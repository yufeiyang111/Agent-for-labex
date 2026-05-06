package com.labex.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@TableName("t_question_test_case")
public class QuestionTestCase {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField("question_id")
    private Integer questionId;

    @TableField("input")
    private String input;

    @TableField("expected_output")
    private String expectedOutput;

    @TableField("score_weight")
    private Integer scoreWeight;

    @TableField("sort_index")
    private Integer sortIndex;

    @TableField("created_at")
    private LocalDateTime createdAt;
}