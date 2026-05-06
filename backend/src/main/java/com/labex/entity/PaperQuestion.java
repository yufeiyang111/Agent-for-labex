package com.labex.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

/**
 * 试卷题目关联实体类
 */
@Data
@TableName("t_paper_question")
public class PaperQuestion {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField("paper_id")
    private Integer paperId;

    @TableField("question_id")
    private Integer questionId;

    @TableField("sort")
    private Integer sort;

    @TableField("score")
    private Integer score;
}
