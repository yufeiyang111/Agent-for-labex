package com.labex.rag.service;

import com.labex.entity.Question;
import com.labex.entity.QuestionType;
import com.labex.rag.llm.LLMChat;
import com.labex.mapper.QuestionMapper;
import com.labex.mapper.QuestionTypeMapper;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

/**
 * AI题目生成服务测试
 * 测试人员：于峰
 * 测试内容：AI智能出题、题目难度控制、题目类型选择
 */
@ExtendWith(MockitoExtension.class)
public class QuestionGenerationServiceTest {

    @InjectMocks
    private QuestionGenerationService questionGenerationService;

    @Mock
    private LLMChat llmChat;

    @Mock
    private QuestionMapper questionMapper;

    @Mock
    private QuestionTypeMapper questionTypeMapper;

    /**
     * 测试生成单选题
     */
    @Test
    public void testGenerateSingleChoiceQuestion() {
        String topic = "Java多态";
        int difficulty = 3;
        int count = 1;

        String llmResponse = "{\"title\":\"Java中什么是多态？\",\"options\":[\"A. 继承\",\"B. 封装\",\"C. 多态\",\"D. 抽象\"],\"answer\":\"C\",\"explanation\":\"多态是面向对象编程的重要特性\"}";

        when(llmChat.chat(anyString(), anyList())).thenReturn(llmResponse);
        when(questionMapper.insert(any(Question.class))).thenReturn(1);

        List<Question> questions = questionGenerationService.generateQuestions(topic, 2, difficulty, count);

        assertNotNull(questions);
        assertEquals(1, questions.size());
        assertEquals("Java中什么是多态？", questions.get(0).getTitle());
        verify(llmChat).chat(anyString(), anyList());
        verify(questionMapper).insert(any(Question.class));
    }

    /**
     * 测试生成多选题
     */
    @Test
    public void testGenerateMultipleChoiceQuestion() {
        String topic = "Java面向对象";
        int difficulty = 4;
        int count = 1;

        String llmResponse = "{\"title\":\"以下哪些是面向对象的特性？\",\"options\":[\"A. 继承\",\"B. 封装\",\"C. 多态\",\"D. 递归\"],\"answer\":\"A,B,C\",\"explanation\":\"继承、封装、多态是面向对象的三大特性\"}";

        when(llmChat.chat(anyString(), anyList())).thenReturn(llmResponse);
        when(questionMapper.insert(any(Question.class))).thenReturn(1);

        List<Question> questions = questionGenerationService.generateQuestions(topic, 3, difficulty, count);

        assertNotNull(questions);
        assertEquals(1, questions.size());
        verify(llmChat).chat(anyString(), anyList());
    }

    /**
     * 测试生成判断题
     */
    @Test
    public void testGenerateTrueFalseQuestion() {
        String topic = "Java继承";
        int difficulty = 2;
        int count = 1;

        String llmResponse = "{\"title\":\"Java中类可以继承多个类\",\"options\":[\"A. 正确\",\"B. 错误\"],\"answer\":\"B\",\"explanation\":\"Java中类只能继承一个类，但可以实现多个接口\"}";

        when(llmChat.chat(anyString(), anyList())).thenReturn(llmResponse);
        when(questionMapper.insert(any(Question.class))).thenReturn(1);

        List<Question> questions = questionGenerationService.generateQuestions(topic, 4, difficulty, count);

        assertNotNull(questions);
        assertEquals(1, questions.size());
        verify(llmChat).chat(anyString(), anyList());
    }

    /**
     * 测试生成填空题
     */
    @Test
    public void testGenerateFillBlankQuestion() {
        String topic = "Java封装";
        int difficulty = 2;
        int count = 1;

        String llmResponse = "{\"title\":\"Java中使用_____关键字来定义私有访问修饰符\",\"answer\":\"private\",\"explanation\":\"private关键字用于定义私有访问修饰符\"}";

        when(llmChat.chat(anyString(), anyList())).thenReturn(llmResponse);
        when(questionMapper.insert(any(Question.class))).thenReturn(1);

        List<Question> questions = questionGenerationService.generateQuestions(topic, 1, difficulty, count);

        assertNotNull(questions);
        assertEquals(1, questions.size());
        verify(llmChat).chat(anyString(), anyList());
    }

    /**
     * 测试生成简答题
     */
    @Test
    public void testGenerateShortAnswerQuestion() {
        String topic = "Java多态";
        int difficulty = 4;
        int count = 1;

        String llmResponse = "{\"title\":\"请解释Java中多态的概念和实现方式\",\"answer\":\"多态是指同一操作作用于不同的对象，可以有不同的解释，产生不同的执行结果。\",\"explanation\":\"多态通过继承和接口实现\"}";

        when(llmChat.chat(anyString(), anyList())).thenReturn(llmResponse);
        when(questionMapper.insert(any(Question.class))).thenReturn(1);

        List<Question> questions = questionGenerationService.generateQuestions(topic, 5, difficulty, count);

        assertNotNull(questions);
        assertEquals(1, questions.size());
        verify(llmChat).chat(anyString(), anyList());
    }

    /**
     * 测试生成编程题
     */
    @Test
    public void testGenerateProgrammingQuestion() {
        String topic = "Java数组";
        int difficulty = 3;
        int count = 1;

        String llmResponse = "{\"title\":\"编写一个Java程序，实现数组排序\",\"content\":\"请编写一个Java程序，使用冒泡排序算法对整数数组进行排序\",\"answer\":\"public class ArraySort { public static void main(String[] args) { int[] arr = {5, 3, 8, 1, 2}; for (int i = 0; i < arr.length - 1; i++) { for (int j = 0; j < arr.length - 1 - i; j++) { if (arr[j] > arr[j + 1]) { int temp = arr[j]; arr[j] = arr[j + 1]; arr[j + 1] = temp; } } } } }\",\"explanation\":\"使用冒泡排序算法\"}";

        when(llmChat.chat(anyString(), anyList())).thenReturn(llmResponse);
        when(questionMapper.insert(any(Question.class))).thenReturn(1);

        List<Question> questions = questionGenerationService.generateQuestions(topic, 6, difficulty, count);

        assertNotNull(questions);
        assertEquals(1, questions.size());
        verify(llmChat).chat(anyString(), anyList());
    }

    /**
     * 测试批量生成题目
     */
    @Test
    public void testGenerateMultipleQuestions() {
        String topic = "Java基础";
        int type = 2;
        int difficulty = 3;
        int count = 3;

        String llmResponse1 = "{\"title\":\"Java中什么是类？\",\"options\":[\"A. 对象的模板\",\"B. 变量\",\"C. 方法\",\"D. 接口\"],\"answer\":\"A\",\"explanation\":\"类是对象的模板\"}";
        String llmResponse2 = "{\"title\":\"Java中什么是对象？\",\"options\":[\"A. 类的实例\",\"B. 变量\",\"C. 方法\",\"D. 接口\"],\"answer\":\"A\",\"explanation\":\"对象是类的实例\"}";
        String llmResponse3 = "{\"title\":\"Java中什么是方法？\",\"options\":[\"A. 对象的行为\",\"B. 变量\",\"C. 类\",\"D. 接口\"],\"answer\":\"A\",\"explanation\":\"方法是对象的行为\"}";

        when(llmChat.chat(anyString(), anyList()))
                .thenReturn(llmResponse1)
                .thenReturn(llmResponse2)
                .thenReturn(llmResponse3);
        when(questionMapper.insert(any(Question.class))).thenReturn(1);

        List<Question> questions = questionGenerationService.generateQuestions(topic, type, difficulty, count);

        assertNotNull(questions);
        assertEquals(3, questions.size());
        verify(llmChat, times(3)).chat(anyString(), anyList());
        verify(questionMapper, times(3)).insert(any(Question.class));
    }

    /**
     * 测试题目难度控制
     */
    @Test
    public void testDifficultyControl() {
        String topic = "Java多态";
        int type = 2;
        int count = 1;

        // 测试不同难度级别
        for (int difficulty = 1; difficulty <= 5; difficulty++) {
            String llmResponse = "{\"title\":\"难度" + difficulty + "的题目\",\"options\":[\"A. 选项1\",\"B. 选项2\"],\"answer\":\"A\",\"explanation\":\"解释\"}";

            when(llmChat.chat(anyString(), anyList())).thenReturn(llmResponse);
            when(questionMapper.insert(any(Question.class))).thenReturn(1);

            List<Question> questions = questionGenerationService.generateQuestions(topic, type, difficulty, count);

            assertNotNull(questions);
            assertEquals(1, questions.size());
        }
    }

    /**
     * 测试题目类型选择
     */
    @Test
    public void testQuestionTypeSelection() {
        String topic = "Java多态";
        int difficulty = 3;
        int count = 1;

        // 测试不同题目类型
        int[] types = {1, 2, 3, 4, 5, 6, 7};
        String[] typeNames = {"填空", "单选", "多选", "判断", "简答", "编程", "综合"};

        for (int i = 0; i < types.length; i++) {
            String llmResponse = "{\"title\":\"" + typeNames[i] + "题\",\"answer\":\"答案\",\"explanation\":\"解释\"}";

            when(llmChat.chat(anyString(), anyList())).thenReturn(llmResponse);
            when(questionMapper.insert(any(Question.class))).thenReturn(1);

            List<Question> questions = questionGenerationService.generateQuestions(topic, types[i], difficulty, count);

            assertNotNull(questions);
            assertEquals(1, questions.size());
        }
    }

    /**
     * 测试题目质量评估
     */
    @Test
    public void testQuestionQualityAssessment() {
        Question question = new Question();
        question.setTitle("Java中什么是多态？");
        question.setContent("请解释Java中多态的概念");
        question.setType(5);
        question.setDifficulty(3);
        question.setScore(10);

        boolean isQuality = questionGenerationService.assessQuestionQuality(question);

        assertTrue(isQuality);
    }

    /**
     * 测试题目质量评估 - 低质量题目
     */
    @Test
    public void testQuestionQualityAssessmentLowQuality() {
        Question question = new Question();
        question.setTitle("");  // 空标题
        question.setContent(null);  // 空内容
        question.setType(5);
        question.setDifficulty(3);
        question.setScore(10);

        boolean isQuality = questionGenerationService.assessQuestionQuality(question);

        assertFalse(isQuality);
    }

    /**
     * 测试获取题目类型列表
     */
    @Test
    public void testGetQuestionTypeList() {
        QuestionType type1 = new QuestionType();
        type1.setId(1);
        type1.setName("填空题");

        QuestionType type2 = new QuestionType();
        type2.setId(2);
        type2.setName("单选题");

        when(questionTypeMapper.selectList(any())).thenReturn(Arrays.asList(type1, type2));

        List<QuestionType> types = questionGenerationService.getQuestionTypeList();

        assertNotNull(types);
        assertEquals(2, types.size());
        verify(questionTypeMapper).selectList(any());
    }

    /**
     * 测试LLM响应解析
     */
    @Test
    public void testParseLLMResponse() {
        String llmResponse = "{\"title\":\"Java中什么是多态？\",\"options\":[\"A. 继承\",\"B. 封装\",\"C. 多态\",\"D. 抽象\"],\"answer\":\"C\",\"explanation\":\"多态是面向对象编程的重要特性\"}";

        Question question = questionGenerationService.parseLLMResponse(llmResponse, 2, 3);

        assertNotNull(question);
        assertEquals("Java中什么是多态？", question.getTitle());
        assertEquals(2, question.getType());
        assertEquals(3, question.getDifficulty());
    }

    /**
     * 测试LLM响应解析 - 格式错误
     */
    @Test
    public void testParseLLMResponseInvalidFormat() {
        String llmResponse = "invalid json";

        assertThrows(Exception.class, () -> {
            questionGenerationService.parseLLMResponse(llmResponse, 2, 3);
        });
    }
}
