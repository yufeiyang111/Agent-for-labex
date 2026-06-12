package com.labex.controller.student;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.labex.common.Result;
import com.labex.entity.Clazz;
import com.labex.entity.Homework;
import com.labex.entity.HomeworkQuestion;
import com.labex.entity.Question;
import com.labex.entity.QuestionTestCase;
import com.labex.entity.Student;
import com.labex.entity.StudentHomework;
import com.labex.entity.StudentHomeworkQuestion;
import com.labex.service.ClazzService;
import com.labex.service.CodeExecutionService;
import com.labex.service.HomeworkQuestionService;
import com.labex.service.HomeworkService;
import com.labex.service.QuestionService;
import com.labex.service.QuestionTestCaseService;
import com.labex.service.StudentHomeworkQuestionService;
import com.labex.service.StudentHomeworkService;
import com.labex.service.StudentService;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.util.StringUtils;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * Student homework controller:
 * 1) list/homework detail
 * 2) question-by-question answering
 * 3) auto-grading for objective/programming questions
 * 4) manual grading pending for short-answer/comprehensive questions
 */
@RestController
@RequestMapping("/student/homework")
@PreAuthorize("hasRole('STUDENT')")
@Slf4j
public class StudentHomeworkController {

    @Autowired
    private HomeworkService homeworkService;

    @Autowired
    private StudentHomeworkService studentHomeworkService;

    @Autowired
    private StudentService studentService;

    @Autowired
    private ClazzService clazzService;

    @Autowired
    private HomeworkQuestionService homeworkQuestionService;

    @Autowired
    private QuestionService questionService;

    @Autowired
    private StudentHomeworkQuestionService studentHomeworkQuestionService;

    @Autowired
    private QuestionTestCaseService questionTestCaseService;

    @Autowired
    private CodeExecutionService codeExecutionService;

    private final String uploadPath = System.getProperty("user.dir") + "/uploads/";

    private Integer getTeacherIdByCurrentStudent() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null) {
            return null;
        }
        Student student = studentService.findByStudentNo(authentication.getName());
        if (student == null || !StringUtils.hasText(student.getClazzNo())) {
            return null;
        }
        Clazz clazz = clazzService.findByNo(student.getClazzNo());
        return clazz != null ? clazz.getTeacherId() : null;
    }

    private Student getCurrentStudent() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null) {
            return null;
        }
        return studentService.findByStudentNo(authentication.getName());
    }

    private boolean canAccessHomework(Homework homework) {
        Integer teacherId = getTeacherIdByCurrentStudent();
        return homework != null && teacherId != null && teacherId.equals(homework.getTeacherId());
    }

    private boolean isHomeworkClosed(Homework homework) {
        if (homework == null) {
            return true;
        }
        if (homework.getState() == null || homework.getState() != 1) {
            return true;
        }
        return homework.getDeadline() != null && LocalDateTime.now().isAfter(homework.getDeadline());
    }

    @GetMapping("/list")
    public Result<Map<String, Object>> getAvailableHomeworks(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer pageSize) {
        Integer teacherId = getTeacherIdByCurrentStudent();
        if (teacherId == null) {
            return Result.success(Map.of("records", List.of(), "total", 0));
        }

        Long total = homeworkService.count(
                new LambdaQueryWrapper<Homework>()
                        .eq(Homework::getState, 1)
                        .eq(Homework::getTeacherId, teacherId)
        );

        List<Homework> homeworks = homeworkService.list(
                new LambdaQueryWrapper<Homework>()
                        .eq(Homework::getState, 1)
                        .eq(Homework::getTeacherId, teacherId)
                        .orderByAsc(Homework::getDeadline)
                        .last("LIMIT " + (page - 1) * pageSize + ", " + pageSize)
        );

        return Result.success(Map.of("records", homeworks, "total", total, "page", page, "pageSize", pageSize));
    }

    @GetMapping("/{id}")
    public Result<Map<String, Object>> getHomeworkDetail(@PathVariable Integer id) {
        Homework homework = homeworkService.getById(id);
        if (!canAccessHomework(homework)) {
            return Result.error("No permission to access this homework");
        }
        Student student = getCurrentStudent();
        if (student == null) {
            return Result.error("Student not found");
        }

        Map<String, Object> result = new HashMap<>();
        result.put("homework", homework);
        result.put("questions", buildHomeworkQuestions(id, student.getStudentId(), false));
        result.put("closed", isHomeworkClosed(homework));
        return Result.success(result);
    }

    @GetMapping("/{id}/questions")
    public Result<List<Map<String, Object>>> getHomeworkQuestions(@PathVariable Integer id) {
        Homework homework = homeworkService.getById(id);
        if (!canAccessHomework(homework)) {
            return Result.error("No permission to access this homework");
        }
        Student student = getCurrentStudent();
        if (student == null) {
            return Result.error("Student not found");
        }
        return Result.success(buildHomeworkQuestions(id, student.getStudentId(), false));
    }

    @GetMapping("/{id}/my-answers")
    public Result<List<StudentHomeworkQuestion>> getMyAnswers(@PathVariable Integer id) {
        Homework homework = homeworkService.getById(id);
        if (!canAccessHomework(homework)) {
            return Result.error("No permission to access this homework");
        }
        Student student = getCurrentStudent();
        if (student == null) {
            return Result.error("Student not found");
        }
        return Result.success(studentHomeworkQuestionService.findByHomeworkAndStudent(id, student.getStudentId()));
    }

    @PostMapping("/{homeworkId}/question/{questionId}/save")
    public Result<Void> saveAnswer(
            @PathVariable Integer homeworkId,
            @PathVariable Integer questionId,
            @RequestParam String myAnswer) {
        Homework homework = homeworkService.getById(homeworkId);
        if (!canAccessHomework(homework)) {
            return Result.error("No permission to access this homework");
        }
        if (isHomeworkClosed(homework)) {
            return Result.error("Homework is closed");
        }
        Student student = getCurrentStudent();
        if (student == null) {
            return Result.error("Student not found");
        }

        boolean success = studentHomeworkQuestionService.saveAnswer(
                homeworkId,
                student.getStudentId(),
                questionId,
                myAnswer
        );
        return success ? Result.success("Saved", null) : Result.error("Save failed");
    }

    @PostMapping("/{homeworkId}/question/{questionId}/run-tests")
    public Result<Map<String, Object>> runProgrammingTests(
            @PathVariable Integer homeworkId,
            @PathVariable Integer questionId,
            @RequestParam String code,
            @RequestParam(defaultValue = "java") String language) {
        Homework homework = homeworkService.getById(homeworkId);
        if (!canAccessHomework(homework)) {
            return Result.error("No permission to access this homework");
        }
        if (!"java".equals(language) && !"c".equals(language)) {
            return Result.error("Only java/c supported");
        }
        Question question = questionService.getById(questionId);
        if (question == null || question.getType() == null || question.getType() != 6) {
            return Result.error("Question is not programming type");
        }

        List<QuestionTestCase> testCases = questionTestCaseService.findByQuestionId(questionId);
        if (testCases.isEmpty()) {
            return Result.error("No test cases configured");
        }

        Map<String, Object> judge = codeExecutionService.executeAndGrade(code, language, testCases);
        int passedCount = 0;
        Object detailsObj = judge.get("details");
        if (detailsObj instanceof List<?> detailList) {
            for (Object item : detailList) {
                if (item instanceof Map<?, ?> detail && Boolean.TRUE.equals(detail.get("passed"))) {
                    passedCount++;
                }
            }
        }

        String status = "NONE_PASS";
        String compileError = null;
        if (detailsObj instanceof List<?> detailList && !detailList.isEmpty()) {
            Object first = detailList.get(0);
            if (first instanceof Map<?, ?> firstMap && firstMap.get("error") != null) {
                status = "COMPILE_ERROR";
                compileError = String.valueOf(firstMap.get("error"));
            }
        }
        if (!"COMPILE_ERROR".equals(status)) {
            if (passedCount == testCases.size()) {
                status = "ALL_PASS";
            } else if (passedCount > 0) {
                status = "PARTIAL_PASS";
            }
        }

        Map<String, Object> result = new HashMap<>(judge);
        result.put("passedCount", passedCount);
        result.put("totalCount", testCases.size());
        result.put("status", status);
        result.put("compileError", compileError);
        return Result.success(result);
    }

    @PostMapping("/{homeworkId}/submit")
    @Transactional(rollbackFor = Exception.class)
    public Result<Map<String, Object>> submitHomework(@PathVariable Integer homeworkId) {
        Homework homework = homeworkService.getById(homeworkId);
        if (!canAccessHomework(homework)) {
            return Result.error("No permission to access this homework");
        }
        if (isHomeworkClosed(homework)) {
            return Result.error("Homework is closed");
        }
        Student student = getCurrentStudent();
        if (student == null) {
            return Result.error("Student not found");
        }

        List<HomeworkQuestion> links = homeworkQuestionService.findByHomeworkId(homeworkId);
        int totalScore = 0;
        int autoScore = 0;
        boolean pendingManual = false;
        List<Map<String, Object>> questionResults = new ArrayList<>();

        for (HomeworkQuestion link : links) {
            Question q = questionService.getById(link.getQuestionId());
            if (q == null) {
                continue;
            }
            int maxScore = resolveQuestionScore(link, q);
            totalScore += maxScore;

            StudentHomeworkQuestion answer = studentHomeworkQuestionService.findByHomeworkStudentQuestion(
                    homeworkId, student.getStudentId(), q.getId()
            );
            if (answer == null) {
                answer = new StudentHomeworkQuestion();
                answer.setHomeworkId(homeworkId);
                answer.setStudentId(student.getStudentId());
                answer.setQuestionId(q.getId());
                answer.setMyAnswer("");
                answer.setFillTime(LocalDateTime.now());
                answer.setIsCorrect(0);
            }

            Map<String, Object> questionResult = new HashMap<>();
            questionResult.put("questionId", q.getId());
            questionResult.put("type", q.getType());
            questionResult.put("maxScore", maxScore);

            Integer score;
            switch (q.getType() == null ? 0 : q.getType()) {
                case 1, 2, 3, 4 -> {
                    score = gradeObjectiveQuestion(q, answer.getMyAnswer(), maxScore);
                    answer.setScore(score);
                    answer.setGraded(true);
                    answer.setIsCorrect(score == maxScore ? 1 : 0);
                    autoScore += score;
                    questionResult.put("status", score == maxScore ? "CORRECT" : "WRONG");
                }
                case 5, 7 -> {
                    score = null;
                    answer.setScore(null);
                    answer.setGraded(false);
                    answer.setIsCorrect(null);
                    pendingManual = true;
                    questionResult.put("status", "PENDING_MANUAL");
                }
                case 6 -> {
                    ProgrammingGradeResult programming = gradeProgrammingQuestion(q, answer.getMyAnswer(), maxScore);
                    score = programming.score();
                    answer.setScore(score);
                    answer.setGraded(true);
                    answer.setIsCorrect(programming.status().equals("ALL_PASS") ? 1 : 0);
                    autoScore += score;
                    questionResult.put("status", programming.status());
                    questionResult.put("passedCount", programming.passedCount());
                    questionResult.put("totalCount", programming.totalCount());
                    questionResult.put("compileError", programming.compileError());
                }
                default -> {
                    score = 0;
                    answer.setScore(score);
                    answer.setGraded(true);
                    answer.setIsCorrect(0);
                    questionResult.put("status", "WRONG");
                }
            }

            answer.setFillTime(LocalDateTime.now());
            persistAnswer(answer);
            questionResult.put("score", score);
            questionResults.add(questionResult);
        }

        StudentHomework submission = studentHomeworkService.findByStudentAndHomework(student.getStudentId(), homeworkId);
        if (submission == null) {
            submission = new StudentHomework();
            submission.setHomeworkId(homeworkId);
            submission.setStudentId(student.getStudentId());
        }
        submission.setSubmitTime(LocalDateTime.now());
        submission.setScore(autoScore);
        submission.setRemark(pendingManual ? "Pending manual grading" : "Auto graded");
        submission.setContent("Submitted from online homework workspace");
        if (submission.getId() == null) {
            studentHomeworkService.save(submission);
        } else {
            studentHomeworkService.updateById(submission);
        }

        Map<String, Object> result = new HashMap<>();
        result.put("totalScore", totalScore);
        result.put("autoScore", autoScore);
        result.put("pendingManualGrading", pendingManual);
        result.put("questionResults", questionResults);
        return Result.success(result);
    }

    @GetMapping("/{id}/my-submission")
    public Result<StudentHomework> getMySubmission(@PathVariable Integer id) {
        Student student = getCurrentStudent();
        if (student == null) {
            return Result.error("Student not found");
        }
        StudentHomework submission = studentHomeworkService.findByStudentAndHomework(student.getStudentId(), id);
        return Result.success(submission);
    }

    @GetMapping("/my-list")
    public Result<List<StudentHomework>> getMySubmissions() {
        Student student = getCurrentStudent();
        if (student == null) {
            return Result.error("Student not found");
        }
        return Result.success(studentHomeworkService.findByStudentId(student.getStudentId()));
    }

    @PostMapping("/{id}/submit-text")
    public Result<Void> submitText(@PathVariable Integer id, @RequestBody StudentHomework body) {
        Student student = getCurrentStudent();
        if (student == null) {
            return Result.error("Student not found");
        }
        Homework homework = homeworkService.getById(id);
        if (!canAccessHomework(homework)) {
            return Result.error("No permission to access this homework");
        }
        if (isHomeworkClosed(homework)) {
            return Result.error("Homework is closed");
        }

        StudentHomework sh = studentHomeworkService.findByStudentAndHomework(student.getStudentId(), id);
        if (sh == null) {
            sh = new StudentHomework();
            sh.setHomeworkId(id);
            sh.setStudentId(student.getStudentId());
        }
        sh.setContent(body.getContent());
        sh.setSubmitTime(LocalDateTime.now());
        if (sh.getId() == null) {
            studentHomeworkService.save(sh);
        } else {
            studentHomeworkService.updateById(sh);
        }
        return Result.success("Submitted", null);
    }

    @PostMapping("/{id}/submit-file")
    public Result<Void> submitFile(@PathVariable Integer id, @RequestParam("file") MultipartFile file) {
        Student student = getCurrentStudent();
        if (student == null) {
            return Result.error("Student not found");
        }
        Homework homework = homeworkService.getById(id);
        if (!canAccessHomework(homework)) {
            return Result.error("No permission to access this homework");
        }
        if (isHomeworkClosed(homework)) {
            return Result.error("Homework is closed");
        }
        if (file.isEmpty()) {
            return Result.error("File is empty");
        }

        File dir = new File(uploadPath);
        if (!dir.exists() && !dir.mkdirs()) {
            return Result.error("Create upload dir failed");
        }

        String originalFilename = file.getOriginalFilename();
        String suffix = originalFilename != null && originalFilename.contains(".")
                ? originalFilename.substring(originalFilename.lastIndexOf('.'))
                : "";
        String filename = UUID.randomUUID() + suffix;

        try {
            File dest = new File(uploadPath + filename);
            file.transferTo(dest);

            StudentHomework sh = studentHomeworkService.findByStudentAndHomework(student.getStudentId(), id);
            if (sh == null) {
                sh = new StudentHomework();
                sh.setHomeworkId(id);
                sh.setStudentId(student.getStudentId());
            }
            sh.setFilePath(filename);
            sh.setFileSize(file.getSize());
            sh.setSubmitTime(LocalDateTime.now());
            if (sh.getId() == null) {
                studentHomeworkService.save(sh);
            } else {
                studentHomeworkService.updateById(sh);
            }
            return Result.success("Submitted", null);
        } catch (IOException e) {
            log.error("Upload failed", e);
            return Result.error("Upload failed");
        }
    }

    @GetMapping("/{id}/download")
    public void downloadHomeworkFile(@PathVariable Integer id, HttpServletResponse response) {
        Homework homework = homeworkService.getById(id);
        if (homework == null || !StringUtils.hasText(homework.getFilePath())) {
            writeError(response, "Homework file not found");
            return;
        }

        File file = new File(uploadPath + homework.getFilePath());
        if (!file.exists()) {
            writeError(response, "File not found");
            return;
        }

        try {
            String fileName = URLEncoder.encode(
                    homework.getHomeworkName(),
                    StandardCharsets.UTF_8
            ) + "." + homework.getFilePath().substring(homework.getFilePath().lastIndexOf('.') + 1);
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
            log.error("Download failed", e);
            writeError(response, "Download failed");
        }
    }

    private void persistAnswer(StudentHomeworkQuestion answer) {
        if (answer.getId() == null) {
            studentHomeworkQuestionService.save(answer);
        } else {
            studentHomeworkQuestionService.updateById(answer);
        }
    }

    private int resolveQuestionScore(HomeworkQuestion link, Question question) {
        if (link != null && link.getScore() != null) {
            return link.getScore();
        }
        if (question != null && question.getScore() != null) {
            return question.getScore();
        }
        return 10;
    }

    private Integer gradeObjectiveQuestion(Question question, String myAnswer, int fullScore) {
        if (!StringUtils.hasText(question.getAnswer()) || !StringUtils.hasText(myAnswer)) {
            return 0;
        }
        String correct = normalizeAnswer(question.getAnswer());
        String answer = normalizeAnswer(myAnswer);

        // 多选题：比较集合（顺序无关）
        if (question.getType() != null && question.getType() == 3) {
            Set<String> correctSet = new HashSet<>(Arrays.asList(correct.split(",")));
            Set<String> answerSet = new HashSet<>(Arrays.asList(answer.split(",")));
            return correctSet.equals(answerSet) ? fullScore : 0;
        }

        // 填空题：每个空单独计分，正确得部分分（顺序无关，只要内容正确即可）
        if (correct.contains("|||") || answer.contains("|||")) {
            String[] correctParts = correct.split("\\|\\|\\|");
            String[] answerParts = answer.split("\\|\\|\\|");
            int correctCount = 0;
            int totalCount = correctParts.length;
            for (String c : correctParts) {
                String cNorm = normalizeAnswer(c.trim());
                if (cNorm.isEmpty()) continue;
                for (String a : answerParts) {
                    String aNorm = normalizeAnswer(a.trim());
                    if (aNorm.equals(cNorm)) {
                        correctCount++;
                        break;
                    }
                }
            }
            if (totalCount == 0) return 0;
            return (int) Math.round(fullScore * correctCount / (double) totalCount);
        }

        return correct.equals(answer) ? fullScore : 0;
    }

    private ProgrammingGradeResult gradeProgrammingQuestion(Question question, String rawAnswer, int fullScore) {
        ParsedProgramAnswer parsed = parseProgramAnswer(rawAnswer);
        if (!StringUtils.hasText(parsed.code())) {
            return new ProgrammingGradeResult(0, "NONE_PASS", 0, 0, null);
        }

        List<QuestionTestCase> testCases = questionTestCaseService.findByQuestionId(question.getId());
        if (testCases.isEmpty()) {
            return new ProgrammingGradeResult(0, "NONE_PASS", 0, 0, "No test cases configured");
        }

        Map<String, Object> judge = codeExecutionService.executeAndGrade(parsed.code(), parsed.language(), testCases);
        int passedCount = 0;
        String compileError = null;
        Object detailsObj = judge.get("details");
        if (detailsObj instanceof List<?> detailList) {
            for (Object item : detailList) {
                if (item instanceof Map<?, ?> detail) {
                    if (Boolean.TRUE.equals(detail.get("passed"))) {
                        passedCount++;
                    }
                    if (compileError == null && detail.get("error") != null) {
                        compileError = String.valueOf(detail.get("error"));
                    }
                }
            }
        }

        int totalCount = testCases.size();
        String status = "NONE_PASS";
        if (compileError != null) {
            status = "COMPILE_ERROR";
        } else if (passedCount == totalCount) {
            status = "ALL_PASS";
        } else if (passedCount > 0) {
            status = "PARTIAL_PASS";
        }

        int score = totalCount == 0 ? 0 : (int) Math.round((double) fullScore * passedCount / totalCount);
        return new ProgrammingGradeResult(score, status, passedCount, totalCount, compileError);
    }

    private ParsedProgramAnswer parseProgramAnswer(String rawAnswer) {
        if (!StringUtils.hasText(rawAnswer)) {
            return new ParsedProgramAnswer("java", "");
        }
        String trimmed = rawAnswer.trim();
        if (trimmed.startsWith("{") && trimmed.contains("\"code\"")) {
            String language = extractJsonLikeValue(trimmed, "language");
            String code = extractJsonLikeValue(trimmed, "code");
            if (!StringUtils.hasText(language)) {
                language = "java";
            }
            if (!"java".equals(language) && !"c".equals(language)) {
                language = "java";
            }
            return new ParsedProgramAnswer(language, code == null ? "" : code);
        }
        return new ParsedProgramAnswer("java", rawAnswer);
    }

    private String extractJsonLikeValue(String text, String key) {
        String marker = "\"" + key + "\"";
        int keyIdx = text.indexOf(marker);
        if (keyIdx < 0) {
            return null;
        }
        int colonIdx = text.indexOf(':', keyIdx);
        if (colonIdx < 0) {
            return null;
        }
        int firstQuote = text.indexOf('"', colonIdx + 1);
        if (firstQuote < 0) {
            return null;
        }
        int endQuote = firstQuote + 1;
        StringBuilder value = new StringBuilder();
        boolean escape = false;
        while (endQuote < text.length()) {
            char ch = text.charAt(endQuote);
            if (escape) {
                switch (ch) {
                    case 'n' -> value.append('\n');
                    case 'r' -> value.append('\r');
                    case 't' -> value.append('\t');
                    case '"' -> value.append('"');
                    case '\\' -> value.append('\\');
                    default -> value.append(ch);
                }
                escape = false;
            } else if (ch == '\\') {
                escape = true;
            } else if (ch == '"') {
                break;
            } else {
                value.append(ch);
            }
            endQuote++;
        }
        return value.toString();
    }

    private String normalizeAnswer(String answer) {
        return Arrays.stream(answer.toLowerCase().trim().split(","))
                .map(String::trim)
                .filter(StringUtils::hasText)
                .sorted(Comparator.naturalOrder())
                .collect(Collectors.joining(","));
    }

    private List<Map<String, Object>> buildHomeworkQuestions(Integer homeworkId, Integer studentId, boolean includeAnswer) {
        List<HomeworkQuestion> links = homeworkQuestionService.findByHomeworkId(homeworkId);
        List<Map<String, Object>> questions = new ArrayList<>();
        for (HomeworkQuestion link : links) {
            Question q = questionService.getById(link.getQuestionId());
            if (q == null) {
                continue;
            }
            Map<String, Object> item = new HashMap<>();
            item.put("id", q.getId());
            item.put("question", q.getQuestion());
            item.put("type", q.getType());
            item.put("typeName", getTypeName(q.getType()));
            item.put("options", q.getOptions());
            item.put("score", resolveQuestionScore(link, q));
            if (includeAnswer) {
                item.put("answer", q.getAnswer());
            }
            if (q.getType() != null && q.getType() == 6) {
                item.put("testCaseCount", questionTestCaseService.findByQuestionId(q.getId()).size());
            }
            if (studentId != null) {
                StudentHomeworkQuestion answer = studentHomeworkQuestionService
                        .findByHomeworkStudentQuestion(homeworkId, studentId, q.getId());
                if (answer != null) {
                    item.put("myAnswer", answer.getMyAnswer());
                    item.put("answerScore", answer.getScore());
                    item.put("graded", answer.getGraded());
                    item.put("isCorrect", answer.getIsCorrect());
                }
            }
            questions.add(item);
        }
        return questions;
    }

    private String getTypeName(Integer type) {
        if (type == null) return "Unknown";
        return switch (type) {
            case 1 -> "Fill Blank";
            case 2 -> "Single Choice";
            case 3 -> "Multiple Choice";
            case 4 -> "True/False";
            case 5 -> "Short Answer";
            case 6 -> "Programming";
            case 7 -> "Comprehensive";
            default -> "Unknown";
        };
    }

    private void writeError(HttpServletResponse response, String msg) {
        try {
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write("{\"code\":500,\"message\":\"" + msg + "\"}");
        } catch (IOException e) {
            log.error("Write error response failed", e);
        }
    }

    private record ParsedProgramAnswer(String language, String code) {
    }

    private record ProgrammingGradeResult(int score, String status, int passedCount, int totalCount, String compileError) {
    }
}
