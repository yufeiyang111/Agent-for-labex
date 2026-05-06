package com.labex.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

/**
 * 学生练习表（兼容旧系统）
 */
@Data
@TableName("t_student_excercise")
public class StudentExcercise {

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @TableField("item_id")
    private Integer itemId;

    @TableField("student_id")
    private Integer studentId;

    @TableField("answer")
    private String answer;

    @TableField("content")
    private String content;

    @TableField("score")
    private Integer score;

    @TableField("fill_time")
    private LocalDateTime fillTime;
}
