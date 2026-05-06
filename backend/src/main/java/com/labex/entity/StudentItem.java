package com.labex.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 学生答题实体类
 */
@Data
@TableName("t_student_item")
public class StudentItem {

    @TableId(value = "student_item_id", type = IdType.AUTO)
    private Integer studentItemId;

    @TableField("student_id")
    private Integer studentId;

    @TableField("item_id")
    private Integer itemId;

    @TableField("content")
    private String content;

    @TableField("score")
    private Integer score;

    @TableField("fill_time")
    private LocalDateTime fillTime;

    @TableField("score_flag")
    private Integer scoreFlag;
}
