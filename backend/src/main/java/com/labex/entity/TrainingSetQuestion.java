package com.labex.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

@Data
@TableName("t_training_set_question")
public class TrainingSetQuestion {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField("training_set_id")
    private Integer trainingSetId;

    @TableField("question_id")
    private Integer questionId;

    @TableField("score")
    private Integer score;

    @TableField("sort_index")
    private Integer sortIndex;
}
