package com.labex.kg.controller;

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
 * 知识图谱控制器测试类
 * 测试人员：周志文
 * 测试内容：知识图谱管理、学生掌握度、推荐系统
 */
@SpringBootTest
@AutoConfigureMockMvc
public class KnowledgeGraphControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    private String teacherToken;
    private String studentToken;

    @BeforeEach
    public void setUp() throws Exception {
        // 教师登录获取Token
        LoginRequest teacherLogin = new LoginRequest();
        teacherLogin.setUsername("teacher");
        teacherLogin.setPassword("teacher123");

        MvcResult teacherResult = mockMvc.perform(post("/api/auth/login")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(teacherLogin)))
                .andExpect(status().isOk())
                .andReturn();

        String teacherResponse = teacherResult.getResponse().getContentAsString();
        teacherToken = objectMapper.readTree(teacherResponse).path("data").path("token").asText();

        // 学生登录获取Token
        LoginRequest studentLogin = new LoginRequest();
        studentLogin.setUsername("student");
        studentLogin.setPassword("student123");

        MvcResult studentResult = mockMvc.perform(post("/api/auth/login")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(studentLogin)))
                .andExpect(status().isOk())
                .andReturn();

        String studentResponse = studentResult.getResponse().getContentAsString();
        studentToken = objectMapper.readTree(studentResponse).path("data").path("token").asText();
    }

    // ==================== 知识图谱管理测试 ====================

    /**
     * 测试获取知识图谱数据
     */
    @Test
    public void testGetKnowledgeGraph() throws Exception {
        mockMvc.perform(get("/api/kg/graph")
                .header("Authorization", "Bearer " + teacherToken)
                .param("courseId", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isNotEmpty());
    }

    /**
     * 测试获取知识点列表
     */
    @Test
    public void testGetKnowledgePointList() throws Exception {
        mockMvc.perform(get("/api/kg/knowledge-points")
                .header("Authorization", "Bearer " + teacherToken)
                .param("courseId", "1")
                .param("page", "1")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.records").isArray());
    }

    /**
     * 测试创建知识点
     */
    @Test
    public void testCreateKnowledgePoint() throws Exception {
        String kpJson = "{" +
                "\"name\": \"Java多态\"," +
                "\"description\": \"Java中多态的概念和实现\"," +
                "\"courseId\": 1," +
                "\"difficulty\": 3" +
                "}";

        mockMvc.perform(post("/api/kg/knowledge-points")
                .header("Authorization", "Bearer " + teacherToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(kpJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试更新知识点
     */
    @Test
    public void testUpdateKnowledgePoint() throws Exception {
        String kpJson = "{" +
                "\"name\": \"更新知识点\"," +
                "\"description\": \"更新描述\"," +
                "\"difficulty\": 4" +
                "}";

        mockMvc.perform(put("/api/kg/knowledge-points/1")
                .header("Authorization", "Bearer " + teacherToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(kpJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试删除知识点
     */
    @Test
    public void testDeleteKnowledgePoint() throws Exception {
        mockMvc.perform(delete("/api/kg/knowledge-points/1")
                .header("Authorization", "Bearer " + teacherToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试构建知识图谱
     */
    @Test
    public void testBuildKnowledgeGraph() throws Exception {
        mockMvc.perform(post("/api/kg/graph/build")
                .header("Authorization", "Bearer " + teacherToken)
                .param("courseId", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试获取知识点详情
     */
    @Test
    public void testGetKnowledgePointDetail() throws Exception {
        mockMvc.perform(get("/api/kg/knowledge-points/1")
                .header("Authorization", "Bearer " + teacherToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isNotEmpty());
    }

    /**
     * 测试获取知识点关联关系
     */
    @Test
    public void testGetKnowledgePointRelations() throws Exception {
        mockMvc.perform(get("/api/kg/knowledge-points/1/relations")
                .header("Authorization", "Bearer " + teacherToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isArray());
    }

    /**
     * 测试创建知识点关联关系
     */
    @Test
    public void testCreateKnowledgePointRelation() throws Exception {
        String relationJson = "{" +
                "\"sourceId\": 1," +
                "\"targetId\": 2," +
                "\"relationType\": \"PREREQUISITE\"" +
                "}";

        mockMvc.perform(post("/api/kg/knowledge-points/relations")
                .header("Authorization", "Bearer " + teacherToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(relationJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试删除知识点关联关系
     */
    @Test
    public void testDeleteKnowledgePointRelation() throws Exception {
        mockMvc.perform(delete("/api/kg/knowledge-points/relations/1")
                .header("Authorization", "Bearer " + teacherToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    // ==================== 学生掌握度测试 ====================

    /**
     * 测试获取学生掌握度列表
     */
    @Test
    public void testGetStudentMasteryList() throws Exception {
        mockMvc.perform(get("/api/kg/student-mastery")
                .header("Authorization", "Bearer " + teacherToken)
                .param("studentId", "1")
                .param("courseId", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isArray());
    }

    /**
     * 测试获取学生知识点掌握度
     */
    @Test
    public void testGetStudentKnowledgePointMastery() throws Exception {
        mockMvc.perform(get("/api/kg/student-mastery/1")
                .header("Authorization", "Bearer " + teacherToken)
                .param("studentId", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isNotEmpty());
    }

    /**
     * 测试获取班级掌握度统计
     */
    @Test
    public void testGetClassMasteryStatistics() throws Exception {
        mockMvc.perform(get("/api/kg/student-mastery/statistics")
                .header("Authorization", "Bearer " + teacherToken)
                .param("clazzId", "1")
                .param("courseId", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isNotEmpty());
    }

    /**
     * 测试获取学生掌握度雷达图数据
     */
    @Test
    public void testGetStudentMasteryRadar() throws Exception {
        mockMvc.perform(get("/api/kg/student-mastery/radar")
                .header("Authorization", "Bearer " + studentToken)
                .param("courseId", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isNotEmpty());
    }

    // ==================== 推荐系统测试 ====================

    /**
     * 测试获取练习题推荐
     */
    @Test
    public void testGetExerciseRecommendation() throws Exception {
        mockMvc.perform(get("/api/kg/recommendations/exercises")
                .header("Authorization", "Bearer " + studentToken)
                .param("courseId", "1")
                .param("limit", "5"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isArray());
    }

    /**
     * 测试获取学习路径推荐
     */
    @Test
    public void testGetLearningPathRecommendation() throws Exception {
        mockMvc.perform(get("/api/kg/recommendations/learning-path")
                .header("Authorization", "Bearer " + studentToken)
                .param("courseId", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isArray());
    }

    /**
     * 测试获取薄弱知识点推荐
     */
    @Test
    public void testGetWeakPointRecommendation() throws Exception {
        mockMvc.perform(get("/api/kg/recommendations/weak-points")
                .header("Authorization", "Bearer " + studentToken)
                .param("courseId", "1")
                .param("limit", "3"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isArray());
    }

    /**
     * 测试获取个性化推荐
     */
    @Test
    public void testGetPersonalizedRecommendation() throws Exception {
        mockMvc.perform(get("/api/kg/recommendations/personalized")
                .header("Authorization", "Bearer " + studentToken)
                .param("courseId", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isNotEmpty());
    }

    // ==================== 题目知识点关联测试 ====================

    /**
     * 测试获取题目关联的知识点
     */
    @Test
    public void testGetQuestionKnowledgePoints() throws Exception {
        mockMvc.perform(get("/api/kg/questions/1/knowledge-points")
                .header("Authorization", "Bearer " + teacherToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isArray());
    }

    /**
     * 测试关联题目和知识点
     */
    @Test
    public void testLinkQuestionKnowledgePoint() throws Exception {
        String linkJson = "{" +
                "\"questionId\": 1," +
                "\"knowledgePointId\": 1," +
                "\"relevance\": 0.8" +
                "}";

        mockMvc.perform(post("/api/kg/questions/knowledge-points")
                .header("Authorization", "Bearer " + teacherToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(linkJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试取消题目和知识点关联
     */
    @Test
    public void testUnlinkQuestionKnowledgePoint() throws Exception {
        mockMvc.perform(delete("/api/kg/questions/1/knowledge-points/1")
                .header("Authorization", "Bearer " + teacherToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试自动关联题目和知识点
     */
    @Test
    public void testAutoLinkQuestionKnowledgePoints() throws Exception {
        mockMvc.perform(post("/api/kg/questions/auto-link")
                .header("Authorization", "Bearer " + teacherToken)
                .param("courseId", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }
}
