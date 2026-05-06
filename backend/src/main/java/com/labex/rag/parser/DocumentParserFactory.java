package com.labex.rag.parser;

import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Factory for getting appropriate parser based on file type
 */
@Component
public class DocumentParserFactory {

    private final Map<String, DocumentParser> parserMap = new HashMap<>();

    public DocumentParserFactory(List<DocumentParser> parsers) {
        for (DocumentParser parser : parsers) {
            for (String ext : parser.getSupportedExtensions()) {
                parserMap.put(ext.toLowerCase(), parser);
            }
        }
    }

    /**
     * Get parser for file
     *
     * @param fileName File name
     * @return Appropriate parser or null
     */
    public DocumentParser getParser(String fileName) {
        if (fileName == null) return null;

        for (String ext : parserMap.keySet()) {
            if (fileName.toLowerCase().endsWith(ext)) {
                return parserMap.get(ext);
            }
        }
        return null;
    }
}
