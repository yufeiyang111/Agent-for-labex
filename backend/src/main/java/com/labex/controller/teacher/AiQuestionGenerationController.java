package com.labex.controller.teacher;

import com.labex.common.Result;
import com.labex.dto.ai.GenerateBatchDTO;
import com.labex.dto.ai.GeneratedQuestionDTO;
import com.labex.dto.ai.QuestionGenerateRequest;
import com.labex.entity.Question;
import com.labex.service.ai.AiQuestionGenerationService;
import com.labex.service.ai.QuestionGenerationCacheService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.*;

/**
 * AI题目生成控制器
 */
@Slf4j
@RestController
@RequestMapping("/teacher/ai-question")
@PreAuthorize("hasRole('TEACHER')")
public class AiQuestionGenerationController {

    private final AiQuestionGenerationService generationService;
    private final QuestionGenerationCacheService cacheService;

    @Autowired
    public AiQuestionGenerationController(AiQuestionGenerationService generationService,
                                          QuestionGenerationCacheService cacheService) {
        this.generationService = generationService;
        this.cacheService = cacheService;
    }

    /**
     * 异步生成题目
     */
    @PostMapping("/generate")
    public Result<Map<String, Object>> generateQuestions(@RequestBody QuestionGenerateRequest request,
                                                         Authentication auth) {
        try {
            Integer teacherId = Integer.parseInt(auth.getName());
            request.setTeacherId(teacherId);

            // 验证请求参数
            if (request.getQuestionTypes() == null || request.getQuestionTypes().isEmpty()) {
                return Result.error("请选择至少一种题型");
            }

            // 生成批次ID
            String batchId = UUID.randomUUID().toString().replace("-", "");
            request.setBatchId(batchId);

            // 异步生成
            generationService.generateQuestionsAsync(request);

            Map<String, Object> response = new HashMap<>();
            response.put("batchId", batchId);
            response.put("message", "题目生成已启动，请稍后查看结果");

            return Result.success(response);
        } catch (Exception e) {
            log.error("启动题目生成失败: {}", e.getMessage(), e);
            return Result.error("启动题目生成失败: " + e.getMessage());
        }
    }

    /**
     * 同步生成题目（等待完成）
     */
    @PostMapping("/generate-sync")
    public Result<GenerateBatchDTO> generateQuestionsSync(@RequestBody QuestionGenerateRequest request,
                                                          Authentication auth) {
        try {
            Integer teacherId = Integer.parseInt(auth.getName());
            request.setTeacherId(teacherId);

            // 验证请求参数
            if (request.getQuestionTypes() == null || request.getQuestionTypes().isEmpty()) {
                return Result.error("请选择至少一种题型");
            }

            // 同步生成
            GenerateBatchDTO batch = generationService.generateQuestions(request);

            return Result.success(batch);
        } catch (Exception e) {
            log.error("题目生成失败: {}", e.getMessage(), e);
            return Result.error("题目生成失败: " + e.getMessage());
        }
    }

    /**
     * 获取生成批次状态
     */
    @GetMapping("/batch/{batchId}")
    public Result<GenerateBatchDTO> getBatch(@PathVariable String batchId) {
        try {
            log.debug("查询批次状态: batchId={}", batchId);
            GenerateBatchDTO batch = cacheService.getBatch(batchId);
            if (batch == null) {
                log.warn("批次不存在或已过期: batchId={}", batchId);
                return Result.error("批次不存在或已过期");
            }
            log.debug("批次状态: batchId={}, status={}", batchId, batch.getStatus());
            return Result.success(batch);
        } catch (Exception e) {
            log.error("获取批次失败: {}", e.getMessage(), e);
            return Result.error("获取批次失败: " + e.getMessage());
        }
    }

    /**
     * 获取教师的所有生成批次
     */
    @GetMapping("/batches")
    public Result<List<GenerateBatchDTO>> getTeacherBatches(Authentication auth) {
        try {
            Integer teacherId = Integer.parseInt(auth.getName());
            List<GenerateBatchDTO> batches = cacheService.getTeacherBatches(teacherId);
            return Result.success(batches);
        } catch (Exception e) {
            log.error("获取教师批次列表失败: {}", e.getMessage(), e);
            return Result.error("获取批次列表失败: " + e.getMessage());
        }
    }

    /**
     * 获取批次统计信息
     */
    @GetMapping("/batch/{batchId}/statistics")
    public Result<Map<String, Object>> getBatchStatistics(@PathVariable String batchId) {
        try {
            Map<String, Object> stats = generationService.getBatchStatistics(batchId);
            if (stats.isEmpty()) {
                return Result.error("批次不存在或已过期");
            }
            return Result.success(stats);
        } catch (Exception e) {
            log.error("获取批次统计失败: {}", e.getMessage(), e);
            return Result.error("获取批次统计失败: " + e.getMessage());
        }
    }

    /**
     * 获取批次的所有题目
     */
    @GetMapping("/batch/{batchId}/questions")
    public Result<List<GeneratedQuestionDTO>> getBatchQuestions(@PathVariable String batchId) {
        try {
            List<GeneratedQuestionDTO> questions = cacheService.getBatchQuestions(batchId);
            return Result.success(questions);
        } catch (Exception e) {
            log.error("获取批次题目失败: {}", e.getMessage(), e);
            return Result.error("获取批次题目失败: " + e.getMessage());
        }
    }

    /**
     * 获取单个题目详情
     */
    @GetMapping("/question/{tempId}")
    public Result<GeneratedQuestionDTO> getQuestion(@PathVariable String tempId) {
        try {
            GeneratedQuestionDTO question = cacheService.getQuestion(tempId);
            if (question == null) {
                return Result.error("题目不存在或已过期");
            }
            return Result.success(question);
        } catch (Exception e) {
            log.error("获取题目失败: {}", e.getMessage(), e);
            return Result.error("获取题目失败: " + e.getMessage());
        }
    }

    /**
     * 批准题目
     */
    @PostMapping("/question/{tempId}/approve")
    public Result<Void> approveQuestion(@PathVariable String tempId) {
        try {
            cacheService.approveQuestion(tempId);
            return Result.success(null);
        } catch (Exception e) {
            log.error("批准题目失败: {}", e.getMessage(), e);
            return Result.error("批准题目失败: " + e.getMessage());
        }
    }

    /**
     * 拒绝题目
     */
    @PostMapping("/question/{tempId}/reject")
    public Result<Void> rejectQuestion(@PathVariable String tempId) {
        try {
            cacheService.rejectQuestion(tempId);
            return Result.success(null);
        } catch (Exception e) {
            log.error("拒绝题目失败: {}", e.getMessage(), e);
            return Result.error("拒绝题目失败: " + e.getMessage());
        }
    }

    /**
     * 修改题目内容
     */
    @PutMapping("/question/{tempId}")
    public Result<Void> updateQuestion(@PathVariable String tempId,
                                        @RequestBody Map<String, String> updates) {
        try {
            String question = updates.get("question");
            String answer = updates.get("answer");
            String analysis = updates.get("analysis");

            cacheService.updateQuestionContent(tempId, question, answer, analysis);
            return Result.success(null);
        } catch (Exception e) {
            log.error("修改题目失败: {}", e.getMessage(), e);
            return Result.error("修改题目失败: " + e.getMessage());
        }
    }

    /**
     * 重新生成题目
     */
    @PostMapping("/question/{tempId}/regenerate")
    public Result<GeneratedQuestionDTO> regenerateQuestion(@PathVariable String tempId,
                                                            @RequestBody(required = false) Map<String, String> body) {
        try {
            String requirements = body != null ? body.get("requirements") : null;
            GeneratedQuestionDTO regenerated = generationService.regenerateQuestion(tempId, requirements);
            return Result.success(regenerated);
        } catch (Exception e) {
            log.error("重新生成题目失败: {}", e.getMessage(), e);
            return Result.error("重新生成题目失败: " + e.getMessage());
        }
    }

    /**
     * 持久化单个题目到数据库
     */
    @PostMapping("/question/{tempId}/persist")
    public Result<Question> persistQuestion(@PathVariable String tempId) {
        try {
            Question question = generationService.persistQuestion(tempId);
            return Result.success(question);
        } catch (Exception e) {
            log.error("持久化题目失败: {}", e.getMessage(), e);
            return Result.error("持久化题目失败: " + e.getMessage());
        }
    }

    /**
     * 批量持久化题目到数据库
     */
    @PostMapping("/batch/{batchId}/persist")
    public Result<List<Question>> batchPersistQuestions(@PathVariable String batchId,
                                                        @RequestBody List<String> tempIds) {
        try {
            List<Question> questions = generationService.batchPersistQuestions(tempIds);
            return Result.success(questions);
        } catch (Exception e) {
            log.error("批量持久化题目失败: {}", e.getMessage(), e);
            return Result.error("批量持久化题目失败: " + e.getMessage());
        }
    }

    /**
     * 删除生成批次
     */
    @DeleteMapping("/batch/{batchId}")
    public Result<Void> deleteBatch(@PathVariable String batchId) {
        try {
            cacheService.deleteBatch(batchId);
            return Result.success(null);
        } catch (Exception e) {
            log.error("删除批次失败: {}", e.getMessage(), e);
            return Result.error("删除批次失败: " + e.getMessage());
        }
    }

    /**
     * 获取批次剩余过期时间
     */
    @GetMapping("/batch/{batchId}/ttl")
    public Result<Map<String, Object>> getBatchTTL(@PathVariable String batchId) {
        try {
            Long ttl = cacheService.getBatchTTL(batchId);
            Map<String, Object> result = new HashMap<>();
            result.put("batchId", batchId);
            result.put("ttlSeconds", ttl);
            result.put("ttlHours", ttl != null ? ttl / 3600.0 : null);
            return Result.success(result);
        } catch (Exception e) {
            log.error("获取批次TTL失败: {}", e.getMessage(), e);
            return Result.error("获取批次TTL失败: " + e.getMessage());
        }
    }
}
