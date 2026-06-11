package com.labex.service.ai;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.labex.entity.Question;
import com.labex.mapper.QuestionMapper;
import com.labex.rag.vector.EmbeddingService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 题目相似度检查服务
 * 使用文本相似度和语义相似度来检测重复题目
 */
@Slf4j
@Service
public class QuestionSimilarityService {

    private final QuestionMapper questionMapper;
    private final EmbeddingService embeddingService;

    // 相似度阈值：超过此值认为是重复题目
    private static final double SIMILARITY_THRESHOLD = 0.75;

    @Autowired
    public QuestionSimilarityService(QuestionMapper questionMapper,
                                     EmbeddingService embeddingService) {
        this.questionMapper = questionMapper;
        this.embeddingService = embeddingService;
    }

    /**
     * 检查题目与现有题库的相似度
     * @param questionText 题目内容
     * @param questionType 题目类型
     * @return 相似度检查结果
     */
    public SimilarityCheckResult checkSimilarity(String questionText, Integer questionType) {
        SimilarityCheckResult result = new SimilarityCheckResult();

        // 1. 获取同类型的现有题目
        List<Question> existingQuestions = questionMapper.selectList(
                new LambdaQueryWrapper<Question>()
                        .eq(Question::getType, questionType)
                        .eq(Question::getState, 1)
                        .select(Question::getId, Question::getQuestion, Question::getAnswer)
        );

        if (existingQuestions.isEmpty()) {
            result.setSimilarityScore(0.0);
            result.setIsDuplicate(false);
            return result;
        }

        // 2. 文本相似度检查（快速筛选）
        List<Question> textSimilarQuestions = existingQuestions.stream()
                .filter(q -> textSimilarity(questionText, q.getQuestion()) > 0.5)
                .collect(Collectors.toList());

        if (textSimilarQuestions.isEmpty()) {
            result.setSimilarityScore(0.0);
            result.setIsDuplicate(false);
            return result;
        }

        // 3. 语义相似度检查（精确判断）
        double maxSimilarity = 0.0;
        Question mostSimilarQuestion = null;

        try {
            // 计算新题目的embedding
            List<Double> newEmbedding = getEmbedding(questionText);

            for (Question existing : textSimilarQuestions) {
                List<Double> existingEmbedding = getEmbedding(existing.getQuestion());
                double similarity = cosineSimilarity(newEmbedding, existingEmbedding);

                if (similarity > maxSimilarity) {
                    maxSimilarity = similarity;
                    mostSimilarQuestion = existing;
                }
            }
        } catch (Exception e) {
            log.warn("Embedding计算失败，使用文本相似度: {}", e.getMessage());
            // 降级到文本相似度
            for (Question existing : textSimilarQuestions) {
                double similarity = textSimilarity(questionText, existing.getQuestion());
                if (similarity > maxSimilarity) {
                    maxSimilarity = similarity;
                    mostSimilarQuestion = existing;
                }
            }
        }

        result.setSimilarityScore(maxSimilarity);
        result.setIsDuplicate(maxSimilarity > SIMILARITY_THRESHOLD);
        if (mostSimilarQuestion != null) {
            result.setSimilarQuestionId(mostSimilarQuestion.getId());
            result.setSimilarQuestionText(mostSimilarQuestion.getQuestion());
        }

        return result;
    }

    /**
     * 批量检查相似度
     */
    public List<SimilarityCheckResult> batchCheckSimilarity(List<String> questionTexts, Integer questionType) {
        return questionTexts.stream()
                .map(text -> checkSimilarity(text, questionType))
                .collect(Collectors.toList());
    }

    /**
     * 获取embedding向量
     */
    private List<Double> getEmbedding(String text) {
        try {
            List<List<Double>> embeddings = embeddingService.embed(List.of(text));
            if (embeddings != null && !embeddings.isEmpty()) {
                return embeddings.get(0);
            }
            return Collections.emptyList();
        } catch (Exception e) {
            log.warn("获取embedding失败: {}", e.getMessage());
            return Collections.emptyList();
        }
    }

    /**
     * 计算余弦相似度
     */
    private double cosineSimilarity(List<Double> vec1, List<Double> vec2) {
        if (vec1 == null || vec2 == null || vec1.isEmpty() || vec2.isEmpty()) {
            return 0.0;
        }
        if (vec1.size() != vec2.size()) {
            return 0.0;
        }

        double dotProduct = 0.0;
        double norm1 = 0.0;
        double norm2 = 0.0;

        for (int i = 0; i < vec1.size(); i++) {
            dotProduct += vec1.get(i) * vec2.get(i);
            norm1 += vec1.get(i) * vec1.get(i);
            norm2 += vec2.get(i) * vec2.get(i);
        }

        if (norm1 == 0.0 || norm2 == 0.0) {
            return 0.0;
        }

        return dotProduct / (Math.sqrt(norm1) * Math.sqrt(norm2));
    }

    /**
     * 文本相似度计算（基于编辑距离）
     */
    private double textSimilarity(String s1, String s2) {
        if (s1 == null || s2 == null) return 0.0;
        if (s1.equals(s2)) return 1.0;

        String a = s1.replaceAll("\\s+", "").toLowerCase();
        String b = s2.replaceAll("\\s+", "").toLowerCase();

        if (a.isEmpty() && b.isEmpty()) return 1.0;
        if (a.isEmpty() || b.isEmpty()) return 0.0;

        int maxLen = Math.max(a.length(), b.length());
        int distance = levenshteinDistance(a, b);

        return 1.0 - (double) distance / maxLen;
    }

    /**
     * 计算编辑距离
     */
    private int levenshteinDistance(String s1, String s2) {
        int m = s1.length();
        int n = s2.length();
        int[][] dp = new int[m + 1][n + 1];

        for (int i = 0; i <= m; i++) {
            dp[i][0] = i;
        }
        for (int j = 0; j <= n; j++) {
            dp[0][j] = j;
        }

        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                if (s1.charAt(i - 1) == s2.charAt(j - 1)) {
                    dp[i][j] = dp[i - 1][j - 1];
                } else {
                    dp[i][j] = Math.min(dp[i - 1][j - 1], Math.min(dp[i - 1][j], dp[i][j - 1])) + 1;
                }
            }
        }

        return dp[m][n];
    }

    /**
     * 相似度检查结果
     */
    @lombok.Data
    public static class SimilarityCheckResult {
        private Double similarityScore;
        private Boolean isDuplicate;
        private Integer similarQuestionId;
        private String similarQuestionText;
    }
}
