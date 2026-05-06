package com.labex.controller.student;

import com.labex.common.Result;
import com.labex.entity.*;
import com.labex.service.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@RestController
@RequestMapping("/student/training")
public class StudentTrainingController {

    @Autowired
    private TrainingSetService trainingSetService;

    @Autowired
    private TrainingSetQuestionService trainingSetQuestionService;

    @Autowired
    private QuestionService questionService;

    @Autowired
    private StudentTrainingService studentTrainingService;

    @Autowired
    private StudentTrainingQuestionService studentTrainingQuestionService;

    private Integer getStudentId(Authentication auth) {
        return Integer.parseInt(auth.getName());
    }

    @GetMapping("/list")
    public Result<List<Map<String, Object>>> list() {
        List<TrainingSet> sets = trainingSetService.lambdaQuery()
                .eq(TrainingSet::getState, 1)
                .orderByDesc(TrainingSet::getCreateTime)
                .list();

        List<Map<String, Object>> result = sets.stream().map(ts -> {
            Map<String, Object> item = new HashMap<>();
            item.put("trainingSetId", ts.getTrainingSetId());
            item.put("name", ts.getName());
            item.put("description", ts.getDescription());
            item.put("totalScore", ts.getTotalScore());

            // Question count
            long qCount = trainingSetQuestionService.lambdaQuery()
                    .eq(TrainingSetQuestion::getTrainingSetId, ts.getTrainingSetId())
                    .count();
            item.put("questionCount", qCount);

            return item;
        }).collect(Collectors.toList());

        return Result.success(result);
    }

    @GetMapping("/{id}")
    public Result<Map<String, Object>> detail(@PathVariable Integer id) {
        TrainingSet ts = trainingSetService.getById(id);
        if (ts == null) return Result.error("训练集不存在");

        List<TrainingSetQuestion> links = trainingSetQuestionService.findByTrainingSetId(id);

        Map<String, Object> result = new HashMap<>();
        result.put("trainingSetId", ts.getTrainingSetId());
        result.put("name", ts.getName());
        result.put("description", ts.getDescription());
        result.put("totalScore", ts.getTotalScore());
        result.put("questionCount", links.size());

        return Result.success(result);
    }

    @GetMapping("/{id}/questions")
    public Result<List<Map<String, Object>>> getQuestions(@PathVariable Integer id) {
        List<TrainingSetQuestion> links = trainingSetQuestionService.findByTrainingSetId(id);
        List<Map<String, Object>> questions = links.stream().map(link -> {
            Question q = questionService.getById(link.getQuestionId());
            Map<String, Object> item = new HashMap<>();
            item.put("questionId", link.getQuestionId());
            item.put("score", link.getScore() != null ? link.getScore() : 10);
            if (q != null) {
                item.put("question", q.getQuestion());
                item.put("type", q.getType());
                item.put("typeName", q.getTypeName());
                item.put("options", q.getOptions());
                item.put("isProgramming", q.getIsProgramming());
                item.put("language", q.getLanguage());
                item.put("templateCode", q.getTemplateCode());
                item.put("ioMode", q.getIoMode());
                // Answer key NOT included here — shown after submission
            }
            return item;
        }).collect(Collectors.toList());

        return Result.success(questions);
    }

    @GetMapping("/{id}/my-records")
    public Result<List<Map<String, Object>>> myRecords(@PathVariable Integer id, Authentication auth) {
        Integer studentId = getStudentId(auth);
        List<StudentTraining> records = studentTrainingService.lambdaQuery()
                .eq(StudentTraining::getTrainingSetId, id)
                .eq(StudentTraining::getStudentId, studentId)
                .orderByDesc(StudentTraining::getSubmitTime)
                .list();

        List<Map<String, Object>> result = records.stream().map(rec -> {
            Map<String, Object> item = new HashMap<>();
            item.put("id", rec.getId());
            item.put("score", rec.getScore());
            item.put("totalScore", rec.getTotalScore());
            item.put("submitTime", rec.getSubmitTime());
            item.put("attemptCount", rec.getAttemptCount());
            return item;
        }).collect(Collectors.toList());

        return Result.success(result);
    }

    @PostMapping("/{id}/question/{questionId}/save")
    public Result<Void> saveAnswer(
            @PathVariable Integer id, @PathVariable Integer questionId,
            @RequestParam String myAnswer, Authentication auth) {
        Integer studentId = getStudentId(auth);

        // Find or create latest attempt
        StudentTraining attempt = findOrCreateAttempt(id, studentId);

        StudentTrainingQuestion stq = studentTrainingQuestionService.lambdaQuery()
                .eq(StudentTrainingQuestion::getTrainingSetId, id)
                .eq(StudentTrainingQuestion::getStudentId, studentId)
                .eq(StudentTrainingQuestion::getQuestionId, questionId)
                .eq(StudentTrainingQuestion::getAttemptId, attempt.getId())
                .one();

        if (stq == null) {
            stq = new StudentTrainingQuestion();
            stq.setTrainingSetId(id);
            stq.setStudentId(studentId);
            stq.setQuestionId(questionId);
            stq.setAttemptId(attempt.getId());
        }

        stq.setMyAnswer(myAnswer);
        stq.setSubmitTime(LocalDateTime.now());
        stq.setScore(null);  // Reset score until submit
        stq.setIsCorrect(0);

        if (stq.getId() == null) {
            studentTrainingQuestionService.save(stq);
        } else {
            studentTrainingQuestionService.updateById(stq);
        }

        return Result.success(null);
    }

    @PostMapping("/{id}/submit")
    public Result<Map<String, Object>> submit(@PathVariable Integer id, Authentication auth) {
        Integer studentId = getStudentId(auth);
        TrainingSet ts = trainingSetService.getById(id);
        if (ts == null) return Result.error("训练集不存在");

        List<TrainingSetQuestion> links = trainingSetQuestionService.findByTrainingSetId(id);
        StudentTraining attempt = findOrCreateAttempt(id, studentId);

        int totalScore = 0;
        int autoScore = 0;
        List<Map<String, Object>> questionResults = new ArrayList<>();

        for (TrainingSetQuestion link : links) {
            Question q = questionService.getById(link.getQuestionId());
            if (q == null) continue;

            int maxScore = link.getScore() != null ? link.getScore() :
                    (q.getScore() != null ? q.getScore() : 10);
            totalScore += maxScore;

            StudentTrainingQuestion answer = studentTrainingQuestionService.lambdaQuery()
                    .eq(StudentTrainingQuestion::getTrainingSetId, id)
                    .eq(StudentTrainingQuestion::getStudentId, studentId)
                    .eq(StudentTrainingQuestion::getQuestionId, q.getId())
                    .eq(StudentTrainingQuestion::getAttemptId, attempt.getId())
                    .one();

            String myAnswer = answer != null ? answer.getMyAnswer() : "";

            Map<String, Object> qr = new HashMap<>();
            qr.put("questionId", q.getId());
            qr.put("type", q.getType());
            qr.put("maxScore", maxScore);
            qr.put("myAnswer", myAnswer);
            qr.put("correctAnswer", q.getAnswer());
            qr.put("analysis", q.getAnalysis());
            qr.put("question", q.getQuestion());
            qr.put("options", q.getOptions());

            Integer score;
            String status;

            switch (q.getType() != null ? q.getType() : 0) {
                case 1, 2, 3, 4 -> {
                    score = gradeObjective(q, myAnswer, maxScore);
                    status = score == maxScore ? "CORRECT" : "WRONG";
                    autoScore += score;
                }
                case 5, 7 -> {
                    score = null;
                    status = "MANUAL_REFER";
                }
                case 6 -> {
                    score = 0;
                    status = "NEEDS_CODE_RUN";
                }
                default -> {
                    score = 0;
                    status = "WRONG";
                }
            }

            qr.put("score", score);
            qr.put("status", status);
            questionResults.add(qr);

            // Persist answer result
            if (answer == null) {
                answer = new StudentTrainingQuestion();
                answer.setTrainingSetId(id);
                answer.setStudentId(studentId);
                answer.setQuestionId(q.getId());
                answer.setAttemptId(attempt.getId());
                answer.setMyAnswer("");
            }
            answer.setScore(score);
            answer.setIsCorrect(score != null && score == maxScore ? 1 : 0);
            answer.setSubmitTime(LocalDateTime.now());
            if (answer.getId() == null) {
                studentTrainingQuestionService.save(answer);
            } else {
                studentTrainingQuestionService.updateById(answer);
            }
        }

        // Update attempt record
        attempt.setTotalScore(totalScore);
        attempt.setScore(autoScore);
        attempt.setSubmitTime(LocalDateTime.now());
        studentTrainingService.updateById(attempt);

        Map<String, Object> result = new HashMap<>();
        result.put("totalScore", totalScore);
        result.put("myScore", autoScore);
        result.put("attemptId", attempt.getId());
        result.put("attemptCount", attempt.getAttemptCount());
        result.put("questionResults", questionResults);

        return Result.success(result);
    }

    @PostMapping("/{id}/retry")
    public Result<Map<String, Object>> retry(@PathVariable Integer id, Authentication auth) {
        Integer studentId = getStudentId(auth);
        StudentTraining lastAttempt = studentTrainingService.lambdaQuery()
                .eq(StudentTraining::getTrainingSetId, id)
                .eq(StudentTraining::getStudentId, studentId)
                .orderByDesc(StudentTraining::getAttemptCount)
                .last("LIMIT 1")
                .one();

        StudentTraining newAttempt = new StudentTraining();
        newAttempt.setTrainingSetId(id);
        newAttempt.setStudentId(studentId);
        newAttempt.setAttemptCount(lastAttempt != null ? lastAttempt.getAttemptCount() + 1 : 1);
        newAttempt.setTotalScore(0);
        newAttempt.setScore(0);
        studentTrainingService.save(newAttempt);

        return Result.success(Map.of(
                "attemptId", newAttempt.getId(),
                "attemptCount", newAttempt.getAttemptCount()
        ));
    }

    @GetMapping("/{id}/result/{attemptId}")
    public Result<Map<String, Object>> getResult(
            @PathVariable Integer id, @PathVariable Integer attemptId) {
        StudentTraining attempt = studentTrainingService.getById(attemptId);
        if (attempt == null) return Result.error("记录不存在");

        List<StudentTrainingQuestion> answers = studentTrainingQuestionService.lambdaQuery()
                .eq(StudentTrainingQuestion::getAttemptId, attemptId)
                .list();

        List<Map<String, Object>> questionResults = answers.stream().map(a -> {
            Question q = questionService.getById(a.getQuestionId());
            Map<String, Object> item = new HashMap<>();
            item.put("questionId", a.getQuestionId());
            item.put("myAnswer", a.getMyAnswer());
            item.put("score", a.getScore());
            item.put("isCorrect", a.getIsCorrect());
            item.put("correctAnswer", q != null ? q.getAnswer() : "");
            item.put("analysis", q != null ? q.getAnalysis() : "");
            item.put("question", q != null ? q.getQuestion() : "");
            item.put("type", q != null ? q.getType() : null);
            item.put("options", q != null ? q.getOptions() : null);
            return item;
        }).collect(Collectors.toList());

        Map<String, Object> result = new HashMap<>();
        result.put("attemptId", attempt.getId());
        result.put("attemptCount", attempt.getAttemptCount());
        result.put("score", attempt.getScore());
        result.put("totalScore", attempt.getTotalScore());
        result.put("submitTime", attempt.getSubmitTime());
        result.put("questionResults", questionResults);

        return Result.success(result);
    }

    // ---- Private helpers ----

    private StudentTraining findOrCreateAttempt(Integer trainingSetId, Integer studentId) {
        StudentTraining latest = studentTrainingService.lambdaQuery()
                .eq(StudentTraining::getTrainingSetId, trainingSetId)
                .eq(StudentTraining::getStudentId, studentId)
                .orderByDesc(StudentTraining::getAttemptCount)
                .last("LIMIT 1")
                .one();

        if (latest != null) {
            // If the latest attempt has not been submitted (score is null), reuse it
            if (latest.getScore() == null || latest.getSubmitTime() == null) {
                return latest;
            }
        }

        // Create new attempt
        StudentTraining newAttempt = new StudentTraining();
        newAttempt.setTrainingSetId(trainingSetId);
        newAttempt.setStudentId(studentId);
        newAttempt.setAttemptCount(latest != null ? latest.getAttemptCount() + 1 : 1);
        studentTrainingService.save(newAttempt);
        return newAttempt;
    }

    private Integer gradeObjective(Question question, String myAnswer, int fullScore) {
        if (!StringUtils.hasText(question.getAnswer()) || !StringUtils.hasText(myAnswer)) {
            return 0;
        }
        String correct = normalize(question.getAnswer());
        String answer = normalize(myAnswer);

        // Multiple choice: compare sets (order independent)
        if (question.getType() != null && question.getType() == 3) {
            Set<String> correctSet = new HashSet<>(Arrays.asList(correct.split(",")));
            Set<String> answerSet = new HashSet<>(Arrays.asList(answer.split(",")));
            return correctSet.equals(answerSet) ? fullScore : 0;
        }

        // Fill-blank: partial credit per blank (order independent)
        if (correct.contains("|||") || answer.contains("|||")) {
            String[] correctParts = correct.split("\\|\\|\\|");
            String[] answerParts = answer.split("\\|\\|\\|");
            int correctCount = 0;
            int totalCount = correctParts.length;
            for (String c : correctParts) {
                String cNorm = normalize(c.trim());
                if (cNorm.isEmpty()) continue;
                for (String a : answerParts) {
                    String aNorm = normalize(a.trim());
                    if (aNorm.equals(cNorm)) {
                        correctCount++;
                        break;
                    }
                }
            }
            if (totalCount == 0) return 0;
            return (int) Math.round(fullScore * correctCount / (double) totalCount);
        }

        return correct.equals(answer) ? fullScore : 0;
    }

    private String normalize(String s) {
        if (s == null) return "";
        return s.trim()
                .replaceAll("\\s+", " ")
                .replaceAll("\\p{Punct}+", "")
                .toLowerCase();
    }
}
