package com.labex;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.lang.reflect.Field;
import java.nio.file.Files;
import java.nio.file.Path;

import static org.junit.jupiter.api.Assertions.*;

/**
 * PasswordEncoderUtil 安全检查测试
 */
@DisplayName("PasswordEncoderUtil 安全检查测试")
class PasswordEncoderUtilTest {

    @Test
    @DisplayName("UT-Password-01: 源代码不应包含硬编码密码")
    void sourceCode_ShouldNotContainHardcodedPasswords() throws Exception {
        // 读取源文件
        Path sourcePath = Path.of("src/main/java/com/labex/PasswordEncoderUtil.java");
        String sourceCode = Files.readString(sourcePath);

        // 检查不应包含的硬编码密码
        assertFalse(sourceCode.contains("\"root\""), "源代码不应包含硬编码密码 \"root\"");
        assertFalse(sourceCode.contains("\"admin\""), "源代码不应包含硬编码密码 \"admin\"");
        assertFalse(sourceCode.contains("\"123456\""), "源代码不应包含硬编码密码 \"123456\"");
    }

    @Test
    @DisplayName("UT-Password-02: PasswordEncoderUtil 应能正常加密密码")
    void encode_ShouldEncryptPassword() {
        // Act - 使用反射调用 encoder
        try {
            Field encoderField = PasswordEncoderUtil.class.getDeclaredField("encoder");
            encoderField.setAccessible(true);
            org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder encoder =
                    (org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder) encoderField.get(null);

            // 测试加密功能
            String rawPassword = "testPassword123";
            String encoded = encoder.encode(rawPassword);

            // Assert
            assertNotNull(encoded, "加密结果不应为 null");
            assertNotEquals(rawPassword, encoded, "加密后的密码不应与原密码相同");
            assertTrue(encoder.matches(rawPassword, encoded), "加密后的密码应能通过验证");
        } catch (Exception e) {
            fail("无法访问 encoder: " + e.getMessage());
        }
    }
}
