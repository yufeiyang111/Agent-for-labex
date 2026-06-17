package com.labex.kg.controller;

import com.labex.common.Result;
import com.labex.kg.dto.RecommendationRequest;
import com.labex.kg.dto.RecommendationResponse;
import com.labex.kg.service.ExerciseRecommendationService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Slf4j
@RestController
@RequestMapping("/recommendation")
public class RecommendationController {

    @Autowired
    private ExerciseRecommendationService recommendationService;

    /** Personalized recommendations based on student's weak points */
    @GetMapping("/for-me")
    public Result<List<RecommendationResponse>> forMe(
            @RequestParam(defaultValue = "10") int limit,
            @RequestParam(defaultValue = "false") boolean explain) {
        int studentId = getCurrentStudentId();
        return Result.success(recommendationService.recommendByWeakness(studentId, limit, explain));
    }

    /** Recommendations for a specific knowledge point */
    @GetMapping("/by-knowledge")
    public Result<List<RecommendationResponse>> byKnowledge(
            @RequestParam String knowledgePointId,
            @RequestParam(defaultValue = "10") int limit) {
        return Result.success(recommendationService.recommendByKnowledgePoint(knowledgePointId, limit));
    }

    /** Similar exercises to a given question */
    @GetMapping("/similar")
    public Result<List<RecommendationResponse>> similar(
            @RequestParam int questionId,
            @RequestParam(defaultValue = "5") int limit) {
        return Result.success(recommendationService.recommendSimilar(questionId, limit));
    }

    /** Create or refresh a personal practice set from KG recommendations. */
    @PostMapping("/practice-set")
    public Result<Map<String, Object>> practiceSet(@RequestBody(required = false) RecommendationRequest request) {
        int studentId = getCurrentStudentId();
        try {
            return Result.success(recommendationService.createPersonalPracticeSet(studentId, request));
        } catch (Exception e) {
            log.warn("Create recommendation practice set failed for student {}: {}", studentId, e.getMessage());
            return Result.error(e.getMessage());
        }
    }

    private int getCurrentStudentId() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated()) {
            try {
                return Integer.parseInt(auth.getName());
            } catch (NumberFormatException e) {
                throw new IllegalStateException("当前登录用户不是学生账号");
            }
        }
        throw new IllegalStateException("未登录");
    }
}
