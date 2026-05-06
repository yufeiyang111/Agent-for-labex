package com.labex.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.labex.entity.Exam;
import com.labex.entity.ExamGrading;
import com.labex.entity.PaperQuestion;
import com.labex.entity.Question;
import com.labex.entity.QuestionTestCase;
import com.labex.entity.StudentQuestion;
import com.labex.service.CodeExecutionService;
import com.labex.service.ExamAutoSubmitService;
import com.labex.service.ExamGradingService;
import com.labex.service.ExamService;
import com.labex.service.PaperQuestionService;
import com.labex.service.QuestionService;
import com.labex.service.QuestionTestCaseService;
import com.labex.service.StudentQuestionService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@Slf4j
public class ExamAutoSubmitServiceImpl implements ExamAutoSubmitService {

    @Autowired
    private ExamService examService;
    @Autowired
    private StudentQuestionService studentQuestionService;
    @Autowired
    private PaperQuestionService paperQuestionService;
    @Autowired
    private QuestionService questionService;
    @Autowired
    private QuestionTestCaseService questionTestCaseService;
    @Autowired
    private CodeExecutionService codeExecutionService;
    @Autowired
    private ExamGradingService examGradingService;

    @Override
    public int forceSubmitExpiredExams() {
        LocalDateTime now = LocalDateTime.now();
        List<Exam> expiredExams = examService.list(
                new LambdaQueryWrapper<Exam>()
                        .eq(Exam::getState, 1)
                        .isNotNull(Exam::getEndTime)
                        .lt(Exam::getEndTime, now)
        );
        if (expiredExams.isEmpty()) {
            return 0;
        }

        int processed = 0;
        for (Exam exam : expiredExams) {
            if (exam.getPaperId() == null) {
                continue;
            }
            List<StudentQuestion> answers = studentQuestionService.list(
                    new LambdaQueryWrapper<StudentQuestion>()
                            .eq(StudentQuestion::getExamId, exam.getId())
            );
            Set<Integer> studentIds = answers.stream()
                    .map(StudentQuestion::getStudentId)
                    .filter(id -> id != null)
                    .collect(Collectors.toSet());

            for (Integer studentId : studentIds) {
                try {
                    if (alreadyAutoSubmitted(exam.getId(), studentId)) {
                        continue;
                    }
                    autoSubmitOneStudent(exam, studentId);
                    processed++;
                } catch (Exception ex) {
                    log.error("Auto submit exam={} student={} failed", exam.getId(), studentId, ex);
                }
            }
        }
        return processed;
    }

    private boolean alreadyAutoSubmitted(Integer examId, Integer studentId) {
        ExamGrading grading = examGradingService.findByExamAndStudent(examId, studentId);
        return grading != null && Boolean.TRUE.equals(grading.getAutoGraded());
    }

    @Transactional(rollbackFor = Exception.class)
    protected void autoSubmitOneStudent(Exam exam, Integer studentId) {
        List<PaperQuestion> links = paperQuestionService.findByPaperId(exam.getPaperId());
        if (links.isEmpty()) {
            return;
        }
        List<StudentQuestion> answers = studentQuestionService.list(
                new LambdaQueryWrapper<StudentQuestion>()
                        .eq(StudentQuestion::getExamId, exam.getId())
                        .eq(StudentQuestion::getStudentId, studentId)
        );
        Map<Integer, StudentQuestion> answerMap = answers.stream()
                .collect(Collectors.toMap(StudentQuestion::getQuestionId, a -> a, (a, b) -> a));

        int autoScore = 0;
        boolean pendingManual = false;
        int totalScore = 0;

        for (PaperQuestion link : links) {
            Question question = questionService.getById(link.getQuestionId());
            if (question == null) {
                continue;
            }
            int fullScore = link.getScore() != null ? link.getScore() : (question.getScore() != null ? question.getScore() : 10);
            totalScore += fullScore;

            StudentQuestion sq = answerMap.get(question.getId());
            if (sq == null) {
                continue;
            }

            switch (question.getType() == null ? 0 : question.getType()) {
                case 1, 2, 3, 4 -> {
                    int score = gradeObjective(question, sq.getMyAnswer(), fullScore);
                    sq.setScore(score);
                    sq.setGraded(true);
                    sq.setIsCorrect(score == fullScore ? 1 : 0);
                    autoScore += score;
                }
                case 5, 7 -> {
                    sq.setScore(0);
                    sq.setGraded(false);
                    sq.setIsCorrect(null);
                    pendingManual = true;
                }
                case 6 -> {
                    ProgrammingGradeResult programming = gradeProgramming(question, sq.getMyAnswer(), fullScore);
                    sq.setScore(programming.score());
                    sq.setGraded(true);
                    sq.setIsCorrect("ALL_PASS".equals(programming.status()) ? 1 : 0);
                    autoScore += programming.score();
                }
                default -> {
                    sq.setScore(0);
                    sq.setGraded(true);
                    sq.setIsCorrect(0);
                }
            }
            sq.setFillTime(LocalDateTime.now());
            studentQuestionService.updateById(sq);
        }

        ExamGrading grading = examGradingService.getOrCreate(exam.getId(), studentId);
        grading.setAutoGraded(true);
        if (pendingManual) {
            grading.setManualGraded(false);
        } else {
            grading.setManualGraded(true);
            grading.setFinalScore(autoScore);
            grading.setGradedAt(LocalDateTime.now());
        }
        examGradingService.updateById(grading);

        log.info("Auto submitted exam={} student={} autoScore={}/{} pendingManual={}",
                exam.getId(), studentId, autoScore, totalScore, pendingManual);
    }

    private int gradeObjective(Question question, String answer, int fullScore) {
        if (!StringUtils.hasText(question.getAnswer()) || !StringUtils.hasText(answer)) {
            return 0;
        }
        String correct = normalizeAnswer(question.getAnswer());
        String mine = normalizeAnswer(answer);
        log.info("评分填空题: questionId={}, correct='{}', mine='{}', fullScore={}", question.getId(), correct, mine, fullScore);

        // 多选题：比较集合（顺序无关）
        if (question.getType() != null && question.getType() == 3) {
            Set<String> correctSet = new HashSet<>(Arrays.asList(correct.split(",")));
            Set<String> mineSet = new HashSet<>(Arrays.asList(mine.split(",")));
            return correctSet.equals(mineSet) ? fullScore : 0;
        }

        // 填空题：每个空单独计分，正确得部分分（顺序无关，只要内容正确即可）
        if (correct.contains("|||") || mine.contains("|||")) {
            String[] correctParts = correct.split("\\|\\|\\|");
            String[] mineParts = mine.split("\\|\\|\\|");
            log.info("填空题多空: correctParts={}, mineParts={}", Arrays.toString(correctParts), Arrays.toString(mineParts));
            int correctCount = 0;
            int totalCount = correctParts.length;
            // 逐个比较，空答案为错误
            for (String c : correctParts) {
                String cNorm = normalizeAnswer(c.trim());
                if (cNorm.isEmpty()) continue;
                // 检查学生的答案中是否包含这个正确答案（忽略顺序）
                for (String m : mineParts) {
                    String mNorm = normalizeAnswer(m.trim());
                    if (mNorm.equals(cNorm)) {
                        correctCount++;
                        break;
                    }
                }
            }
            log.info("填空题多空结果: correctCount={}, totalCount={}, score={}", correctCount, totalCount, totalCount > 0 ? (int) Math.round(fullScore * correctCount / (double) totalCount) : 0);
            if (totalCount == 0) return 0;
            return (int) Math.round(fullScore * correctCount / (double) totalCount);
        }

        // 单个填空题或普通题：精确匹配
        return correct.equals(mine) ? fullScore : 0;
    }

    private ProgrammingGradeResult gradeProgramming(Question question, String rawAnswer, int fullScore) {
        ParsedProgramAnswer parsed = parseProgramAnswer(rawAnswer);
        String language = parsed.language();
        if (!StringUtils.hasText(language)) {
            language = normalizeLanguage(question.getLanguage());
        }
        if (!StringUtils.hasText(parsed.code())) {
            return new ProgrammingGradeResult(0, "NONE_PASS");
        }

        List<QuestionTestCase> testCases = questionTestCaseService.findByQuestionId(question.getId());
        if (testCases.isEmpty()) {
            return new ProgrammingGradeResult(0, "NONE_PASS");
        }

        Map<String, Object> judge = codeExecutionService.executeAndGrade(parsed.code(), language, testCases);
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
        return new ProgrammingGradeResult(score, status);
    }

    private ParsedProgramAnswer parseProgramAnswer(String rawAnswer) {
        if (!StringUtils.hasText(rawAnswer)) {
            return new ParsedProgramAnswer("", "");
        }
        String trimmed = rawAnswer.trim();
        if (trimmed.startsWith("{") && trimmed.contains("\"code\"")) {
            String language = extractJsonLikeValue(trimmed, "language");
            String code = extractJsonLikeValue(trimmed, "code");
            return new ParsedProgramAnswer(normalizeLanguage(language), code == null ? "" : code);
        }
        return new ParsedProgramAnswer("", rawAnswer);
    }

    private String normalizeLanguage(String language) {
        if (!StringUtils.hasText(language)) {
            return "java";
        }
        return "c".equalsIgnoreCase(language) ? "c" : "java";
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

    private record ParsedProgramAnswer(String language, String code) {
    }

    private record ProgrammingGradeResult(int score, String status) {
    }
}

