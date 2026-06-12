package com.labex.entity.teaching;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 开课实例（CTL-S1）
 */
@Data
@TableName("t_course_offering")
public class CourseOffering {

    @TableId(value = "offering_id", type = IdType.AUTO)
    private Integer offeringId;

    @TableField("course_id")
    private Integer courseId;

    /** 班级编号，对应 t_clazz.no (String) */
    @TableField("clazz_no")
    private String clazzNo;

    @TableField("teacher_id")
    private Integer teacherId;

    @TableField("semester")
    private String semester;

    @TableField("student_count")
    private Integer studentCount;

    @TableField("status")
    private String status;

    @TableField("create_time")
    private LocalDateTime createTime;

    @TableField("update_time")
    private LocalDateTime updateTime;

    @TableLogic
    @TableField("deleted")
    private Integer deleted;
}
