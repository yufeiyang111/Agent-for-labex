package com.labex.vo.teaching;

import lombok.Data;

import java.math.BigDecimal;
import java.util.Map;

/**
 * 单学生达成度（CTL-S5）
 */
@Data
public class StudentAchievementVO {

    private Integer studentId;

    private String studentNo;

    private String studentName;

    /** objectiveId -> 达成度（0~1） */
    private Map<Integer, BigDecimal> objectiveAchievements;

    /** 总达成度 */
    private BigDecimal totalAchievement;

    /** 总加权得分（满分 100 制） */
    private BigDecimal totalWeightedScore;

    /** 总加权满分（标准 100） */
    private BigDecimal totalWeightedMax;
}
