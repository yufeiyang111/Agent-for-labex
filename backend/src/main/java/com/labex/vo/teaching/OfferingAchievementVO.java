package com.labex.vo.teaching;

import lombok.Data;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

/**
 * 开课级达成度（CTL-S5）
 */
@Data
public class OfferingAchievementVO {

    private Integer offeringId;

    /** 目标维度的班级聚合结果 */
    private Map<Integer, ObjectiveSummary> byObjective;

    /** 课程总目标达成度（学生总得分≥60的比例） */
    private BigDecimal overallReachedRatio;

    /** 学生明细 */
    private List<StudentAchievementVO> students;

    @Data
    public static class ObjectiveSummary {
        private Integer objectiveId;
        private String code;
        private String description;
        /** 达成度（班级层= reachedCount/totalCount） */
        private BigDecimal value;
        private Integer reachedCount;
        private Integer totalCount;
        /** 期望比例（passing / max） */
        private BigDecimal expectedRatio;
        /** 平均得分 */
        private BigDecimal avgScore;
    }
}
