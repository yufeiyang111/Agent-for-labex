package com.labex.controller.teaching;

import com.labex.common.Result;
import com.labex.entity.teaching.ScoringItem;
import com.labex.entity.teaching.ScoringItemObjective;
import com.labex.service.teaching.ScoringItemService;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * 评分项控制器（CTL-S3）
 */
@RestController
@RequestMapping("/teacher/scoring-item")
@PreAuthorize("hasRole('TEACHER') or hasRole('ADMIN')")
@Slf4j
public class ScoringItemController {

    @Autowired private ScoringItemService scoringItemService;

    @GetMapping("/list")
    public Result<List<ScoringItem>> list(@RequestParam Integer offeringId) {
        return Result.success(scoringItemService.listByOffering(offeringId));
    }

    @GetMapping("/{id}/objectives")
    public Result<List<ScoringItemObjective>> objectives(@PathVariable Integer id) {
        return Result.success(scoringItemService.listObjectiveLinks(id));
    }

    @PostMapping
    public Result<ScoringItem> create(@RequestBody ScoringItemRequest req) {
        return Result.success(scoringItemService.createItem(req.getItem(), req.getObjectiveLinks()));
    }

    @PutMapping("/{id}")
    public Result<Map<String, Object>> update(@PathVariable Integer id, @RequestBody ScoringItemRequest req) {
        scoringItemService.updateItem(id, req.getItem(), req.getObjectiveLinks());
        return Result.success(Map.of("itemId", id));
    }

    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Integer id) {
        scoringItemService.deleteItem(id);
        return Result.success();
    }

    @GetMapping("/validate-weight")
    public Result<Map<String, Object>> validateWeight(@RequestParam Integer offeringId) {
        boolean ok = scoringItemService.validateWeightSum(offeringId);
        return Result.success(Map.of("valid", ok));
    }

    @GetMapping("/suggest")
    public Result<List<ScoringItem>> suggest(@RequestParam Integer offeringId) {
        return Result.success(scoringItemService.suggestFromExistingTasks(offeringId));
    }

    /** 批量保存（含建议批量持久化） */
    @PostMapping("/batch-save")
    public Result<Integer> batchSave(@RequestBody List<ScoringItemRequest> requests) {
        int n = 0;
        for (ScoringItemRequest req : requests) {
            scoringItemService.createItem(req.getItem(), req.getObjectiveLinks());
            n++;
        }
        return Result.success(n);
    }

    @Data
    public static class ScoringItemRequest {
        private ScoringItem item;
        private List<ScoringItemObjective> objectiveLinks;
    }
}
