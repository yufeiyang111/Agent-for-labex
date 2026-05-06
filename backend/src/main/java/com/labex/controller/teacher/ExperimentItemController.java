package com.labex.controller.teacher;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.labex.common.Result;
import com.labex.common.PageResult;
import com.labex.entity.ExperimentItem;
import com.labex.service.ExperimentItemService;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 教师-实验题目管理控制器
 */
@RestController
@RequestMapping("/teacher/experiment-item")
@PreAuthorize("hasRole('TEACHER')")
@Slf4j
public class ExperimentItemController {

    @Autowired
    private ExperimentItemService experimentItemService;

    /**
     * 根据实验ID查询题目列表
     */
    @GetMapping("/experiment/{experimentId}")
    public Result<List<ExperimentItem>> listByExperiment(@PathVariable Integer experimentId) {
        List<ExperimentItem> items = experimentItemService.list(
                new LambdaQueryWrapper<ExperimentItem>()
                        .eq(ExperimentItem::getExperimentId, experimentId)
                        .orderByAsc(ExperimentItem::getExperimentItemNo)
        );
        return Result.success(items);
    }

    /**
     * 分页查询题目
     */
    @GetMapping("/list")
    public Result<PageResult<ExperimentItem>> list(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "20") Integer pageSize,
            @RequestParam Integer experimentId) {

        log.debug("查询题目列表: page={}, pageSize={}, experimentId={}", page, pageSize, experimentId);

        LambdaQueryWrapper<ExperimentItem> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ExperimentItem::getExperimentId, experimentId)
                .orderByAsc(ExperimentItem::getExperimentItemNo);

        Page<ExperimentItem> p = experimentItemService.page(new Page<>(page, pageSize), wrapper);
        log.debug("查询到 {} 条记录", p.getTotal());

        PageResult<ExperimentItem> pageResult = new PageResult<>();
        pageResult.setPageNum(page);
        pageResult.setPageSize(pageSize);
        pageResult.setTotal(p.getTotal());
        pageResult.setList(p.getRecords());
        pageResult.setTotalPages((int) Math.ceil((double) p.getTotal() / pageSize));

        return Result.success(pageResult);
    }

    /**
     * 根据ID查询题目
     */
    @GetMapping("/{id}")
    public Result<ExperimentItem> getById(@PathVariable Integer id) {
        ExperimentItem item = experimentItemService.getById(id);
        if (item != null) {
            return Result.success(item);
        }
        return Result.error("题目不存在");
    }

    /**
     * 新增题目
     */
    @PostMapping
    public Result<Void> add(@Valid @RequestBody ExperimentItem item,
                            @RequestParam(required = false) Integer experimentId) {
        if (item.getExperimentId() == null && experimentId != null) {
            item.setExperimentId(experimentId);
        }
        if (item.getExperimentId() == null) {
            return Result.error("实验ID不能为空");
        }
        boolean success = experimentItemService.save(item);
        if (success) {
            log.info("新增实验题目: {}, 实验ID: {}", item.getExperimentItemName(), item.getExperimentId());
            return Result.success("添加成功", null);
        }
        return Result.error("添加失败");
    }

    /**
     * 更新题目
     */
    @PutMapping("/{id}")
    public Result<Void> update(@PathVariable Integer id, @Valid @RequestBody ExperimentItem item) {
        item.setExperimentItemId(id);
        boolean success = experimentItemService.updateById(item);
        if (success) {
            log.info("更新实验题目: {}", id);
            return Result.success("修改成功", null);
        }
        return Result.error("修改失败");
    }

    /**
     * 删除题目
     */
    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Integer id) {
        boolean success = experimentItemService.removeById(id);
        if (success) {
            log.info("删除实验题目: {}", id);
            return Result.success("删除成功", null);
        }
        return Result.error("删除失败");
    }

    /**
     * 批量删除题目
     */
    @DeleteMapping("/batch")
    public Result<Void> batchDelete(@RequestBody List<Integer> ids) {
        boolean success = experimentItemService.removeBatchByIds(ids);
        if (success) {
            log.info("批量删除实验题目: {}", ids);
            return Result.success("删除成功", null);
        }
        return Result.error("删除失败");
    }
}
