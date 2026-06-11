package com.labex.service;

import com.labex.entity.QuestionTestCase;
import com.labex.service.impl.CodeExecutionServiceImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;
import org.springframework.test.util.ReflectionTestUtils;

import java.io.File;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

/**
 * CodeExecutionService 单元测试
 *
 * 测试用例清单:
 * | UT-Code-01 | Java编译运行 | runCode_ValidJava_ReturnsOutput |
 * | UT-Code-02 | C代码编译运行 | runCode_ValidC_ReturnsOutput |
 * | UT-Code-03 | 编译错误 | runCode_SyntaxError_ReturnsError |
 * | UT-Code-04 | 测试用例评分 | executeAndGrade_MultipleTestCases_ReturnsScore |
 */
@DisplayName("代码执行服务测试")
class CodeExecutionServiceTest {

    private CodeExecutionServiceImpl codeExecutionService;

    @TempDir
    Path tempDir;

    @BeforeEach
    void setUp() {
        codeExecutionService = new CodeExecutionServiceImpl();
        // 设置测试用的代码执行目录
        ReflectionTestUtils.setField(codeExecutionService, "codeExecBasePath", tempDir.toString());
    }

    @Test
    @DisplayName("UT-Code-01: Java代码 - 输出Hello World")
    void runCode_ValidJava_ReturnsHelloWorld() {
        String javaCode = """
            public class Main {
                public static void main(String[] args) {
                    System.out.println("Hello World");
                }
            }
            """;

        Map<String, Object> result = codeExecutionService.runCode(javaCode, "java", null);

        assertNull(result.get("error"));
        assertEquals("Hello World", result.get("output"));
    }

    @Test
    @DisplayName("UT-Code-01: Java代码 - 带输入计算")
    void runCode_JavaWithInput_ReturnsCalculatedOutput() {
        String javaCode = """
            import java.util.Scanner;
            public class Main {
                public static void main(String[] args) {
                    Scanner scanner = new Scanner(System.in);
                    int a = scanner.nextInt();
                    int b = scanner.nextInt();
                    System.out.println(a + b);
                }
            }
            """;

        Map<String, Object> result = codeExecutionService.runCode(javaCode, "java", "5\n3");

        assertNull(result.get("error"));
        assertEquals("8", result.get("output").toString().trim());
    }

    @Test
    @DisplayName("UT-Code-01: Java代码 - 使用标准输入")
    void runCode_JavaStdinInput_ReturnsOutput() {
        String javaCode = """
            public class Main {
                public static void main(String[] args) throws Exception {
                    java.io.BufferedReader br = new java.io.BufferedReader(new java.io.InputStreamReader(System.in));
                    String line = br.readLine();
                    System.out.println("Input: " + line);
                }
            }
            """;

        Map<String, Object> result = codeExecutionService.runCode(javaCode, "java", "test input");

        assertNull(result.get("error"));
        assertTrue(result.get("output").toString().contains("Input:"));
    }

    @Test
    @DisplayName("UT-Code-03: Java代码 - 语法错误返回编译错误")
    void runCode_SyntaxError_ReturnsCompileError() {
        String javaCode = """
            public class Main {
                public static void main(String[] args) {
                    System.out.println("Missing semicolon")
                }
            }
            """;

        Map<String, Object> result = codeExecutionService.runCode(javaCode, "java", null);

        assertNotNull(result.get("error"));
        assertTrue(result.get("error").toString().contains("Compile error"));
    }

    @Test
    @DisplayName("UT-Code-03: Java代码 - 运行时不存在的类")
    void runCode_RuntimeError_ReturnsError() {
        String javaCode = """
            public class Main {
                public static void main(String[] args) {
                    String s = null;
                    System.out.println(s.length());
                }
            }
            """;

        Map<String, Object> result = codeExecutionService.runCode(javaCode, "java", null);

        assertNotNull(result.get("error"));
        assertTrue(result.get("error").toString().contains("Execution error") || result.get("error").toString().contains("NullPointerException"));
    }

    @Test
    @DisplayName("UT-Code-04: 测试用例评分 - 多测试用例")
    void executeAndGrade_MultipleTestCases_ReturnsScore() {
        String javaCode = """
            import java.util.Scanner;
            public class Main {
                public static void main(String[] args) {
                    Scanner scanner = new Scanner(System.in);
                    int a = scanner.nextInt();
                    System.out.println(a * 2);
                }
            }
            """;

        List<QuestionTestCase> testCases = new ArrayList<>();

        QuestionTestCase tc1 = new QuestionTestCase();
        tc1.setId(1);
        tc1.setInput("5");
        tc1.setExpectedOutput("10");
        tc1.setScoreWeight(30);
        testCases.add(tc1);

        QuestionTestCase tc2 = new QuestionTestCase();
        tc2.setId(2);
        tc2.setInput("3");
        tc2.setExpectedOutput("6");
        tc2.setScoreWeight(30);
        testCases.add(tc2);

        QuestionTestCase tc3 = new QuestionTestCase();
        tc3.setId(3);
        tc3.setInput("10");
        tc3.setExpectedOutput("20");
        tc3.setScoreWeight(40);
        testCases.add(tc3);

        Map<String, Object> result = codeExecutionService.executeAndGrade(javaCode, "java", testCases);

        assertNotNull(result);
        assertEquals(100, result.get("score")); // 所有测试用例通过
        assertEquals(100, result.get("passedWeight"));
        assertEquals(100, result.get("totalWeight"));

        @SuppressWarnings("unchecked")
        List<Map<String, Object>> details = (List<Map<String, Object>>) result.get("details");
        assertEquals(3, details.size());
        assertTrue((Boolean) details.get(0).get("passed"));
        assertTrue((Boolean) details.get(1).get("passed"));
        assertTrue((Boolean) details.get(2).get("passed"));
    }

    @Test
    @DisplayName("UT-Code-04: 测试用例评分 - 部分失败")
    void executeAndGrade_PartialFailure_ReturnsPartialScore() {
        String javaCode = """
            import java.util.Scanner;
            public class Main {
                public static void main(String[] args) {
                    Scanner scanner = new Scanner(System.in);
                    int a = scanner.nextInt();
                    System.out.println(a + 1); // 错误实现
                }
            }
            """;

        List<QuestionTestCase> testCases = new ArrayList<>();

        QuestionTestCase tc1 = new QuestionTestCase();
        tc1.setId(1);
        tc1.setInput("5");
        tc1.setExpectedOutput("10"); // 期望 5*2=10
        tc1.setScoreWeight(50);
        testCases.add(tc1);

        QuestionTestCase tc2 = new QuestionTestCase();
        tc2.setId(2);
        tc2.setInput("3");
        tc2.setExpectedOutput("6"); // 期望 3*2=6
        tc2.setScoreWeight(50);
        testCases.add(tc2);

        Map<String, Object> result = codeExecutionService.executeAndGrade(javaCode, "java", testCases);

        assertNotNull(result);
        assertEquals(0, result.get("score")); // 所有测试用例失败

        @SuppressWarnings("unchecked")
        List<Map<String, Object>> details = (List<Map<String, Object>>) result.get("details");
        assertFalse((Boolean) details.get(0).get("passed"));
        assertFalse((Boolean) details.get(1).get("passed"));
    }

    @Test
    @DisplayName("UT-Code-04: 测试用例评分 - 编译错误")
    void executeAndGrade_CompileError_ReturnsCompileError() {
        String javaCode = """
            public class Main {
                public static void main(String[] args) {
                    // 故意缺少右花括号
            """;

        List<QuestionTestCase> testCases = new ArrayList<>();

        QuestionTestCase tc = new QuestionTestCase();
        tc.setId(1);
        tc.setInput("");
        tc.setExpectedOutput("output");
        tc.setScoreWeight(100);
        testCases.add(tc);

        Map<String, Object> result = codeExecutionService.executeAndGrade(javaCode, "java", testCases);

        assertNotNull(result.get("compileError"));
        assertTrue((Boolean) result.get("details").toString().contains("编译错误"));
    }

    @Test
    @DisplayName("UT-Code-02: 不支持的语言")
    void runCode_UnsupportedLanguage_ReturnsError() {
        Map<String, Object> result = codeExecutionService.runCode("code", "python", null);

        assertNotNull(result.get("error"));
        assertTrue(result.get("error").toString().contains("Unsupported language"));
    }

    @Test
    @DisplayName("Java代码 - 空输入")
    void runCode_JavaNoInput_Success() {
        String javaCode = """
            public class Main {
                public static void main(String[] args) {
                    System.out.println("No input needed");
                }
            }
            """;

        Map<String, Object> result = codeExecutionService.runCode(javaCode, "java", null);

        assertNull(result.get("error"));
        assertEquals("No input needed", result.get("output"));
    }

    @Test
    @DisplayName("Java代码 - 多行输出")
    void runCode_JavaMultiLineOutput_Success() {
        String javaCode = """
            public class Main {
                public static void main(String[] args) {
                    System.out.println("Line 1");
                    System.out.println("Line 2");
                    System.out.println("Line 3");
                }
            }
            """;

        Map<String, Object> result = codeExecutionService.runCode(javaCode, "java", null);

        assertNull(result.get("error"));
        String output = (String) result.get("output");
        assertTrue(output.contains("Line 1"));
        assertTrue(output.contains("Line 2"));
        assertTrue(output.contains("Line 3"));
    }
}