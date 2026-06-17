package com.labex.kg.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.labex.entity.Question;
import com.labex.entity.Student;
import com.labex.entity.StudentHomeworkQuestion;
import com.labex.entity.StudentQuestion;
import com.labex.entity.StudentTrainingQuestion;
import com.labex.kg.dto.StudentMasteryDTO;
import com.labex.kg.repository.KnowledgeGraphRepository;
import com.labex.mapper.StudentHomeworkQuestionMapper;
import com.labex.mapper.StudentMapper;
import com.labex.mapper.StudentQuestionMapper;
import com.labex.mapper.StudentTrainingQuestionMapper;
import com.labex.service.QuestionService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;

@Slf4j
@Service
public class StudentMasteryService {

    private static final double STRUGGLE_THRESHOLD = 0.70;
    private static final double STRONG_THRESHOLD = 0.85;

    @Autowired
    private StudentQuestionMapper studentQuestionMapper;
    @Autowired
    private StudentHomeworkQuestionMapper studentHomeworkQuestionMapper;
    @Autowired
    private StudentTrainingQuestionMapper studentTrainingQuestionMapper;
    @Autowired
    private StudentMapper studentMapper;
    @Autowired
    private QuestionService questionService;
    @Autowired
    private KnowledgeGraphRepository kgRepository;

    /** Calculate mastery for all students (nightly job). */
    @Scheduled(cron = "0 0 2 * * ?")
    public void nightlyMasteryRefresh() {
        log.info("Starting nightly student mastery refresh...");
        List<Student> allStudents = studentMapper.selectList(null);
        for (Student s : allStudents) {
            try {
                computeMastery(s.getStudentId(), s.getStudentName());
            } catch (Exception e) {
                log.error("Mastery refresh failed for student {}: {}", s.getStudentId(), e.getMessage());
            }
        }
        log.info("Nightly mastery refresh complete for {} students.", allStudents.size());
    }

    /** Compute mastery for a specific student and write Student->KnowledgePoint edges to Neo4j. */
    public void computeMastery(int studentId, String studentName) {
        String displayName = (studentName == null || studentName.isBlank()) ? "Student " + studentId : studentName;
        kgRepository.upsertStudent(studentId, displayName);
        kgRepository.removeMasteryEdges(studentId);

        List<AnswerEvidence> evidence = collectAnswerEvidence(studentId);
        if (evidence.isEmpty()) {
            log.debug("No graded answer data for student {}", studentId);
            return;
        }

        Set<Integer> questionIds = new HashSet<>();
        for (AnswerEvidence item : evidence) {
            questionIds.add(item.questionId());
        }

        Map<Integer, List<Map<String, Object>>> kpByQuestion = kgRepository.findKnowledgePointsByQuestionIds(questionIds);
        if (kpByQuestion.isEmpty()) {
            log.info("Student {} has graded answers, but no question-to-KP links are available.", studentId);
            return;
        }

        Map<String, KpAccumulator> accumulators = new LinkedHashMap<>();
        int mappedAnswers = 0;
        for (AnswerEvidence item : evidence) {
            List<Map<String, Object>> links = kpByQuestion.get(item.questionId());
            if (links == null || links.isEmpty()) {
                continue;
            }
            mappedAnswers++;
            for (Map<String, Object> link : links) {
                @SuppressWarnings("unchecked")
                Map<String, Object> kp = (Map<String, Object>) link.get("kp");
                if (kp == null || kp.get("id") == null) {
                    continue;
                }
                String kpId = Objects.toString(kp.get("id"));
                String kpName = Objects.toString(kp.get("name"), kpId);
                double weight = number(link.get("weight"), 1.0);
                KpAccumulator acc = accumulators.computeIfAbsent(kpId, id -> new KpAccumulator(kpId, kpName));
                acc.add(item.scoreRatio(), weight);
            }
        }

        if (accumulators.isEmpty()) {
            log.info("Student {} answer evidence was not mapped to any knowledge point.", studentId);
            return;
        }

        for (KpAccumulator acc : accumulators.values()) {
            double mastery = acc.mastery();
            kgRepository.setMastery(studentId, acc.kpId(), mastery, acc.attemptCount());
            if (mastery < STRUGGLE_THRESHOLD) {
                kgRepository.setStrugglesWith(studentId, acc.kpId(), 1.0 - mastery, acc.attemptCount());
            }
        }

        log.info("Student {} mastery refreshed: {} mapped answers, {} knowledge points.",
                studentId, mappedAnswers, accumulators.size());
    }

    /** Question IDs already attempted by a student. Used to prefer new recommendation items. */
    public Set<Integer> getAttemptedQuestionIds(int studentId) {
        Set<Integer> ids = new HashSet<>();
        for (AnswerEvidence evidence : collectAnswerEvidence(studentId)) {
            ids.add(evidence.questionId());
        }
        return ids;
    }

    /** Get mastery DTO for a student. */
    public StudentMasteryDTO getMastery(int studentId) {
        Map<String, Object> data = kgRepository.getStudentMastery(studentId);

        StudentMasteryDTO dto = new StudentMasteryDTO();
        dto.setOverallMastery(0.5);
        dto.setWeakPoints(new ArrayList<>());
        dto.setStrongPoints(new ArrayList<>());
        dto.setRadarData(new ArrayList<>());

        if (data == null) {
            return dto;
        }

        @SuppressWarnings("unchecked")
        List<Map<String, Object>> mastered = (List<Map<String, Object>>) data.get("mastered");
        @SuppressWarnings("unchecked")
        List<Map<String, Object>> weak = (List<Map<String, Object>>) data.get("weak");

        Map<String, StudentMasteryDTO.MasteryItem> byKp = new LinkedHashMap<>();

        if (mastered != null) {
            for (Map<String, Object> row : mastered) {
                @SuppressWarnings("unchecked")
                Map<String, Object> kp = (Map<String, Object>) row.get("kp");
                if (kp == null || kp.get("id") == null) {
                    continue;
                }
                String kpId = Objects.toString(kp.get("id"));
                StudentMasteryDTO.MasteryItem item = new StudentMasteryDTO.MasteryItem();
                item.setKpId(kpId);
                item.setKpName(Objects.toString(kp.get("name"), kpId));
                item.setMastery(clamp01(number(row.get("score"), 0.0)));
                item.setAttemptCount((int) number(row.get("attemptCount"), 0));
                item.setLastAttempted(formatTimestamp(row.get("lastUpdated")));
                byKp.put(kpId, item);
            }
        }

        if (weak != null) {
            for (Map<String, Object> row : weak) {
                @SuppressWarnings("unchecked")
                Map<String, Object> kp = (Map<String, Object>) row.get("kp");
                if (kp == null || kp.get("id") == null) {
                    continue;
                }
                String kpId = Objects.toString(kp.get("id"));
                StudentMasteryDTO.MasteryItem item = byKp.getOrDefault(kpId, new StudentMasteryDTO.MasteryItem());
                item.setKpId(kpId);
                item.setKpName(Objects.toString(kp.get("name"), kpId));
                item.setMastery(clamp01(1.0 - number(row.get("errorRate"), 0.0)));
                item.setAttemptCount(Math.max(item.getAttemptCount(), (int) number(row.get("attemptCount"), 0)));
                item.setLastAttempted(formatTimestamp(row.get("lastUpdated")));
                byKp.put(kpId, item);
            }
        }

        List<StudentMasteryDTO.MasteryItem> all = new ArrayList<>(byKp.values());
        all.sort(Comparator.comparingDouble(StudentMasteryDTO.MasteryItem::getMastery));

        double sum = 0.0;
        for (StudentMasteryDTO.MasteryItem item : all) {
            sum += item.getMastery();
            dto.getRadarData().add(new StudentMasteryDTO.RadarPoint(item.getKpName(), item.getMastery()));
            if (item.getMastery() < STRUGGLE_THRESHOLD) {
                dto.getWeakPoints().add(item);
            } else if (item.getMastery() >= STRONG_THRESHOLD) {
                dto.getStrongPoints().add(item);
            }
        }

        dto.setOverallMastery(all.isEmpty() ? 0.5 : sum / all.size());
        return dto;
    }

    private List<AnswerEvidence> collectAnswerEvidence(int studentId) {
        List<AnswerEvidence> evidence = new ArrayList<>();

        List<StudentQuestion> examAnswers = studentQuestionMapper.selectList(
                new QueryWrapper<StudentQuestion>().eq("student_id", studentId));
        for (StudentQuestion answer : examAnswers) {
            AnswerEvidence item = evidence(answer.getQuestionId(), answer.getIsCorrect(), answer.getScore());
            if (item != null) evidence.add(item);
        }

        List<StudentHomeworkQuestion> homeworkAnswers = studentHomeworkQuestionMapper.selectList(
                new QueryWrapper<StudentHomeworkQuestion>().eq("student_id", studentId));
        for (StudentHomeworkQuestion answer : homeworkAnswers) {
            AnswerEvidence item = evidence(answer.getQuestionId(), answer.getIsCorrect(), answer.getScore());
            if (item != null) evidence.add(item);
        }

        List<StudentTrainingQuestion> trainingAnswers = studentTrainingQuestionMapper.selectList(
                new QueryWrapper<StudentTrainingQuestion>().eq("student_id", studentId).isNotNull("score"));
        for (StudentTrainingQuestion answer : trainingAnswers) {
            AnswerEvidence item = evidence(answer.getQuestionId(), answer.getIsCorrect(), answer.getScore());
            if (item != null) evidence.add(item);
        }

        return evidence;
    }

    private AnswerEvidence evidence(Integer questionId, Integer isCorrect, Integer score) {
        if (questionId == null) {
            return null;
        }
        if (isCorrect != null) {
            return new AnswerEvidence(questionId, isCorrect == 1 ? 1.0 : scoreRatio(questionId, score));
        }
        if (score != null) {
            return new AnswerEvidence(questionId, scoreRatio(questionId, score));
        }
        return null;
    }

    private double scoreRatio(Integer questionId, Integer score) {
        if (score == null) {
            return 0.0;
        }
        int maxScore = 10;
        Question question = questionService.getById(questionId);
        if (question != null && question.getScore() != null && question.getScore() > 0) {
            maxScore = question.getScore();
        }
        return clamp01(score / (double) maxScore);
    }

    private double number(Object value, double fallback) {
        return value instanceof Number n ? n.doubleValue() : fallback;
    }

    private double clamp01(double value) {
        return Math.max(0.0, Math.min(1.0, value));
    }

    private String formatTimestamp(Object value) {
        if (!(value instanceof Number n)) {
            return null;
        }
        return String.valueOf(n.longValue());
    }

    private record AnswerEvidence(Integer questionId, double scoreRatio) {}

    private static class KpAccumulator {
        private final String kpId;
        private final String kpName;
        private double weightedScore;
        private double totalWeight;
        private int attemptCount;

        KpAccumulator(String kpId, String kpName) {
            this.kpId = kpId;
            this.kpName = kpName;
        }

        void add(double score, double weight) {
            double safeWeight = Math.max(0.05, weight);
            weightedScore += Math.max(0.0, Math.min(1.0, score)) * safeWeight;
            totalWeight += safeWeight;
            attemptCount++;
        }

        String kpId() {
            return kpId;
        }

        @SuppressWarnings("unused")
        String kpName() {
            return kpName;
        }

        int attemptCount() {
            return attemptCount;
        }

        double mastery() {
            return totalWeight <= 0 ? 0.0 : Math.max(0.0, Math.min(1.0, weightedScore / totalWeight));
        }
    }
}
