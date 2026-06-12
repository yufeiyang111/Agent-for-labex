package com.labex.controller.teacher;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.labex.common.Result;
import com.labex.entity.*;
import com.labex.service.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 教师-考试批改控制器
 */
@RestController
@RequestMapping("/teacher/grading")
@PreAuthorize("hasRole('TEACHER')")
@Slf4j
public class TeacherGradingController {

    @Autowired
    private ExamService examService;

    @Autowired
    private ExamGradingService examGradingService;

    @Autowired
    private StudentQuestionService studentQuestionService;

    @Autowired
    private PaperService paperService;

    @Autowired
    private PaperQuestionService paperQuestionService;

    @Autowired
    private QuestionService questionService;

    @Autowired
    private StudentService studentService;

    @Autowired
    private TeacherService teacherService;

    @Autowired
    private ExamMonitorEventService examMonitorEventService;

    /**
     * 获取待批改的考试列表
     */
    @GetMapping("/pending-exams")
    public Result<List<Map<String, Object>>> getPendingExams() {
        Integer teacherId = getCurrentTeacherId();
        if (teacherId == null) {
            return Result.success(List.of());
        }

        List<Exam> exams = examService.list(
                new LambdaQueryWrapper<Exam>()
                        .eq(Exam::getTeacherId, teacherId)
                        .eq(Exam::getState, 1)
                        .orderByDesc(Exam::getTime)
        );

        List<Map<String, Object>> result = new ArrayList<>();
        for (Exam exam : exams) {
            Map<String, Object> examInfo = new HashMap<>();
            examInfo.put("id", exam.getId());
            examInfo.put("examName", exam.getExamName());
            examInfo.put("time", exam.getTime());
            examInfo.put("endTime", exam.getEndTime());

            // 统计需要人工批改的学生数
            List<ExamGrading> gradings = examGradingService.list(
                    new LambdaQueryWrapper<ExamGrading>()
                            .eq(ExamGrading::getExamId, exam.getId())
                            .eq(ExamGrading::getAutoGraded, true)
                            .eq(ExamGrading::getManualGraded, false)
            );
            examInfo.put("pendingCount", gradings.size());

            // 检查是否有简答题
            boolean hasManualQuestions = checkHasManualQuestions(exam.getPaperId());
            examInfo.put("hasManualQuestions", hasManualQuestions);

            result.add(examInfo);
        }

        return Result.success(result);
    }

    /**
     * 获取考试待批改学生列表
     */
    @GetMapping("/exam/{examId}/pending-students")
    public Result<List<Map<String, Object>>> getPendingStudents(@PathVariable Integer examId) {
        Exam exam = examService.getById(examId);
        if (exam == null) {
            return Result.error("考试不存在");
        }

        Integer teacherId = getCurrentTeacherId();
        if (!exam.getTeacherId().equals(teacherId)) {
            return Result.error("无权访问此考试");
        }

        // 获取已自动评分但需人工批改的学生
        List<ExamGrading> gradings = examGradingService.list(
                new LambdaQueryWrapper<ExamGrading>()
                        .eq(ExamGrading::getExamId, examId)
                        .eq(ExamGrading::getAutoGraded, true)
                        .eq(ExamGrading::getManualGraded, false)
        );

        List<Map<String, Object>> students = new ArrayList<>();
        for (ExamGrading grading : gradings) {
            Student student = studentService.getById(grading.getStudentId());
            if (student == null) continue;

            Map<String, Object> studentInfo = new HashMap<>();
            studentInfo.put("studentId", student.getStudentId());
            studentInfo.put("studentName", student.getStudentName());
            studentInfo.put("studentNo", student.getStudentNo());

            // 获取该学生的简答题答题信息
            List<Map<String, Object>> pendingQuestions = getStudentPendingQuestions(
                    examId, exam.getPaperId(), grading.getStudentId());
            studentInfo.put("pendingQuestions", pendingQuestions);
            studentInfo.put("pendingCount", pendingQuestions.size());

            // 已得分数（自动评分部分）
            int autoScore = studentQuestionService.list(
                    new LambdaQueryWrapper<StudentQuestion>()
                            .eq(StudentQuestion::getExamId, examId)
                            .eq(StudentQuestion::getStudentId, grading.getStudentId())
                            .eq(StudentQuestion::getGraded, Boolean.TRUE)
            ).stream()
                    .mapToInt(sq -> sq.getScore() != null ? sq.getScore() : 0)
                    .sum();
            studentInfo.put("autoScore", autoScore);

            students.add(studentInfo);
        }

        return Result.success(students);
    }

    /**
     * 获取考试已批改学生列表
     */
    @GetMapping("/exam/{examId}/graded-students")
    public Result<List<Map<String, Object>>> getGradedStudents(@PathVariable Integer examId) {
        Exam exam = examService.getById(examId);
        if (exam == null) {
            return Result.error("考试不存在");
        }

        Integer teacherId = getCurrentTeacherId();
        if (!exam.getTeacherId().equals(teacherId)) {
            return Result.error("无权访问此考试");
        }

        // 获取已完成人工批改的学生
        List<ExamGrading> gradings = examGradingService.list(
                new LambdaQueryWrapper<ExamGrading>()
                        .eq(ExamGrading::getExamId, examId)
                        .eq(ExamGrading::getManualGraded, true)
                        .orderByDesc(ExamGrading::getGradedAt)
        );

        List<Map<String, Object>> students = new ArrayList<>();
        for (ExamGrading grading : gradings) {
            Student student = studentService.getById(grading.getStudentId());
            if (student == null) continue;

            Map<String, Object> studentInfo = new HashMap<>();
            studentInfo.put("studentId", student.getStudentId());
            studentInfo.put("studentName", student.getStudentName());
            studentInfo.put("studentNo", student.getStudentNo());
            studentInfo.put("finalScore", grading.getFinalScore() != null ? grading.getFinalScore() : 0);
            studentInfo.put("gradedAt", grading.getGradedAt());

            students.add(studentInfo);
        }

        return Result.success(students);
    }

    /**
     * 获取学生答题详情（用于批改）
     */
    @GetMapping("/exam/{examId}/student/{studentId}/questions")
    public Result<Map<String, Object>> getStudentQuestionsForGrading(
            @PathVariable Integer examId,
            @PathVariable Integer studentId) {

        Exam exam = examService.getById(examId);
        if (exam == null) {
            return Result.error("考试不存在");
        }

        Map<String, Object> result = new HashMap<>();
        result.put("examId", examId);
        result.put("examName", exam.getExamName());

        Student student = studentService.getById(studentId);
        if (student == null) {
            return Result.error("学生不存在");
        }
        result.put("studentId", studentId);
        result.put("studentName", student.getStudentName());

        // 获取简答题列表
        List<Question> shortAnswerQuestions = getManualGradingQuestions(exam.getPaperId());

        List<Map<String, Object>> questionsWithAnswers = new ArrayList<>();
        for (Question q : shortAnswerQuestions) {
            StudentQuestion sq = studentQuestionService.getOne(
                    new LambdaQueryWrapper<StudentQuestion>()
                            .eq(StudentQuestion::getExamId, examId)
                            .eq(StudentQuestion::getStudentId, studentId)
                            .eq(StudentQuestion::getQuestionId, q.getId())
            );

            Map<String, Object> qInfo = new HashMap<>();
            qInfo.put("questionId", q.getId());
            qInfo.put("questionContent", q.getQuestion());
            qInfo.put("fullScore", q.getScore());
            qInfo.put("studentAnswer", sq != null ? sq.getMyAnswer() : "");
            qInfo.put("currentScore", sq != null ? sq.getScore() : 0);
            qInfo.put("graded", sq != null && sq.getGraded());

            questionsWithAnswers.add(qInfo);
        }

        result.put("questions", questionsWithAnswers);
        return Result.success(result);
    }

    /**
     * 批改单道题目
     */
    @PutMapping("/exam/{examId}/student/{studentId}/question/{questionId}")
    @Transactional(rollbackFor = Exception.class)
    public Result<Void> gradeQuestion(
            @PathVariable Integer examId,
            @PathVariable Integer studentId,
            @PathVariable Integer questionId,
            @RequestParam Integer score) {

        StudentQuestion sq = studentQuestionService.getOne(
                new LambdaQueryWrapper<StudentQuestion>()
                        .eq(StudentQuestion::getExamId, examId)
                        .eq(StudentQuestion::getStudentId, studentId)
                        .eq(StudentQuestion::getQuestionId, questionId)
        );

        if (sq != null) {
            sq.setScore(score);
            sq.setIsCorrect(score > 0 ? 1 : 0);
            sq.setGraded(true);
            studentQuestionService.updateById(sq);
        }

        // 检查是否所有简答题都已批改完成
        checkAndCompleteGrading(examId, studentId);

        return Result.success("批改成功", null);
    }

    /**
     * 批量提交批改成绩
     */
    @PostMapping("/exam/{examId}/student/{studentId}/submit-grades")
    @Transactional(rollbackFor = Exception.class)
    public Result<Map<String, Object>> submitAllGrades(
            @PathVariable Integer examId,
            @PathVariable Integer studentId,
            @RequestBody List<Map<String, Object>> grades) {

        for (Map<String, Object> g : grades) {
            Integer questionId = (Integer) g.get("questionId");
            Integer score = (Integer) g.get("score");

            StudentQuestion sq = studentQuestionService.getOne(
                    new LambdaQueryWrapper<StudentQuestion>()
                            .eq(StudentQuestion::getExamId, examId)
                            .eq(StudentQuestion::getStudentId, studentId)
                            .eq(StudentQuestion::getQuestionId, questionId)
            );

            if (sq != null) {
                sq.setScore(score);
                sq.setIsCorrect(score > 0 ? 1 : 0);
                sq.setGraded(true);
                studentQuestionService.updateById(sq);
            }
        }

        // 完成人工批改，计算最终成绩
        ExamGrading grading = examGradingService.getOrCreate(examId, studentId);
        grading.setManualGraded(true);
        grading.setGradedAt(LocalDateTime.now());

        // 计算总分
        List<StudentQuestion> allAnswers = studentQuestionService.list(
                new LambdaQueryWrapper<StudentQuestion>()
                        .eq(StudentQuestion::getExamId, examId)
                        .eq(StudentQuestion::getStudentId, studentId)
        );

        int totalScore = allAnswers.stream()
                .filter(a -> a.getScore() != null && a.getGraded())
                .mapToInt(StudentQuestion::getScore)
                .sum();

        grading.setFinalScore(totalScore);
        examGradingService.updateById(grading);

        log.info("教师批改考试{}学生{}完成，最终得分{}", examId, studentId, totalScore);

        Map<String, Object> result = new HashMap<>();
        result.put("finalScore", totalScore);
        return Result.success(result);
    }

    /**
     * 获取学生最终成绩
     */
    @GetMapping("/exam/{examId}/student/{studentId}/score")
    public Result<Map<String, Object>> getStudentScore(
            @PathVariable Integer examId,
            @PathVariable Integer studentId) {

        ExamGrading grading = examGradingService.findByExamAndStudent(examId, studentId);

        Map<String, Object> result = new HashMap<>();
        if (grading != null) {
            result.put("finalScore", grading.getFinalScore());
            result.put("autoGraded", grading.getAutoGraded());
            result.put("manualGraded", grading.getManualGraded());
            result.put("gradedAt", grading.getGradedAt());
        } else {
            result.put("finalScore", null);
            result.put("autoGraded", false);
            result.put("manualGraded", false);
        }

        return Result.success(result);
    }

    /**
     * 获取考试监考异常记录
     */
    @GetMapping("/exam/{examId}/invigilation-events")
    public Result<Map<String, Object>> getInvigilationEvents(@PathVariable Integer examId) {
        Exam exam = examService.getById(examId);
        if (exam == null) {
            return Result.error("鑰冭瘯涓嶅瓨鍦?");
        }

        Integer teacherId = getCurrentTeacherId();
        if (teacherId == null || !teacherId.equals(exam.getTeacherId())) {
            return Result.error("鏃犳潈璁块棶姝よ€冭瘯");
        }

        List<ExamMonitorEvent> events = examMonitorEventService.list(
                new LambdaQueryWrapper<ExamMonitorEvent>()
                        .eq(ExamMonitorEvent::getExamId, examId)
                        .orderByDesc(ExamMonitorEvent::getOccurredAt)
                        .last("LIMIT 500")
        );

        Set<Integer> studentIds = events.stream()
                .map(ExamMonitorEvent::getStudentId)
                .filter(Objects::nonNull)
                .collect(Collectors.toSet());

        Map<Integer, Student> studentMap = studentIds.isEmpty() ? Map.of() :
                studentService.listByIds(studentIds).stream()
                        .collect(Collectors.toMap(Student::getStudentId, s -> s, (a, b) -> a));

        List<Map<String, Object>> eventRows = new ArrayList<>();
        for (ExamMonitorEvent event : events) {
            Student student = studentMap.get(event.getStudentId());
            Map<String, Object> row = new HashMap<>();
            row.put("id", event.getId());
            row.put("studentId", event.getStudentId());
            row.put("studentName", student != null ? student.getStudentName() : "-");
            row.put("studentNo", student != null ? student.getStudentNo() : "-");
            row.put("eventType", event.getEventType());
            row.put("eventDesc", event.getEventDesc());
            row.put("pageUrl", event.getPageUrl());
            row.put("ip", event.getIp());
            row.put("occurredAt", event.getOccurredAt());
            eventRows.add(row);
        }

        Map<Integer, List<ExamMonitorEvent>> groupedByStudent = events.stream()
                .filter(e -> e.getStudentId() != null)
                .collect(Collectors.groupingBy(ExamMonitorEvent::getStudentId));

        List<Map<String, Object>> studentSummary = new ArrayList<>();
        for (Map.Entry<Integer, List<ExamMonitorEvent>> entry : groupedByStudent.entrySet()) {
            Integer studentId = entry.getKey();
            List<ExamMonitorEvent> studentEvents = entry.getValue();
            Student student = studentMap.get(studentId);

            LocalDateTime latestAt = studentEvents.stream()
                    .map(ExamMonitorEvent::getOccurredAt)
                    .filter(Objects::nonNull)
                    .max(LocalDateTime::compareTo)
                    .orElse(null);

            Map<String, Object> summary = new HashMap<>();
            summary.put("studentId", studentId);
            summary.put("studentName", student != null ? student.getStudentName() : "-");
            summary.put("studentNo", student != null ? student.getStudentNo() : "-");
            summary.put("warningCount", studentEvents.size());
            summary.put("latestAt", latestAt);
            studentSummary.add(summary);
        }

        studentSummary.sort((a, b) -> Integer.compare(
                ((Number) b.get("warningCount")).intValue(),
                ((Number) a.get("warningCount")).intValue()
        ));

        LocalDateTime latestAt = events.stream()
                .map(ExamMonitorEvent::getOccurredAt)
                .filter(Objects::nonNull)
                .max(LocalDateTime::compareTo)
                .orElse(null);

        Map<String, Object> result = new HashMap<>();
        result.put("totalEvents", events.size());
        result.put("affectedStudents", studentSummary.size());
        result.put("latestAt", latestAt);
        result.put("studentSummary", studentSummary);
        result.put("events", eventRows);
        return Result.success(result);
    }

    // ==================== 私有方法 ====================

    private Integer getCurrentTeacherId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !StringUtils.hasText(authentication.getName())) {
            return null;
        }
        Teacher teacher = teacherService.findByAccount(authentication.getName());
        return teacher != null ? teacher.getTeacherId() : null;
    }

    private boolean checkHasManualQuestions(Integer paperId) {
        if (paperId == null) return false;

        List<PaperQuestion> pqs = paperQuestionService.findByPaperId(paperId);
        for (PaperQuestion pq : pqs) {
            Question q = questionService.getById(pq.getQuestionId());
            if (q != null && q.getType() == 5) { // 简答题
                return true;
            }
        }
        return false;
    }

    private List<Question> getManualGradingQuestions(Integer paperId) {
        if (paperId == null) return List.of();

        List<PaperQuestion> pqs = paperQuestionService.findByPaperId(paperId);
        return pqs.stream()
                .map(pq -> questionService.getById(pq.getQuestionId()))
                .filter(q -> q != null && q.getType() == 5) // 简答题
                .collect(Collectors.toList());
    }

    private List<Map<String, Object>> getStudentPendingQuestions(Integer examId, Integer paperId, Integer studentId) {
        List<Question> questions = getManualGradingQuestions(paperId);
        List<Map<String, Object>> result = new ArrayList<>();

        for (Question q : questions) {
            StudentQuestion sq = studentQuestionService.getOne(
                    new LambdaQueryWrapper<StudentQuestion>()
                            .eq(StudentQuestion::getExamId, examId)
                            .eq(StudentQuestion::getStudentId, studentId)
                            .eq(StudentQuestion::getQuestionId, q.getId())
            );

            if (sq == null || !Boolean.TRUE.equals(sq.getGraded())) {
                Map<String, Object> info = new HashMap<>();
                info.put("questionId", q.getId());
                info.put("questionContent", q.getQuestion());
                info.put("fullScore", q.getScore());
                result.add(info);
            }
        }

        return result;
    }

    private void checkAndCompleteGrading(Integer examId, Integer studentId) {
        // 检查是否所有简答题都已批改
        Exam exam = examService.getById(examId);
        if (exam == null || exam.getPaperId() == null) return;

        List<Question> manualQuestions = getManualGradingQuestions(exam.getPaperId());
        boolean allGraded = true;

        for (Question q : manualQuestions) {
            StudentQuestion sq = studentQuestionService.getOne(
                    new LambdaQueryWrapper<StudentQuestion>()
                            .eq(StudentQuestion::getExamId, examId)
                            .eq(StudentQuestion::getStudentId, studentId)
                            .eq(StudentQuestion::getQuestionId, q.getId())
            );
            if (sq == null || !Boolean.TRUE.equals(sq.getGraded())) {
                allGraded = false;
                break;
            }
        }

        if (allGraded) {
            ExamGrading grading = examGradingService.getOrCreate(examId, studentId);
            grading.setManualGraded(true);
            grading.setGradedAt(LocalDateTime.now());

            // 计算总分
            List<StudentQuestion> allAnswers = studentQuestionService.list(
                    new LambdaQueryWrapper<StudentQuestion>()
                            .eq(StudentQuestion::getExamId, examId)
                            .eq(StudentQuestion::getStudentId, studentId)
            );

            int totalScore = allAnswers.stream()
                    .filter(a -> a.getScore() != null && a.getGraded())
                    .mapToInt(StudentQuestion::getScore)
                    .sum();

            grading.setFinalScore(totalScore);
            examGradingService.updateById(grading);
        }
    }
}
