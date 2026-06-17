package com.labex.vo.teaching;

import lombok.Data;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

/**
 * 学生×评分项得分矩阵（CTL-S4）
 */
@Data
public class ScoreMatrixVO {

    /** 评分项元信息 */
    private List<ItemHeader> items;

    /** 学生行（含每个评分项的分数） */
    private List<StudentRow> students;

    /** 分页信息 */
    private Integer total;
    private Integer page;
    private Integer pageSize;

    @Data
    public static class ItemHeader {
        private Integer itemId;
        private String name;
        private String type;
        private Integer maxScore;
        private Integer passingScore;
        private BigDecimal weight;
        private Integer sortOrder;
        /** 该评分项对应的目标 ID 列表（用于展示） */
        private List<Integer> objectiveIds;
    }

    @Data
    public static class StudentRow {
        private Integer studentId;
        private String studentNo;
        private String studentName;
        /** itemId -> score */
        private Map<Integer, BigDecimal> scores;
    }
}
