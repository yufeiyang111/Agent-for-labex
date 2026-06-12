package com.labex.entity.teaching;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 课程实体（CTL-S1）
 */
@Data
@TableName("t_course")
public class Course {

    @TableId(value = "course_id", type = IdType.AUTO)
    private Integer courseId;

    @TableField("code")
    private String code;

    @TableField("name_cn")
    private String nameCn;

    @TableField("name_en")
    private String nameEn;

    @TableField("credit")
    private BigDecimal credit;

    @TableField("hours")
    private Integer hours;

    @TableField("theory_hours")
    private Integer theoryHours;

    @TableField("lab_hours")
    private Integer labHours;

    @TableField("major")
    private String major;

    @TableField("prerequisite")
    private String prerequisite;

    @TableField("department")
    private String department;

    @TableField("intro")
    private String intro;

    @TableField("owner_id")
    private Integer ownerId;

    @TableField("create_time")
    private LocalDateTime createTime;

    @TableField("update_time")
    private LocalDateTime updateTime;

    @TableLogic
    @TableField("deleted")
    private Integer deleted;
}
