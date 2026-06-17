package com.labex.rag.controller;

import com.labex.dto.LoginRequest;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * RAG控制器测试类
 * 测试人员：杨宇润
 * 测试内容：RAG问答、会话管理、文档上传和处理
 */
@SpringBootTest
@AutoConfigureMockMvc
public class RagControllerTest {

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

    // ==================== RAG问答测试 ====================

    /**
     * 测试RAG问答 - 成功场景
     */
    @Test
    public void testQuerySuccess() throws Exception {
        String queryJson = "{" +
                "\"question\": \"什么是Java多态？\"," +
                "\"sessionId\": \"session-1\"" +
                "}";

        mockMvc.perform(post("/api/rag/query")
                .header("Authorization", "Bearer " + studentToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(queryJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.answer").isNotEmpty());
    }

    /**
     * 测试RAG问答 - 空问题
     */
    @Test
    public void testQueryEmptyQuestion() throws Exception {
        String queryJson = "{" +
                "\"question\": \"\"," +
                "\"sessionId\": \"session-1\"" +
                "}";

        mockMvc.perform(post("/api/rag/query")
                .header("Authorization", "Bearer " + studentToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(queryJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(-1));
    }

    /**
     * 测试RAG问答 - 无会话ID
     */
    @Test
    public void testQueryWithoutSessionId() throws Exception {
        String queryJson = "{" +
                "\"question\": \"什么是Java多态？\"" +
                "}";

        mockMvc.perform(post("/api/rag/query")
                .header("Authorization", "Bearer " + studentToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(queryJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.sessionId").isNotEmpty());
    }

    // ==================== 会话管理测试 ====================

    /**
     * 测试获取会话列表
     */
    @Test
    public void testGetSessionList() throws Exception {
        mockMvc.perform(get("/api/rag/sessions")
                .header("Authorization", "Bearer " + studentToken)
                .param("page", "1")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.records").isArray());
    }

    /**
     * 测试创建会话
     */
    @Test
    public void testCreateSession() throws Exception {
        String sessionJson = "{" +
                "\"title\": \"Java学习会话\"," +
                "\"courseId\": 1" +
                "}";

        mockMvc.perform(post("/api/rag/sessions")
                .header("Authorization", "Bearer " + studentToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(sessionJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.sessionId").isNotEmpty());
    }

    /**
     * 测试获取会话详情
     */
    @Test
    public void testGetSessionDetail() throws Exception {
        mockMvc.perform(get("/api/rag/sessions/session-1")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isNotEmpty());
    }

    /**
     * 测试删除会话
     */
    @Test
    public void testDeleteSession() throws Exception {
        mockMvc.perform(delete("/api/rag/sessions/session-1")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试获取会话消息历史
     */
    @Test
    public void testGetSessionMessages() throws Exception {
        mockMvc.perform(get("/api/rag/sessions/session-1/messages")
                .header("Authorization", "Bearer " + studentToken)
                .param("page", "1")
                .param("size", "20"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.records").isArray());
    }

    /**
     * 测试清空会话历史
     */
    @Test
    public void testClearSessionHistory() throws Exception {
        mockMvc.perform(post("/api/rag/sessions/session-1/clear")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    // ==================== 文档上传测试 ====================

    /**
     * 测试上传PDF文档
     */
    @Test
    public void testUploadPdfDocument() throws Exception {
        MockMultipartFile file = new MockMultipartFile(
                "file",
                "test.pdf",
                MediaType.APPLICATION_PDF_VALUE,
                "PDF content".getBytes()
        );

        mockMvc.perform(multipart("/api/rag/documents/upload")
                .file(file)
                .header("Authorization", "Bearer " + studentToken)
                .param("courseId", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.documentId").isNotEmpty());
    }

    /**
     * 测试上传Word文档
     */
    @Test
    public void testUploadWordDocument() throws Exception {
        MockMultipartFile file = new MockMultipartFile(
                "file",
                "test.docx",
                "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
                "Word content".getBytes()
        );

        mockMvc.perform(multipart("/api/rag/documents/upload")
                .file(file)
                .header("Authorization", "Bearer " + studentToken)
                .param("courseId", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试上传Markdown文档
     */
    @Test
    public void testUploadMarkdownDocument() throws Exception {
        MockMultipartFile file = new MockMultipartFile(
                "file",
                "test.md",
                "text/markdown",
                "# Markdown content".getBytes()
        );

        mockMvc.perform(multipart("/api/rag/documents/upload")
                .file(file)
                .header("Authorization", "Bearer " + studentToken)
                .param("courseId", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试上传不支持的文件格式
     */
    @Test
    public void testUploadUnsupportedFormat() throws Exception {
        MockMultipartFile file = new MockMultipartFile(
                "file",
                "test.exe",
                "application/octet-stream",
                "Executable content".getBytes()
        );

        mockMvc.perform(multipart("/api/rag/documents/upload")
                .file(file)
                .header("Authorization", "Bearer " + studentToken)
                .param("courseId", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(-1));
    }

    /**
     * 测试获取文档列表
     */
    @Test
    public void testGetDocumentList() throws Exception {
        mockMvc.perform(get("/api/rag/documents")
                .header("Authorization", "Bearer " + studentToken)
                .param("courseId", "1")
                .param("page", "1")
                .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.records").isArray());
    }

    /**
     * 测试删除文档
     */
    @Test
    public void testDeleteDocument() throws Exception {
        mockMvc.perform(delete("/api/rag/documents/doc-1")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    // ==================== 模型切换测试 ====================

    /**
     * 测试获取可用模型列表
     */
    @Test
    public void testGetAvailableModels() throws Exception {
        mockMvc.perform(get("/api/rag/models")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isArray());
    }

    /**
     * 测试切换模型
     */
    @Test
    public void testSwitchModel() throws Exception {
        String modelJson = "{" +
                "\"modelId\": \"minimax\"" +
                "}";

        mockMvc.perform(post("/api/rag/models/switch")
                .header("Authorization", "Bearer " + studentToken)
                .contentType(MediaType.APPLICATION_JSON)
                .content(modelJson))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    /**
     * 测试获取当前模型
     */
    @Test
    public void testGetCurrentModel() throws Exception {
        mockMvc.perform(get("/api/rag/models/current")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.modelId").isNotEmpty());
    }

    // ==================== 摘要生成测试 ====================

    /**
     * 测试生成文档摘要
     */
    @Test
    public void testGenerateSummary() throws Exception {
        mockMvc.perform(post("/api/rag/summaries/generate")
                .header("Authorization", "Bearer " + studentToken)
                .param("documentId", "doc-1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.summary").isNotEmpty());
    }

    /**
     * 测试获取文档摘要
     */
    @Test
    public void testGetDocumentSummary() throws Exception {
        mockMvc.perform(get("/api/rag/summaries/doc-1")
                .header("Authorization", "Bearer " + studentToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0));
    }

    // ==================== 图片理解测试 ====================

    /**
     * 测试图片理解
     */
    @Test
    public void testUnderstandImage() throws Exception {
        MockMultipartFile file = new MockMultipartFile(
                "file",
                "test.png",
                MediaType.IMAGE_PNG_VALUE,
                "Image content".getBytes()
        );

        mockMvc.perform(multipart("/api/rag/images/understand")
                .file(file)
                .header("Authorization", "Bearer " + studentToken)
                .param("question", "这张图片是什么内容？"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data.answer").isNotEmpty());
    }

    // ==================== 网页搜索测试 ====================

    /**
     * 测试网页搜索
     */
    @Test
    public void testWebSearch() throws Exception {
        mockMvc.perform(get("/api/rag/web-search")
                .header("Authorization", "Bearer " + studentToken)
                .param("query", "Java多态"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isArray());
    }

    // ==================== 查询指标测试 ====================

    /**
     * 测试获取查询指标
     */
    @Test
    public void testGetQueryMetrics() throws Exception {
        mockMvc.perform(get("/api/rag/metrics")
                .header("Authorization", "Bearer " + studentToken)
                .param("sessionId", "session-1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(0))
                .andExpect(jsonPath("$.data").isNotEmpty());
    }
}
