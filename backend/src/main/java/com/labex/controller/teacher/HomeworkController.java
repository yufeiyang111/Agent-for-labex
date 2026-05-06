package com.labex.controller.teacher;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.labex.common.Result;
import com.labex.common.PageResult;
import com.labex.entity.Homework;
import com.labex.entity.HomeworkQuestion;
import com.labex.entity.Question;
import com.labex.entity.StudentHomework;
import com.labex.entity.StudentHomeworkQuestion;
import com.labex.entity.Teacher;
import com.labex.service.HomeworkQuestionService;
import com.labex.service.HomeworkService;
import com.labex.service.QuestionService;
import com.labex.service.StudentHomeworkQuestionService;
import com.labex.service.StudentHomeworkService;
import com.labex.service.TeacherService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * 教师-作业管理控制器
 */
@RestController
@RequestMapping("/teacher/homework")
@PreAuthorize("hasRole('TEACHER')")
@Slf4j
public class HomeworkController {

    @Autowired
    private HomeworkService homeworkService;

    @Autowired
    private HomeworkQuestionService homeworkQuestionService;

    @Autowired
    private QuestionService questionService;

    @Autowired
    private StudentHomeworkService studentHomeworkService;

    @Autowired
    private StudentHomeworkQuestionService studentHomeworkQuestionService;

    @Autowired
    private TeacherService teacherService;

    private final String uploadPath = System.getProperty("user.dir") + "/uploads/";

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
     * 分页查询作业列表
     */
    @GetMapping("/list")
    public Result<PageResult<Homework>> list(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "20") Integer pageSize,
            @RequestParam(required = false) String name) {

        Integer teacherId = getCurrentTeacherId();
        LambdaQueryWrapper<Homework> wrapper = new LambdaQueryWrapper<>();

        if (teacherId != null) {
            wrapper.eq(Homework::getTeacherId, teacherId);
        }

        if (name != null && !name.isEmpty()) {
            wrapper.like(Homework::getHomeworkName, name);
        }

        wrapper.orderByDesc(Homework::getCreateTime);
        Page<Homework> p = homeworkService.page(new Page<>(page, pageSize), wrapper);

        PageResult<Homework> pageResult = new PageResult<>();
        pageResult.setPageNum(page);
        pageResult.setPageSize(pageSize);
        pageResult.setTotal(p.getTotal());
        pageResult.setList(p.getRecords());
        pageResult.setTotalPages((int) Math.ceil((double) p.getTotal() / pageSize));

        return Result.success(pageResult);
    }

    /**
     * 查询所有作业
     */
    @GetMapping("/all")
    public Result<List<Homework>> getAll() {
        Integer teacherId = getCurrentTeacherId();
        return Result.success(homeworkService.findByTeacherId(teacherId));
    }

    /**
     * 根据ID查询作业
     */
    @GetMapping("/{id}")
    public Result<Homework> getById(@PathVariable Integer id) {
        Homework homework = homeworkService.getById(id);
        return homework != null ? Result.success(homework) : Result.error("作业不存在");
    }

    /**
     * 新增作业
     */
    @PostMapping
    public Result<Void> add(@Valid @RequestBody Homework homework) {
        Integer teacherId = getCurrentTeacherId();
        if (teacherId != null) {
            homework.setTeacherId(teacherId);
        }
        if (homework.getState() == null) {
            homework.setState(1);
        }
        if (homework.getCreateTime() == null) {
            homework.setCreateTime(LocalDateTime.now());
        }
        boolean success = homeworkService.save(homework);
        return success ? Result.success("添加成功", null) : Result.error("添加失败");
    }

    /**
     * 更新作业
     */
    @PutMapping("/{id}")
    public Result<Void> update(@PathVariable Integer id, @Valid @RequestBody Homework homework) {
        homework.setHomeworkId(id);
        return homeworkService.updateById(homework) ? Result.success("修改成功", null) : Result.error("修改失败");
    }

    /**
     * 删除作业
     */
    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Integer id) {
        return homeworkService.removeById(id) ? Result.success("删除成功", null) : Result.error("删除失败");
    }

    /**
     * 上传作业附件
     */
    @PostMapping("/upload")
    public Result<String> uploadFile(@RequestParam("file") MultipartFile file) {
        if (file.isEmpty()) {
            return Result.error("文件为空");
        }

        File dir = new File(uploadPath);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        String originalFilename = file.getOriginalFilename();
        String suffix = originalFilename.substring(originalFilename.lastIndexOf('.'));
        String filename = UUID.randomUUID() + suffix;

        try {
            File dest = new File(uploadPath + filename);
            file.transferTo(dest);
            log.info("作业附件上传成功: {}", filename);
            return Result.success("上传成功", filename);
        } catch (IOException e) {
            log.error("文件上传失败", e);
            return Result.error("上传失败");
        }
    }

    /**
     * 下载作业附件
     */
    @GetMapping("/download/{id}")
    public void downloadFile(@PathVariable Integer id, HttpServletResponse response) {
        Homework homework = homeworkService.getById(id);
        if (homework == null || homework.getFilePath() == null) {
            writeError(response, "作业不存在");
            return;
        }

        File file = new File(uploadPath + homework.getFilePath());
        if (!file.exists()) {
            writeError(response, "文件不存在");
            return;
        }

        try {
            String fileName = URLEncoder.encode(homework.getHomeworkName(), StandardCharsets.UTF_8) + "." + 
                    homework.getFilePath().substring(homework.getFilePath().lastIndexOf('.') + 1);
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment;filename=" + fileName);
            response.setContentLengthLong(file.length());

            try (BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));
                 java.io.OutputStream out = response.getOutputStream()) {
                byte[] buffer = new byte[4096];
                int len;
                while ((len = bis.read(buffer)) != -1) {
                    out.write(buffer, 0, len);
                }
                out.flush();
            }
        } catch (IOException e) {
            log.error("文件下载失败", e);
            writeError(response, "下载失败");
        }
    }

    /**
     * 查看作业的所有提交
     */
    @GetMapping("/{id}/submissions")
    public Result<List<StudentHomework>> getSubmissions(@PathVariable Integer id) {
        List<StudentHomework> submissions = studentHomeworkService.findByHomeworkId(id);
        return Result.success(submissions);
    }

    /**
     * 获取作业的题目列表
     */
    @GetMapping("/{id}/questions")
    public Result<List<Map<String, Object>>> getHomeworkQuestions(@PathVariable Integer id) {
        List<HomeworkQuestion> hqs = homeworkQuestionService.findByHomeworkId(id);
        List<Map<String, Object>> questions = new java.util.ArrayList<>();
        for (HomeworkQuestion hq : hqs) {
            Question q = questionService.getById(hq.getQuestionId());
            if (q != null) {
                Map<String, Object> qInfo = new java.util.HashMap<>();
                qInfo.put("id", q.getId());
                qInfo.put("type", q.getType());
                qInfo.put("typeName", getTypeName(q.getType()));
                qInfo.put("question", q.getQuestion());
                qInfo.put("score", hq.getScore());
                qInfo.put("answer", q.getAnswer());
                qInfo.put("options", q.getOptions());
                questions.add(qInfo);
            }
        }
        return Result.success(questions);
    }

    /**
     * 添加题目到作业
     */
    @PostMapping("/{id}/questions")
    public Result<Void> addQuestionsToHomework(@PathVariable Integer id, @RequestBody List<Integer> questionIds) {
        homeworkQuestionService.saveQuestions(id, questionIds);
        return Result.success("添加成功", null);
    }

    /**
     * 删除作业中的题目
     */
    @DeleteMapping("/{homeworkId}/question/{questionId}")
    public Result<Void> removeQuestionFromHomework(
            @PathVariable Integer homeworkId,
            @PathVariable Integer questionId) {
        homeworkQuestionService.removeQuestion(homeworkId, questionId);
        return Result.success("删除成功", null);
    }

    /**
     * 获取所有可用题目（用于添加）
     */
    @GetMapping("/available-questions")
    public Result<List<Question>> getAvailableQuestions(
            @RequestParam(required = false) Integer type) {
        Integer teacherId = getCurrentTeacherId();
        List<Question> questions = questionService.findByTeacherId(teacherId);
        if (type != null) {
            questions = questions.stream().filter(q -> q.getType().equals(type)).toList();
        }
        questions.forEach(q -> q.setTypeName(getTypeName(q.getType())));
        return Result.success(questions);
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
            default -> "其他";
        };
    }

    /**
     * 批改作业（评分）
     */
    @PutMapping("/submission/{id}")
    public Result<Void> scoreHomework(@PathVariable Integer id, @RequestBody StudentHomework submission) {
        submission.setId(id);
        return studentHomeworkService.updateById(submission) 
                ? Result.success("评分成功", null) : Result.error("评分失败");
    }

    /**
     * 下载学生提交的作业
     */
    @GetMapping("/{homeworkId}/student/{studentId}/answers")
    public Result<List<Map<String, Object>>> getStudentHomeworkAnswers(
            @PathVariable Integer homeworkId,
            @PathVariable Integer studentId) {
        List<HomeworkQuestion> links = homeworkQuestionService.findByHomeworkId(homeworkId);
        List<StudentHomeworkQuestion> studentAnswers = studentHomeworkQuestionService
                .findByHomeworkAndStudent(homeworkId, studentId);
        Map<Integer, StudentHomeworkQuestion> answerMap = new HashMap<>();
        for (StudentHomeworkQuestion answer : studentAnswers) {
            answerMap.put(answer.getQuestionId(), answer);
        }

        List<Map<String, Object>> result = new ArrayList<>();
        for (HomeworkQuestion link : links) {
            Question q = questionService.getById(link.getQuestionId());
            if (q == null) {
                continue;
            }
            StudentHomeworkQuestion sq = answerMap.get(q.getId());
            Map<String, Object> item = new HashMap<>();
            item.put("questionId", q.getId());
            item.put("question", q.getQuestion());
            item.put("type", q.getType());
            item.put("typeName", getTypeName(q.getType()));
            item.put("maxScore", link.getScore() != null ? link.getScore() : q.getScore());
            item.put("myAnswer", sq != null ? sq.getMyAnswer() : null);
            item.put("score", sq != null ? sq.getScore() : null);
            item.put("graded", sq != null ? sq.getGraded() : null);
            item.put("isCorrect", sq != null ? sq.getIsCorrect() : null);
            result.add(item);
        }
        return Result.success(result);
    }

    @PutMapping("/{homeworkId}/student/{studentId}/question/{questionId}/score")
    public Result<Void> scoreStudentQuestion(
            @PathVariable Integer homeworkId,
            @PathVariable Integer studentId,
            @PathVariable Integer questionId,
            @RequestParam Integer score) {
        StudentHomeworkQuestion sq = studentHomeworkQuestionService
                .findByHomeworkStudentQuestion(homeworkId, studentId, questionId);
        if (sq == null) {
            return Result.error("学生答案不存在");
        }
        sq.setScore(score);
        sq.setGraded(true);
        sq.setIsCorrect(score > 0 ? 1 : 0);
        studentHomeworkQuestionService.updateById(sq);

        List<StudentHomeworkQuestion> all = studentHomeworkQuestionService
                .findByHomeworkAndStudent(homeworkId, studentId);
        int total = 0;
        boolean pending = false;
        for (StudentHomeworkQuestion item : all) {
            if (Boolean.FALSE.equals(item.getGraded())) {
                pending = true;
            }
            if (item.getScore() != null) {
                total += item.getScore();
            }
        }

        StudentHomework submission = studentHomeworkService.findByStudentAndHomework(studentId, homeworkId);
        if (submission != null) {
            submission.setScore(total);
            submission.setRemark(pending ? "部分批改" : "已完成批改");
            studentHomeworkService.updateById(submission);
        }
        return Result.success("评分成功", null);
    }

    @GetMapping("/submission/download/{id}")
    public void downloadSubmission(@PathVariable Integer id, HttpServletResponse response) {
        StudentHomework submission = studentHomeworkService.getById(id);
        if (submission == null || submission.getFilePath() == null) {
            writeError(response, "提交记录不存在");
            return;
        }

        File file = new File(uploadPath + submission.getFilePath());
        if (!file.exists()) {
            writeError(response, "文件不存在");
            return;
        }

        try {
            String fileName = URLEncoder.encode(submission.getStudentName() + "_" + submission.getHomeworkName(), 
                    StandardCharsets.UTF_8);
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment;filename=" + fileName);
            response.setContentLengthLong(file.length());

            try (BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));
                 java.io.OutputStream out = response.getOutputStream()) {
                byte[] buffer = new byte[4096];
                int len;
                while ((len = bis.read(buffer)) != -1) {
                    out.write(buffer, 0, len);
                }
                out.flush();
            }
        } catch (IOException e) {
            log.error("文件下载失败", e);
            writeError(response, "下载失败");
        }
    }

    private void writeError(HttpServletResponse response, String msg) {
        try {
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write("{\"code\":500,\"msg\":\"" + msg + "\"}");
        } catch (IOException e) {
            log.error("��入响应失败", e);
        }
    }
}
