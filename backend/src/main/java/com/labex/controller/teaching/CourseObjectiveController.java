package com.labex.controller.teaching;

import com.labex.common.Result;
import com.labex.entity.teaching.CourseObjective;
import com.labex.entity.teaching.GraduationIndicator;
import com.labex.entity.teaching.ObjectiveSupport;
import com.labex.service.teaching.CourseObjectiveService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 课程目标控制器（CTL-S2）
 */
@RestController
@RequestMapping("/teacher/objective")
@PreAuthorize("hasRole('TEACHER') or hasRole('ADMIN')")
@Slf4j
public class CourseObjectiveController {

    @Autowired private CourseObjectiveService objectiveService;

    @GetMapping("/list")
    public Result<List<CourseObjective>> list(@RequestParam Integer courseId) {
        return Result.success(objectiveService.listByCourse(courseId));
    }

    @GetMapping("/supports")
    public Result<List<ObjectiveSupport>> supportsByCourse(@RequestParam Integer courseId) {
        return Result.success(objectiveService.listSupportsByCourse(courseId));
    }

    @PostMapping
    public Result<CourseObjective> create(@RequestBody CourseObjective obj) {
        return Result.success(objectiveService.createObjective(obj));
    }

    @PutMapping("/{id}")
    public Result<Boolean> update(@PathVariable Integer id, @RequestBody CourseObjective obj) {
        obj.setObjectiveId(id);
        return Result.success(objectiveService.updateById(obj));
    }

    @DeleteMapping("/{id}")
    public Result<Boolean> delete(@PathVariable Integer id) {
        return Result.success(objectiveService.removeById(id));
    }

    @PostMapping("/{id}/supports")
    public Result<Void> setSupports(@PathVariable Integer id, @RequestBody List<ObjectiveSupport> supports) {
        objectiveService.setSupports(id, supports);
        return Result.success();
    }

    @GetMapping("/{id}/indicators")
    public Result<List<GraduationIndicator>> getSupported(@PathVariable Integer id) {
        return Result.success(objectiveService.getSupportedIndicators(id));
    }
}
