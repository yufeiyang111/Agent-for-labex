package com.labex.labexagent.tool.impl;

import com.google.gson.JsonObject;
import com.labex.labexagent.runtime.AgentContext;
import com.labex.labexagent.tool.AgentTool;
import com.labex.labexagent.tool.ToolDefinition;
import com.labex.labexagent.tool.ToolResult;
import com.labex.labexagent.tool.ToolSupport;
import java.nio.file.Files;
import java.nio.file.LinkOption;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;
import org.springframework.stereotype.Component;

@Component
public class LspSymbolsTool
implements AgentTool {
    private static final Pattern SYMBOL = Pattern.compile("^\\s*(public|private|protected|export|class|interface|enum|function|def|const|let|var|@\\w+).*");

    public ToolDefinition definition() {
        return ToolDefinition.builder().name("lsp_symbols").description("\u63d0\u53d6\u5355\u4e2a\u6587\u4ef6\u7684\u7b26\u53f7/\u58f0\u660e\u8f6e\u5ed3\u3002\u8f7b\u91cf\u66ff\u4ee3\u8bfb\u53d6\u5b8c\u6574\u5927\u6587\u4ef6\u3002").stringProperty("file_path", "\u8981\u5206\u6790\u7684\u6587\u4ef6\u8def\u5f84", true).intProperty("max_symbols", "\u6700\u5927\u8fd4\u56de\u7b26\u53f7\u6570\uff0c\u9ed8\u8ba4120", false).build();
    }

    public ToolResult execute(AgentContext context, JsonObject args) throws Exception {
        String pathArg = ToolSupport.stringArgMulti((JsonObject)args, "", (String[])new String[]{"file_path", "path"});
        if (pathArg.isBlank()) {
            return ToolResult.failed("file_path is required");
        }
        Path file = ToolSupport.resolve((AgentContext)context, (String)pathArg);
        if (!Files.isRegularFile(file, new LinkOption[0])) {
            return ToolResult.failed("file not found");
        }
        int max = Math.min(300, Math.max(1, ToolSupport.intArg((JsonObject)args, "max_symbols", 120)));
        List<String> lines = Files.readAllLines(file);
        ArrayList<String> symbols = new ArrayList<>();
        for (int i = 0; i < lines.size() && symbols.size() < max; ++i) {
            String line = lines.get(i);
            if (!SYMBOL.matcher(line).matches()) continue;
            symbols.add((i + 1) + ": " + line.trim());
        }
        return ToolResult.ok(symbols.isEmpty() ? "No obvious symbols found." : String.join("\n", symbols));
    }
}

