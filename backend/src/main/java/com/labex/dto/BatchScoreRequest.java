package com.labex.dto;

import lombok.Data;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import java.util.List;

/**
 * 批量评分DTO
 */
@Data
public class BatchScoreRequest {

    @NotNull(message = "实验ID不能为空")
    private Integer experimentId;

    @NotEmpty(message = "评分列表不能为空")
    private List<ScoreItem> scores;
}
