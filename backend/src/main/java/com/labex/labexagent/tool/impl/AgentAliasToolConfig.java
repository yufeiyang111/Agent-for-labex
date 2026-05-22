package com.labex.labexagent.tool.impl;

import com.google.gson.JsonObject;
import com.labex.labexagent.runtime.AgentContext;
import com.labex.labexagent.tool.AgentTool;
import com.labex.labexagent.tool.ToolDefinition;
import com.labex.labexagent.tool.ToolResult;
import java.util.Map;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AgentAliasToolConfig {
    @Bean public AgentTool readAlias(ReadFileTool d) { return alias(d, ToolDefinition.builder().name("read").description("Read file.").stringProperty("file_path", "", true).intProperty("offset", "", false).intProperty("limit", "", false).build()); }
    @Bean public AgentTool writeAlias(WriteFileTool d) { return alias(d, ToolDefinition.builder().name("write").description("Write file.").stringProperty("file_path", "", true).stringProperty("content", "", true).build()); }
    @Bean public AgentTool editAlias(EditFileTool d) { return alias(d, ToolDefinition.builder().name("edit").description("Edit file.").stringProperty("file_path", "", true).stringProperty("old_string", "", true).stringProperty("new_string", "", true).build()); }
    @Bean public AgentTool patchAlias(ApplyPatchTool d) { return alias(d, ToolDefinition.builder().name("patch").description("Apply patch.").arrayProperty("changes", "", Map.of("type", "object"), true).build()); }
    @Bean public AgentTool webfetchAlias(WebFetchTool d) { return alias(d, ToolDefinition.builder().name("webfetch").description("Fetch URL.").stringProperty("url", "", true).intProperty("max_chars", "", false).build()); }
    @Bean public AgentTool websearchAlias(WebSearchTool d) { return alias(d, ToolDefinition.builder().name("websearch").description("Search web.").stringProperty("query", "", true).build()); }
    @Bean public AgentTool repoOverviewAlias(ProjectOverviewTool d) { return alias(d, ToolDefinition.builder().name("repo_overview").description("Project overview.").stringProperty("query", "", false).build()); }
    @Bean public AgentTool todoAlias(TodoWriteTool d) { return alias(d, ToolDefinition.builder().name("todo").description("Todo list.").stringProperty("todos", "", true).build()); }

    private AgentTool alias(AgentTool delegate, ToolDefinition def) {
        return new AgentTool() {
            public ToolDefinition definition() { return def; }
            public ToolResult execute(AgentContext ctx, JsonObject args) throws Exception { return delegate.execute(ctx, args); }
        };
    }
}
