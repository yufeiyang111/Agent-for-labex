package com.labex.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

/**
 * 成绩实体类
 */
@Data
@TableName("t_score")
public class Score {

    @TableId(value = "score_id", type = IdType.AUTO)
    private Integer scoreId;

    @TableField("student_id")
    private Integer studentId;

    @TableField("experiment_id")
    private Integer experimentId;

    @TableField("score")
    private Integer score;
}
