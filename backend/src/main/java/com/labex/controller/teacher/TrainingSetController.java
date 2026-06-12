package com.labex.controller.teacher;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.labex.common.PageResult;
import com.labex.common.Result;
import com.labex.entity.*;
import com.labex.service.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@RestController
@RequestMapping("/teacher/training-set")
@PreAuthorize("hasRole('TEACHER')")
public class TrainingSetController {

    @Autowired
    private TrainingSetService trainingSetService;

    @Autowired
    private TrainingSetQuestionService trainingSetQuestionService;

    @Autowired
    private QuestionService questionService;

    @Autowired
    private StudentTrainingService studentTrainingService;

    @Autowired
    private StudentTrainingQuestionService studentTrainingQuestionService;

    private Integer getTeacherId(Authentication auth) {
        return Integer.parseInt(auth.getName());
    }

    @GetMapping("/list")
    public Result<Page<TrainingSet>> list(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "20") Integer pageSize,
            @RequestParam(required = false) String keyword,
            Authentication auth) {
        Integer teacherId = getTeacherId(auth);
        LambdaQueryWrapper<TrainingSet> wrapper = new LambdaQueryWrapper<TrainingSet>()
                .eq(TrainingSet::getTeacherId, teacherId)
                .like(keyword != null && !keyword.isBlank(), TrainingSet::getName, keyword)
                .orderByDesc(TrainingSet::getCreateTime);
        return Result.success(trainingSetService.page(new Page<>(page, pageSize), wrapper));
    }

    @GetMapping("/all")
    public Result<List<TrainingSet>> all(Authentication auth) {
        Integer teacherId = getTeacherId(auth);
        List<TrainingSet> list = trainingSetService.lambdaQuery()
                .eq(TrainingSet::getTeacherId, teacherId)
                .orderByDesc(TrainingSet::getCreateTime)
                .list();
        return Result.success(list);
    }

    @GetMapping("/{id}")
    public Result<TrainingSet> get(@PathVariable Integer id) {
        TrainingSet ts = trainingSetService.getById(id);
        return ts != null ? Result.success(ts) : Result.error("训练集不存在");
    }

    @PostMapping
    public Result<TrainingSet> create(@RequestBody TrainingSet trainingSet, Authentication auth) {
        trainingSet.setTeacherId(getTeacherId(auth));
        trainingSet.setState(1);
        trainingSet.setCreateTime(LocalDateTime.now());
        trainingSetService.save(trainingSet);
        return Result.success(trainingSet);
    }

    @PutMapping("/{id}")
    public Result<Void> update(@PathVariable Integer id, @RequestBody TrainingSet trainingSet) {
        trainingSet.setTrainingSetId(id);
        trainingSetService.updateById(trainingSet);
        return Result.success(null);
    }

    @DeleteMapping("/{id}")
    @Transactional(rollbackFor = Exception.class)
    public Result<Void> delete(@PathVariable Integer id) {
        trainingSetQuestionService.removeQuestions(id);
        trainingSetService.removeById(id);
        return Result.success(null);
    }

    @GetMapping("/{id}/questions")
    public Result<List<Map<String, Object>>> getQuestions(@PathVariable Integer id) {
        List<TrainingSetQuestion> links = trainingSetQuestionService.findByTrainingSetId(id);
        List<Integer> questionIds = links.stream()
                .map(TrainingSetQuestion::getQuestionId)
                .collect(Collectors.toList());

        Map<Integer, Integer> scoreMap = links.stream()
                .collect(Collectors.toMap(TrainingSetQuestion::getQuestionId, l -> l.getScore() != null ? l.getScore() : 10));

        if (questionIds.isEmpty()) {
            return Result.success(Collections.emptyList());
        }

        List<Question> questions = questionService.listByIds(questionIds);
        Map<Integer, Question> qMap = questions.stream()
                .collect(Collectors.toMap(Question::getId, q -> q));

        List<Map<String, Object>> result = links.stream()
                .map(link -> {
                    Question q = qMap.get(link.getQuestionId());
                    Map<String, Object> item = new HashMap<>();
                    item.put("questionId", link.getQuestionId());
                    item.put("score", scoreMap.getOrDefault(link.getQuestionId(), 10));
                    item.put("sortIndex", link.getSortIndex());
                    if (q != null) {
                        item.put("question", q.getQuestion());
                        item.put("type", q.getType());
                        item.put("typeName", q.getTypeName());
                        item.put("answer", q.getAnswer());
                        item.put("analysis", q.getAnalysis());
                        item.put("options", q.getOptions());
                        item.put("isProgramming", q.getIsProgramming());
                        item.put("language", q.getLanguage());
                    }
                    return item;
                })
                .collect(Collectors.toList());

        return Result.success(result);
    }

    @PostMapping("/{id}/questions")
    public Result<Void> addQuestions(@PathVariable Integer id, @RequestBody List<Integer> questionIds) {
        trainingSetQuestionService.saveQuestions(id, questionIds);

        // 更新总分
        List<TrainingSetQuestion> all = trainingSetQuestionService.findByTrainingSetId(id);
        int total = all.stream().mapToInt(q -> q.getScore() != null ? q.getScore() : 10).sum();
        TrainingSet ts = trainingSetService.getById(id);
        if (ts != null) {
            ts.setTotalScore(total);
            trainingSetService.updateById(ts);
        }

        return Result.success(null);
    }

    @DeleteMapping("/{trainingSetId}/question/{questionId}")
    public Result<Void> removeQuestion(@PathVariable Integer trainingSetId, @PathVariable Integer questionId) {
        trainingSetQuestionService.removeQuestion(trainingSetId, questionId);

        // 更新总分
        List<TrainingSetQuestion> all = trainingSetQuestionService.findByTrainingSetId(trainingSetId);
        int total = all.stream().mapToInt(q -> q.getScore() != null ? q.getScore() : 10).sum();
        TrainingSet ts = trainingSetService.getById(trainingSetId);
        if (ts != null) {
            ts.setTotalScore(total);
            trainingSetService.updateById(ts);
        }

        return Result.success(null);
    }

    @GetMapping("/available-questions")
    public Result<PageResult<Question>> availableQuestions(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "20") Integer pageSize,
            @RequestParam(required = false) Integer type,
            @RequestParam(required = false) String keyword,
            Authentication auth) {
        LambdaQueryWrapper<Question> wrapper = new LambdaQueryWrapper<Question>()
                .eq(Question::getState, 1)
                .eq(type != null && type > 0, Question::getType, type)
                .like(keyword != null && !keyword.isBlank(), Question::getQuestion, keyword)
                .orderByDesc(Question::getId);

        Page<Question> p = questionService.page(new Page<>(page, pageSize), wrapper);
        PageResult<Question> pageResult = new PageResult<>();
        pageResult.setPageNum(page);
        pageResult.setPageSize(pageSize);
        pageResult.setTotal(p.getTotal());
        pageResult.setList(p.getRecords());
        pageResult.setTotalPages((int) Math.ceil((double) p.getTotal() / pageSize));
        return Result.success(pageResult);
    }

    @GetMapping("/{id}/student-records")
    public Result<List<Map<String, Object>>> studentRecords(@PathVariable Integer id) {
        List<StudentTraining> records = studentTrainingService.lambdaQuery()
                .eq(StudentTraining::getTrainingSetId, id)
                .orderByDesc(StudentTraining::getSubmitTime)
                .list();

        List<Map<String, Object>> result = records.stream().map(rec -> {
            Map<String, Object> item = new HashMap<>();
            item.put("id", rec.getId());
            item.put("studentId", rec.getStudentId());
            item.put("score", rec.getScore());
            item.put("totalScore", rec.getTotalScore());
            item.put("submitTime", rec.getSubmitTime());
            item.put("attemptCount", rec.getAttemptCount());

            // Get student answers for this attempt
            List<StudentTrainingQuestion> answers = studentTrainingQuestionService.lambdaQuery()
                    .eq(StudentTrainingQuestion::getAttemptId, rec.getId())
                    .list();
            long correctCount = answers.stream()
                    .filter(a -> a.getIsCorrect() != null && a.getIsCorrect() == 1)
                    .count();
            item.put("correctCount", correctCount);
            item.put("totalQuestions", answers.size());
            return item;
        }).collect(Collectors.toList());

        return Result.success(result);
    }

    @GetMapping("/{trainingSetId}/student/{studentId}/detail")
    public Result<List<Map<String, Object>>> studentDetail(
            @PathVariable Integer trainingSetId, @PathVariable Integer studentId,
            @RequestParam Integer attemptId) {
        List<StudentTrainingQuestion> answers = studentTrainingQuestionService.lambdaQuery()
                .eq(StudentTrainingQuestion::getAttemptId, attemptId)
                .eq(StudentTrainingQuestion::getTrainingSetId, trainingSetId)
                .eq(StudentTrainingQuestion::getStudentId, studentId)
                .list();

        List<Map<String, Object>> result = answers.stream().map(a -> {
            Map<String, Object> item = new HashMap<>();
            item.put("questionId", a.getQuestionId());
            item.put("myAnswer", a.getMyAnswer());
            item.put("score", a.getScore());
            item.put("isCorrect", a.getIsCorrect());

            Question q = questionService.getById(a.getQuestionId());
            if (q != null) {
                item.put("question", q.getQuestion());
                item.put("type", q.getType());
                item.put("typeName", q.getTypeName());
                item.put("answer", q.getAnswer());
                item.put("analysis", q.getAnalysis());
                item.put("options", q.getOptions());
            }
            return item;
        }).collect(Collectors.toList());

        return Result.success(result);
    }
}
