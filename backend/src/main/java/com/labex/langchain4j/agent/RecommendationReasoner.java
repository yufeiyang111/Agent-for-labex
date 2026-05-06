package com.labex.langchain4j.agent;

import com.labex.rag.llm.MiniMaxChat;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

/**
 * Generates human-readable (Taffy-style) explanations for exercise recommendations.
 */
@Slf4j
@Component
public class RecommendationReasoner {

    private final MiniMaxChat miniMaxChat;

    public RecommendationReasoner(MiniMaxChat miniMaxChat) {
        this.miniMaxChat = miniMaxChat;
    }

    public String explain(String kpName, String questionText, int questionType, double masteryScore, double errorRate) {
        String kpStatus = masteryScore >= 0.7 ? "掌握良好" : masteryScore < 0.4 ? "需要加强" : "一般";
        String typeName = switch (questionType) {
            case 1 -> "填空题";
            case 2 -> "单选题";
            case 3 -> "多选题";
            case 4 -> "判断题";
            case 5 -> "解答题";
            case 6 -> "编程题";
            default -> "习题";
        };

        String prompt = "你是一个叫塔菲的可爱知识助手，请用塔菲的口吻解释为什么推荐这道题。\n" +
                "知识点：%s，掌握度：%.0f%%（%s）\n" +
                "题目：%s\n题型：%s\n\n" +
                "要求：1-2句话，口语化，每句话最后加喵字，自称塔菲。";

        String formatted = String.format(prompt, kpName, masteryScore * 100, kpStatus, questionText, typeName);
        try {
            return miniMaxChat.chat(formatted, "", "");
        } catch (Exception e) {
            log.error("Recommendation explanation failed: {}", e.getMessage());
            return "塔菲觉得这道" + typeName + "可以帮你巩固「" + kpName + "」的知识喵~";
        }
    }
}
