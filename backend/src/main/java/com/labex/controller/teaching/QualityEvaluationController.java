package com.labex.controller.teaching;

import com.labex.common.Result;
import com.labex.entity.Teacher;
import com.labex.entity.teaching.QualityEvaluation;
import com.labex.service.TeacherService;
import com.labex.service.teaching.QualityEvaluationService;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.*;

/**
 * 课程质量评价控制器（CTL-S6）
 */
@RestController
@RequestMapping("/teacher/quality-evaluation")
@PreAuthorize("hasRole('TEACHER') or hasRole('ADMIN')")
@Slf4j
public class QualityEvaluationController {

    @Autowired private QualityEvaluationService evaluationService;
    @Autowired private TeacherService teacherService;

    private Integer currentTeacherId() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            Teacher t = teacherService.findByAccount(auth.getName());
            if (t != null) return t.getTeacherId();
        }
        return null;
    }

    @GetMapping("/list")
    public Result<List<QualityEvaluation>> list(@RequestParam Integer offeringId) {
        return Result.success(evaluationService.listByOffering(offeringId));
    }

    @GetMapping("/latest")
    public Result<QualityEvaluation> latest(@RequestParam Integer offeringId) {
        return Result.success(evaluationService.getLatest(offeringId));
    }

    @GetMapping("/{id}")
    public Result<QualityEvaluation> detail(@PathVariable Integer id) {
        return Result.success(evaluationService.getById(id));
    }

    @PostMapping
    public Result<QualityEvaluation> create(@RequestBody CreateRequest req) {
        Integer eid = req.getEvaluatorId() != null ? req.getEvaluatorId() : currentTeacherId();
        return Result.success(evaluationService.createDraft(req.getOfferingId(), eid, req.getEvalRound()));
    }

    @PutMapping("/{id}")
    public Result<QualityEvaluation> save(@PathVariable Integer id, @RequestBody QualityEvaluation dto) {
        return Result.success(evaluationService.saveEvaluation(id, dto));
    }

    @PostMapping("/{id}/finalize")
    public Result<QualityEvaluation> finalize(@PathVariable Integer id) {
        return Result.success(evaluationService.finalize(id));
    }

    @DeleteMapping("/{id}")
    public Result<Boolean> delete(@PathVariable Integer id) {
        return Result.success(evaluationService.removeById(id));
    }

    /**
     * 获取学生评价统计
     */
    @GetMapping("/stats")
    public Result<Map<String, Object>> getStats(@RequestParam Integer offeringId) {
        // 从数据库获取学生评价统计数据
        Map<String, Object> stats = evaluationService.getEvaluationStats(offeringId);
        return Result.success(stats);
    }

    /**
     * 获取评价维度数据
     */
    @GetMapping("/dimensions")
    public Result<List<Map<String, Object>>> getDimensions(@RequestParam Integer offeringId) {
        // 从数据库获取各维度评分数据
        List<Map<String, Object>> dimensions = evaluationService.getEvaluationDimensions(offeringId);
        return Result.success(dimensions);
    }

    /**
     * 获取学生文字评价
     */
    @GetMapping("/comments")
    public Result<List<Map<String, Object>>> getComments(@RequestParam Integer offeringId) {
        // 从数据库获取学生文字评价
        List<Map<String, Object>> comments = evaluationService.getStudentComments(offeringId);
        return Result.success(comments);
    }

    @Data
    public static class CreateRequest {
        private Integer offeringId;
        private Integer evaluatorId;
        private String evalRound;
    }
}
