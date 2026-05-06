package com.labex.rag.parser;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;
import org.springframework.stereotype.Component;

import java.io.InputStream;
import java.util.List;

/**
 * PDF Document Parser using Apache PDFBox
 */
@Component
public class PdfParser implements DocumentParser {

    @Override
    public String parse(InputStream inputStream, String fileName) {
        try (PDDocument document = PDDocument.load(inputStream)) {
            PDFTextStripper stripper = new PDFTextStripper();
            stripper.setSortByPosition(true);
            return stripper.getText(document);
        } catch (Exception e) {
            throw new RuntimeException("Failed to parse PDF: " + e.getMessage(), e);
        }
    }

    @Override
    public List<String> getSupportedExtensions() {
        return List.of(".pdf");
    }

    @Override
    public boolean supports(String fileName) {
        return fileName != null && fileName.toLowerCase().endsWith(".pdf");
    }
}
