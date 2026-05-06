package com.labex.rag.controller;

import com.labex.common.Result;
import com.labex.entity.Lecture;
import com.labex.rag.dto.QueryRequest;
import com.labex.rag.dto.QueryResponse;
import com.labex.rag.dto.SessionDTO;
import com.labex.rag.llm.MiniMaxChat;
import com.labex.rag.memory.SessionMemory;
import com.labex.rag.retrieval.HybridRetriever;
import com.labex.rag.service.RagService;
import com.labex.service.LectureService;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.core.io.ClassPathResource;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.stream.Collectors;

/**
 * RAG Controller - Knowledge Q&A based on lecture content
 */
@Slf4j
@RestController
@RequestMapping("/rag")
public class RagController {

    private final LectureService lectureService;
    private final RagService ragService;
    private final HybridRetriever hybridRetriever;
    private final MiniMaxChat miniMaxChat;
    private final SessionMemory sessionMemory;

    private static final String SYSTEM_PROMPT = loadPrompt();

    private static String loadPrompt() {
        try {
            ClassPathResource resource = new ClassPathResource("prompts/taffy_prompt.txt");
            return new String(resource.getInputStream().readAllBytes(), StandardCharsets.UTF_8);
        } catch (Exception e) {
            log.warn("Failed to load prompt file, using default: {}", e.getMessage());
            return "你是一个智能知识库助手。请根据提供的上下文信息，用中文准确回答用户的问题。\n" +
                   "如果上下文中没有相关信息，请如实告知用户你无法从知识库中找到答案。\n" +
                   "回答要简洁、有条理，并注明答案来源于哪些文档。";
        }
    }

    @Autowired
    public RagController(
            LectureService lectureService,
            @Lazy RagService ragService,
            @Lazy HybridRetriever hybridRetriever,
            @Lazy MiniMaxChat miniMaxChat,
            @Lazy SessionMemory sessionMemory) {
        this.lectureService = lectureService;
        this.ragService = ragService;
        this.hybridRetriever = hybridRetriever;
        this.miniMaxChat = miniMaxChat;
        this.sessionMemory = sessionMemory;
        log.info("RagController initialized successfully");
    }

    /**
     * 获取当前用户ID
     */
    private String getCurrentUserId() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated()) {
            return auth.getName();
        }
        return "anonymous";
    }

    /**
     * 初始化知识库
     * POST /api/rag/init
     */
    @PostMapping("/init")
    public Result<Map<String, Object>> initKnowledgeBase() {
        try {
            log.info("开始初始化知识库...");
            int count = ragService.initializeAllUnvectorized();

            Map<String, Object> result = new HashMap<>();
            result.put("vectorizedCount", count);

            return Result.success(result);
        } catch (Exception e) {
            log.error("初始化知识库失败: {}", e.getMessage());
            return Result.error("初始化失败: " + e.getMessage());
        }
    }

    /**
     * 创建新会话
     * POST /api/rag/session/create
     */
    @PostMapping("/session/create")
    public Result<SessionDTO> createSession(@RequestParam(required = false) String title) {
        try {
            String userId = getCurrentUserId();
            SessionDTO session = sessionMemory.createSession(userId, title);
            if (session != null) {
                return Result.success(session);
            }
            return Result.error("创建会话失败");
        } catch (Exception e) {
            log.error("创建会话失败: {}", e.getMessage());
            return Result.error("创建会话失败: " + e.getMessage());
        }
    }

    /**
     * 获取用户的所有会话
     * GET /api/rag/sessions
     */
    @GetMapping("/sessions")
    public Result<List<SessionDTO>> getUserSessions() {
        try {
            String userId = getCurrentUserId();
            List<SessionDTO> sessions = sessionMemory.getUserSessions(userId);
            return Result.success(sessions);
        } catch (Exception e) {
            log.error("获取会话列表失败: {}", e.getMessage());
            return Result.error("获取会话列表失败: " + e.getMessage());
        }
    }

    /**
     * 获取会话详情
     * GET /api/rag/session/{sessionId}
     */
    @GetMapping("/session/{sessionId}")
    public Result<SessionDTO> getSession(@PathVariable String sessionId) {
        try {
            SessionDTO session = sessionMemory.getSession(sessionId);
            if (session != null) {
                // Verify ownership
                if (!session.getUserId().equals(getCurrentUserId())) {
                    return Result.error("无权访问此会话");
                }
                return Result.success(session);
            }
            return Result.error("会话不存在");
        } catch (Exception e) {
            log.error("获取会话失败: {}", e.getMessage());
            return Result.error("获取会话失败: " + e.getMessage());
        }
    }

    /**
     * 删除会话
     * DELETE /api/rag/session/{sessionId}
     */
    @DeleteMapping("/session/{sessionId}")
    public Result<Void> deleteSession(@PathVariable String sessionId) {
        try {
            String userId = getCurrentUserId();
            sessionMemory.deleteSession(sessionId, userId);
            return Result.success(null);
        } catch (Exception e) {
            log.error("删除会话失败: {}", e.getMessage());
            return Result.error("删除会话失败: " + e.getMessage());
        }
    }

    /**
     * 更新会话标题
     * PUT /api/rag/session/{sessionId}/title
     */
    @PutMapping("/session/{sessionId}/title")
    public Result<Void> updateSessionTitle(
            @PathVariable String sessionId,
            @RequestParam String title) {
        try {
            sessionMemory.updateSessionTitle(sessionId, title);
            return Result.success(null);
        } catch (Exception e) {
            log.error("更新会话标题失败: {}", e.getMessage());
            return Result.error("更新会话标题失败: " + e.getMessage());
        }
    }

    /**
     * 查询知识库
     * POST /api/rag/query
     */
    @PostMapping("/query")
    public Result<QueryResponse> query(@RequestBody QueryRequest request) {
        try {
            String question = request.getQuestion();
            if (question == null || question.isBlank()) {
                return Result.error("问题不能为空");
            }

            String sessionId = request.getSessionId();
            String userId = getCurrentUserId();

            // 如果没有sessionId，创建一个新会话
            if (sessionId == null || sessionId.isBlank()) {
                SessionDTO newSession = sessionMemory.createSession(userId, "新会话");
                if (newSession != null) {
                    sessionId = newSession.getSessionId();
                }
            } else {
                // 验证session属于当前用户
                SessionDTO session = sessionMemory.getSession(sessionId);
                if (session != null && !session.getUserId().equals(userId)) {
                    return Result.error("无权访问此会话");
                }
            }

            // 搜索相关文本块
            List<Map<String, Object>> searchResults = hybridRetriever.search(question, 5);

            if (searchResults.isEmpty()) {
                // 知识库无相关内容，让 LLM 用自己的知识回答
                String noContextPrompt = "知识库中没有找到与问题相关的内容。如果你知道这个问题的答案，请直接回答，但需要在回答开头用「塔菲知识小贴士」标注这部分内容是AI自身知识，不是来自讲义知识库喵~\n\n" +
                        "同时请加一句提示：塔菲的知识可能不够全面，建议你再查查其他资料确认一下喵~";
                String answer = miniMaxChat.chat(noContextPrompt, "", question);

                QueryResponse response = new QueryResponse();
                response.setAnswer(answer);
                response.setSources(new ArrayList<>());
                response.setSessionId(sessionId);
                response.setFromKnowledgeBase(false);

                // 保存会话历史
                sessionMemory.addMessage(sessionId, "user", question);
                sessionMemory.addMessage(sessionId, "assistant", answer);

                return Result.success(response);
            }

            // 构建上下文和来源（包含讲义ID用于跳转）
            StringBuilder contextBuilder = new StringBuilder();
            List<Map<String, Object>> sources = new ArrayList<>();

            for (Map<String, Object> result : searchResults) {
                String text = (String) result.get("text");
                String docId = (String) result.get("documentId");
                Integer lectureId = (Integer) result.get("lectureId");
                String lectureName = (String) result.get("lectureName");

                contextBuilder.append(text).append("\n\n");

                Map<String, Object> source = new HashMap<>();
                source.put("text", text.length() > 200 ? text.substring(0, 200) + "..." : text);
                source.put("documentId", docId != null ? docId : "");
                source.put("lectureId", lectureId);
                source.put("lectureName", lectureName);
                source.put("score", result.getOrDefault("finalScore", 0.0));
                sources.add(source);
            }

            String context = contextBuilder.toString();

            // 生成答案
            String answer = miniMaxChat.chat(SYSTEM_PROMPT, context, question);

            // 将sources转为JSON字符串保存
            String sourcesJson = new Gson().toJson(sources);

            // 保存会话历史
            sessionMemory.addMessage(sessionId, "user", question);
            sessionMemory.addMessage(sessionId, "assistant", answer, sourcesJson);

            QueryResponse response = new QueryResponse();
            response.setAnswer(answer);
            response.setSources(sources);
            response.setSessionId(sessionId);
            response.setFromKnowledgeBase(true);

            return Result.success(response);
        } catch (Exception e) {
            log.error("查询失败: {}", e.getMessage());
            return Result.error("查询失败: " + e.getMessage());
        }
    }

    /**
     * 获取会话历史
     * GET /api/rag/history/{sessionId}
     */
    @GetMapping("/history/{sessionId}")
    public Result<List<Map<String, Object>>> getHistory(@PathVariable String sessionId) {
        try {
            // Verify ownership
            SessionDTO session = sessionMemory.getSession(sessionId);
            if (session != null && !session.getUserId().equals(getCurrentUserId())) {
                return Result.error("无权访问此会话");
            }

            List<Map<String, Object>> history = sessionMemory.getHistory(sessionId, 200);
            return Result.success(history);
        } catch (Exception e) {
            log.error("获取历史失败: {}", e.getMessage());
            return Result.error("获取历史失败: " + e.getMessage());
        }
    }

    /**
     * 获取已向量化的文档列表
     * GET /api/rag/documents
     */
    @GetMapping("/documents")
    public Result<List<Map<String, Object>>> listDocuments() {
        try {
            List<Lecture> lectures = lectureService.list();

            List<Map<String, Object>> documents = lectures.stream()
                    .filter(l -> l.getVectorized() != null && l.getVectorized() == 1)
                    .map(lecture -> {
                        Map<String, Object> doc = new HashMap<>();
                        doc.put("id", lecture.getDocumentId());
                        doc.put("lectureId", lecture.getLectureId());
                        doc.put("lectureName", lecture.getLectureName());
                        doc.put("lectureType", lecture.getLectureType());
                        doc.put("vectorized", lecture.getVectorized());
                        return doc;
                    })
                    .collect(Collectors.toList());

            return Result.success(documents);
        } catch (Exception e) {
            log.error("获取文档列表失败: {}", e.getMessage());
            return Result.error("获取文档列表失败: " + e.getMessage());
        }
    }

    /**
     * 获取讲义内容（用于RAG知识库预览，不校验教师归属）
     * GET /api/rag/lecture/{id}
     */
    @GetMapping("/lecture/{id}")
    public Result<Lecture> getLecture(@PathVariable Integer id) {
        try {
            Lecture lecture = lectureService.getById(id);
            if (lecture == null) {
                return Result.error("讲义不存在");
            }
            return Result.success(lecture);
        } catch (Exception e) {
            log.error("获取讲义失败: {}", e.getMessage());
            return Result.error("获取讲义失败: " + e.getMessage());
        }
    }

    /**
     * 获取知识库状态
     * GET /api/rag/status
     */
    @GetMapping("/status")
    public Result<Map<String, Object>> getStatus() {
        try {
            List<Lecture> allLectures = lectureService.list();
            long totalLectures = allLectures.size();
            long vectorizedCount = allLectures.stream()
                    .filter(l -> l.getVectorized() != null && l.getVectorized() == 1)
                    .count();
            long pendingCount = allLectures.stream()
                    .filter(l -> l.getVectorized() == null || l.getVectorized() == 0)
                    .count();
            long failedCount = allLectures.stream()
                    .filter(l -> l.getVectorized() != null && l.getVectorized() == 2)
                    .count();

            Map<String, Object> status = new HashMap<>();
            status.put("totalLectures", totalLectures);
            status.put("vectorizedCount", vectorizedCount);
            status.put("pendingCount", pendingCount);
            status.put("failedCount", failedCount);
            status.put("ready", vectorizedCount > 0);

            return Result.success(status);
        } catch (Exception e) {
            log.error("获取状态失败: {}", e.getMessage());
            return Result.error("获取状态失败: " + e.getMessage());
        }
    }
}