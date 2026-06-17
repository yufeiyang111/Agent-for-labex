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
 * 智能代理控制器测试类
 * 测试人员：余飞杨
 * 测试内容：代理对话、代理任务、代理工具、代理权限
 */
@SpringBootTest
@AutoConfigureMockMvc
public class AgentControllerTest {

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

    // ==================== 代理对话测试 ====================

    /**
     * 测试创建代理对话
     */
    @Test
    public void testCreateAgentConversation() throws Exception {
        String conversationJson = "{" +
                "\"projectId\": 1," +
                "\"message\": \"帮我创建一个Java项目\"" +
                "}";

        mockMvc.perform(post("/api/student/agent/conversations")
                .header("Authorization", "Bearer " + studentToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(conversationJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.conversationId").isNotEmpty());
    }

    /**
     * 测试发送代理消息
     */
    @Test
    public void testSendAgentMessage() throws Exception {
        String messageJson = "{" +
                "\"conversationId\": 1," +
                "\"message\": \"帮我编写Hello World程序\"" +
                "}";

        mockMvc.perform(post("/api/student/agent/messages")
                .header("Authorization", "Bearer " + studentToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(messageJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试获取代理对话列表
     */
    @Test
    public void testGetAgentConversationList() throws Exception {
        mockMvc.perform(get("/api/student/agent/conversations")
                .header("Authorization", "Bearer " + studentToken)
                .param("projectId", "1")
                .param("page", "1")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.records").isArray());
    }

    /**
     * 测试获取代理对话详情
     */
    @Test
    public void testGetAgentConversationDetail() throws Exception {
        mockMvc.perform(get("/api/student/agent/conversations/1")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isNotEmpty());
    }

    /**
     * 测试删除代理对话
     */
    @Test
    public void testDeleteAgentConversation() throws Exception {
        mockMvc.perform(delete("/api/student/agent/conversations/1")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试获取代理消息历史
     */
    @Test
    public void testGetAgentMessageHistory() throws Exception {
        mockMvc.perform(get("/api/student/agent/conversations/1/messages")
                .header("Authorization", "Bearer " + studentToken)
                .param("page", "1")
                .param("size", "20"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.records").isArray());
    }

    // ==================== 代理任务测试 ====================

    /**
     * 测试获取代理任务列表
     */
    @Test
    public void testGetAgentTaskList() throws Exception {
        mockMvc.perform(get("/api/student/agent/tasks")
                .header("Authorization", "Bearer " + studentToken)
                .param("projectId", "1")
                .param("page", "1")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.records").isArray());
    }

    /**
     * 测试获取代理任务详情
     */
    @Test
    public void testGetAgentTaskDetail() throws Exception {
        mockMvc.perform(get("/api/student/agent/tasks/1")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isNotEmpty());
    }

    /**
     * 测试取消代理任务
     */
    @Test
    public void testCancelAgentTask() throws Exception {
        mockMvc.perform(post("/api/student/agent/tasks/1/cancel")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试获取代理任务状态
     */
    @Test
    public void testGetAgentTaskStatus() throws Exception {
        mockMvc.perform(get("/api/student/agent/tasks/1/status")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.status").isNotEmpty());
    }

    // ==================== 代理工具测试 ====================

    /**
     * 测试获取可用工具列表
     */
    @Test
    public void testGetAvailableTools() throws Exception {
        mockMvc.perform(get("/api/student/agent/tools")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isArray());
    }

    /**
     * 测试执行代理工具
     */
    @Test
    public void testExecuteAgentTool() throws Exception {
        String toolJson = "{" +
                "\"toolName\": \"read_file\"," +
                "\"parameters\": {\"path\": \"/src/Main.java\"}" +
                "}";

        mockMvc.perform(post("/api/student/agent/tools/execute")
                .header("Authorization", "Bearer " + studentToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(toolJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试获取工具执行结果
     */
    @Test
    public void testGetToolExecutionResult() throws Exception {
        mockMvc.perform(get("/api/student/agent/tools/executions/1")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isNotEmpty());
    }

    // ==================== 代理变更集测试 ====================

    /**
     * 测试获取代理变更集列表
     */
    @Test
    public void testGetAgentChangeSetList() throws Exception {
        mockMvc.perform(get("/api/student/agent/changesets")
                .header("Authorization", "Bearer " + studentToken)
                .param("projectId", "1")
                .param("page", "1")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.records").isArray());
    }

    /**
     * 测试获取代理变更集详情
     */
    @Test
    public void testGetAgentChangeSetDetail() throws Exception {
        mockMvc.perform(get("/api/student/agent/changesets/1")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isNotEmpty());
    }

    /**
     * 测试应用代理变更集
     */
    @Test
    public void testApplyAgentChangeSet() throws Exception {
        mockMvc.perform(post("/api/student/agent/changesets/1/apply")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试拒绝代理变更集
     */
    @Test
    public void testRejectAgentChangeSet() throws Exception {
        mockMvc.perform(post("/api/student/agent/changesets/1/reject")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试撤销代理变更集
     */
    @Test
    public void testUndoAgentChangeSet() throws Exception {
        mockMvc.perform(post("/api/student/agent/changesets/1/undo")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    // ==================== 代理文件变更测试 ====================

    /**
     * 测试获取代理文件变更列表
     */
    @Test
    public void testGetAgentFileChangeList() throws Exception {
        mockMvc.perform(get("/api/student/agent/changesets/1/files")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isArray());
    }

    /**
     * 测试获取文件差异
     */
    @Test
    public void testGetFileDiff() throws Exception {
        mockMvc.perform(get("/api/student/agent/changesets/1/files/1/diff")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isNotEmpty());
    }

    // ==================== 代理验证测试 ====================

    /**
     * 测试获取代理验证列表
     */
    @Test
    public void testGetAgentVerificationList() throws Exception {
        mockMvc.perform(get("/api/student/agent/verifications")
                .header("Authorization", "Bearer " + studentToken)
                .param("taskId", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isArray());
    }

    /**
     * 测试获取代理验证详情
     */
    @Test
    public void testGetAgentVerificationDetail() throws Exception {
        mockMvc.perform(get("/api/student/agent/verifications/1")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isNotEmpty());
    }

    // ==================== 代理权限测试 ====================

    /**
     * 测试获取代理权限规则
     */
    @Test
    public void testGetAgentPermissionRules() throws Exception {
        mockMvc.perform(get("/api/student/agent/permissions")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isArray());
    }

    /**
     * 测试更新代理权限规则
     */
    @Test
    public void testUpdateAgentPermissionRules() throws Exception {
        String rulesJson = "{" +
                "\"allowedTools\": [\"read_file\", \"write_file\", \"edit_file\"]," +
                "\"deniedTools\": [\"shell\", \"run_command\"]" +
                "}";

        mockMvc.perform(put("/api/student/agent/permissions")
                .header("Authorization", "Bearer " + studentToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(rulesJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    // ==================== 代理诊断测试 ====================

    /**
     * 测试获取代理诊断信息
     */
    @Test
    public void testGetAgentDiagnostics() throws Exception {
        mockMvc.perform(get("/api/student/agent/diagnostics")
                .header("Authorization", "Bearer " + studentToken)
                .param("projectId", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isNotEmpty());
    }

    /**
     * 测试运行代理诊断
     */
    @Test
    public void testRunAgentDiagnostics() throws Exception {
        mockMvc.perform(post("/api/student/agent/diagnostics/run")
                .header("Authorization", "Bearer " + studentToken)
                .param("projectId", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    // ==================== 代理计划测试 ====================

    /**
     * 测试创建代理计划
     */
    @Test
    public void testCreateAgentPlan() throws Exception {
        String planJson = "{" +
                "\"projectId\": 1," +
                "\"title\": \"创建Java项目\"," +
                "\"description\": \"创建一个Java项目并实现基本功能\"" +
                "}";

        mockMvc.perform(post("/api/student/agent/plans")
                .header("Authorization", "Bearer " + studentToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(planJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试获取代理计划列表
     */
    @Test
    public void testGetAgentPlanList() throws Exception {
        mockMvc.perform(get("/api/student/agent/plans")
                .header("Authorization", "Bearer " + studentToken)
                .param("projectId", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isArray());
    }

    /**
     * 测试获取代理计划详情
     */
    @Test
    public void testGetAgentPlanDetail() throws Exception {
        mockMvc.perform(get("/api/student/agent/plans/1")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isNotEmpty());
    }

    /**
     * 测试更新代理计划
     */
    @Test
    public void testUpdateAgentPlan() throws Exception {
        String planJson = "{" +
                "\"title\": \"更新计划\"," +
                "\"description\": \"更新计划描述\"" +
                "}";

        mockMvc.perform(put("/api/student/agent/plans/1")
                .header("Authorization", "Bearer " + studentToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(planJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试删除代理计划
     */
    @Test
    public void testDeleteAgentPlan() throws Exception {
        mockMvc.perform(delete("/api/student/agent/plans/1")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }
}
