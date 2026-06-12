package com.labex.entity.teaching;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 评分项↔课程目标（CTL-S3）
 */
@Data
@TableName("t_scoring_item_objective")
public class ScoringItemObjective {

    @TableId(value = "link_id", type = IdType.AUTO)
    private Integer linkId;

    @TableField("item_id")
    private Integer itemId;

    @TableField("objective_id")
    private Integer objectiveId;

    @TableField("weight_in_objective")
    private BigDecimal weightInObjective;

    @TableField("create_time")
    private LocalDateTime createTime;

    @TableLogic
    @TableField("deleted")
    private Integer deleted;
}
