package com.labex.langchain4j.agent;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.labex.rag.llm.MiniMaxChat;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;

/**
 * Uses MiniMax LLM to automatically generate diverse, high-quality questions
 * from lecture content. Follows the same pattern as {@link KnowledgeExtractionAgent}.
 */
@Slf4j
@Component
public class QuestionGenerationAgent {

    private final MiniMaxChat miniMaxChat;
    private final Gson gson = new Gson();

    public QuestionGenerationAgent(MiniMaxChat miniMaxChat) {
        this.miniMaxChat = miniMaxChat;
    }

    private static final String GENERATION_PROMPT =
            "你是一位经验丰富的学科教育专家和命题人。请严格根据以下讲义内容，设计一批高质量的练习题。\n\n" +
            "### 命题要求\n\n" +
            "1. **内容紧密围绕讲义**：每道题必须直接考察讲义中出现的知识点、概念、原理或应用场景，不得超出讲义范围。\n\n" +
            "2. **题型高度多样**：请混合以下题型进行命题：\n" +
            "   - 填空题（type=1）：考察关键概念、术语、公式填空\n" +
            "   - 单选题（type=2）：四个选项，考察概念辨析、原理理解\n" +
            "   - 多选题（type=3）：四个选项，可能有多个正确答案\n" +
            "   - 判断题（type=4）：考察易混淆概念的辨别\n" +
            "   - 简答题（type=5）：考察对原理、流程、机制的理解和表述\n" +
            "   - 编程题（type=6）：考察代码编写、算法实现（仅当讲义涉及编程相关内容时）\n\n" +
            "3. **严格禁止重复题**：以下情况视为重复，绝对禁止：\n" +
            "   - 仅修改数值参数但解题思路完全相同的题（例如：\"加速度2→4m/s要多久\"和\"加速度4→0→4m/s要多久\"）\n" +
            "   - 同一知识点换不同表述问同一问题\n" +
            "   - 选择题选项仅调换顺序\n" +
            "   每道题的考察角度、思维过程、知识点切入点必须有本质区别。\n\n" +
            "4. **难度梯度合理**：\n" +
            "   - easy（约30%）：直接考察概念记忆、基础理解\n" +
            "   - medium（约40%）：需要简单推理、综合运用\n" +
            "   - hard（约30%）：需要深入分析、复杂推理或综合应用\n\n" +
            "5. **每题必须包含**：题目内容、标准答案、详细解析（说明为什么对/错）、知识点标签\n\n" +
            "6. **各题型分值**：easy=5分, medium=10分, hard=15分\n\n" +
            "7. **选择题格式**：options字段为JSON对象，如 {\"A\":\"选项内容\", \"B\":\"选项内容\", \"C\":\"选项内容\", \"D\":\"选项内容\"}；answer字段填入正确选项字母（单选题一个字母，多选题多个字母如\"ABC\"，判断题\"true\"或\"false\"）。\n\n" +
            "8. **填空题格式**：多个空用|||分隔答案。\n\n" +
            "9. **编程题格式**：question中包含题目描述和要求，answer中包含参考代码。\n\n" +
            "请返回严格符合以下 JSON 数组格式的题目列表（不要包含任何其他文字）：\n" +
            "[{\"type\": 1, \"question\": \"题目内容\", \"answer\": \"标准答案\", \"analysis\": \"详细解析\", \"options\": \"\", \"knowledgePoint\": \"知识点名称\", \"difficulty\": \"easy|medium|hard\", \"score\": 5}]";

    public List<GeneratedQuestion> generate(String lectureContent, String lectureName) {
        try {
            log.info("Generating questions from lecture: {} (content length: {})", lectureName, lectureContent.length());
            String response = miniMaxChat.chat(GENERATION_PROMPT, "", lectureContent);

            String json = extractJsonArray(response);
            if (json == null) {
                log.warn("Failed to extract JSON from LLM response for lecture: {}", lectureName);
                log.debug("Raw response: {}", response);
                return new ArrayList<>();
            }

            Type listType = new TypeToken<List<GeneratedQuestion>>() {}.getType();
            List<GeneratedQuestion> questions = gson.fromJson(json, listType);
            log.info("Generated {} questions from lecture: {}", questions.size(), lectureName);
            return questions;
        } catch (Exception e) {
            log.error("Question generation failed for lecture {}: {}", lectureName, e.getMessage());
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
