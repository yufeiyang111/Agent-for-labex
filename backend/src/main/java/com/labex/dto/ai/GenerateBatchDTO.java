package com.labex.dto.ai;

import lombok.Data;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

/**
 * 生成批次DTO（用于Redis暂存）
 */
@Data
public class GenerateBatchDTO {
    /**
     * 批次ID
     */
    private String batchId;

    /**
     * 教师ID
     */
    private Integer teacherId;

    /**
     * 生成请求参数
     */
    private QuestionGenerateRequest request;

    /**
     * 生成的题目列表
     */
    private List<GeneratedQuestionDTO> questions;

    /**
     * 各题型数量统计
     */
    private Map<String, Integer> typeDistribution;

    /**
     * 生成状态：generating（生成中）, completed（完成）, failed（失败）
     */
    private String status = "generating";

    /**
     * 生成开始时间
     */
    private LocalDateTime startedAt;

    /**
     * 生成完成时间
     */
    private LocalDateTime completedAt;

    /**
     * 错误信息（如果有）
     */
    private String errorMessage;

    /**
     * 已审核数量
     */
    private Integer reviewedCount = 0;

    /**
     * 已批准数量
     */
    private Integer approvedCount = 0;

    /**
     * 已拒绝数量
     */
    private Integer rejectedCount = 0;

    /**
     * 已持久化数量
     */
    private Integer persistedCount = 0;

    /**
     * 总题目数量
     */
    private Integer totalCount = 0;

    /**
     * 知识库检索的文档片段
     */
    private List<String> sourceContexts;

    /**
     * 3天后过期（Redis TTL）
     */
    private LocalDateTime expiresAt;
}
