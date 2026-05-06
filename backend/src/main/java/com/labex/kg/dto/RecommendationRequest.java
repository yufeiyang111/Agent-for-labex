package com.labex.kg.dto;

import lombok.Data;

@Data
public class RecommendationRequest {
    private String knowledgePointId;
    private Integer questionId;
    private String topicId;
    private int limit = 10;
    private boolean includeMastered = false;
    private boolean explain = false;
}
