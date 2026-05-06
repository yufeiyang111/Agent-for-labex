package com.labex.service;

import java.util.List;
import java.util.Map;
import com.labex.entity.QuestionTestCase;

public interface CodeExecutionService {
    /**
     * 执行代码并评分
     * @param code 源代码
     * @param language 语言 (java/c)
     * @param testCases 测试用例列表
     * @return 包含score和详细结果
     */
    Map<String, Object> executeAndGrade(String code, String language, List<QuestionTestCase> testCases);

    /**
     * 运行代码（仅执行，不评分）
     * @param code 源代码
     * @param language 语言
     * @param input 自定义输入
     * @return 执行结果
     */
    Map<String, Object> runCode(String code, String language, String input);
}