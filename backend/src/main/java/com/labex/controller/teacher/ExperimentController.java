package com.labex.controller.teacher;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.labex.common.Result;
import com.labex.common.PageResult;
import com.labex.entity.Clazz;
import com.labex.entity.Experiment;
import com.labex.entity.Teacher;
import com.labex.service.ClazzService;
import com.labex.service.ExperimentService;
import com.labex.service.TeacherService;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 教师-实验管理控制器
 */
@RestController
@RequestMapping("/teacher/experiment")
@PreAuthorize("hasRole('TEACHER')")
@Slf4j
public class ExperimentController {

    @Autowired
    private ExperimentService experimentService;

    @Autowired
    private TeacherService teacherService;

    /**
     * 获取当前登录的教师ID
     */
    private Integer getCurrentTeacherId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null) {
            Teacher teacher = teacherService.findByAccount(authentication.getName());
            if (teacher != null) {
                return teacher.getTeacherId();
            }
        }
        return null;
    }

    /**
     * 分页查询实验列表（仅当前教师的）
     */
    @GetMapping("/list")
    public Result<PageResult<Experiment>> list(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "20") Integer pageSize,
            @RequestParam(required = false) Integer state) {

        Integer teacherId = getCurrentTeacherId();
        log.debug("查询实验列表: page={}, pageSize={}, state={}, teacherId={}", page, pageSize, state, teacherId);

        LambdaQueryWrapper<Experiment> wrapper = new LambdaQueryWrapper<>();

        if (teacherId != null) {
            wrapper.eq(Experiment::getTeacherId, teacherId);
        }

        if (state != null) {
            wrapper.eq(Experiment::getState, state);
        }
        wrapper.orderByDesc(Experiment::getExperimentNo);

        Page<Experiment> p = experimentService.page(new Page<>(page, pageSize), wrapper);
        log.debug("查询到 {} 条记录", p.getTotal());

        PageResult<Experiment> pageResult = new PageResult<>();
        pageResult.setPageNum(page);
        pageResult.setPageSize(pageSize);
        pageResult.setTotal(p.getTotal());
        pageResult.setList(p.getRecords());
        pageResult.setTotalPages((int) Math.ceil((double) p.getTotal() / pageSize));

        return Result.success(pageResult);
    }

    /**
     * 查询所有启用的实验（仅当前教师的）
     */
    @GetMapping("/enabled")
    public Result<List<Experiment>> getEnabledExperiments() {
        Integer teacherId = getCurrentTeacherId();
        LambdaQueryWrapper<Experiment> wrapper = new LambdaQueryWrapper<Experiment>()
                .eq(Experiment::getState, 1);
        if (teacherId != null) {
            wrapper.eq(Experiment::getTeacherId, teacherId);
        }
        List<Experiment> experiments = experimentService.list(wrapper.orderByDesc(Experiment::getExperimentNo));
        return Result.success(experiments);
    }

    /**
     * 根据ID查询实验
     */
    @GetMapping("/{id}")
    public Result<Experiment> getById(@PathVariable Integer id) {
        Experiment experiment = experimentService.getById(id);
        if (experiment != null) {
            return Result.success(experiment);
        }
        return Result.error("实验不存在");
    }

    /**
     * 新增实验（自动关联当前教师）
     */
    @PostMapping
    public Result<Void> add(@Valid @RequestBody Experiment experiment) {
        Integer teacherId = getCurrentTeacherId();
        if (teacherId != null) {
            experiment.setTeacherId(teacherId);
        }
        boolean success = experimentService.save(experiment);
        if (success) {
            log.info("新增实验: {}, 教师ID: {}", experiment.getExperimentName(), teacherId);
            return Result.success("添加成功", null);
        }
        return Result.error("添加失败");
    }

    /**
     * 更新实验
     */
    @PutMapping("/{id}")
    public Result<Void> update(@PathVariable Integer id, @Valid @RequestBody Experiment experiment) {
        experiment.setExperimentId(id);
        boolean success = experimentService.updateById(experiment);
        if (success) {
            log.info("更新实验: {}", id);
            return Result.success("修改成功", null);
        }
        return Result.error("修改失败");
    }

    /**
     * 删除实验
     */
    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Integer id) {
        boolean success = experimentService.removeById(id);
        if (success) {
            log.info("删除实验: {}", id);
            return Result.success("删除成功", null);
        }
        return Result.error("删除失败");
    }

    /**
     * 启用/禁用实验
     */
    @PutMapping("/{id}/state")
    public Result<Void> updateState(@PathVariable Integer id, @RequestParam Integer state) {
        Experiment experiment = experimentService.getById(id);
        if (experiment == null) {
            return Result.error("实验不存在");
        }
        experiment.setState(state);
        boolean success = experimentService.updateById(experiment);
        if (success) {
            log.info("修改实验状态: {}, state: {}", id, state);
            return Result.success("状态修改成功", null);
        }
        return Result.error("状态修改失败");
    }
}
