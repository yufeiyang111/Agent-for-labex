package com.labex.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

/**
 * 讲义实体类
 */
@Data
@TableName("t_lecture")
public class Lecture {

    @TableId(value = "lecture_id", type = IdType.AUTO)
    private Integer lectureId;

    @TableField("lecture_name")
    private String lectureName;

    @TableField("lecture_type")
    private Integer lectureType;

    @TableField("category")
    private String category;

    @TableField("lecture_content")
    private String lectureContent;

    @TableField("lecture_filetype")
    private String lectureFiletype;

    @TableField("file_path")
    private String filePath;

    @TableField("file_size")
    private Long fileSize;

    @TableField("teacher_id")
    private Integer teacherId;

    /**
     * 是否已向量化（0-未处理，1-已向量化，2-向量化失败）
     */
    @TableField("vectorized")
    private Integer vectorized = 0;

    /**
     * Neo4j文档ID
     */
    @TableField("document_id")
    private String documentId;
}
