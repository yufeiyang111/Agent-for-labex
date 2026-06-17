package com.labex.controller.teaching;

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
 * 教学模块（CTL）控制器测试类
 * 测试人员：于峰
 * 测试内容：课程管理、课程开设、教学大纲、课程目标、毕业要求、评分项、成绩录入、达成度计算、质量评价、质量报告
 */
@SpringBootTest
@AutoConfigureMockMvc
public class TeachingControllerTest {

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

    // ==================== 课程管理测试 ====================

    /**
     * 测试获取课程列表
     */
    @Test
    public void testGetCourseList() throws Exception {
        mockMvc.perform(get("/api/teaching/courses")
                .header("Authorization", "Bearer " + teacherToken)
                .param("page", "1")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.records").isArray());
    }

    /**
     * 测试创建课程
     */
    @Test
    public void testCreateCourse() throws Exception {
        String courseJson = "{" +
                "\"name\": \"Java程序设计\"," +
                "\"code\": \"CS101\"," +
                "\"description\": \"Java基础课程\"," +
                "\"credits\": 3" +
                "}";

        mockMvc.perform(post("/api/teaching/courses")
                .header("Authorization", "Bearer " + teacherToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(courseJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试更新课程信息
     */
    @Test
    public void testUpdateCourse() throws Exception {
        String courseJson = "{" +
                "\"name\": \"更新课程\"," +
                "\"description\": \"更新课程描述\"," +
                "\"credits\": 4" +
                "}";

        mockMvc.perform(put("/api/teaching/courses/1")
                .header("Authorization", "Bearer " + teacherToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(courseJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试删除课程
     */
    @Test
    public void testDeleteCourse() throws Exception {
        mockMvc.perform(delete("/api/teaching/courses/1")
                .header("Authorization", "Bearer " + teacherToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    // ==================== 课程开设测试 ====================

    /**
     * 测试获取课程开设列表
     */
    @Test
    public void testGetCourseOfferingList() throws Exception {
        mockMvc.perform(get("/api/teaching/course-offerings")
                .header("Authorization", "Bearer " + teacherToken)
                .param("page", "1")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.records").isArray());
    }

    /**
     * 测试创建课程开设
     */
    @Test
    public void testCreateCourseOffering() throws Exception {
        String offeringJson = "{" +
                "\"courseId\": 1," +
                "\"semester\": \"2024-2025-1\"," +
                "\"teacherId\": 1," +
                "\"clazzId\": 1" +
                "}";

        mockMvc.perform(post("/api/teaching/course-offerings")
                .header("Authorization", "Bearer " + teacherToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(offeringJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    // ==================== 教学大纲测试 ====================

    /**
     * 测试获取教学大纲
     */
    @Test
    public void testGetSyllabus() throws Exception {
        mockMvc.perform(get("/api/teaching/syllabuses/1")
                .header("Authorization", "Bearer " + teacherToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试创建教学大纲
     */
    @Test
    public void testCreateSyllabus() throws Exception {
        String syllabusJson = "{" +
                "\"courseId\": 1," +
                "\"content\": \"课程教学大纲内容\"," +
                "\"version\": \"1.0\"" +
                "}";

        mockMvc.perform(post("/api/teaching/syllabuses")
                .header("Authorization", "Bearer " + teacherToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(syllabusJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试更新教学大纲
     */
    @Test
    public void testUpdateSyllabus() throws Exception {
        String syllabusJson = "{" +
                "\"content\": \"更新教学大纲内容\"," +
                "\"version\": \"1.1\"" +
                "}";

        mockMvc.perform(put("/api/teaching/syllabuses/1")
                .header("Authorization", "Bearer " + teacherToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(syllabusJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    // ==================== 课程目标测试 ====================

    /**
     * 测试获取课程目标列表
     */
    @Test
    public void testGetCourseObjectiveList() throws Exception {
        mockMvc.perform(get("/api/teaching/course-objectives")
                .header("Authorization", "Bearer " + teacherToken)
                .param("courseId", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isArray());
    }

    /**
     * 测试创建课程目标
     */
    @Test
    public void testCreateCourseObjective() throws Exception {
        String objectiveJson = "{" +
                "\"courseId\": 1," +
                "\"name\": \"课程目标1\"," +
                "\"description\": \"掌握Java基础语法\"," +
                "\"weight\": 0.3" +
                "}";

        mockMvc.perform(post("/api/teaching/course-objectives")
                .header("Authorization", "Bearer " + teacherToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectiveJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试更新课程目标
     */
    @Test
    public void testUpdateCourseObjective() throws Exception {
        String objectiveJson = "{" +
                "\"name\": \"更新课程目标\"," +
                "\"description\": \"更新描述\"," +
                "\"weight\": 0.4" +
                "}";

        mockMvc.perform(put("/api/teaching/course-objectives/1")
                .header("Authorization", "Bearer " + teacherToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectiveJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试删除课程目标
     */
    @Test
    public void testDeleteCourseObjective() throws Exception {
        mockMvc.perform(delete("/api/teaching/course-objectives/1")
                .header("Authorization", "Bearer " + teacherToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    // ==================== 毕业要求测试 ====================

    /**
     * 测试获取毕业要求列表
     */
    @Test
    public void testGetGraduationRequirementList() throws Exception {
        mockMvc.perform(get("/api/teaching/graduation-requirements")
                .header("Authorization", "Bearer " + teacherToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isArray());
    }

    /**
     * 测试创建毕业要求
     */
    @Test
    public void testCreateGraduationRequirement() throws Exception {
        String requirementJson = "{" +
                "\"name\": \"毕业要求1\"," +
                "\"description\": \"工程知识\"," +
                "\"indicators\": [" +
                "{\"name\": \"指标点1.1\", \"description\": \"掌握数学知识\"}," +
                "{\"name\": \"指标点1.2\", \"description\": \"掌握自然科学知识\"}" +
                "]" +
                "}";

        mockMvc.perform(post("/api/teaching/graduation-requirements")
                .header("Authorization", "Bearer " + teacherToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(requirementJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    // ==================== 评分项测试 ====================

    /**
     * 测试获取评分项列表
     */
    @Test
    public void testGetScoringItemList() throws Exception {
        mockMvc.perform(get("/api/teaching/scoring-items")
                .header("Authorization", "Bearer " + teacherToken)
                .param("offeringId", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isArray());
    }

    /**
     * 测试创建评分项
     */
    @Test
    public void testCreateScoringItem() throws Exception {
        String itemJson = "{" +
                "\"offeringId\": 1," +
                "\"name\": \"平时成绩\"," +
                "\"weight\": 0.3," +
                "\"description\": \"平时作业和考勤\"" +
                "}";

        mockMvc.perform(post("/api/teaching/scoring-items")
                .header("Authorization", "Bearer " + teacherToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(itemJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试更新评分项
     */
    @Test
    public void testUpdateScoringItem() throws Exception {
        String itemJson = "{" +
                "\"name\": \"更新评分项\"," +
                "\"weight\": 0.4," +
                "\"description\": \"更新描述\"" +
                "}";

        mockMvc.perform(put("/api/teaching/scoring-items/1")
                .header("Authorization", "Bearer " + teacherToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(itemJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试删除评分项
     */
    @Test
    public void testDeleteScoringItem() throws Exception {
        mockMvc.perform(delete("/api/teaching/scoring-items/1")
                .header("Authorization", "Bearer " + teacherToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    // ==================== 成绩录入测试 ====================

    /**
     * 测试批量录入成绩
     */
    @Test
    public void testBatchEnterScores() throws Exception {
        String scoresJson = "[" +
                "{\"studentId\": 1, \"scoringItemId\": 1, \"score\": 85}," +
                "{\"studentId\": 2, \"scoringItemId\": 1, \"score\": 90}" +
                "]";

        mockMvc.perform(post("/api/teaching/scoring-scores/batch")
                .header("Authorization", "Bearer " + teacherToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(scoresJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试导入成绩
     */
    @Test
    public void testImportScores() throws Exception {
        String scoresJson = "[" +
                "{\"studentNo\": \"2024001\", \"scoringItemId\": 1, \"score\": 85}," +
                "{\"studentNo\": \"2024002\", \"scoringItemId\": 1, \"score\": 90}" +
                "]";

        mockMvc.perform(post("/api/teaching/scoring-scores/import")
                .header("Authorization", "Bearer " + teacherToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(scoresJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试导出成绩
     */
    @Test
    public void testExportScores() throws Exception {
        mockMvc.perform(get("/api/teaching/scoring-scores/export")
                .header("Authorization", "Bearer " + teacherToken)
                .param("offeringId", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    // ==================== 达成度计算测试 ====================

    /**
     * 测试计算课程目标达成度
     */
    @Test
    public void testCalculateCourseObjectiveAchievement() throws Exception {
        mockMvc.perform(get("/api/teaching/achievements/course-objectives")
                .header("Authorization", "Bearer " + teacherToken)
                .param("offeringId", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isArray());
    }

    /**
     * 测试计算毕业要求达成度
     */
    @Test
    public void testCalculateGraduationRequirementAchievement() throws Exception {
        mockMvc.perform(get("/api/teaching/achievements/graduation-requirements")
                .header("Authorization", "Bearer " + teacherToken)
                .param("offeringId", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isArray());
    }

    /**
     * 测试导出达成度报告
     */
    @Test
    public void testExportAchievementReport() throws Exception {
        mockMvc.perform(get("/api/teaching/achievements/export")
                .header("Authorization", "Bearer " + teacherToken)
                .param("offeringId", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    // ==================== 质量评价测试 ====================

    /**
     * 测试获取质量评价列表
     */
    @Test
    public void testGetQualityEvaluationList() throws Exception {
        mockMvc.perform(get("/api/teaching/quality-evaluations")
                .header("Authorization", "Bearer " + teacherToken)
                .param("offeringId", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isArray());
    }

    /**
     * 测试创建质量评价
     */
    @Test
    public void testCreateQualityEvaluation() throws Exception {
        String evaluationJson = "{" +
                "\"offeringId\": 1," +
                "\"evaluatorType\": \"STUDENT\"," +
                "\"score\": 90," +
                "\"comment\": \"课程内容丰富\"" +
                "}";

        mockMvc.perform(post("/api/teaching/quality-evaluations")
                .header("Authorization", "Bearer " + teacherToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(evaluationJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    // ==================== 质量报告测试 ====================

    /**
     * 测试获取质量报告列表
     */
    @Test
    public void testGetQualityReportList() throws Exception {
        mockMvc.perform(get("/api/teaching/quality-reports")
                .header("Authorization", "Bearer " + teacherToken)
                .param("offeringId", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isArray());
    }

    /**
     * 测试生成质量报告
     */
    @Test
    public void testGenerateQualityReport() throws Exception {
        mockMvc.perform(post("/api/teaching/quality-reports/generate")
                .header("Authorization", "Bearer " + teacherToken)
                .param("offeringId", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试导出质量报告
     */
    @Test
    public void testExportQualityReport() throws Exception {
        mockMvc.perform(get("/api/teaching/quality-reports/export")
                .header("Authorization", "Bearer " + teacherToken)
                .param("reportId", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    // ==================== 学生教学测试 ====================

    /**
     * 测试获取学生教学数据
     */
    @Test
    public void testGetStudentTeachingData() throws Exception {
        mockMvc.perform(get("/api/teaching/student-teaching/data")
                .header("Authorization", "Bearer " + teacherToken)
                .param("offeringId", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isNotEmpty());
    }

    // ==================== AI辅助测试 ====================

    /**
     * 测试获取AI辅助建议
     */
    @Test
    public void testGetAiAssistSuggestion() throws Exception {
        mockMvc.perform(get("/api/teaching/ai-assist/suggestions")
                .header("Authorization", "Bearer " + teacherToken)
                .param("offeringId", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isArray());
    }

    // ==================== 文档导出测试 ====================

    /**
     * 测试导出教学文档
     */
    @Test
    public void testExportDocument() throws Exception {
        mockMvc.perform(get("/api/teaching/documents/export")
                .header("Authorization", "Bearer " + teacherToken)
                .param("offeringId", "1")
                .param("type", "syllabus"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }
}
