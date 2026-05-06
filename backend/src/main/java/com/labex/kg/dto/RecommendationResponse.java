package com.labex.kg.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class RecommendationResponse {
    private Integer questionId;
    private String question;
    private int type;
    private String typeName;
    private String knowledgePoint;
    private String reason;
    private double difficulty;
    private double masteryScore;
}
