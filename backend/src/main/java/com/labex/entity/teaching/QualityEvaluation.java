package com.labex.entity.teaching;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 课程质量评价（CTL-S6）
 */
@Data
@TableName("t_quality_evaluation")
public class QualityEvaluation {

    @TableId(value = "evaluation_id", type = IdType.AUTO)
    private Integer evaluationId;

    @TableField("offering_id")
    private Integer offeringId;

    @TableField("evaluator_id")
    private Integer evaluatorId;

    @TableField("eval_round")
    private String evalRound;

    @TableField("course_responsible")
    private String courseResponsible;

    @TableField("course_members")
    private String courseMembers;

    @TableField("eval_group_members")
    private String evalGroupMembers;

    /** reasonable / relatively / unreasonable */
    @TableField("objective_indicator_rationality")
    private String objectiveIndicatorRationality;

    /** contain / partial / none */
    @TableField("objective_contains_kaq")
    private String objectiveContainsKaq;

    @TableField("achievement_values")
    private String achievementValues;

    @TableField("expected_rationality")
    private String expectedRationality;

    @TableField("analysis_rationality")
    private String analysisRationality;

    @TableField("improvement_rationality")
    private String improvementRationality;

    @TableField("existing_issues")
    private String existingIssues;

    @TableField("evaluation_validity")
    private String evaluationValidity;

    @TableField("last_round_improvements")
    private String lastRoundImprovements;

    @TableField("conclusion_and_suggestions")
    private String conclusionAndSuggestions;

    /** draft / finalized */
    @TableField("status")
    private String status;

    @TableField("create_time")
    private LocalDateTime createTime;

    @TableField("update_time")
    private LocalDateTime updateTime;

    @TableLogic
    @TableField("deleted")
    private Integer deleted;
}
