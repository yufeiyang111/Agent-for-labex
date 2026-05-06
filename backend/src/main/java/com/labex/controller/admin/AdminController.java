package com.labex.controller.admin;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.labex.common.Result;
import com.labex.common.PageResult;
import com.labex.dto.StudentBatchImportRequest;
import com.labex.entity.Clazz;
import com.labex.entity.Student;
import com.labex.entity.Teacher;
import com.labex.service.ClazzService;
import com.labex.service.StudentService;
import com.labex.service.TeacherService;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

/**
 * 管理员控制器 - 管理系统所有资源
 */
@RestController
@RequestMapping("/admin")
@PreAuthorize("hasRole('ADMIN')")
@Slf4j
public class AdminController {

    @Autowired
    private TeacherService teacherService;

    @Autowired
    private StudentService studentService;

    @Autowired
    private ClazzService clazzService;

    // ==================== 教师管理 ====================

    /**
     * 分页查询教师列表
     */
    @GetMapping("/teacher/list")
    public Result<PageResult<Teacher>> listTeachers(
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "20") Integer pageSize,
            @RequestParam(required = false) String keyword) {

        LambdaQueryWrapper<Teacher> wrapper = new LambdaQueryWrapper<>();
        if (keyword != null && !keyword.trim().isEmpty()) {
            wrapper.like(Teacher::getTeacherName, keyword)
                    .or().like(Teacher::getTeacherAccount, keyword);
        }

        Page<Teacher> page = teacherService.page(new Page<>(pageNum, pageSize), wrapper);
        return Result.success(PageResult.success(page.getRecords(), pageNum, pageSize, page.getTotal()));
    }

    /**
     * 获取所有教师（不分页）
     */
    @GetMapping("/teacher/all")
    public Result<List<Teacher>> getAllTeachers() {
        List<Teacher> teachers = teacherService.list();
        return Result.success(teachers);
    }

    /**
     * 根据ID查询教师
     */
    @GetMapping("/teacher/{id}")
    public Result<Teacher> getTeacherById(@PathVariable Integer id) {
        Teacher teacher = teacherService.getById(id);
        if (teacher != null) {
            return Result.success(teacher);
        }
        return Result.error("教师不存在");
    }

    /**
     * 新增教师
     */
    @PostMapping("/teacher")
    public Result<Void> addTeacher(@Valid @RequestBody Teacher teacher) {
        // 检查账号是否已存在
        Teacher existing = teacherService.findByAccount(teacher.getTeacherAccount());
        if (existing != null) {
            return Result.error("账号已存在");
        }

        // 设置默认角色为TEACHER
        if (teacher.getRole() == null || teacher.getRole().isEmpty()) {
            teacher.setRole("TEACHER");
        }

        boolean success = teacherService.save(teacher);
        if (success) {
            log.info("新增教师: {}", teacher.getTeacherName());
            return Result.success("添加成功", null);
        }
        return Result.error("添加失败");
    }

    /**
     * 更新教师
     */
    @PutMapping("/teacher/{id}")
    public Result<Void> updateTeacher(@PathVariable Integer id, @Valid @RequestBody Teacher teacher) {
        teacher.setTeacherId(id);
        boolean success = teacherService.updateById(teacher);
        if (success) {
            log.info("更新教师: {}", id);
            return Result.success("修改成功", null);
        }
        return Result.error("修改失败");
    }

    /**
     * 删除教师
     */
    @DeleteMapping("/teacher/{id}")
    public Result<Void> deleteTeacher(@PathVariable Integer id) {
        Teacher teacher = teacherService.getById(id);
        if (teacher != null && "ADMIN".equalsIgnoreCase(teacher.getRole())) {
            return Result.error("不能删除管理员账号");
        }
        boolean success = teacherService.removeById(id);
        if (success) {
            log.info("删除教师: {}", id);
            return Result.success("删除成功", null);
        }
        return Result.error("删除失败");
    }

    /**
     * 更新教师状态
     */
    @PutMapping("/teacher/{id}/state")
    public Result<Void> updateTeacherState(@PathVariable Integer id, @RequestParam Integer state) {
        Teacher teacher = teacherService.getById(id);
        if (teacher == null) {
            return Result.error("教师不存在");
        }
        if ("ADMIN".equalsIgnoreCase(teacher.getRole())) {
            return Result.error("不能修改管理员状态");
        }
        teacher.setState(state);
        boolean success = teacherService.updateById(teacher);
        if (success) {
            log.info("修改教师状态: {}, state: {}", id, state);
            return Result.success("状态修改成功", null);
        }
        return Result.error("状态修改失败");
    }

    /**
     * 重置教师密码
     */
    @PutMapping("/teacher/{id}/reset-password")
    public Result<Void> resetTeacherPassword(@PathVariable Integer id) {
        Teacher teacher = teacherService.getById(id);
        if (teacher == null) {
            return Result.error("教师不存在");
        }
        teacher.setTeacherPassword(teacher.getTeacherAccount()); // 密码设置为账号
        boolean success = teacherService.updateById(teacher);
        if (success) {
            log.info("重置教师密码: {}", id);
            return Result.success("密码已重置为账号", null);
        }
        return Result.error("密码重置失败");
    }

    // ==================== 学生管理 ====================

    /**
     * 分页查询学生列表
     */
    @GetMapping("/student/list")
    public Result<PageResult<Student>> listStudents(
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "20") Integer pageSize,
            @RequestParam(required = false) String clazzNo,
            @RequestParam(required = false) String keyword) {

        LambdaQueryWrapper<Student> wrapper = new LambdaQueryWrapper<>();

        if (clazzNo != null && !clazzNo.trim().isEmpty()) {
            wrapper.eq(Student::getClazzNo, clazzNo);
        }
        if (keyword != null && !keyword.trim().isEmpty()) {
            wrapper.and(w -> w.like(Student::getStudentName, keyword)
                    .or().like(Student::getStudentNo, keyword));
        }

        Page<Student> page = studentService.page(new Page<>(pageNum, pageSize), wrapper);
        return Result.success(PageResult.success(page.getRecords(), pageNum, pageSize, page.getTotal()));
    }

    /**
     * 获取所有学生（不分页）
     */
    @GetMapping("/student/all")
    public Result<List<Student>> getAllStudents() {
        List<Student> students = studentService.list();
        return Result.success(students);
    }

    /**
     * 根据ID查询学生
     */
    @GetMapping("/student/{id}")
    public Result<Student> getStudentById(@PathVariable Integer id) {
        Student student = studentService.getById(id);
        if (student != null) {
            return Result.success(student);
        }
        return Result.error("学生不存在");
    }

    /**
     * 新增学生
     */
    @PostMapping("/student")
    public Result<Void> addStudent(@Valid @RequestBody Student student) {
        // 检查学号是否已存在
        long count = studentService.count(
                new LambdaQueryWrapper<Student>().eq(Student::getStudentNo, student.getStudentNo())
        );
        if (count > 0) {
            return Result.error("学号已存在");
        }

        boolean success = studentService.save(student);
        if (success) {
            log.info("新增学生: {}", student.getStudentName());
            return Result.success("添加成功", null);
        }
        return Result.error("添加失败");
    }

    /**
     * 更新学生
     */
    @PutMapping("/student/{id}")
    public Result<Void> updateStudent(@PathVariable Integer id, @Valid @RequestBody Student student) {
        student.setStudentId(id);
        boolean success = studentService.updateById(student);
        if (success) {
            log.info("更新学生: {}", id);
            return Result.success("修改成功", null);
        }
        return Result.error("修改失败");
    }

    /**
     * 删除学生
     */
    @DeleteMapping("/student/{id}")
    public Result<Void> deleteStudent(@PathVariable Integer id) {
        boolean success = studentService.removeById(id);
        if (success) {
            log.info("删除学生: {}", id);
            return Result.success("删除成功", null);
        }
        return Result.error("删除失败");
    }

    /**
     * 启用/禁用学生
     */
    @PutMapping("/student/{id}/state")
    public Result<Void> updateStudentState(@PathVariable Integer id, @RequestParam Integer state) {
        Student student = studentService.getById(id);
        if (student == null) {
            return Result.error("学生不存在");
        }
        student.setState(state);
        boolean success = studentService.updateById(student);
        if (success) {
            log.info("修改学生状态: {}, state: {}", id, state);
            return Result.success("状态修改成功", null);
        }
        return Result.error("状态修改失败");
    }

    /**
     * 重置学生密码
     */
    @PutMapping("/student/{id}/reset-password")
    public Result<Void> resetStudentPassword(@PathVariable Integer id) {
        Student student = studentService.getById(id);
        if (student == null) {
            return Result.error("学生不存在");
        }
        student.setStudentPassword(student.getStudentNo());
        boolean success = studentService.updateById(student);
        if (success) {
            log.info("重置学生密码: {}", id);
            return Result.success("密码已重置为学号", null);
        }
        return Result.error("密码重置失败");
    }

    /**
     * 重置学生IP
     */
    @PutMapping("/student/{id}/reset-ip")
    public Result<Void> resetStudentIp(@PathVariable Integer id) {
        Student student = studentService.getById(id);
        if (student == null) {
            return Result.error("学生不存在");
        }
        student.setIp(null);
        boolean success = studentService.updateById(student);
        if (success) {
            log.info("重置学生IP: {}", id);
            return Result.success("IP已重置", null);
        }
        return Result.error("IP重置失败");
    }

    /**
     * 批量导入学生
     */
    @PostMapping("/student/import")
    public Result<Void> importStudents(
            @RequestParam("file") MultipartFile file,
            @RequestParam String clazzNo) {

        if (file.isEmpty()) {
            return Result.error("文件为空");
        }

        try (BufferedReader reader = new BufferedReader(new InputStreamReader(file.getInputStream()))) {
            String line;
            List<Student> students = new ArrayList<>();
            int lineNum = 0;

            while ((line = reader.readLine()) != null) {
                lineNum++;
                if (lineNum == 1) {
                    continue;
                }

                String[] parts = line.split(",");
                if (parts.length < 2) {
                    continue;
                }

                String studentNo = parts[0].trim();
                String studentName = parts[1].trim();

                if (!studentNo.matches("\\d{8}")) {
                    log.warn("第{}行学号格式错误: {}", lineNum, studentNo);
                    continue;
                }

                Student existing = studentService.findByStudentNo(studentNo);
                if (existing != null) {
                    log.warn("第{}行学号已存在: {}", lineNum, studentNo);
                    continue;
                }

                Student student = new Student();
                student.setStudentNo(studentNo);
                student.setStudentName(studentName);
                student.setClazzNo(clazzNo);
                student.setState(0);
                student.setStudentPassword(studentNo);

                students.add(student);
            }

            if (!students.isEmpty()) {
                studentService.batchImport(clazzNo, students);
                return Result.success("导入成功，共" + students.size() + "条记录", null);
            } else {
                return Result.error("没有可导入的数据");
            }

        } catch (IOException e) {
            log.error("文件读取失败", e);
            return Result.error("文件读取失败");
        }
    }

    // ==================== 班级管理 ====================

    /**
     * 分页查询班级列表
     */
    @GetMapping("/clazz/list")
    public Result<PageResult<Clazz>> listClazzs(
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "20") Integer pageSize,
            @RequestParam(required = false) String keyword) {

        LambdaQueryWrapper<Clazz> wrapper = new LambdaQueryWrapper<>();
        if (keyword != null && !keyword.trim().isEmpty()) {
            wrapper.like(Clazz::getNo, keyword)
                    .or().like(Clazz::getMemo, keyword);
        }

        Page<Clazz> page = clazzService.page(new Page<>(pageNum, pageSize), wrapper);
        return Result.success(PageResult.success(page.getRecords(), pageNum, pageSize, page.getTotal()));
    }

    /**
     * 获取所有班级
     */
    @GetMapping("/clazz/all")
    public Result<List<Clazz>> getAllClazzs() {
        List<Clazz> clazzs = clazzService.list();
        return Result.success(clazzs);
    }

    /**
     * 根据班级编号查询
     */
    @GetMapping("/clazz/{no}")
    public Result<Clazz> getClazzByNo(@PathVariable String no) {
        Clazz clazz = clazzService.findByNo(no);
        if (clazz != null) {
            return Result.success(clazz);
        }
        return Result.error("班级不存在");
    }

    /**
     * 新增班级
     */
    @PostMapping("/clazz")
    public Result<Void> addClazz(@Valid @RequestBody Clazz clazz) {
        Clazz existing = clazzService.findByNo(clazz.getNo());
        if (existing != null) {
            return Result.error("班级编号已存在");
        }

        boolean success = clazzService.save(clazz);
        if (success) {
            log.info("新增班级: {}", clazz.getNo());
            return Result.success("添加成功", null);
        }
        return Result.error("添加失败");
    }

    /**
     * 更新班级
     */
    @PutMapping("/clazz/{no}")
    public Result<Void> updateClazz(@PathVariable String no, @Valid @RequestBody Clazz clazz) {
        Clazz existing = clazzService.findByNo(no);
        if (existing == null) {
            return Result.error("班级不存在");
        }

        existing.setMemo(clazz.getMemo());
        existing.setState(clazz.getState());

        boolean success = clazzService.updateByNo(no, existing);
        if (success) {
            log.info("更新班级: {}", no);
            return Result.success("修改成功", null);
        }
        return Result.error("修改失败");
    }

    /**
     * 删除班级
     */
    @DeleteMapping("/clazz/{no}")
    public Result<Void> deleteClazz(@PathVariable String no) {
        boolean success = clazzService.removeByNo(no);
        if (success) {
            log.info("删除班级: {}", no);
            return Result.success("删除成功", null);
        }
        return Result.error("删除失败");
    }

    /**
     * 更新班级状态
     */
    @PutMapping("/clazz/{no}/state")
    public Result<Void> updateClazzState(@PathVariable String no, @RequestParam Integer state) {
        Clazz clazz = clazzService.findByNo(no);
        if (clazz == null) {
            return Result.error("班级不存在");
        }
        clazz.setState(state);
        boolean success = clazzService.updateByNo(no, clazz);
        if (success) {
            log.info("修改班级状态: {}, state: {}", no, state);
            return Result.success("状态��改成功", null);
        }
        return Result.error("状态修改失败");
    }

    // ==================== 统计信息 ====================

    /**
     * 获取系统统计信息
     */
    @GetMapping("/stats")
    public Result<Object> getStats() {
        long teacherCount = teacherService.count();
        long studentCount = studentService.count();
        long clazzCount = clazzService.count();

        return Result.success(java.util.Map.of(
                "teacherCount", teacherCount,
                "studentCount", studentCount,
                "clazzCount", clazzCount
        ));
    }
}