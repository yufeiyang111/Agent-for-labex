package com.labex.dto.ai;

import lombok.Data;
import java.time.LocalDateTime;

/**
 * 生成的题目DTO（用于Redis暂存和前端展示）
 */
@Data
public class GeneratedQuestionDTO {
    /**
     * 临时ID（Redis中的标识）
     */
    private String tempId;

    /**
     * 题目类型：1=填空, 2=单选, 3=多选, 4=判断, 5=简答, 6=编程
     */
    private Integer type;

    /**
     * 题目类型名称
     */
    private String typeName;

    /**
     * 题目内容
     */
    private String question;

    /**
     * 标准答案
     */
    private String answer;

    /**
     * 解析
     */
    private String analysis;

    /**
     * 选项（JSON格式）
     */
    private String options;

    /**
     * 知识点标签
     */
    private String knowledgePoint;

    /**
     * 难度：easy, medium, hard
     */
    private String difficulty;

    /**
     * 分值
     */
    private Integer score;

    /**
     * 来源讲义ID
     */
    private Integer lectureId;

    /**
     * 来源讲义名称
     */
    private String lectureName;

    /**
     * 与现有题库的相似度（0-1）
     */
    private Double similarityScore;

    /**
     * 相似的题目ID（如果有）
     */
    private Integer similarQuestionId;

    /**
     * 相似的题目内容（如果有）
     */
    private String similarQuestionText;

    /**
     * 生成时间
     */
    private LocalDateTime generatedAt;

    /**
     * 状态：pending（待审核）, approved（已批准）, rejected（已拒绝）, modified（已修改）
     */
    private String status = "pending";

    /**
     * 教师修改后的内容（如果有）
     */
    private String modifiedQuestion;

    /**
     * 教师修改后的答案（如果有）
     */
    private String modifiedAnswer;

    /**
     * 教师修改后的解析（如果有）
     */
    private String modifiedAnalysis;

    /**
     * 生成批次ID
     */
    private String batchId;

    /**
     * 来源知识库文档片段
     */
    private String sourceContext;

    /**
     * 考察角度描述（用于避免重复）
     */
    private String examAngle;

    /**
     * 是否已持久化到数据库
     */
    private Boolean persisted = false;

    /**
     * 持久化后的题目ID
     */
    private Integer questionId;
}
