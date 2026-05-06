package com.labex.controller.teacher;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.labex.common.PageResult;
import com.labex.common.Result;
import com.labex.entity.Paper;
import com.labex.entity.PaperQuestion;
import com.labex.entity.Question;
import com.labex.entity.Teacher;
import com.labex.service.PaperQuestionService;
import com.labex.service.PaperService;
import com.labex.service.QuestionService;
import com.labex.service.TeacherService;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

/**
 * 教师-试卷管理控制器
 */
@RestController
@RequestMapping("/teacher/paper")
@PreAuthorize("hasRole('TEACHER')")
@Slf4j
public class PaperController {

    @Autowired
    private PaperService paperService;

    @Autowired
    private PaperQuestionService paperQuestionService;

    @Autowired
    private QuestionService questionService;

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

    /**
     * 生成下一个试卷编号，避免 t_paper.no 非空约束报错。
     */
    private Integer nextPaperNo() {
        Paper latest = paperService.lambdaQuery()
                .select(Paper::getNo)
                .orderByDesc(Paper::getNo)
                .last("LIMIT 1")
                .one();
        if (latest == null || latest.getNo() == null) {
            return 1001;
        }
        if (latest.getNo() >= Integer.MAX_VALUE - 1) {
            return (int) (System.currentTimeMillis() / 1000);
        }
        return latest.getNo() + 1;
    }

    /**
     * 分页查询试卷列表
     */
    @GetMapping("/list")
    public Result<PageResult<Paper>> list(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "20") Integer pageSize,
            @RequestParam(required = false) String name) {

        Integer teacherId = getCurrentTeacherId();
        LambdaQueryWrapper<Paper> wrapper = new LambdaQueryWrapper<>();

        if (teacherId != null) {
            wrapper.eq(Paper::getTeacherId, teacherId);
        }

        if (name != null && !name.isEmpty()) {
            wrapper.like(Paper::getName, name);
        }

        wrapper.orderByDesc(Paper::getTime);
        Page<Paper> p = paperService.page(new Page<>(page, pageSize), wrapper);

        PageResult<Paper> pageResult = new PageResult<>();
        pageResult.setPageNum(page);
        pageResult.setPageSize(pageSize);
        pageResult.setTotal(p.getTotal());
        pageResult.setList(p.getRecords());
        pageResult.setTotalPages((int) Math.ceil((double) p.getTotal() / pageSize));

        return Result.success(pageResult);
    }

    /**
     * 查询所有试卷
     */
    @GetMapping("/all")
    public Result<List<Paper>> getAll() {
        Integer teacherId = getCurrentTeacherId();
        return Result.success(paperService.findByTeacherId(teacherId));
    }

    /**
     * 根据ID查询试卷
     */
    @GetMapping("/{id}")
    public Result<Paper> getById(@PathVariable Integer id) {
        Paper paper = paperService.getById(id);
        return paper != null ? Result.success(paper) : Result.error("试卷不存在");
    }

    /**
     * 获取试卷题目列表
     */
    @GetMapping("/{id}/questions")
    public Result<List<Question>> getQuestions(@PathVariable Integer id) {
        List<PaperQuestion> links = paperQuestionService.findByPaperId(id);
        List<Question> questions = links.stream()
                .map(link -> questionService.getById(link.getQuestionId()))
                .toList();
        return Result.success(questions);
    }

    /**
     * 新增试卷
     */
    @PostMapping
    public Result<Void> add(@Valid @RequestBody Paper paper) {
        Integer teacherId = getCurrentTeacherId();
        if (teacherId != null) {
            paper.setTeacherId(teacherId);
        }
        if (paper.getNo() == null) {
            paper.setNo(nextPaperNo());
        }
        if (paper.getState() == null) {
            paper.setState(1);
        }
        if (paper.getQuestionCount() == null) {
            paper.setQuestionCount(0);
        }
        if (paper.getTotalScore() == null) {
            paper.setTotalScore(0);
        }
        paper.setTime(paper.getTime() != null ? paper.getTime() : LocalDateTime.now());

        boolean success = paperService.save(paper);
        return success ? Result.success("添加成功", null) : Result.error("添加失败");
    }

    /**
     * 更新试卷
     */
    @PutMapping("/{id}")
    public Result<Void> update(@PathVariable Integer id, @Valid @RequestBody Paper paper) {
        paper.setId(id);
        return paperService.updateById(paper) ? Result.success("修改成功", null) : Result.error("修改失败");
    }

    /**
     * 删除试卷
     */
    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Integer id) {
        paperQuestionService.deleteByPaperId(id);
        return paperService.removeById(id) ? Result.success("删除成功", null) : Result.error("删除失败");
    }

    /**
     * 配置试卷题目
     */
    @PostMapping("/{id}/questions")
    public Result<Void> addQuestions(@PathVariable Integer id, @RequestBody Map<String, List<Integer>> body) {
        List<Integer> questionIds = body.get("questionIds");
        if (questionIds == null || questionIds.isEmpty()) {
            return Result.error("请选择题目");
        }

        // 先删除旧关联
        paperQuestionService.deleteByPaperId(id);

        // 添加新关联
        int sort = 1;
        int totalScore = 0;
        for (Integer questionId : questionIds) {
            Question question = questionService.getById(questionId);
            PaperQuestion link = new PaperQuestion();
            link.setPaperId(id);
            link.setQuestionId(questionId);
            link.setSort(sort++);
            link.setScore(question != null ? (question.getScore() != null ? question.getScore() : 10) : 10);
            paperQuestionService.save(link);
            totalScore += link.getScore();
        }

        // 回写试卷汇总
        Paper paper = paperService.getById(id);
        if (paper != null) {
            paper.setQuestionCount(questionIds.size());
            paper.setTotalScore(totalScore);
            paperService.updateById(paper);
        }

        return Result.success("添加成功", null);
    }
}

