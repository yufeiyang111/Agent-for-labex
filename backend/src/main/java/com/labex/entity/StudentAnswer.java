package com.labex.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

/**
 * 学生答案记录表
 */
@Data
@TableName("t_student_answer")
public class StudentAnswer {

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @TableField("item_id")
    private Integer itemId;

    @TableField("fill_no")
    private Integer fillNo;

    @TableField("content")
    private String content;

    @TableField("content_hash")
    private String contentHash;

    @TableField("count")
    private Integer count;

    @TableField("is_correct")
    private Boolean isCorrect;
}
