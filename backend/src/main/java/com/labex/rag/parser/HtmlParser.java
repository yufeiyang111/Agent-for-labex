package com.labex.rag.parser;

import org.jsoup.Jsoup;
import org.jsoup.safety.Safelist;
import org.springframework.stereotype.Component;

import java.io.InputStream;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.List;
import java.nio.charset.StandardCharsets;

/**
 * HTML Document Parser using Jsoup
 */
@Component
public class HtmlParser implements DocumentParser {

    @Override
    public String parse(InputStream inputStream, String fileName) {
        try (BufferedReader reader = new BufferedReader(
                new InputStreamReader(inputStream, StandardCharsets.UTF_8))) {
            StringBuilder html = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                html.append(line).append("\n");
            }

            // Parse HTML and extract text
            org.jsoup.nodes.Document doc = Jsoup.parse(html.toString());
            // Remove script and style elements
            doc.select("script, style").remove();
            // Get text content
            String text = doc.body().text();
            // Clean extra whitespace
            text = text.replaceAll("\\s+", " ").trim();
            return text;
        } catch (Exception e) {
            throw new RuntimeException("Failed to parse HTML: " + e.getMessage(), e);
        }
    }

    @Override
    public List<String> getSupportedExtensions() {
        return List.of(".html", ".htm");
    }

    @Override
    public boolean supports(String fileName) {
        if (fileName == null) return false;
        String lower = fileName.toLowerCase();
        return lower.endsWith(".html") || lower.endsWith(".htm");
    }
}
