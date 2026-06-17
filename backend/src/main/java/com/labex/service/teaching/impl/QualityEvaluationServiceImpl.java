package com.labex.service.teaching.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.labex.entity.Student;
import com.labex.entity.StudentCourseEvaluation;
import com.labex.entity.teaching.CourseOffering;
import com.labex.entity.teaching.QualityEvaluation;
import com.labex.mapper.StudentCourseEvaluationMapper;
import com.labex.mapper.StudentMapper;
import com.labex.mapper.teaching.CourseOfferingMapper;
import com.labex.mapper.teaching.QualityEvaluationMapper;
import com.labex.service.teaching.AchievementCalcEngine;
import com.labex.service.teaching.QualityEvaluationService;
import com.labex.vo.teaching.OfferingAchievementVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

@Service
@Slf4j
public class QualityEvaluationServiceImpl extends ServiceImpl<QualityEvaluationMapper, QualityEvaluation>
        implements QualityEvaluationService {

    private static final ObjectMapper JSON = new ObjectMapper();

    @Autowired
    private AchievementCalcEngine achievementEngine;

    @Autowired
    private CourseOfferingMapper offeringMapper;

    @Autowired
    private StudentCourseEvaluationMapper studentEvalMapper;

    @Autowired
    private StudentMapper studentMapper;

    @Override
    public List<QualityEvaluation> listByOffering(Integer offeringId) {
        return list(new LambdaQueryWrapper<QualityEvaluation>()
                .eq(QualityEvaluation::getOfferingId, offeringId)
                .orderByDesc(QualityEvaluation::getCreateTime));
    }

    @Override
    public QualityEvaluation getLatest(Integer offeringId) {
        return getOne(new LambdaQueryWrapper<QualityEvaluation>()
                .eq(QualityEvaluation::getOfferingId, offeringId)
                .orderByDesc(QualityEvaluation::getCreateTime)
                .last("LIMIT 1"));
    }

    @Override
    @Transactional
    public QualityEvaluation createDraft(Integer offeringId, Integer evaluatorId, String evalRound) {
        // 默认评价轮次为当前学年
        if (evalRound == null || evalRound.isBlank()) {
            int year = java.time.LocalDate.now().getYear();
            int month = java.time.LocalDate.now().getMonthValue();
            evalRound = (month >= 9 ? year : year - 1) + "-" + (month >= 9 ? year + 1 : year) + " 第1轮";
        }

        QualityEvaluation existing = getOne(new LambdaQueryWrapper<QualityEvaluation>()
                .eq(QualityEvaluation::getOfferingId, offeringId)
                .eq(QualityEvaluation::getEvalRound, evalRound));
        if (existing != null) {
            return existing;
        }

        QualityEvaluation eval = new QualityEvaluation();
        eval.setOfferingId(offeringId);
        eval.setEvaluatorId(evaluatorId);
        eval.setEvalRound(evalRound);
        eval.setStatus("draft");

        try {
            OfferingAchievementVO ach = achievementEngine.calcForOffering(offeringId);
            Map<String, Object> achMap = new HashMap<>();
            ach.getByObjective().values().forEach(s -> achMap.put(s.getCode(), s.getValue()));
            achMap.put("__overall__", ach.getOverallReachedRatio());
            eval.setAchievementValues(JSON.writeValueAsString(achMap));
        } catch (JsonProcessingException e) {
            log.warn("Failed to prefill achievement values for offering {}", offeringId, e);
        }

        save(eval);
        return eval;
    }

    @Override
    public QualityEvaluation saveEvaluation(Integer id, QualityEvaluation dto) {
        dto.setEvaluationId(id);
        updateById(dto);
        return getById(id);
    }

    @Override
    @Transactional
    public QualityEvaluation finalize(Integer id) {
        QualityEvaluation eval = getById(id);
        if (eval == null) {
            throw new RuntimeException("Evaluation not found");
        }

        eval.setStatus("finalized");
        updateById(eval);
        achievementEngine.snapshot(eval.getOfferingId(), "finalize evaluation " + id);

        CourseOffering offering = offeringMapper.selectById(eval.getOfferingId());
        if (offering != null && !"archived".equals(offering.getStatus())) {
            offering.setStatus("finished");
            offeringMapper.updateById(offering);
        }

        return eval;
    }

    @Override
    public Map<String, Object> getEvaluationStats(Integer offeringId) {
        Map<String, Object> stats = new HashMap<>();

        // 查询该开课的所有学生评价
        List<StudentCourseEvaluation> evaluations = studentEvalMapper.selectList(
                new LambdaQueryWrapper<StudentCourseEvaluation>()
                        .eq(StudentCourseEvaluation::getOfferingId, offeringId)
        );

        int totalCount = evaluations.size();
        stats.put("totalCount", totalCount);

        if (totalCount == 0) {
            stats.put("overallSatisfaction", 0);
            stats.put("teachingQuality", 0);
            stats.put("courseContent", 0);
            return stats;
        }

        // 计算总体满意度（4-5分为满意）
        long satisfiedCount = evaluations.stream()
                .filter(e -> e.getOverallSatisfaction() != null && e.getOverallSatisfaction() >= 4)
                .count();
        int overallSatisfaction = (int) Math.round((double) satisfiedCount / totalCount * 100);
        stats.put("overallSatisfaction", overallSatisfaction);

        // 计算教学质量平均分
        double teachingQuality = evaluations.stream()
                .filter(e -> e.getTeachingQuality() != null)
                .mapToInt(StudentCourseEvaluation::getTeachingQuality)
                .average()
                .orElse(0);
        stats.put("teachingQuality", Math.round(teachingQuality * 10) / 10.0);

        // 计算课程内容平均分
        double courseContent = evaluations.stream()
                .filter(e -> e.getCourseContent() != null)
                .mapToInt(StudentCourseEvaluation::getCourseContent)
                .average()
                .orElse(0);
        stats.put("courseContent", Math.round(courseContent * 10) / 10.0);

        return stats;
    }

    @Override
    public List<Map<String, Object>> getEvaluationDimensions(Integer offeringId) {
        List<Map<String, Object>> dimensions = new ArrayList<>();

        // 查询该开课的所有学生评价
        List<StudentCourseEvaluation> evaluations = studentEvalMapper.selectList(
                new LambdaQueryWrapper<StudentCourseEvaluation>()
                        .eq(StudentCourseEvaluation::getOfferingId, offeringId)
        );

        // 定义维度配置
        String[][] dimensionConfig = {
                {"teachingQuality", "教学质量"},
                {"courseContent", "课程内容"},
                {"learningResources", "学习资源"},
                {"assessmentMethod", "考核方式"},
                {"learningEffect", "学习效果"}
        };

        for (String[] config : dimensionConfig) {
            String key = config[0];
            String label = config[1];

            Map<String, Object> dim = new HashMap<>();
            dim.put("key", key);
            dim.put("label", label);

            // 获取该维度的分数列表
            List<Integer> scores = evaluations.stream()
                    .map(e -> {
                        switch (key) {
                            case "teachingQuality": return e.getTeachingQuality();
                            case "courseContent": return e.getCourseContent();
                            case "learningResources": return e.getLearningResources();
                            case "assessmentMethod": return e.getAssessmentMethod();
                            case "learningEffect": return e.getLearningEffect();
                            default: return null;
                        }
                    })
                    .filter(Objects::nonNull)
                    .collect(Collectors.toList());

            // 计算平均分
            double avgScore = scores.stream()
                    .mapToInt(Integer::intValue)
                    .average()
                    .orElse(0);
            dim.put("score", Math.round(avgScore * 10) / 10.0);

            // 计算分布
            Map<String, Object> distribution = new HashMap<>();
            for (int i = 1; i <= 5; i++) {
                final int star = i;
                long count = scores.stream().filter(s -> s == star).count();
                distribution.put(String.valueOf(star), count);
            }
            dim.put("distribution", distribution);

            dimensions.add(dim);
        }

        return dimensions;
    }

    @Override
    public List<Map<String, Object>> getStudentComments(Integer offeringId) {
        List<Map<String, Object>> comments = new ArrayList<>();

        // 查询有文字评价的学生评价
        List<StudentCourseEvaluation> evaluations = studentEvalMapper.selectList(
                new LambdaQueryWrapper<StudentCourseEvaluation>()
                        .eq(StudentCourseEvaluation::getOfferingId, offeringId)
                        .and(w -> w.isNotNull(StudentCourseEvaluation::getComment)
                                .or()
                                .isNotNull(StudentCourseEvaluation::getSuggestion))
                        .orderByDesc(StudentCourseEvaluation::getCreateTime)
        );

        // 获取学生ID列表
        List<Integer> studentIds = evaluations.stream()
                .map(StudentCourseEvaluation::getStudentId)
                .distinct()
                .collect(Collectors.toList());

        // 批量查询学生信息
        Map<Integer, Student> studentMap = new HashMap<>();
        if (!studentIds.isEmpty()) {
            List<Student> students = studentMapper.selectBatchIds(studentIds);
            studentMap = students.stream()
                    .collect(Collectors.toMap(Student::getStudentId, s -> s));
        }

        // 组装返回数据
        for (StudentCourseEvaluation eval : evaluations) {
            Map<String, Object> comment = new HashMap<>();

            Student student = studentMap.get(eval.getStudentId());
            comment.put("studentName", student != null ? student.getStudentName() : "匿名学生");
            comment.put("createTime", eval.getCreateTime());
            comment.put("content", eval.getComment() != null ? eval.getComment() : "");
            comment.put("suggestion", eval.getSuggestion() != null ? eval.getSuggestion() : "");

            comments.add(comment);
        }

        return comments;
    }
}
