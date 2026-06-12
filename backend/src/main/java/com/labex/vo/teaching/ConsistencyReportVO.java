package com.labex.vo.teaching;

import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

/**
 * 考核合理性审核表（CTL-S6 报告 2）
 * 对应《课程质量评价资料汇编.pdf》第 3 页
 */
@Data
public class ConsistencyReportVO {

    private String courseName;
    private String courseCategory;       // 课程类别
    private Integer teachingHours;       // 授课学时
    private BigDecimal courseCredit;
    private String semester;
    private String teachingTarget;       // 授课对象
    private Integer studentCount;
    private String courseResponsible;    // 课程负责人
    private List<ObjectiveRow> rows;

    @Data
    public static class ObjectiveRow {
        private String objectiveCode;        // "课程目标 1"
        private String objectiveDescription;
        private String assessmentContent;    // 考核内容
        private String assessmentMethod;     // 考核方式
        private BigDecimal assessmentScore;  // 考核分值
        private String rationalityComment;   // 合理性审核意见（默认"合理"）
    }
}
