package com.labex.config;

import com.labex.rag.config.RagConfig;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.lang.reflect.Field;

import static org.junit.jupiter.api.Assertions.*;

/**
 * 硬编码配置检查测试
 * 验证关键配置项的默认值不包含硬编码的本地路径
 */
@DisplayName("硬编码配置检查测试")
class HardcodeConfigTest {

    @Test
    @DisplayName("UT-Config-01: RagConfig.uploadPath 默认值不应包含硬编码路径")
    void uploadPath_DefaultValue_ShouldNotContainHardcodedPath() throws Exception {
        // Arrange
        RagConfig config = new RagConfig();

        // Act
        String uploadPath = config.getUploadPath();

        // Assert
        assertNotNull(uploadPath, "uploadPath 不应为 null");
        assertFalse(uploadPath.contains("D:"), "uploadPath 默认值不应包含 Windows 盘符 (D:)");
        assertFalse(uploadPath.contains("workfordasan"), "uploadPath 默认值不应包含开发者目录名");
    }

    @Test
    @DisplayName("UT-Config-02: RagConfig 应支持通过 setter 覆盖 uploadPath")
    void uploadPath_ShouldBeOverridable() {
        // Arrange
        RagConfig config = new RagConfig();

        // Act
        config.setUploadPath("/tmp/custom-uploads");

        // Assert
        assertEquals("/tmp/custom-uploads", config.getUploadPath(), "uploadPath 应支持通过 setter 覆盖");
    }

    @Test
    @DisplayName("UT-Config-03: StudentProjectServiceImpl 的 projectBasePath 应使用 @Value 注入")
    void studentProjectBasePath_ShouldUseValueAnnotation() throws Exception {
        // Arrange - 检查字段是否有 @Value 注解
        Class<?> clazz = Class.forName("com.labex.service.impl.StudentProjectServiceImpl");
        Field field = clazz.getDeclaredField("projectBasePath");

        // Act
        boolean hasValueAnnotation = field.isAnnotationPresent(org.springframework.beans.factory.annotation.Value.class);

        // Assert
        assertTrue(hasValueAnnotation, "projectBasePath 应使用 @Value 注解以便配置覆盖");

        // 验证默认值不包含硬编码路径
        org.springframework.beans.factory.annotation.Value valueAnnotation =
                field.getAnnotation(org.springframework.beans.factory.annotation.Value.class);
        String defaultValue = valueAnnotation.value();
        assertFalse(defaultValue.contains("workfordasan"),
                "projectBasePath 默认值不应包含开发者目录名");
    }
}
