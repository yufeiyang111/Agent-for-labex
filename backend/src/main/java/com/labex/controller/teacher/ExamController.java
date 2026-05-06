package com.labex.controller.teacher;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.labex.common.PageResult;
import com.labex.common.Result;
import com.labex.entity.Exam;
import com.labex.entity.Paper;
import com.labex.entity.Teacher;
import com.labex.service.ExamService;
import com.labex.service.PaperService;
import com.labex.service.TeacherService;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/teacher/exam")
@PreAuthorize("hasRole('TEACHER')")
@Slf4j
public class ExamController {

    @Autowired
    private ExamService examService;
    @Autowired
    private PaperService paperService;
    @Autowired
    private TeacherService teacherService;

    @GetMapping("/papers")
    public Result<List<Paper>> getPapers() {
        Integer teacherId = getCurrentTeacherId();
        return Result.success(paperService.findByTeacherId(teacherId));
    }

    @GetMapping("/list")
    public Result<PageResult<Exam>> list(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "20") Integer pageSize,
            @RequestParam(required = false) String name) {
        Integer teacherId = getCurrentTeacherId();
        LambdaQueryWrapper<Exam> wrapper = new LambdaQueryWrapper<>();
        if (teacherId != null) {
            wrapper.eq(Exam::getTeacherId, teacherId);
        }
        if (name != null && !name.isEmpty()) {
            wrapper.like(Exam::getExamName, name);
        }
        wrapper.orderByDesc(Exam::getTime);

        Page<Exam> pageResult = examService.page(new Page<>(page, pageSize), wrapper);
        for (Exam exam : pageResult.getRecords()) {
            if (exam.getPaperId() != null) {
                Paper paper = paperService.getById(exam.getPaperId());
                if (paper != null) {
                    exam.setPaperName(paper.getName());
                    if (exam.getTotalScore() == null) {
                        exam.setTotalScore(paper.getTotalScore());
                    }
                }
            }
        }

        PageResult<Exam> data = new PageResult<>();
        data.setPageNum(page);
        data.setPageSize(pageSize);
        data.setTotal(pageResult.getTotal());
        data.setList(pageResult.getRecords());
        data.setTotalPages((int) Math.ceil((double) pageResult.getTotal() / pageSize));
        return Result.success(data);
    }

    @GetMapping("/all")
    public Result<List<Exam>> getAll() {
        return Result.success(examService.findByTeacherId(getCurrentTeacherId()));
    }

    @GetMapping("/{id}")
    public Result<Exam> getById(@PathVariable Integer id) {
        Exam exam = examService.getById(id);
        if (exam == null) {
            return Result.error("考试不存在");
        }
        if (exam.getPaperId() != null) {
            Paper paper = paperService.getById(exam.getPaperId());
            if (paper != null) {
                exam.setPaperName(paper.getName());
            }
        }
        return Result.success(exam);
    }

    @PostMapping
    public Result<Void> add(@Valid @RequestBody Exam exam) {
        Integer teacherId = getCurrentTeacherId();
        if (teacherId != null) {
            exam.setTeacherId(teacherId);
        }
        Result<Void> validate = validateExamPayload(exam);
        if (validate != null) {
            return validate;
        }
        if (exam.getState() == null) {
            exam.setState(1);
        }
        exam.setTime(exam.getTime() == null ? LocalDateTime.now() : exam.getTime());
        return examService.save(exam) ? Result.success("添加成功", null) : Result.error("添加失败");
    }

    @PutMapping("/{id}")
    public Result<Void> update(@PathVariable Integer id, @Valid @RequestBody Exam exam) {
        exam.setId(id);
        Result<Void> validate = validateExamPayload(exam);
        if (validate != null) {
            return validate;
        }
        return examService.updateById(exam) ? Result.success("修改成功", null) : Result.error("修改失败");
    }

    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Integer id) {
        return examService.removeById(id) ? Result.success("删除成功", null) : Result.error("删除失败");
    }

    private Result<Void> validateExamPayload(Exam exam) {
        if (exam.getPaperId() == null) {
            return Result.error("请选择试卷");
        }
        Paper paper = paperService.getById(exam.getPaperId());
        if (paper == null) {
            return Result.error("试卷不存在");
        }
        if (exam.getTime() != null && exam.getEndTime() != null && !exam.getEndTime().isAfter(exam.getTime())) {
            return Result.error("截止时间必须晚于开始时间");
        }
        exam.setTotalScore(paper.getTotalScore());
        return null;
    }

    private Integer getCurrentTeacherId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null) {
            return null;
        }
        Teacher teacher = teacherService.findByAccount(authentication.getName());
        return teacher == null ? null : teacher.getTeacherId();
    }
}
