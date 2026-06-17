package com.labex.service.impl;

import com.labex.entity.ExamGrading;
import com.labex.entity.StudentAnswer;
import com.labex.entity.Homework;
import com.labex.entity.Exam;
import com.labex.mapper.ExamGradingMapper;
import com.labex.mapper.StudentAnswerMapper;
import com.labex.mapper.HomeworkMapper;
import com.labex.mapper.ExamMapper;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

/**
 * 批改服务测试
 * 测试人员：杨宇润
 * 测试内容：作业批改、考试批改、批改状态管理
 */
@ExtendWith(MockitoExtension.class)
public class GradingServiceTest {

    @InjectMocks
    private GradingService gradingService;

    @Mock
    private ExamGradingMapper examGradingMapper;

    @Mock
    private StudentAnswerMapper studentAnswerMapper;

    @Mock
    private HomeworkMapper homeworkMapper;

    @Mock
    private ExamMapper examMapper;

    // ==================== 作业批改测试 ====================

    /**
     * 测试获取待批改作业列表
     */
    @Test
    public void testGetPendingHomeworkList() {
        Long teacherId = 1L;

        Homework homework1 = new Homework();
        homework1.setId(1L);
        homework1.setTitle("Java基础作业");
        homework1.setStatus("待批改");

        Homework homework2 = new Homework();
        homework2.setId(2L);
        homework2.setTitle("Java面向对象作业");
        homework2.setStatus("待批改");

        when(homeworkMapper.selectList(any())).thenReturn(Arrays.asList(homework1, homework2));

        List<Homework> result = gradingService.getPendingHomeworkList(teacherId);

        assertNotNull(result);
        assertEquals(2, result.size());
        assertEquals("待批改", result.get(0).getStatus());
        verify(homeworkMapper).selectList(any());
    }

    /**
     * 测试获取学生作业答案
     */
    @Test
    public void testGetStudentHomeworkAnswers() {
        Long studentId = 1L;
        Long homeworkId = 1L;

        StudentAnswer answer1 = new StudentAnswer();
        answer1.setId(1L);
        answer1.setStudentId(studentId);
        answer1.setHomeworkId(homeworkId);
        answer1.setQuestionId(1L);
        answer1.setAnswer("答案1");

        StudentAnswer answer2 = new StudentAnswer();
        answer2.setId(2L);
        answer2.setStudentId(studentId);
        answer2.setHomeworkId(homeworkId);
        answer2.setQuestionId(2L);
        answer2.setAnswer("答案2");

        when(studentAnswerMapper.selectList(any())).thenReturn(Arrays.asList(answer1, answer2));

        List<StudentAnswer> result = gradingService.getStudentHomeworkAnswers(studentId, homeworkId);

        assertNotNull(result);
        assertEquals(2, result.size());
        verify(studentAnswerMapper).selectList(any());
    }

    /**
     * 测试提交作业批改结果
     */
    @Test
    public void testSubmitHomeworkGrading() {
        ExamGrading grading = new ExamGrading();
        grading.setStudentId(1L);
        grading.setHomeworkId(1L);
        grading.setScore(new BigDecimal("85"));
        grading.setComment("表现良好");

        when(examGradingMapper.insert(any(ExamGrading.class))).thenReturn(1);

        ExamGrading result = gradingService.submitHomeworkGrading(grading);

        assertNotNull(result);
        assertNotNull(result.getId());
        assertEquals(new BigDecimal("85"), result.getScore());
        verify(examGradingMapper).insert(any(ExamGrading.class));
    }

    /**
     * 测试批量批改作业
     */
    @Test
    public void testBatchGradeHomework() {
        List<ExamGrading> gradings = Arrays.asList(
                createGrading(1L, 1L, new BigDecimal("85"), "良好"),
                createGrading(2L, 1L, new BigDecimal("90"), "优秀"),
                createGrading(3L, 1L, new BigDecimal("78"), "及格")
        );

        when(examGradingMapper.insertBatch(anyList())).thenReturn(3);

        int result = gradingService.batchGradeHomework(gradings);

        assertEquals(3, result);
        verify(examGradingMapper).insertBatch(anyList());
    }

    // ==================== 考试批改测试 ====================

    /**
     * 测试获取待批改考试列表
     */
    @Test
    public void testGetPendingExamList() {
        Long teacherId = 1L;

        Exam exam1 = new Exam();
        exam1.setId(1L);
        exam1.setName("期中考试");
        exam1.setStatus("待批改");

        Exam exam2 = new Exam();
        exam2.setId(2L);
        exam2.setName("期末考试");
        exam2.setStatus("待批改");

        when(examMapper.selectList(any())).thenReturn(Arrays.asList(exam1, exam2));

        List<Exam> result = gradingService.getPendingExamList(teacherId);

        assertNotNull(result);
        assertEquals(2, result.size());
        assertEquals("待批改", result.get(0).getStatus());
        verify(examMapper).selectList(any());
    }

    /**
     * 测试获取学生考试答案
     */
    @Test
    public void testGetStudentExamAnswers() {
        Long studentId = 1L;
        Long examId = 1L;

        StudentAnswer answer1 = new StudentAnswer();
        answer1.setId(1L);
        answer1.setStudentId(studentId);
        answer1.setExamId(examId);
        answer1.setQuestionId(1L);
        answer1.setAnswer("A");

        StudentAnswer answer2 = new StudentAnswer();
        answer2.setId(2L);
        answer2.setStudentId(studentId);
        answer2.setExamId(examId);
        answer2.setQuestionId(2L);
        answer2.setAnswer("B");

        when(studentAnswerMapper.selectList(any())).thenReturn(Arrays.asList(answer1, answer2));

        List<StudentAnswer> result = gradingService.getStudentExamAnswers(studentId, examId);

        assertNotNull(result);
        assertEquals(2, result.size());
        verify(studentAnswerMapper).selectList(any());
    }

    /**
     * 测试提交考试批改结果
     */
    @Test
    public void testSubmitExamGrading() {
        ExamGrading grading = new ExamGrading();
        grading.setStudentId(1L);
        grading.setExamId(1L);
        grading.setScore(new BigDecimal("90"));
        grading.setComment("表现优秀");

        when(examGradingMapper.insert(any(ExamGrading.class))).thenReturn(1);

        ExamGrading result = gradingService.submitExamGrading(grading);

        assertNotNull(result);
        assertNotNull(result.getId());
        assertEquals(new BigDecimal("90"), result.getScore());
        verify(examGradingMapper).insert(any(ExamGrading.class));
    }

    /**
     * 测试批量批改考试
     */
    @Test
    public void testBatchGradeExam() {
        List<ExamGrading> gradings = Arrays.asList(
                createGrading(1L, 1L, new BigDecimal("90"), "优秀"),
                createGrading(2L, 1L, new BigDecimal("85"), "良好"),
                createGrading(3L, 1L, new BigDecimal("78"), "及格")
        );

        when(examGradingMapper.insertBatch(anyList())).thenReturn(3);

        int result = gradingService.batchGradeExam(gradings);

        assertEquals(3, result);
        verify(examGradingMapper).insertBatch(anyList());
    }

    // ==================== 批改状态管理测试 ====================

    /**
     * 测试获取批改状态
     */
    @Test
    public void testGetGradingStatus() {
        Long gradingId = 1L;

        ExamGrading grading = new ExamGrading();
        grading.setId(gradingId);
        grading.setStatus("已完成");
        grading.setScore(new BigDecimal("85"));

        when(examGradingMapper.selectById(gradingId)).thenReturn(grading);

        ExamGrading result = gradingService.getGradingStatus(gradingId);

        assertNotNull(result);
        assertEquals("已完成", result.getStatus());
        verify(examGradingMapper).selectById(gradingId);
    }

    /**
     * 测试更新批改状态
     */
    @Test
    public void testUpdateGradingStatus() {
        Long gradingId = 1L;
        String status = "已批改";

        ExamGrading grading = new ExamGrading();
        grading.setId(gradingId);
        grading.setStatus(status);

        when(examGradingMapper.updateById(any(ExamGrading.class))).thenReturn(1);

        gradingService.updateGradingStatus(gradingId, status);

        verify(examGradingMapper).updateById(any(ExamGrading.class));
    }

    /**
     * 测试获取批改历史
     */
    @Test
    public void testGetGradingHistory() {
        Long teacherId = 1L;

        ExamGrading grading1 = new ExamGrading();
        grading1.setId(1L);
        grading1.setStudentId(1L);
        grading1.setScore(new BigDecimal("85"));
        grading1.setStatus("已完成");

        ExamGrading grading2 = new ExamGrading();
        grading2.setId(2L);
        grading2.setStudentId(2L);
        grading2.setScore(new BigDecimal("90"));
        grading2.setStatus("已完成");

        when(examGradingMapper.selectList(any())).thenReturn(Arrays.asList(grading1, grading2));

        List<ExamGrading> result = gradingService.getGradingHistory(teacherId);

        assertNotNull(result);
        assertEquals(2, result.size());
        verify(examGradingMapper).selectList(any());
    }

    /**
     * 测试获取批改统计
     */
    @Test
    public void testGetGradingStatistics() {
        Long teacherId = 1L;

        ExamGrading grading1 = new ExamGrading();
        grading1.setScore(new BigDecimal("85"));

        ExamGrading grading2 = new ExamGrading();
        grading2.setScore(new BigDecimal("90"));

        ExamGrading grading3 = new ExamGrading();
        grading3.setScore(new BigDecimal("78"));

        when(examGradingMapper.selectList(any())).thenReturn(Arrays.asList(grading1, grading2, grading3));

        var statistics = gradingService.getGradingStatistics(teacherId);

        assertNotNull(statistics);
        verify(examGradingMapper).selectList(any());
    }

    // ==================== 辅助方法 ====================

    private ExamGrading createGrading(Long studentId, Long examId, BigDecimal score, String comment) {
        ExamGrading grading = new ExamGrading();
        grading.setStudentId(studentId);
        grading.setExamId(examId);
        grading.setScore(score);
        grading.setComment(comment);
        return grading;
    }
}
