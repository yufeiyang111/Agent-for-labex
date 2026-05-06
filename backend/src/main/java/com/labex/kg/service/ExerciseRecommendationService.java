package com.labex.kg.service;

import com.labex.entity.Question;
import com.labex.kg.dto.RecommendationResponse;
import com.labex.kg.repository.KnowledgeGraphRepository;
import com.labex.langchain4j.agent.RecommendationReasoner;
import com.labex.mapper.QuestionMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@Service
public class ExerciseRecommendationService {

    @Autowired
    private KnowledgeGraphRepository kgRepository;

    @Autowired
    private QuestionMapper questionMapper;

    @Autowired
    private RecommendationReasoner reasoner;

    private static final Map<Integer, String> TYPE_NAMES = Map.of(
            1, "填空题", 2, "单选题", 3, "多选题", 4, "判断题", 5, "解答题", 6, "编程题", 7, "综合题"
    );

    /** Recommend exercises based on student's weak knowledge points */
    public List<RecommendationResponse> recommendByWeakness(int studentId, int limit, boolean explain) {
        List<Map<String, Object>> results = kgRepository.recommendByWeakness(studentId, limit);

        return results.stream().map(item -> {
            @SuppressWarnings("unchecked")
            Map<String, Object> q = (Map<String, Object>) item.get("question");
            @SuppressWarnings("unchecked")
            Map<String, Object> kp = (Map<String, Object>) item.get("knowledgePoint");
            double errorRate = ((Number) item.get("errorRate")).doubleValue();

            int questionId = ((Number) q.get("questionId")).intValue();
            String kpName = (String) kp.get("name");

            RecommendationResponse resp = buildResponse(q, kpName);
            resp.setMasteryScore(1.0 - errorRate);

            if (explain) {
                String fullQuestionText = resp.getQuestion();
                int type = resp.getType();
                String explanation = reasoner.explain(kpName, fullQuestionText, type, 1.0 - errorRate, errorRate);
                resp.setReason(explanation);
            } else {
                resp.setReason(String.format("该知识点正确率仅为 %.0f%%，建议加强练习", (1.0 - errorRate) * 100));
            }

            return resp;
        }).collect(Collectors.toList());
    }

    /** Recommend exercises for a specific knowledge point */
    public List<RecommendationResponse> recommendByKnowledgePoint(String kpId, int limit) {
        List<Map<String, Object>> results = kgRepository.recommendByKnowledgePoint(kpId, limit);
        return results.stream().map(q -> buildResponse(q, null)).collect(Collectors.toList());
    }

    /** Find similar exercises to a given question */
    public List<RecommendationResponse> recommendSimilar(int questionId, int limit) {
        List<Map<String, Object>> results = kgRepository.recommendSimilar(questionId, limit);
        return results.stream().map(q -> buildResponse(q, null)).collect(Collectors.toList());
    }

    private RecommendationResponse buildResponse(Map<String, Object> q, String kpName) {
        int qid = ((Number) q.get("questionId")).intValue();
        int type = q.get("type") instanceof Number ? ((Number) q.get("type")).intValue() : 1;
        String text = (String) q.getOrDefault("questionText", "");

        return RecommendationResponse.builder()
                .questionId(qid)
                .question(text.length() > 100 ? text.substring(0, 100) + "..." : text)
                .type(type)
                .typeName(TYPE_NAMES.getOrDefault(type, "习题"))
                .knowledgePoint(kpName != null ? kpName : "")
                .build();
    }
}
