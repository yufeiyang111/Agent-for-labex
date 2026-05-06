package com.labex.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

/**
 * 学生班级关联实体（多对多）
 */
@Data
@TableName("t_student_clazz")
public class StudentClazz {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField("student_id")
    private Integer studentId;

    @TableField("clazz_no")
    private String clazzNo;

    @TableField("teacher_id")
    private Integer teacherId;

    @TableField(exist = false)
    private String studentName;

    @TableField(exist = false)
    private String studentNo;

    @TableField(exist = false)
    private String clazzName;
}
