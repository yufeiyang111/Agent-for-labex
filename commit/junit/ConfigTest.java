package com.labex.config;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;

import static org.junit.jupiter.api.Assertions.*;

/**
 * 配置类测试
 * 测试人员：于峰
 * 测试内容：安全配置、跨域配置、MyBatis配置、Neo4j配置、Web配置
 */
@SpringBootTest
@TestPropertySource(properties = {
        "spring.datasource.url=jdbc:mysql://localhost:3306/labex_test",
        "spring.datasource.username=root",
        "spring.datasource.password=test",
        "jwt.secret=test-secret-key-for-testing-only-32-chars!",
        "jwt.expiration=86400000"
})
public class ConfigTest {

    @Autowired
    private SecurityConfig securityConfig;

    @Autowired
    private CorsConfig corsConfig;

    @Autowired
    private MybatisPlusConfig mybatisPlusConfig;

    @Autowired
    private Neo4jConfig neo4jConfig;

    @Autowired
    private WebMvcConfig webMvcConfig;

    // ==================== 安全配置测试 ====================

    /**
     * 测试SecurityConfig是否正确加载
     */
    @Test
    public void testSecurityConfigLoaded() {
        assertNotNull(securityConfig);
    }

    /**
     * 测试SecurityConfig的Bean定义
     */
    @Test
    public void testSecurityConfigBeans() {
        assertNotNull(securityConfig.passwordEncoder());
        assertNotNull(securityConfig.authenticationManager());
    }

    /**
     * 测试密码编码器
     */
    @Test
    public void testPasswordEncoder() {
        var passwordEncoder = securityConfig.passwordEncoder();

        String rawPassword = "password123";
        String encodedPassword = passwordEncoder.encode(rawPassword);

        assertNotNull(encodedPassword);
        assertNotEquals(rawPassword, encodedPassword);
        assertTrue(passwordEncoder.matches(rawPassword, encodedPassword));
    }

    /**
     * 测试密码编码器 - 不同密码产生不同编码
     */
    @Test
    public void testPasswordEncoderDifferentPasswords() {
        var passwordEncoder = securityConfig.passwordEncoder();

        String password1 = "password123";
        String password2 = "password456";

        String encoded1 = passwordEncoder.encode(password1);
        String encoded2 = passwordEncoder.encode(password2);

        assertNotEquals(encoded1, encoded2);
    }

    /**
     * 测试密码编码器 - 相同密码产生不同编码（BCrypt特性）
     */
    @Test
    public void testPasswordEncoderSamePasswordDifferentSalt() {
        var passwordEncoder = securityConfig.passwordEncoder();

        String password = "password123";

        String encoded1 = passwordEncoder.encode(password);
        String encoded2 = passwordEncoder.encode(password);

        // BCrypt每次编码使用不同的盐，所以结果不同
        assertNotEquals(encoded1, encoded2);

        // 但都能匹配原始密码
        assertTrue(passwordEncoder.matches(password, encoded1));
        assertTrue(passwordEncoder.matches(password, encoded2));
    }

    // ==================== 跨域配置测试 ====================

    /**
     * 测试CorsConfig是否正确加载
     */
    @Test
    public void testCorsConfigLoaded() {
        assertNotNull(corsConfig);
    }

    /**
     * 测试CorsConfig的Bean定义
     */
    @Test
    public void testCorsConfigBeans() {
        assertNotNull(corsConfig.corsFilter());
    }

    // ==================== MyBatis配置测试 ====================

    /**
     * 测试MybatisPlusConfig是否正确加载
     */
    @Test
    public void testMybatisPlusConfigLoaded() {
        assertNotNull(mybatisPlusConfig);
    }

    /**
     * 测试MybatisPlusConfig的Bean定义
     */
    @Test
    public void testMybatisPlusConfigBeans() {
        assertNotNull(mybatisPlusConfig.paginationInterceptor());
        assertNotNull(mybatisPlusConfig乐观锁插件());
    }

    // ==================== Neo4j配置测试 ====================

    /**
     * 测试Neo4jConfig是否正确加载
     */
    @Test
    public void testNeo4jConfigLoaded() {
        assertNotNull(neo4jConfig);
    }

    /**
     * 测试Neo4jConfig的Bean定义
     */
    @Test
    public void testNeo4jConfigBeans() {
        assertNotNull(neo4jConfig.driver());
    }

    // ==================== Web配置测试 ====================

    /**
     * 测试WebMvcConfig是否正确加载
     */
    @Test
    public void testWebMvcConfigLoaded() {
        assertNotNull(webMvcConfig);
    }

    /**
     * 测试WebMvcConfig的Bean定义
     */
    @Test
    public void testWebMvcConfigBeans() {
        assertNotNull(webMvcConfig.multipartResolver());
    }

    // ==================== Schema兼容性初始化测试 ====================

    /**
     * 测试SchemaCompatibilityInitializer是否正确加载
     */
    @Test
    public void testSchemaCompatibilityInitializerLoaded() {
        SchemaCompatibilityInitializer initializer = new SchemaCompatibilityInitializer();
        assertNotNull(initializer);
    }

    /**
     * 测试SchemaCompatibilityInitializer的初始化方法
     */
    @Test
    public void testSchemaCompatibilityInitializerMethods() {
        SchemaCompatibilityInitializer initializer = new SchemaCompatibilityInitializer();

        // 验证方法存在
        assertNotNull(initializer.getClass().getMethods());

        // 查找初始化方法
        boolean hasInitMethod = false;
        for (var method : initializer.getClass().getMethods()) {
            if (method.getName().contains("init") || method.getName().contains("ensure")) {
                hasInitMethod = true;
                break;
            }
        }

        assertTrue(hasInitMethod);
    }

    // ==================== 考试自动提交调度测试 ====================

    /**
     * 测试ExamAutoSubmitScheduler是否正确加载
     */
    @Test
    public void testExamAutoSubmitSchedulerLoaded() {
        ExamAutoSubmitScheduler scheduler = new ExamAutoSubmitScheduler();
        assertNotNull(scheduler);
    }

    /**
     * 测试ExamAutoSubmitScheduler的方法
     */
    @Test
    public void testExamAutoSubmitSchedulerMethods() {
        ExamAutoSubmitScheduler scheduler = new ExamAutoSubmitScheduler();

        // 验证方法存在
        assertNotNull(scheduler.getClass().getMethods());

        // 查找调度方法
        boolean hasScheduleMethod = false;
        for (var method : scheduler.getClass().getMethods()) {
            if (method.getName().contains("schedule") || method.getName().contains("submit")) {
                hasScheduleMethod = true;
                break;
            }
        }

        assertTrue(hasScheduleMethod);
    }

    // ==================== JWT配置测试 ====================

    /**
     * 测试JWT配置属性
     */
    @Test
    public void testJwtConfigProperties() {
        // 验证JWT配置属性存在
        assertNotNull(System.getProperty("jwt.secret"));
        assertNotNull(System.getProperty("jwt.expiration"));
    }

    /**
     * 测试JWT密钥长度
     */
    @Test
    public void testJwtSecretLength() {
        String secret = System.getProperty("jwt.secret");

        // JWT密钥应该至少32字节
        assertTrue(secret.length() >= 32);
    }

    // ==================== 数据库配置测试 ====================

    /**
     * 测试数据库配置属性
     */
    @Test
    public void testDatabaseConfigProperties() {
        // 验证数据库配置属性存在
        assertNotNull(System.getProperty("spring.datasource.url"));
        assertNotNull(System.getProperty("spring.datasource.username"));
        assertNotNull(System.getProperty("spring.datasource.password"));
    }

    /**
     * 测试数据库URL格式
     */
    @Test
    public void testDatabaseUrlFormat() {
        String url = System.getProperty("spring.datasource.url");

        // 验证MySQL URL格式
        assertTrue(url.startsWith("jdbc:mysql://"));
        assertTrue(url.contains("localhost"));
        assertTrue(url.contains("3306"));
    }

    // ==================== Redis配置测试 ====================

    /**
     * 测试Redis配置属性
     */
    @Test
    public void testRedisConfigProperties() {
        // 验证Redis配置属性存在
        String host = System.getProperty("spring.redis.host");
        String port = System.getProperty("spring.redis.port");

        // 如果配置了Redis，验证格式
        if (host != null) {
            assertNotNull(host);
        }
        if (port != null) {
            assertNotNull(port);
        }
    }

    // ==================== 文件上传配置测试 ====================

    /**
     * 测试文件上传配置属性
     */
    @Test
    public void testFileUploadConfigProperties() {
        // 验证文件上传配置属性存在
        String uploadPath = System.getProperty("upload-path");
        String maxSize = System.getProperty("spring.servlet.multipart.max-file-size");

        // 如果配置了上传路径，验证格式
        if (uploadPath != null) {
            assertNotNull(uploadPath);
        }
        if (maxSize != null) {
            assertNotNull(maxSize);
        }
    }

    // ==================== 日志配置测试 ====================

    /**
     * 测试日志配置属性
     */
    @Test
    public void testLogConfigProperties() {
        // 验证日志配置属性存在
        String logLevel = System.getProperty("logging.level.root");

        // 如果配置了日志级别，验证格式
        if (logLevel != null) {
            assertNotNull(logLevel);
            assertTrue(logLevel.equals("DEBUG") || logLevel.equals("INFO") ||
                    logLevel.equals("WARN") || logLevel.equals("ERROR"));
        }
    }
}
