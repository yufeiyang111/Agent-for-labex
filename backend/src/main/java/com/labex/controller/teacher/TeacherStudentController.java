package com.labex.controller.teacher;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.labex.common.Result;
import com.labex.common.PageResult;
import com.labex.dto.StudentBatchImportRequest;
import com.labex.entity.Clazz;
import com.labex.entity.Student;
import com.labex.entity.StudentClazz;
import com.labex.entity.Teacher;
import com.labex.service.ClazzService;
import com.labex.service.StudentClazzService;
import com.labex.service.StudentService;
import com.labex.service.TeacherService;
import com.labex.util.CurrentUser;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * 教师-学生管理控制器
 */
@RestController
@RequestMapping("/teacher/student")
@PreAuthorize("hasRole('TEACHER')")
@Slf4j
public class TeacherStudentController {

    @Autowired
    private StudentService studentService;

    @Autowired
    private ClazzService clazzService;

    @Autowired
    private TeacherService teacherService;

    @Autowired
    private StudentClazzService studentClazzService;

    /**
     * 获取当前登录教师的ID
     */
    private Integer getCurrentTeacherId() {
        String username = CurrentUser.getUsername();
        if (username == null) {
            return null;
        }
        Teacher teacher = teacherService.findByAccount(username);
        return teacher != null ? teacher.getTeacherId() : null;
    }

    /**
     * 获取当前老师拥有的班级编号列表
     */
    private List<String> getCurrentTeacherClazzNos() {
        Integer teacherId = getCurrentTeacherId();
        if (teacherId == null) {
            return new ArrayList<>();
        }
        return clazzService.getClazzNosByTeacherId(teacherId);
    }

    /**
     * 验证班级是否属于当前老师
     */
    private boolean isClazzBelongsToCurrentTeacher(String clazzNo) {
        List<String> clazzNos = getCurrentTeacherClazzNos();
        return clazzNos.contains(clazzNo);
    }

    /**
     * 分页查询学生列表（只显示属于当前老师的班级的学生）
     */
    @GetMapping("/list")
    public Result<PageResult<Student>> list(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "20") Integer pageSize,
            @RequestParam(required = false) String clazzNo,
            @RequestParam(required = false) String keyword) {

        log.debug("查询学生列表: page={}, pageSize={}, clazzNo={}, keyword={}", page, pageSize, clazzNo, keyword);

        Integer teacherId = getCurrentTeacherId();
        if (teacherId == null) {
            return Result.error("未找到教师信息");
        }

        // 使用学生班级关联表查询
        List<StudentClazz> studentClazzRelations = new ArrayList<>();
        if (clazzNo != null && !clazzNo.trim().isEmpty()) {
            // 指定了班级，验证班级是否属于当前老师
            if (!isClazzBelongsToCurrentTeacher(clazzNo)) {
                return emptyPageResult(page, pageSize);
            }
            studentClazzRelations = studentClazzService.findByClazzNo(clazzNo);
        } else {
            // 查询当前教师的所有学生
            studentClazzRelations = studentClazzService.findByTeacherId(teacherId);
        }

        if (studentClazzRelations.isEmpty()) {
            return emptyPageResult(page, pageSize);
        }

        // 获取学生ID列表
        List<Integer> studentIds = studentClazzRelations.stream()
                .map(StudentClazz::getStudentId)
                .distinct()
                .toList();

        // 查询学生详情
        LambdaQueryWrapper<Student> wrapper = new LambdaQueryWrapper<>();
        wrapper.in(Student::getStudentId, studentIds);

        if (keyword != null && !keyword.trim().isEmpty()) {
            wrapper.and(w -> w.like(Student::getStudentName, keyword)
                    .or().like(Student::getStudentNo, keyword));
        }

        // 分页查询
        Page<Student> p = studentService.page(new Page<>(page, pageSize), wrapper);
        log.debug("查询到 {} 条记录", p.getTotal());

        PageResult<Student> pageResult = new PageResult<>();
        pageResult.setPageNum(page);
        pageResult.setPageSize(pageSize);
        pageResult.setTotal(p.getTotal());
        pageResult.setList(p.getRecords());
        pageResult.setTotalPages((int) Math.ceil((double) p.getTotal() / pageSize));

        return Result.success(pageResult);
    }

    private Result<PageResult<Student>> emptyPageResult(int page, int pageSize) {
        PageResult<Student> pageResult = new PageResult<>();
        pageResult.setPageNum(page);
        pageResult.setPageSize(pageSize);
        pageResult.setTotal(0L);
        pageResult.setList(new ArrayList<>());
        pageResult.setTotalPages(0);
        return Result.success(pageResult);
    }

    /**
     * 根据班级查询学生列表（只允许查询属于自己的班级）
     */
    @GetMapping("/clazz/{clazzNo}")
    public Result<List<Student>> getByClazz(@PathVariable String clazzNo) {
        if (!isClazzBelongsToCurrentTeacher(clazzNo)) {
            return Result.error("无权访问该班级的学生");
        }

        List<Student> students = studentService.list(
                new LambdaQueryWrapper<Student>().eq(Student::getClazzNo, clazzNo)
        );
        return Result.success(students);
    }

    /**
     * 根据ID查询学生
     */
    @GetMapping("/{id}")
    public Result<Student> getById(@PathVariable Integer id) {
        Student student = studentService.getById(id);
        if (student != null) {
            // 验证学生是否属于当前老师的班级
            if (!isClazzBelongsToCurrentTeacher(student.getClazzNo())) {
                return Result.error("无权访问该学生");
            }
            return Result.success(student);
        }
        return Result.error("学生不存在");
    }

    /**
     * 新增学生（只能添加到属于自己的班级）
     * 如果学号已存在，则将其关联到当前教师的班级（多对多关系）
     */
    @PostMapping
    public Result<Void> add(@Valid @RequestBody Student student) {
        // 验证班级是否属于当前老师
        if (!isClazzBelongsToCurrentTeacher(student.getClazzNo())) {
            return Result.error("只能向自己的班级添加学生");
        }

        Integer teacherId = getCurrentTeacherId();
        if (teacherId == null) {
            return Result.error("未找到教师信息");
        }

        try {
            studentService.saveOrUpdateStudent(student, teacherId, student.getClazzNo());
            return Result.success("添加成功", null);
        } catch (Exception e) {
            log.error("添加学生失败", e);
            return Result.error("添加失败");
        }
    }

    /**
     * 更新学生
     */
    @PutMapping("/{id}")
    public Result<Void> update(@PathVariable Integer id, @Valid @RequestBody Student student) {
        // 验证学生是否属于当前老师的班级
        Student existing = studentService.getById(id);
        if (existing == null) {
            return Result.error("学生不存在");
        }
        if (!isClazzBelongsToCurrentTeacher(existing.getClazzNo())) {
            return Result.error("无权修改该学生");
        }

        // 如果要修改班级，验证新班级是否属于当前老师
        if (student.getClazzNo() != null && !student.getClazzNo().equals(existing.getClazzNo())) {
            if (!isClazzBelongsToCurrentTeacher(student.getClazzNo())) {
                return Result.error("只能将学生移动到自己的班级");
            }
        }

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
    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Integer id) {
        // 验证学生是否属于当前老师的班级
        Student existing = studentService.getById(id);
        if (existing == null) {
            return Result.error("学生不存在");
        }
        if (!isClazzBelongsToCurrentTeacher(existing.getClazzNo())) {
            return Result.error("无权删除该学生");
        }

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
    @PutMapping("/{id}/state")
    public Result<Void> updateState(@PathVariable Integer id, @RequestParam Integer state) {
        Student student = studentService.getById(id);
        if (student == null) {
            return Result.error("学生不存在");
        }
        // 验证学生是否属于当前老师的班级
        if (!isClazzBelongsToCurrentTeacher(student.getClazzNo())) {
            return Result.error("无权修改该学生");
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
     * 重置学生密码为学号
     */
    @PutMapping("/{id}/reset-password")
    public Result<Void> resetPassword(@PathVariable Integer id) {
        Student student = studentService.getById(id);
        if (student == null) {
            return Result.error("学生不存在");
        }
        // 验证学生是否属于当前老师的班级
        if (!isClazzBelongsToCurrentTeacher(student.getClazzNo())) {
            return Result.error("无权修改该学生");
        }

        student.setStudentPassword(student.getStudentNo()); // 密码设置为学号（后续需要加密）
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
    @PutMapping("/{id}/reset-ip")
    public Result<Void> resetIp(@PathVariable Integer id) {
        Student student = studentService.getById(id);
        if (student == null) {
            return Result.error("学生不存在");
        }
        // 验证学生是否属于当前老师的班级
        if (!isClazzBelongsToCurrentTeacher(student.getClazzNo())) {
            return Result.error("无权修改该学生");
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
     * 批量导入学生（支持 Excel 和 CSV 文件，只能导入到属于自己的班级）
     * 如果学号已存在，则将其关联到当前班级（多对多关系）
     */
    @PostMapping("/import")
    public Result<Void> importStudents(
            @RequestParam("file") MultipartFile file,
            @RequestParam String clazzNo) {

        // 验证班级是否属于当前老师
        if (!isClazzBelongsToCurrentTeacher(clazzNo)) {
            return Result.error("只能向自己的班级导入学生");
        }

        Integer teacherId = getCurrentTeacherId();
        if (teacherId == null) {
            return Result.error("未找到教师信息");
        }

        if (file.isEmpty()) {
            return Result.error("文件为空");
        }

        String filename = file.getOriginalFilename();
        if (filename == null) {
            return Result.error("文件名为空");
        }

        try {
            List<String[]> rows = new ArrayList<>();

            // 根据文件类型解析
            if (filename.endsWith(".xlsx") || filename.endsWith(".xls")) {
                rows = parseExcelFile(file.getInputStream());
            } else if (filename.endsWith(".csv")) {
                rows = parseCsvFile(file.getInputStream());
            } else {
                return Result.error("不支持的文件格式，请使用 .xlsx 或 .csv 文件");
            }

            int addedCount = 0;
            int linkedCount = 0;
            int skippedCount = 0;

            for (int i = 0; i < rows.size(); i++) {
                String[] parts = rows.get(i);
                if (parts.length < 2) {
                    skippedCount++;
                    continue;
                }

                String studentNo = parts[0].trim();
                String studentName = parts[1].trim();

                // 验证学号格式（8位数字）
                if (!studentNo.matches("\\d{8}")) {
                    log.warn("第{}行学号格式错误: {}", i + 2, studentNo);
                    skippedCount++;
                    continue;
                }

                // 检查学生是否已存在
                Student existingStudent = studentService.findByStudentNo(studentNo);

                Student student = new Student();
                student.setStudentNo(studentNo);
                student.setStudentName(studentName);
                student.setState(1);

                // 使用新的关联方法：保存或更新学生并创建关联
                studentService.saveOrUpdateStudent(student, teacherId, clazzNo);

                if (existingStudent == null) {
                    addedCount++;
                } else {
                    linkedCount++;
                }
            }

            String message = "导入完成：新增" + addedCount + "人，关联" + linkedCount + "人，跳过" + skippedCount + "人";
            log.info(message);
            return Result.success(message, null);

        } catch (Exception e) {
            log.error("文件读取失败", e);
            return Result.error("文件读取失败：" + e.getMessage());
        }
    }

    /**
     * 解析 Excel 文件
     */
    private List<String[]> parseExcelFile(InputStream inputStream) throws IOException {
        List<String[]> rows = new ArrayList<>();

        try (Workbook workbook = WorkbookFactory.create(inputStream)) {
            Sheet sheet = workbook.getSheetAt(0);
            Iterator<Row> rowIterator = sheet.iterator();

            // 跳过表头
            if (rowIterator.hasNext()) {
                rowIterator.next();
            }

            while (rowIterator.hasNext()) {
                Row row = rowIterator.next();
                Cell cell0 = row.getCell(0);
                Cell cell1 = row.getCell(1);

                String studentNo = getCellValueAsString(cell0);
                String studentName = getCellValueAsString(cell1);

                if (!studentNo.isEmpty() && !studentName.isEmpty()) {
                    rows.add(new String[]{studentNo, studentName});
                }
            }
        }

        return rows;
    }

    /**
     * 获取单元格值为字符串
     */
    private String getCellValueAsString(Cell cell) {
        if (cell == null) {
            return "";
        }

        switch (cell.getCellType()) {
            case STRING:
                return cell.getStringCellValue().trim();
            case NUMERIC:
                // 处理数字格式的学号
                double numVal = cell.getNumericCellValue();
                if (numVal == Math.floor(numVal) && !Double.isInfinite(numVal)) {
                    return String.valueOf((long) numVal);
                }
                return String.valueOf(numVal);
            case BOOLEAN:
                return String.valueOf(cell.getBooleanCellValue());
            case FORMULA:
                try {
                    return cell.getStringCellValue().trim();
                } catch (Exception e) {
                    return String.valueOf(cell.getNumericCellValue());
                }
            default:
                return "";
        }
    }

    /**
     * 解析 CSV 文件
     */
    private List<String[]> parseCsvFile(InputStream inputStream) throws IOException {
        List<String[]> rows = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream))) {
            String line;
            boolean isFirstLine = true;

            while ((line = reader.readLine()) != null) {
                if (isFirstLine) {
                    isFirstLine = false;
                    continue; // 跳过表头
                }

                String[] parts = line.split(",");
                if (parts.length >= 2) {
                    rows.add(new String[]{parts[0].trim(), parts[1].trim()});
                }
            }
        }

        return rows;
    }
}
