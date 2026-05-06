package com.labex.controller.teacher;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.labex.common.PageResult;
import com.labex.common.Result;
import com.labex.entity.ExperimentItem;
import com.labex.entity.Score;
import com.labex.entity.Student;
import com.labex.entity.StudentItem;
import com.labex.service.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 教师-成绩管理控制器
 */
@RestController
@RequestMapping("/teacher/score")
@PreAuthorize("hasRole('TEACHER')")
@Slf4j
public class ScoreController {

    @Autowired
    private StudentItemService studentItemService;

    @Autowired
    private ExperimentItemService experimentItemService;

    @Autowired
    private StudentService studentService;

    @Autowired
    private ScoreService scoreService;

    @Autowired
    private ExperimentService experimentService;

    /**
     * 根据实验查询学生答题列表
     */
    @GetMapping("/experiment/{experimentId}/students")
    public Result<Map<String, Object>> getStudentAnswers(
            @PathVariable Integer experimentId,
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "20") Integer pageSize) {

        // 查询该实验所有学生的答题记录
        List<StudentItem> allItems = studentItemService.list(
                new LambdaQueryWrapper<StudentItem>()
        );

        // 获取该实验的所有题目
        List<ExperimentItem> experimentItems = experimentItemService.list(
                new LambdaQueryWrapper<ExperimentItem>()
                        .eq(ExperimentItem::getExperimentId, experimentId)
        );
        Set<Integer> itemIds = experimentItems.stream()
                .map(ExperimentItem::getExperimentItemId)
                .collect(Collectors.toSet());

        // 过滤出该实验的答题记录
        List<StudentItem> experimentItems2 = allItems.stream()
                .filter(item -> itemIds.contains(item.getItemId()))
                .collect(Collectors.toList());

        // 按学生ID分组
        Map<Integer, List<StudentItem>> studentItemsMap = experimentItems2.stream()
                .collect(Collectors.groupingBy(StudentItem::getStudentId));

        // 获取学生信息
        Set<Integer> studentIds = studentItemsMap.keySet();
        Map<Integer, Student> studentMap = new HashMap<>();
        if (!studentIds.isEmpty()) {
            List<Student> students = studentService.list(
                    new LambdaQueryWrapper<Student>().in(Student::getStudentId, studentIds)
            );
            studentMap = students.stream()
                    .collect(Collectors.toMap(Student::getStudentId, s -> s));
        }

        // 构建返回数据
        List<Map<String, Object>> studentList = new ArrayList<>();
        int totalScore = experimentItems.stream().mapToInt(ExperimentItem::getExperimentItemScore).sum();

        for (Map.Entry<Integer, List<StudentItem>> entry : studentItemsMap.entrySet()) {
            Integer studentId = entry.getKey();
            List<StudentItem> items = entry.getValue();

            Student student = studentMap.get(studentId);
            if (student == null) continue;

            // 计算总分（已评分题目的分数之和）
            int currentScore = items.stream()
                    .filter(item -> item.getScore() != null)
                    .mapToInt(item -> item.getScore())
                    .sum();

            boolean allScored = items.stream().allMatch(item -> item.getScore() != null);

            Map<String, Object> studentData = new HashMap<>();
            studentData.put("studentId", studentId);
            studentData.put("studentNo", student.getStudentNo());
            studentData.put("studentName", student.getStudentName());
            studentData.put("clazzNo", student.getClazzNo());
            studentData.put("totalScore", currentScore);
            studentData.put("maxScore", totalScore);
            studentData.put("itemCount", items.size());
            studentData.put("scoredCount", items.stream().filter(item -> item.getScore() != null).count());
            studentData.put("status", allScored ? "已评分" : "待评分");

            studentList.add(studentData);
        }

        // 分页
        int total = studentList.size();
        int start = (page - 1) * pageSize;
        int end = Math.min(start + pageSize, total);
        List<Map<String, Object>> pagedList = start < total ?
                studentList.subList(start, end) : Collections.emptyList();

        Map<String, Object> result = new HashMap<>();
        result.put("list", pagedList);
        result.put("total", total);
        result.put("pageNum", page);
        result.put("pageSize", pageSize);

        return Result.success(result);
    }

    /**
     * 根据学生和实验查询答题详情
     */
    @GetMapping("/student/{studentId}/experiment/{experimentId}")
    public Result<Map<String, Object>> getStudentExperimentDetail(
            @PathVariable Integer studentId,
            @PathVariable Integer experimentId) {

        // 获取学生信息
        Student student = studentService.getById(studentId);
        if (student == null) {
            return Result.error("学生不存在");
        }

        // 获取实验题目
        List<ExperimentItem> items = experimentItemService.list(
                new LambdaQueryWrapper<ExperimentItem>()
                        .eq(ExperimentItem::getExperimentId, experimentId)
                        .orderByAsc(ExperimentItem::getExperimentItemNo)
        );

        // 获取学生的答题记录
        List<StudentItem> studentItems = studentItemService.list(
                new LambdaQueryWrapper<StudentItem>()
                        .eq(StudentItem::getStudentId, studentId)
        );

        Map<Integer, StudentItem> itemMap = studentItems.stream()
                .collect(Collectors.toMap(StudentItem::getItemId, item -> item, (a, b) -> a));

        // 构建详情数据
        List<Map<String, Object>> itemDetails = new ArrayList<>();
        int totalScore = 0;
        int maxScore = 0;

        for (ExperimentItem item : items) {
            Map<String, Object> detail = new HashMap<>();
            detail.put("itemId", item.getExperimentItemId());
            detail.put("itemNo", item.getExperimentItemNo());
            detail.put("name", item.getExperimentItemName());
            detail.put("questionType", getQuestionTypeName(item.getExperimentItemType()));
            detail.put("content", item.getExperimentItemContent());
            detail.put("answer", item.getExperimentItemAnswer());
            detail.put("maxScore", item.getExperimentItemScore());

            maxScore += item.getExperimentItemScore();

            StudentItem studentItem = itemMap.get(item.getExperimentItemId());
            if (studentItem != null) {
                detail.put("studentAnswer", studentItem.getContent());
                detail.put("score", studentItem.getScore());
                detail.put("studentItemId", studentItem.getStudentItemId());
                if (studentItem.getScore() != null) {
                    totalScore += studentItem.getScore();
                }
            } else {
                detail.put("studentAnswer", "未作答");
                detail.put("score", null);
            }

            itemDetails.add(detail);
        }

        Map<String, Object> result = new HashMap<>();
        result.put("studentId", student.getStudentId());
        result.put("studentNo", student.getStudentNo());
        result.put("studentName", student.getStudentName());
        result.put("clazzNo", student.getClazzNo());
        result.put("totalScore", totalScore);
        result.put("maxScore", maxScore);
        result.put("items", itemDetails);

        return Result.success(result);
    }

    /**
     * 评分（单条）
     */
    @PutMapping("/item/{studentItemId}")
    public Result<Void> scoreItem(
            @PathVariable Integer studentItemId,
            @RequestParam Integer score) {

        StudentItem item = studentItemService.getById(studentItemId);
        if (item == null) {
            return Result.error("答题记录不存在");
        }

        item.setScore(score);
        item.setScoreFlag(1);
        boolean success = studentItemService.updateById(item);

        if (success) {
            // 更新总成绩
            updateTotalScore(item.getStudentId(), item.getItemId());
            log.info("评分成功: 答题ID={}, 分数={}", studentItemId, score);
            return Result.success("评分成功", null);
        }
        return Result.error("评分失败");
    }

    /**
     * 更新学生总成绩
     */
    private void updateTotalScore(Integer studentId, Integer itemId) {
        // 找到该题目对应的实验
        ExperimentItem experimentItem = experimentItemService.getById(itemId);
        if (experimentItem == null) return;

        Integer experimentId = experimentItem.getExperimentId();

        // 查找或创建成绩记录
        Score score = scoreService.getOne(
                new LambdaQueryWrapper<Score>()
                        .eq(Score::getStudentId, studentId)
                        .eq(Score::getExperimentId, experimentId)
        );

        // 计算该学生在该实验下的总得分
        List<StudentItem> studentItems = studentItemService.list(
                new LambdaQueryWrapper<StudentItem>()
                        .eq(StudentItem::getStudentId, studentId)
        );

        Set<Integer> experimentItemIds = experimentItemService.list(
                new LambdaQueryWrapper<ExperimentItem>()
                        .eq(ExperimentItem::getExperimentId, experimentId)
        ).stream().map(ExperimentItem::getExperimentItemId).collect(Collectors.toSet());

        int totalScore = studentItems.stream()
                .filter(item -> experimentItemIds.contains(item.getItemId()))
                .filter(item -> item.getScore() != null)
                .mapToInt(StudentItem::getScore)
                .sum();

        if (score == null) {
            score = new Score();
            score.setStudentId(studentId);
            score.setExperimentId(experimentId);
            score.setScore(totalScore);
            scoreService.save(score);
        } else {
            score.setScore(totalScore);
            scoreService.updateById(score);
        }
    }

    /**
     * 批量评分
     */
    @PutMapping("/batch")
    public Result<Void> batchScore(@RequestBody List<Map<String, Object>> items) {
        if (items == null || items.isEmpty()) {
            return Result.error("评分列表为空");
        }

        int successCount = 0;
        Set<Integer> updatedStudents = new HashSet<>();

        for (Map<String, Object> itemData : items) {
            Integer studentItemId = itemData.get("studentItemId") != null ?
                    Integer.parseInt(itemData.get("studentItemId").toString()) : null;
            Integer score = itemData.get("score") != null ?
                    Integer.parseInt(itemData.get("score").toString()) : null;

            if (studentItemId == null || score == null) continue;

            StudentItem item = studentItemService.getById(studentItemId);
            if (item != null) {
                item.setScore(score);
                item.setScoreFlag(1);
                if (studentItemService.updateById(item)) {
                    successCount++;
                    updatedStudents.add(item.getStudentId());
                }
            }
        }

        // 更新所有涉及学生的总成绩
        for (Integer studentId : updatedStudents) {
            List<StudentItem> studentItems = studentItemService.list(
                    new LambdaQueryWrapper<StudentItem>()
                            .eq(StudentItem::getStudentId, studentId)
            );

            Map<Integer, Integer> experimentScores = new HashMap<>();

            for (StudentItem si : studentItems) {
                if (si.getScore() != null) {
                    ExperimentItem ei = experimentItemService.getById(si.getItemId());
                    if (ei != null) {
                        experimentScores.merge(ei.getExperimentId(), si.getScore(), Integer::sum);
                    }
                }
            }

            for (Map.Entry<Integer, Integer> entry : experimentScores.entrySet()) {
                Score score = scoreService.getOne(
                        new LambdaQueryWrapper<Score>()
                                .eq(Score::getStudentId, studentId)
                                .eq(Score::getExperimentId, entry.getKey())
                );

                if (score == null) {
                    score = new Score();
                    score.setStudentId(studentId);
                    score.setExperimentId(entry.getKey());
                    score.setScore(entry.getValue());
                    scoreService.save(score);
                } else {
                    score.setScore(entry.getValue());
                    scoreService.updateById(score);
                }
            }
        }

        if (successCount > 0) {
            log.info("批量评分成功，数量: {}", successCount);
            return Result.success("批量评分成功，共" + successCount + "条", null);
        }
        return Result.error("批量评分失败");
    }

    /**
     * 获取题目类型名称
     */
    private String getQuestionTypeName(Integer type) {
        if (type == null) return "未知";
        switch (type) {
            case 1: return "选择题";
            case 2: return "填空题";
            case 3: return "简答题";
            case 4: return "编程题";
            case 5: return "综合题";
            default: return "其他";
        }
    }

    /**
     * 导出成绩Excel
     */
    @GetMapping("/export/{experimentId}")
    public Result<String> exportScores(@PathVariable Integer experimentId) {
        // TODO: 实现Excel导出功能
        log.info("导出实验成绩: 实验ID={}", experimentId);
        return Result.success("导出功能待实现", null);
    }
}
