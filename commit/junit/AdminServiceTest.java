package com.labex.service.impl;

import com.labex.entity.Teacher;
import com.labex.entity.Student;
import com.labex.entity.Clazz;
import com.labex.mapper.TeacherMapper;
import com.labex.mapper.StudentMapper;
import com.labex.mapper.ClazzMapper;
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
 * 管理员服务测试
 * 测试人员：余飞杨
 * 测试内容：管理员仪表板、教师管理、学生管理、班级管理
 */
@ExtendWith(MockitoExtension.class)
public class AdminServiceTest {

    @InjectMocks
    private AdminService adminService;

    @Mock
    private TeacherMapper teacherMapper;

    @Mock
    private StudentMapper studentMapper;

    @Mock
    private ClazzMapper clazzMapper;

    // ==================== 管理员仪表板测试 ====================

    /**
     * 测试获取仪表板数据
     */
    @Test
    public void testGetDashboardData() {
        when(teacherMapper.selectCount(any())).thenReturn(10L);
        when(studentMapper.selectCount(any())).thenReturn(100L);
        when(clazzMapper.selectCount(any())).thenReturn(20L);

        var dashboardData = adminService.getDashboardData();

        assertNotNull(dashboardData);
        verify(teacherMapper).selectCount(any());
        verify(studentMapper).selectCount(any());
        verify(clazzMapper).selectCount(any());
    }

    // ==================== 教师管理测试 ====================

    /**
     * 测试获取教师列表
     */
    @Test
    public void testGetTeacherList() {
        Teacher teacher1 = new Teacher();
        teacher1.setId(1L);
        teacher1.setName("张老师");
        teacher1.setAccount("teacher1");
        teacher1.setEmail("teacher1@example.com");

        Teacher teacher2 = new Teacher();
        teacher2.setId(2L);
        teacher2.setName("李老师");
        teacher2.setAccount("teacher2");
        teacher2.setEmail("teacher2@example.com");

        when(teacherMapper.selectList(any())).thenReturn(Arrays.asList(teacher1, teacher2));

        List<Teacher> result = adminService.getTeacherList();

        assertNotNull(result);
        assertEquals(2, result.size());
        assertEquals("张老师", result.get(0).getName());
        verify(teacherMapper).selectList(any());
    }

    /**
     * 测试获取教师详情
     */
    @Test
    public void testGetTeacherDetail() {
        Long teacherId = 1L;

        Teacher teacher = new Teacher();
        teacher.setId(teacherId);
        teacher.setName("张老师");
        teacher.setAccount("teacher1");
        teacher.setEmail("teacher1@example.com");
        teacher.setPhone("13800138001");

        when(teacherMapper.selectById(teacherId)).thenReturn(teacher);

        Teacher result = adminService.getTeacherDetail(teacherId);

        assertNotNull(result);
        assertEquals("张老师", result.getName());
        assertEquals("teacher1@example.com", result.getEmail());
        verify(teacherMapper).selectById(teacherId);
    }

    /**
     * 测试创建教师
     */
    @Test
    public void testCreateTeacher() {
        Teacher teacher = new Teacher();
        teacher.setName("新老师");
        teacher.setAccount("newteacher");
        teacher.setPassword("password123");
        teacher.setEmail("newteacher@example.com");
        teacher.setPhone("13800138000");

        when(teacherMapper.insert(any(Teacher.class))).thenReturn(1);

        Teacher result = adminService.createTeacher(teacher);

        assertNotNull(result);
        assertNotNull(result.getId());
        assertEquals("新老师", result.getName());
        verify(teacherMapper).insert(any(Teacher.class));
    }

    /**
     * 测试更新教师信息
     */
    @Test
    public void testUpdateTeacher() {
        Teacher teacher = new Teacher();
        teacher.setId(1L);
        teacher.setName("更新老师");
        teacher.setEmail("update@example.com");
        teacher.setPhone("13900139000");

        when(teacherMapper.updateById(any(Teacher.class))).thenReturn(1);

        Teacher result = adminService.updateTeacher(teacher);

        assertNotNull(result);
        assertEquals("更新老师", result.getName());
        verify(teacherMapper).updateById(any(Teacher.class));
    }

    /**
     * 测试删除教师
     */
    @Test
    public void testDeleteTeacher() {
        Long teacherId = 1L;

        when(teacherMapper.deleteById(teacherId)).thenReturn(1);

        adminService.deleteTeacher(teacherId);

        verify(teacherMapper).deleteById(teacherId);
    }

    // ==================== 学生管理测试 ====================

    /**
     * 测试获取学生列表
     */
    @Test
    public void testGetStudentList() {
        Student student1 = new Student();
        student1.setId(1L);
        student1.setName("张三");
        student1.setStudentNo("2024001");
        student1.setEmail("zhangsan@example.com");

        Student student2 = new Student();
        student2.setId(2L);
        student2.setName("李四");
        student2.setStudentNo("2024002");
        student2.setEmail("lisi@example.com");

        when(studentMapper.selectList(any())).thenReturn(Arrays.asList(student1, student2));

        List<Student> result = adminService.getStudentList();

        assertNotNull(result);
        assertEquals(2, result.size());
        assertEquals("张三", result.get(0).getName());
        verify(studentMapper).selectList(any());
    }

    /**
     * 测试获取学生详情
     */
    @Test
    public void testGetStudentDetail() {
        Long studentId = 1L;

        Student student = new Student();
        student.setId(studentId);
        student.setName("张三");
        student.setStudentNo("2024001");
        student.setEmail("zhangsan@example.com");
        student.setPhone("13800138000");

        when(studentMapper.selectById(studentId)).thenReturn(student);

        Student result = adminService.getStudentDetail(studentId);

        assertNotNull(result);
        assertEquals("张三", result.getName());
        assertEquals("2024001", result.getStudentNo());
        verify(studentMapper).selectById(studentId);
    }

    /**
     * 测试创建学生
     */
    @Test
    public void testCreateStudent() {
        Student student = new Student();
        student.setName("新学生");
        student.setStudentNo("2024003");
        student.setPassword("password123");
        student.setEmail("newstudent@example.com");
        student.setPhone("13800138002");
        student.setClazzId(1L);

        when(studentMapper.insert(any(Student.class))).thenReturn(1);

        Student result = adminService.createStudent(student);

        assertNotNull(result);
        assertNotNull(result.getId());
        assertEquals("新学生", result.getName());
        verify(studentMapper).insert(any(Student.class));
    }

    /**
     * 测试更新学生信息
     */
    @Test
    public void testUpdateStudent() {
        Student student = new Student();
        student.setId(1L);
        student.setName("更新学生");
        student.setEmail("update@example.com");
        student.setPhone("13900139001");

        when(studentMapper.updateById(any(Student.class))).thenReturn(1);

        Student result = adminService.updateStudent(student);

        assertNotNull(result);
        assertEquals("更新学生", result.getName());
        verify(studentMapper).updateById(any(Student.class));
    }

    /**
     * 测试删除学生
     */
    @Test
    public void testDeleteStudent() {
        Long studentId = 1L;

        when(studentMapper.deleteById(studentId)).thenReturn(1);

        adminService.deleteStudent(studentId);

        verify(studentMapper).deleteById(studentId);
    }

    /**
     * 测试批量导入学生
     */
    @Test
    public void testBatchImportStudents() {
        List<Student> students = Arrays.asList(
                createStudent("学生1", "2024004"),
                createStudent("学生2", "2024005"),
                createStudent("学生3", "2024006")
        );

        when(studentMapper.insertBatch(anyList())).thenReturn(3);

        int result = adminService.batchImportStudents(students);

        assertEquals(3, result);
        verify(studentMapper).insertBatch(anyList());
    }

    // ==================== 班级管理测试 ====================

    /**
     * 测试获取班级列表
     */
    @Test
    public void testGetClazzList() {
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

        List<Clazz> result = adminService.getClazzList();

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

        Clazz result = adminService.createClazz(clazz);

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

        Clazz result = adminService.updateClazz(clazz);

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

        adminService.deleteClazz(clazzId);

        verify(clazzMapper).deleteById(clazzId);
    }

    // ==================== 辅助方法 ====================

    private Student createStudent(String name, String studentNo) {
        Student student = new Student();
        student.setName(name);
        student.setStudentNo(studentNo);
        student.setPassword("password123");
        student.setEmail(studentNo + "@example.com");
        student.setPhone("13800138000");
        student.setClazzId(1L);
        return student;
    }
}
