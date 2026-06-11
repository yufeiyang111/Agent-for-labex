package com.labex.service.ai;

import com.labex.dto.ai.GenerateBatchDTO;
import com.labex.dto.ai.GeneratedQuestionDTO;
import com.labex.dto.ai.QuestionGenerateRequest;
import com.labex.entity.Lecture;
import com.labex.entity.Question;
import com.labex.langchain4j.agent.GeneratedQuestion;
import com.labex.langchain4j.agent.QuestionGenerationAgent;
import com.labex.rag.retrieval.HybridRetriever;
import com.labex.service.LectureService;
import com.labex.service.QuestionService;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.CompletableFuture;
import java.util.stream.Collectors;

/**
 * AI题目生成核心服务
 * 集成知识库检索、相似度检查、智能避重
 */
@Slf4j
@Service
public class AiQuestionGenerationService {

    private final QuestionGenerationAgent generationAgent;
    private final HybridRetriever hybridRetriever;
    private final QuestionSimilarityService similarityService;
    private final QuestionGenerationCacheService cacheService;
    private final LectureService lectureService;
    private final QuestionService questionService;
    private final Gson gson = new Gson();

    // 题目类型名称映射
    private static final Map<Integer, String> TYPE_NAMES = Map.of(
            1, "填空题",
            2, "单选题",
            3, "多选题",
            4, "判断题",
            5, "简答题",
            6, "编程题"
    );

    // 相似度阈值：超过此值需要重新生成
    private static final double REGENERATE_THRESHOLD = 0.75;

    // 最大重试次数
    private static final int MAX_RETRY_COUNT = 3;

    @Autowired
    public AiQuestionGenerationService(QuestionGenerationAgent generationAgent,
                                       HybridRetriever hybridRetriever,
                                       QuestionSimilarityService similarityService,
                                       QuestionGenerationCacheService cacheService,
                                       LectureService lectureService,
                                       QuestionService questionService) {
        this.generationAgent = generationAgent;
        this.hybridRetriever = hybridRetriever;
        this.similarityService = similarityService;
        this.cacheService = cacheService;
        this.lectureService = lectureService;
        this.questionService = questionService;
    }

    /**
     * 异步生成题目
     * 使用 @Async 注解在Spring异步线程池中执行，不再额外包装 CompletableFuture.supplyAsync()
     */
    @Async
    public CompletableFuture<GenerateBatchDTO> generateQuestionsAsync(QuestionGenerateRequest request) {
        GenerateBatchDTO result = generateQuestions(request);
        return CompletableFuture.completedFuture(result);
    }

    /**
     * 生成题目（同步版本）
     */
    public GenerateBatchDTO generateQuestions(QuestionGenerateRequest request) {
        String batchId = request.getBatchId() != null ? request.getBatchId() : UUID.randomUUID().toString().replace("-", "");
        request.setBatchId(batchId);

        GenerateBatchDTO batch = new GenerateBatchDTO();
        batch.setBatchId(batchId);
        batch.setTeacherId(request.getTeacherId());
        batch.setRequest(request);
        batch.setStartedAt(LocalDateTime.now());
        batch.setStatus("generating");
        batch.setQuestions(new ArrayList<>());

        // 立即保存初始状态到Redis，让前端可以轮询到
        cacheService.saveBatch(batch);
        log.info("批次已创建并保存: batchId={}, teacherId={}", batchId, request.getTeacherId());

        try {
            // 1. 从知识库检索相关内容
            List<String> sourceContexts = retrieveKnowledge(request);
            batch.setSourceContexts(sourceContexts);

            if (sourceContexts.isEmpty()) {
                batch.setStatus("failed");
                batch.setErrorMessage("未找到相关知识库内容，请检查关键词或讲义选择");
                batch.setCompletedAt(LocalDateTime.now());
                cacheService.saveBatch(batch);
                return batch;
            }

            // 2. 生成题目（每生成一道就更新到Redis）
            List<GeneratedQuestionDTO> allQuestions = new ArrayList<>();
            for (Integer questionType : request.getQuestionTypes()) {
                List<GeneratedQuestionDTO> questions = generateQuestionsByType(
                        questionType, sourceContexts, request, batchId,
                        // 回调：每生成一道题就更新Redis
                        newQuestion -> {
                            allQuestions.add(newQuestion);
                            batch.setQuestions(new ArrayList<>(allQuestions));
                            batch.setTotalCount(allQuestions.size());
                            cacheService.saveBatch(batch);
                            log.info("题目已生成并保存: batchId={}, 当前总数={}", batchId, allQuestions.size());
                        });
            }

            // 3. 设置批次信息
            batch.setQuestions(allQuestions);
            batch.setTotalCount(allQuestions.size());
            batch.setStatus("completed");
            batch.setCompletedAt(LocalDateTime.now());

            // 4. 统计各题型数量
            Map<String, Integer> typeDistribution = allQuestions.stream()
                    .collect(Collectors.groupingBy(q -> String.valueOf(q.getType()), Collectors.summingInt(q -> 1)));
            batch.setTypeDistribution(typeDistribution);

            // 5. 保存最终状态到Redis
            cacheService.saveBatch(batch);

            log.info("题目生成完成: batchId={}, totalCount={}, typeDistribution={}",
                    batchId, allQuestions.size(), typeDistribution);

            return batch;
        } catch (Exception e) {
            log.error("题目生成失败: batchId={}, error={}", batchId, e.getMessage(), e);
            batch.setStatus("failed");
            batch.setErrorMessage(e.getMessage());
            batch.setCompletedAt(LocalDateTime.now());
            cacheService.saveBatch(batch);
            return batch;
        }
    }

    /**
     * 从知识库检索相关内容
     */
    private List<String> retrieveKnowledge(QuestionGenerateRequest request) {
        List<String> contexts = new ArrayList<>();

        // 方式1：通过关键词检索
        if (request.getKnowledgeKeywords() != null && !request.getKnowledgeKeywords().isBlank()) {
            List<Map<String, Object>> searchResults = hybridRetriever.search(
                    request.getKnowledgeKeywords(), 10);
            for (Map<String, Object> result : searchResults) {
                String text = (String) result.get("text");
                if (text != null && !text.isBlank()) {
                    contexts.add(text);
                }
            }
        }

        // 方式2：通过讲义ID检索
        if (request.getLectureIds() != null && !request.getLectureIds().isEmpty()) {
            List<Lecture> lectures = lectureService.listByIds(request.getLectureIds());
            for (Lecture lecture : lectures) {
                String content = lecture.getLectureContent();
                if (content != null && !content.isBlank()) {
                    contexts.add("【讲义：" + lecture.getLectureName() + "】\n" + content);
                }
            }
        }

        // 如果没有指定关键词和讲义，使用默认检索
        if (contexts.isEmpty() && request.getKnowledgeKeywords() != null) {
            List<Map<String, Object>> defaultResults = hybridRetriever.search(
                    "教育 知识点 概念 原理", 5);
            for (Map<String, Object> result : defaultResults) {
                String text = (String) result.get("text");
                if (text != null && !text.isBlank()) {
                    contexts.add(text);
                }
            }
        }

        return contexts;
    }

    /**
     * 按题型生成题目
     */
    private List<GeneratedQuestionDTO> generateQuestionsByType(Integer questionType,
                                                                List<String> sourceContexts,
                                                                QuestionGenerateRequest request,
                                                                String batchId,
                                                                java.util.function.Consumer<GeneratedQuestionDTO> onQuestionGenerated) {
        List<GeneratedQuestionDTO> questions = new ArrayList<>();
        int countPerType = request.getCountPerType() != null ? request.getCountPerType() : 5;
        int retryCount = 0;

        while (questions.size() < countPerType && retryCount < MAX_RETRY_COUNT) {
            // 1. 使用LLM生成题目
            List<GeneratedQuestion> generated = generationAgent.generate(
                    String.join("\n\n", sourceContexts),
                    "知识库内容",
                    questionType,
                    request.getDifficulty()
            );

            // 2. 检查相似度并过滤
            for (GeneratedQuestion gq : generated) {
                if (questions.size() >= countPerType) {
                    break;
                }

                // 检查与现有题库的相似度
                QuestionSimilarityService.SimilarityCheckResult similarityResult =
                        similarityService.checkSimilarity(gq.getQuestion(), questionType);

                if (similarityResult.getIsDuplicate()) {
                    log.info("题目相似度过高，跳过: similarity={}, similarQuestionId={}",
                            similarityResult.getSimilarityScore(), similarityResult.getSimilarQuestionId());

                    // 尝试切换考察角度重新生成
                    GeneratedQuestion regenerated = regenerateWithDifferentAngle(
                            gq, sourceContexts, questionType, request.getDifficulty());
                    if (regenerated != null) {
                        // 再次检查相似度
                        QuestionSimilarityService.SimilarityCheckResult recheckResult =
                                similarityService.checkSimilarity(regenerated.getQuestion(), questionType);
                        if (!recheckResult.getIsDuplicate()) {
                            GeneratedQuestionDTO dto = convertToDTO(regenerated, questionType, batchId,
                                    similarityResult, sourceContexts);
                            questions.add(dto);
                            // 回调通知已生成一道题
                            if (onQuestionGenerated != null) {
                                onQuestionGenerated.accept(dto);
                            }
                        }
                    }
                } else {
                    GeneratedQuestionDTO dto = convertToDTO(gq, questionType, batchId,
                            similarityResult, sourceContexts);
                    questions.add(dto);
                    // 回调通知已生成一道题
                    if (onQuestionGenerated != null) {
                        onQuestionGenerated.accept(dto);
                    }
                }
            }

            retryCount++;
        }

        return questions;
    }

    /**
     * 切换考察角度重新生成
     */
    private GeneratedQuestion regenerateWithDifferentAngle(GeneratedQuestion original,
                                                            List<String> sourceContexts,
                                                            Integer questionType,
                                                            String difficulty) {
        try {
            // 构建提示词，要求从不同角度生成
            String prompt = buildRegenerationPrompt(original, questionType);

            // 使用LLM重新生成
            List<GeneratedQuestion> regenerated = generationAgent.generate(
                    String.join("\n\n", sourceContexts),
                    "知识库内容",
                    questionType,
                    difficulty,
                    prompt
            );

            if (!regenerated.isEmpty()) {
                return regenerated.get(0);
            }
        } catch (Exception e) {
            log.warn("切换角度重新生成失败: {}", e.getMessage());
        }
        return null;
    }

    /**
     * 构建重新生成的提示词
     */
    private String buildRegenerationPrompt(GeneratedQuestion original, Integer questionType) {
        StringBuilder prompt = new StringBuilder();
        prompt.append("请从不同的考察角度生成一道新的").append(TYPE_NAMES.get(questionType)).append("。\n\n");
        prompt.append("### 重新生成要求\n\n");
        prompt.append("1. **相同知识点，不同角度**：考察相同的知识点，但必须从完全不同的角度出题\n");
        prompt.append("2. **禁止表面修改**：禁止只是修改数值、调换选项顺序或改变表述方式\n");
        prompt.append("3. **能力层次转换**：尝试考察不同的能力层次（记忆→理解→应用→分析→评价）\n");
        prompt.append("4. **本质区别**：题目表述、问法、解题思路必须有本质区别\n\n");
        prompt.append("### 原题目（请避免与此题相似）\n\n");
        prompt.append(original.getQuestion());

        return prompt.toString();
    }

    /**
     * 转换为DTO
     */
    private GeneratedQuestionDTO convertToDTO(GeneratedQuestion gq, Integer questionType,
                                               String batchId,
                                               QuestionSimilarityService.SimilarityCheckResult similarityResult,
                                               List<String> sourceContexts) {
        GeneratedQuestionDTO dto = new GeneratedQuestionDTO();
        dto.setTempId(UUID.randomUUID().toString().replace("-", ""));
        dto.setType(questionType);
        dto.setTypeName(TYPE_NAMES.getOrDefault(questionType, "未知"));
        dto.setQuestion(gq.getQuestion());
        dto.setAnswer(gq.getAnswer());
        dto.setAnalysis(gq.getAnalysis());
        dto.setOptions(gq.getOptions() != null ? gson.toJson(gq.getOptions()) : null);
        dto.setKnowledgePoint(gq.getKnowledgePoint());
        dto.setDifficulty(gq.getDifficulty());
        dto.setScore(gq.getScore());
        dto.setBatchId(batchId);
        dto.setGeneratedAt(LocalDateTime.now());
        dto.setStatus("pending");

        // 设置相似度信息
        dto.setSimilarityScore(similarityResult.getSimilarityScore());
        dto.setSimilarQuestionId(similarityResult.getSimilarQuestionId());
        dto.setSimilarQuestionText(similarityResult.getSimilarQuestionText());

        // 设置来源上下文
        if (!sourceContexts.isEmpty()) {
            dto.setSourceContext(sourceContexts.get(0).substring(0,
                    Math.min(500, sourceContexts.get(0).length())) + "...");
        }

        // 设置考察角度
        dto.setExamAngle(gq.getKnowledgePoint() + " - " + gq.getDifficulty());

        return dto;
    }

    /**
     * 持久化题目到数据库
     */
    public Question persistQuestion(String tempId) {
        GeneratedQuestionDTO dto = cacheService.getQuestion(tempId);
        if (dto == null) {
            throw new RuntimeException("题目不存在: " + tempId);
        }

        if (Boolean.TRUE.equals(dto.getPersisted())) {
            throw new RuntimeException("题目已持久化");
        }

        // 创建题目实体
        Question question = new Question();
        question.setQuestion(dto.getModifiedQuestion() != null ? dto.getModifiedQuestion() : dto.getQuestion());
        question.setAnswer(dto.getModifiedAnswer() != null ? dto.getModifiedAnswer() : dto.getAnswer());
        question.setAnalysis(dto.getModifiedAnalysis() != null ? dto.getModifiedAnalysis() : dto.getAnalysis());
        question.setType(dto.getType());
        question.setScore(dto.getScore() != null ? dto.getScore() : 10);
        question.setOptions(dto.getOptions());
        question.setTeacherId(dto.getBatchId() != null ? getTeacherIdFromBatch(dto.getBatchId()) : null);
        question.setState(1);

        // 保存到数据库
        questionService.save(question);

        // 标记为已持久化
        cacheService.markPersisted(tempId, question.getId());

        log.info("题目已持久化: tempId={}, questionId={}", tempId, question.getId());

        return question;
    }

    /**
     * 批量持久化题目
     */
    public List<Question> batchPersistQuestions(List<String> tempIds) {
        List<Question> persistedQuestions = new ArrayList<>();

        for (String tempId : tempIds) {
            try {
                Question question = persistQuestion(tempId);
                persistedQuestions.add(question);
            } catch (Exception e) {
                log.warn("持久化题目失败: tempId={}, error={}", tempId, e.getMessage());
            }
        }

        return persistedQuestions;
    }

    /**
     * 从批次ID获取教师ID
     */
    private Integer getTeacherIdFromBatch(String batchId) {
        GenerateBatchDTO batch = cacheService.getBatch(batchId);
        return batch != null ? batch.getTeacherId() : null;
    }

    /**
     * 重新生成单个题目
     */
    public GeneratedQuestionDTO regenerateQuestion(String tempId, String requirements) {
        GeneratedQuestionDTO original = cacheService.getQuestion(tempId);
        if (original == null) {
            throw new RuntimeException("题目不存在: " + tempId);
        }

        // 获取批次信息
        GenerateBatchDTO batch = cacheService.getBatch(original.getBatchId());
        if (batch == null) {
            throw new RuntimeException("批次不存在");
        }

        // 重新生成
        QuestionGenerateRequest request = batch.getRequest();
        List<String> sourceContexts = batch.getSourceContexts();

        // 构建自定义提示词
        String prompt = buildCustomRegenerationPrompt(original, requirements);

        // 使用LLM重新生成
        List<GeneratedQuestion> regenerated = generationAgent.generate(
                String.join("\n\n", sourceContexts),
                "知识库内容",
                original.getType(),
                original.getDifficulty(),
                prompt
        );

        if (regenerated.isEmpty()) {
            throw new RuntimeException("重新生成失败");
        }

        // 检查相似度
        GeneratedQuestion newQuestion = regenerated.get(0);
        QuestionSimilarityService.SimilarityCheckResult similarityResult =
                similarityService.checkSimilarity(newQuestion.getQuestion(), original.getType());

        // 转换为DTO
        GeneratedQuestionDTO newDto = convertToDTO(newQuestion, original.getType(),
                original.getBatchId(), similarityResult, sourceContexts);

        // 更新缓存中的题目
        cacheService.updateQuestionContent(tempId,
                newDto.getQuestion(), newDto.getAnswer(), newDto.getAnalysis());

        return newDto;
    }

    /**
     * 构建自定义重新生成提示词
     */
    private String buildCustomRegenerationPrompt(GeneratedQuestionDTO original, String requirements) {
        StringBuilder prompt = new StringBuilder();
        prompt.append("请根据以下要求重新生成一道").append(original.getTypeName()).append("。\n\n");
        prompt.append("### 原始题目\n\n");
        prompt.append(original.getQuestion()).append("\n\n");
        prompt.append("### 教师要求\n\n");
        prompt.append(requirements).append("\n\n");
        prompt.append("### 生成原则\n\n");
        prompt.append("1. 新题目必须与原题目考察相同的知识点\n");
        prompt.append("2. 严格按照教师要求进行调整\n");
        prompt.append("3. 确保题目表述清晰、答案准确、解析详细\n");

        return prompt.toString();
    }

    /**
     * 获取批次统计信息
     */
    public Map<String, Object> getBatchStatistics(String batchId) {
        GenerateBatchDTO batch = cacheService.getBatch(batchId);
        if (batch == null) {
            return Collections.emptyMap();
        }

        Map<String, Object> stats = new HashMap<>();
        stats.put("batchId", batchId);
        stats.put("status", batch.getStatus());
        stats.put("totalCount", batch.getTotalCount());
        stats.put("reviewedCount", batch.getReviewedCount());
        stats.put("approvedCount", batch.getApprovedCount());
        stats.put("rejectedCount", batch.getRejectedCount());
        stats.put("persistedCount", batch.getPersistedCount());
        stats.put("typeDistribution", batch.getTypeDistribution());
        stats.put("startedAt", batch.getStartedAt());
        stats.put("completedAt", batch.getCompletedAt());
        stats.put("expiresAt", batch.getExpiresAt());
        stats.put("ttl", cacheService.getBatchTTL(batchId));

        return stats;
    }
}
