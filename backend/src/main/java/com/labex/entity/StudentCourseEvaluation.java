package com.labex.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 学生课程评价实体类
 */
@Data
@TableName("t_student_course_evaluation")
public class StudentCourseEvaluation {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField("offering_id")
    private Integer offeringId;

    @TableField("student_id")
    private Integer studentId;

    @TableField("teaching_quality")
    private Integer teachingQuality;

    @TableField("course_content")
    private Integer courseContent;

    @TableField("learning_resources")
    private Integer learningResources;

    @TableField("assessment_method")
    private Integer assessmentMethod;

    @TableField("learning_effect")
    private Integer learningEffect;

    @TableField("overall_satisfaction")
    private Integer overallSatisfaction;

    @TableField("comment")
    private String comment;

    @TableField("suggestion")
    private String suggestion;

    @TableField("create_time")
    private LocalDateTime createTime;

    @TableLogic
    @TableField("deleted")
    private Integer deleted;
}
