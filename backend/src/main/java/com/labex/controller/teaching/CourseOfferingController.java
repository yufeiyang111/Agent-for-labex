package com.labex.controller.teaching;

import com.labex.common.Result;
import com.labex.entity.Teacher;
import com.labex.entity.teaching.CourseOffering;
import com.labex.service.TeacherService;
import com.labex.service.teaching.CourseOfferingService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 开课管理控制器（CTL-S1）
 */
@RestController
@RequestMapping("/teacher/offering")
@PreAuthorize("hasRole('TEACHER') or hasRole('ADMIN')")
@Slf4j
public class CourseOfferingController {

    @Autowired private CourseOfferingService offeringService;
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
    public Result<List<CourseOffering>> list(@RequestParam(required = false) Integer courseId) {
        if (courseId != null) {
            return Result.success(offeringService.listByCourse(courseId));
        }
        return Result.success(offeringService.listByTeacher(currentTeacherId()));
    }

    @GetMapping("/{id}")
    public Result<CourseOffering> detail(@PathVariable Integer id) {
        CourseOffering o = offeringService.getById(id);
        return o != null ? Result.success(o) : Result.error("开课不存在");
    }

    @PostMapping
    public Result<CourseOffering> create(@RequestBody CourseOffering body) {
        Integer teacherId = body.getTeacherId() != null ? body.getTeacherId() : currentTeacherId();
        CourseOffering o = offeringService.createOffering(body.getCourseId(), body.getClazzNo(), teacherId, body.getSemester());
        return Result.success("创建成功", o);
    }

    @PutMapping("/{id}")
    public Result<Boolean> update(@PathVariable Integer id, @RequestBody CourseOffering body) {
        body.setOfferingId(id);
        return Result.success(offeringService.updateById(body));
    }

    @DeleteMapping("/{id}")
    public Result<Boolean> delete(@PathVariable Integer id) {
        return Result.success(offeringService.removeById(id));
    }
}
