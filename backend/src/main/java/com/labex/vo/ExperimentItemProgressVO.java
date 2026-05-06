package com.labex.vo;

import lombok.Data;

/**
 * 题目进度VO
 */
@Data
public class ExperimentItemProgressVO {

    /**
     * 题目ID
     */
    private Integer experimentItemId;

    /**
     * 题号
     */
    private Integer experimentItemNo;

    /**
     * 题目名称
     */
    private String experimentItemName;

    /**
     * 题型
     */
    private Integer experimentItemType;

    /**
     * 分值
     */
    private Integer experimentItemScore;

    /**
     * 是否已答题
     */
    private Boolean answered;

    /**
     * 得分
     */
    private Integer score;
}
