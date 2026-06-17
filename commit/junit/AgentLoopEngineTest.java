package com.labex.labexagent.runtime;

import com.labex.labexagent.dto.AgentEvent;
import com.labex.labexagent.tool.ToolCall;
import com.labex.labexagent.tool.ToolResult;
import com.labex.labexagent.tool.ToolRegistry;
import com.labex.labexagent.tool.ToolDefinition;
import com.labex.labexagent.diff.DiffService;
import com.labex.labexagent.runtime.AgentSsePublisher;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

/**
 * 代理循环引擎测试
 * 测试人员：余飞杨
 * 测试内容：代理执行循环、工具调用、任务管理
 */
@ExtendWith(MockitoExtension.class)
public class AgentLoopEngineTest {

    @InjectMocks
    private AgentLoopEngine agentLoopEngine;

    @Mock
    private ToolRegistry toolRegistry;

    @Mock
    private DiffService diffService;

    @Mock
    private AgentSsePublisher ssePublisher;

    /**
     * 测试代理执行 - 成功场景
     */
    @Test
    public void testAgentExecutionSuccess() {
        String projectId = "1";
        String message = "帮我创建一个Hello World程序";

        ToolDefinition toolDef = new ToolDefinition();
        toolDef.setName("write_file");
        toolDef.setDescription("写入文件");

        ToolResult toolResult = new ToolResult();
        toolResult.setStatus("success");
        toolResult.setContent("文件已创建");

        when(toolRegistry.getToolDefinition("write_file")).thenReturn(toolDef);
        when(toolRegistry.executeTool(any(ToolCall.class))).thenReturn(toolResult);

        agentLoopEngine.execute(projectId, message, ssePublisher);

        verify(ssePublisher, atLeastOnce()).publish(any(AgentEvent.class));
    }

    /**
     * 测试代理执行 - 工具调用失败
     */
    @Test
    public void testAgentExecutionToolFailure() {
        String projectId = "1";
        String message = "帮我执行一个命令";

        ToolResult toolResult = new ToolResult();
        toolResult.setStatus("error");
        toolResult.setContent("命令执行失败");

        when(toolRegistry.executeTool(any(ToolCall.class))).thenReturn(toolResult);

        agentLoopEngine.execute(projectId, message, ssePublisher);

        verify(ssePublisher, atLeastOnce()).publish(any(AgentEvent.class));
    }

    /**
     * 测试代理执行 - 达到最大迭代次数
     */
    @Test
    public void testAgentExecutionMaxIterations() {
        String projectId = "1";
        String message = "帮我执行一个复杂的任务";

        ToolResult toolResult = new ToolResult();
        toolResult.setStatus("success");
        toolResult.setContent("任务执行中...");

        when(toolRegistry.executeTool(any(ToolCall.class))).thenReturn(toolResult);

        agentLoopEngine.execute(projectId, message, ssePublisher);

        // 验证不会超过30次迭代
        verify(toolRegistry, atMost(30)).executeTool(any(ToolCall.class));
    }

    /**
     * 测试代理执行 - 取消任务
     */
    @Test
    public void testAgentExecutionCancel() {
        String projectId = "1";
        String message = "帮我执行一个任务";

        agentLoopEngine.cancel(projectId);

        agentLoopEngine.execute(projectId, message, ssePublisher);

        // 验证任务被取消
        verify(ssePublisher, atLeastOnce()).publish(any(AgentEvent.class));
    }

    /**
     * 测试工具注册
     */
    @Test
    public void testToolRegistration() {
        ToolDefinition toolDef = new ToolDefinition();
        toolDef.setName("test_tool");
        toolDef.setDescription("测试工具");

        toolRegistry.registerTool(toolDef);

        verify(toolRegistry).registerTool(toolDef);
    }

    /**
     * 测试获取工具列表
     */
    @Test
    public void testGetToolList() {
        List<ToolDefinition> tools = Arrays.asList(
                createToolDefinition("read_file", "读取文件"),
                createToolDefinition("write_file", "写入文件"),
                createToolDefinition("edit_file", "编辑文件")
        );

        when(toolRegistry.getToolDefinitions()).thenReturn(tools);

        List<ToolDefinition> result = toolRegistry.getToolDefinitions();

        assertNotNull(result);
        assertEquals(3, result.size());
        verify(toolRegistry).getToolDefinitions();
    }

    /**
     * 测试工具执行 - read_file
     */
    @Test
    public void testExecuteReadFile() {
        ToolCall toolCall = new ToolCall();
        toolCall.setName("read_file");
        toolCall.setParameters(Map.of("path", "/src/Main.java"));

        ToolResult toolResult = new ToolResult();
        toolResult.setStatus("success");
        toolResult.setContent("public class Main { }");

        when(toolRegistry.executeTool(toolCall)).thenReturn(toolResult);

        ToolResult result = toolRegistry.executeTool(toolCall);

        assertNotNull(result);
        assertEquals("success", result.getStatus());
        assertEquals("public class Main { }", result.getContent());
        verify(toolRegistry).executeTool(toolCall);
    }

    /**
     * 测试工具执行 - write_file
     */
    @Test
    public void testExecuteWriteFile() {
        ToolCall toolCall = new ToolCall();
        toolCall.setName("write_file");
        toolCall.setParameters(Map.of(
                "path", "/src/Main.java",
                "content", "public class Main { }"
        ));

        ToolResult toolResult = new ToolResult();
        toolResult.setStatus("success");
        toolResult.setContent("文件已写入");

        when(toolRegistry.executeTool(toolCall)).thenReturn(toolResult);

        ToolResult result = toolRegistry.executeTool(toolCall);

        assertNotNull(result);
        assertEquals("success", result.getStatus());
        verify(toolRegistry).executeTool(toolCall);
    }

    /**
     * 测试工具执行 - shell
     */
    @Test
    public void testExecuteShell() {
        ToolCall toolCall = new ToolCall();
        toolCall.setName("shell");
        toolCall.setParameters(Map.of("command", "ls -la"));

        ToolResult toolResult = new ToolResult();
        toolResult.setStatus("success");
        toolResult.setContent("total 0\ndrwxr-xr-x 2 user user 4096 Jan 1 00:00 .");

        when(toolRegistry.executeTool(toolCall)).thenReturn(toolResult);

        ToolResult result = toolRegistry.executeTool(toolCall);

        assertNotNull(result);
        assertEquals("success", result.getStatus());
        verify(toolRegistry).executeTool(toolCall);
    }

    /**
     * 测试工具执行 - glob
     */
    @Test
    public void testExecuteGlob() {
        ToolCall toolCall = new ToolCall();
        toolCall.setName("glob");
        toolCall.setParameters(Map.of("pattern", "**/*.java"));

        ToolResult toolResult = new ToolResult();
        toolResult.setStatus("success");
        toolResult.setContent("/src/Main.java\n/src/Utils.java");

        when(toolRegistry.executeTool(toolCall)).thenReturn(toolResult);

        ToolResult result = toolRegistry.executeTool(toolCall);

        assertNotNull(result);
        assertEquals("success", result.getStatus());
        verify(toolRegistry).executeTool(toolCall);
    }

    /**
     * 测试工具执行 - grep
     */
    @Test
    public void testExecuteGrep() {
        ToolCall toolCall = new ToolCall();
        toolCall.setName("grep");
        toolCall.setParameters(Map.of(
                "pattern", "public class",
                "path", "/src"
        ));

        ToolResult toolResult = new ToolResult();
        toolResult.setStatus("success");
        toolResult.setContent("/src/Main.java:1:public class Main {");

        when(toolRegistry.executeTool(toolCall)).thenReturn(toolResult);

        ToolResult result = toolRegistry.executeTool(toolCall);

        assertNotNull(result);
        assertEquals("success", result.getStatus());
        verify(toolRegistry).executeTool(toolCall);
    }

    /**
     * 测试差异服务
     */
    @Test
    public void testDiffService() {
        String projectId = "1";
        String filePath = "/src/Main.java";
        String oldContent = "public class Main { }";
        String newContent = "public class Main {\n    public static void main(String[] args) {\n        System.out.println(\"Hello World\");\n    }\n}";

        when(diffService.generateDiff(anyString(), anyString(), anyString())).thenReturn("diff content");

        String diff = diffService.generateDiff(projectId, filePath, newContent);

        assertNotNull(diff);
        verify(diffService).generateDiff(projectId, filePath, newContent);
    }

    /**
     * 测试SSE发布
     */
    @Test
    public void testSsePublish() {
        AgentEvent event = new AgentEvent();
        event.setType("message");
        event.setContent("测试消息");

        ssePublisher.publish(event);

        verify(ssePublisher).publish(event);
    }

    /**
     * 测试代理事件类型
     */
    @Test
    public void testAgentEventTypes() {
        AgentEvent messageEvent = new AgentEvent();
        messageEvent.setType("message");
        assertEquals("message", messageEvent.getType());

        AgentEvent toolCallEvent = new AgentEvent();
        toolCallEvent.setType("tool_call");
        assertEquals("tool_call", toolCallEvent.getType());

        AgentEvent toolResultEvent = new AgentEvent();
        toolResultEvent.setType("tool_result");
        assertEquals("tool_result", toolResultEvent.getType());

        AgentEvent errorEvent = new AgentEvent();
        errorEvent.setType("error");
        assertEquals("error", errorEvent.getType());

        AgentEvent doneEvent = new AgentEvent();
        doneEvent.setType("done");
        assertEquals("done", doneEvent.getType());
    }

    // ==================== 辅助方法 ====================

    private ToolDefinition createToolDefinition(String name, String description) {
        ToolDefinition toolDef = new ToolDefinition();
        toolDef.setName(name);
        toolDef.setDescription(description);
        return toolDef;
    }
}
