package com.labex.entity.teaching;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 课程大纲（CTL-S1）
 */
@Data
@TableName("t_syllabus")
public class Syllabus {

    @TableId(value = "syllabus_id", type = IdType.AUTO)
    private Integer syllabusId;

    @TableField("course_id")
    private Integer courseId;

    @TableField("course_intro")
    private String courseIntro;

    @TableField("main_task")
    private String mainTask;

    @TableField("knowledge_goals")
    private String knowledgeGoals;

    @TableField("ability_goals")
    private String abilityGoals;

    @TableField("quality_goals")
    private String qualityGoals;

    @TableField("teaching_methods")
    private String teachingMethods;

    @TableField("exercise_requirements")
    private String exerciseRequirements;

    @TableField("assessment_methods")
    private String assessmentMethods;

    @TableField("achievement_formula")
    private String achievementFormula;

    @TableField("textbooks")
    private String textbooks;

    @TableField("references_list")
    private String referencesList;

    @TableField("version")
    private Integer version;

    @TableField("create_time")
    private LocalDateTime createTime;

    @TableField("update_time")
    private LocalDateTime updateTime;

    @TableLogic
    @TableField("deleted")
    private Integer deleted;
}
