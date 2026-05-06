package com.labex.kg.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ExtractionResult {
    private String lectureName;
    private Integer lectureId;
    private List<ExtractedKnowledgePoint> knowledgePoints;
    private int extractedCount;

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class ExtractedKnowledgePoint {
        private String name;
        private String description;
        private List<String> prerequisites;
    }
}
