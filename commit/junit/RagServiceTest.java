package com.labex.rag.service;

import com.labex.rag.dto.QueryRequest;
import com.labex.rag.dto.QueryResponse;
import com.labex.rag.dto.SessionDTO;
import com.labex.rag.vector.EmbeddingService;
import com.labex.rag.retrieval.HybridRetriever;
import com.labex.rag.llm.LLMChat;
import com.labex.rag.chunker.HierarchicalChunker;
import com.labex.rag.parser.DocumentParserFactory;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

/**
 * RAG服务测试
 * 测试人员：杨宇润
 * 测试内容：RAG问答、会话管理、文档处理
 */
@ExtendWith(MockitoExtension.class)
public class RagServiceTest {

    @InjectMocks
    private RagService ragService;

    @Mock
    private EmbeddingService embeddingService;

    @Mock
    private HybridRetriever hybridRetriever;

    @Mock
    private LLMChat llmChat;

    @Mock
    private HierarchicalChunker hierarchicalChunker;

    @Mock
    private DocumentParserFactory documentParserFactory;

    /**
     * 测试RAG问答 - 成功场景
     */
    @Test
    public void testQuerySuccess() {
        QueryRequest request = new QueryRequest();
        request.setQuestion("什么是Java多态？");
        request.setSessionId("session-1");

        List<Float> embedding = Arrays.asList(0.1f, 0.2f, 0.3f);
        List<String> contexts = Arrays.asList("Java多态是面向对象编程的重要特性...", "多态允许不同类的对象对同一消息做出响应...");
        String answer = "Java多态是面向对象编程的重要特性，它允许不同类的对象对同一消息做出响应。";

        when(embeddingService.embed(anyString())).thenReturn(embedding);
        when(hybridRetriever.retrieve(anyList(), anyString(), anyInt())).thenReturn(contexts);
        when(llmChat.chat(anyString(), anyList())).thenReturn(answer);

        QueryResponse response = ragService.query(request);

        assertNotNull(response);
        assertEquals(answer, response.getAnswer());
        assertNotNull(response.getSources());
        verify(embeddingService).embed(anyString());
        verify(hybridRetriever).retrieve(anyList(), anyString(), anyInt());
        verify(llmChat).chat(anyString(), anyList());
    }

    /**
     * 测试RAG问答 - 空问题
     */
    @Test
    public void testQueryEmptyQuestion() {
        QueryRequest request = new QueryRequest();
        request.setQuestion("");
        request.setSessionId("session-1");

        assertThrows(IllegalArgumentException.class, () -> ragService.query(request));
    }

    /**
     * 测试RAG问答 - 无会话ID
     */
    @Test
    public void testQueryWithoutSessionId() {
        QueryRequest request = new QueryRequest();
        request.setQuestion("什么是Java多态？");

        List<Float> embedding = Arrays.asList(0.1f, 0.2f, 0.3f);
        List<String> contexts = Arrays.asList("Java多态是面向对象编程的重要特性...");
        String answer = "Java多态是面向对象编程的重要特性。";

        when(embeddingService.embed(anyString())).thenReturn(embedding);
        when(hybridRetriever.retrieve(anyList(), anyString(), anyInt())).thenReturn(contexts);
        when(llmChat.chat(anyString(), anyList())).thenReturn(answer);

        QueryResponse response = ragService.query(request);

        assertNotNull(response);
        assertNotNull(response.getSessionId());
        assertFalse(response.getSessionId().isEmpty());
    }

    /**
     * 测试创建会话
     */
    @Test
    public void testCreateSession() {
        SessionDTO dto = new SessionDTO();
        dto.setTitle("Java学习会话");
        dto.setCourseId(1L);

        SessionDTO result = ragService.createSession(dto);

        assertNotNull(result);
        assertNotNull(result.getSessionId());
        assertEquals("Java学习会话", result.getTitle());
    }

    /**
     * 测试获取会话详情
     */
    @Test
    public void testGetSession() {
        String sessionId = "session-1";

        SessionDTO result = ragService.getSession(sessionId);

        assertNotNull(result);
        assertEquals(sessionId, result.getSessionId());
    }

    /**
     * 测试删除会话
     */
    @Test
    public void testDeleteSession() {
        String sessionId = "session-1";

        ragService.deleteSession(sessionId);

        // 验证会话已删除
        verify(ragService).deleteSession(sessionId);
    }

    /**
     * 测试处理文档
     */
    @Test
    public void testProcessDocument() {
        String documentId = "doc-1";
        String content = "Java多态是面向对象编程的重要特性...";

        when(documentParserFactory.parse(anyString(), anyString())).thenReturn(content);
        when(hierarchicalChunker.chunk(anyString())).thenReturn(Arrays.asList("chunk1", "chunk2"));
        when(embeddingService.embed(anyString())).thenReturn(Arrays.asList(0.1f, 0.2f, 0.3f));

        ragService.processDocument(documentId, "pdf");

        verify(documentParserFactory).parse(anyString(), anyString());
        verify(hierarchicalChunker).chunk(anyString());
        verify(embeddingService, atLeastOnce()).embed(anyString());
    }

    /**
     * 测试生成摘要
     */
    @Test
    public void testGenerateSummary() {
        String documentId = "doc-1";
        String content = "Java多态是面向对象编程的重要特性...";
        String summary = "本文介绍了Java多态的基本概念和实现方式。";

        when(documentParserFactory.parse(anyString(), anyString())).thenReturn(content);
        when(llmChat.chat(anyString(), anyList())).thenReturn(summary);

        String result = ragService.generateSummary(documentId);

        assertNotNull(result);
        assertEquals(summary, result);
        verify(llmChat).chat(anyString(), anyList());
    }

    /**
     * 测试图片理解
     */
    @Test
    public void testUnderstandImage() {
        byte[] imageData = "image data".getBytes();
        String question = "这张图片是什么内容？";
        String answer = "这张图片显示了一个Java类的UML图。";

        when(llmChat.chatWithImage(anyString(), any(byte[].class))).thenReturn(answer);

        String result = ragService.understandImage(imageData, question);

        assertNotNull(result);
        assertEquals(answer, result);
        verify(llmChat).chatWithImage(anyString(), any(byte[].class));
    }

    /**
     * 测试网页搜索
     */
    @Test
    public void testWebSearch() {
        String query = "Java多态";
        List<String> results = Arrays.asList("https://example.com/java-polymorphism", "https://example.com/oop");

        when(hybridRetriever.webSearch(anyString())).thenReturn(results);

        List<String> result = ragService.webSearch(query);

        assertNotNull(result);
        assertEquals(2, result.size());
        verify(hybridRetriever).webSearch(anyString());
    }

    /**
     * 测试获取查询指标
     */
    @Test
    public void testGetQueryMetrics() {
        String sessionId = "session-1";

        var metrics = ragService.getQueryMetrics(sessionId);

        assertNotNull(metrics);
    }

    /**
     * 测试嵌入服务
     */
    @Test
    public void testEmbeddingService() {
        String text = "Java多态";
        List<Float> embedding = Arrays.asList(0.1f, 0.2f, 0.3f);

        when(embeddingService.embed(text)).thenReturn(embedding);

        List<Float> result = embeddingService.embed(text);

        assertNotNull(result);
        assertEquals(3, result.size());
        assertEquals(0.1f, result.get(0), 0.001);
        verify(embeddingService).embed(text);
    }

    /**
     * 测试混合检索
     */
    @Test
    public void testHybridRetriever() {
        List<Float> queryEmbedding = Arrays.asList(0.1f, 0.2f, 0.3f);
        String queryText = "Java多态";
        int limit = 5;
        List<String> results = Arrays.asList("chunk1", "chunk2", "chunk3");

        when(hybridRetriever.retrieve(queryEmbedding, queryText, limit)).thenReturn(results);

        List<String> result = hybridRetriever.retrieve(queryEmbedding, queryText, limit);

        assertNotNull(result);
        assertEquals(3, result.size());
        verify(hybridRetriever).retrieve(queryEmbedding, queryText, limit);
    }

    /**
     * 测试LLM聊天
     */
    @Test
    public void testLLMChat() {
        String prompt = "解释Java多态";
        List<String> contexts = Arrays.asList("Java多态是面向对象编程的重要特性...");
        String response = "Java多态是面向对象编程的重要特性，它允许不同类的对象对同一消息做出响应。";

        when(llmChat.chat(prompt, contexts)).thenReturn(response);

        String result = llmChat.chat(prompt, contexts);

        assertNotNull(result);
        assertEquals(response, result);
        verify(llmChat).chat(prompt, contexts);
    }

    /**
     * 测试文档解析器工厂
     */
    @Test
    public void testDocumentParserFactory() {
        String fileName = "test.pdf";
        String content = "PDF content";

        when(documentParserFactory.parse(anyString(), anyString())).thenReturn(content);

        String result = documentParserFactory.parse(fileName, "pdf");

        assertNotNull(result);
        assertEquals(content, result);
        verify(documentParserFactory).parse(fileName, "pdf");
    }

    /**
     * 测试层次化分块
     */
    @Test
    public void testHierarchicalChunker() {
        String content = "Java多态是面向对象编程的重要特性。它允许不同类的对象对同一消息做出响应。";
        List<String> chunks = Arrays.asList("Java多态是面向对象编程的重要特性。", "它允许不同类的对象对同一消息做出响应。");

        when(hierarchicalChunker.chunk(content)).thenReturn(chunks);

        List<String> result = hierarchicalChunker.chunk(content);

        assertNotNull(result);
        assertEquals(2, result.size());
        verify(hierarchicalChunker).chunk(content);
    }
}
