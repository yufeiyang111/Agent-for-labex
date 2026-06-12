package com.labex.entity.teaching;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 大纲章节（CTL-S1）
 */
@Data
@TableName("t_syllabus_chapter")
public class SyllabusChapter {

    @TableId(value = "chapter_id", type = IdType.AUTO)
    private Integer chapterId;

    @TableField("syllabus_id")
    private Integer syllabusId;

    @TableField("chapter_no")
    private String chapterNo;

    @TableField("topic")
    private String topic;

    @TableField("knowledge_requirements")
    private String knowledgeRequirements;

    @TableField("ideological_elements")
    private String ideologicalElements;

    @TableField("recommended_hours")
    private Integer recommendedHours;

    @TableField("teaching_method")
    private String teachingMethod;

    /** 对应课程目标编号，如 "课程目标1,课程目标2" */
    @TableField("objective_ref")
    private String objectiveRef;

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
