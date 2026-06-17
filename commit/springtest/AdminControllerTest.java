package com.labex.controller.admin;

import com.labex.dto.LoginRequest;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * 管理员控制器测试类
 * 测试人员：余飞杨
 * 测试内容：管理员仪表板、教师管理、学生管理、班级管理
 */
@SpringBootTest
@AutoConfigureMockMvc
public class AdminControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    private String adminToken;

    @BeforeEach
    public void setUp() throws Exception {
        // 管理员登录获取Token
        LoginRequest loginRequest = new LoginRequest();
        loginRequest.setUsername("admin");
        loginRequest.setPassword("admin123");

        MvcResult loginResult = mockMvc.perform(post("/api/auth/login")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(loginRequest)))
                .andExpect(status().isOk())
                .andReturn();

        String responseBody = loginResult.getResponse().getContentAsString();
        adminToken = objectMapper.readTree(responseBody).path("data").path("token").asText();
    }

    /**
     * 测试获取管理员仪表板数据
     */
    @Test
    public void testGetDashboard() throws Exception {
        mockMvc.perform(get("/api/admin/dashboard")
                .header("Authorization", "Bearer " + adminToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isNotEmpty());
    }

    /**
     * 测试获取教师列表
     */
    @Test
    public void testGetTeacherList() throws Exception {
        mockMvc.perform(get("/api/admin/teachers")
                .header("Authorization", "Bearer " + adminToken)
                .param("page", "1")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.records").isArray());
    }

    /**
     * 测试获取教师详情
     */
    @Test
    public void testGetTeacherDetail() throws Exception {
        mockMvc.perform(get("/api/admin/teachers/1")
                .header("Authorization", "Bearer " + adminToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isNotEmpty());
    }

    /**
     * 测试创建教师
     */
    @Test
    public void testCreateTeacher() throws Exception {
        String teacherJson = "{" +
                "\"name\": \"测试教师\"," +
                "\"account\": \"testteacher\"," +
                "\"password\": \"password123\"," +
                "\"email\": \"test@example.com\"," +
                "\"phone\": \"13800138000\"" +
                "}";

        mockMvc.perform(post("/api/admin/teachers")
                .header("Authorization", "Bearer " + adminToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(teacherJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试更新教师信息
     */
    @Test
    public void testUpdateTeacher() throws Exception {
        String teacherJson = "{" +
                "\"name\": \"更新教师\"," +
                "\"email\": \"update@example.com\"," +
                "\"phone\": \"13900139000\"" +
                "}";

        mockMvc.perform(put("/api/admin/teachers/1")
                .header("Authorization", "Bearer " + adminToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(teacherJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试删除教师
     */
    @Test
    public void testDeleteTeacher() throws Exception {
        mockMvc.perform(delete("/api/admin/teachers/1")
                .header("Authorization", "Bearer " + adminToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试获取学生列表
     */
    @Test
    public void testGetStudentList() throws Exception {
        mockMvc.perform(get("/api/admin/students")
                .header("Authorization", "Bearer " + adminToken)
                .param("page", "1")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.records").isArray());
    }

    /**
     * 测试获取学生详情
     */
    @Test
    public void testGetStudentDetail() throws Exception {
        mockMvc.perform(get("/api/admin/students/1")
                .header("Authorization", "Bearer " + adminToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isNotEmpty());
    }

    /**
     * 测试批量导入学生
     */
    @Test
    public void testBatchImportStudents() throws Exception {
        String studentsJson = "[" +
                "{\"name\": \"学生1\", \"studentNo\": \"2024001\", \"clazzId\": 1}," +
                "{\"name\": \"学生2\", \"studentNo\": \"2024002\", \"clazzId\": 1}" +
                "]";

        mockMvc.perform(post("/api/admin/students/batch-import")
                .header("Authorization", "Bearer " + adminToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(studentsJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试获取班级列表
     */
    @Test
    public void testGetClazzList() throws Exception {
        mockMvc.perform(get("/api/admin/clazzs")
                .header("Authorization", "Bearer " + adminToken)
                .param("page", "1")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.records").isArray());
    }

    /**
     * 测试创建班级
     */
    @Test
    public void testCreateClazz() throws Exception {
        String clazzJson = "{" +
                "\"name\": \"测试班级\"," +
                "\"grade\": \"2024\"," +
                "\"major\": \"计算机科学与技术\"" +
                "}";

        mockMvc.perform(post("/api/admin/clazzs")
                .header("Authorization", "Bearer " + adminToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(clazzJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试未授权访问
     */
    @Test
    public void testUnauthorizedAccess() throws Exception {
        mockMvc.perform(get("/api/admin/dashboard"))
                .andExpect(status().isUnauthorized());
    }

    /**
     * 测试教师权限访问管理员接口
     */
    @Test
    public void testTeacherAccessAdminApi() throws Exception {
        // 教师登录
        LoginRequest loginRequest = new LoginRequest();
        loginRequest.setUsername("teacher");
        loginRequest.setPassword("teacher123");

        MvcResult loginResult = mockMvc.perform(post("/api/auth/login")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(loginRequest)))
                .andExpect(status().isOk())
                .andReturn();

        String responseBody = loginResult.getResponse().getContentAsString();
        String teacherToken = objectMapper.readTree(responseBody).path("data").path("token").asText();

        // 教师访问管理员接口
        mockMvc.perform(get("/api/admin/dashboard")
                .header("Authorization", "Bearer " + teacherToken))
                .andExpect(status().isForbidden());
    }
}
