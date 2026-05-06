package com.labex.vo;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 用户信息VO
 */
@Data
public class UserInfoVO {

    /**
     * 用户ID
     */
    private Integer id;

    /**
     * 账号/学号
     */
    private String account;

    /**
     * 姓名
     */
    private String name;

    /**
     * 角色：TEACHER, STUDENT, ADMIN
     */
    private String role;

    /**
     * 创建时间
     */
    private LocalDateTime createTime;

    // ========== 学生特有字段 ==========

    /**
     * 学号
     */
    private String studentNo;

    /**
     * 班级号
     */
    private String clazzNo;

    /**
     * 班级名称
     */
    private String clazzName;

    /**
     * 状态：0-正常，1-禁用
     */
    private Integer state;

    /**
     * 错误次数
     */
    private Integer errorCount;

    /**
     * IP地址
     */
    private String ip;

    // ========== 教师特有字段 ==========

    /**
     * 教师账号
     */
    private String teacherAccount;

    // ========== 通用字段 ==========

    /**
     * 头像URL
     */
    private String avatar;
}
