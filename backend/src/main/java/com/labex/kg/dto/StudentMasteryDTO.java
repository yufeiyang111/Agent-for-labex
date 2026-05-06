package com.labex.kg.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class StudentMasteryDTO {
    private double overallMastery;
    private List<MasteryItem> weakPoints;
    private List<MasteryItem> strongPoints;
    private List<RadarPoint> radarData;

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class MasteryItem {
        private String kpName;
        private double mastery;
        private int attemptCount;
        private String lastAttempted;
    }

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class RadarPoint {
        private String kpName;
        private double mastery;
    }
}
