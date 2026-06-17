package com.labex.controller.teaching;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.labex.common.PageResult;
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
            if (t != null) {
                return t.getTeacherId();
            }
        }
        return null;
    }

    @GetMapping("/list")
    public Result<?> list(@RequestParam(required = false) Integer courseId,
                          @RequestParam(defaultValue = "1") Integer pageNum,
                          @RequestParam(defaultValue = "20") Integer pageSize) {
        Integer teacherId = currentTeacherId();
        LambdaQueryWrapper<CourseOffering> wrapper = new LambdaQueryWrapper<>();
        if (teacherId != null) {
            wrapper.eq(CourseOffering::getTeacherId, teacherId);
        }
        if (courseId != null) {
            wrapper.eq(CourseOffering::getCourseId, courseId);
        }
        wrapper.orderByDesc(CourseOffering::getOfferingId);
        Page<CourseOffering> page = offeringService.page(new Page<>(pageNum, pageSize), wrapper);
        return Result.success(PageResult.success(page.getRecords(), pageNum, pageSize, page.getTotal()));
    }

    @GetMapping("/{id}")
    public Result<CourseOffering> detail(@PathVariable Integer id) {
        CourseOffering offering = offeringService.getById(id);
        if (offering == null) {
            return Result.error("Offering not found");
        }
        if (!ownedByCurrentTeacher(offering)) {
            return Result.error("No permission for this offering");
        }
        return Result.success(offering);
    }

    @PostMapping
    public Result<CourseOffering> create(@RequestBody CourseOffering body) {
        CourseOffering offering = offeringService.createOffering(
                body.getCourseId(),
                body.getClazzNo(),
                currentTeacherId(),
                body.getSemester());
        return Result.success("Created", offering);
    }

    @PutMapping("/{id}")
    public Result<Boolean> update(@PathVariable Integer id, @RequestBody CourseOffering body) {
        CourseOffering existing = offeringService.getById(id);
        if (existing == null) {
            return Result.error("Offering not found");
        }
        if (!ownedByCurrentTeacher(existing)) {
            return Result.error("No permission for this offering");
        }
        body.setOfferingId(id);
        body.setTeacherId(existing.getTeacherId());
        if (body.getClazzNo() == null || body.getClazzNo().isBlank()) {
            body.setClazzNo(existing.getClazzNo());
        }
        if (body.getStudentCount() == null) {
            body.setStudentCount(existing.getStudentCount());
        }
        return Result.success(offeringService.updateById(body));
    }

    @PutMapping("/{id}/status")
    public Result<CourseOffering> updateStatus(@PathVariable Integer id, @RequestParam String status) {
        return Result.success(offeringService.updateStatus(id, currentTeacherId(), status));
    }

    @PostMapping("/{id}/refresh-students")
    public Result<CourseOffering> refreshStudentCount(@PathVariable Integer id) {
        CourseOffering existing = offeringService.getById(id);
        if (existing == null) {
            return Result.error("Offering not found");
        }
        if (!ownedByCurrentTeacher(existing)) {
            return Result.error("No permission for this offering");
        }
        return Result.success(offeringService.refreshStudentCount(id));
    }

    /**
     * 复制开课到多个新班级，包含评分项配置
     */
    @PostMapping("/{id}/clone")
    public Result<List<CourseOffering>> cloneToClass(
            @PathVariable Integer id,
            @RequestBody List<String> clazzNos) {
        CourseOffering existing = offeringService.getById(id);
        if (existing == null) {
            return Result.error("Offering not found");
        }
        if (!ownedByCurrentTeacher(existing)) {
            return Result.error("No permission for this offering");
        }

        List<CourseOffering> created = new java.util.ArrayList<>();
        List<String> skipped = new java.util.ArrayList<>();
        for (String clazzNo : clazzNos) {
            // 跳过与源开课相同的班级
            if (clazzNo != null && clazzNo.equals(existing.getClazzNo())) {
                log.info("Skipping clone to same class: {}", clazzNo);
                skipped.add(clazzNo);
                continue;
            }
            try {
                CourseOffering newOffering = offeringService.cloneOffering(id, clazzNo);
                created.add(newOffering);
            } catch (RuntimeException e) {
                // 如果是已存在的错误，跳过而不是报错
                if (e.getMessage() != null && e.getMessage().contains("已存在")) {
                    log.info("Skipping existing class: {}", clazzNo);
                    skipped.add(clazzNo);
                    continue;
                }
                log.error("Failed to clone offering to clazz {}: {}", clazzNo, e.getMessage());
                return Result.error("复制到班级 " + clazzNo + " 失败: " + e.getMessage());
            }
        }
        if (created.isEmpty()) {
            String msg = skipped.isEmpty() ? "没有新班级需要添加" : "所选班级均已存在开课记录";
            return Result.success(msg, created);
        }
        return Result.success("已添加 " + created.size() + " 个班级", created);
    }

    @DeleteMapping("/{id}")
    public Result<Boolean> delete(@PathVariable Integer id) {
        CourseOffering existing = offeringService.getById(id);
        if (existing == null) {
            return Result.error("Offering not found");
        }
        if (!ownedByCurrentTeacher(existing)) {
            return Result.error("No permission for this offering");
        }
        return Result.success(offeringService.removeById(id));
    }

    private boolean ownedByCurrentTeacher(CourseOffering offering) {
        Integer teacherId = currentTeacherId();
        return teacherId == null || offering.getTeacherId() == null || teacherId.equals(offering.getTeacherId());
    }
}
