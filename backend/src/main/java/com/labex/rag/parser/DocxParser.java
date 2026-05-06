package com.labex.rag.parser;

import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.springframework.stereotype.Component;

import java.io.InputStream;
import java.util.List;

/**
 * DOCX Document Parser using Apache POI
 */
@Component
public class DocxParser implements DocumentParser {

    @Override
    public String parse(InputStream inputStream, String fileName) {
        try (XWPFDocument document = new XWPFDocument(inputStream)) {
            StringBuilder text = new StringBuilder();
            for (XWPFParagraph paragraph : document.getParagraphs()) {
                String paragraphText = paragraph.getText();
                if (paragraphText != null && !paragraphText.isBlank()) {
                    text.append(paragraphText).append("\n");
                }
            }
            return text.toString();
        } catch (Exception e) {
            throw new RuntimeException("Failed to parse DOCX: " + e.getMessage(), e);
        }
    }

    @Override
    public List<String> getSupportedExtensions() {
        return List.of(".docx");
    }

    @Override
    public boolean supports(String fileName) {
        return fileName != null && fileName.toLowerCase().endsWith(".docx");
    }
}
