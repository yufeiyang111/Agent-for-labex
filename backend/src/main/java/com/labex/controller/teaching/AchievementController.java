package com.labex.controller.teaching;

import com.labex.common.Result;
import com.labex.entity.teaching.AchievementSnapshot;
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

    @GetMapping("/me")
    @PreAuthorize("hasRole('STUDENT')")
    public Result<StudentAchievementVO> myAchievement(@RequestParam Integer offeringId) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Integer studentId = Integer.parseInt(auth.getName());
        return Result.success(engine.calcForStudent(offeringId, studentId));
    }
}
