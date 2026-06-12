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
     * 学生用户：username 就是学号，直接解析为 ID
     * 教师用户：username 是教师账号，需要调用方通过 TeacherService 查询
     */
    public static Integer getUserId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof UserDetails) {
            String username = ((UserDetails) authentication.getPrincipal()).getUsername();
            try {
                // 学生用户的 username 是学号（数字），可以直接解析为 ID
                return Integer.parseInt(username);
            } catch (NumberFormatException e) {
                // 教师用户的 username 是账号（非数字），返回 null
                // 调用方应通过 TeacherService.findByAccount() 查询
                return null;
            }
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