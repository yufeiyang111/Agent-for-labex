package com.labex.controller.teacher;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.labex.common.Result;
import com.labex.common.PageResult;
import com.labex.entity.Clazz;
import com.labex.entity.Student;
import com.labex.entity.Teacher;
import com.labex.service.ClazzService;
import com.labex.service.StudentService;
import com.labex.service.TeacherService;
import com.labex.util.CurrentUser;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 教师-班级管理控制器
 */
@RestController
@RequestMapping("/teacher/clazz")
@PreAuthorize("hasRole('TEACHER')")
@Slf4j
public class ClazzController {

    @Autowired
    private ClazzService clazzService;

    @Autowired
    private StudentService studentService;

    @Autowired
    private TeacherService teacherService;

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
     * 分页查询班级列表（只显示属于当前老师的班级）
     */
    @GetMapping("/list")
    public Result<PageResult<Clazz>> list(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "20") Integer pageSize,
            @RequestParam(required = false) String keyword) {

        Integer teacherId = getCurrentTeacherId();
        log.debug("查询班级列表: page={}, pageSize={}, keyword={}, teacherId={}", page, pageSize, keyword, teacherId);

        LambdaQueryWrapper<Clazz> wrapper = new LambdaQueryWrapper<>();

        // 只查询属于当前老师的班级
        if (teacherId != null) {
            wrapper.eq(Clazz::getTeacherId, teacherId);
        }

        if (keyword != null && !keyword.trim().isEmpty()) {
            wrapper.and(w -> w.like(Clazz::getMemo, keyword)
                    .or().like(Clazz::getNo, keyword));
        }

        Page<Clazz> p = clazzService.page(new Page<>(page, pageSize), wrapper);
        log.debug("查询到 {} 条记录", p.getTotal());

        PageResult<Clazz> pageResult = new PageResult<>();
        pageResult.setPageNum(page);
        pageResult.setPageSize(pageSize);
        pageResult.setTotal(p.getTotal());
        pageResult.setList(p.getRecords());
        pageResult.setTotalPages((int) Math.ceil((double) p.getTotal() / pageSize));

        return Result.success(pageResult);
    }

    /**
     * 查询所有班级（用于下拉框，只显示属于当前老师的班级）
     */
    @GetMapping("/all")
    public Result<List<Clazz>> getAll() {
        Integer teacherId = getCurrentTeacherId();
        LambdaQueryWrapper<Clazz> wrapper = new LambdaQueryWrapper<>();

        if (teacherId != null) {
            wrapper.eq(Clazz::getTeacherId, teacherId);
        }

        return Result.success(clazzService.list(wrapper));
    }

    /**
     * 根据编号查询班级
     */
    @GetMapping("/{no}")
    public Result<Clazz> getByNo(@PathVariable String no) {
        Clazz clazz = clazzService.getById(no);
        if (clazz != null) {
            // 验证班级是否属于当前老师
            Integer teacherId = getCurrentTeacherId();
            if (teacherId != null && !teacherId.equals(clazz.getTeacherId())) {
                return Result.error("无权访问该班级");
            }
            return Result.success(clazz);
        }
        return Result.error("班级不存在");
    }

    /**
     * 新增班级
     */
    @PostMapping
    public Result<Void> add(@Valid @RequestBody Clazz clazz) {
        Integer teacherId = getCurrentTeacherId();
        if (teacherId == null) {
            return Result.error("未登录");
        }

        log.info("收到新增班级请求: {}", clazz);
        log.info("班级编号: {}, 描述: {}, 状态: {}, teacherId: {}", clazz.getNo(), clazz.getMemo(), clazz.getState(), teacherId);

        // 检查班级是否已存在
        Clazz existing = clazzService.getById(clazz.getNo());
        if (existing != null) {
            log.warn("班级已存在: {}", clazz.getNo());
            return Result.error("班级编号已存在");
        }

        // 设置班级属于当前老师
        clazz.setTeacherId(teacherId);

        boolean success = clazzService.save(clazz);
        log.info("保存结果: {}", success);

        if (success) {
            log.info("新增班级成功: {}", clazz.getNo());
            return Result.success("添加成功", null);
        }
        log.error("新增班级失败: {}", clazz.getNo());
        return Result.error("添加失败");
    }

    /**
     * 更新班级
     */
    @PutMapping("/{no}")
    public Result<Void> update(@PathVariable String no, @Valid @RequestBody Clazz clazz) {
        // 验证班级是否属于当前老师
        Clazz existing = clazzService.getById(no);
        if (existing == null) {
            return Result.error("班级不存在");
        }

        Integer teacherId = getCurrentTeacherId();
        if (teacherId != null && !teacherId.equals(existing.getTeacherId())) {
            return Result.error("无权修改该班级");
        }

        clazz.setNo(no);
        clazz.setTeacherId(teacherId);
        boolean success = clazzService.updateById(clazz);
        if (success) {
            log.info("更新班级: {}", no);
            return Result.success("修改成功", null);
        }
        return Result.error("修改失败");
    }

    /**
     * 删除班级
     */
    @DeleteMapping("/{no}")
    public Result<Void> delete(@PathVariable String no) {
        // 验证班级是否属于当前老师
        Clazz existing = clazzService.getById(no);
        if (existing == null) {
            return Result.error("班级不存在");
        }

        Integer teacherId = getCurrentTeacherId();
        if (teacherId != null && !teacherId.equals(existing.getTeacherId())) {
            return Result.error("无权删除该班级");
        }

        // 检查是否有关联学生
        long studentCount = studentService.count(
                new LambdaQueryWrapper<Student>().eq(Student::getClazzNo, no)
        );
        if (studentCount > 0) {
            return Result.error("班级下有学生，无法删除");
        }

        boolean success = clazzService.removeById(no);
        if (success) {
            log.info("删除班级: {}", no);
            return Result.success("删除成功", null);
        }
        return Result.error("删除失败");
    }

    /**
     * 启用/禁用班级
     */
    @PutMapping("/{no}/state")
    public Result<Void> updateState(@PathVariable String no, @RequestParam Integer state) {
        Clazz existing = clazzService.getById(no);
        if (existing == null) {
            return Result.error("班级不存在");
        }

        // 验证班级是否属于当前老师
        Integer teacherId = getCurrentTeacherId();
        if (teacherId != null && !teacherId.equals(existing.getTeacherId())) {
            return Result.error("无权修改该班级");
        }

        existing.setState(state);
        boolean success = clazzService.updateById(existing);
        if (success) {
            log.info("修改班级状态: {}, state: {}", no, state);
            return Result.success("状态修改成功", null);
        }
        return Result.error("状态修改失败");
    }
}
