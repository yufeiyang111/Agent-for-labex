package com.labex.controller.teacher;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.labex.entity.ExperimentItem;
import com.labex.entity.Student;
import com.labex.entity.StudentItem;
import com.labex.service.ExperimentItemService;
import com.labex.service.ExperimentService;
import com.labex.service.ScoreService;
import com.labex.service.StudentItemService;
import com.labex.service.StudentService;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;

import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

/**
 * ScoreController 单元测试
 */
@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
@DisplayName("成绩控制器单元测试")
class ScoreControllerTest {

    @Mock
    private StudentItemService studentItemService;

    @Mock
    private ExperimentItemService experimentItemService;

    @Mock
    private StudentService studentService;

    @Mock
    private ScoreService scoreService;

    @Mock
    private ExperimentService experimentService;

    @InjectMocks
    private ScoreController scoreController;

    @Test
    @DisplayName("UT-Score-01: 导出成绩不应返回占位符字符串")
    void exportScores_ValidExperimentId_ShouldNotReturnPlaceholder() {
        // Arrange
        Integer experimentId = 1;

        // 模拟实验题目数据
        ExperimentItem item = new ExperimentItem();
        item.setExperimentItemId(1);
        item.setExperimentId(1);
        item.setExperimentItemName("题目1");
        item.setExperimentItemScore(10);
        when(experimentItemService.list(any(LambdaQueryWrapper.class))).thenReturn(Arrays.asList(item));

        // 模拟学生答题数据
        StudentItem studentItem = new StudentItem();
        studentItem.setStudentItemId(1);
        studentItem.setStudentId(1);
        studentItem.setItemId(1);
        studentItem.setContent("答案1");
        studentItem.setScore(8);
        when(studentItemService.list(any(LambdaQueryWrapper.class))).thenReturn(Arrays.asList(studentItem));

        // 模拟学生数据
        Student student = new Student();
        student.setStudentId(1);
        student.setStudentNo("2021001");
        student.setStudentName("张三");
        when(studentService.listByIds(any())).thenReturn(Arrays.asList(student));

        // Act
        com.labex.common.Result<String> result = scoreController.exportScores(experimentId);

        // Assert
        assertNotNull(result, "导出结果不应为 null");
        assertEquals(0, result.getCode(), "导出应返回成功状态码");
        assertNotNull(result.getData(), "导出数据不应为 null");
        assertNotEquals("导出功能待实现", result.getData(), "不应返回占位符字符串");

        // 验证服务被调用
        verify(experimentItemService, atLeastOnce()).list(any(LambdaQueryWrapper.class));
    }
}
