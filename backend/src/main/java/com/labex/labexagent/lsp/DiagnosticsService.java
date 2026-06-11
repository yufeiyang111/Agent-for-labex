package com.labex.labexagent.lsp;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.util.*;
import java.util.regex.Pattern;

@Service
public class DiagnosticsService {
    private static final Logger log = LoggerFactory.getLogger(DiagnosticsService.class);

    private static final Pattern JAVA_IMPORT = Pattern.compile("^import\\s+.*;$");
    private static final Pattern JAVA_CLASS = Pattern.compile("^\\s*(public|private|protected)?\\s*(abstract|final)?\\s*(class|interface|enum|@interface)\\s+\\w+");
    private static final Pattern JAVA_METHOD = Pattern.compile("^\\s*(public|private|protected)?\\s*(static|final|abstract|synchronized)?\\s*(\\w+\\.)*\\w+\\s+\\w+\\s*\\(.*\\)\\s*\\{?$");
    private static final Pattern JS_IMPORT = Pattern.compile("^(import|export)\\s+.*;$");
    private static final Pattern JS_FUNCTION = Pattern.compile("^(export\\s+)?(async\\s+)?function\\s+\\w+\\s*\\(|^(export\\s+)?(const|let|var)\\s+\\w+\\s*=\\s*(async\\s+)?\\(?");
    private static final Pattern PY_CLASS = Pattern.compile("^\\s*class\\s+\\w+");
    private static final Pattern PY_FUNCTION = Pattern.compile("^\\s*(async\\s+)?def\\s+\\w+\\s*\\(.*\\)\\s*:");

    public List<Diagnostic> analyze(Path filePath, String content) {
        if (content == null || content.isBlank()) {
            return List.of();
        }
        String fileName = filePath.getFileName().toString().toLowerCase();
        if (fileName.endsWith(".java")) {
            return analyzeJava(content, fileName);
        } else if (fileName.endsWith(".js") || fileName.endsWith(".jsx") || fileName.endsWith(".ts") || fileName.endsWith(".tsx")) {
            return analyzeJavaScript(content, fileName);
        } else if (fileName.endsWith(".py")) {
            return analyzePython(content, fileName);
        } else if (fileName.endsWith(".json")) {
            return analyzeJson(content, fileName);
        } else if (fileName.endsWith(".css") || fileName.endsWith(".scss")) {
            return analyzeCss(content, fileName);
        }
        return List.of();
    }

    private List<Diagnostic> analyzeJava(String content, String fileName) {
        List<Diagnostic> result = new ArrayList<>();
        String[] lines = content.split("\n", -1);
        boolean inBlockComment = false;
        for (int i = 0; i < lines.length; i++) {
            String line = lines[i];
            int lineNum = i + 1;

            if (inBlockComment) {
                if (line.contains("*/")) inBlockComment = false;
                continue;
            }
            String trimmed = line.trim();
            if (trimmed.startsWith("/*")) {
                if (!trimmed.contains("*/")) inBlockComment = true;
                continue;
            }
            if (trimmed.startsWith("//") || trimmed.startsWith("*")) continue;
            if (trimmed.isEmpty()) continue;

            // Check for missing semicolons on executable statements
            if (!trimmed.startsWith("import") && !trimmed.startsWith("package")
                && !trimmed.endsWith("{") && !trimmed.endsWith("}") && !trimmed.endsWith(";")
                && !trimmed.startsWith("@") && !trimmed.startsWith("//")
                && trimmed.length() > 2 && !trimmed.contains("//")
                && !trimmed.endsWith("*/") && !trimmed.endsWith("+") && !trimmed.endsWith(",")
                && !trimmed.endsWith("(") && !trimmed.endsWith(")") && !trimmed.endsWith("|")
                && !trimmed.endsWith("&") && !trimmed.endsWith("=") && !trimmed.endsWith(":")
                && trimmed.contains(" ") && Character.isLowerCase(trimmed.charAt(0))
                && Character.isLetter(trimmed.charAt(0))) {
                result.add(new Diagnostic(fileName, lineNum, 1, "Possible missing semicolon", DiagnosticSeverity.WARNING));
            }

            // Unclosed string detection (simple)
            int quoteCount = countChar(trimmed, '"');
            if (quoteCount % 2 != 0 && !trimmed.contains("//")) {
                result.add(new Diagnostic(fileName, lineNum, 1, "Unclosed string literal", DiagnosticSeverity.ERROR));
            }
        }
        return result;
    }

    private List<Diagnostic> analyzeJavaScript(String content, String fileName) {
        List<Diagnostic> result = new ArrayList<>();
        String[] lines = content.split("\n", -1);
        boolean inBlockComment = false;
        boolean inTemplate = false;
        for (int i = 0; i < lines.length; i++) {
            String line = lines[i];
            int lineNum = i + 1;
            String trimmed = line.trim();

            if (inBlockComment) {
                if (trimmed.contains("*/")) inBlockComment = false;
                continue;
            }
            if (trimmed.startsWith("/*")) {
                if (!trimmed.contains("*/")) inBlockComment = true;
                continue;
            }
            if (trimmed.startsWith("//")) continue;
            if (trimmed.isEmpty()) continue;

            if (inTemplate) {
                if (trimmed.contains("`")) inTemplate = false;
                continue;
            }
            if (trimmed.contains("`")) {
                long backtickCount = trimmed.chars().filter(ch -> ch == '`').count();
                if (backtickCount % 2 != 0) inTemplate = !inTemplate;
            }

            // Missing semicolons for var/let/const/return/import/export
            if (!trimmed.endsWith(";") && !trimmed.endsWith("{") && !trimmed.endsWith("}")
                && !trimmed.endsWith("(") && !trimmed.endsWith(")") && !trimmed.endsWith(",")
                && !trimmed.endsWith(":") && !trimmed.endsWith("=>") && !trimmed.endsWith("|")
                && !trimmed.endsWith("&") && !trimmed.endsWith("=") && !trimmed.endsWith("[")
                && !trimmed.endsWith("]") && !trimmed.endsWith("`") && !trimmed.endsWith("?")
                && !trimmed.endsWith("+") && !trimmed.endsWith("-") && !trimmed.endsWith("*")
                && !trimmed.endsWith("/") && !trimmed.endsWith(".")
                && (trimmed.startsWith("var ") || trimmed.startsWith("let ") || trimmed.startsWith("const ")
                    || trimmed.startsWith("return ") || trimmed.startsWith("import ")
                    || trimmed.startsWith("export ") || trimmed.startsWith("throw "))) {
                result.add(new Diagnostic(fileName, lineNum, 1, "Possible missing semicolon", DiagnosticSeverity.WARNING));
            }
        }
        return result;
    }

    private List<Diagnostic> analyzePython(String content, String fileName) {
        List<Diagnostic> result = new ArrayList<>();
        String[] lines = content.split("\n", -1);
        for (int i = 0; i < lines.length; i++) {
            String line = lines[i];
            int lineNum = i + 1;
            String trimmed = line.strip();
            if (trimmed.isEmpty() || trimmed.startsWith("#")) continue;

            // Check for mixed tabs and spaces
            if (line.startsWith("\t") && line.contains("    ")) {
                result.add(new Diagnostic(fileName, lineNum, 1, "Mixed tabs and spaces", DiagnosticSeverity.WARNING));
            }
        }

        // Basic indentation consistency check
        List<Integer> indents = new ArrayList<>();
        for (String line : lines) {
            String stripped = line.strip();
            if (stripped.isEmpty() || stripped.startsWith("#")) continue;
            int indent = line.length() - stripped.length();
            if (indent > 0) indents.add(indent);
        }
        if (!indents.isEmpty()) {
            int base = indents.get(0);
            for (int i = 1; i < indents.size(); i++) {
                if (indents.get(i) % base != 0) {
                    result.add(new Diagnostic(fileName, i + 1, 1,
                        "Inconsistent indentation (expected multiple of " + base + ")", DiagnosticSeverity.WARNING));
                    break;
                }
            }
        }
        return result;
    }

    private List<Diagnostic> analyzeJson(String content, String fileName) {
        List<Diagnostic> result = new ArrayList<>();
        try {
            com.google.gson.JsonParser.parseString(content);
        } catch (com.google.gson.JsonSyntaxException e) {
            String msg = e.getMessage();
            // Try to extract line number from error message
            int lineNum = 1;
            if (msg != null) {
                java.util.regex.Matcher m = Pattern.compile("at line (\\d+)").matcher(msg);
                if (m.find()) {
                    lineNum = Integer.parseInt(m.group(1));
                }
            }
            result.add(new Diagnostic(fileName, lineNum, 1,
                "Invalid JSON: " + (msg != null ? msg.substring(0, Math.min(msg.length(), 100)) : "parse error"),
                DiagnosticSeverity.ERROR));
        }
        return result;
    }

    private List<Diagnostic> analyzeCss(String content, String fileName) {
        List<Diagnostic> result = new ArrayList<>();
        String[] lines = content.split("\n", -1);
        for (int i = 0; i < lines.length; i++) {
            String line = lines[i];
            int lineNum = i + 1;
            String trimmed = line.trim();
            if (trimmed.isEmpty() || trimmed.startsWith("/*") || trimmed.startsWith("*")) continue;

            // Missing closing brace
            int openBraces = countChar(trimmed, '{');
            int closeBraces = countChar(trimmed, '}');
            if (openBraces > closeBraces && !trimmed.endsWith("{")) {
                result.add(new Diagnostic(fileName, lineNum, 1, "Missing closing brace", DiagnosticSeverity.WARNING));
            }

            // Check for empty rules
            if (trimmed.equals("{}") || trimmed.equals("{ }")) {
                result.add(new Diagnostic(fileName, lineNum, 1, "Empty CSS rule", DiagnosticSeverity.WARNING));
            }
        }
        return result;
    }

    private int countChar(String s, char c) {
        int count = 0;
        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == c) count++;
        }
        return count;
    }

    public static class Diagnostic {
        private final String file;
        private final int line;
        private final int column;
        private final String message;
        private final DiagnosticSeverity severity;

        public Diagnostic(String file, int line, int column, String message, DiagnosticSeverity severity) {
            this.file = file;
            this.line = line;
            this.column = column;
            this.message = message;
            this.severity = severity;
        }

        public String getFile() { return file; }
        public int getLine() { return line; }
        public int getColumn() { return column; }
        public String getMessage() { return message; }
        public DiagnosticSeverity getSeverity() { return severity; }
    }

    public enum DiagnosticSeverity {
        ERROR, WARNING, INFORMATION, HINT
    }
}
