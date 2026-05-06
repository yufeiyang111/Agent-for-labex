package com.labex.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 学生实体类
 */
@Data
@TableName("t_student")
public class Student {

    @TableId(value = "student_id", type = IdType.AUTO)
    private Integer studentId;

    @TableField("student_no")
    private String studentNo;

    @TableField("student_name")
    private String studentName;

    @TableField("student_password")
    private String studentPassword;

    @TableField("clazz_no")
    private String clazzNo;

    @TableField("memo")
    private String memo;

    @TableField("state")
    private Integer state;

    @TableField("error_count")
    private Integer errorCount;

    @TableField("ip")
    private String ip;

    /**
     * 头像URL
     */
    @TableField("avatar")
    private String avatar;

    @TableField("create_time")
    private LocalDateTime createTime;

    @TableField("update_time")
    private LocalDateTime updateTime;

    @TableLogic
    @TableField(exist = false)
    private Integer deleted;
}
