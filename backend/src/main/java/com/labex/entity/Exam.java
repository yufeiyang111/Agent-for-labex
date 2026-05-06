package com.labex.entity;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;

/**
 * 考试实体类
 */
@Data
@TableName("t_exam")
public class Exam {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField("exam_name")
    private String examName;

    @TableField("description")
    private String description;

    @TableField("duration")
    private Integer duration;

    @TableField("time")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Shanghai")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime time;

    @TableField("end_time")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Shanghai")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime endTime;

    @TableField("paper_id")
    private Integer paperId;

    @TableField("total_score")
    private Integer totalScore;

    @TableField("state")
    private Integer state;

    @TableField("teacher_id")
    private Integer teacherId;

    @TableField("total_times")
    private Integer totalTimes;

    @TableField(exist = false)
    private String paperName;

    @TableField(exist = false)
    private Integer totalQuestions;

    @TableField(exist = false)
    private Integer myScore;
}
