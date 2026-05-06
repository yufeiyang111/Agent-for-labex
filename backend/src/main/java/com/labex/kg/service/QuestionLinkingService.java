package com.labex.kg.service;

import com.labex.entity.Question;
import com.labex.kg.repository.KnowledgeGraphRepository;
import com.labex.langchain4j.agent.QuestionClassifierAgent;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

/**
 * Batch auto-classify questions to knowledge points using LLM.
 */
@Slf4j
@Service
public class QuestionLinkingService {

    @Autowired
    private QuestionClassifierAgent classifierAgent;

    @Autowired
    private KnowledgeGraphRepository repository;

    private static final int BATCH_SIZE = 10;

    /**
     * Classify all questions and link them to knowledge points.
     *
     * @param allQuestions All questions from MySQL
     * @param forceReprocess If true, re-process even already-classified questions
     */
    @Async
    public void linkQuestions(List<Question> allQuestions, boolean forceReprocess) {
        // Get existing KP catalog for the classifier
        List<Map<String, Object>> allKPs = repository.findAllKnowledgePoints(null, "", 0, 1000);
        List<String> kpCatalog = allKPs.stream()
                .map(kp -> kp.get("name") + " (" + Objects.toString(kp.get("id"), "") + ")")
                .collect(Collectors.toList());

        if (kpCatalog.isEmpty()) {
            log.warn("No knowledge points in catalog. Run extraction first.");
            return;
        }

        int linked = 0;
        for (int i = 0; i < allQuestions.size(); i += BATCH_SIZE) {
            int end = Math.min(i + BATCH_SIZE, allQuestions.size());
            List<Question> batch = allQuestions.subList(i, end);

            // Build classification input
            List<Map<String, Object>> questionInputs = batch.stream()
                    .map(q -> {
                        Map<String, Object> m = new HashMap<>();
                        m.put("id", q.getId());  // MySQL question ID
                        m.put("text", q.getQuestion());
                        m.put("type", q.getType());
                        return m;
                    }).collect(Collectors.toList());

            // Call LLM
            List<Map<String, Object>> results = classifierAgent.classify(questionInputs, kpCatalog);
            if (results.isEmpty()) {
                log.warn("No classification results for batch {}-{}", i, end);
                continue;
            }

            // Process results
            for (Map<String, Object> result : results) {
                try {
                    int questionId = ((Number) result.get("questionId")).intValue();
                    String kpName = (String) result.get("kpName");
                    double weight = ((Number) result.getOrDefault("weight", 0.5)).doubleValue();
                    boolean isPrimary = (Boolean) result.getOrDefault("isPrimary", false);

                    // Find question from batch
                    Question q = batch.stream()
                            .filter(bq -> bq.getId().equals(questionId))
                            .findFirst().orElse(null);
                    if (q == null) continue;

                    // Find or fuzzy-match KP
                    String kpId = findKpId(kpName, allKPs);
                    if (kpId == null) {
                        log.debug("KP '{}' not found for question {}", kpName, questionId);
                        continue;
                    }

                    // Create QuestionRef node and TESTS relationship
                    boolean isProgramming = q.getIsProgramming() != null && q.getIsProgramming() == 1;
                    repository.upsertQuestionRef(q.getId(), q.getQuestion(), q.getType(), isProgramming);
                    repository.linkQuestionToKnowledgePoint(q.getId(), kpId, weight, isPrimary);
                    linked++;
                } catch (Exception e) {
                    log.error("Failed to link question: {}", e.getMessage());
                }
            }
        }

        log.info("Question linking complete. {} questions linked to knowledge points.", linked);
    }

    private String findKpId(String kpName, List<Map<String, Object>> allKPs) {
        // Exact match first
        for (Map<String, Object> kp : allKPs) {
            if (kpName.equals(kp.get("name"))) {
                return (String) kp.get("id");
            }
        }
        // Fuzzy: contains match
        for (Map<String, Object> kp : allKPs) {
            String name = (String) kp.get("name");
            if (name != null && (name.contains(kpName) || kpName.contains(name))) {
                return (String) kp.get("id");
            }
        }
        return null;
    }
}
