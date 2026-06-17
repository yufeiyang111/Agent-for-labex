package com.labex.controller.teaching;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.labex.common.Result;
import com.labex.entity.Student;
import com.labex.entity.teaching.AchievementSnapshot;
import com.labex.entity.teaching.CourseOffering;
import com.labex.mapper.teaching.CourseOfferingMapper;
import com.labex.service.StudentService;
import com.labex.service.teaching.AchievementCalcEngine;
import com.labex.vo.teaching.OfferingAchievementVO;
import com.labex.vo.teaching.StudentAchievementVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 达成度控制器（CTL-S5）— 同时提供教师与学生端
 */
@RestController
@RequestMapping("/teaching/achievement")
@Slf4j
public class AchievementController {

    @Autowired private AchievementCalcEngine engine;
    @Autowired private CourseOfferingMapper offeringMapper;
    @Autowired private StudentService studentService;

    // ============ 教师端 ============

    @GetMapping("/offering")
    @PreAuthorize("hasRole('TEACHER') or hasRole('ADMIN')")
    public Result<OfferingAchievementVO> offering(@RequestParam Integer offeringId) {
        return Result.success(engine.calcForOffering(offeringId));
    }

    @GetMapping("/student")
    @PreAuthorize("hasRole('TEACHER') or hasRole('ADMIN')")
    public Result<StudentAchievementVO> student(@RequestParam Integer offeringId,
                                                 @RequestParam Integer studentId) {
        return Result.success(engine.calcForStudent(offeringId, studentId));
    }

    @PostMapping("/recalc")
    @PreAuthorize("hasRole('TEACHER') or hasRole('ADMIN')")
    public Result<OfferingAchievementVO> recalc(@RequestParam Integer offeringId) {
        return Result.success(engine.calcForOffering(offeringId));
    }

    @PostMapping("/snapshot")
    @PreAuthorize("hasRole('TEACHER') or hasRole('ADMIN')")
    public Result<Void> snapshot(@RequestParam Integer offeringId,
                                  @RequestParam(defaultValue = "manual") String reason) {
        engine.snapshot(offeringId, reason);
        return Result.success();
    }

    @GetMapping("/snapshots")
    @PreAuthorize("hasRole('TEACHER') or hasRole('ADMIN')")
    public Result<List<AchievementSnapshot>> snapshots(@RequestParam Integer offeringId) {
        return Result.success(engine.getSnapshots(offeringId));
    }

    // ============ 学生端 ============

    /**
     * 学生查看自己在某开课的达成度
     * 越权校验：学生班级必须等于开课班级
     */
    @GetMapping("/me")
    @PreAuthorize("hasRole('STUDENT')")
    public Result<StudentAchievementVO> myAchievement(@RequestParam Integer offeringId) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String account = auth.getName();  // 学号，如 "23201335"

        // 通过学号查询学生
        Student stu = studentService.findByStudentNo(account);
        if (stu == null) {
            return Result.error("学生信息不存在");
        }

        CourseOffering offering = offeringMapper.selectById(offeringId);
        if (offering == null) {
            return Result.error("开课不存在");
        }
        if (stu.getClazzNo() == null || !stu.getClazzNo().equals(offering.getClazzNo())) {
            log.warn("Student {} (clazz={}) tried to query offering {} (clazz={})",
                    account, stu.getClazzNo(), offeringId, offering.getClazzNo());
            return Result.error("您不在该开课的班级中");
        }

        return Result.success(engine.calcForStudent(offeringId, stu.getStudentId()));
    }
}
