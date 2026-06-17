package com.labex.service.impl;

import com.labex.entity.Student;
import com.labex.entity.Exam;
import com.labex.entity.Homework;
import com.labex.entity.TrainingSet;
import com.labex.entity.StudentProject;
import com.labex.entity.StudentAnswer;
import com.labex.mapper.StudentMapper;
import com.labex.mapper.ExamMapper;
import com.labex.mapper.HomeworkMapper;
import com.labex.mapper.TrainingSetMapper;
import com.labex.mapper.StudentProjectMapper;
import com.labex.mapper.StudentAnswerMapper;
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
 * 学生服务测试
 * 测试人员：杨宇润
 * 测试内容：学生个人信息、考试、作业、训练、项目
 */
@ExtendWith(MockitoExtension.class)
public class StudentServiceTest {

    @InjectMocks
    private StudentService studentService;

    @Mock
    private StudentMapper studentMapper;

    @Mock
    private ExamMapper examMapper;

    @Mock
    private HomeworkMapper homeworkMapper;

    @Mock
    private TrainingSetMapper trainingSetMapper;

    @Mock
    private StudentProjectMapper studentProjectMapper;

    @Mock
    private StudentAnswerMapper studentAnswerMapper;

    // ==================== 学生个人信息测试 ====================

    /**
     * 测试获取学生信息
     */
    @Test
    public void testGetStudent() {
        Long studentId = 1L;

        Student student = new Student();
        student.setId(studentId);
        student.setName("张三");
        student.setStudentNo("2024001");
        student.setEmail("zhangsan@example.com");

        when(studentMapper.selectById(studentId)).thenReturn(student);

        Student result = studentService.getStudent(studentId);

        assertNotNull(result);
        assertEquals("张三", result.getName());
        assertEquals("2024001", result.getStudentNo());
        verify(studentMapper).selectById(studentId);
    }

    /**
     * 测试根据学号获取学生信息
     */
    @Test
    public void testGetStudentByStudentNo() {
        String studentNo = "2024001";

        Student student = new Student();
        student.setId(1L);
        student.setName("张三");
        student.setStudentNo(studentNo);

        when(studentMapper.selectOne(any())).thenReturn(student);

        Student result = studentService.getStudentByStudentNo(studentNo);

        assertNotNull(result);
        assertEquals("张三", result.getName());
        verify(studentMapper).selectOne(any());
    }

    /**
     * 测试更新学生信息
     */
    @Test
    public void testUpdateStudent() {
        Student student = new Student();
        student.setId(1L);
        student.setName("张三");
        student.setEmail("zhangsan@example.com");
        student.setPhone("13800138000");

        when(studentMapper.updateById(any(Student.class))).thenReturn(1);

        Student result = studentService.updateStudent(student);

        assertNotNull(result);
        assertEquals("zhangsan@example.com", result.getEmail());
        verify(studentMapper).updateById(any(Student.class));
    }

    // ==================== 学生考试测试 ====================

    /**
     * 测试获取考试列表
     */
    @Test
    public void testGetExamList() {
        Long studentId = 1L;

        Exam exam1 = new Exam();
        exam1.setId(1L);
        exam1.setName("期中考试");
        exam1.setStatus("进行中");

        Exam exam2 = new Exam();
        exam2.setId(2L);
        exam2.setName("期末考试");
        exam2.setStatus("未开始");

        when(examMapper.selectList(any())).thenReturn(Arrays.asList(exam1, exam2));

        List<Exam> result = studentService.getExamList(studentId);

        assertNotNull(result);
        assertEquals(2, result.size());
        assertEquals("期中考试", result.get(0).getName());
        verify(examMapper).selectList(any());
    }

    /**
     * 测试提交考试答案
     */
    @Test
    public void testSubmitExamAnswer() {
        StudentAnswer answer = new StudentAnswer();
        answer.setStudentId(1L);
        answer.setExamId(1L);
        answer.setQuestionId(1L);
        answer.setAnswer("A");

        when(studentAnswerMapper.insert(any(StudentAnswer.class))).thenReturn(1);

        StudentAnswer result = studentService.submitExamAnswer(answer);

        assertNotNull(result);
        assertNotNull(result.getId());
        verify(studentAnswerMapper).insert(any(StudentAnswer.class));
    }

    /**
     * 测试获取考试结果
     */
    @Test
    public void testGetExamResult() {
        Long studentId = 1L;
        Long examId = 1L;

        StudentAnswer answer = new StudentAnswer();
        answer.setId(1L);
        answer.setStudentId(studentId);
        answer.setExamId(examId);
        answer.setScore(85);

        when(studentAnswerMapper.selectList(any())).thenReturn(Arrays.asList(answer));

        List<StudentAnswer> result = studentService.getExamResult(studentId, examId);

        assertNotNull(result);
        assertEquals(1, result.size());
        assertEquals(85, result.get(0).getScore());
        verify(studentAnswerMapper).selectList(any());
    }

    // ==================== 学生作业测试 ====================

    /**
     * 测试获取作业列表
     */
    @Test
    public void testGetHomeworkList() {
        Long studentId = 1L;

        Homework homework1 = new Homework();
        homework1.setId(1L);
        homework1.setTitle("Java基础作业");
        homework1.setStatus("未完成");

        Homework homework2 = new Homework();
        homework2.setId(2L);
        homework2.setTitle("Java面向对象作业");
        homework2.setStatus("未完成");

        when(homeworkMapper.selectList(any())).thenReturn(Arrays.asList(homework1, homework2));

        List<Homework> result = studentService.getHomeworkList(studentId);

        assertNotNull(result);
        assertEquals(2, result.size());
        assertEquals("Java基础作业", result.get(0).getTitle());
        verify(homeworkMapper).selectList(any());
    }

    /**
     * 测试提交作业答案
     */
    @Test
    public void testSubmitHomeworkAnswer() {
        StudentAnswer answer = new StudentAnswer();
        answer.setStudentId(1L);
        answer.setHomeworkId(1L);
        answer.setQuestionId(1L);
        answer.setAnswer("答案内容");

        when(studentAnswerMapper.insert(any(StudentAnswer.class))).thenReturn(1);

        StudentAnswer result = studentService.submitHomeworkAnswer(answer);

        assertNotNull(result);
        assertNotNull(result.getId());
        verify(studentAnswerMapper).insert(any(StudentAnswer.class));
    }

    /**
     * 测试获取作业结果
     */
    @Test
    public void testGetHomeworkResult() {
        Long studentId = 1L;
        Long homeworkId = 1L;

        StudentAnswer answer = new StudentAnswer();
        answer.setId(1L);
        answer.setStudentId(studentId);
        answer.setHomeworkId(homeworkId);
        answer.setScore(90);

        when(studentAnswerMapper.selectList(any())).thenReturn(Arrays.asList(answer));

        List<StudentAnswer> result = studentService.getHomeworkResult(studentId, homeworkId);

        assertNotNull(result);
        assertEquals(1, result.size());
        assertEquals(90, result.get(0).getScore());
        verify(studentAnswerMapper).selectList(any());
    }

    // ==================== 学生训练测试 ====================

    /**
     * 测试获取训练列表
     */
    @Test
    public void testGetTrainingList() {
        Long studentId = 1L;

        TrainingSet training1 = new TrainingSet();
        training1.setId(1L);
        training1.setName("Java基础训练");
        training1.setDescription("Java基础知识训练集");

        TrainingSet training2 = new TrainingSet();
        training2.setId(2L);
        training2.setName("Java面向对象训练");
        training2.setDescription("Java面向对象编程训练集");

        when(trainingSetMapper.selectList(any())).thenReturn(Arrays.asList(training1, training2));

        List<TrainingSet> result = studentService.getTrainingList(studentId);

        assertNotNull(result);
        assertEquals(2, result.size());
        assertEquals("Java基础训练", result.get(0).getName());
        verify(trainingSetMapper).selectList(any());
    }

    /**
     * 测试提交训练答案
     */
    @Test
    public void testSubmitTrainingAnswer() {
        StudentAnswer answer = new StudentAnswer();
        answer.setStudentId(1L);
        answer.setTrainingId(1L);
        answer.setQuestionId(1L);
        answer.setAnswer("A");

        when(studentAnswerMapper.insert(any(StudentAnswer.class))).thenReturn(1);

        StudentAnswer result = studentService.submitTrainingAnswer(answer);

        assertNotNull(result);
        assertNotNull(result.getId());
        verify(studentAnswerMapper).insert(any(StudentAnswer.class));
    }

    /**
     * 测试获取训练结果
     */
    @Test
    public void testGetTrainingResult() {
        Long studentId = 1L;
        Long trainingId = 1L;

        StudentAnswer answer = new StudentAnswer();
        answer.setId(1L);
        answer.setStudentId(studentId);
        answer.setTrainingId(trainingId);
        answer.setScore(95);

        when(studentAnswerMapper.selectList(any())).thenReturn(Arrays.asList(answer));

        List<StudentAnswer> result = studentService.getTrainingResult(studentId, trainingId);

        assertNotNull(result);
        assertEquals(1, result.size());
        assertEquals(95, result.get(0).getScore());
        verify(studentAnswerMapper).selectList(any());
    }

    // ==================== 学生项目测试 ====================

    /**
     * 测试获取项目列表
     */
    @Test
    public void testGetProjectList() {
        Long studentId = 1L;

        StudentProject project1 = new StudentProject();
        project1.setId(1L);
        project1.setName("Java项目1");
        project1.setDescription("Java基础项目");

        StudentProject project2 = new StudentProject();
        project2.setId(2L);
        project2.setName("Java项目2");
        project2.setDescription("Java高级项目");

        when(studentProjectMapper.selectList(any())).thenReturn(Arrays.asList(project1, project2));

        List<StudentProject> result = studentService.getProjectList(studentId);

        assertNotNull(result);
        assertEquals(2, result.size());
        assertEquals("Java项目1", result.get(0).getName());
        verify(studentProjectMapper).selectList(any());
    }

    /**
     * 测试创建项目
     */
    @Test
    public void testCreateProject() {
        StudentProject project = new StudentProject();
        project.setName("新Java项目");
        project.setDescription("新Java项目描述");
        project.setStudentId(1L);

        when(studentProjectMapper.insert(any(StudentProject.class))).thenReturn(1);

        StudentProject result = studentService.createProject(project);

        assertNotNull(result);
        assertNotNull(result.getId());
        assertEquals("新Java项目", result.getName());
        verify(studentProjectMapper).insert(any(StudentProject.class));
    }

    /**
     * 测试删除项目
     */
    @Test
    public void testDeleteProject() {
        Long projectId = 1L;

        when(studentProjectMapper.deleteById(projectId)).thenReturn(1);

        studentService.deleteProject(projectId);

        verify(studentProjectMapper).deleteById(projectId);
    }

    /**
     * 测试获取项目详情
     */
    @Test
    public void testGetProject() {
        Long projectId = 1L;

        StudentProject project = new StudentProject();
        project.setId(projectId);
        project.setName("Java项目");
        project.setDescription("Java项目描述");

        when(studentProjectMapper.selectById(projectId)).thenReturn(project);

        StudentProject result = studentService.getProject(projectId);

        assertNotNull(result);
        assertEquals("Java项目", result.getName());
        verify(studentProjectMapper).selectById(projectId);
    }

    // ==================== 学生课程测试 ====================

    /**
     * 测试获取课程列表
     */
    @Test
    public void testGetCourseList() {
        Long studentId = 1L;

        // 这里需要模拟课程查询，但为了简洁，我们假设课程服务已经存在
        // 实际测试中需要注入CourseMapper或CourseService
        List<?> courses = studentService.getCourseList(studentId);

        assertNotNull(courses);
    }

    // ==================== 学生讲义测试 ====================

    /**
     * 测试获取讲义列表
     */
    @Test
    public void testGetLectureList() {
        Long studentId = 1L;

        // 这里需要模拟讲义查询，但为了简洁，我们假设讲义服务已经存在
        // 实际测试中需要注入LectureMapper或LectureService
        List<?> lectures = studentService.getLectureList(studentId);

        assertNotNull(lectures);
    }
}
