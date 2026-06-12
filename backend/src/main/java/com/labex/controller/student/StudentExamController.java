package com.labex.controller.student;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.labex.common.Result;
import com.labex.entity.Clazz;
import com.labex.entity.Exam;
import com.labex.entity.ExamGrading;
import com.labex.entity.ExamMonitorEvent;
import com.labex.entity.Paper;
import com.labex.entity.PaperQuestion;
import com.labex.entity.Question;
import com.labex.entity.QuestionTestCase;
import com.labex.entity.Student;
import com.labex.entity.StudentQuestion;
import com.labex.service.ClazzService;
import com.labex.service.CodeExecutionService;
import com.labex.service.ExamGradingService;
import com.labex.service.ExamMonitorEventService;
import com.labex.service.ExamService;
import com.labex.service.PaperQuestionService;
import com.labex.service.PaperService;
import com.labex.service.QuestionService;
import com.labex.service.QuestionTestCaseService;
import com.labex.service.StudentQuestionService;
import com.labex.service.StudentService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/student/exam")
@PreAuthorize("hasRole('STUDENT')")
@Slf4j
public class StudentExamController {

    @Autowired
    private ExamService examService;
    @Autowired
    private PaperService paperService;
    @Autowired
    private PaperQuestionService paperQuestionService;
    @Autowired
    private QuestionService questionService;
    @Autowired
    private StudentQuestionService studentQuestionService;
    @Autowired
    private StudentService studentService;
    @Autowired
    private ClazzService clazzService;
    @Autowired
    private ExamGradingService examGradingService;
    @Autowired
    private QuestionTestCaseService questionTestCaseService;
    @Autowired
    private CodeExecutionService codeExecutionService;
    @Autowired
    private ExamMonitorEventService examMonitorEventService;

    @GetMapping("/list")
    public Result<Map<String, Object>> getAvailableExams(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer pageSize) {
        Integer teacherId = getTeacherIdByCurrentStudent();
        Student student = getCurrentStudent();
        if (teacherId == null) {
            return Result.success(Map.of("records", List.of(), "total", 0));
        }

        Long total = examService.count(
                new LambdaQueryWrapper<Exam>()
                        .eq(Exam::getState, 1)
                        .eq(Exam::getTeacherId, teacherId)
        );

        List<Exam> exams = examService.list(
                new LambdaQueryWrapper<Exam>()
                        .eq(Exam::getState, 1)
                        .eq(Exam::getTeacherId, teacherId)
                        .orderByAsc(Exam::getTime)
                        .last("LIMIT " + (page - 1) * pageSize + ", " + pageSize)
        );

        for (Exam exam : exams) {
            if (exam.getPaperId() != null) {
                Paper paper = paperService.getById(exam.getPaperId());
                if (paper != null) {
                    exam.setPaperName(paper.getName());
                    List<PaperQuestion> pqs = paperQuestionService.findByPaperId(paper.getId());
                    exam.setTotalQuestions(pqs.size());
                    if (exam.getTotalScore() == null) {
                        int totalScore = pqs.stream()
                                .map(PaperQuestion::getScore)
                                .filter(Objects::nonNull)
                                .mapToInt(Integer::intValue)
                                .sum();
                        exam.setTotalScore(totalScore);
                    }
                }
            }
            if (student != null) {
                exam.setMyScore(examGradingService.getFinalScore(exam.getId(), student.getStudentId()));
            }
        }

        return Result.success(Map.of("records", exams, "total", total, "page", page, "pageSize", pageSize));
    }

    @GetMapping("/{id}")
    public Result<Map<String, Object>> getExamDetail(@PathVariable Integer id) {
        Exam exam = examService.getById(id);
        if (!canAccessExam(exam)) {
            return Result.error("无权访问此考试");
        }

        LocalDateTime now = LocalDateTime.now();
        boolean examStarted = hasStarted(exam, now);
        boolean examEnded = hasEnded(exam, now);

        Map<String, Object> result = new HashMap<>();
        result.put("exam", exam);
        result.put("examStarted", examStarted);
        result.put("examEnded", examEnded);
        result.put("serverTime", now);
        result.put("startTime", exam.getTime());
        result.put("endTime", exam.getEndTime());
        result.put("secondsToStart", examStarted || exam.getTime() == null ? 0 : ChronoUnit.SECONDS.between(now, exam.getTime()));
        result.put("secondsToEnd", exam.getEndTime() == null ? null : Math.max(0, ChronoUnit.SECONDS.between(now, exam.getEndTime())));

        if (examEnded) {
            result.put("questions", List.of());
            result.put("message", "考试已结束");
            return Result.success(result);
        }
        if (!examStarted) {
            result.put("questions", List.of());
            result.put("message", "考试未开始");
            return Result.success(result);
        }

        Student student = getCurrentStudent();
        Integer studentId = student != null ? student.getStudentId() : null;
        Paper paper = exam.getPaperId() != null ? paperService.getById(exam.getPaperId()) : null;
        List<Map<String, Object>> questions = buildExamQuestions(exam, studentId, false);

        result.put("paper", paper);
        result.put("questions", questions);
        return Result.success(result);
    }

    @GetMapping("/{id}/my-answers")
    public Result<List<StudentQuestion>> getMyAnswers(@PathVariable Integer id) {
        Student student = getCurrentStudent();
        if (student == null) {
            return Result.error("学生不存在");
        }
        Exam exam = examService.getById(id);
        if (!canAccessExam(exam)) {
            return Result.error("无权访问此考试");
        }
        return Result.success(studentQuestionService.findByStudentAndExam(student.getStudentId(), id));
    }

    @PostMapping("/{examId}/question/{questionId}/save")
    public Result<Void> saveAnswer(
            @PathVariable Integer examId,
            @PathVariable Integer questionId,
            @RequestParam String myAnswer) {
        Student student = getCurrentStudent();
        if (student == null) {
            return Result.error("学生不存在");
        }

        Exam exam = examService.getById(examId);
        if (!canAccessExam(exam)) {
            return Result.error("无权访问此考试");
        }
        LocalDateTime now = LocalDateTime.now();
        if (!hasStarted(exam, now)) {
            return Result.error("考试未开始");
        }
        if (hasEnded(exam, now)) {
            return Result.error("考试已结束，无法继续作答");
        }

        StudentQuestion existing = studentQuestionService.getOne(
                new LambdaQueryWrapper<StudentQuestion>()
                        .eq(StudentQuestion::getStudentId, student.getStudentId())
                        .eq(StudentQuestion::getExamId, examId)
                        .eq(StudentQuestion::getQuestionId, questionId)
        );

        StudentQuestion sq = new StudentQuestion();
        sq.setStudentId(student.getStudentId());
        sq.setExamId(examId);
        sq.setQuestionId(questionId);
        sq.setMyAnswer(myAnswer);
        sq.setFillTime(LocalDateTime.now());

        if (existing != null) {
            sq.setId(existing.getId());
            studentQuestionService.updateById(sq);
        } else {
            studentQuestionService.save(sq);
        }
        return Result.success("保存成功", null);
    }

    @PostMapping("/{examId}/question/{questionId}/run-tests")
    public Result<Map<String, Object>> runProgrammingTests(
            @PathVariable Integer examId,
            @PathVariable Integer questionId,
            @RequestParam String code,
            @RequestParam(defaultValue = "java") String language) {
        Exam exam = examService.getById(examId);
        if (!canAccessExam(exam)) {
            return Result.error("无权访问此考试");
        }
        LocalDateTime now = LocalDateTime.now();
        if (!hasStarted(exam, now)) {
            return Result.error("考试未开始");
        }
        if (hasEnded(exam, now)) {
            return Result.error("考试已结束，无法运行测试");
        }
        if (!"java".equals(language) && !"c".equals(language)) {
            return Result.error("仅支持 Java/C");
        }

        Question question = questionService.getById(questionId);
        if (question == null || question.getType() == null || question.getType() != 6) {
            return Result.error("题目不是编程题");
        }

        List<QuestionTestCase> testCases = questionTestCaseService.findByQuestionId(questionId);
        if (testCases.isEmpty()) {
            return Result.error("No test cases configured");
        }

        Map<String, Object> judge = codeExecutionService.executeAndGrade(code, language, testCases);
        int passedCount = 0;
        String compileError = null;
        String executionError = null;
        Object detailsObj = judge.get("details");
        if (detailsObj instanceof List<?> detailList) {
            for (Object item : detailList) {
                if (item instanceof Map<?, ?> detail) {
                    if (Boolean.TRUE.equals(detail.get("passed"))) {
                        passedCount++;
                    }
                    if (detail.get("error") != null) {
                        String detailError = String.valueOf(detail.get("error"));
                        if (compileError == null && detailError.startsWith("Compile error:")) {
                            compileError = detailError;
                        }
                        if (executionError == null && detailError.startsWith("Execution error:")) {
                            executionError = detailError;
                        }
                    }
                }
            }
        }
        int totalCount = testCases.size();
        String status = "NONE_PASS";
        if (compileError != null) {
            status = "COMPILE_ERROR";
        } else if (executionError != null) {
            status = "RUNTIME_ERROR";
        } else if (passedCount == totalCount) {
            status = "ALL_PASS";
        } else if (passedCount > 0) {
            status = "PARTIAL_PASS";
        }

        Map<String, Object> result = new HashMap<>(judge);
        result.put("passedCount", passedCount);
        result.put("totalCount", totalCount);
        result.put("status", status);
        result.put("compileError", compileError);
        result.put("executionError", executionError);
        return Result.success(result);
    }

    @PostMapping("/{examId}/submit")
    @Transactional(rollbackFor = Exception.class)
    public Result<Map<String, Object>> submitExam(@PathVariable Integer examId) {
        Student student = getCurrentStudent();
        if (student == null) {
            return Result.error("学生不存在");
        }

        Exam exam = examService.getById(examId);
        if (!canAccessExam(exam)) {
            return Result.error("无权访问此考试");
        }
        if (!hasStarted(exam, LocalDateTime.now())) {
            return Result.error("考试未开始");
        }

        List<Question> questions = List.of();
        int totalScore = 0;
        int autoScore = 0;
        boolean pendingManual = false;
        List<Map<String, Object>> questionResults = new ArrayList<>();

        if (exam.getPaperId() != null) {
            List<PaperQuestion> pqs = paperQuestionService.findByPaperId(exam.getPaperId());
            questions = pqs.stream()
                    .map(pq -> {
                        Question q = questionService.getById(pq.getQuestionId());
                        if (q != null) {
                            q.setScore(pq.getScore() != null ? pq.getScore() : q.getScore());
                        }
                        return q;
                    })
                    .toList();
        }

        ExamGrading grading = examGradingService.getOrCreate(examId, student.getStudentId());

        for (Question q : questions) {
            if (q == null) {
                continue;
            }
            StudentQuestion sq = studentQuestionService.getOne(
                    new LambdaQueryWrapper<StudentQuestion>()
                            .eq(StudentQuestion::getStudentId, student.getStudentId())
                            .eq(StudentQuestion::getExamId, examId)
                            .eq(StudentQuestion::getQuestionId, q.getId())
            );
            if (sq == null) {
                continue;
            }

            int fullScore = resolveQuestionScore(q);
            totalScore += fullScore;

            Map<String, Object> questionResult = new HashMap<>();
            questionResult.put("questionId", q.getId());
            questionResult.put("type", q.getType());
            questionResult.put("maxScore", fullScore);

            switch (q.getType() == null ? 0 : q.getType()) {
                case 1, 2, 3, 4 -> {
                    int score = gradeObjectiveQuestion(q, sq.getMyAnswer(), fullScore);
                    sq.setScore(score);
                    sq.setGraded(true);
                    sq.setIsCorrect(score == fullScore ? 1 : 0);
                    autoScore += score;
                    questionResult.put("status", score == fullScore ? "CORRECT" : "WRONG");
                    questionResult.put("score", score);
                }
                case 5, 7 -> {
                    sq.setScore(0);
                    sq.setGraded(false);
                    sq.setIsCorrect(null);
                    pendingManual = true;
                    questionResult.put("status", "PENDING_MANUAL");
                    questionResult.put("score", 0);
                }
                case 6 -> {
                    ProgrammingGradeResult programming = gradeProgrammingQuestion(q, sq.getMyAnswer(), fullScore);
                    sq.setScore(programming.score());
                    sq.setGraded(true);
                    sq.setIsCorrect("ALL_PASS".equals(programming.status()) ? 1 : 0);
                    autoScore += programming.score();
                    questionResult.put("status", programming.status());
                    questionResult.put("score", programming.score());
                    questionResult.put("passedCount", programming.passedCount());
                    questionResult.put("totalCount", programming.totalCount());
                    questionResult.put("compileError", programming.compileError());
                }
                default -> {
                    sq.setScore(0);
                    sq.setGraded(true);
                    sq.setIsCorrect(0);
                    questionResult.put("status", "WRONG");
                    questionResult.put("score", 0);
                }
            }
            sq.setFillTime(LocalDateTime.now());
            studentQuestionService.updateById(sq);
            questionResults.add(questionResult);
        }

        grading.setAutoGraded(true);
        if (pendingManual) {
            grading.setManualGraded(false);
        } else {
            grading.setManualGraded(true);
            grading.setFinalScore(autoScore);
            grading.setGradedAt(LocalDateTime.now());
        }
        examGradingService.updateById(grading);

        Map<String, Object> result = new HashMap<>();
        result.put("totalScore", totalScore);
        result.put("myScore", autoScore);
        result.put("pendingManualGrading", pendingManual);
        result.put("questionResults", questionResults);
        return Result.success(result);
    }

    @PostMapping("/{examId}/monitor-event")
    public Result<Void> reportMonitorEvent(
            @PathVariable Integer examId,
            @RequestBody Map<String, String> payload,
            HttpServletRequest request) {
        Student student = getCurrentStudent();
        if (student == null) {
            return Result.error("瀛︾敓涓嶅瓨鍦?");
        }

        Exam exam = examService.getById(examId);
        if (!canAccessExam(exam)) {
            return Result.error("鏃犳潈璁块棶姝よ€冭瘯");
        }

        LocalDateTime now = LocalDateTime.now();
        if (!hasStarted(exam, now) || hasEnded(exam, now)) {
            return Result.error("褰撳墠鑰冭瘯鐘舵€佷笉鏀寔璁板綍鐩戣€冧簨浠?");
        }

        String eventType = payload == null ? null : payload.get("eventType");
        if (!StringUtils.hasText(eventType)) {
            return Result.error("缂哄皯浜嬩欢绫诲瀷");
        }

        ExamMonitorEvent event = new ExamMonitorEvent();
        event.setExamId(examId);
        event.setStudentId(student.getStudentId());
        event.setEventType(safeText(eventType, 32).toUpperCase());
        event.setEventDesc(safeText(payload == null ? null : payload.get("detail"), 500));
        event.setPageUrl(safeText(payload == null ? null : payload.get("pageUrl"), 255));
        event.setIp(resolveClientIp(request));
        event.setOccurredAt(now);

        boolean saved = examMonitorEventService.save(event);
        if (!saved) {
            log.warn("Exam monitor event save failed. examId={}, studentId={}, eventType={}",
                    examId, student.getStudentId(), event.getEventType());
            return Result.error("鐩戣€冭褰曚繚瀛樺け璐?");
        }
        return Result.success("璁板綍鎴愬姛", null);
    }

    @PostMapping("/run-code")
    public Result<Map<String, Object>> runCode(@RequestParam String code, @RequestParam String language) {
        if (code == null || code.isBlank()) {
            return Result.error("代码不能为空");
        }
        if (!"java".equals(language) && !"c".equals(language)) {
            return Result.error("仅支持Java和C语言");
        }
        Map<String, Object> result = codeExecutionService.runCode(code, language, "");
        return Result.success(result);
    }

    private boolean canAccessExam(Exam exam) {
        Integer teacherId = getTeacherIdByCurrentStudent();
        return exam != null && teacherId != null && teacherId.equals(exam.getTeacherId());
    }

    private boolean hasStarted(Exam exam, LocalDateTime now) {
        return exam.getTime() == null || !now.isBefore(exam.getTime());
    }

    private boolean hasEnded(Exam exam, LocalDateTime now) {
        return exam.getEndTime() != null && now.isAfter(exam.getEndTime());
    }

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

    private int resolveQuestionScore(Question question) {
        return question != null && question.getScore() != null ? question.getScore() : 10;
    }

    private int gradeObjectiveQuestion(Question question, String myAnswer, int fullScore) {
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
        String executionError = null;
        Object detailsObj = judge.get("details");
        if (detailsObj instanceof List<?> detailList) {
            for (Object item : detailList) {
                if (item instanceof Map<?, ?> detail) {
                    if (Boolean.TRUE.equals(detail.get("passed"))) {
                        passedCount++;
                    }
                    if (detail.get("error") != null) {
                        String detailError = String.valueOf(detail.get("error"));
                        if (compileError == null && detailError.startsWith("Compile error:")) {
                            compileError = detailError;
                        }
                        if (executionError == null && detailError.startsWith("Execution error:")) {
                            executionError = detailError;
                        }
                    }
                }
            }
        }
        int totalCount = testCases.size();
        String status = "NONE_PASS";
        if (compileError != null) {
            status = "COMPILE_ERROR";
        } else if (executionError != null) {
            status = "RUNTIME_ERROR";
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
                .sorted()
                .collect(Collectors.joining(","));
    }

    private String safeText(String value, int maxLen) {
        if (!StringUtils.hasText(value)) {
            return null;
        }
        String trimmed = value.trim();
        if (trimmed.length() <= maxLen) {
            return trimmed;
        }
        return trimmed.substring(0, maxLen);
    }

    private String resolveClientIp(HttpServletRequest request) {
        if (request == null) {
            return null;
        }
        String xff = request.getHeader("X-Forwarded-For");
        if (StringUtils.hasText(xff)) {
            String[] parts = xff.split(",");
            if (parts.length > 0 && StringUtils.hasText(parts[0])) {
                return parts[0].trim();
            }
        }
        String ip = request.getHeader("X-Real-IP");
        if (StringUtils.hasText(ip)) {
            return ip.trim();
        }
        return request.getRemoteAddr();
    }

    private List<Map<String, Object>> buildExamQuestions(Exam exam, Integer studentId, boolean includeAnswer) {
        if (exam == null || exam.getPaperId() == null) {
            return List.of();
        }
        List<PaperQuestion> links = paperQuestionService.findByPaperId(exam.getPaperId());
        List<Map<String, Object>> questions = new ArrayList<>();
        for (PaperQuestion link : links) {
            Question q = questionService.getById(link.getQuestionId());
            if (q == null) {
                continue;
            }
            Map<String, Object> item = new HashMap<>();
            item.put("id", q.getId());
            item.put("question", q.getQuestion());
            item.put("type", q.getType());
            item.put("options", q.getOptions());
            item.put("score", link.getScore() != null ? link.getScore() : resolveQuestionScore(q));
            if (includeAnswer) {
                item.put("answer", q.getAnswer());
            }
            if (q.getType() != null && q.getType() == 6) {
                item.put("testCaseCount", questionTestCaseService.findByQuestionId(q.getId()).size());
            }
            if (studentId != null) {
                StudentQuestion sq = studentQuestionService.getOne(
                        new LambdaQueryWrapper<StudentQuestion>()
                                .eq(StudentQuestion::getStudentId, studentId)
                                .eq(StudentQuestion::getExamId, exam.getId())
                                .eq(StudentQuestion::getQuestionId, q.getId())
                );
                if (sq != null) {
                    item.put("myAnswer", sq.getMyAnswer());
                    item.put("answerScore", sq.getScore());
                    item.put("graded", sq.getGraded());
                    item.put("isCorrect", sq.getIsCorrect());
                }
            }
            questions.add(item);
        }
        return questions;
    }

    private record ParsedProgramAnswer(String language, String code) {
    }

    private record ProgrammingGradeResult(int score, String status, int passedCount, int totalCount, String compileError) {
    }
}
