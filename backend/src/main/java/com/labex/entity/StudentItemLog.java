package com.labex.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 学生答题日志表
 */
@Data
@TableName("t_student_item_log")
public class StudentItemLog {

    @TableId(value = "log_id", type = IdType.AUTO)
    private Long logId;

    @TableField("student_item")
    private Integer studentItem;

    @TableField("content")
    private String content;

    @TableField("fill_time")
    private LocalDateTime fillTime;
}
