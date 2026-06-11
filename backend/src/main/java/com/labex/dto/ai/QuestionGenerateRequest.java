package com.labex.dto.ai;

import lombok.Data;
import java.util.List;

/**
 * 题目自动生成请求
 */
@Data
public class QuestionGenerateRequest {
    /**
     * 题目类型：1=填空, 2=单选, 3=多选, 4=判断, 5=简答, 6=编程
     * 支持多选，生成多种类型
     */
    private List<Integer> questionTypes;

    /**
     * 知识点关键词，用于从知识库检索相关内容
     */
    private String knowledgeKeywords;

    /**
     * 讲义ID列表（可选，指定从哪些讲义生成）
     */
    private List<Integer> lectureIds;

    /**
     * 每种题型生成的数量
     */
    private Integer countPerType = 5;

    /**
     * 难度要求：easy, medium, hard, mixed
     */
    private String difficulty = "mixed";

    /**
     * 生成批次ID（用于追踪）
     */
    private String batchId;

    /**
     * 教师ID
     */
    private Integer teacherId;
}
