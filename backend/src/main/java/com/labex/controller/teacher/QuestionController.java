package com.labex.controller.teacher;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.labex.common.PageResult;
import com.labex.common.Result;
import com.labex.entity.Question;
import com.labex.entity.QuestionTestCase;
import com.labex.entity.Teacher;
import com.labex.service.QuestionService;
import com.labex.service.QuestionTestCaseService;
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

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/teacher/question")
@PreAuthorize("hasRole('TEACHER')")
@Slf4j
public class QuestionController {

    @Autowired
    private QuestionService questionService;

    @Autowired
    private QuestionTestCaseService questionTestCaseService;

    @Autowired
    private TeacherService teacherService;

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

    @GetMapping("/list")
    public Result<PageResult<Question>> list(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "20") Integer pageSize,
            @RequestParam(required = false) Integer type,
            @RequestParam(required = false) String keyword) {

        LambdaQueryWrapper<Question> wrapper = new LambdaQueryWrapper<>();
        if (type != null) {
            wrapper.eq(Question::getType, type);
        }
        if (keyword != null && !keyword.isEmpty()) {
            wrapper.like(Question::getQuestion, keyword);
        }
        wrapper.orderByDesc(Question::getId);

        Page<Question> p = questionService.page(new Page<>(page, pageSize), wrapper);
        fillQuestionMeta(p.getRecords());

        PageResult<Question> pageResult = new PageResult<>();
        pageResult.setPageNum(page);
        pageResult.setPageSize(pageSize);
        pageResult.setTotal(p.getTotal());
        pageResult.setList(p.getRecords());
        pageResult.setTotalPages((int) Math.ceil((double) p.getTotal() / pageSize));
        return Result.success(pageResult);
    }

    @GetMapping("/all")
    public Result<List<Question>> getAll() {
        List<Question> questions = questionService.list().stream()
                .sorted((a, b) -> b.getId() - a.getId())
                .toList();
        fillQuestionMeta(questions);
        return Result.success(questions);
    }

    @GetMapping("/{id}")
    public Result<Question> getById(@PathVariable Integer id) {
        Question question = questionService.getById(id);
        if (question != null) {
            fillQuestionMeta(List.of(question));
            return Result.success(question);
        }
        return Result.error("题目不存在");
    }

    @PostMapping
    public Result<Map<String, Object>> add(@Valid @RequestBody Question question) {
        Integer teacherId = getCurrentTeacherId();
        if (teacherId != null) {
            question.setTeacherId(teacherId);
        }
        if (question.getState() == null) {
            question.setState(1);
        }
        if (question.getScore() == null) {
            question.setScore(10);
        }
        boolean success = questionService.save(question);
        if (!success) {
            return Result.error("添加失败");
        }
        return Result.success("添加成功", Map.of("id", question.getId()));
    }

    /**
     * Create question and return created id directly.
     * This endpoint exists to avoid frontend mismatches when older responses don't include `data.id`.
     */
    @PostMapping("/create")
    public Result<Integer> create(@Valid @RequestBody Question question) {
        Integer teacherId = getCurrentTeacherId();
        if (teacherId != null) {
            question.setTeacherId(teacherId);
        }
        if (question.getState() == null) {
            question.setState(1);
        }
        if (question.getScore() == null) {
            question.setScore(10);
        }
        boolean success = questionService.save(question);
        if (!success) {
            return Result.error("create failed");
        }
        return Result.success("ok", question.getId());
    }

    @PostMapping("/seed-demo")
    public Result<List<Integer>> seedDemoQuestions() {
        Integer teacherId = getCurrentTeacherId();
        if (teacherId == null) {
            return Result.error("no teacher");
        }

        List<Integer> ids = new ArrayList<>();

        Question fill = new Question();
        fill.setTeacherId(teacherId);
        fill.setType(1);
        fill.setScore(10);
        fill.setState(1);
        fill.setQuestion("Fill blank: Java common output method is ________ .");
        fill.setAnswer("System.out.println");
        fill.setAnalysis("Most common output is System.out.println(...).");
        questionService.save(fill);
        ids.add(fill.getId());

        Question choice = new Question();
        choice.setTeacherId(teacherId);
        choice.setType(2);
        choice.setScore(10);
        choice.setState(1);
        choice.setQuestion("Choice: HTTP default port is?");
        choice.setOptions("{\"A\":\"21\",\"B\":\"80\",\"C\":\"443\",\"D\":\"3306\"}");
        choice.setAnswer("B");
        choice.setAnalysis("HTTP is 80, HTTPS is 443.");
        questionService.save(choice);
        ids.add(choice.getId());

        Question sa = new Question();
        sa.setTeacherId(teacherId);
        sa.setType(5);
        sa.setScore(20);
        sa.setState(1);
        sa.setQuestion("Short answer: explain encapsulation, inheritance, polymorphism.");
        sa.setAnswer("Encapsulation, inheritance, polymorphism.");
        sa.setAnalysis("Encapsulation hides details; inheritance reuses; polymorphism same interface different impl.");
        questionService.save(sa);
        ids.add(sa.getId());

        Question prog = new Question();
        prog.setTeacherId(teacherId);
        prog.setType(6);
        prog.setScore(40);
        prog.setState(1);
        prog.setQuestion("Programming: read integer n, print sum of 1..n.");
        prog.setOptions("{\"defaultLanguage\":\"c\"}");
        prog.setAnswer("");
        prog.setAnalysis("Loop or formula n*(n+1)/2.");
        questionService.save(prog);
        ids.add(prog.getId());

        List<QuestionTestCase> tcs = new ArrayList<>();
        QuestionTestCase tc1 = new QuestionTestCase();
        tc1.setInput("3\n");
        tc1.setExpectedOutput("6\n");
        tc1.setScoreWeight(1);
        tc1.setSortIndex(0);
        tcs.add(tc1);

        QuestionTestCase tc2 = new QuestionTestCase();
        tc2.setInput("100\n");
        tc2.setExpectedOutput("5050\n");
        tc2.setScoreWeight(1);
        tc2.setSortIndex(1);
        tcs.add(tc2);

        questionTestCaseService.saveBatchForQuestion(prog.getId(), tcs);

        return Result.success(ids);
    }

    @PutMapping("/{id}")
    public Result<Void> update(@PathVariable Integer id, @Valid @RequestBody Question question) {
        question.setId(id);
        return questionService.updateById(question) ? Result.success("修改成功", null) : Result.error("修改失败");
    }

    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Integer id) {
        questionTestCaseService.deleteByQuestionId(id);
        return questionService.removeById(id) ? Result.success("删除成功", null) : Result.error("删除失败");
    }

    @GetMapping("/{id}/test-cases")
    public Result<List<QuestionTestCase>> getTestCases(@PathVariable Integer id) {
        return Result.success(questionTestCaseService.findByQuestionId(id));
    }

    @PostMapping("/{id}/test-cases")
    public Result<Void> saveTestCases(@PathVariable Integer id, @RequestBody List<QuestionTestCase> testCases) {
        boolean success = questionTestCaseService.saveBatchForQuestion(id, testCases);
        return success ? Result.success("保存成功", null) : Result.error("保存失败");
    }

    @DeleteMapping("/test-case/{testCaseId}")
    public Result<Void> deleteTestCase(@PathVariable Integer testCaseId) {
        boolean success = questionTestCaseService.removeById(testCaseId);
        return success ? Result.success("删除成功", null) : Result.error("删除失败");
    }

    private String getTypeName(Integer type) {
        if (type == null) return "未知";
        return switch (type) {
            case 1 -> "填空";
            case 2 -> "单选";
            case 3 -> "多选";
            case 4 -> "判断";
            case 5 -> "简答";
            case 6 -> "编程";
            case 7 -> "综合";
            default -> "未知";
        };
    }

    private void fillQuestionMeta(List<Question> questions) {
        for (Question q : questions) {
            q.setTypeName(getTypeName(q.getType()));
            if (q.getTeacherId() != null) {
                Teacher teacher = teacherService.getById(q.getTeacherId());
                if (teacher != null) {
                    q.setTeacherName(teacher.getTeacherName());
                }
            }
        }
    }
}
