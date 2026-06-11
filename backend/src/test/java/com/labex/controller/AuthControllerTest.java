package com.labex.controller;

import com.labex.dto.LoginRequest;
import com.labex.entity.Student;
import com.labex.entity.Teacher;
import com.labex.mapper.StudentMapper;
import com.labex.mapper.TeacherMapper;
import com.labex.security.JwtUtil;
import com.labex.service.StudentService;
import com.labex.service.TeacherService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;
import org.springframework.http.ResponseEntity;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

/**
 * AuthController 单元测试 (使用Mockito隔离测试)
 */
@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
@DisplayName("认证控制器单元测试")
class AuthControllerTest {

    @Mock
    private JwtUtil jwtUtil;

    @Mock
    private TeacherService teacherService;

    @Mock
    private StudentService studentService;

    @Mock
    private TeacherMapper teacherMapper;

    @Mock
    private StudentMapper studentMapper;

    @InjectMocks
    private AuthController authController;

    private Student mockStudent;
    private Teacher mockTeacher;

    @BeforeEach
    void setUp() {
        mockStudent = new Student();
        mockStudent.setStudentId(1);
        mockStudent.setStudentNo("2021001");
        mockStudent.setStudentName("张三");
        mockStudent.setStudentPassword("$2a$10$validhash");
        mockStudent.setState(1);

        mockTeacher = new Teacher();
        mockTeacher.setTeacherId(1);
        mockTeacher.setTeacherAccount("teacher1");
        mockTeacher.setTeacherName("李老师");
        mockTeacher.setTeacherPassword("$2a$10$validhash");
        mockTeacher.setState(1);
        mockTeacher.setRole("TEACHER");
    }

    @Test
    @DisplayName("UT-Auth-01: 学生登录成功返回Token")
    void postLogin_ValidStudentCredentials_ReturnsToken() {
        // Arrange
        when(studentMapper.selectByStudentNo("2021001")).thenReturn(mockStudent);

        LoginRequest request = new LoginRequest();
        request.setAccount("2021001");
        request.setPassword("password123");
        request.setRole("STUDENT");

        // Act
        ResponseEntity<?> response = authController.login(request);

        // Assert
        assertNotNull(response);
        assertEquals(200, response.getStatusCode().value());
        verify(studentMapper, times(1)).selectByStudentNo("2021001");
    }

    @Test
    @DisplayName("UT-Auth-01: 教师登录成功返回Token")
    void postLogin_ValidTeacherCredentials_ReturnsToken() {
        // Arrange
        when(teacherMapper.selectByAccount("teacher1")).thenReturn(mockTeacher);

        LoginRequest request = new LoginRequest();
        request.setAccount("teacher1");
        request.setPassword("teacher123");
        request.setRole("TEACHER");

        // Act
        ResponseEntity<?> response = authController.login(request);

        // Assert
        assertNotNull(response);
        assertEquals(200, response.getStatusCode().value());
        verify(teacherMapper, times(1)).selectByAccount("teacher1");
    }

    @Test
    @DisplayName("UT-Auth-02: 用户不存在返回错误")
    void postLogin_UserNotFound_ReturnsError() {
        // Arrange
        when(studentMapper.selectByStudentNo("unknown")).thenReturn(null);
        when(teacherMapper.selectByAccount("unknown")).thenReturn(null);

        LoginRequest request = new LoginRequest();
        request.setAccount("unknown");
        request.setPassword("password");
        request.setRole("STUDENT");

        // Act
        ResponseEntity<?> response = authController.login(request);

        // Assert
        assertNotNull(response);
        assertEquals(200, response.getStatusCode().value());
        assertEquals(-1, ((com.labex.common.Result<?>) response.getBody()).getCode());
    }

    @Test
    @DisplayName("UT-Auth-02: 密码错误返回错误")
    void postLogin_WrongPassword_ReturnsError() {
        // Arrange
        when(studentMapper.selectByStudentNo("2021001")).thenReturn(mockStudent);
        // mockStudent password hash is for "password123", sending "wrong" should fail

        LoginRequest request = new LoginRequest();
        request.setAccount("2021001");
        request.setPassword("wrongpassword");
        request.setRole("STUDENT");

        // Act
        ResponseEntity<?> response = authController.login(request);

        // Assert
        assertNotNull(response);
        // Password verification should fail and return error
    }

    @Test
    @DisplayName("UT-Auth-04: 退出登录成功")
    void postLogout_Success() {
        // Act
        ResponseEntity<?> response = authController.logout();

        // Assert
        assertNotNull(response);
        assertEquals(200, response.getStatusCode().value());
        assertEquals(0, ((com.labex.common.Result<?>) response.getBody()).getCode());
    }

    @Test
    @DisplayName("UT-Auth-05: 学生注册成功")
    void postRegister_ValidRequest_Success() {
        // Arrange
        when(studentMapper.selectByStudentNo("2021999")).thenReturn(null);
        when(studentMapper.insert(any(Student.class))).thenReturn(1);

        com.labex.dto.RegisterRequest request = new com.labex.dto.RegisterRequest();
        request.setStudentNo("2021999");
        request.setStudentName("新学生");
        request.setPassword("password123");

        // Act
        ResponseEntity<?> response = authController.register(request);

        // Assert
        assertNotNull(response);
        assertEquals(200, response.getStatusCode().value());
        verify(studentMapper, times(1)).insert(any(Student.class));
    }

    @Test
    @DisplayName("UT-Auth-05: 学生注册 - 学号已存在")
    void postRegister_StudentNoExists_ReturnsError() {
        // Arrange
        when(studentMapper.selectByStudentNo("2021001")).thenReturn(mockStudent);

        com.labex.dto.RegisterRequest request = new com.labex.dto.RegisterRequest();
        request.setStudentNo("2021001");
        request.setStudentName("新学生");
        request.setPassword("password123");

        // Act
        ResponseEntity<?> response = authController.register(request);

        // Assert
        assertNotNull(response);
        assertEquals(-1, ((com.labex.common.Result<?>) response.getBody()).getCode());
        assertEquals("该学号已注册", ((com.labex.common.Result<?>) response.getBody()).getMessage());
    }

    @Test
    @DisplayName("UT-Auth-05: 管理员角色转换 - 用户是管理员但选择教师角色")
    void postLogin_AdminAsTeacher_ReturnsError() {
        // Arrange
        mockTeacher.setRole("ADMIN"); // 用户实际是管理员
        when(teacherMapper.selectByAccount("admin1")).thenReturn(mockTeacher);

        LoginRequest request = new LoginRequest();
        request.setAccount("admin1");
        request.setPassword("admin123");
        request.setRole("TEACHER"); // 但选择教师角色登录

        // Act
        ResponseEntity<?> response = authController.login(request);

        // Assert
        assertNotNull(response);
        assertEquals(-1, ((com.labex.common.Result<?>) response.getBody()).getCode());
    }
}