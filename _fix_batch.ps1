$utf8 = New-Object System.Text.UTF8Encoding $false
$base = "D:\workfordasan\backend\src\main\java\com\labex"

# MiniMaxStreamingChatModel
[System.IO.File]::WriteAllText("$base\langchain4j\model\MiniMaxStreamingChatModel.java", @"
package com.labex.langchain4j.model;

import com.labex.rag.llm.MiniMaxChat;
import dev.langchain4j.data.message.AiMessage;
import dev.langchain4j.data.message.ChatMessage;
import dev.langchain4j.data.message.ChatMessageType;
import dev.langchain4j.model.StreamingResponseHandler;
import dev.langchain4j.model.chat.StreamingChatLanguageModel;
import dev.langchain4j.model.output.Response;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class MiniMaxStreamingChatModel implements StreamingChatLanguageModel {
    private final MiniMaxChat miniMaxChat;
    private final ExecutorService executor = Executors.newCachedThreadPool();

    public MiniMaxStreamingChatModel(MiniMaxChat miniMaxChat) { this.miniMaxChat = miniMaxChat; }

    public void generate(List<ChatMessage> messages, StreamingResponseHandler<AiMessage> handler) {
        this.executor.submit(() -> {
            try {
                StringBuilder context = new StringBuilder();
                String userQuestion = "";
                for (ChatMessage msg : messages) {
                    String text = msg.text();
                    ChatMessageType type = msg.type();
                    if (type == ChatMessageType.SYSTEM) context.append(text).append("\n");
                    else if (type == ChatMessageType.USER) userQuestion = text;
                    else if (type == ChatMessageType.AI) context.append("Previous response: ").append(text).append("\n");
                }
                String answer = this.miniMaxChat.chat(context.toString(), "", userQuestion);
                AiMessage aiMessage = AiMessage.from((String)answer);
                handler.onNext(answer);
                handler.onComplete(Response.from((Object)aiMessage));
            } catch (Exception e) { handler.onError((Throwable)e); }
        });
    }
}
"@, $utf8)

# ExecuteCodeTool
[System.IO.File]::WriteAllText("$base\labexagent\tool\impl\ExecuteCodeTool.java", @"
package com.labex.labexagent.tool.impl;

import com.google.gson.JsonObject;
import com.labex.labexagent.runtime.AgentContext;
import com.labex.labexagent.tool.AgentTool;
import com.labex.labexagent.tool.ToolDefinition;
import com.labex.labexagent.tool.ToolResult;
import com.labex.labexagent.tool.ToolSupport;
import org.springframework.stereotype.Component;

import java.io.File;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.concurrent.TimeUnit;

@Component
public class ExecuteCodeTool implements AgentTool {
    public ToolDefinition definition() {
        return ToolDefinition.builder()
            .name("execute_code").description("Execute Python/JavaScript code in sandbox.")
            .stringProperty("language", "Programming language: python or javascript", true)
            .stringProperty("code", "Code to execute", true)
            .intProperty("timeout_seconds", "Timeout in seconds (default 30)", false).build();
    }

    public ToolResult execute(AgentContext context, JsonObject args) throws Exception {
        String language = args.has("language") ? args.get("language").getAsString() : "";
        String code = args.has("code") ? args.get("code").getAsString() : "";
        if (language.isEmpty()) return ToolResult.failed("language is required");
        if (code.isEmpty()) return ToolResult.failed("code is required");
        int timeout = Math.min(120, Math.max(1, args.has("timeout_seconds") ? args.get("timeout_seconds").getAsInt() : 30));
        String extension = language.equalsIgnoreCase("python") ? ".py" : ".js";
        String command = language.equalsIgnoreCase("python") ? "python3" : "node";
        Path tempFile = context.getWorkspaceRoot().resolve(".labex-agent" + File.separator + "temp" + System.currentTimeMillis() + extension);
        Files.createDirectories(tempFile.getParent());
        Files.writeString(tempFile, code);
        boolean windows = System.getProperty("os.name").toLowerCase().contains("win");
        List<String> cmd = windows ? List.of("cmd.exe", "/c", command + " " + tempFile.toString()) : List.of("/bin/sh", "-c", command + " " + tempFile.toString());
        try {
            Process process = new ProcessBuilder(cmd).directory(context.getWorkspaceRoot().toFile()).redirectErrorStream(true).start();
            boolean finished = process.waitFor(timeout, TimeUnit.SECONDS);
            if (!finished) { process.destroyForcibly(); return ToolResult.failed("Code execution timeout"); }
            String output = new String(process.getInputStream().readAllBytes(), StandardCharsets.UTF_8);
            return ToolResult.ok("exit=" + process.exitValue() + "\n" + ToolSupport.limit(output, 60000));
        } finally { try { Files.deleteIfExists(tempFile); } catch (Exception e) {} }
    }
}
"@, $utf8)

# OpencodeAliasToolConfig
[System.IO.File]::WriteAllText("$base\labexagent\tool\impl\OpencodeAliasToolConfig.java", @"
package com.labex.labexagent.tool.impl;

import com.google.gson.JsonObject;
import com.labex.labexagent.runtime.AgentContext;
import com.labex.labexagent.tool.AgentTool;
import com.labex.labexagent.tool.ToolDefinition;
import com.labex.labexagent.tool.ToolResult;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;
import java.util.Map;

@Configuration
public class OpencodeAliasToolConfig {
    @Bean public AgentTool opencodeReadAlias(ReadFileTool d) { return alias("read","",d,ToolDefinition.builder().name("read").description("Read file.").stringProperty("file_path","",true).intProperty("offset","",false).intProperty("limit","",false).build()); }
    @Bean public AgentTool opencodeWriteAlias(WriteFileTool d) { return alias("write","",d,ToolDefinition.builder().name("write").description("Write file.").stringProperty("file_path","",true).stringProperty("content","",true).build()); }
    @Bean public AgentTool opencodeEditAlias(EditFileTool d) { return alias("edit","",d,ToolDefinition.builder().name("edit").description("Edit file.").stringProperty("file_path","",true).stringProperty("old_string","",true).stringProperty("new_string","",true).build()); }
    @Bean public AgentTool opencodePatchAlias(ApplyPatchTool d) { return alias("patch","",d,ToolDefinition.builder().name("patch").description("Apply patch.").arrayProperty("changes","",Map.of("type","object"),true).build()); }
    @Bean public AgentTool opencodeWebfetchAlias(WebFetchTool d) { return alias("webfetch","",d,ToolDefinition.builder().name("webfetch").description("Fetch URL.").stringProperty("url","",true).intProperty("max_chars","",false).build()); }
    @Bean public AgentTool opencodeWebsearchAlias(WebSearchTool d) { return alias("websearch","",d,ToolDefinition.builder().name("websearch").description("Search web.").stringProperty("query","",true).build()); }
    @Bean public AgentTool opencodeRepoOverviewAlias(ProjectOverviewTool d) { return alias("repo_overview","",d,ToolDefinition.builder().name("repo_overview").description("Project overview.").stringProperty("query","",false).build()); }
    @Bean public AgentTool opencodeTodoAlias(TodoWriteTool d) { return alias("todo","",d,ToolDefinition.builder().name("todo").description("Todo list.").stringProperty("todos","",true).build()); }

    private AgentTool alias(String name, String desc, AgentTool delegate, ToolDefinition def) {
        return new AgentTool() {
            public ToolDefinition definition() { return def; }
            public ToolResult execute(AgentContext ctx, JsonObject args) throws Exception { return delegate.execute(ctx, args); }
        };
    }
}
"@, $utf8)

Write-Output 'Batch 1 done'
