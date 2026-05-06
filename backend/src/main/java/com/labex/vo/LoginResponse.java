package com.labex.vo;

import lombok.Data;

/**
 * 登录响应VO
 */
@Data
public class LoginResponse {

    /**
     * Token
     */
    private String token;

    /**
     * 用户信息
     */
    private UserInfoVO userInfo;

    /**
     * 过期时间（毫秒）
     */
    private Long expiresIn;
}
