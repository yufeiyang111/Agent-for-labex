package com.labex.rag.parser;

import org.springframework.stereotype.Component;

import java.io.InputStream;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.List;
import java.nio.charset.StandardCharsets;

/**
 * Markdown Document Parser
 */
@Component
public class MdParser implements DocumentParser {

    @Override
    public String parse(InputStream inputStream, String fileName) {
        try (BufferedReader reader = new BufferedReader(
                new InputStreamReader(inputStream, StandardCharsets.UTF_8))) {
            StringBuilder content = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                // Remove markdown syntax but keep content
                line = line.replaceAll("#+\\s*", "")  // Headers
                        .replaceAll("\\*\\*|__", "")  // Bold
                        .replaceAll("\\*|_", "")       // Italic
                        .replaceAll("\\[([^\\]]+)\\]\\([^)]+\\)", "$1")  // Links
                        .replaceAll("!\\[([^\\]]*)\\]\\([^)]*\\)", "")  // Images
                        .replaceAll("`{1,3}", "")  // Code blocks
                        .replaceAll("\\|", " ")    // Tables
                        .replaceAll("^\\s*[-*+]\\s+", "")  // Lists
                        .replaceAll("^\\s*\\d+\\.\\s+", "");  // Numbered lists
                content.append(line).append("\n");
            }
            // Clean extra whitespace
            return content.toString().replaceAll("\\s+", " ").trim();
        } catch (Exception e) {
            throw new RuntimeException("Failed to parse Markdown: " + e.getMessage(), e);
        }
    }

    @Override
    public List<String> getSupportedExtensions() {
        return List.of(".md", ".markdown");
    }

    @Override
    public boolean supports(String fileName) {
        if (fileName == null) return false;
        String lower = fileName.toLowerCase();
        return lower.endsWith(".md") || lower.endsWith(".markdown");
    }
}
