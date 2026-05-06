package com.labex.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

/**
 * 实验题目实体类
 */
@Data
@TableName("t_experiment_item")
public class ExperimentItem {

    @TableId(value = "experiment_item_id", type = IdType.AUTO)
    private Integer experimentItemId;

    @TableField("experiment_item_no")
    private Integer experimentItemNo;

    @TableField("experiment_item_name")
    private String experimentItemName;

    @TableField("experiment_item_type")
    private Integer experimentItemType;

    @TableField("experiment_item_content")
    private String experimentItemContent;

    @TableField("experiment_id")
    private Integer experimentId;

    @TableField("experiment_item_answer")
    private String experimentItemAnswer;

    @TableField("experiment_item_score")
    private Integer experimentItemScore;

    @TableField("state")
    private Integer state;
}
