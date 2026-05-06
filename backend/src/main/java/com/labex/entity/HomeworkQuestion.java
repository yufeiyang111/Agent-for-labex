package com.labex.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

/**
 * 作业题目关联表
 */
@Data
@TableName("t_homework_question")
public class HomeworkQuestion {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField("homework_id")
    private Integer homeworkId;

    @TableField("question_id")
    private Integer questionId;

    @TableField("score")
    private Integer score;

    @TableField("sort_index")
    private Integer sortIndex;
}