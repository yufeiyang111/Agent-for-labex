package com.labex.vo.teaching;

import lombok.Data;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

/**
 * 成绩明细表完整结构 — 用于 JSON 预览（前端 el-table 多级表头展示）
 * 复现 Class-docs/课程分组及成绩明细表.xlsx Sheet「成绩明细表」结构
 */
@Data
public class GradeDetailMatrixVO {

    /** 标题（如：南昌航空大学学生课程目标达成度计算表） */
    private String title;

    /** 副标题（如：开课学期 课程 教师 班级） */
    private String subtitle;

    private String semester;
    private String courseName;
    private String teacherName;
    private String clazzNo;

    /** 课程目标分组（每个目标含若干评分项列） */
    private List<ObjectiveGroup> objectiveGroups;

    /** 学生数据行 */
    private List<StudentRow> students;

    /** 统计行（平均分、达成人数、目标达成度） */
    private List<StatRow> stats;

    /** 综合列（平时成绩 50% / 期末成绩 50% / 总成绩） */
    private List<String> aggregateColumns;

    @Data
    public static class ObjectiveGroup {
        private Integer objectiveId;
        private String objectiveCode;
        private String objectiveDescription;
        /** 这个目标下的评分项列（顺序对应学生数据列） */
        private List<ColumnHeader> columns;
        /** 该目标的"达成度"列 */
        private ColumnHeader achievementColumn;
    }

    @Data
    public static class ColumnHeader {
        private Integer itemId;
        private String name;
        private String type;
        private Integer maxScore;
        private Integer passingScore;
        private BigDecimal weight;
        /** 加权分值 = passingScore × weight (Excel 行 154) */
        private BigDecimal weightedValue;
    }

    @Data
    public static class StudentRow {
        private Integer rowIndex;
        private Integer studentId;
        private String studentNo;
        private String studentName;
        /** itemId -> score */
        private Map<Integer, BigDecimal> scores;
        /** objectiveId -> achievement (0~1.4x) */
        private Map<Integer, BigDecimal> objectiveAchievements;
        private BigDecimal totalAchievement;
        private BigDecimal totalWeightedScore;
    }

    @Data
    public static class StatRow {
        /** "平均分" / "达成期望分值的学生人数" / "课程目标达成度" */
        private String label;
        /** itemId -> value */
        private Map<Integer, BigDecimal> itemValues;
        /** objectiveId -> value */
        private Map<Integer, BigDecimal> objectiveValues;
    }
}
