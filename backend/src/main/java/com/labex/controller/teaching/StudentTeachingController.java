package com.labex.controller.teaching;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.labex.common.Result;
import com.labex.entity.Student;
import com.labex.entity.StudentCourseEvaluation;
import com.labex.entity.teaching.CourseObjective;
import com.labex.entity.teaching.CourseOffering;
import com.labex.mapper.StudentCourseEvaluationMapper;
import com.labex.mapper.teaching.CourseObjectiveMapper;
import com.labex.mapper.teaching.CourseOfferingMapper;
import com.labex.security.JwtUtil;
import com.labex.service.StudentService;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;

/**
 * 学生端教学闭环只读 API（CTL-S5）
 * 解决学生角色无法访问 /teacher/* 端点的问题。
 */
@RestController
@RequestMapping("/student")
@PreAuthorize("hasRole('STUDENT')")
@Slf4j
public class StudentTeachingController {

    @Autowired private CourseOfferingMapper offeringMapper;
    @Autowired private CourseObjectiveMapper objectiveMapper;
    @Autowired private StudentService studentService;
    @Autowired private StudentCourseEvaluationMapper studentEvalMapper;
    @Autowired private JwtUtil jwtUtil;

    private Student currentStudent() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null) return null;

        // auth.getName() 返回的是学号（如 "23201335"），不是studentId
        String studentNo = auth.getName();
        log.debug("当前登录学生学号: {}", studentNo);

        // 通过学号查找学生
        Student stu = studentService.findByStudentNo(studentNo);
        if (stu != null) {
            log.debug("找到学生: id={}, name={}, clazzNo={}", stu.getStudentId(), stu.getStudentName(), stu.getClazzNo());
        } else {
            log.warn("未找到学号为 {} 的学生", studentNo);
        }
        return stu;
    }

    /** 学生可见的开课列表（按自己班级过滤，只排除草稿状态） */
    @GetMapping("/teaching/offering/list")
    public Result<List<CourseOffering>> myOfferings() {
        Student stu = currentStudent();
        if (stu == null) {
            log.warn("myOfferings: 学生信息不存在");
            return Result.success(Collections.emptyList());
        }
        if (stu.getClazzNo() == null) {
            log.warn("myOfferings: 学生{}的班级信息为空", stu.getStudentNo());
            return Result.success(Collections.emptyList());
        }

        log.info("查询学生{}的开课列表, clazzNo={}", stu.getStudentNo(), stu.getClazzNo());
        List<CourseOffering> offerings = offeringMapper.selectList(new LambdaQueryWrapper<CourseOffering>()
                .eq(CourseOffering::getClazzNo, stu.getClazzNo())
                .ne(CourseOffering::getStatus, "draft")
                .orderByDesc(CourseOffering::getSemester));
        log.info("查询到{}条开课记录", offerings.size());
        return Result.success(offerings);
    }

    /** 查询某课程的课程目标列表（学生只读） */
    @GetMapping("/teaching/objective/list")
    public Result<List<CourseObjective>> objectives(@RequestParam Integer courseId) {
        if (courseId == null) {
            return Result.success(Collections.emptyList());
        }
        // 越权校验：学生只能看自己班级关联的课程
        Student stu = currentStudent();
        if (stu == null || stu.getClazzNo() == null) {
            return Result.error("学生信息不完整");
        }
        long owned = offeringMapper.selectCount(new LambdaQueryWrapper<CourseOffering>()
                .eq(CourseOffering::getCourseId, courseId)
                .eq(CourseOffering::getClazzNo, stu.getClazzNo()));
        if (owned == 0) {
            log.warn("Student {} attempted to read objectives of course {} not in own class {}",
                    stu.getStudentId(), courseId, stu.getClazzNo());
            return Result.success(Collections.emptyList());
        }
        List<CourseObjective> objectives = objectiveMapper.selectList(new LambdaQueryWrapper<CourseObjective>()
                .eq(CourseObjective::getCourseId, courseId)
                .orderByAsc(CourseObjective::getSortOrder)
                .orderByAsc(CourseObjective::getCode));
        return Result.success(objectives);
    }

    /** 获取我的课程评价 */
    @GetMapping("/evaluation/my")
    public Result<StudentCourseEvaluation> getMyEvaluation(@RequestParam Integer offeringId) {
        Student stu = currentStudent();
        if (stu == null) {
            return Result.error("学生信息不存在");
        }

        // 验证学生是否属于该开课的班级
        if (stu.getClazzNo() == null) {
            return Result.error("学生信息不完整");
        }

        CourseOffering offering = offeringMapper.selectById(offeringId);
        if (offering == null || !stu.getClazzNo().equals(offering.getClazzNo())) {
            return Result.error("无权访问此开课");
        }

        StudentCourseEvaluation eval = studentEvalMapper.selectOne(
                new LambdaQueryWrapper<StudentCourseEvaluation>()
                        .eq(StudentCourseEvaluation::getOfferingId, offeringId)
                        .eq(StudentCourseEvaluation::getStudentId, stu.getStudentId())
        );

        return Result.success(eval);
    }

    /** 提交课程评价 */
    @PostMapping("/evaluation/submit")
    public Result<StudentCourseEvaluation> submitEvaluation(@RequestBody EvaluationSubmitRequest request) {
        Student stu = currentStudent();
        if (stu == null) {
            return Result.error("学生信息不存在");
        }

        // 验证学生是否属于该开课的班级
        if (stu.getClazzNo() == null) {
            return Result.error("学生信息不完整");
        }

        CourseOffering offering = offeringMapper.selectById(request.getOfferingId());
        if (offering == null || !stu.getClazzNo().equals(offering.getClazzNo())) {
            return Result.error("无权评价此开课");
        }

        // 检查是否已评价
        StudentCourseEvaluation existing = studentEvalMapper.selectOne(
                new LambdaQueryWrapper<StudentCourseEvaluation>()
                        .eq(StudentCourseEvaluation::getOfferingId, request.getOfferingId())
                        .eq(StudentCourseEvaluation::getStudentId, stu.getStudentId())
        );

        if (existing != null) {
            return Result.error("您已评价过此课程");
        }

        // 创建评价
        StudentCourseEvaluation eval = new StudentCourseEvaluation();
        eval.setOfferingId(request.getOfferingId());
        eval.setStudentId(stu.getStudentId());
        eval.setTeachingQuality(request.getTeachingQuality());
        eval.setCourseContent(request.getCourseContent());
        eval.setLearningResources(request.getLearningResources());
        eval.setAssessmentMethod(request.getAssessmentMethod());
        eval.setLearningEffect(request.getLearningEffect());
        eval.setOverallSatisfaction(request.getTeachingQuality()); // 使用教学质量作为总体满意度
        eval.setComment(request.getComment());
        eval.setSuggestion(request.getSuggestion());

        studentEvalMapper.insert(eval);

        log.info("学生{}评价了开课{}", stu.getStudentId(), request.getOfferingId());
        return Result.success(eval);
    }

    @Data
    public static class EvaluationSubmitRequest {
        private Integer offeringId;
        private Integer teachingQuality;
        private Integer courseContent;
        private Integer learningResources;
        private Integer assessmentMethod;
        private Integer learningEffect;
        private String comment;
        private String suggestion;
    }
}
