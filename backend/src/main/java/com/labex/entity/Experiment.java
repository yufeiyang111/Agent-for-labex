package com.labex.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 实验实体类
 */
@Data
@TableName("t_experiment")
public class Experiment {

    @TableId(value = "experiment_id", type = IdType.AUTO)
    private Integer experimentId;

    @TableField("experiment_no")
    private Integer experimentNo;

    @TableField("experiment_name")
    private String experimentName;

    @TableField("experiment_type")
    private Integer experimentType;

    @TableField("instruction_type")
    private String instructionType;

    @TableField("experiment_requirement")
    private String experimentRequirement;

    @TableField("experiment_content")
    private String experimentContent;

    @TableField("state")
    private Integer state;

    @TableField(exist = false)
    private LocalDateTime createTime;

    @TableField(exist = false)
    private LocalDateTime updateTime;

    @TableLogic
    @TableField(exist = false)
    private Integer deleted;

    @TableField("teacher_id")
    private Integer teacherId;
}
