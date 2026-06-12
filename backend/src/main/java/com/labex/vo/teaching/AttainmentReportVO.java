package com.labex.vo.teaching;

import lombok.Data;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

/**
 * 课程目标达成情况评价报告（CTL-S6 报告 3）
 * 对应《课程质量评价资料汇编.pdf》第 4-6 页
 */
@Data
public class AttainmentReportVO {

    /** 一、课程基本信息 */
    private CourseBasicInfo basicInfo;

    /** 二、课程目标与毕业要求观测点的对应关系及达成途径 */
    private List<ObjectiveSupportRow> objectiveSupports;

    /** 三、3.1 课程考核方式及分值分配 + 3.2 考核方法及内容 */
    private List<AssessmentDistribution> assessmentDistribution;

    /** 四、合理性分析（教师手填） */
    private String rationalityAnalysis;

    /** 五、5.1 主要考核数据 */
    private MainScoreData mainScoreData;

    /** 五、5.2 各课程目标达成情况 */
    private List<ObjectiveAttainmentRow> objectiveAttainment;

    /** 六、达成评价分析（教师手填） */
    private String attainmentAnalysis;

    /** 七、上一轮存在问题及本轮改进效果 */
    private String lastRoundImprovements;

    /** 八、下一轮教学改进措施 */
    private String nextRoundImprovements;

    @Data
    public static class CourseBasicInfo {
        private String courseName;
        private String semester;
        private Integer theoryHours;
        private Integer labHours;
        private String assessmentMethod;
        private String teacherName;
        private String teacherTitle;
        private String clazzNo;
        private Integer studentCount;
    }

    @Data
    public static class ObjectiveSupportRow {
        private String objectiveCode;
        private String objectiveDescription;
        private String supportedRequirements;     // "5"
        private String supportedIndicators;       // "5.1"
        private String attainmentMethod;          // 主要达成途径（教学设计）
    }

    @Data
    public static class AssessmentDistribution {
        private String objectiveCode;
        /** type ("homework"/"experiment"/"exam") -> 该目标下该类型的合计权重 */
        private Map<String, BigDecimal> typeWeights;
        private BigDecimal totalScore;            // 合计分值（按 100 制）
        private BigDecimal expectedValue;         // 期望值
        private String assessmentContent;         // 考核内容描述
    }

    @Data
    public static class MainScoreData {
        private BigDecimal maxScore;
        private BigDecimal minScore;
        private BigDecimal avgScore;
        private List<GradeStatReportVO.ScoreRangeBucket> distribution;
    }

    @Data
    public static class ObjectiveAttainmentRow {
        private String objectiveCode;
        private String assessmentLink;           // 考核环节合并描述
        private BigDecimal weight;
        private Integer maxScore;
        private BigDecimal avgScore;
        private BigDecimal expectedValue;        // 期望值
        private Integer reachedCount;
        private Integer totalCount;
        private BigDecimal attainmentValue;      // 达成值
    }
}
