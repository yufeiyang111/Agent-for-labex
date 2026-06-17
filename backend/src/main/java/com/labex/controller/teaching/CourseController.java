package com.labex.controller.teaching;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.labex.common.PageResult;
import com.labex.common.Result;
import com.labex.entity.Teacher;
import com.labex.entity.teaching.Course;
import com.labex.service.TeacherService;
import com.labex.service.teaching.CourseService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 课程管理控制器（CTL-S1）
 */
@RestController
@RequestMapping("/teacher/course")
@PreAuthorize("hasRole('TEACHER') or hasRole('ADMIN')")
@Slf4j
public class CourseController {

    @Autowired private CourseService courseService;
    @Autowired private TeacherService teacherService;

    private Integer currentTeacherId() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            Teacher t = teacherService.findByAccount(auth.getName());
            if (t != null) return t.getTeacherId();
        }
        return null;
    }

    @GetMapping("/list")
    public Result<?> list(@RequestParam(defaultValue = "1") Integer pageNum,
                          @RequestParam(defaultValue = "20") Integer pageSize) {
        Integer ownerId = currentTeacherId();
        LambdaQueryWrapper<Course> wrapper = new LambdaQueryWrapper<>();
        if (ownerId != null) {
            wrapper.eq(Course::getOwnerId, ownerId);
        }
        wrapper.orderByDesc(Course::getCourseId);
        Page<Course> page = courseService.page(new Page<>(pageNum, pageSize), wrapper);
        return Result.success(PageResult.success(page.getRecords(), pageNum, pageSize, page.getTotal()));
    }

    @GetMapping("/all")
    public Result<List<Course>> listAll() {
        return Result.success(courseService.list());
    }

    @GetMapping("/{id}")
    public Result<Course> detail(@PathVariable Integer id) {
        Course c = courseService.getById(id);
        return c != null ? Result.success(c) : Result.error("课程不存在");
    }

    @PostMapping
    public Result<Course> create(@RequestBody Course course) {
        Integer ownerId = currentTeacherId();
        Course saved = courseService.createCourse(course, ownerId);
        log.info("Course created: id={}, code={}, owner={}", saved.getCourseId(), saved.getCode(), ownerId);
        return Result.success("创建成功", saved);
    }

    @PutMapping("/{id}")
    public Result<Boolean> update(@PathVariable Integer id, @RequestBody Course course) {
        course.setCourseId(id);
        return Result.success(courseService.updateById(course));
    }

    @DeleteMapping("/{id}")
    public Result<Boolean> delete(@PathVariable Integer id) {
        return Result.success(courseService.removeById(id));
    }
}
