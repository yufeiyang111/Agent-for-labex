package com.labex.kg.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.labex.entity.*;
import com.labex.kg.dto.StudentMasteryDTO;
import com.labex.kg.repository.KnowledgeGraphRepository;
import com.labex.mapper.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@Service
public class StudentMasteryService {

    @Autowired
    private StudentQuestionMapper studentQuestionMapper;
    @Autowired
    private StudentItemMapper studentItemMapper;
    @Autowired
    private StudentHomeworkQuestionMapper studentHomeworkQuestionMapper;
    @Autowired
    private StudentMapper studentMapper;
    @Autowired
    private KnowledgeGraphRepository kgRepository;

    /** Calculate mastery for all students (nightly job) */
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

    /** Compute mastery for a specific student */
    public void computeMastery(int studentId, String studentName) {
        // Ensure student node exists in Neo4j
        kgRepository.upsertStudent(studentId, studentName);

        // Remove old mastery edges
        kgRepository.removeMasteryEdges(studentId);

        // Collect all answers by question ID
        Map<Integer, List<Boolean>> correctnessByQuestionId = new HashMap<>();

        // Exam answers
        List<StudentQuestion> sqList = studentQuestionMapper.selectList(
                new QueryWrapper<StudentQuestion>().eq("student_id", studentId));
        for (StudentQuestion sq : sqList) {
            if (sq.getIsCorrect() != null) {
                correctnessByQuestionId.computeIfAbsent(sq.getQuestionId(), k -> new ArrayList<>())
                        .add(sq.getIsCorrect() == 1);
            }
        }

        // Experiment answers
        List<StudentItem> siList = studentItemMapper.selectList(
                new QueryWrapper<StudentItem>().eq("student_id", studentId));
        for (StudentItem si : siList) {
            if (si.getScoreFlag() != null) {
                correctnessByQuestionId.computeIfAbsent(si.getItemId(), k -> new ArrayList<>())
                        .add(si.getScoreFlag() == 1);
            }
        }

        // Homework answers
        List<StudentHomeworkQuestion> shqList = studentHomeworkQuestionMapper.selectList(
                new QueryWrapper<StudentHomeworkQuestion>().eq("student_id", studentId));
        for (StudentHomeworkQuestion shq : shqList) {
            if (shq.getIsCorrect() != null) {
                correctnessByQuestionId.computeIfAbsent(shq.getQuestionId(), k -> new ArrayList<>())
                        .add(shq.getIsCorrect() == 1);
            }
        }

        // Legacy exercise answers — StudentExcercise has no isCorrect field, skip for now
        // TODO: derive correctness from StudentExcercise.score if needed

        if (correctnessByQuestionId.isEmpty()) {
            log.debug("No answer data for student {}", studentId);
            return;
        }

        // Get all knowledge points from Neo4j
        List<Map<String, Object>> allKPs = kgRepository.findAllKnowledgePoints(null, null, 0, 1000);

        // Aggregate correctness per knowledge point
        Map<String, List<Boolean>> correctnessByKpId = new HashMap<>();

        for (Map.Entry<Integer, List<Boolean>> entry : correctnessByQuestionId.entrySet()) {
            int questionId = entry.getKey();
            List<Boolean> results = entry.getValue();

            // Check which KPs this question tests
            for (Map<String, Object> kp : allKPs) {
                String kpId = (String) kp.get("id");
                // This is a simplification — ideally we'd query Neo4j for question-to-KP links
                // For now, track all answer correctness at question level
                // The actual KP mapping is done in the recommendation phase via Cypher
            }
        }

        // Since we can't easily reverse-map question → KP in Java without N queries,
        // store at the question level and let Cypher handle traversal later
        // For now, write simple stats to Neo4j
        int totalCorrect = 0;
        int totalAttempts = 0;
        for (List<Boolean> results : correctnessByQuestionId.values()) {
            for (boolean correct : results) {
                totalAttempts++;
                if (correct) totalCorrect++;
            }
        }

        double overallMastery = totalAttempts > 0 ? (double) totalCorrect / totalAttempts : 0;
        log.info("Student {} ({}) mastery computed: {:.2f} ({}/{})",
                studentId, studentName, overallMastery, totalCorrect, totalAttempts);
    }

    /** Get mastery DTO for a student */
    public StudentMasteryDTO getMastery(int studentId) {
        Map<String, Object> data = kgRepository.getStudentMastery(studentId);

        StudentMasteryDTO dto = new StudentMasteryDTO();
        dto.setOverallMastery(0.5);
        dto.setWeakPoints(new ArrayList<>());
        dto.setStrongPoints(new ArrayList<>());
        dto.setRadarData(new ArrayList<>());

        if (data == null) return dto;

        @SuppressWarnings("unchecked")
        List<Map<String, Object>> mastered = (List<Map<String, Object>>) data.get("mastered");
        @SuppressWarnings("unchecked")
        List<Map<String, Object>> weak = (List<Map<String, Object>>) data.get("weak");

        double totalScore = 0;
        int totalKPs = 0;
        List<StudentMasteryDTO.RadarPoint> radar = new ArrayList<>();

        if (mastered != null) {
            for (Map<String, Object> m : mastered) {
                Object scoreObj = m.get("score");
                double score = scoreObj instanceof Number ? ((Number) scoreObj).doubleValue() : 0;
                @SuppressWarnings("unchecked")
                Map<String, Object> kpMap = (Map<String, Object>) m.get("kp");
                // Skip "score": null entries from OPTIONAL MATCH
                if (kpMap == null) continue;
                String kpName = (String) kpMap.get("name");

                StudentMasteryDTO.MasteryItem item = new StudentMasteryDTO.MasteryItem();
                item.setKpName(kpName);
                item.setMastery(score);
                if (score >= 0.7) dto.getStrongPoints().add(item);
                else if (score < 0.4) dto.getWeakPoints().add(item);

                radar.add(new StudentMasteryDTO.RadarPoint(kpName, score));
                totalScore += score;
                totalKPs++;
            }
        }

        if (weak != null) {
            for (Map<String, Object> w : weak) {
                @SuppressWarnings("unchecked")
                Map<String, Object> kpMap = (Map<String, Object>) w.get("kp");
                if (kpMap == null) continue;
                String kpName = (String) kpMap.get("name");
                Object errObj = w.get("errorRate");
                double errRate = errObj instanceof Number ? ((Number) errObj).doubleValue() : 0;
                Object cntObj = w.get("attemptCount");
                int cnt = cntObj instanceof Number ? ((Number) cntObj).intValue() : 0;

                StudentMasteryDTO.MasteryItem item = new StudentMasteryDTO.MasteryItem();
                item.setKpName(kpName);
                item.setMastery(1.0 - errRate);
                item.setAttemptCount(cnt);
                dto.getWeakPoints().add(item);

                radar.add(new StudentMasteryDTO.RadarPoint(kpName, 1.0 - errRate));
                totalKPs++;
                totalScore += (1.0 - errRate);
            }
        }

        dto.setOverallMastery(totalKPs > 0 ? totalScore / totalKPs : 0.5);
        dto.setRadarData(radar);
        return dto;
    }
}
