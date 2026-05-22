package com.labex.labexagent.tool.impl;

import com.google.gson.JsonObject;
import com.labex.labexagent.runtime.AgentContext;
import com.labex.labexagent.tool.AgentTool;
import com.labex.labexagent.tool.ToolDefinition;
import com.labex.labexagent.tool.ToolResult;
import java.net.URLEncoder;
import org.springframework.stereotype.Component;

@Component
public class WebSearchTool
implements AgentTool {
    public ToolDefinition definition() {
        return ToolDefinition.builder().name("web_search").description("\u641c\u7d22\u4e92\u8054\u7f51\u83b7\u53d6\u5b9e\u65f6\u4fe1\u606f\u3002\u5f53\u524d\u65e0\u641c\u7d22 API key \u65f6\u8fd4\u56de\u53ef\u6267\u884c\u641c\u7d22\u5efa\u8bae\u3002").stringProperty("query", "\u641c\u7d22\u5173\u952e\u8bcd", true).build();
    }

    public ToolResult execute(AgentContext context, JsonObject args) throws Exception {
        String query;
        String string = query = args.has("query") ? args.get("query").getAsString() : "";
        if (query.isEmpty()) {
            return ToolResult.failed("query is required");
        }
        String result = "\u641c\u7d22\u5efa\u8bae: " + query + "\nGoogle \u641c\u7d22\u94fe\u63a5: https://www.google.com/search?q=" + URLEncoder.encode(query, "UTF-8") + "\n\u6ce8\u610f: \u5f53\u524d\u65e0\u641c\u7d22 API key\uff0c\u8bf7\u624b\u52a8\u8bbf\u95ee\u4e0a\u8ff0\u94fe\u63a5\u83b7\u53d6\u4fe1\u606f\u3002";
        return ToolResult.ok((String)result);
    }
}

