package com.labex.entity.teaching;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 课程目标（CTL-S2）
 */
@Data
@TableName("t_course_objective")
public class CourseObjective {

    @TableId(value = "objective_id", type = IdType.AUTO)
    private Integer objectiveId;

    @TableField("course_id")
    private Integer courseId;

    @TableField("code")
    private String code;

    /** knowledge / ability / quality */
    @TableField("category")
    private String category;

    @TableField("description")
    private String description;

    @TableField("sort_order")
    private Integer sortOrder;

    @TableField("create_time")
    private LocalDateTime createTime;

    @TableField("update_time")
    private LocalDateTime updateTime;

    @TableLogic
    @TableField("deleted")
    private Integer deleted;
}
