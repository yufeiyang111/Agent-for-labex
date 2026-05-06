package com.labex.vo;

import lombok.Data;

import java.util.List;

/**
 * 学生实验答题进度VO
 */
@Data
public class StudentExperimentProgressVO {

    /**
     * 实验ID
     */
    private Integer experimentId;

    /**
     * 实验名称
     */
    private String experimentName;

    /**
     * 总分
     */
    private Integer totalScore;

    /**
     * 已得分
     */
    private Integer earnedScore;

    /**
     * 完成题目数
     */
    private Integer completedItems;

    /**
     * 总题目数
     */
    private Integer totalItems;

    /**
     * 题目列表
     */
    private List<ExperimentItemProgressVO> items;
}
