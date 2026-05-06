package com.labex.controller.student;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.labex.common.Result;
import com.labex.entity.*;
import com.labex.service.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * 学生模块控制器
 */
@RestController
@RequestMapping("/student")
@PreAuthorize("hasRole('STUDENT')")
@Slf4j
public class StudentController {

    @Autowired
    private ExperimentService experimentService;

    @Autowired
    private LectureService lectureService;

    @Autowired
    private ScoreService scoreService;

    @Autowired
    private StudentItemService studentItemService;

    @Autowired
    private StudentService studentService;

    @Autowired
    private ClazzService clazzService;

    @Autowired
    private StudentClazzService studentClazzService;

    @Autowired
    private ExamGradingService examGradingService;

    @Autowired
    private StudentQuestionService studentQuestionService;

    /**
     * 获取当前登录学生
     */
    private Student getCurrentStudent() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null) {
            return null;
        }
        String username = authentication.getName();
        return studentService.findByStudentNo(username);
    }

    /**
     * 获取当前登录学生关联的所有教师ID（可能多个）
     */
    private List<Integer> getTeacherIdsByCurrentStudent() {
        Student student = getCurrentStudent();
        if (student == null) {
            return new ArrayList<>();
        }
        List<StudentClazz> relations = studentClazzService.findByStudentId(student.getStudentId());
        return relations.stream()
                .map(StudentClazz::getTeacherId)
                .distinct()
                .collect(Collectors.toList());
    }

    /**
     * 获取可用的实验列表（所有关联教师布置的）
     */
    @GetMapping("/experiments")
    public Result<List<Experiment>> getExperiments() {
        List<Integer> teacherIds = getTeacherIdsByCurrentStudent();
        if (teacherIds.isEmpty()) {
            return Result.success(new ArrayList<>());
        }

        List<Experiment> experiments = experimentService.list(
                new LambdaQueryWrapper<Experiment>()
                        .eq(Experiment::getState, 1)
                        .in(Experiment::getTeacherId, teacherIds)
                        .orderByAsc(Experiment::getExperimentNo)
        );
        return Result.success(experiments);
    }

    /**
     * 根据实验ID获取题目
     */
    @GetMapping("/experiment/{experimentId}/items")
    public Result<Experiment> getExperimentItems(@PathVariable Integer experimentId) {
        List<Integer> teacherIds = getTeacherIdsByCurrentStudent();
        if (teacherIds.isEmpty()) {
            return Result.error("未找到所属教师");
        }

        Experiment experiment = experimentService.getById(experimentId);
        if (experiment == null) {
            return Result.error("实验不存在");
        }
        // 检查实验是否属于当前学生的教师
        if (!teacherIds.contains(experiment.getTeacherId())) {
            return Result.error("无权访问此实验");
        }
        if (experiment.getState() != 1) {
            return Result.error("实验未启用");
        }
        return Result.success(experiment);
    }

    /**
     * 获取学生答题进度
     */
    @GetMapping("/experiment/{experimentId}/progress")
    public Result<List<StudentItem>> getProgress(@PathVariable Integer experimentId) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null) {
            return Result.error("用户未登录");
        }
        String username = authentication.getName();
        Student student = studentService.findByStudentNo(username);
        if (student == null) {
            return Result.error("学生不存在");
        }

        List<StudentItem> items = studentItemService.list(
                new LambdaQueryWrapper<StudentItem>()
                        .eq(StudentItem::getStudentId, student.getStudentId())
        );

        return Result.success(items);
    }

    /**
     * 保存答案（自动保存）
     */
    @PostMapping("/experiment/{experimentId}/item/{itemId}/save")
    public Result<Void> saveAnswer(
            @PathVariable Integer experimentId,
            @PathVariable Integer itemId,
            @RequestParam String content) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null) {
            return Result.error("用户未登录");
        }
        String username = authentication.getName();
        Student student = studentService.findByStudentNo(username);
        if (student == null) {
            return Result.error("学生不存在");
        }

        StudentItem existing = studentItemService.getOne(
                new LambdaQueryWrapper<StudentItem>()
                        .eq(StudentItem::getStudentId, student.getStudentId())
                        .eq(StudentItem::getItemId, itemId)
        );

        StudentItem studentItem = new StudentItem();
        studentItem.setStudentId(student.getStudentId());
        studentItem.setItemId(itemId);
        studentItem.setContent(content);
        studentItem.setFillTime(LocalDateTime.now());

        if (existing != null) {
            studentItem.setStudentItemId(existing.getStudentItemId());
            studentItemService.updateById(studentItem);
        } else {
            studentItemService.save(studentItem);
        }

        log.info("学生{}保存答案: 实验{}, 题目{}", student.getStudentId(), experimentId, itemId);
        return Result.success("保存成功", null);
    }

    /**
     * 提交实验答案
     */
    @PostMapping("/experiment/{experimentId}/submit")
    public Result<Void> submitAnswer(
            @PathVariable Integer experimentId,
            @RequestBody List<StudentItem> answers) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null) {
            return Result.error("用户未登录");
        }
        String username = authentication.getName();
        Student student = studentService.findByStudentNo(username);
        if (student == null) {
            return Result.error("学生不存在");
        }

        for (StudentItem answer : answers) {
            answer.setStudentId(student.getStudentId());
            answer.setFillTime(LocalDateTime.now());

            StudentItem existing = studentItemService.getOne(
                    new LambdaQueryWrapper<StudentItem>()
                            .eq(StudentItem::getStudentId, student.getStudentId())
                            .eq(StudentItem::getItemId, answer.getItemId())
            );

            if (existing != null) {
                answer.setStudentItemId(existing.getStudentItemId());
                studentItemService.updateById(answer);
            } else {
                studentItemService.save(answer);
            }
        }

        log.info("学生{}提交实验答案: 实验{}", student.getStudentId(), experimentId);
        return Result.success("提交成功", null);
    }

    /**
     * 查询个人成绩
     */
    @GetMapping("/scores")
    public Result<List<Map<String, Object>>> getScores() {
        Student student = getCurrentStudent();
        if (student == null) {
            return Result.error("用户未登录");
        }

        List<Integer> teacherIds = getTeacherIdsByCurrentStudent();

        // 查询该学生的所有成绩
        List<Score> scoreList = scoreService.list(
                new LambdaQueryWrapper<Score>()
                        .eq(Score::getStudentId, student.getStudentId())
        );

        // 获取实验信息（只获取自己教师的实验）
        List<Map<String, Object>> result = new ArrayList<>();
        for (Score score : scoreList) {
            Experiment experiment = experimentService.getById(score.getExperimentId());
            // 如果没有获取到教师ID则允许查看（兼容旧数据）
            if (experiment != null && (teacherIds.isEmpty() || teacherIds.contains(experiment.getTeacherId()))) {
                Map<String, Object> item = new HashMap<>();
                item.put("experimentId", experiment.getExperimentId());
                item.put("experimentNo", experiment.getExperimentNo());
                item.put("experimentName", experiment.getExperimentName());
                item.put("score", score.getScore());
                result.add(item);
            }
        }

        return Result.success(result);
    }

    /**
     * 学习统计数据
     */
    @GetMapping("/stats")
    public Result<Map<String, Object>> getLearningStats() {
        Student student = getCurrentStudent();
        if (student == null) {
            return Result.error("用户未登录");
        }

        Integer studentId = student.getStudentId();

        List<Score> experimentScores = scoreService.list(
                new LambdaQueryWrapper<Score>()
                        .eq(Score::getStudentId, studentId)
        );

        Set<Integer> finishedExperimentIds = new HashSet<>();
        List<Integer> allScoreValues = new ArrayList<>();
        for (Score score : experimentScores) {
            if (score.getExperimentId() != null) {
                finishedExperimentIds.add(score.getExperimentId());
            }
            if (score.getScore() != null) {
                allScoreValues.add(score.getScore());
            }
        }

        List<ExamGrading> examGradings = examGradingService.list(
                new LambdaQueryWrapper<ExamGrading>()
                        .eq(ExamGrading::getStudentId, studentId)
        );
        int examCount = examGradings.size();
        for (ExamGrading grading : examGradings) {
            if (grading.getFinalScore() != null) {
                allScoreValues.add(grading.getFinalScore());
            }
        }

        List<StudentItem> studentItems = studentItemService.list(
                new LambdaQueryWrapper<StudentItem>()
                        .eq(StudentItem::getStudentId, studentId)
        );
        int experimentAnswerCount = 0;
        for (StudentItem item : studentItems) {
            if (item.getContent() != null && !item.getContent().trim().isEmpty()) {
                experimentAnswerCount++;
            }
        }

        List<StudentQuestion> studentQuestions = studentQuestionService.list(
                new LambdaQueryWrapper<StudentQuestion>()
                        .eq(StudentQuestion::getStudentId, studentId)
        );
        int examAnswerCount = 0;
        for (StudentQuestion question : studentQuestions) {
            if (question.getMyAnswer() != null && !question.getMyAnswer().trim().isEmpty()) {
                examAnswerCount++;
            }
        }

        int avgScore = 0;
        if (!allScoreValues.isEmpty()) {
            int sum = 0;
            for (Integer value : allScoreValues) {
                sum += value;
            }
            avgScore = Math.round((float) sum / allScoreValues.size());
        }

        Map<String, Object> stats = new HashMap<>();
        stats.put("experimentCount", finishedExperimentIds.size());
        stats.put("examCount", examCount);
        stats.put("questionCount", experimentAnswerCount + examAnswerCount);
        stats.put("avgScore", avgScore);
        return Result.success(stats);
    }

    /**
     * 获取讲义列表（所有关联教师布置的）
     */
    @GetMapping("/lectures")
    public Result<List<Lecture>> getLectures() {
        List<Integer> teacherIds = getTeacherIdsByCurrentStudent();
        if (teacherIds.isEmpty()) {
            return Result.success(new ArrayList<>());
        }

        List<Lecture> lectures = lectureService.list(
                new LambdaQueryWrapper<Lecture>()
                        .in(Lecture::getTeacherId, teacherIds)
        );
        return Result.success(lectures);
    }

    /**
     * 根据ID查询讲义
     */
    @GetMapping("/lecture/{id}")
    public Result<Lecture> getLecture(@PathVariable Integer id) {
        List<Integer> teacherIds = getTeacherIdsByCurrentStudent();
        if (teacherIds.isEmpty()) {
            return Result.error("未找到所属教师");
        }

        Lecture lecture = lectureService.getById(id);
        if (lecture == null) {
            return Result.error("讲义不存在");
        }
        // 检查讲义是否属于当前学生的教师
        if (!teacherIds.contains(lecture.getTeacherId())) {
            return Result.error("无权访问此讲义");
        }
        return Result.success(lecture);
    }
}
