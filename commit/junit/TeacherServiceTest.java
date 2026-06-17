package com.labex.service.impl;

import com.labex.entity.Teacher;
import com.labex.entity.Clazz;
import com.labex.entity.Exam;
import com.labex.entity.Experiment;
import com.labex.entity.Question;
import com.labex.entity.Paper;
import com.labex.mapper.TeacherMapper;
import com.labex.mapper.ClazzMapper;
import com.labex.mapper.ExamMapper;
import com.labex.mapper.ExperimentMapper;
import com.labex.mapper.QuestionMapper;
import com.labex.mapper.PaperMapper;
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
 * 教师服务测试
 * 测试人员：周志文
 * 测试内容：班级管理、考试管理、实验管理、题目管理、试卷管理
 */
@ExtendWith(MockitoExtension.class)
public class TeacherServiceTest {

    @InjectMocks
    private TeacherService teacherService;

    @Mock
    private TeacherMapper teacherMapper;

    @Mock
    private ClazzMapper clazzMapper;

    @Mock
    private ExamMapper examMapper;

    @Mock
    private ExperimentMapper experimentMapper;

    @Mock
    private QuestionMapper questionMapper;

    @Mock
    private PaperMapper paperMapper;

    // ==================== 班级管理测试 ====================

    /**
     * 测试获取班级列表
     */
    @Test
    public void testGetClazzList() {
        Long teacherId = 1L;

        Clazz clazz1 = new Clazz();
        clazz1.setId(1L);
        clazz1.setName("计算机2024-1班");
        clazz1.setGrade("2024");
        clazz1.setMajor("计算机科学与技术");

        Clazz clazz2 = new Clazz();
        clazz2.setId(2L);
        clazz2.setName("计算机2024-2班");
        clazz2.setGrade("2024");
        clazz2.setMajor("计算机科学与技术");

        when(clazzMapper.selectList(any())).thenReturn(Arrays.asList(clazz1, clazz2));

        List<Clazz> result = teacherService.getClazzList(teacherId);

        assertNotNull(result);
        assertEquals(2, result.size());
        assertEquals("计算机2024-1班", result.get(0).getName());
        verify(clazzMapper).selectList(any());
    }

    /**
     * 测试创建班级
     */
    @Test
    public void testCreateClazz() {
        Clazz clazz = new Clazz();
        clazz.setName("计算机2024-3班");
        clazz.setGrade("2024");
        clazz.setMajor("计算机科学与技术");

        when(clazzMapper.insert(any(Clazz.class))).thenReturn(1);

        Clazz result = teacherService.createClazz(clazz);

        assertNotNull(result);
        assertNotNull(result.getId());
        assertEquals("计算机2024-3班", result.getName());
        verify(clazzMapper).insert(any(Clazz.class));
    }

    /**
     * 测试更新班级
     */
    @Test
    public void testUpdateClazz() {
        Clazz clazz = new Clazz();
        clazz.setId(1L);
        clazz.setName("更新班级名称");
        clazz.setGrade("2024");
        clazz.setMajor("软件工程");

        when(clazzMapper.updateById(any(Clazz.class))).thenReturn(1);

        Clazz result = teacherService.updateClazz(clazz);

        assertNotNull(result);
        assertEquals("更新班级名称", result.getName());
        verify(clazzMapper).updateById(any(Clazz.class));
    }

    /**
     * 测试删除班级
     */
    @Test
    public void testDeleteClazz() {
        Long clazzId = 1L;

        when(clazzMapper.deleteById(clazzId)).thenReturn(1);

        teacherService.deleteClazz(clazzId);

        verify(clazzMapper).deleteById(clazzId);
    }

    // ==================== 考试管理测试 ====================

    /**
     * 测试获取考试列表
     */
    @Test
    public void testGetExamList() {
        Long teacherId = 1L;

        Exam exam1 = new Exam();
        exam1.setId(1L);
        exam1.setName("期中考试");
        exam1.setStatus("未开始");

        Exam exam2 = new Exam();
        exam2.setId(2L);
        exam2.setName("期末考试");
        exam2.setStatus("未开始");

        when(examMapper.selectList(any())).thenReturn(Arrays.asList(exam1, exam2));

        List<Exam> result = teacherService.getExamList(teacherId);

        assertNotNull(result);
        assertEquals(2, result.size());
        assertEquals("期中考试", result.get(0).getName());
        verify(examMapper).selectList(any());
    }

    /**
     * 测试创建考试
     */
    @Test
    public void testCreateExam() {
        Exam exam = new Exam();
        exam.setName("Java期中考试");
        exam.setCourseId(1L);
        exam.setDuration(120);

        when(examMapper.insert(any(Exam.class))).thenReturn(1);

        Exam result = teacherService.createExam(exam);

        assertNotNull(result);
        assertNotNull(result.getId());
        assertEquals("Java期中考试", result.getName());
        verify(examMapper).insert(any(Exam.class));
    }

    /**
     * 测试更新考试
     */
    @Test
    public void testUpdateExam() {
        Exam exam = new Exam();
        exam.setId(1L);
        exam.setName("更新考试名称");
        exam.setDuration(150);

        when(examMapper.updateById(any(Exam.class))).thenReturn(1);

        Exam result = teacherService.updateExam(exam);

        assertNotNull(result);
        assertEquals("更新考试名称", result.getName());
        verify(examMapper).updateById(any(Exam.class));
    }

    /**
     * 测试删除考试
     */
    @Test
    public void testDeleteExam() {
        Long examId = 1L;

        when(examMapper.deleteById(examId)).thenReturn(1);

        teacherService.deleteExam(examId);

        verify(examMapper).deleteById(examId);
    }

    // ==================== 实验管理测试 ====================

    /**
     * 测试获取实验列表
     */
    @Test
    public void testGetExperimentList() {
        Long teacherId = 1L;

        Experiment experiment1 = new Experiment();
        experiment1.setId(1L);
        experiment1.setName("Java基础实验");
        experiment1.setDescription("学习Java基础语法");

        Experiment experiment2 = new Experiment();
        experiment2.setId(2L);
        experiment2.setName("Java面向对象实验");
        experiment2.setDescription("学习Java面向对象编程");

        when(experimentMapper.selectList(any())).thenReturn(Arrays.asList(experiment1, experiment2));

        List<Experiment> result = teacherService.getExperimentList(teacherId);

        assertNotNull(result);
        assertEquals(2, result.size());
        assertEquals("Java基础实验", result.get(0).getName());
        verify(experimentMapper).selectList(any());
    }

    /**
     * 测试创建实验
     */
    @Test
    public void testCreateExperiment() {
        Experiment experiment = new Experiment();
        experiment.setName("Java异常处理实验");
        experiment.setDescription("学习Java异常处理机制");
        experiment.setCourseId(1L);

        when(experimentMapper.insert(any(Experiment.class))).thenReturn(1);

        Experiment result = teacherService.createExperiment(experiment);

        assertNotNull(result);
        assertNotNull(result.getId());
        assertEquals("Java异常处理实验", result.getName());
        verify(experimentMapper).insert(any(Experiment.class));
    }

    /**
     * 测试更新实验
     */
    @Test
    public void testUpdateExperiment() {
        Experiment experiment = new Experiment();
        experiment.setId(1L);
        experiment.setName("更新实验名称");
        experiment.setDescription("更新实验描述");

        when(experimentMapper.updateById(any(Experiment.class))).thenReturn(1);

        Experiment result = teacherService.updateExperiment(experiment);

        assertNotNull(result);
        assertEquals("更新实验名称", result.getName());
        verify(experimentMapper).updateById(any(Experiment.class));
    }

    /**
     * 测试删除实验
     */
    @Test
    public void testDeleteExperiment() {
        Long experimentId = 1L;

        when(experimentMapper.deleteById(experimentId)).thenReturn(1);

        teacherService.deleteExperiment(experimentId);

        verify(experimentMapper).deleteById(experimentId);
    }

    // ==================== 题目管理测试 ====================

    /**
     * 测试获取题目列表
     */
    @Test
    public void testGetQuestionList() {
        Long teacherId = 1L;

        Question question1 = new Question();
        question1.setId(1L);
        question1.setTitle("Java中什么是多态？");
        question1.setType(5);
        question1.setDifficulty(3);

        Question question2 = new Question();
        question2.setId(2L);
        question2.setTitle("Java中什么是继承？");
        question2.setType(5);
        question2.setDifficulty(2);

        when(questionMapper.selectList(any())).thenReturn(Arrays.asList(question1, question2));

        List<Question> result = teacherService.getQuestionList(teacherId);

        assertNotNull(result);
        assertEquals(2, result.size());
        assertEquals("Java中什么是多态？", result.get(0).getTitle());
        verify(questionMapper).selectList(any());
    }

    /**
     * 测试创建题目
     */
    @Test
    public void testCreateQuestion() {
        Question question = new Question();
        question.setTitle("Java中什么是封装？");
        question.setContent("请解释Java中封装的概念");
        question.setType(5);
        question.setDifficulty(2);
        question.setScore(10);

        when(questionMapper.insert(any(Question.class))).thenReturn(1);

        Question result = teacherService.createQuestion(question);

        assertNotNull(result);
        assertNotNull(result.getId());
        assertEquals("Java中什么是封装？", result.getTitle());
        verify(questionMapper).insert(any(Question.class));
    }

    /**
     * 测试更新题目
     */
    @Test
    public void testUpdateQuestion() {
        Question question = new Question();
        question.setId(1L);
        question.setTitle("更新题目标题");
        question.setDifficulty(4);

        when(questionMapper.updateById(any(Question.class))).thenReturn(1);

        Question result = teacherService.updateQuestion(question);

        assertNotNull(result);
        assertEquals("更新题目标题", result.getTitle());
        verify(questionMapper).updateById(any(Question.class));
    }

    /**
     * 测试删除题目
     */
    @Test
    public void testDeleteQuestion() {
        Long questionId = 1L;

        when(questionMapper.deleteById(questionId)).thenReturn(1);

        teacherService.deleteQuestion(questionId);

        verify(questionMapper).deleteById(questionId);
    }

    // ==================== 试卷管理测试 ====================

    /**
     * 测试获取试卷列表
     */
    @Test
    public void testGetPaperList() {
        Long teacherId = 1L;

        Paper paper1 = new Paper();
        paper1.setId(1L);
        paper1.setName("Java期中试卷");
        paper1.setTotalScore(100);

        Paper paper2 = new Paper();
        paper2.setId(2L);
        paper2.setName("Java期末试卷");
        paper2.setTotalScore(100);

        when(paperMapper.selectList(any())).thenReturn(Arrays.asList(paper1, paper2));

        List<Paper> result = teacherService.getPaperList(teacherId);

        assertNotNull(result);
        assertEquals(2, result.size());
        assertEquals("Java期中试卷", result.get(0).getName());
        verify(paperMapper).selectList(any());
    }

    /**
     * 测试创建试卷
     */
    @Test
    public void testCreatePaper() {
        Paper paper = new Paper();
        paper.setName("Java单元测试试卷");
        paper.setDescription("Java基础知识测试");
        paper.setTotalScore(100);

        when(paperMapper.insert(any(Paper.class))).thenReturn(1);

        Paper result = teacherService.createPaper(paper);

        assertNotNull(result);
        assertNotNull(result.getId());
        assertEquals("Java单元测试试卷", result.getName());
        verify(paperMapper).insert(any(Paper.class));
    }

    /**
     * 测试更新试卷
     */
    @Test
    public void testUpdatePaper() {
        Paper paper = new Paper();
        paper.setId(1L);
        paper.setName("更新试卷名称");
        paper.setTotalScore(120);

        when(paperMapper.updateById(any(Paper.class))).thenReturn(1);

        Paper result = teacherService.updatePaper(paper);

        assertNotNull(result);
        assertEquals("更新试卷名称", result.getName());
        verify(paperMapper).updateById(any(Paper.class));
    }

    /**
     * 测试删除试卷
     */
    @Test
    public void testDeletePaper() {
        Long paperId = 1L;

        when(paperMapper.deleteById(paperId)).thenReturn(1);

        teacherService.deletePaper(paperId);

        verify(paperMapper).deleteById(paperId);
    }

    // ==================== 教师信息测试 ====================

    /**
     * 测试获取教师信息
     */
    @Test
    public void testGetTeacher() {
        Long teacherId = 1L;

        Teacher teacher = new Teacher();
        teacher.setId(teacherId);
        teacher.setName("张老师");
        teacher.setAccount("teacher");
        teacher.setEmail("teacher@example.com");

        when(teacherMapper.selectById(teacherId)).thenReturn(teacher);

        Teacher result = teacherService.getTeacher(teacherId);

        assertNotNull(result);
        assertEquals("张老师", result.getName());
        verify(teacherMapper).selectById(teacherId);
    }

    /**
     * 测试根据账号获取教师信息
     */
    @Test
    public void testGetTeacherByAccount() {
        String account = "teacher";

        Teacher teacher = new Teacher();
        teacher.setId(1L);
        teacher.setName("张老师");
        teacher.setAccount(account);

        when(teacherMapper.selectOne(any())).thenReturn(teacher);

        Teacher result = teacherService.getTeacherByAccount(account);

        assertNotNull(result);
        assertEquals("张老师", result.getName());
        verify(teacherMapper).selectOne(any());
    }
}
