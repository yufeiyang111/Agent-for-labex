package com.labex.util;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

/**
 * CurrentUser 工具类测试
 */
@DisplayName("CurrentUser 工具类测试")
class CurrentUserTest {

    @Test
    @DisplayName("UT-User-01: 学生用户 getUserId 应返回学生ID")
    void getUserId_StudentUser_ReturnsStudentId() {
        // Arrange - 模拟学生登录，username 为学号
        UserDetails studentDetails = User.builder()
                .username("2021001")
                .password("password")
                .authorities(new SimpleGrantedAuthority("ROLE_STUDENT"))
                .build();

        Authentication auth = new UsernamePasswordAuthenticationToken(
                studentDetails, null, studentDetails.getAuthorities());

        SecurityContext context = SecurityContextHolder.createEmptyContext();
        context.setAuthentication(auth);
        SecurityContextHolder.setContext(context);

        // Act
        Integer userId = CurrentUser.getUserId();

        // Assert - 学生的 userId 应该是从 username 解析出的数字
        assertNotNull(userId, "学生用户 getUserId 不应返回 null");
        assertEquals(2021001, userId, "学生 userId 应该等于学号");

        // Cleanup
        SecurityContextHolder.clearContext();
    }

    @Test
    @DisplayName("UT-User-02: 无认证信息时 getUserId 应返回 null")
    void getUserId_NoAuth_ReturnsNull() {
        // Arrange - 清除认证信息
        SecurityContextHolder.clearContext();

        // Act
        Integer userId = CurrentUser.getUserId();

        // Assert
        assertNull(userId, "无认证信息时应返回 null");
    }

    @Test
    @DisplayName("UT-User-03: getUsername 应返回当前用户名")
    void getUsername_ValidAuth_ReturnsUsername() {
        // Arrange
        UserDetails details = User.builder()
                .username("teacher1")
                .password("password")
                .authorities(new SimpleGrantedAuthority("ROLE_TEACHER"))
                .build();

        Authentication auth = new UsernamePasswordAuthenticationToken(
                details, null, details.getAuthorities());

        SecurityContext context = SecurityContextHolder.createEmptyContext();
        context.setAuthentication(auth);
        SecurityContextHolder.setContext(context);

        // Act
        String username = CurrentUser.getUsername();

        // Assert
        assertEquals("teacher1", username);

        // Cleanup
        SecurityContextHolder.clearContext();
    }
}
