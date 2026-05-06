package com.labex.langchain4j.agent;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.labex.rag.llm.MiniMaxChat;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Uses LLM to classify questions into knowledge points.
 * Takes question content + the existing KP catalog, returns matched KP names with weights.
 */
@Slf4j
@Component
public class QuestionClassifierAgent {

    private final MiniMaxChat miniMaxChat;
    private final Gson gson = new Gson();

    public QuestionClassifierAgent(MiniMaxChat miniMaxChat) {
        this.miniMaxChat = miniMaxChat;
    }

    /**
     * Classify a batch of questions into knowledge points.
     *
     * @param questions       List of question maps (id, text, type)
     * @param kpCatalog       Existing knowledge point catalog as "id|name|description"
     * @return List of classification results [{questionId, kpName, weight, isPrimary}]
     */
    public List<Map<String, Object>> classify(List<Map<String, Object>> questions, List<String> kpCatalog) {
        String catalog = String.join("\n", kpCatalog);
        String questionList = questions.stream()
                .map(q -> String.format("Q%d: %s [type=%s]", q.get("id"), q.get("text"), q.get("type")))
                .collect(Collectors.joining("\n"));

        String prompt = "你是一个教育知识图谱专家。请将以下题目归类到已有的知识点中。\n\n" +
                "已有知识点目录：\n" + catalog + "\n\n" +
                "题目列表：\n" + questionList + "\n\n" +
                "要求：\n" +
                "1. 每个题目可以关联1-3个知识点\n" +
                "2. 每个关联需要指定 weight（0-1，表示题目对该知识点的考察比重）和 isPrimary（是否为最主要考察的知识点）\n" +
                "3. 如果题目不适合任何已有知识点，可以创建新的知识点名称\n\n" +
                "请以 JSON 数组格式返回：\n" +
                "[{\"questionId\": 1, \"kpName\": \"知识点名\", \"weight\": 0.8, \"isPrimary\": true}]";

        try {
            String response = miniMaxChat.chat(prompt, "", "");
            String json = extractJsonArray(response);
            if (json == null) {
                log.warn("Failed to extract JSON from question classification response");
                return new ArrayList<>();
            }
            Type listType = new TypeToken<List<Map<String, Object>>>() {}.getType();
            return gson.fromJson(json, listType);
        } catch (Exception e) {
            log.error("Question classification failed: {}", e.getMessage());
            return new ArrayList<>();
        }
    }

    private String extractJsonArray(String text) {
        int start = text.indexOf('[');
        int end = text.lastIndexOf(']');
        if (start >= 0 && end > start) {
            return text.substring(start, end + 1);
        }
        return null;
    }
}
