package com.labex.controller.teacher;

import lombok.Data;
import java.util.List;
import java.util.Map;

/**
 * Response for question generation.
 */
@Data
public class GenerateResponse {
    private int totalGenerated;
    private int totalDuplicates;
    private int totalErrors;
    private List<LectureResult> lectureResults;
    private List<String> errors;

    @Data
    public static class LectureResult {
        private Integer lectureId;
        private String lectureName;
        private int generated;
        private int duplicates;
        /** Map of type -> count, e.g. {"1": 8, "2": 10} */
        private Map<String, Integer> typeDistribution;
    }
}
