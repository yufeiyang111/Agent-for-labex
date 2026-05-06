package com.labex.controller.teacher;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.labex.common.Result;
import com.labex.entity.Clazz;
import com.labex.entity.Exam;
import com.labex.entity.ExamMonitorEvent;
import com.labex.entity.Experiment;
import com.labex.entity.Score;
import com.labex.entity.Student;
import com.labex.entity.StudentClazz;
import com.labex.entity.Teacher;
import com.labex.service.ClazzService;
import com.labex.service.ExamMonitorEventService;
import com.labex.service.ExamService;
import com.labex.service.ExperimentService;
import com.labex.service.ScoreService;
import com.labex.service.StudentClazzService;
import com.labex.service.StudentService;
import com.labex.service.TeacherService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/teacher/dashboard")
@PreAuthorize("hasRole('TEACHER')")
@Slf4j
public class TeacherDashboardController {

    @Autowired
    private TeacherService teacherService;
    @Autowired
    private ClazzService clazzService;
    @Autowired
    private StudentService studentService;
    @Autowired
    private StudentClazzService studentClazzService;
    @Autowired
    private ExperimentService experimentService;
    @Autowired
    private ScoreService scoreService;
    @Autowired
    private ExamService examService;
    @Autowired
    private ExamMonitorEventService examMonitorEventService;

    @GetMapping("/overview")
    public Result<Map<String, Object>> overview() {
        Integer teacherId = getCurrentTeacherId();
        if (teacherId == null) {
            return Result.error("鏈壘鍒版暀甯堜俊鎭?");
        }

        List<Clazz> clazzList = clazzService.list(
                new LambdaQueryWrapper<Clazz>()
                        .eq(Clazz::getTeacherId, teacherId)
                        .orderByAsc(Clazz::getNo)
        );
        List<Experiment> experimentList = experimentService.list(
                new LambdaQueryWrapper<Experiment>()
                        .eq(Experiment::getTeacherId, teacherId)
                        .orderByDesc(Experiment::getExperimentNo)
        );

        Set<String> clazzNos = clazzList.stream()
                .map(Clazz::getNo)
                .filter(StringUtils::hasText)
                .collect(Collectors.toSet());

        Map<String, Long> clazzStudentCounter = new LinkedHashMap<>();
        for (Clazz clazz : clazzList) {
            clazzStudentCounter.put(clazz.getNo(), 0L);
        }

        Set<Integer> studentIds = new HashSet<>();
        List<StudentClazz> relations = studentClazzService.findByTeacherId(teacherId);
        if (!relations.isEmpty()) {
            for (StudentClazz relation : relations) {
                if (relation.getStudentId() != null) {
                    studentIds.add(relation.getStudentId());
                }
                if (StringUtils.hasText(relation.getClazzNo())) {
                    clazzStudentCounter.merge(relation.getClazzNo(), 1L, Long::sum);
                }
            }
        } else if (!clazzNos.isEmpty()) {
            // 兼容老数据：按 student.clazz_no 回填统计
            List<Student> fallbackStudents = studentService.list(
                    new LambdaQueryWrapper<Student>().in(Student::getClazzNo, clazzNos)
            );
            for (Student student : fallbackStudents) {
                if (student.getStudentId() != null) {
                    studentIds.add(student.getStudentId());
                }
                if (StringUtils.hasText(student.getClazzNo())) {
                    clazzStudentCounter.merge(student.getClazzNo(), 1L, Long::sum);
                }
            }
        }

        Set<Integer> experimentIds = experimentList.stream()
                .map(Experiment::getExperimentId)
                .filter(Objects::nonNull)
                .collect(Collectors.toSet());

        List<Score> scoreList = List.of();
        if (!studentIds.isEmpty() && !experimentIds.isEmpty()) {
            scoreList = scoreService.list(
                    new LambdaQueryWrapper<Score>()
                            .in(Score::getStudentId, studentIds)
                            .in(Score::getExperimentId, experimentIds)
            );
        }

        long completedPairs = scoreList.stream()
                .filter(s -> s.getStudentId() != null && s.getExperimentId() != null)
                .map(s -> s.getStudentId() + "_" + s.getExperimentId())
                .distinct()
                .count();
        long totalPairs = (long) studentIds.size() * experimentList.size();
        int completionRate = totalPairs <= 0 ? 0 : (int) Math.round(completedPairs * 100.0 / totalPairs);
        if (completionRate < 0) {
            completionRate = 0;
        } else if (completionRate > 100) {
            completionRate = 100;
        }

        int enabledExperimentCount = (int) experimentList.stream()
                .filter(exp -> exp.getState() != null && exp.getState() == 1)
                .count();
        int disabledExperimentCount = experimentList.size() - enabledExperimentCount;

        int[] scoreRanges = new int[]{0, 0, 0, 0, 0};
        for (Score score : scoreList) {
            if (score.getScore() == null) {
                continue;
            }
            int val = score.getScore();
            if (val < 60) {
                scoreRanges[0]++;
            } else if (val < 70) {
                scoreRanges[1]++;
            } else if (val < 80) {
                scoreRanges[2]++;
            } else if (val < 90) {
                scoreRanges[3]++;
            } else {
                scoreRanges[4]++;
            }
        }

        List<Map<String, Object>> classStudentDistribution = clazzStudentCounter.entrySet().stream()
                .map(e -> chartItem(e.getKey(), e.getValue()))
                .collect(Collectors.toList());

        List<Map<String, Object>> experimentStateDistribution = List.of(
                chartItem("鍚敤", enabledExperimentCount),
                chartItem("绂佺敤", disabledExperimentCount)
        );

        List<Map<String, Object>> scoreRangeDistribution = List.of(
                chartItem("0-59", scoreRanges[0]),
                chartItem("60-69", scoreRanges[1]),
                chartItem("70-79", scoreRanges[2]),
                chartItem("80-89", scoreRanges[3]),
                chartItem("90-100", scoreRanges[4])
        );

        List<Map<String, Object>> recentExperiments = experimentList.stream()
                .limit(5)
                .map(exp -> {
                    Map<String, Object> row = new HashMap<>();
                    row.put("experimentId", exp.getExperimentId());
                    row.put("experimentNo", exp.getExperimentNo());
                    row.put("experimentName", exp.getExperimentName());
                    row.put("state", exp.getState());
                    return row;
                })
                .collect(Collectors.toList());

        Map<String, Object> monitorData = buildMonitorData(teacherId);

        Map<String, Object> result = new HashMap<>();
        result.put("clazzCount", clazzList.size());
        result.put("studentCount", studentIds.size());
        result.put("experimentCount", experimentList.size());
        result.put("completionRate", completionRate);
        result.put("recentExperiments", recentExperiments);
        result.put("classStudentDistribution", classStudentDistribution);
        result.put("experimentStateDistribution", experimentStateDistribution);
        result.put("scoreRangeDistribution", scoreRangeDistribution);
        result.putAll(monitorData);

        return Result.success(result);
    }

    private Map<String, Object> buildMonitorData(Integer teacherId) {
        Map<String, Object> result = new HashMap<>();
        result.put("monitorTotalEvents", 0);
        result.put("monitorAffectedStudents", 0);
        result.put("monitorLatestAt", null);
        result.put("monitorTypeDistribution", List.of());
        result.put("recentMonitorEvents", List.of());

        List<Exam> exams = examService.list(
                new LambdaQueryWrapper<Exam>()
                        .eq(Exam::getTeacherId, teacherId)
                        .orderByDesc(Exam::getTime)
        );
        Set<Integer> examIds = exams.stream()
                .map(Exam::getId)
                .filter(Objects::nonNull)
                .collect(Collectors.toSet());
        if (examIds.isEmpty()) {
            return result;
        }

        List<ExamMonitorEvent> allEvents = examMonitorEventService.list(
                new LambdaQueryWrapper<ExamMonitorEvent>()
                        .in(ExamMonitorEvent::getExamId, examIds)
                        .orderByDesc(ExamMonitorEvent::getOccurredAt)
        );

        if (allEvents.isEmpty()) {
            return result;
        }

        Map<Integer, String> examNameMap = exams.stream()
                .collect(Collectors.toMap(Exam::getId, Exam::getExamName, (a, b) -> a));

        Set<Integer> monitorStudentIds = allEvents.stream()
                .map(ExamMonitorEvent::getStudentId)
                .filter(Objects::nonNull)
                .collect(Collectors.toSet());

        Map<Integer, Student> studentMap = monitorStudentIds.isEmpty() ? Map.of() :
                studentService.listByIds(monitorStudentIds).stream()
                        .collect(Collectors.toMap(Student::getStudentId, s -> s, (a, b) -> a));

        Map<String, Long> typeCounter = allEvents.stream()
                .collect(Collectors.groupingBy(
                        e -> normalizeEventType(e.getEventType()),
                        LinkedHashMap::new,
                        Collectors.counting()
                ));
        List<Map<String, Object>> monitorTypeDistribution = typeCounter.entrySet().stream()
                .map(e -> chartItem(e.getKey(), e.getValue()))
                .collect(Collectors.toList());

        LocalDateTime latestAt = allEvents.stream()
                .map(ExamMonitorEvent::getOccurredAt)
                .filter(Objects::nonNull)
                .max(LocalDateTime::compareTo)
                .orElse(null);

        List<Map<String, Object>> recentEvents = allEvents.stream()
                .sorted(Comparator.comparing(ExamMonitorEvent::getOccurredAt, Comparator.nullsLast(LocalDateTime::compareTo)).reversed())
                .limit(20)
                .map(event -> {
                    Student student = studentMap.get(event.getStudentId());
                    Map<String, Object> row = new HashMap<>();
                    row.put("id", event.getId());
                    row.put("examId", event.getExamId());
                    row.put("examName", examNameMap.getOrDefault(event.getExamId(), "-"));
                    row.put("studentId", event.getStudentId());
                    row.put("studentNo", student != null ? student.getStudentNo() : "-");
                    row.put("studentName", student != null ? student.getStudentName() : "-");
                    row.put("eventType", normalizeEventType(event.getEventType()));
                    row.put("eventDesc", event.getEventDesc());
                    row.put("occurredAt", event.getOccurredAt());
                    row.put("ip", event.getIp());
                    return row;
                })
                .collect(Collectors.toList());

        result.put("monitorTotalEvents", allEvents.size());
        result.put("monitorAffectedStudents", monitorStudentIds.size());
        result.put("monitorLatestAt", latestAt);
        result.put("monitorTypeDistribution", monitorTypeDistribution);
        result.put("recentMonitorEvents", recentEvents);
        return result;
    }

    private String normalizeEventType(String eventType) {
        if (!StringUtils.hasText(eventType)) {
            return "UNKNOWN";
        }
        String type = eventType.trim().toUpperCase();
        return switch (type) {
            case "TAB_HIDDEN" -> "TAB_HIDDEN";
            case "WINDOW_BLUR" -> "WINDOW_BLUR";
            default -> type;
        };
    }

    private Map<String, Object> chartItem(String name, Number value) {
        Map<String, Object> item = new HashMap<>();
        item.put("name", name);
        item.put("value", value == null ? 0 : value);
        return item;
    }

    private Integer getCurrentTeacherId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !StringUtils.hasText(authentication.getName())) {
            return null;
        }
        Teacher teacher = teacherService.findByAccount(authentication.getName());
        return teacher != null ? teacher.getTeacherId() : null;
    }
}
