package com.labex.util;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

/**
 * 当前用户工具类
 */
public class CurrentUser {

    /**
     * 获取当前登录用户的ID
     */
    public static Integer getUserId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            String username = ((UserDetails) authentication.getPrincipal()).getUsername();
            // 从token中解析userId（通过username查询或从其他途径获取）
            // 这里暂时返回null，实际情况由调用方处理
            return null;
        }
        return null;
    }

    /**
     * 获取当前登录用户的账号
     */
    public static String getUsername() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            return ((UserDetails) authentication.getPrincipal()).getUsername();
        }
        return null;
    }

    /**
     * 获取当前登录用户的角色
     */
    public static String getRole() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null) {
            return authentication.getAuthorities().iterator().next().getAuthority();
        }
        return null;
    }
}