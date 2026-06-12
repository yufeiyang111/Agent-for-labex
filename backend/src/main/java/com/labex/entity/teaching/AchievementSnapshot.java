package com.labex.entity.teaching;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 达成度快照（CTL-S5）
 * student_id IS NULL → 班级聚合
 * objective_id IS NULL → 课程总目标
 */
@Data
@TableName("t_achievement_snapshot")
public class AchievementSnapshot {

    @TableId(value = "snapshot_id", type = IdType.AUTO)
    private Integer snapshotId;

    @TableField("offering_id")
    private Integer offeringId;

    @TableField("student_id")
    private Integer studentId;

    @TableField("objective_id")
    private Integer objectiveId;

    @TableField("achievement_value")
    private BigDecimal achievementValue;

    @TableField("weighted_score")
    private BigDecimal weightedScore;

    @TableField("weighted_max")
    private BigDecimal weightedMax;

    @TableField("reached_count")
    private Integer reachedCount;

    @TableField("total_count")
    private Integer totalCount;

    @TableField("calc_time")
    private LocalDateTime calcTime;

    @TableField("version")
    private Integer version;
}
