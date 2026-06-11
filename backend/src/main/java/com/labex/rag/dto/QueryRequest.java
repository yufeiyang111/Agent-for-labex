package com.labex.rag.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class QueryRequest {

    private String question;

    private String sessionId;

    /**
     * knowledge, web, or hybrid.
     */
    private String retrievalMode;

    /**
     * When enabled, the response includes a user-visible reasoning summary.
     */
    private Boolean deepThinking;

    /**
     * Multimodal attachments. Images are stored as data URLs or uploaded URLs.
     */
    private List<java.util.Map<String, Object>> attachments;
}
