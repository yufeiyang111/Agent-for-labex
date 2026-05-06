package com.labex.entity;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import java.time.LocalDateTime;

/**
 * 作业实体类
 */
@Data
@TableName("t_homework")
public class Homework {

    @TableId(value = "homework_id", type = IdType.AUTO)
    private Integer homeworkId;

    @TableField("homework_name")
    private String homeworkName;

    @TableField("content")
    private String content;

    @TableField("deadline")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime deadline;

    @TableField("teacher_id")
    private Integer teacherId;

    @TableField("state")
    private Integer state;

    @TableField("total_score")
    private Integer totalScore;

    @TableField("create_time")
    private LocalDateTime createTime;

    @TableField("file_path")
    private String filePath;

    @TableField("file_size")
    private Long fileSize;
}
