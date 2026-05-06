package com.labex.rag.parser;

import org.apache.poi.hslf.usermodel.HSLFSlideShow;
import org.apache.poi.sl.usermodel.Slide;
import org.apache.poi.sl.usermodel.TextShape;
import org.springframework.stereotype.Component;

import java.io.InputStream;
import java.util.List;

/**
 * PPT Document Parser using Apache POI HSLF
 */
@Component
public class PptParser implements DocumentParser {

    @Override
    public String parse(InputStream inputStream, String fileName) {
        try (HSLFSlideShow ppt = new HSLFSlideShow(inputStream)) {
            StringBuilder text = new StringBuilder();
            for (Slide<?, ?> slide : ppt.getSlides()) {
                for (org.apache.poi.sl.usermodel.Shape<?, ?> shape : slide.getShapes()) {
                    if (shape instanceof TextShape<?, ?> textShape) {
                        String shapeText = textShape.getText();
                        if (shapeText != null && !shapeText.isBlank()) {
                            text.append(shapeText).append("\n");
                        }
                    }
                }
            }
            return text.toString();
        } catch (Exception e) {
            throw new RuntimeException("Failed to parse PPT: " + e.getMessage(), e);
        }
    }

    @Override
    public List<String> getSupportedExtensions() {
        return List.of(".ppt", ".pptx");
    }

    @Override
    public boolean supports(String fileName) {
        if (fileName == null) return false;
        String lower = fileName.toLowerCase();
        return lower.endsWith(".ppt") || lower.endsWith(".pptx");
    }
}