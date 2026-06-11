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
            "你是一位经验丰富的学科教育专家和命题人，拥有多年的教学和出题经验。请严格根据以下讲义内容，设计一批高质量、有区分度的练习题。\n\n" +
            "### 核心原则\n\n" +
            "1. **内容精准**：每道题必须直接考察讲义中出现的知识点、概念、原理或应用场景，不得超出讲义范围。\n\n" +
            "2. **题型多样**：请混合以下题型进行命题：\n" +
            "   - 填空题（type=1）：考察关键概念、术语、公式、原理的精确记忆\n" +
            "   - 单选题（type=2）：四个选项，考察概念辨析、原理理解、应用场景判断\n" +
            "   - 多选题（type=3）：四个选项，可能有2-4个正确答案，考察综合理解\n" +
            "   - 判断题（type=4）：考察易混淆概念、常见误区的辨别\n" +
            "   - 简答题（type=5）：考察对原理、流程、机制的深入理解和表述能力\n" +
            "   - 编程题（type=6）：考察代码编写、算法实现能力（仅当讲义涉及编程相关内容时）\n\n" +
            "3. **严格避免重复**：以下情况视为重复，绝对禁止：\n" +
            "   - 仅修改数值参数但解题思路完全相同的题\n" +
            "   - 同一知识点换不同表述问同一问题\n" +
            "   - 选择题选项仅调换顺序\n" +
            "   - 考察角度、思维过程、知识点切入点必须有本质区别\n\n" +
            "4. **难度梯度**：\n" +
            "   - easy（约30%）：直接考察概念记忆、基础理解\n" +
            "   - medium（约40%）：需要简单推理、综合运用\n" +
            "   - hard（约30%）：需要深入分析、复杂推理或综合应用\n\n" +
            "5. **质量标准**：\n" +
            "   - 题目表述清晰、无歧义\n" +
            "   - 答案准确、唯一（客观题）或要点完整（主观题）\n" +
            "   - 解析详细，说明解题思路和易错点\n" +
            "   - 知识点标签准确，便于后续检索和分类\n\n" +
            "### 输出格式要求\n\n" +
            "1. **分值设置**：easy=5分, medium=10分, hard=15分\n\n" +
            "2. **选择题格式**：\n" +
            "   - options字段为JSON对象：{\"A\":\"选项内容\", \"B\":\"选项内容\", \"C\":\"选项内容\", \"D\":\"选项内容\"}\n" +
            "   - 单选题answer填一个字母（如\"A\"）\n" +
            "   - 多选题answer填所有正确选项字母（如\"ABC\"）\n" +
            "   - 判断题answer填\"true\"或\"false\"\n\n" +
            "3. **填空题格式**：\n" +
            "   - 题目中用 _____ 表示空白处\n" +
            "   - 多个空的答案用 ||| 分隔\n\n" +
            "4. **编程题格式**：\n" +
            "   - question中包含题目描述、输入输出要求、示例\n" +
            "   - answer中包含带注释的参考代码\n\n" +
            "请返回严格符合以下 JSON 数组格式的题目列表（不要包含任何其他文字、不要添加 markdown 代码块标记）：\n" +
            "[{\"type\": 1, \"question\": \"题目内容\", \"answer\": \"标准答案\", \"analysis\": \"详细解析（说明解题思路和关键点）\", \"options\": \"\", \"knowledgePoint\": \"知识点名称\", \"difficulty\": \"easy|medium|hard\", \"score\": 5}]";

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

    /**
     * 生成指定类型的题目
     */
    public List<GeneratedQuestion> generate(String content, String sourceName, Integer questionType, String difficulty) {
        String typePrompt = buildTypeSpecificPrompt(questionType, difficulty);
        try {
            log.info("Generating {} questions from: {} (content length: {})",
                    getTypeName(questionType), sourceName, content.length());
            String response = miniMaxChat.chat(typePrompt, "", content);

            String json = extractJsonArray(response);
            if (json == null) {
                log.warn("Failed to extract JSON from LLM response for source: {}", sourceName);
                return new ArrayList<>();
            }

            Type listType = new TypeToken<List<GeneratedQuestion>>() {}.getType();
            List<GeneratedQuestion> questions = gson.fromJson(json, listType);
            log.info("Generated {} {} questions from: {}", questions.size(), getTypeName(questionType), sourceName);
            return questions;
        } catch (Exception e) {
            log.error("Question generation failed for source {}: {}", sourceName, e.getMessage());
            return new ArrayList<>();
        }
    }

    /**
     * 生成指定类型的题目（带自定义提示词）
     */
    public List<GeneratedQuestion> generate(String content, String sourceName, Integer questionType,
                                             String difficulty, String customPrompt) {
        String typePrompt = buildTypeSpecificPrompt(questionType, difficulty);
        String fullPrompt = typePrompt + "\n\n" + customPrompt;

        try {
            log.info("Generating {} questions with custom prompt from: {}",
                    getTypeName(questionType), sourceName);
            String response = miniMaxChat.chat(fullPrompt, "", content);

            String json = extractJsonArray(response);
            if (json == null) {
                log.warn("Failed to extract JSON from LLM response for source: {}", sourceName);
                return new ArrayList<>();
            }

            Type listType = new TypeToken<List<GeneratedQuestion>>() {}.getType();
            List<GeneratedQuestion> questions = gson.fromJson(json, listType);
            log.info("Generated {} {} questions with custom prompt from: {}",
                    questions.size(), getTypeName(questionType), sourceName);
            return questions;
        } catch (Exception e) {
            log.error("Question generation failed for source {}: {}", sourceName, e.getMessage());
            return new ArrayList<>();
        }
    }

    /**
     * 构建题型特定的提示词
     */
    private String buildTypeSpecificPrompt(Integer questionType, String difficulty) {
        StringBuilder prompt = new StringBuilder();
        prompt.append("你是一位经验丰富的学科教育专家和命题人。请严格根据以下内容，生成高质量的");
        prompt.append(getTypeName(questionType));
        prompt.append("。\n\n");

        prompt.append("### 核心原则\n\n");
        prompt.append("1. **内容精准**：每道题必须直接考察材料中出现的知识点、概念、原理或应用场景。\n\n");
        prompt.append("2. **避免重复**：每道题的考察角度、思维过程必须有本质区别。\n\n");
        prompt.append("3. **质量标准**：题目表述清晰无歧义，答案准确，解析详细。\n\n");

        // 根据题型添加特定要求
        prompt.append("### 题型格式要求\n\n");
        switch (questionType) {
            case 1: // 填空题
                prompt.append("**填空题**：\n");
                prompt.append("- 题目中用 _____ 表示空白处\n");
                prompt.append("- 多个空的答案用 ||| 分隔\n");
                prompt.append("- 考察关键概念、术语、公式、原理的精确记忆\n");
                prompt.append("- 解析需说明每个空的答案来源和依据\n\n");
                break;
            case 2: // 单选题
                prompt.append("**单选题**：\n");
                prompt.append("- 四个选项（A、B、C、D），只有一个正确答案\n");
                prompt.append("- options字段为JSON对象：{\"A\":\"选项内容\", \"B\":\"选项内容\", \"C\":\"选项内容\", \"D\":\"选项内容\"}\n");
                prompt.append("- answer字段填入正确选项字母（如\"A\"）\n");
                prompt.append("- 干扰项应具有迷惑性，解析需说明为什么选A、为什么不选BCD\n\n");
                break;
            case 3: // 多选题
                prompt.append("**多选题**：\n");
                prompt.append("- 四个选项（A、B、C、D），有2-4个正确答案\n");
                prompt.append("- options字段为JSON对象\n");
                prompt.append("- answer字段填入所有正确选项字母（如\"ABC\"）\n");
                prompt.append("- 解析需逐一说明每个选项的对错原因\n\n");
                break;
            case 4: // 判断题
                prompt.append("**判断题**：\n");
                prompt.append("- answer字段为\"true\"或\"false\"\n");
                prompt.append("- 考察易混淆概念、常见误区\n");
                prompt.append("- 解析需说明判断依据和易错点\n\n");
                break;
            case 5: // 简答题
                prompt.append("**简答题**：\n");
                prompt.append("- question中包含明确的问题\n");
                prompt.append("- answer中包含详细的参考答案（分点作答）\n");
                prompt.append("- 考察对原理、流程、机制的深入理解\n");
                prompt.append("- 解析需列出答题要点和评分标准\n\n");
                break;
            case 6: // 编程题
                prompt.append("**编程题**：\n");
                prompt.append("- question中包含题目描述、输入输出要求、示例\n");
                prompt.append("- answer中包含带注释的参考代码\n");
                prompt.append("- 解析需说明算法思路、时间复杂度、关键代码段解释\n\n");
                break;
        }

        // 难度要求
        prompt.append("### 难度要求\n\n");
        switch (difficulty != null ? difficulty : "mixed") {
            case "easy":
                prompt.append("简单难度：直接考察概念记忆、基础理解\n\n");
                break;
            case "medium":
                prompt.append("中等难度：需要简单推理、综合运用\n\n");
                break;
            case "hard":
                prompt.append("困难难度：需要深入分析、复杂推理或综合应用\n\n");
                break;
            default:
                prompt.append("混合难度：easy约30%, medium约40%, hard约30%\n\n");
        }

        prompt.append("### 输出格式\n\n");
        prompt.append("分值设置：easy=5分, medium=10分, hard=15分\n\n");
        prompt.append("请返回严格符合以下 JSON 数组格式的题目列表（不要包含任何其他文字、不要添加 markdown 代码块标记）：\n");
        prompt.append("[{\"type\": ").append(questionType).append(", \"question\": \"题目内容\", \"answer\": \"标准答案\", \"analysis\": \"详细解析（说明解题思路和关键点）\", \"options\": \"\", \"knowledgePoint\": \"知识点名称\", \"difficulty\": \"easy|medium|hard\", \"score\": 5}]");

        return prompt.toString();
    }

    /**
     * 获取题型名称
     */
    private String getTypeName(Integer type) {
        switch (type) {
            case 1: return "填空题";
            case 2: return "单选题";
            case 3: return "多选题";
            case 4: return "判断题";
            case 5: return "简答题";
            case 6: return "编程题";
            default: return "题目";
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
