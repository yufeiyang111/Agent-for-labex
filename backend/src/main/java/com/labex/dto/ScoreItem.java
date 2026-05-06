package com.labex.dto;

import lombok.Data;

import jakarta.validation.constraints.NotNull;

/**
 * 评分项
 */
@Data
public class ScoreItem {

    @NotNull(message = "学生ID不能为空")
    private Integer studentId;

    @NotNull(message = "题目ID不能为空")
    private Integer itemId;

    @NotNull(message = "分数不能为空")
    private Integer score;
}
