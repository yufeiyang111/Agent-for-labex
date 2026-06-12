package com.labex.entity.teaching;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 课程目标支撑指标点（CTL-S2）
 * 关联表，使用物理删除（不映射 deleted 字段以避免 MyBatis-Plus 全局逻辑删除 + UNIQUE 冲突）。
 */
@Data
@TableName("t_objective_support")
public class ObjectiveSupport {

    @TableId(value = "support_id", type = IdType.AUTO)
    private Integer supportId;

    @TableField("objective_id")
    private Integer objectiveId;

    @TableField("indicator_id")
    private Integer indicatorId;

    /** H=3 / M=2 / L=1 */
    @TableField("support_strength")
    private Integer supportStrength;

    @TableField("create_time")
    private LocalDateTime createTime;
}
