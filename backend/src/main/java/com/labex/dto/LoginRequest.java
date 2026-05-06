package com.labex.dto;

import lombok.Data;

/**
 * 登录请求DTO
 */
@Data
public class LoginRequest {

    /**
     * 账号
     */
    private String account;

    /**
     * 密码
     */
    private String password;

    /**
     * 角色：TEACHER(教师), STUDENT(学生)
     */
    private String role;
}
