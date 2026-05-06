package com.labex.vo;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 成绩统计VO
 */
@Data
public class ScoreStatisticsVO {

    /**
     * 学生ID
     */
    private Integer studentId;

    /**
     * 学号
     */
    private String studentNo;

    /**
     * 学生姓名
     */
    private String studentName;

    /**
     * 班级编号
     */
    private String clazzNo;

    /**
     * 实验ID
     */
    private Integer experimentId;

    /**
     * 总分
     */
    private Integer score;

    /**
     * 提交时间
     */
    private LocalDateTime fillTime;
}
