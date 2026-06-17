package com.labex.rag.controller;

import com.labex.common.Result;
import com.labex.entity.Lecture;
import com.labex.rag.dto.QueryRequest;
import com.labex.rag.dto.QueryResponse;
import com.labex.rag.dto.SessionDTO;
import com.labex.rag.llm.MiniMaxChat;
import com.labex.rag.memory.SessionMemory;
import com.labex.rag.retrieval.HybridRetriever;
import com.labex.rag.service.ImageUnderstandingService;
import com.labex.rag.service.RagQueryMetricService;
import com.labex.rag.service.RagService;
import com.labex.rag.service.WebSearchService;
import com.labex.service.LectureService;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.core.io.ClassPathResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.util.*;
import java.util.concurrent.CompletableFuture;
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
    private final WebSearchService webSearchService;
    private final ImageUnderstandingService imageUnderstandingService;
    private final RagQueryMetricService metricService;

    private static final String SYSTEM_PROMPT = loadPrompt();
    private static final Gson GSON = new Gson();
    private static final int KNOWLEDGE_TOP_K = 5;
    private static final int WEB_TOP_K = 8;
    private static final int MAX_CONTEXT_CHARS = 26000;

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
            @Lazy SessionMemory sessionMemory,
            @Lazy WebSearchService webSearchService,
            @Lazy ImageUnderstandingService imageUnderstandingService,
            @Lazy RagQueryMetricService metricService) {
        this.lectureService = lectureService;
        this.ragService = ragService;
        this.hybridRetriever = hybridRetriever;
        this.miniMaxChat = miniMaxChat;
        this.sessionMemory = sessionMemory;
        this.webSearchService = webSearchService;
        this.imageUnderstandingService = imageUnderstandingService;
        this.metricService = metricService;
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
    public Result<QueryResponse> queryEnhanced(@RequestBody QueryRequest request) {
        long startedAt = System.currentTimeMillis();
        try {
            String question = request.getQuestion();
            List<Map<String, Object>> attachments = sanitizeAttachments(request.getAttachments());
            if ((question == null || question.isBlank()) && attachments.isEmpty()) {
                return Result.error("问题不能为空");
            }
            if (question == null) {
                question = "";
            }

            String sessionId = request.getSessionId();
            String userId = getCurrentUserId();
            String retrievalMode = normalizeRetrievalMode(request.getRetrievalMode());
            boolean deepThinking = Boolean.TRUE.equals(request.getDeepThinking());

            if (sessionId == null || sessionId.isBlank()) {
                SessionDTO newSession = sessionMemory.createSession(userId, "新会话");
                if (newSession != null) {
                    sessionId = newSession.getSessionId();
                }
            } else {
                SessionDTO session = sessionMemory.getSession(sessionId);
                if (session != null && !session.getUserId().equals(userId)) {
                    return Result.error("无权访问此会话");
                }
            }

            List<Map<String, Object>> knowledgeSources = new ArrayList<>();
            List<Map<String, Object>> webSources = new ArrayList<>();
            List<Map<String, Object>> imageSources = new ArrayList<>();
            List<String> searchKeywords = new ArrayList<>();

            if (!attachments.isEmpty()) {
                imageSources = imageUnderstandingService.analyzeAttachments(question, attachments);
            }

            RetrievalPlan retrievalPlan = buildRetrievalPlan(question, retrievalMode, deepThinking, imageSources);
            if (retrievalPlan.useKnowledge() && !retrievalPlan.query().isBlank()) {
                knowledgeSources = buildKnowledgeSources(hybridRetriever.search(retrievalPlan.query(), retrievalPlan.knowledgeTopK()));
            }
            if (retrievalPlan.useWeb() && !retrievalPlan.query().isBlank()) {
                SearchPlan searchPlan = buildWebSearchPlan(question, retrievalPlan, imageSources);
                WebSearchService.SearchBundle webSearch = webSearchService.search(
                        searchPlan.query(),
                        searchPlan.webTopK(),
                        searchPlan.webFetchTopK(),
                        searchPlan.keywords()
                );
                searchKeywords = webSearch.getKeywords();
                webSources = buildWebSources(webSearch.getResults());
            }

            List<Map<String, Object>> sources = new ArrayList<>();
            sources.addAll(imageSources);
            sources.addAll(knowledgeSources);
            sources.addAll(webSources);
            sources = orderSources(sources);
            sources = orderSources(sources);

            String context = buildContext(sources, attachments);
            String prompt = buildAnswerPrompt(retrievalMode, deepThinking, sources.isEmpty(), attachments, retrievalPlan, hasFetchedWebContent(webSources));
            String answer = miniMaxChat.chat(prompt, context, buildQuestionWithAttachments(question, attachments));
            String thinkingTrace = deepThinking
                    ? buildThinkingTrace(question, retrievalMode, searchKeywords, knowledgeSources, webSources, imageSources, sources.isEmpty(), attachments, retrievalPlan)
                    : null;

            sessionMemory.addMessage(
                    sessionId,
                    "user",
                    question,
                    null,
                    null,
                    null,
                    null,
                    GSON.toJson(attachments)
            );
            sessionMemory.addMessage(
                    sessionId,
                    "assistant",
                    answer,
                    GSON.toJson(sources),
                    retrievalMode,
                    GSON.toJson(searchKeywords),
                    thinkingTrace
            );

            QueryResponse response = new QueryResponse();
            response.setAnswer(answer);
            response.setSources(sources);
            response.setSessionId(sessionId);
            response.setFromKnowledgeBase(!sources.isEmpty());
            response.setRetrievalMode(retrievalMode);
            response.setSearchKeywords(searchKeywords);
            response.setThinkingTrace(thinkingTrace);
            response.setAttachments(new ArrayList<>());

            metricService.record(
                    sessionId,
                    userId,
                    retrievalMode,
                    deepThinking,
                    question,
                    retrievalPlan.query(),
                    sources,
                    System.currentTimeMillis() - startedAt);

            return Result.success(response);
        } catch (Exception e) {
            log.error("查询失败: {}", e.getMessage(), e);
            return Result.error("查询失败: " + e.getMessage());
        }
    }

    @PostMapping(value = "/query-stream", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    public ResponseEntity<SseEmitter> queryStream(@RequestBody QueryRequest request) {
        String userId = getCurrentUserId();
        SseEmitter emitter = new SseEmitter(0L);
        CompletableFuture.runAsync(() -> runQueryStream(request, userId, emitter));
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.TEXT_EVENT_STREAM);
        headers.setCacheControl("no-cache, no-transform");
        headers.set("X-Accel-Buffering", "no");
        headers.set("Connection", "keep-alive");
        return ResponseEntity.ok().headers(headers).body(emitter);
    }

    private void runQueryStream(QueryRequest request, String userId, SseEmitter emitter) {
        long startedAt = System.currentTimeMillis();
        String question = request.getQuestion();
        String sessionId = request.getSessionId();
        String retrievalMode = normalizeRetrievalMode(request.getRetrievalMode());
        boolean deepThinking = Boolean.TRUE.equals(request.getDeepThinking());
        List<Map<String, Object>> attachments = sanitizeAttachments(request.getAttachments());

        try {
            sendStreamEvent(emitter, "status", Map.of("text", "已连接流式接口，正在准备请求"));
            sendStreamPadding(emitter);
            if ((question == null || question.isBlank()) && attachments.isEmpty()) {
                sendStreamEvent(emitter, "error", Map.of("message", "问题不能为空"));
                emitter.complete();
                return;
            }
            if (question == null) {
                question = "";
            }

            sendStreamEvent(emitter, "status", Map.of("text", "正在准备会话和请求上下文"));
            if (sessionId == null || sessionId.isBlank()) {
                SessionDTO newSession = sessionMemory.createSession(userId, "新会话");
                if (newSession != null) {
                    sessionId = newSession.getSessionId();
                }
            } else {
                SessionDTO session = sessionMemory.getSession(sessionId);
                if (session != null && !session.getUserId().equals(userId)) {
                    sendStreamEvent(emitter, "error", Map.of("message", "无权访问此会话"));
                    emitter.complete();
                    return;
                }
            }
            sendStreamEvent(emitter, "session", Map.of("sessionId", Objects.toString(sessionId, "")));
            sendThinkingEvent(emitter, deepThinking, "解析问题", "我正在读取用户输入、附件和检索模式，准备把可用信息合并成一个更准确的检索意图。");

            // ========== 收集所有来源（边搜边推给前端） ==========
            List<Map<String, Object>> sources = new ArrayList<>();
            List<String> searchKeywords = new ArrayList<>();

            // 图片理解
            List<Map<String, Object>> imageSources = new ArrayList<>();
            if (!attachments.isEmpty()) {
                sendStreamEvent(emitter, "status", Map.of("text", "正在调用 understand_image 读取图片内容"));
                imageSources = imageUnderstandingService.analyzeAttachments(question, attachments);
                sources.addAll(imageSources);
                for (Map<String, Object> src : imageSources) {
                    sendStreamEvent(emitter, "source_found", src);
                }
                long successCount = imageSources.stream().filter(source -> Boolean.TRUE.equals(source.get("success"))).count();
                sendThinkingEvent(emitter, deepThinking, "调用图片理解工具", "已读取 " + attachments.size() + " 张图片，成功获得 " + successCount + " 条图片分析结果。");
            }

            RetrievalPlan retrievalPlan = buildRetrievalPlan(question, retrievalMode, deepThinking, imageSources);

            // ========== 并行检索：知识库 + 联网搜索，每搜到一个就推给前端 ==========
            CompletableFuture<List<Map<String, Object>>> knowledgeFuture;
            CompletableFuture<WebSearchService.SearchBundle> webFuture;

            if (retrievalPlan.useKnowledge() && !retrievalPlan.query().isBlank()) {
                sendStreamEvent(emitter, "status", Map.of("text", "正在检索知识库..."));
                knowledgeFuture = CompletableFuture.supplyAsync(() -> {
                    try {
                        List<Map<String, Object>> results = buildKnowledgeSources(hybridRetriever.search(retrievalPlan.query(), retrievalPlan.knowledgeTopK()));
                        // 搜到后立刻逐条推给前端
                        for (Map<String, Object> src : results) {
                            sendStreamEvent(emitter, "source_found", src);
                        }
                        return results;
                    } catch (Exception e) {
                        log.warn("知识库检索失败: {}", e.getMessage());
                        return new ArrayList<Map<String, Object>>();
                    }
                });
            } else {
                knowledgeFuture = CompletableFuture.completedFuture(new ArrayList<>());
            }

            if (retrievalPlan.useWeb() && !retrievalPlan.query().isBlank()) {
                sendStreamEvent(emitter, "status", Map.of("text", "正在联网搜索..."));
                SearchPlan streamSearchPlan = buildWebSearchPlan(question, retrievalPlan, imageSources);
                String webQuery = streamSearchPlan.query();
                List<String> keywords = streamSearchPlan.keywords();
                webFuture = CompletableFuture.supplyAsync(() -> {
                    try {
                        WebSearchService.SearchBundle bundle = webSearchService.search(
                                webQuery,
                                streamSearchPlan.webTopK(),
                                streamSearchPlan.webFetchTopK(),
                                keywords);
                        List<Map<String, Object>> webResults = buildWebSources(bundle.getResults());
                        // 搜到后立刻逐条推给前端
                        for (Map<String, Object> src : webResults) {
                            sendStreamEvent(emitter, "source_found", src);
                        }
                        return bundle;
                    } catch (Exception e) {
                        log.warn("联网搜索失败: {}", e.getMessage());
                        return new WebSearchService.SearchBundle(keywords, List.of(), new ArrayList<>());
                    }
                });
            } else {
                webFuture = CompletableFuture.completedFuture(new WebSearchService.SearchBundle(List.of(), List.of(), new ArrayList<>()));
            }

            // 等待并行任务完成
            CompletableFuture.allOf(knowledgeFuture, webFuture).join();

            List<Map<String, Object>> knowledgeSources = knowledgeFuture.get();
            WebSearchService.SearchBundle webBundle = webFuture.get();
            List<Map<String, Object>> webSources = buildWebSources(webBundle.getResults());
            searchKeywords = webBundle.getKeywords();

            sources.addAll(knowledgeSources);
            sources.addAll(webSources);

            // 所有搜索完成，发送汇总 metadata
            sendStreamEvent(emitter, "metadata", buildStreamMetadata(sessionId, retrievalMode, searchKeywords, sources));
            String context = buildContext(sources, attachments);
            String prompt = buildAnswerPrompt(retrievalMode, deepThinking, sources.isEmpty(), attachments, retrievalPlan, hasFetchedWebContent(webSources));
            String thinkingTrace = deepThinking
                    ? buildThinkingTrace(question, retrievalMode, searchKeywords, knowledgeSources, webSources, imageSources, sources.isEmpty(), attachments, retrievalPlan)
                    : null;

            sendStreamEvent(emitter, "status", Map.of("text", "正在流式生成最终回答"));

            StringBuilder answerBuilder = new StringBuilder();
            StringBuilder modelThinkingBuilder = new StringBuilder();
            String finalQuestion = question;
            miniMaxChat.chatStream(prompt, context, buildQuestionWithAttachments(finalQuestion, attachments), deepThinking, chunk -> {
                if ("thinking_delta".equals(chunk.type())) {
                    // 转发模型的真实思考过程
                    modelThinkingBuilder.append(chunk.content());
                    if (deepThinking) {
                        sendStreamEvent(emitter, "thinking_delta", Map.of("text", chunk.content() == null ? "" : chunk.content()));
                    }
                } else if ("text_delta".equals(chunk.type())) {
                    answerBuilder.append(chunk.content());
                    sendAnswerDelta(emitter, chunk.content());
                } else if ("error".equals(chunk.type())) {
                    sendStreamEvent(emitter, "error", Map.of("message", chunk.content()));
                }
            });

            String answer = answerBuilder.toString();
            if (answer.isBlank()) {
                answer = "抱歉，模型没有返回可用内容。";
            }

            // 使用模型的真实思考内容（如果有的话），否则使用手动构建的
            String finalThinkingTrace = modelThinkingBuilder.length() > 0
                    ? modelThinkingBuilder.toString()
                    : thinkingTrace;

            sessionMemory.addMessage(sessionId, "user", finalQuestion, null, null, null, null, GSON.toJson(attachments));
            sessionMemory.addMessage(sessionId, "assistant", answer, GSON.toJson(sources), retrievalMode, GSON.toJson(searchKeywords), finalThinkingTrace);

            QueryResponse response = new QueryResponse();
            response.setAnswer(answer);
            response.setSources(sources);
            response.setSessionId(sessionId);
            response.setFromKnowledgeBase(!sources.isEmpty());
            response.setRetrievalMode(retrievalMode);
            response.setSearchKeywords(searchKeywords);
            response.setThinkingTrace(finalThinkingTrace);
            response.setAttachments(new ArrayList<>());
            metricService.record(
                    sessionId,
                    userId,
                    retrievalMode,
                    deepThinking,
                    finalQuestion,
                    retrievalPlan.query(),
                    sources,
                    System.currentTimeMillis() - startedAt);
            sendStreamEvent(emitter, "done", response);
            emitter.complete();
        } catch (Exception e) {
            log.error("流式查询失败: {}", e.getMessage(), e);
            sendStreamEvent(emitter, "error", Map.of("message", "流式查询失败: " + e.getMessage()));
            emitter.complete();
        }
    }

    private Map<String, Object> buildStreamMetadata(
            String sessionId,
            String retrievalMode,
            List<String> searchKeywords,
            List<Map<String, Object>> sources) {
        Map<String, Object> metadata = new HashMap<>();
        metadata.put("sessionId", sessionId);
        metadata.put("retrievalMode", retrievalMode);
        metadata.put("searchKeywords", searchKeywords);
        metadata.put("sources", sources);
        metadata.put("fromKnowledgeBase", !sources.isEmpty());
        return metadata;
    }

    private void sendThinkingEvent(SseEmitter emitter, boolean enabled, String title, String body) {
        if (!enabled) {
            return;
        }
        sendStreamEvent(emitter, "thinking_delta", Map.of("text", title + "\n" + body + "\n"));
    }

    private void sendAnswerDelta(SseEmitter emitter, String content) {
        if (content == null || content.isEmpty()) {
            return;
        }
        int chunkSize = 64;
        for (int i = 0; i < content.length(); i += chunkSize) {
            String part = content.substring(i, Math.min(i + chunkSize, content.length()));
            sendStreamEvent(emitter, "answer_delta", Map.of("text", part));
        }
    }

    private void sendStreamEvent(SseEmitter emitter, String type, Object data) {
        try {
            synchronized (emitter) {
                emitter.send(SseEmitter.event().name(type).data(GSON.toJson(data)));
            }
        } catch (IOException e) {
            log.debug("SSE send failed: {}", e.getMessage());
        }
    }

    private void sendStreamPadding(SseEmitter emitter) {
        sendStreamEvent(emitter, "ping", Map.of("padding", " ".repeat(2048)));
    }

    private String normalizeRetrievalMode(String mode) {
        if (mode == null || mode.isBlank()) {
            return "knowledge";
        }
        String normalized = mode.trim().toLowerCase(Locale.ROOT).replace("-", "_");
        if (Set.of("web", "web_search", "web_seach", "online", "internet", "联网搜索").contains(normalized)) {
            return "web";
        }
        if (Set.of("hybrid", "mixed", "mix", "混合检索").contains(normalized)) {
            return "hybrid";
        }
        return "knowledge";
    }

    private boolean usesKnowledge(String retrievalMode) {
        return "knowledge".equals(retrievalMode) || "hybrid".equals(retrievalMode);
    }

    private boolean usesWeb(String retrievalMode) {
        return "web".equals(retrievalMode) || "hybrid".equals(retrievalMode);
    }

    private List<Map<String, Object>> buildKnowledgeSources(List<Map<String, Object>> searchResults) {
        List<Map<String, Object>> sources = new ArrayList<>();
        for (Map<String, Object> result : searchResults) {
            String text = Objects.toString(result.get("text"), "");
            String docId = Objects.toString(result.get("documentId"), "");
            String lectureName = Objects.toString(result.get("lectureName"), "未知讲义");

            Map<String, Object> source = new HashMap<>();
            source.put("type", "knowledge");
            source.put("title", lectureName);
            source.put("text", truncate(text, 1500));
            source.put("snippet", truncate(text, 520));
            source.put("documentId", docId);
            source.put("lectureId", result.get("lectureId"));
            source.put("lectureName", lectureName);
            source.put("lectureType", result.get("lectureType"));
            source.put("matchTerms", result.getOrDefault("matchTerms", new ArrayList<>()));
            source.put("vectorScore", result.getOrDefault("vectorScore", result.getOrDefault("score", 0.0)));
            source.put("score", result.getOrDefault("finalScore", 0.0));
            sources.add(source);
        }
        return sources;
    }

    private List<Map<String, Object>> buildWebSources(List<WebSearchService.WebSearchResult> webResults) {
        List<Map<String, Object>> sources = new ArrayList<>();
        for (WebSearchService.WebSearchResult result : webResults) {
            String content = Objects.toString(result.getContent(), "");
            String snippet = Objects.toString(result.getSnippet(), "");
            String readableText = content.isBlank()
                    ? "Search snippet only. Page body was not fetched; use as a discovery clue, not verified evidence.\n" + snippet
                    : (snippet.isBlank() ? content : snippet + "\n\n网页正文摘录：\n" + content);
            Map<String, Object> source = new HashMap<>();
            source.put("type", "web");
            source.put("title", result.getTitle());
            source.put("url", result.getUrl());
            source.put("snippet", truncate(firstNonBlank(snippet, content), 620));
            source.put("text", truncate(readableText, 2400));
            source.put("engine", result.getEngine());
            source.put("fallback", result.isFallback());
            source.put("contentFetched", !content.isBlank());
            source.put("exactMatch", result.isExactMatch());
            source.put("publishedAt", result.getPublishedAt());
            source.put("fetchedAt", result.getFetchedAt());
            source.put("host", host(result.getUrl()));
            source.put("evidenceLevel", evidenceLevel(result, !content.isBlank()));
            source.put("sourceQuality", sourceQuality(host(result.getUrl()), !content.isBlank()));
            sources.add(source);
        }
        return sources;
    }

    private List<Map<String, Object>> orderSources(List<Map<String, Object>> sources) {
        if (sources == null || sources.size() <= 1) {
            return sources == null ? new ArrayList<>() : sources;
        }
        List<Map<String, Object>> ordered = new ArrayList<>(sources);
        ordered.sort((left, right) -> Double.compare(sourceRank(right), sourceRank(left)));
        return ordered;
    }

    private double sourceRank(Map<String, Object> source) {
        String type = Objects.toString(source.get("type"), "knowledge");
        double rank = switch (type) {
            case "image" -> 1.35;
            case "web" -> 0.55;
            default -> 0.75;
        };
        rank += getNumber(source.get("score")) * 0.35;
        rank += getNumber(source.get("vectorScore")) * 0.10;
        if (Boolean.TRUE.equals(source.get("contentFetched"))) {
            rank += 0.28;
        }
        if (Boolean.TRUE.equals(source.get("exactMatch"))) {
            rank += 0.18;
        }
        String evidence = Objects.toString(source.get("evidenceLevel"), "");
        if (evidence.contains("verified_exact")) {
            rank += 0.22;
        } else if (evidence.contains("verified")) {
            rank += 0.14;
        } else if (evidence.contains("snippet")) {
            rank -= 0.08;
        } else if (evidence.contains("fallback")) {
            rank -= 0.55;
        }
        String quality = Objects.toString(source.get("sourceQuality"), "");
        if (quality.contains("primary_or_docs_verified")) {
            rank += 0.18;
        } else if (quality.contains("primary_or_docs")) {
            rank += 0.08;
        } else if (quality.contains("secondary_snippet")) {
            rank -= 0.04;
        }
        return rank;
    }

    private boolean hasFetchedWebContent(List<Map<String, Object>> webSources) {
        return webSources != null && webSources.stream()
                .anyMatch(source -> Boolean.TRUE.equals(source.get("contentFetched")));
    }

    private double getNumber(Object value) {
        return value instanceof Number number ? number.doubleValue() : 0.0;
    }

    private String evidenceLevel(WebSearchService.WebSearchResult result, boolean contentFetched) {
        if (result.isFallback()) {
            return "fallback_search_page";
        }
        if (contentFetched) {
            return result.isExactMatch() ? "verified_exact_page_body" : "verified_page_body";
        }
        return result.isExactMatch() ? "search_snippet_exact" : "search_snippet_only";
    }

    private String sourceQuality(String host, boolean contentFetched) {
        if (host == null || host.isBlank()) {
            return contentFetched ? "body_fetched" : "snippet_only";
        }
        String normalized = host.toLowerCase(Locale.ROOT);
        boolean primaryLike = normalized.endsWith(".gov")
                || normalized.endsWith(".edu")
                || normalized.contains("docs.")
                || normalized.contains("developer.")
                || normalized.contains("learn.microsoft.com")
                || normalized.contains("openai.com")
                || normalized.contains("anthropic.com")
                || normalized.contains("cloud.google.com")
                || normalized.contains("github.com");
        if (primaryLike && contentFetched) {
            return "primary_or_docs_verified";
        }
        if (primaryLike) {
            return "primary_or_docs_snippet";
        }
        return contentFetched ? "secondary_verified" : "secondary_snippet";
    }

    private String buildContext(List<Map<String, Object>> sources, List<Map<String, Object>> attachments) {
        StringBuilder contextBuilder = new StringBuilder();
        if (!attachments.isEmpty()) {
            contextBuilder.append("User attachments:\n");
            for (int i = 0; i < attachments.size(); i++) {
                Map<String, Object> attachment = attachments.get(i);
                contextBuilder.append("[Image ")
                        .append(i + 1)
                        .append("] ")
                        .append(Objects.toString(attachment.get("name"), "image"))
                        .append(", type=")
                        .append(Objects.toString(attachment.get("mimeType"), "image"))
                        .append(", size=")
                        .append(Objects.toString(attachment.get("size"), "unknown"))
                        .append("\n");
            }
            contextBuilder.append("\n");
        }
        if (sources.isEmpty()) {
            return contextBuilder.toString();
        }
        for (int i = 0; i < sources.size(); i++) {
            Map<String, Object> source = sources.get(i);
            String type = Objects.toString(source.get("type"), "knowledge");
            String title = Objects.toString(source.get("title"), Objects.toString(source.get("lectureName"), "参考资料"));
            String text = Objects.toString(source.get("text"), Objects.toString(source.get("snippet"), ""));
            contextBuilder.append("[")
                    .append(i + 1)
                    .append("][")
                    .append(formatSourceTypeLabel(type))
                    .append("] ")
                    .append(title)
                    .append("\n");
            if ("web".equals(type)) {
                contextBuilder.append("URL: ")
                        .append(Objects.toString(source.get("url"), ""))
                        .append("\nContentFetched: ")
                        .append(Boolean.TRUE.equals(source.get("contentFetched")) ? "true" : "false")
                        .append("\nExactEntityMatch: ")
                        .append(Boolean.TRUE.equals(source.get("exactMatch")) ? "true" : "false")
                        .append("\nEvidenceLevel: ")
                        .append(Objects.toString(source.get("evidenceLevel"), "unknown"))
                        .append("\nSourceQuality: ")
                        .append(Objects.toString(source.get("sourceQuality"), "unknown"))
                        .append("\nPublishedAt: ")
                        .append(Objects.toString(source.get("publishedAt"), ""))
                        .append("\nFetchedAt: ")
                        .append(Objects.toString(source.get("fetchedAt"), ""))
                        .append("\n");
            }
            if ("image".equals(type)) {
                contextBuilder.append("Tool: ")
                        .append(Objects.toString(source.get("tool"), "understand_image"))
                        .append("\nStatus: ")
                        .append(Boolean.TRUE.equals(source.get("success")) ? "success" : "failed")
                        .append("\n");
            }
            contextBuilder.append(text).append("\n\n");
            if (contextBuilder.length() >= MAX_CONTEXT_CHARS) {
                contextBuilder.append("[Context truncated because enough reference material has been collected.]\n");
                break;
            }
        }
        return contextBuilder.toString();
    }

    private String buildAnswerPrompt(
            String retrievalMode,
            boolean deepThinking,
            boolean noSources,
            List<Map<String, Object>> attachments,
            RetrievalPlan retrievalPlan,
            boolean hasFetchedWebContent) {
        StringBuilder prompt = new StringBuilder(SYSTEM_PROMPT);
        prompt.append("\n\nCurrent date: ").append(LocalDate.now()).append(".");
        prompt.append("\n\n请基于 Context 中的参考资料回答用户问题。Context 可能包含知识库讲义片段、联网搜索摘要，以及 understand_image 工具返回的图片理解结果。");
        prompt.append("回答时优先使用参考资料，必要时说明信息不足或需要进一步确认。不要编造不存在的链接、文档或事实。");
        prompt.append("\n本轮智能检索查询为：").append(retrievalPlan.query()).append("。");
        prompt.append("\n输出风格要求：");
        prompt.append("\n- 使用清晰、漂亮、可执行的 Markdown。");
        prompt.append("\n- 默认输出更完整：除非用户明确要求简短，教学/解释/图片解读类问题请给出 800-1400 字左右的充分回答。");
        prompt.append("\n- 先给一个简短结论，再按“识别到的信息 / 关键依据 / 展开解释 / 可执行建议或下一步”组织。");
        prompt.append("\n- 适合对比的问题优先使用表格；适合流程的问题使用编号步骤；适合教学的问题补充记忆点、易错点和小练习。");
        prompt.append("\n- 每段控制在 2-4 句，段落之间留出清晰层次，避免大段墙文字。");
        prompt.append("\n- 对来自图片、知识库、网页正文的内容分别说明依据类型，必要时标注信息不足。");
        prompt.append("\n- 如有风险、限制、时效性或不确定性，请单独列出“注意事项”。");
        prompt.append("\nAnswer design rules: make the output visually structured and useful. Prefer short titled sections, tables for comparisons, numbered steps for procedures, and a final actionable summary when appropriate.");
        prompt.append("\nPersonalization rule: adapt the explanation to the user's apparent intent. For learning questions, teach progressively; for troubleshooting, give diagnosis and fixes; for comparisons, give ranking criteria and trade-offs.");
        prompt.append("\nExact entity rule: preserve the exact entity/version/name from the user request. Do not silently replace it with a nearby version. If sources only discuss a different version, state that explicitly.");
        prompt.append("\nFreshness rule: for latest/current/recent questions, prefer dated fetched web page excerpts. If no fetched source is recent or exact, say the search did not verify the claim instead of filling the gap from memory.");
        prompt.append("\nCitation rule: when using retrieved context, cite source numbers from Context like [1], [2]. For web claims, cite only sources whose ContentFetched=true unless explicitly describing them as unverified snippets.");
        if (noSources) {
            prompt.append("\n本次没有检索到可用参考资料，请明确提示用户当前回答缺少外部依据。");
        }
        if (!attachments.isEmpty()) {
            prompt.append("\n用户上传了图片附件。图片内容已优先通过 understand_image 工具转换为文本分析；请把这些工具结果作为图片依据。若工具结果显示失败，请说明失败原因并请用户补充更清晰图片或文字描述。");
        }
        if (usesWeb(retrievalMode)) {
            prompt.append("\nWeb evidence rule: only web sources marked contentFetched=true, or sources that include a 'web page excerpt', may be used as verified web evidence.");
            prompt.append(" Search snippets without fetched page content are discovery clues only and must not be treated as factual proof.");
            prompt.append(" Sources marked ExactEntityMatch=false must not be used as proof for the requested exact version/name; use them only to explain that search results appear to discuss a different entity.");
            if (!hasFetchedWebContent) {
                prompt.append(" No web page body was successfully fetched in this request, so explicitly state that web verification is limited and do not claim the answer is verified by web content.");
            }
        }
        if (deepThinking) {
            prompt.append("\n请在内部进行更充分的分析和交叉核对，但最终答案只输出结论、依据和必要提醒，不输出隐藏思维链。");
        }
        prompt.append("\n当前检索模式：").append(formatModeLabel(retrievalMode)).append("。");
        return prompt.toString();
    }

    private String buildThinkingTrace(
            String question,
            String retrievalMode,
            List<String> searchKeywords,
            List<Map<String, Object>> knowledgeSources,
            List<Map<String, Object>> webSources,
            List<Map<String, Object>> imageSources,
            boolean noSources,
            List<Map<String, Object>> attachments,
            RetrievalPlan retrievalPlan) {
        List<String> lines = new ArrayList<>();
        lines.add("解析问题\n我先把用户问题拆成核心目标、约束条件和需要确认的信息，避免直接给出未经核对的结论。\n本次问题聚焦：" + truncate(question, 90) + "。");
        lines.add("制定检索策略\n我选择使用" + formatModeLabel(retrievalMode) + "，并把用户输入、图片理解结果和关键术语合并成新的检索查询。\n智能检索查询是：" + truncate(retrievalPlan.query(), 140) + "，知识库计划读取 " + retrievalPlan.knowledgeTopK() + " 条，网页计划搜索 " + retrievalPlan.webTopK() + " 条并读取前 " + retrievalPlan.webFetchTopK() + " 条正文。");
        if (!knowledgeSources.isEmpty()) {
            lines.add("检索知识库\n我从知识库中命中 " + knowledgeSources.size() + " 条讲义片段，优先挑选标题、片段内容和问题语义更接近的资料。\n这些资料会作为回答中的课程依据。");
        }
        if (!webSources.isEmpty()) {
            String keywordText = searchKeywords.isEmpty() ? "原始问题" : String.join("、", searchKeywords);
            long fetchedCount = webSources.stream().filter(source -> Boolean.TRUE.equals(source.get("contentFetched"))).count();
            lines.add("联网搜索核对\n我使用关键词" + keywordText + "进行网页搜索，获得 " + webSources.size() + " 条网页参考，并读取了其中 " + fetchedCount + " 条网页正文摘录。\n接下来会优先保留标题清楚、摘要直接、正文可验证且可点击访问的来源。");
        }
        if (!attachments.isEmpty()) {
            long successCount = imageSources.stream().filter(source -> Boolean.TRUE.equals(source.get("success"))).count();
            lines.add("调用图片理解工具\n我检测到 " + attachments.size() + " 张图片附件，并调用 understand_image 工具读取图片内容、可见文字和截图结构。\n当前工具返回 " + imageSources.size() + " 条图片分析结果，其中 " + successCount + " 条成功进入回答上下文。");
        }
        if (noSources) {
            lines.add("检查资料覆盖度\n这次没有获得足够可用的外部参考资料，因此回答会更谨慎。\n我会避免把缺少依据的信息写成确定事实。");
        } else {
            lines.add("筛选与交叉验证\n我会合并知识库片段和网页摘要，优先采用可追溯、与问题直接相关、彼此不冲突的资料。\n对时效性强或存在争议的内容，会在答案中保留限定语。");
            lines.add("组织回答结构\n我会先给出直接结论，再用表格、步骤或要点展开原因。\n最后补充注意事项，让答案既好读，也方便用户执行或继续追问。");
        }
        return String.join("\n", lines);
    }

    private List<Map<String, Object>> sanitizeAttachments(List<Map<String, Object>> rawAttachments) {
        if (rawAttachments == null || rawAttachments.isEmpty()) {
            return new ArrayList<>();
        }
        List<Map<String, Object>> attachments = new ArrayList<>();
        for (Map<String, Object> raw : rawAttachments) {
            if (raw == null || attachments.size() >= 6) {
                continue;
            }
            String type = Objects.toString(raw.getOrDefault("type", "image"), "image");
            String mimeType = Objects.toString(raw.getOrDefault("mimeType", ""), "");
            String url = Objects.toString(raw.getOrDefault("url", ""), "");
            if (!"image".equals(type) || !mimeType.startsWith("image/") || url.isBlank()) {
                continue;
            }
            Map<String, Object> attachment = new HashMap<>();
            attachment.put("type", "image");
            attachment.put("name", truncate(Objects.toString(raw.getOrDefault("name", "image"), "image"), 120));
            attachment.put("mimeType", truncate(mimeType, 80));
            attachment.put("url", url);
            attachment.put("size", raw.getOrDefault("size", 0));
            attachments.add(attachment);
        }
        return attachments;
    }

    private String buildQuestionWithAttachments(String question, List<Map<String, Object>> attachments) {
        if (attachments.isEmpty()) {
            return question;
        }
        StringBuilder builder = new StringBuilder(question == null ? "" : question);
        builder.append("\n\n用户随消息附带了 ").append(attachments.size()).append(" 张图片，图片理解结果已写入 Context：");
        for (int i = 0; i < attachments.size(); i++) {
            Map<String, Object> attachment = attachments.get(i);
            builder.append("\n")
                    .append(i + 1)
                    .append(". ")
                    .append(Objects.toString(attachment.get("name"), "image"))
                    .append(" (")
                    .append(Objects.toString(attachment.get("mimeType"), "image"))
                    .append(")");
        }
        return builder.toString();
    }

    private SearchPlan buildWebSearchPlan(
            String question,
            RetrievalPlan retrievalPlan,
            List<Map<String, Object>> imageSources) {
        SearchPlan fallback = fallbackSearchPlan(retrievalPlan);
        try {
            String imageText = imageSources.stream()
                    .filter(source -> Boolean.TRUE.equals(source.get("success")))
                    .map(source -> Objects.toString(source.get("text"), ""))
                    .filter(text -> !text.isBlank())
                    .limit(3)
                    .collect(Collectors.joining("\n"));

            String plannerPrompt = """
                    You are a universal web-search query planner.
                    Read the user request and any image-understanding text, then produce only one compact JSON object.
                    The JSON schema is:
                    {
                      "searchQuery": "one precise search-engine query, preserving important names, versions, numbers, quoted terms and constraints",
                      "keywords": ["3 to 6 short display keywords or phrases"],
                      "webTopK": 12-30,
                      "webFetchTopK": 4-10
                    }
                    Rules:
                    - Do not answer the user's question.
                    - Do not hard-code a domain. Work for any topic, language, course, product, paper, person, image or troubleshooting request.
                    - Keep complete entities intact, especially names with versions, dates, numbers, symbols or abbreviations.
                    - If the user asks about an exact entity/version/name, include that exact phrase in searchQuery. Do not substitute a nearby version.
                    - Remove filler words, but keep intent words such as parameter, price, comparison, tutorial, definition, official, pros and cons, cause, fix, security, release date when they matter.
                    - Return valid JSON only, without Markdown.
                    """;

            String input = "User request:\n" + Objects.toString(question, "") +
                    "\n\nRetrieval query draft:\n" + retrievalPlan.query() +
                    (imageText.isBlank() ? "" : "\n\nImage-understanding text:\n" + truncate(imageText, 1200));
            String raw = miniMaxChat.chat(plannerPrompt, "", input);
            return preserveExactPhrases(parseSearchPlanResponse(raw, fallback), question + " " + retrievalPlan.query());
        } catch (Exception e) {
            log.debug("AI search plan fallback used: {}", e.getMessage());
            return fallback;
        }
    }

    private SearchPlan parseSearchPlanResponse(String raw, SearchPlan fallback) {
        String jsonText = extractJsonObject(raw);
        if (jsonText.isBlank()) {
            return fallback;
        }
        try {
            JsonObject object = JsonParser.parseString(jsonText).getAsJsonObject();
            String query = object.has("searchQuery") && !object.get("searchQuery").isJsonNull()
                    ? object.get("searchQuery").getAsString().trim()
                    : "";
            List<String> keywords = new ArrayList<>();
            if (object.has("keywords") && object.get("keywords").isJsonArray()) {
                for (var item : object.getAsJsonArray("keywords")) {
                    if (!item.isJsonNull()) {
                        String keyword = item.getAsString().trim();
                        if (!keyword.isBlank() && keywords.stream().noneMatch(existing -> existing.equalsIgnoreCase(keyword))) {
                            keywords.add(truncate(keyword, 80));
                        }
                    }
                }
            }
            if (query.isBlank()) {
                query = fallback.query();
            }
            if (keywords.isEmpty()) {
                keywords = fallback.keywords();
            }
            int webTopK = object.has("webTopK") ? clamp(object.get("webTopK").getAsInt(), 12, 30) : fallback.webTopK();
            int webFetchTopK = object.has("webFetchTopK") ? clamp(object.get("webFetchTopK").getAsInt(), 4, 10) : fallback.webFetchTopK();
            return new SearchPlan(truncate(query, 260), keywords.stream().limit(8).toList(), webTopK, webFetchTopK);
        } catch (Exception e) {
            log.debug("AI search plan parse failed: {}", e.getMessage());
            return fallback;
        }
    }

    private SearchPlan preserveExactPhrases(SearchPlan plan, String source) {
        List<String> exactPhrases = extractExactSearchPhrases(source);
        if (exactPhrases.isEmpty()) {
            return plan;
        }

        String query = Objects.toString(plan.query(), "");
        List<String> keywords = new ArrayList<>(plan.keywords());
        for (String phrase : exactPhrases) {
            if (!containsLoosePhrase(query, phrase)) {
                query = "\"" + phrase + "\" " + query;
            }
            if (keywords.stream().noneMatch(keyword -> keyword.equalsIgnoreCase(phrase))) {
                keywords.add(0, phrase);
            }
        }
        return new SearchPlan(truncate(query.trim(), 260), keywords.stream().limit(8).toList(), plan.webTopK(), plan.webFetchTopK());
    }

    private List<String> extractExactSearchPhrases(String source) {
        if (source == null || source.isBlank()) {
            return new ArrayList<>();
        }
        Set<String> phrases = new LinkedHashSet<>();
        java.util.regex.Matcher matcher = java.util.regex.Pattern
                .compile("(?iu)([\\p{L}][\\p{L}\\p{N}+#./_]*[\\s-]+\\d+(?:\\.\\d+)*(?:[\\p{L}\\p{N}+#./_-]{0,20})?)")
                .matcher(source);
        while (matcher.find()) {
            String phrase = matcher.group(1).replaceAll("\\s+", " ").trim();
            if (phrase.length() >= 3 && phrase.length() <= 80) {
                phrases.add(phrase);
            }
        }
        return phrases.stream().limit(4).toList();
    }

    private boolean containsLoosePhrase(String text, String phrase) {
        String normalizedText = normalizeLoosePhrase(text);
        String normalizedPhrase = normalizeLoosePhrase(phrase);
        return !normalizedPhrase.isBlank() && normalizedText.contains(normalizedPhrase);
    }

    private String normalizeLoosePhrase(String value) {
        return value == null ? "" : value.toLowerCase(Locale.ROOT)
                .replaceAll("[\"'`]+", "")
                .replaceAll("[\\s_-]+", " ")
                .trim();
    }

    private SearchPlan fallbackSearchPlan(RetrievalPlan retrievalPlan) {
        String query = retrievalPlan.query();
        List<String> keywords = webSearchService.extractKeywords(query);
        if (keywords.isEmpty() && !query.isBlank()) {
            keywords = List.of(truncate(query, 100));
        }
        return new SearchPlan(
                truncate(query, 220),
                keywords.stream().limit(6).toList(),
                retrievalPlan.webTopK(),
                retrievalPlan.webFetchTopK()
        );
    }

    private String extractJsonObject(String raw) {
        if (raw == null || raw.isBlank()) {
            return "";
        }
        int start = raw.indexOf('{');
        int end = raw.lastIndexOf('}');
        if (start < 0 || end <= start) {
            return "";
        }
        return raw.substring(start, end + 1);
    }

    private int clamp(int value, int min, int max) {
        return Math.max(min, Math.min(max, value));
    }

    private RetrievalPlan buildRetrievalPlan(
            String question,
            String retrievalMode,
            boolean deepThinking,
            List<Map<String, Object>> imageSources) {
        String imageText = imageSources.stream()
                .filter(source -> Boolean.TRUE.equals(source.get("success")))
                .map(source -> Objects.toString(source.get("text"), ""))
                .filter(text -> !text.isBlank())
                .collect(Collectors.joining("\n"));
        String combined = ((question == null ? "" : question) + "\n" + imageText).trim();
        List<String> terms = extractSearchTerms(combined);

        String query;
        if (question != null && !question.isBlank()) {
            String extraTerms = terms.stream()
                    .filter(term -> !question.contains(term))
                    .limit(imageSources.isEmpty() ? 3 : 6)
                    .collect(Collectors.joining(" "));
            query = (question + " " + extraTerms).trim();
        } else {
            query = terms.isEmpty() ? truncate(cleanForSearch(combined), 140) : String.join(" ", terms.stream().limit(8).toList());
        }
        if (query.isBlank()) {
            query = truncate(cleanForSearch(combined), 140);
        }

        boolean complex = isComplexQuery(combined, !imageSources.isEmpty(), deepThinking);
        int knowledgeTopK = complex ? 8 : 5;
        int webTopK = complex ? 20 : 12;
        int webFetchTopK = complex ? 8 : 5;
        if (deepThinking) {
            knowledgeTopK = Math.min(10, knowledgeTopK + 2);
            webTopK = Math.min(30, webTopK + 6);
            webFetchTopK = Math.min(10, webFetchTopK + 2);
        }
        if (!imageSources.isEmpty()) {
            knowledgeTopK = Math.max(knowledgeTopK, 7);
            webTopK = Math.max(webTopK, 18);
            webFetchTopK = Math.max(webFetchTopK, 7);
        }

        return new RetrievalPlan(
                truncate(query, 220),
                usesKnowledge(retrievalMode),
                usesWeb(retrievalMode),
                knowledgeTopK,
                webTopK,
                webFetchTopK
        );
    }

    private List<String> extractSearchTerms(String text) {
        if (text == null || text.isBlank()) {
            return new ArrayList<>();
        }
        String normalized = cleanForSearch(text);
        Set<String> terms = new LinkedHashSet<>();
        Set<String> stopWords = Set.of(
                "图片", "内容", "用户", "问题", "主要", "可见", "文字", "信息", "截图", "工具", "结果",
                "分析", "说明", "回答", "这个", "一个", "如果", "可以", "进行", "相关", "识别",
                "the", "and", "for", "with", "from", "this", "that", "image", "content"
        );

        java.util.regex.Matcher latinMatcher = java.util.regex.Pattern
                .compile("\\b[A-Za-z][A-Za-z0-9+#./-]{1,30}\\b")
                .matcher(normalized);
        while (latinMatcher.find() && terms.size() < 12) {
            String term = latinMatcher.group();
            if (!stopWords.contains(term.toLowerCase(Locale.ROOT))) {
                terms.add(term);
            }
        }

        java.util.regex.Matcher chineseMatcher = java.util.regex.Pattern
                .compile("[\\u4e00-\\u9fa5A-Za-z0-9+#-]{2,18}")
                .matcher(normalized);
        while (chineseMatcher.find() && terms.size() < 14) {
            String term = chineseMatcher.group();
            if (term.length() < 2 || stopWords.contains(term.toLowerCase(Locale.ROOT))) {
                continue;
            }
            terms.add(term);
        }
        return new ArrayList<>(terms);
    }

    private boolean isComplexQuery(String text, boolean hasImages, boolean deepThinking) {
        String value = text == null ? "" : text;
        if (deepThinking || hasImages || value.length() > 80) {
            return true;
        }
        return value.matches(".*(对比|比较|排名|主流|最新|优势|劣势|原理|教程|实现|方案|分析|总结|为什么|如何|怎么|资料|论文|调研|安全|攻击|防御).*");
    }

    private String cleanForSearch(String value) {
        return (value == null ? "" : value)
                .replaceAll("[\\p{Cntrl}]+", " ")
                .replaceAll("[，。！？；：、“”‘’（）【】《》<>`~|]+", " ")
                .replaceAll("\\s+", " ")
                .trim();
    }

    private String firstNonBlank(String first, String second) {
        return first == null || first.isBlank() ? Objects.toString(second, "") : first;
    }

    private String host(String url) {
        try {
            String host = java.net.URI.create(Objects.toString(url, "")).getHost();
            return host == null ? "" : host.toLowerCase(Locale.ROOT);
        } catch (Exception e) {
            return "";
        }
    }

    private String formatModeLabel(String retrievalMode) {
        return switch (retrievalMode) {
            case "web" -> "联网搜索";
            case "hybrid" -> "混合检索";
            default -> "知识库检索";
        };
    }

    private String formatSourceTypeLabel(String type) {
        return switch (type) {
            case "web" -> "网页";
            case "image" -> "图片理解工具";
            default -> "知识库";
        };
    }

    private String truncate(String value, int maxLength) {
        if (value == null) {
            return "";
        }
        if (value.length() <= maxLength) {
            return value;
        }
        return value.substring(0, maxLength) + "...";
    }

    private record SearchPlan(
            String query,
            List<String> keywords,
            int webTopK,
            int webFetchTopK) {
    }

    private record RetrievalPlan(
            String query,
            boolean useKnowledge,
            boolean useWeb,
            int knowledgeTopK,
            int webTopK,
            int webFetchTopK) {
    }

    @PostMapping("/query-legacy")
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
     * 清空会话历史（仅清空消息，保留会话）
     * DELETE /api/rag/history/{sessionId}
     */
    @DeleteMapping("/history/{sessionId}")
    public Result<Void> clearHistory(@PathVariable String sessionId) {
        try {
            SessionDTO session = sessionMemory.getSession(sessionId);
            if (session != null && !session.getUserId().equals(getCurrentUserId())) {
                return Result.error("无权访问此会话");
            }
            sessionMemory.clearSession(sessionId);
            return Result.success(null);
        } catch (Exception e) {
            log.error("清空会话历史失败: {}", e.getMessage());
            return Result.error("清空会话历史失败: " + e.getMessage());
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

    @GetMapping("/metrics/summary")
    public Result<Map<String, Object>> getMetricSummary(
            @RequestParam(defaultValue = "100") Integer limit,
            @RequestParam(defaultValue = "true") Boolean currentUserOnly) {
        try {
            String userId = Boolean.FALSE.equals(currentUserOnly) ? null : getCurrentUserId();
            return Result.success(metricService.summary(userId, limit == null ? 100 : limit));
        } catch (Exception e) {
            log.error("Failed to get RAG metric summary: {}", e.getMessage(), e);
            return Result.error("Failed to get RAG metric summary: " + e.getMessage());
        }
    }
}
