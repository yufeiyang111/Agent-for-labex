package com.labex.controller.teacher;

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
 * 教师控制器测试类
 * 测试人员：周志文、杨宇润
 * 测试内容：班级管理、考试管理、实验管理、题目管理、试卷管理、成绩管理、作业管理、训练集管理、讲义管理
 */
@SpringBootTest
@AutoConfigureMockMvc
public class TeacherControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    private String teacherToken;

    @BeforeEach
    public void setUp() throws Exception {
        // 教师登录获取Token
        LoginRequest loginRequest = new LoginRequest();
        loginRequest.setUsername("teacher");
        loginRequest.setPassword("teacher123");

        MvcResult loginResult = mockMvc.perform(post("/api/auth/login")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(loginRequest)))
                .andExpect(status().isOk())
                .andReturn();

        String responseBody = loginResult.getResponse().getContentAsString();
        teacherToken = objectMapper.readTree(responseBody).path("data").path("token").asText();
    }

    // ==================== 班级管理测试（周志文） ====================

    /**
     * 测试获取班级列表
     */
    @Test
    public void testGetClazzList() throws Exception {
        mockMvc.perform(get("/api/teacher/clazzs")
                .header("Authorization", "Bearer " + teacherToken)
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

        mockMvc.perform(post("/api/teacher/clazzs")
                .header("Authorization", "Bearer " + teacherToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(clazzJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试更新班级信息
     */
    @Test
    public void testUpdateClazz() throws Exception {
        String clazzJson = "{" +
                "\"name\": \"更新班级\"," +
                "\"grade\": \"2024\"," +
                "\"major\": \"软件工程\"" +
                "}";

        mockMvc.perform(put("/api/teacher/clazzs/1")
                .header("Authorization", "Bearer " + teacherToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(clazzJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试删除班级
     */
    @Test
    public void testDeleteClazz() throws Exception {
        mockMvc.perform(delete("/api/teacher/clazzs/1")
                .header("Authorization", "Bearer " + teacherToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    // ==================== 考试管理测试（周志文） ====================

    /**
     * 测试获取考试列表
     */
    @Test
    public void testGetExamList() throws Exception {
        mockMvc.perform(get("/api/teacher/exams")
                .header("Authorization", "Bearer " + teacherToken)
                .param("page", "1")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.records").isArray());
    }

    /**
     * 测试创建考试
     */
    @Test
    public void testCreateExam() throws Exception {
        String examJson = "{" +
                "\"name\": \"期中考试\"," +
                "\"courseId\": 1," +
                "\"startTime\": \"2024-10-01 09:00:00\"," +
                "\"endTime\": \"2024-10-01 11:00:00\"," +
                "\"duration\": 120" +
                "}";

        mockMvc.perform(post("/api/teacher/exams")
                .header("Authorization", "Bearer " + teacherToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(examJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试更新考试信息
     */
    @Test
    public void testUpdateExam() throws Exception {
        String examJson = "{" +
                "\"name\": \"更新考试\"," +
                "\"startTime\": \"2024-10-02 09:00:00\"," +
                "\"endTime\": \"2024-10-02 11:00:00\"" +
                "}";

        mockMvc.perform(put("/api/teacher/exams/1")
                .header("Authorization", "Bearer " + teacherToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(examJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试删除考试
     */
    @Test
    public void testDeleteExam() throws Exception {
        mockMvc.perform(delete("/api/teacher/exams/1")
                .header("Authorization", "Bearer " + teacherToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    // ==================== 实验管理测试（周志文） ====================

    /**
     * 测试获取实验列表
     */
    @Test
    public void testGetExperimentList() throws Exception {
        mockMvc.perform(get("/api/teacher/experiments")
                .header("Authorization", "Bearer " + teacherToken)
                .param("page", "1")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.records").isArray());
    }

    /**
     * 测试创建实验
     */
    @Test
    public void testCreateExperiment() throws Exception {
        String experimentJson = "{" +
                "\"name\": \"Java基础实验\"," +
                "\"description\": \"学习Java基础语法\"," +
                "\"courseId\": 1" +
                "}";

        mockMvc.perform(post("/api/teacher/experiments")
                .header("Authorization", "Bearer " + teacherToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(experimentJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试更新实验信息
     */
    @Test
    public void testUpdateExperiment() throws Exception {
        String experimentJson = "{" +
                "\"name\": \"更新实验\"," +
                "\"description\": \"更新实验描述\"" +
                "}";

        mockMvc.perform(put("/api/teacher/experiments/1")
                .header("Authorization", "Bearer " + teacherToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(experimentJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试删除实验
     */
    @Test
    public void testDeleteExperiment() throws Exception {
        mockMvc.perform(delete("/api/teacher/experiments/1")
                .header("Authorization", "Bearer " + teacherToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    // ==================== 题目管理测试（周志文） ====================

    /**
     * 测试获取题目列表
     */
    @Test
    public void testGetQuestionList() throws Exception {
        mockMvc.perform(get("/api/teacher/questions")
                .header("Authorization", "Bearer " + teacherToken)
                .param("page", "1")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.records").isArray());
    }

    /**
     * 测试创建题目
     */
    @Test
    public void testCreateQuestion() throws Exception {
        String questionJson = "{" +
                "\"title\": \"Java中什么是多态？\"," +
                "\"content\": \"请解释Java中多态的概念\"," +
                "\"type\": 5," +
                "\"difficulty\": 2," +
                "\"score\": 10" +
                "}";

        mockMvc.perform(post("/api/teacher/questions")
                .header("Authorization", "Bearer " + teacherToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(questionJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试更新题目信息
     */
    @Test
    public void testUpdateQuestion() throws Exception {
        String questionJson = "{" +
                "\"title\": \"更新题目\"," +
                "\"content\": \"更新题目内容\"," +
                "\"difficulty\": 3" +
                "}";

        mockMvc.perform(put("/api/teacher/questions/1")
                .header("Authorization", "Bearer " + teacherToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(questionJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试删除题目
     */
    @Test
    public void testDeleteQuestion() throws Exception {
        mockMvc.perform(delete("/api/teacher/questions/1")
                .header("Authorization", "Bearer " + teacherToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    // ==================== 试卷管理测试（周志文） ====================

    /**
     * 测试获取试卷列表
     */
    @Test
    public void testGetPaperList() throws Exception {
        mockMvc.perform(get("/api/teacher/papers")
                .header("Authorization", "Bearer " + teacherToken)
                .param("page", "1")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.records").isArray());
    }

    /**
     * 测试创建试卷
     */
    @Test
    public void testCreatePaper() throws Exception {
        String paperJson = "{" +
                "\"name\": \"期中试卷\"," +
                "\"description\": \"期中考试试卷\"," +
                "\"totalScore\": 100" +
                "}";

        mockMvc.perform(post("/api/teacher/papers")
                .header("Authorization", "Bearer " + teacherToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(paperJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    // ==================== 成绩管理测试（杨宇润） ====================

    /**
     * 测试获取成绩列表
     */
    @Test
    public void testGetScoreList() throws Exception {
        mockMvc.perform(get("/api/teacher/scores")
                .header("Authorization", "Bearer " + teacherToken)
                .param("page", "1")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.records").isArray());
    }

    /**
     * 测试录入成绩
     */
    @Test
    public void testEnterScore() throws Exception {
        String scoreJson = "{" +
                "\"studentId\": 1," +
                "\"examId\": 1," +
                "\"score\": 85" +
                "}";

        mockMvc.perform(post("/api/teacher/scores")
                .header("Authorization", "Bearer " + teacherToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(scoreJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    // ==================== 作业管理测试（杨宇润） ====================

    /**
     * 测试获取作业列表
     */
    @Test
    public void testGetHomeworkList() throws Exception {
        mockMvc.perform(get("/api/teacher/homeworks")
                .header("Authorization", "Bearer " + teacherToken)
                .param("page", "1")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.records").isArray());
    }

    /**
     * 测试创建作业
     */
    @Test
    public void testCreateHomework() throws Exception {
        String homeworkJson = "{" +
                "\"title\": \"Java基础作业\"," +
                "\"description\": \"完成Java基础练习\"," +
                "\"courseId\": 1," +
                "\"deadline\": \"2024-10-15 23:59:59\"" +
                "}";

        mockMvc.perform(post("/api/teacher/homeworks")
                .header("Authorization", "Bearer " + teacherToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(homeworkJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    // ==================== 训练集管理测试（杨宇润） ====================

    /**
     * 测试获取训练集列表
     */
    @Test
    public void testGetTrainingSetList() throws Exception {
        mockMvc.perform(get("/api/teacher/training-sets")
                .header("Authorization", "Bearer " + teacherToken)
                .param("page", "1")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.records").isArray());
    }

    /**
     * 测试创建训练集
     */
    @Test
    public void testCreateTrainingSet() throws Exception {
        String trainingSetJson = "{" +
                "\"name\": \"Java基础训练\"," +
                "\"description\": \"Java基础知识训练集\"," +
                "\"courseId\": 1" +
                "}";

        mockMvc.perform(post("/api/teacher/training-sets")
                .header("Authorization", "Bearer " + teacherToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(trainingSetJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    // ==================== 讲义管理测试（杨宇润） ====================

    /**
     * 测试获取讲义列表
     */
    @Test
    public void testGetLectureList() throws Exception {
        mockMvc.perform(get("/api/teacher/lectures")
                .header("Authorization", "Bearer " + teacherToken)
                .param("page", "1")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.records").isArray());
    }

    /**
     * 测试创建讲义
     */
    @Test
    public void testCreateLecture() throws Exception {
        String lectureJson = "{" +
                "\"title\": \"Java基础讲义\"," +
                "\"content\": \"Java基础知识讲解\"," +
                "\"courseId\": 1" +
                "}";

        mockMvc.perform(post("/api/teacher/lectures")
                .header("Authorization", "Bearer " + teacherToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(lectureJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    // ==================== 教师仪表板测试（杨宇润） ====================

    /**
     * 测试获取教师仪表板数据
     */
    @Test
    public void testGetTeacherDashboard() throws Exception {
        mockMvc.perform(get("/api/teacher/dashboard")
                .header("Authorization", "Bearer " + teacherToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isNotEmpty());
    }

    // ==================== 学生管理测试（杨宇润） ====================

    /**
     * 测试获取学生列表
     */
    @Test
    public void testGetStudentList() throws Exception {
        mockMvc.perform(get("/api/teacher/students")
                .header("Authorization", "Bearer " + teacherToken)
                .param("page", "1")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.records").isArray());
    }

    // ==================== 批改管理测试（杨宇润） ====================

    /**
     * 测试获取待批改列表
     */
    @Test
    public void testGetGradingList() throws Exception {
        mockMvc.perform(get("/api/teacher/grading")
                .header("Authorization", "Bearer " + teacherToken)
                .param("page", "1")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.records").isArray());
    }

    /**
     * 测试提交批改结果
     */
    @Test
    public void testSubmitGrading() throws Exception {
        String gradingJson = "{" +
                "\"studentId\": 1," +
                "\"examId\": 1," +
                "\"score\": 90," +
                "\"comment\": \"表现优秀\"" +
                "}";

        mockMvc.perform(post("/api/teacher/grading")
                .header("Authorization", "Bearer " + teacherToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(gradingJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }
}
