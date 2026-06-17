package com.labex.controller.student;

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
 * 学生控制器测试类
 * 测试人员：杨宇润
 * 测试内容：学生个人信息、考试、作业、训练、项目
 */
@SpringBootTest
@AutoConfigureMockMvc
public class StudentControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    private String studentToken;

    @BeforeEach
    public void setUp() throws Exception {
        // 学生登录获取Token
        LoginRequest loginRequest = new LoginRequest();
        loginRequest.setUsername("student");
        loginRequest.setPassword("student123");

        MvcResult loginResult = mockMvc.perform(post("/api/auth/login")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(loginRequest)))
                .andExpect(status().isOk())
                .andReturn();

        String responseBody = loginResult.getResponse().getContentAsString();
        studentToken = objectMapper.readTree(responseBody).path("data").path("token").asText();
    }

    // ==================== 学生个人信息测试 ====================

    /**
     * 测试获取学生个人信息
     */
    @Test
    public void testGetStudentProfile() throws Exception {
        mockMvc.perform(get("/api/student/profile")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isNotEmpty());
    }

    /**
     * 测试更新学生个人信息
     */
    @Test
    public void testUpdateStudentProfile() throws Exception {
        String profileJson = "{" +
                "\"email\": \"student@example.com\"," +
                "\"phone\": \"13800138000\"" +
                "}";

        mockMvc.perform(put("/api/student/profile")
                .header("Authorization", "Bearer " + studentToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(profileJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    // ==================== 学生考试测试 ====================

    /**
     * 测试获取考试列表
     */
    @Test
    public void testGetExamList() throws Exception {
        mockMvc.perform(get("/api/student/exams")
                .header("Authorization", "Bearer " + studentToken)
                .param("page", "1")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.records").isArray());
    }

    /**
     * 测试获取考试详情
     */
    @Test
    public void testGetExamDetail() throws Exception {
        mockMvc.perform(get("/api/student/exams/1")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isNotEmpty());
    }

    /**
     * 测试开始考试
     */
    @Test
    public void testStartExam() throws Exception {
        mockMvc.perform(post("/api/student/exams/1/start")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试提交考试答案
     */
    @Test
    public void testSubmitExamAnswer() throws Exception {
        String answerJson = "{" +
                "\"examId\": 1," +
                "\"answers\": [" +
                "{\"questionId\": 1, \"answer\": \"A\"}," +
                "{\"questionId\": 2, \"answer\": \"B\"}" +
                "]" +
                "}";

        mockMvc.perform(post("/api/student/exams/1/submit")
                .header("Authorization", "Bearer " + studentToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(answerJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试获取考试结果
     */
    @Test
    public void testGetExamResult() throws Exception {
        mockMvc.perform(get("/api/student/exams/1/result")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    // ==================== 学生作业测试 ====================

    /**
     * 测试获取作业列表
     */
    @Test
    public void testGetHomeworkList() throws Exception {
        mockMvc.perform(get("/api/student/homeworks")
                .header("Authorization", "Bearer " + studentToken)
                .param("page", "1")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.records").isArray());
    }

    /**
     * 测试获取作业详情
     */
    @Test
    public void testGetHomeworkDetail() throws Exception {
        mockMvc.perform(get("/api/student/homeworks/1")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isNotEmpty());
    }

    /**
     * 测试提交作业答案
     */
    @Test
    public void testSubmitHomeworkAnswer() throws Exception {
        String answerJson = "{" +
                "\"homeworkId\": 1," +
                "\"answers\": [" +
                "{\"questionId\": 1, \"answer\": \"答案1\"}," +
                "{\"questionId\": 2, \"answer\": \"答案2\"}" +
                "]" +
                "}";

        mockMvc.perform(post("/api/student/homeworks/1/submit")
                .header("Authorization", "Bearer " + studentToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(answerJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试获取作业结果
     */
    @Test
    public void testGetHomeworkResult() throws Exception {
        mockMvc.perform(get("/api/student/homeworks/1/result")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    // ==================== 学生训练测试 ====================

    /**
     * 测试获取训练列表
     */
    @Test
    public void testGetTrainingList() throws Exception {
        mockMvc.perform(get("/api/student/trainings")
                .header("Authorization", "Bearer " + studentToken)
                .param("page", "1")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.records").isArray());
    }

    /**
     * 测试获取训练详情
     */
    @Test
    public void testGetTrainingDetail() throws Exception {
        mockMvc.perform(get("/api/student/trainings/1")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isNotEmpty());
    }

    /**
     * 测试开始训练
     */
    @Test
    public void testStartTraining() throws Exception {
        mockMvc.perform(post("/api/student/trainings/1/start")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试提交训练答案
     */
    @Test
    public void testSubmitTrainingAnswer() throws Exception {
        String answerJson = "{" +
                "\"trainingId\": 1," +
                "\"answers\": [" +
                "{\"questionId\": 1, \"answer\": \"A\"}," +
                "{\"questionId\": 2, \"answer\": \"B\"}" +
                "]" +
                "}";

        mockMvc.perform(post("/api/student/trainings/1/submit")
                .header("Authorization", "Bearer " + studentToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(answerJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试获取训练结果
     */
    @Test
    public void testGetTrainingResult() throws Exception {
        mockMvc.perform(get("/api/student/trainings/1/result")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    // ==================== 学生项目测试 ====================

    /**
     * 测试获取项目列表
     */
    @Test
    public void testGetProjectList() throws Exception {
        mockMvc.perform(get("/api/student/projects")
                .header("Authorization", "Bearer " + studentToken)
                .param("page", "1")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.records").isArray());
    }

    /**
     * 测试创建项目
     */
    @Test
    public void testCreateProject() throws Exception {
        String projectJson = "{" +
                "\"name\": \"Java项目\"," +
                "\"description\": \"Java基础项目\"" +
                "}";

        mockMvc.perform(post("/api/student/projects")
                .header("Authorization", "Bearer " + studentToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(projectJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试获取项目详情
     */
    @Test
    public void testGetProjectDetail() throws Exception {
        mockMvc.perform(get("/api/student/projects/1")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isNotEmpty());
    }

    /**
     * 测试删除项目
     */
    @Test
    public void testDeleteProject() throws Exception {
        mockMvc.perform(delete("/api/student/projects/1")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    // ==================== 学生课程测试 ====================

    /**
     * 测试获取课程列表
     */
    @Test
    public void testGetCourseList() throws Exception {
        mockMvc.perform(get("/api/student/courses")
                .header("Authorization", "Bearer " + studentToken)
                .param("page", "1")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.records").isArray());
    }

    /**
     * 测试获取课程详情
     */
    @Test
    public void testGetCourseDetail() throws Exception {
        mockMvc.perform(get("/api/student/courses/1")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isNotEmpty());
    }

    // ==================== 学生讲义测试 ====================

    /**
     * 测试获取讲义列表
     */
    @Test
    public void testGetLectureList() throws Exception {
        mockMvc.perform(get("/api/student/lectures")
                .header("Authorization", "Bearer " + studentToken)
                .param("page", "1")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.records").isArray());
    }

    /**
     * 测试获取讲义详情
     */
    @Test
    public void testGetLectureDetail() throws Exception {
        mockMvc.perform(get("/api/student/lectures/1")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isNotEmpty());
    }
}
