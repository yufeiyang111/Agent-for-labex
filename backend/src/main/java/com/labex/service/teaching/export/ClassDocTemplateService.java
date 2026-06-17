package com.labex.service.teaching.export;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

/**
 * Central access point for the official teaching document templates.
 * All CTL document exports must read templates from Class-docs instead of
 * creating private ad-hoc layouts.
 */
@Component
public class ClassDocTemplateService {

    @Value("${class-docs.path:D:/workfordasan/Class-docs}")
    private String basePath;

    public Path requireTemplate(String filename) {
        Path path = Paths.get(basePath).resolve(filename).normalize();
        if (!Files.isRegularFile(path)) {
            throw new IllegalStateException("缺少教学文档模板: " + path);
        }
        return path;
    }

    public XSSFWorkbook openXlsxTemplate(String filename) throws IOException {
        Path path = requireTemplate(filename);
        try (InputStream in = Files.newInputStream(path)) {
            return new XSSFWorkbook(in);
        }
    }

    public PDDocument openPdfTemplate(String filename) throws IOException {
        return PDDocument.load(requireTemplate(filename).toFile());
    }
}
