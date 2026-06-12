package com.labex.controller.teaching;

import com.labex.common.Result;
import com.labex.entity.teaching.GraduationIndicator;
import com.labex.entity.teaching.GraduationRequirement;
import com.labex.service.teaching.GraduationRequirementService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * 毕业要求控制器（CTL-S2）
 */
@RestController
@RequestMapping("/teacher/gr")
@PreAuthorize("hasRole('TEACHER') or hasRole('ADMIN')")
@Slf4j
public class GraduationRequirementController {

    @Autowired private GraduationRequirementService grService;

    @GetMapping("/list")
    public Result<List<GraduationRequirement>> list() {
        return Result.success(grService.listAll());
    }

    @GetMapping("/indicators")
    public Result<List<GraduationIndicator>> allIndicators() {
        return Result.success(grService.listAllIndicators());
    }

    @GetMapping("/{requirementId}/indicators")
    public Result<List<GraduationIndicator>> listIndicators(@PathVariable Integer requirementId) {
        return Result.success(grService.listIndicators(requirementId));
    }

    @PostMapping
    @SuppressWarnings("unchecked")
    public Result<GraduationRequirement> create(@RequestBody Map<String, Object> body) {
        GraduationRequirement gr = new GraduationRequirement();
        gr.setCode((String) body.get("code"));
        gr.setTitle((String) body.get("title"));
        gr.setDescription((String) body.get("description"));
        gr.setMajor((String) body.get("major"));
        List<GraduationIndicator> indicators = null;
        Object inds = body.get("indicators");
        if (inds instanceof List<?> list) {
            indicators = new java.util.ArrayList<>();
            for (Object o : list) {
                if (o instanceof Map<?, ?> m) {
                    GraduationIndicator ind = new GraduationIndicator();
                    ind.setCode((String) m.get("code"));
                    ind.setDescription((String) m.get("description"));
                    indicators.add(ind);
                }
            }
        }
        return Result.success(grService.createWithIndicators(gr, indicators));
    }

    @PutMapping("/{id}")
    public Result<Boolean> update(@PathVariable Integer id, @RequestBody GraduationRequirement gr) {
        gr.setRequirementId(id);
        return Result.success(grService.updateById(gr));
    }

    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Integer id) {
        grService.deleteRequirement(id);
        return Result.success();
    }

    @PostMapping("/{requirementId}/indicator")
    public Result<GraduationIndicator> addIndicator(@PathVariable Integer requirementId,
                                                     @RequestBody GraduationIndicator indicator) {
        return Result.success(grService.addIndicator(requirementId, indicator));
    }

    @DeleteMapping("/indicator/{indicatorId}")
    public Result<Void> deleteIndicator(@PathVariable Integer indicatorId) {
        grService.deleteIndicator(indicatorId);
        return Result.success();
    }
}
