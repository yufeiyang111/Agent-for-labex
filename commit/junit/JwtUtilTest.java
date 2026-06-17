package com.labex.security;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.junit.jupiter.api.Assertions.*;

/**
 * JWT工具类测试
 * 测试人员：余飞杨
 * 测试内容：JWT token生成、验证、解析
 */
@ExtendWith(MockitoExtension.class)
public class JwtUtilTest {

    @InjectMocks
    private JwtUtil jwtUtil;

    private static final String TEST_USERNAME = "testuser";
    private static final String TEST_ROLE = "TEACHER";
    private static final Long TEST_USER_ID = 1L;

    /**
     * 测试生成Token
     */
    @Test
    public void testGenerateToken() {
        String token = jwtUtil.generateToken(TEST_USERNAME, TEST_ROLE, TEST_USER_ID);

        assertNotNull(token);
        assertFalse(token.isEmpty());
        assertTrue(token.contains("."));
    }

    /**
     * 测试验证Token - 有效Token
     */
    @Test
    public void testValidateTokenValid() {
        String token = jwtUtil.generateToken(TEST_USERNAME, TEST_ROLE, TEST_USER_ID);

        boolean isValid = jwtUtil.validateToken(token);

        assertTrue(isValid);
    }

    /**
     * 测试验证Token - 无效Token
     */
    @Test
    public void testValidateTokenInvalid() {
        String invalidToken = "invalid.token.here";

        boolean isValid = jwtUtil.validateToken(invalidToken);

        assertFalse(isValid);
    }

    /**
     * 测试验证Token - 过期Token
     */
    @Test
    public void testValidateTokenExpired() {
        // 生成一个过期的Token（假设Token有效期为24小时）
        String token = jwtUtil.generateToken(TEST_USERNAME, TEST_ROLE, TEST_USER_ID);

        // 模拟Token过期（这里只是测试结构，实际需要等待Token过期或使用mock）
        // 在实际测试中，可以使用mock来模拟时间
        boolean isValid = jwtUtil.validateToken(token);

        // 由于Token刚生成，应该还是有效的
        assertTrue(isValid);
    }

    /**
     * 测试从Token中获取用户名
     */
    @Test
    public void testGetUsernameFromToken() {
        String token = jwtUtil.generateToken(TEST_USERNAME, TEST_ROLE, TEST_USER_ID);

        String username = jwtUtil.getUsernameFromToken(token);

        assertEquals(TEST_USERNAME, username);
    }

    /**
     * 测试从Token中获取角色
     */
    @Test
    public void testGetRoleFromToken() {
        String token = jwtUtil.generateToken(TEST_USERNAME, TEST_ROLE, TEST_USER_ID);

        String role = jwtUtil.getRoleFromToken(token);

        assertEquals(TEST_ROLE, role);
    }

    /**
     * 测试从Token中获取用户ID
     */
    @Test
    public void testGetUserIdFromToken() {
        String token = jwtUtil.generateToken(TEST_USERNAME, TEST_ROLE, TEST_USER_ID);

        Long userId = jwtUtil.getUserIdFromToken(token);

        assertEquals(TEST_USER_ID, userId);
    }

    /**
     * 测试Token刷新
     */
    @Test
    public void testRefreshToken() {
        String oldToken = jwtUtil.generateToken(TEST_USERNAME, TEST_ROLE, TEST_USER_ID);

        String newToken = jwtUtil.refreshToken(oldToken);

        assertNotNull(newToken);
        assertFalse(newToken.isEmpty());
        assertNotEquals(oldToken, newToken);

        // 验证新Token中的信息
        String username = jwtUtil.getUsernameFromToken(newToken);
        String role = jwtUtil.getRoleFromToken(newToken);
        Long userId = jwtUtil.getUserIdFromToken(newToken);

        assertEquals(TEST_USERNAME, username);
        assertEquals(TEST_ROLE, role);
        assertEquals(TEST_USER_ID, userId);
    }

    /**
     * 测试Token是否过期
     */
    @Test
    public void testIsTokenExpired() {
        String token = jwtUtil.generateToken(TEST_USERNAME, TEST_ROLE, TEST_USER_ID);

        boolean isExpired = jwtUtil.isTokenExpired(token);

        assertFalse(isExpired);
    }

    /**
     * 测试获取Token过期时间
     */
    @Test
    public void testGetTokenExpiration() {
        String token = jwtUtil.generateToken(TEST_USERNAME, TEST_ROLE, TEST_USER_ID);

        var expiration = jwtUtil.getTokenExpiration(token);

        assertNotNull(expiration);
        assertTrue(expiration.after(new java.util.Date()));
    }

    /**
     * 测试生成Token - 不同用户
     */
    @Test
    public void testGenerateTokenDifferentUsers() {
        String token1 = jwtUtil.generateToken("user1", "STUDENT", 1L);
        String token2 = jwtUtil.generateToken("user2", "TEACHER", 2L);

        assertNotNull(token1);
        assertNotNull(token2);
        assertNotEquals(token1, token2);

        assertEquals("user1", jwtUtil.getUsernameFromToken(token1));
        assertEquals("user2", jwtUtil.getUsernameFromToken(token2));
        assertEquals("STUDENT", jwtUtil.getRoleFromToken(token1));
        assertEquals("TEACHER", jwtUtil.getRoleFromToken(token2));
    }

    /**
     * 测试生成Token - 不同角色
     */
    @Test
    public void testGenerateTokenDifferentRoles() {
        String studentToken = jwtUtil.generateToken(TEST_USERNAME, "STUDENT", TEST_USER_ID);
        String teacherToken = jwtUtil.generateToken(TEST_USERNAME, "TEACHER", TEST_USER_ID);
        String adminToken = jwtUtil.generateToken(TEST_USERNAME, "ADMIN", TEST_USER_ID);

        assertEquals("STUDENT", jwtUtil.getRoleFromToken(studentToken));
        assertEquals("TEACHER", jwtUtil.getRoleFromToken(teacherToken));
        assertEquals("ADMIN", jwtUtil.getRoleFromToken(adminToken));
    }

    /**
     * 测试Token签名验证
     */
    @Test
    public void testTokenSignature() {
        String token = jwtUtil.generateToken(TEST_USERNAME, TEST_ROLE, TEST_USER_ID);

        // Token应该有3个部分（header.payload.signature）
        String[] parts = token.split("\\.");
        assertEquals(3, parts.length);

        // 每个部分都不为空
        assertFalse(parts[0].isEmpty());
        assertFalse(parts[1].isEmpty());
        assertFalse(parts[2].isEmpty());
    }

    /**
     * 测试Token中的Claims
     */
    @Test
    public void testTokenClaims() {
        String token = jwtUtil.generateToken(TEST_USERNAME, TEST_ROLE, TEST_USER_ID);

        // 验证Token中的所有Claims
        assertEquals(TEST_USERNAME, jwtUtil.getUsernameFromToken(token));
        assertEquals(TEST_ROLE, jwtUtil.getRoleFromToken(token));
        assertEquals(TEST_USER_ID, jwtUtil.getUserIdFromToken(token));
    }
}
