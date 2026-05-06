package com.labex.langchain4j.agent;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.labex.kg.dto.ExtractionResult;
import com.labex.rag.llm.MiniMaxChat;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Uses LLM to extract knowledge points from lecture content.
 * Returns structured JSON that is parsed into {@link com.labex.kg.dto.ExtractionResult.ExtractedKnowledgePoint}.
 */
@Slf4j
@Component
public class KnowledgeExtractionAgent {

    private final MiniMaxChat miniMaxChat;
    private final Gson gson = new Gson();

    public KnowledgeExtractionAgent(MiniMaxChat miniMaxChat) {
        this.miniMaxChat = miniMaxChat;
    }

    private static final String EXTRACTION_PROMPT =
            "你是一个教育知识图谱构建专家。请从以下讲义内容中提取关键知识点。\n\n" +
            "要求：\n" +
            "1. 每个知识点包含：name（名称）、description（简要描述）、prerequisites（前置知识点名称列表）\n" +
            "2. 知识点应该在合适的粒度上：不要太宽泛，也不要太细碎\n" +
            "3. 如果一个知识点需要先掌握其他概念才能理解，请在 prerequisites 中列出\n\n" +
            "请以 JSON 数组格式返回，不要包含任何其他文字：\n" +
            "[{\"name\": \"知识点名称\", \"description\": \"描述\", \"prerequisites\": [\"前置知识点1\", \"前置知识点2\"]}]";

    public List<ExtractionResult.ExtractedKnowledgePoint> extract(String lectureContent, String lectureName) {
        try {
            String response = miniMaxChat.chat(EXTRACTION_PROMPT, "", lectureContent);

            // Extract JSON array from response (may have markdown code fences)
            String json = extractJsonArray(response);
            if (json == null) {
                log.warn("Failed to extract JSON from LLM response for lecture: {}", lectureName);
                return new ArrayList<>();
            }

            Type listType = new TypeToken<List<ExtractionResult.ExtractedKnowledgePoint>>() {}.getType();
            List<ExtractionResult.ExtractedKnowledgePoint> kps = gson.fromJson(json, listType);
            log.info("Extracted {} knowledge points from lecture: {}", kps.size(), lectureName);
            return kps;
        } catch (Exception e) {
            log.error("Knowledge extraction failed for lecture {}: {}", lectureName, e.getMessage());
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
