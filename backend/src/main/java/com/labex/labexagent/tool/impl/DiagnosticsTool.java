package com.labex.labexagent.tool.impl;

import com.google.gson.JsonObject;
import com.labex.labexagent.lsp.DiagnosticsService;
import com.labex.labexagent.runtime.AgentContext;
import com.labex.labexagent.tool.AgentTool;
import com.labex.labexagent.tool.ToolDefinition;
import com.labex.labexagent.tool.ToolResult;
import com.labex.labexagent.tool.ToolSupport;
import org.springframework.stereotype.Component;

import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

@Component
public class DiagnosticsTool implements AgentTool {
    private final DiagnosticsService diagnosticsService;

    public DiagnosticsTool(DiagnosticsService diagnosticsService) {
        this.diagnosticsService = diagnosticsService;
    }

    @Override
    public ToolDefinition definition() {
        return ToolDefinition.builder()
            .name("diagnostics")
            .description("Analyze a file for syntax errors, warnings, and common issues. Supports Java, JavaScript/TypeScript, Python, JSON, CSS.")
            .stringProperty("file_path", "Path to the file to analyze", true)
            .build();
    }

    @Override
    public ToolResult execute(AgentContext context, JsonObject args) throws Exception {
        String pathArg = ToolSupport.stringArgMulti(args, "", "file_path", "path");
        if (pathArg.isBlank()) {
            return ToolResult.failed("file_path is required");
        }

        Path file = ToolSupport.resolve(context, pathArg);
        if (!Files.isRegularFile(file)) {
            return ToolResult.failed("File not found: " + pathArg);
        }

        String content = Files.readString(file);
        List<DiagnosticsService.Diagnostic> diagnostics = diagnosticsService.analyze(file, content);

        if (diagnostics.isEmpty()) {
            return ToolResult.ok("No issues found in " + pathArg);
        }

        long errors = diagnostics.stream().filter(d -> d.getSeverity() == DiagnosticsService.DiagnosticSeverity.ERROR).count();
        long warnings = diagnostics.stream().filter(d -> d.getSeverity() == DiagnosticsService.DiagnosticSeverity.WARNING).count();

        StringBuilder sb = new StringBuilder();
        sb.append("Analysis for ").append(pathArg).append(":\n");
        sb.append("Found ").append(errors).append(" error(s), ").append(warnings).append(" warning(s)\n\n");

        for (DiagnosticsService.Diagnostic d : diagnostics) {
            String tag = switch (d.getSeverity()) {
                case ERROR -> "ERROR";
                case WARNING -> "WARNING";
                case INFORMATION -> "INFO";
                case HINT -> "HINT";
            };
            sb.append("- [").append(tag).append("] Line ").append(d.getLine());
            sb.append(": ").append(d.getMessage()).append("\n");
        }

        return ToolResult.ok(sb.toString());
    }
}
