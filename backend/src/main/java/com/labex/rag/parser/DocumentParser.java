package com.labex.rag.parser;

import java.io.InputStream;
import java.util.List;

/**
 * Document Parser Interface
 */
public interface DocumentParser {

    /**
     * Parse document and extract text content
     *
     * @param inputStream File input stream
     * @param fileName    File name
     * @return Extracted text content
     */
    String parse(InputStream inputStream, String fileName);

    /**
     * Get supported file extensions
     *
     * @return List of extensions like ".pdf", ".docx"
     */
    List<String> getSupportedExtensions();

    /**
     * Check if this parser supports the given file
     *
     * @param fileName File name
     * @return true if supported
     */
    boolean supports(String fileName);
}
