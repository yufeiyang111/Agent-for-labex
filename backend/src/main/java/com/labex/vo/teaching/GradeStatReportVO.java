package com.labex.vo.teaching;

import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

/**
 * 成绩统计表（CTL-S6 报告 1）
 * 对应《课程质量评价资料汇编.pdf》第 2 页
 */
@Data
public class GradeStatReportVO {

    private String department;       // 教研室
    private String courseName;       // 课程名称
    private String clazzNo;          // 授课班级
    private String teacherName;      // 任课教师
    private String questioner;       // 命题教师
    private Integer expectedValue;   // 期望值
    private BigDecimal avgScore;
    private BigDecimal maxScore;
    private BigDecimal minScore;
    private BigDecimal passingRate;  // 及格率 (%)
    private List<ScoreRangeBucket> distribution;
    private Boolean reachedExpected; // 是否达到期望值
    private Boolean normalDistribution; // 是否正态分布（简化判定）

    @Data
    public static class ScoreRangeBucket {
        private String range;        // "100-90"
        private Integer count;
        private BigDecimal percent;
    }
}
