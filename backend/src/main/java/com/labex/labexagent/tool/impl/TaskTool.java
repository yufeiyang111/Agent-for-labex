package com.labex.labexagent.tool.impl;

import com.google.gson.JsonObject;
import com.labex.labexagent.runtime.AgentContext;
import com.labex.labexagent.tool.AgentTool;
import com.labex.labexagent.tool.ToolDefinition;
import com.labex.labexagent.tool.ToolResult;
import com.labex.labexagent.tool.ToolSupport;
import org.springframework.stereotype.Component;

@Component
public class TaskTool
implements AgentTool {
    public ToolDefinition definition() {
        return ToolDefinition.builder().name("task").description("Records a focused subtask summary; use todo_write for active tracking.").stringProperty("description", "subtask description", true).build();
    }

    public ToolResult execute(AgentContext context, JsonObject args) {
        String description = ToolSupport.stringArg((JsonObject)args, "description", "");
        if (description.isBlank()) {
            return ToolResult.failed("description is required");
        }
        return ToolResult.ok((String)("Subtask noted:\n" + ToolSupport.limit((String)description, 2000)));
    }
}
