package com.labex.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 教师/管理员实体类
 * role字段区分：TEACHER-普通教师，ADMIN-管理员
 */
@Data
@TableName("t_teacher")
public class Teacher {

    @TableId(value = "teacher_id", type = IdType.AUTO)
    private Integer teacherId;

    @TableField("teacher_account")
    private String teacherAccount;

    @TableField("teacher_password")
    private String teacherPassword;

    /**
     * 头像URL
     */
    @TableField("avatar")
    private String avatar;

    @TableField("teacher_name")
    private String teacherName;

    /**
     * 角色：TEACHER-普通教师，ADMIN-管理员
     */
    @TableField("role")
    private String role;

    /**
     * 状态：0-禁用，1-启用
     */
    @TableField("state")
    private Integer state;

    @TableField(exist = false)
    private LocalDateTime createTime;

    @TableField(exist = false)
    private LocalDateTime updateTime;

    @TableLogic
    @TableField(exist = false)
    private Integer deleted;

    /**
     * 判断是否为管理员
     */
    public boolean isAdmin() {
        return "ADMIN".equalsIgnoreCase(this.role);
    }
}
