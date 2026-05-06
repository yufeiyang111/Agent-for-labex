package com.labex.controller.teacher;

import com.labex.common.Result;
import com.labex.rag.service.QuestionGenerationService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

/**
 * Controller for AI-powered automatic question generation from lecture content.
 * Teachers can trigger generation for specific lectures and receive a summary of results.
 */
@Slf4j
@RestController
@RequestMapping("/teacher/question")
@PreAuthorize("hasRole('TEACHER')")
public class QuestionGenerationController {

    private final QuestionGenerationService questionGenerationService;

    public QuestionGenerationController(QuestionGenerationService questionGenerationService) {
        this.questionGenerationService = questionGenerationService;
    }

    /**
     * Generate questions from specified lectures using AI.
     * The questions are automatically saved to the question bank.
     */
    @PostMapping("/generate")
    public Result<GenerateResponse> generate(@RequestBody GenerateRequest request, Authentication auth) {
        if (request.getLectureIds() == null || request.getLectureIds().isEmpty()) {
            return Result.error("请选择至少一个讲义");
        }

        Integer teacherId = Integer.parseInt(auth.getName());
        log.info("Teacher {} requested question generation for lectures: {}",
                teacherId, request.getLectureIds());

        GenerateResponse response = questionGenerationService.generate(request, teacherId);
        log.info("Generation complete: {} questions generated, {} duplicates, {} errors",
                response.getTotalGenerated(), response.getTotalDuplicates(), response.getTotalErrors());

        return Result.success(response);
    }
}
