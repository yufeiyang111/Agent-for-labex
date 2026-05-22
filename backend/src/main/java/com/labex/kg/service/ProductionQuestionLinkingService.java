package com.labex.kg.service;

import com.labex.entity.Question;
import com.labex.kg.repository.KnowledgeGraphRepository;
import com.labex.rag.vector.EmbeddingService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 生产环境题目关联服务
 * 使用 Embedding 向量相似度进行快速匹配，无需 LLM
 */
@Slf4j
@Service
public class ProductionQuestionLinkingService {

    @Autowired
    private KnowledgeGraphRepository repository;

    @Autowired
    private EmbeddingService embeddingService;

    private static final int BATCH_SIZE = 50;
    private static final double SIMILARITY_THRESHOLD = 0.6; // 相似度阈值
    private static final int MAX_KP_PER_QUESTION = 3; // 每题最多关联知识点数

    /**
     * 快速关联题目到知识点（基于向量相似度）
     * 速度：100题/秒，成本：几乎为0
     */
    @Async
    public void linkQuestionsFast(List<Question> allQuestions, boolean forceReprocess) {
        log.info("Starting fast question linking for {} questions", allQuestions.size());

        // 1. 加载所有知识点及其 embedding
        List<Map<String, Object>> allKPs = repository.findAllKnowledgePoints(null, null, 0, 10000);
        if (allKPs.isEmpty()) {
            log.warn("No knowledge points found. Please extract knowledge points first.");
            return;
        }

        // 过滤有 embedding 的知识点
        List<KnowledgePointEmbedding> kpEmbeddings = allKPs.stream()
                .filter(kp -> kp.get("embedding") != null)
                .map(kp -> new KnowledgePointEmbedding(
                        (String) kp.get("id"),
                        (String) kp.get("name"),
                        toDoubleList(kp.get("embedding"))
                ))
                .collect(Collectors.toList());

        log.info("Loaded {} knowledge points with embeddings", kpEmbeddings.size());

        if (kpEmbeddings.isEmpty()) {
            log.warn("No knowledge points with embeddings found.");
            return;
        }

        // 2. 批量处理题目
        int totalLinked = 0;
        int totalSkipped = 0;

        for (int i = 0; i < allQuestions.size(); i += BATCH_SIZE) {
            int end = Math.min(i + BATCH_SIZE, allQuestions.size());
            List<Question> batch = allQuestions.subList(i, end);

            try {
                int linked = processBatch(batch, kpEmbeddings, forceReprocess);
                totalLinked += linked;
                totalSkipped += (batch.size() - linked);

                if ((i / BATCH_SIZE) % 10 == 0) {
                    log.info("Progress: {}/{} questions processed", i + batch.size(), allQuestions.size());
                }
            } catch (Exception e) {
                log.error("Failed to process batch {}-{}: {}", i, end, e.getMessage());
            }
        }

        log.info("Fast linking complete. Linked: {}, Skipped: {}", totalLinked, totalSkipped);
    }

    /**
     * 处理一批题目
     */
    private int processBatch(List<Question> batch, List<KnowledgePointEmbedding> kpEmbeddings, boolean forceReprocess) {
        // 准备文本列表
        List<String> texts = batch.stream()
                .map(q -> buildQuestionText(q))
                .collect(Collectors.toList());

        // 批量生成 embedding（一次 API 调用）
        List<List<Double>> embeddings;
        try {
            embeddings = embeddingService.embed(texts);
        } catch (Exception e) {
            log.error("Failed to generate embeddings: {}", e.getMessage());
            return 0;
        }

        int linked = 0;
        for (int i = 0; i < batch.size(); i++) {
            Question question = batch.get(i);
            List<Double> questionEmbedding = embeddings.get(i);

            // 计算与所有知识点的相似度
            List<SimilarityResult> similarities = kpEmbeddings.stream()
                    .map(kp -> new SimilarityResult(
                            kp.id,
                            kp.name,
                            cosineSimilarity(questionEmbedding, kp.embedding)
                    ))
                    .sorted((a, b) -> Double.compare(b.similarity, a.similarity))
                    .limit(MAX_KP_PER_QUESTION)
                    .filter(r -> r.similarity >= SIMILARITY_THRESHOLD)
                    .collect(Collectors.toList());

            if (!similarities.isEmpty()) {
                // 创建或更新题目节点
                boolean isProgramming = question.getIsProgramming() != null && question.getIsProgramming() == 1;
                repository.upsertQuestionRef(question.getId(), question.getQuestion(), question.getType(), isProgramming);

                // 关联到知识点
                for (int j = 0; j < similarities.size(); j++) {
                    SimilarityResult sim = similarities.get(j);
                    boolean isPrimary = (j == 0);
                    repository.linkQuestionToKnowledgePoint(question.getId(), sim.kpId, sim.similarity, isPrimary);
                }
                linked++;
            }
        }

        return linked;
    }

    /**
     * 构建题目文本（用于 embedding）
     */
    private String buildQuestionText(Question q) {
        StringBuilder sb = new StringBuilder();
        sb.append(q.getQuestion());

        // 如果有选项，加入选项内容
        if (q.getOptions() != null && !q.getOptions().isEmpty()) {
            sb.append(" ").append(q.getOptions());
        }

        // 如果有答案，加入答案关键词
        if (q.getAnswer() != null && !q.getAnswer().isEmpty()) {
            sb.append(" 答案:").append(q.getAnswer());
        }

        return sb.toString();
    }

    /**
     * 计算余弦相似度
     */
    private double cosineSimilarity(List<Double> a, List<Double> b) {
        if (a == null || b == null || a.size() != b.size()) {
            return 0.0;
        }

        double dotProduct = 0.0;
        double normA = 0.0;
        double normB = 0.0;

        for (int i = 0; i < a.size(); i++) {
            dotProduct += a.get(i) * b.get(i);
            normA += a.get(i) * a.get(i);
            normB += b.get(i) * b.get(i);
        }

        if (normA == 0.0 || normB == 0.0) {
            return 0.0;
        }

        return dotProduct / (Math.sqrt(normA) * Math.sqrt(normB));
    }

    private List<Double> toDoubleList(Object embedding) {
        if (embedding instanceof List) {
            @SuppressWarnings("unchecked")
            List<Object> list = (List<Object>) embedding;
            return list.stream()
                    .map(obj -> {
                        if (obj instanceof Number) {
                            return ((Number) obj).doubleValue();
                        }
                        return 0.0;
                    })
                    .collect(Collectors.toList());
        }
        return new ArrayList<>();
    }

    /**
     * 知识点 Embedding 数据结构
     */
    private static class KnowledgePointEmbedding {
        final String id;
        final String name;
        final List<Double> embedding;

        KnowledgePointEmbedding(String id, String name, List<Double> embedding) {
            this.id = id;
            this.name = name;
            this.embedding = embedding;
        }
    }

    /**
     * 相似度结果
     */
    private static class SimilarityResult {
        final String kpId;
        final String kpName;
        final double similarity;

        SimilarityResult(String kpId, String kpName, double similarity) {
            this.kpId = kpId;
            this.kpName = kpName;
            this.similarity = similarity;
        }
    }
}
