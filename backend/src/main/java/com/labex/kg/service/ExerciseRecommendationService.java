package com.labex.kg.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.labex.entity.Question;
import com.labex.entity.Student;
import com.labex.entity.TrainingSet;
import com.labex.entity.TrainingSetQuestion;
import com.labex.kg.dto.RecommendationRequest;
import com.labex.kg.dto.RecommendationResponse;
import com.labex.kg.repository.KnowledgeGraphRepository;
import com.labex.langchain4j.agent.RecommendationReasoner;
import com.labex.mapper.QuestionMapper;
import com.labex.mapper.StudentMapper;
import com.labex.service.TrainingSetQuestionService;
import com.labex.service.TrainingSetService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;

@Slf4j
@Service
public class ExerciseRecommendationService {

    private static final String PERSONAL_SOURCE = "kg_recommendation";
    private static final Map<Integer, String> TYPE_NAMES = Map.of(
            1, "填空题",
            2, "单选题",
            3, "多选题",
            4, "判断题",
            5, "简答题",
            6, "编程题",
            7, "综合题"
    );

    @Autowired
    private KnowledgeGraphRepository kgRepository;
    @Autowired
    private QuestionMapper questionMapper;
    @Autowired
    private StudentMapper studentMapper;
    @Autowired
    private RecommendationReasoner reasoner;
    @Autowired
    private StudentMasteryService masteryService;
    @Autowired
    private TrainingSetService trainingSetService;
    @Autowired
    private TrainingSetQuestionService trainingSetQuestionService;

    /** Recommend exercises based on student's weak knowledge points. */
    public List<RecommendationResponse> recommendByWeakness(int studentId, int limit, boolean explain) {
        int safeLimit = clampLimit(limit);
        refreshMastery(studentId);

        Set<Integer> attemptedQuestionIds = masteryService.getAttemptedQuestionIds(studentId);
        List<Map<String, Object>> rows = new ArrayList<>();
        rows.addAll(safeKgRows(() -> kgRepository.recommendByWeakness(studentId, safeLimit * 3, attemptedQuestionIds)));

        if (rows.size() < safeLimit) {
            rows.addAll(safeKgRows(() -> kgRepository.recommendByLowMastery(studentId, safeLimit * 3, attemptedQuestionIds)));
        }
        if (rows.size() < safeLimit) {
            rows.addAll(safeKgRows(() -> kgRepository.recommendGeneral(safeLimit * 3, attemptedQuestionIds)));
        }
        if (rows.size() < safeLimit) {
            rows.addAll(safeKgRows(() -> kgRepository.recommendGeneral(safeLimit * 3, Collections.emptySet())));
        }

        List<RecommendationResponse> responses = buildResponses(rows, safeLimit, explain, "kg");
        if (!responses.isEmpty()) {
            return responses;
        }
        return fallbackQuestionBank(safeLimit);
    }

    /** Recommend exercises for a specific knowledge point. */
    public List<RecommendationResponse> recommendByKnowledgePoint(String kpId, int limit) {
        int safeLimit = clampLimit(limit);
        List<Map<String, Object>> results = safeKgRows(() -> kgRepository.recommendByKnowledgePoint(kpId, safeLimit));
        return buildQuestionOnlyResponses(results, safeLimit, "knowledge-point");
    }

    /** Find similar exercises to a given question. */
    public List<RecommendationResponse> recommendSimilar(int questionId, int limit) {
        int safeLimit = clampLimit(limit);
        List<Map<String, Object>> results = safeKgRows(() -> kgRepository.recommendSimilar(questionId, safeLimit));
        return buildQuestionOnlyResponses(results, safeLimit, "similar");
    }

    /** Create or refresh a personal training set from the current recommendation result. */
    @Transactional(rollbackFor = Exception.class)
    public Map<String, Object> createPersonalPracticeSet(int studentId, RecommendationRequest request) {
        RecommendationRequest req = request == null ? new RecommendationRequest() : request;
        int safeLimit = clampLimit(req.getLimit() <= 0 ? 10 : req.getLimit());

        LinkedHashSet<Integer> questionIds = new LinkedHashSet<>();
        if (req.getQuestionIds() != null) {
            for (Integer id : req.getQuestionIds()) {
                if (id != null && id > 0) {
                    questionIds.add(id);
                }
            }
        }
        if (questionIds.isEmpty()) {
            for (RecommendationResponse item : recommendByWeakness(studentId, safeLimit, false)) {
                if (item.getQuestionId() != null) {
                    questionIds.add(item.getQuestionId());
                }
            }
        }
        if (questionIds.isEmpty()) {
            throw new IllegalStateException("暂无可用于生成训练集的推荐题目，请先在知识图谱中完成题目-知识点关联。");
        }

        TrainingSet set = trainingSetService.lambdaQuery()
                .eq(TrainingSet::getOwnerStudentId, studentId)
                .eq(TrainingSet::getSource, PERSONAL_SOURCE)
                .last("LIMIT 1")
                .one();
        if (set == null) {
            set = new TrainingSet();
            set.setName("我的薄弱点强化训练");
            set.setDescription("由知识图谱根据当前掌握度自动生成，可重复刷新。");
            set.setTeacherId(0);
            set.setOwnerStudentId(studentId);
            set.setSource(PERSONAL_SOURCE);
            set.setState(1);
            set.setCreateTime(LocalDateTime.now());
            trainingSetService.save(set);
        } else {
            set.setName("我的薄弱点强化训练");
            set.setDescription("由知识图谱根据当前掌握度自动生成，可重复刷新。");
            set.setState(1);
            trainingSetService.updateById(set);
        }

        if (req.isRefresh()) {
            trainingSetQuestionService.removeQuestions(set.getTrainingSetId());
        }
        trainingSetQuestionService.saveQuestions(set.getTrainingSetId(), new ArrayList<>(questionIds));

        List<TrainingSetQuestion> links = trainingSetQuestionService.findByTrainingSetId(set.getTrainingSetId());
        int totalScore = links.stream().mapToInt(q -> q.getScore() != null ? q.getScore() : 10).sum();
        set.setTotalScore(totalScore);
        trainingSetService.updateById(set);

        Map<String, Object> result = new LinkedHashMap<>();
        result.put("trainingSetId", set.getTrainingSetId());
        result.put("name", set.getName());
        result.put("questionCount", links.size());
        result.put("totalScore", totalScore);
        result.put("questionIds", links.stream().map(TrainingSetQuestion::getQuestionId).toList());
        result.put("practiceUrl", "/student/training/" + set.getTrainingSetId() + "/practice");
        return result;
    }

    private void refreshMastery(int studentId) {
        try {
            Student student = studentMapper.selectById(studentId);
            masteryService.computeMastery(studentId, student == null ? "Student " + studentId : student.getStudentName());
        } catch (Exception e) {
            log.warn("Refresh mastery failed before recommendation for student {}: {}", studentId, e.getMessage());
        }
    }

    private List<RecommendationResponse> buildResponses(List<Map<String, Object>> rows, int limit, boolean explain, String source) {
        LinkedHashMap<Integer, RecommendationResponse> dedup = new LinkedHashMap<>();
        for (Map<String, Object> row : rows) {
            @SuppressWarnings("unchecked")
            Map<String, Object> q = (Map<String, Object>) row.get("question");
            @SuppressWarnings("unchecked")
            Map<String, Object> kp = (Map<String, Object>) row.get("knowledgePoint");
            if (q == null || q.get("questionId") == null) {
                continue;
            }
            int questionId = ((Number) q.get("questionId")).intValue();
            if (dedup.containsKey(questionId)) {
                continue;
            }
            double errorRate = number(row.get("errorRate"), 0.5);
            int attemptCount = (int) number(row.get("attemptCount"), 0);
            double priority = number(row.get("priority"), errorRate);
            RecommendationResponse response = buildResponse(q, kp, source);
            response.setMasteryScore(clamp01(1.0 - errorRate));
            response.setPriority(priority);
            response.setAttemptCount(attemptCount);
            response.setReason(buildReason(response, errorRate, attemptCount, explain));
            dedup.put(questionId, response);
            if (dedup.size() >= limit) {
                break;
            }
        }
        return new ArrayList<>(dedup.values());
    }

    private List<RecommendationResponse> buildQuestionOnlyResponses(List<Map<String, Object>> rows, int limit, String source) {
        List<Map<String, Object>> normalized = new ArrayList<>();
        for (Map<String, Object> row : rows) {
            Map<String, Object> wrapper = new LinkedHashMap<>();
            wrapper.put("question", row.containsKey("question") ? row.get("question") : row);
            wrapper.put("source", source);
            normalized.add(wrapper);
        }
        return buildResponses(normalized, limit, false, source);
    }

    private RecommendationResponse buildResponse(Map<String, Object> q, Map<String, Object> kp, String source) {
        int qid = ((Number) q.get("questionId")).intValue();
        Question dbQuestion = questionMapper.selectById(qid);
        int type = dbQuestion != null && dbQuestion.getType() != null
                ? dbQuestion.getType()
                : q.get("type") instanceof Number ? ((Number) q.get("type")).intValue() : 1;
        String text = dbQuestion != null && dbQuestion.getQuestion() != null
                ? dbQuestion.getQuestion()
                : Objects.toString(q.getOrDefault("questionText", ""), "");

        RecommendationResponse response = RecommendationResponse.builder()
                .questionId(qid)
                .question(text)
                .type(type)
                .typeName(TYPE_NAMES.getOrDefault(type, "习题"))
                .difficulty(estimateDifficulty(dbQuestion))
                .source(source)
                .actionText("加入强化训练")
                .build();
        if (kp != null) {
            response.setKnowledgePointId(Objects.toString(kp.get("id"), ""));
            response.setKnowledgePoint(Objects.toString(kp.get("name"), ""));
        }
        return response;
    }

    private String buildReason(RecommendationResponse response, double errorRate, int attemptCount, boolean explain) {
        String kpName = response.getKnowledgePoint() == null || response.getKnowledgePoint().isBlank()
                ? "相关知识点"
                : response.getKnowledgePoint();
        String fallback = String.format("%s 掌握度约 %.0f%%，已累计 %d 次相关作答，建议优先巩固。",
                kpName, response.getMasteryScore() * 100, attemptCount);
        if (!explain) {
            return fallback;
        }
        try {
            String explanation = reasoner.explain(kpName, response.getQuestion(), response.getType(), response.getMasteryScore(), errorRate);
            return explanation == null || explanation.isBlank() ? fallback : explanation;
        } catch (Exception e) {
            log.warn("Recommendation explanation failed for question {}: {}", response.getQuestionId(), e.getMessage());
            return fallback;
        }
    }

    private List<RecommendationResponse> fallbackQuestionBank(int limit) {
        List<Question> questions = questionMapper.selectList(new QueryWrapper<Question>()
                .eq("state", 1)
                .orderByDesc("id")
                .last("LIMIT " + limit));
        List<RecommendationResponse> result = new ArrayList<>();
        for (Question q : questions) {
            RecommendationResponse response = RecommendationResponse.builder()
                    .questionId(q.getId())
                    .question(q.getQuestion())
                    .type(q.getType() == null ? 1 : q.getType())
                    .typeName(TYPE_NAMES.getOrDefault(q.getType(), "习题"))
                    .knowledgePoint("")
                    .masteryScore(0.5)
                    .difficulty(estimateDifficulty(q))
                    .source("question-bank-fallback")
                    .reason("知识图谱暂无可用推荐链路，先提供题库练习；请在教师端完成题目与知识点关联以启用精准推荐。")
                    .actionText("加入训练")
                    .build();
            result.add(response);
        }
        return result;
    }

    private double estimateDifficulty(Question question) {
        if (question == null || question.getScore() == null) {
            return 0.5;
        }
        return clamp01(question.getScore() / 20.0);
    }

    private List<Map<String, Object>> safeKgRows(KgSupplier supplier) {
        try {
            return supplier.get();
        } catch (Exception e) {
            log.warn("KG recommendation query failed: {}", e.getMessage());
            return List.of();
        }
    }

    private int clampLimit(int limit) {
        return Math.max(1, Math.min(limit <= 0 ? 10 : limit, 30));
    }

    private double number(Object value, double fallback) {
        return value instanceof Number n ? n.doubleValue() : fallback;
    }

    private double clamp01(double value) {
        return Math.max(0.0, Math.min(1.0, value));
    }

    @FunctionalInterface
    private interface KgSupplier {
        List<Map<String, Object>> get();
    }
}
