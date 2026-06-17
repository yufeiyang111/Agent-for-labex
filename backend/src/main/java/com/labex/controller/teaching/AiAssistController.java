package com.labex.controller.teaching;

import com.labex.common.Result;
import com.labex.entity.teaching.SyllabusChapter;
import com.labex.service.teaching.ai.SyllabusAiAssistant;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

/**
 * LLM 辅助填写控制器（CTL-AI Assist）
 * 复用项目现有 OpenAiCompatibleProvider
 */
@RestController
@RequestMapping("/teacher/ai-assist")
@PreAuthorize("hasRole('TEACHER') or hasRole('ADMIN')")
@Slf4j
public class AiAssistController {

    @Autowired private SyllabusAiAssistant assistant;

    // ============ 大纲字段 ============

    @PostMapping("/syllabus/full")
    public Result<Map<String, Object>> syllabusFull(@RequestParam Integer courseId) {
        return Result.success(assistant.generateCompleteCourseSetup(courseId));
    }

    @PostMapping("/syllabus/intro")
    public Result<Map<String, Object>> syllabusIntro(@RequestParam Integer courseId) {
        return Result.success(Map.of("content", assistant.generateCourseIntro(courseId)));
    }

    @PostMapping("/syllabus/goals")
    public Result<Map<String, Object>> syllabusGoals(@RequestParam Integer courseId,
                                                      @RequestParam String type) {
        return Result.success(Map.of("type", type, "content", assistant.generateGoals(courseId, type)));
    }

    @PostMapping("/syllabus/chapters")
    public Result<List<SyllabusChapter>> syllabusChapters(@RequestParam Integer courseId) {
        return Result.success(assistant.generateChapters(courseId));
    }

    @PostMapping("/syllabus/methods")
    public Result<Map<String, Object>> syllabusMethods(@RequestParam Integer courseId) {
        return Result.success(Map.of("content", assistant.generateTeachingMethods(courseId)));
    }

    @PostMapping("/syllabus/textbooks")
    public Result<Map<String, Object>> syllabusTextbooks(@RequestParam Integer courseId) {
        return Result.success(Map.of("content", assistant.generateTextbooks(courseId)));
    }

    // ============ 课程目标 ============

    @PostMapping("/objective/description")
    public Result<Map<String, Object>> objectiveDescription(@RequestParam Integer objectiveId) {
        return Result.success(Map.of("content", assistant.generateObjectiveDescription(objectiveId)));
    }

    @PostMapping("/syllabus/main-task")
    public Result<Map<String, Object>> syllabusMainTask(@RequestParam Integer courseId) {
        return Result.success(Map.of("content", assistant.generateMainTask(courseId)));
    }

    @PostMapping("/syllabus/exercise-requirements")
    public Result<Map<String, Object>> syllabusExerciseRequirements(@RequestParam Integer courseId) {
        return Result.success(Map.of("content", assistant.generateExerciseRequirements(courseId)));
    }

    @PostMapping("/syllabus/assessment-methods")
    public Result<Map<String, Object>> syllabusAssessmentMethods(@RequestParam Integer courseId) {
        return Result.success(Map.of("content", assistant.generateAssessmentMethods(courseId)));
    }

    @PostMapping("/syllabus/achievement-formula")
    public Result<Map<String, Object>> syllabusAchievementFormula(@RequestParam Integer courseId) {
        return Result.success(Map.of("content", assistant.generateAchievementFormula(courseId)));
    }

    @PostMapping("/syllabus/references-list")
    public Result<Map<String, Object>> syllabusReferencesList(@RequestParam Integer courseId) {
        return Result.success(Map.of("content", assistant.generateReferencesList(courseId)));
    }

    // ============ 质量评价 ============

    @PostMapping("/quality/attainment-analysis")
    public Result<Map<String, Object>> attainmentAnalysis(@RequestParam Integer offeringId,
                                                           @RequestParam(required = false) Integer objectiveId) {
        return Result.success(Map.of("content", assistant.generateAttainmentAnalysis(offeringId, objectiveId)));
    }

    @PostMapping("/quality/last-round")
    public Result<Map<String, Object>> lastRound(@RequestParam Integer offeringId) {
        return Result.success(Map.of("content", assistant.generateLastRoundImprovements(offeringId)));
    }

    @PostMapping("/quality/conclusion")
    public Result<Map<String, Object>> qualityConclusion(@RequestParam Integer evaluationId) {
        return Result.success(Map.of("content", assistant.generateQualityConclusion(evaluationId)));
    }

    @PostMapping("/quality/existing-issues")
    public Result<Map<String, Object>> existingIssues(@RequestParam Integer evaluationId) {
        return Result.success(Map.of("content", assistant.generateExistingIssues(evaluationId)));
    }

    @PostMapping("/quality/evaluation-validity")
    public Result<Map<String, Object>> evaluationValidity(@RequestParam Integer evaluationId) {
        return Result.success(Map.of("content", assistant.generateEvaluationValidity(evaluationId)));
    }
}
