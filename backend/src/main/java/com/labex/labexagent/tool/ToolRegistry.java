package com.labex.labexagent.tool;

import com.labex.labexagent.tool.AgentTool;
import com.labex.labexagent.tool.ToolDefinition;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Component;

@Component
public class ToolRegistry {
    private final Map<String, AgentTool> tools = new LinkedHashMap();

    public ToolRegistry(List<AgentTool> agentTools) {
        for (AgentTool tool : agentTools) {
            this.tools.put(tool.definition().getName(), tool);
        }
    }

    public AgentTool get(String name) {
        return (AgentTool)this.tools.get(name);
    }

    public Collection<ToolDefinition> definitions() {
        return this.tools.values().stream().map(AgentTool::definition).toList();
    }
}

