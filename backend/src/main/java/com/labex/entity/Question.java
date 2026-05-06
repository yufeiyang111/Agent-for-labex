package com.labex.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

/**
 * 题库实体类
 */
@Data
@TableName("t_question")
public class Question {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField("question")
    private String question;

    @TableField("answer")
    private String answer;

    @TableField("type")
    private Integer type;

    @TableField("score")
    private Integer score;

    @TableField("analysis")
    private String analysis;

    @TableField("options")
    private String options;

    @TableField("is_programming")
    private Integer isProgramming;

    @TableField("language")
    private String language;

    @TableField("template_code")
    private String templateCode;

    @TableField("io_mode")
    private String ioMode;

    @TableField("teacher_id")
    private Integer teacherId;

    @TableField("state")
    private Integer state;

    @TableField(exist = false)
    private String typeName;

    @TableField(exist = false)
    private String teacherName;
}
