package com.labex.transaction;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.springframework.transaction.annotation.Transactional;

import java.lang.reflect.Method;

import static org.junit.jupiter.api.Assertions.*;

/**
 * 事务注解检查测试
 * 验证所有多表写入操作都有 @Transactional 注解
 */
@DisplayName("事务注解检查测试")
class TransactionAnnotationTest {

    @ParameterizedTest
    @DisplayName("UT-TX-01: 验证 Controller 方法有 @Transactional 注解")
    @CsvSource({
            "com.labex.controller.student.StudentExamController, submitExam",
            "com.labex.controller.student.StudentHomeworkController, submitHomework",
            "com.labex.controller.teacher.TeacherGradingController, submitAllGrades",
            "com.labex.controller.teacher.TeacherGradingController, gradeQuestion",
            "com.labex.controller.student.StudentTrainingController, submit",
            "com.labex.controller.teacher.TrainingSetController, delete",
            "com.labex.controller.teacher.PaperController, add"
    })
    void controllerMethod_ShouldHaveTransactionalAnnotation(String className, String methodName) throws Exception {
        // Arrange
        Class<?> clazz = Class.forName(className);
        Method method = findMethod(clazz, methodName);

        // Act
        boolean hasTransactional = method.isAnnotationPresent(Transactional.class);

        // Assert
        assertTrue(hasTransactional,
                String.format("%s.%s() 缺少 @Transactional 注解，多表操作可能导致数据不一致",
                        className.substring(className.lastIndexOf('.') + 1), methodName));
    }

    private Method findMethod(Class<?> clazz, String methodName) {
        for (Method method : clazz.getDeclaredMethods()) {
            if (method.getName().equals(methodName)) {
                return method;
            }
        }
        throw new RuntimeException(String.format("方法 %s.%s() 未找到", clazz.getSimpleName(), methodName));
    }
}
