package com.labex.rag.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.Map;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class QueryResponse {

    private String answer;

    private List<Map<String, Object>> sources;

    private String sessionId;

    private boolean fromKnowledgeBase = true;
}
