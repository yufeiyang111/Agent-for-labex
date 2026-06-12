package com.labex.vo.teaching;

import lombok.Data;

import java.util.List;
import java.util.Map;

/**
 * 课程质量评价表（CTL-S6 报告 4）
 * 对应《课程质量评价资料汇编.pdf》第 7-8 页
 */
@Data
public class QualityReportVO {

    private String courseName;
    private String courseCategory;
    private Integer teachingHours;
    private java.math.BigDecimal courseCredit;
    private String semester;
    private String teachingTarget;
    private Integer studentCount;
    private String courseResponsible;
    private List<String> courseMembers;
    private List<String> evalGroupMembers;

    /** 评价项目 1：课程目标合理性 */
    private String objectiveIndicatorRationality;   // reasonable/relatively/unreasonable
    private String objectiveContainsKaq;             // contain/partial/none

    /** 评价项目 2：课程目标达成情况 */
    private Map<String, java.math.BigDecimal> attainmentValues;  // objCode -> 达成值
    private String expectedRationality;
    private String analysisRationality;
    private String improvementRationality;

    /** 结论及意见（4 段文本） */
    private String existingIssues;
    private String evaluationValidity;
    private String lastRoundImprovements;
    private String conclusionAndSuggestions;
}
