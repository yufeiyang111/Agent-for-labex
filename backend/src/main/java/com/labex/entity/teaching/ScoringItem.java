package com.labex.entity.teaching;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 评分项（CTL-S3）
 */
@Data
@TableName("t_scoring_item")
public class ScoringItem {

    @TableId(value = "item_id", type = IdType.AUTO)
    private Integer itemId;

    @TableField("offering_id")
    private Integer offeringId;

    @TableField("name")
    private String name;

    /** homework / experiment / exam / project / other */
    @TableField("type")
    private String type;

    @TableField("source_table")
    private String sourceTable;

    @TableField("source_id")
    private Integer sourceId;

    @TableField("max_score")
    private Integer maxScore;

    @TableField("passing_score")
    private Integer passingScore;

    @TableField("weight")
    private BigDecimal weight;

    @TableField("sort_order")
    private Integer sortOrder;

    @TableField("create_time")
    private LocalDateTime createTime;

    @TableField("update_time")
    private LocalDateTime updateTime;

    @TableLogic
    @TableField("deleted")
    private Integer deleted;
}
