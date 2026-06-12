package com.labex.controller.teaching;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.labex.common.Result;
import com.labex.entity.Student;
import com.labex.entity.teaching.CourseObjective;
import com.labex.entity.teaching.CourseOffering;
import com.labex.mapper.teaching.CourseObjectiveMapper;
import com.labex.mapper.teaching.CourseOfferingMapper;
import com.labex.service.StudentService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collections;
import java.util.List;

/**
 * 学生端教学闭环只读 API（CTL-S5）
 * 解决学生角色无法访问 /teacher/* 端点的问题。
 */
@RestController
@RequestMapping("/student/teaching")
@PreAuthorize("hasRole('STUDENT')")
@Slf4j
public class StudentTeachingController {

    @Autowired private CourseOfferingMapper offeringMapper;
    @Autowired private CourseObjectiveMapper objectiveMapper;
    @Autowired private StudentService studentService;

    private Integer currentStudentId() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        return auth != null ? Integer.parseInt(auth.getName()) : null;
    }

    /** 学生可见的开课列表（按自己班级过滤，排除 archived） */
    @GetMapping("/offering/list")
    public Result<List<CourseOffering>> myOfferings() {
        Student stu = studentService.getById(currentStudentId());
        if (stu == null || stu.getClazzNo() == null) {
            return Result.success(Collections.emptyList());
        }
        List<CourseOffering> offerings = offeringMapper.selectList(new LambdaQueryWrapper<CourseOffering>()
                .eq(CourseOffering::getClazzNo, stu.getClazzNo())
                .ne(CourseOffering::getStatus, "archived")
                .orderByDesc(CourseOffering::getSemester));
        return Result.success(offerings);
    }

    /** 查询某课程的课程目标列表（学生只读） */
    @GetMapping("/objective/list")
    public Result<List<CourseObjective>> objectives(@RequestParam Integer courseId) {
        if (courseId == null) {
            return Result.success(Collections.emptyList());
        }
        // 越权校验：学生只能看自己班级关联的课程
        Student stu = studentService.getById(currentStudentId());
        if (stu == null || stu.getClazzNo() == null) {
            return Result.error("学生信息不完整");
        }
        long owned = offeringMapper.selectCount(new LambdaQueryWrapper<CourseOffering>()
                .eq(CourseOffering::getCourseId, courseId)
                .eq(CourseOffering::getClazzNo, stu.getClazzNo()));
        if (owned == 0) {
            log.warn("Student {} attempted to read objectives of course {} not in own class {}",
                    currentStudentId(), courseId, stu.getClazzNo());
            return Result.success(Collections.emptyList());
        }
        List<CourseObjective> objectives = objectiveMapper.selectList(new LambdaQueryWrapper<CourseObjective>()
                .eq(CourseObjective::getCourseId, courseId)
                .orderByAsc(CourseObjective::getSortOrder)
                .orderByAsc(CourseObjective::getCode));
        return Result.success(objectives);
    }
}
