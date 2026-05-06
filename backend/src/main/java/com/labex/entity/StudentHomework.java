package com.labex.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

/**
 * 学生作业提交记录实体类
 */
@Data
@TableName("t_student_homework")
public class StudentHomework {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField("homework_id")
    private Integer homeworkId;

    @TableField("student_id")
    private Integer studentId;

    @TableField("content")
    private String content;

    @TableField("file_path")
    private String filePath;

    @TableField("file_size")
    private Long fileSize;

    @TableField("submit_time")
    private LocalDateTime submitTime;

    @TableField("score")
    private Integer score;

    @TableField("remark")
    private String remark;

    @TableField(exist = false)
    private String studentName;

    @TableField(exist = false)
    private String homeworkName;

    @TableField(exist = false)
    private LocalDateTime deadline;
}
