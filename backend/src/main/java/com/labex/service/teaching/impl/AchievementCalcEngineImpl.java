package com.labex.service.teaching.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.labex.entity.Student;
import com.labex.entity.teaching.*;
import com.labex.mapper.teaching.*;
import com.labex.service.StudentService;
import com.labex.service.teaching.AchievementCalcEngine;
import com.labex.vo.teaching.OfferingAchievementVO;
import com.labex.vo.teaching.StudentAchievementVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 达成度计算引擎实现
 * 算法对齐《课程分组及成绩明细表.xlsx》Sheet「成绩明细表」的行 145-197：
 * 个体达成度 = Σ(得分×权重) / Σ(满分×权重)
 * 班级达成度 = 达成期望分值的学生数 / 参与评价的学生总数
 */
@Service
@Slf4j
public class AchievementCalcEngineImpl implements AchievementCalcEngine {

    private static final BigDecimal PASSING_RATIO = new BigDecimal("0.6");  // 总成绩及格阈值
    private static final int SCALE = 6;

    @Autowired private ScoringItemMapper itemMapper;
    @Autowired private ScoringItemObjectiveMapper linkMapper;
    @Autowired private ScoringScoreMapper scoreMapper;
    @Autowired private CourseObjectiveMapper objectiveMapper;
    @Autowired private CourseOfferingMapper offeringMapper;
    @Autowired private AchievementSnapshotMapper snapshotMapper;
    @Autowired private StudentService studentService;

    @Override
    public StudentAchievementVO calcForStudent(Integer offeringId, Integer studentId) {
        StudentAchievementVO vo = new StudentAchievementVO();
        vo.setStudentId(studentId);

        Student stu = studentService.getById(studentId);
        if (stu != null) {
            vo.setStudentNo(stu.getStudentNo());
            vo.setStudentName(stu.getStudentName());
        }

        // 1. 取该 offering 的所有评分项 + 该学生的得分
        List<ScoringItem> items = itemMapper.selectList(new LambdaQueryWrapper<ScoringItem>()
                .eq(ScoringItem::getOfferingId, offeringId));
        if (items.isEmpty()) {
            vo.setObjectiveAchievements(Collections.emptyMap());
            vo.setTotalAchievement(BigDecimal.ZERO);
            vo.setTotalWeightedScore(BigDecimal.ZERO);
            vo.setTotalWeightedMax(BigDecimal.ZERO);
            return vo;
        }

        List<Integer> itemIds = items.stream().map(ScoringItem::getItemId).collect(Collectors.toList());
        Map<Integer, BigDecimal> scoreMap = scoreMapper.selectList(new LambdaQueryWrapper<ScoringScore>()
                        .eq(ScoringScore::getStudentId, studentId)
                        .in(ScoringScore::getItemId, itemIds))
                .stream()
                .collect(Collectors.toMap(ScoringScore::getItemId,
                        s -> s.getScore() == null ? BigDecimal.ZERO : s.getScore()));

        // 2. 取该课程目标
        CourseOffering offering = offeringMapper.selectById(offeringId);
        if (offering == null) {
            log.warn("Offering {} not found", offeringId);
            return vo;
        }
        List<CourseObjective> objectives = objectiveMapper.selectList(new LambdaQueryWrapper<CourseObjective>()
                .eq(CourseObjective::getCourseId, offering.getCourseId()));

        // 3. 取 item↔objective 关联
        Map<Integer, Set<Integer>> itemToObjs = new HashMap<>();
        List<ScoringItemObjective> links = linkMapper.selectList(new LambdaQueryWrapper<ScoringItemObjective>()
                .in(ScoringItemObjective::getItemId, itemIds));
        for (ScoringItemObjective l : links) {
            itemToObjs.computeIfAbsent(l.getItemId(), k -> new HashSet<>()).add(l.getObjectiveId());
        }

        // 4. 按目标聚合：Σ(score × weight) / Σ(max × weight)
        Map<Integer, BigDecimal> objAch = new LinkedHashMap<>();
        for (CourseObjective obj : objectives) {
            BigDecimal weightedSum = BigDecimal.ZERO;
            BigDecimal weightedMax = BigDecimal.ZERO;
            for (ScoringItem item : items) {
                Set<Integer> objs = itemToObjs.getOrDefault(item.getItemId(), Collections.emptySet());
                if (!objs.contains(obj.getObjectiveId())) {
                    continue;
                }
                BigDecimal score = scoreMap.getOrDefault(item.getItemId(), BigDecimal.ZERO);
                BigDecimal weight = item.getWeight() == null ? BigDecimal.ZERO : item.getWeight();
                BigDecimal max = BigDecimal.valueOf(item.getMaxScore() == null ? 100 : item.getMaxScore());
                weightedSum = weightedSum.add(score.multiply(weight));
                weightedMax = weightedMax.add(max.multiply(weight));
            }
            BigDecimal ach = weightedMax.compareTo(BigDecimal.ZERO) > 0
                    ? weightedSum.divide(weightedMax, SCALE, RoundingMode.HALF_UP)
                    : BigDecimal.ZERO;
            objAch.put(obj.getObjectiveId(), ach);
        }
        vo.setObjectiveAchievements(objAch);

        // 5. 总达成度：考虑所有评分项加权
        BigDecimal totalSum = BigDecimal.ZERO;
        BigDecimal totalMax = BigDecimal.ZERO;
        for (ScoringItem item : items) {
            BigDecimal score = scoreMap.getOrDefault(item.getItemId(), BigDecimal.ZERO);
            BigDecimal weight = item.getWeight() == null ? BigDecimal.ZERO : item.getWeight();
            BigDecimal max = BigDecimal.valueOf(item.getMaxScore() == null ? 100 : item.getMaxScore());
            totalSum = totalSum.add(score.multiply(weight));
            totalMax = totalMax.add(max.multiply(weight));
        }
        vo.setTotalWeightedScore(totalSum);
        vo.setTotalWeightedMax(totalMax);
        vo.setTotalAchievement(totalMax.compareTo(BigDecimal.ZERO) > 0
                ? totalSum.divide(totalMax, SCALE, RoundingMode.HALF_UP)
                : BigDecimal.ZERO);

        return vo;
    }

    @Override
    public OfferingAchievementVO calcForOffering(Integer offeringId) {
        OfferingAchievementVO vo = new OfferingAchievementVO();
        vo.setOfferingId(offeringId);

        CourseOffering offering = offeringMapper.selectById(offeringId);
        if (offering == null) {
            vo.setByObjective(Collections.emptyMap());
            vo.setOverallReachedRatio(BigDecimal.ZERO);
            vo.setStudents(Collections.emptyList());
            return vo;
        }

        // 1. 取该班级所有学生
        List<Student> students = studentService.list(new LambdaQueryWrapper<Student>()
                .eq(Student::getClazzNo, offering.getClazzNo()));
        if (students.isEmpty()) {
            vo.setByObjective(Collections.emptyMap());
            vo.setOverallReachedRatio(BigDecimal.ZERO);
            vo.setStudents(Collections.emptyList());
            return vo;
        }

        // 2. 取所有目标
        List<CourseObjective> objectives = objectiveMapper.selectList(new LambdaQueryWrapper<CourseObjective>()
                .eq(CourseObjective::getCourseId, offering.getCourseId()));

        // 3. 计算所有学生
        List<StudentAchievementVO> studentVOs = students.stream()
                .map(s -> calcForStudent(offeringId, s.getStudentId()))
                .collect(Collectors.toList());
        vo.setStudents(studentVOs);

        // 4. 按目标聚合
        Map<Integer, OfferingAchievementVO.ObjectiveSummary> byObj = new LinkedHashMap<>();
        // 目标的期望比例 = 该目标下评分项的加权 passing / 加权 max
        Map<Integer, BigDecimal> objPassingRatio = calcObjectivePassingRatio(offeringId, objectives);

        for (CourseObjective obj : objectives) {
            OfferingAchievementVO.ObjectiveSummary sum = new OfferingAchievementVO.ObjectiveSummary();
            sum.setObjectiveId(obj.getObjectiveId());
            sum.setCode(obj.getCode());
            sum.setDescription(obj.getDescription());
            BigDecimal threshold = objPassingRatio.getOrDefault(obj.getObjectiveId(), new BigDecimal("0.7"));
            sum.setExpectedRatio(threshold);

            int reached = 0;
            BigDecimal achSum = BigDecimal.ZERO;
            for (StudentAchievementVO svo : studentVOs) {
                BigDecimal ach = svo.getObjectiveAchievements().getOrDefault(obj.getObjectiveId(), BigDecimal.ZERO);
                achSum = achSum.add(ach);
                if (ach.compareTo(threshold) >= 0) {
                    reached++;
                }
            }
            sum.setReachedCount(reached);
            sum.setTotalCount(studentVOs.size());
            sum.setValue(studentVOs.isEmpty() ? BigDecimal.ZERO
                    : BigDecimal.valueOf(reached).divide(BigDecimal.valueOf(studentVOs.size()), SCALE, RoundingMode.HALF_UP));
            sum.setAvgScore(studentVOs.isEmpty() ? BigDecimal.ZERO
                    : achSum.divide(BigDecimal.valueOf(studentVOs.size()), SCALE, RoundingMode.HALF_UP));
            byObj.put(obj.getObjectiveId(), sum);
        }
        vo.setByObjective(byObj);

        // 5. 总达成（总成绩 >= 60% 的学生比例）
        long totalReached = studentVOs.stream()
                .filter(s -> s.getTotalAchievement().compareTo(PASSING_RATIO) >= 0)
                .count();
        vo.setOverallReachedRatio(studentVOs.isEmpty() ? BigDecimal.ZERO
                : BigDecimal.valueOf(totalReached).divide(BigDecimal.valueOf(studentVOs.size()), SCALE, RoundingMode.HALF_UP));

        return vo;
    }

    /** 计算每个目标的"达成期望比例" = Σ(passing_score × weight) / Σ(max_score × weight) */
    private Map<Integer, BigDecimal> calcObjectivePassingRatio(Integer offeringId, List<CourseObjective> objectives) {
        Map<Integer, BigDecimal> result = new HashMap<>();
        List<ScoringItem> items = itemMapper.selectList(new LambdaQueryWrapper<ScoringItem>()
                .eq(ScoringItem::getOfferingId, offeringId));
        if (items.isEmpty()) {
            return result;
        }
        List<Integer> itemIds = items.stream().map(ScoringItem::getItemId).collect(Collectors.toList());
        List<ScoringItemObjective> links = linkMapper.selectList(new LambdaQueryWrapper<ScoringItemObjective>()
                .in(ScoringItemObjective::getItemId, itemIds));
        Map<Integer, Set<Integer>> itemToObjs = new HashMap<>();
        for (ScoringItemObjective l : links) {
            itemToObjs.computeIfAbsent(l.getItemId(), k -> new HashSet<>()).add(l.getObjectiveId());
        }

        for (CourseObjective obj : objectives) {
            BigDecimal weightedPass = BigDecimal.ZERO;
            BigDecimal weightedMax = BigDecimal.ZERO;
            for (ScoringItem item : items) {
                Set<Integer> objs = itemToObjs.getOrDefault(item.getItemId(), Collections.emptySet());
                if (!objs.contains(obj.getObjectiveId())) continue;
                BigDecimal weight = item.getWeight() == null ? BigDecimal.ZERO : item.getWeight();
                weightedPass = weightedPass.add(BigDecimal.valueOf(item.getPassingScore() == null ? 70 : item.getPassingScore()).multiply(weight));
                weightedMax = weightedMax.add(BigDecimal.valueOf(item.getMaxScore() == null ? 100 : item.getMaxScore()).multiply(weight));
            }
            if (weightedMax.compareTo(BigDecimal.ZERO) > 0) {
                result.put(obj.getObjectiveId(), weightedPass.divide(weightedMax, SCALE, RoundingMode.HALF_UP));
            } else {
                result.put(obj.getObjectiveId(), new BigDecimal("0.7"));
            }
        }
        return result;
    }

    @Override
    @Transactional
    public void snapshot(Integer offeringId, String reason) {
        OfferingAchievementVO vo = calcForOffering(offeringId);
        // 取下一版本号
        Integer maxVersion = snapshotMapper.selectList(new LambdaQueryWrapper<AchievementSnapshot>()
                        .eq(AchievementSnapshot::getOfferingId, offeringId))
                .stream()
                .map(AchievementSnapshot::getVersion)
                .max(Integer::compareTo)
                .orElse(0);
        int version = maxVersion + 1;
        LocalDateTime now = LocalDateTime.now();

        // 班级聚合（student_id = null）
        for (OfferingAchievementVO.ObjectiveSummary sum : vo.getByObjective().values()) {
            AchievementSnapshot snap = new AchievementSnapshot();
            snap.setOfferingId(offeringId);
            snap.setObjectiveId(sum.getObjectiveId());
            snap.setStudentId(null);
            snap.setAchievementValue(sum.getValue());
            snap.setReachedCount(sum.getReachedCount());
            snap.setTotalCount(sum.getTotalCount());
            snap.setCalcTime(now);
            snap.setVersion(version);
            snapshotMapper.insert(snap);
        }
        // 课程总目标（objective_id = null, student_id = null）
        AchievementSnapshot total = new AchievementSnapshot();
        total.setOfferingId(offeringId);
        total.setStudentId(null);
        total.setObjectiveId(null);
        total.setAchievementValue(vo.getOverallReachedRatio());
        total.setCalcTime(now);
        total.setVersion(version);
        snapshotMapper.insert(total);

        // 学生个体（每个学生每个目标）
        for (StudentAchievementVO svo : vo.getStudents()) {
            for (Map.Entry<Integer, BigDecimal> e : svo.getObjectiveAchievements().entrySet()) {
                AchievementSnapshot snap = new AchievementSnapshot();
                snap.setOfferingId(offeringId);
                snap.setStudentId(svo.getStudentId());
                snap.setObjectiveId(e.getKey());
                snap.setAchievementValue(e.getValue());
                snap.setCalcTime(now);
                snap.setVersion(version);
                snapshotMapper.insert(snap);
            }
            // 学生总达成
            AchievementSnapshot stuTotal = new AchievementSnapshot();
            stuTotal.setOfferingId(offeringId);
            stuTotal.setStudentId(svo.getStudentId());
            stuTotal.setObjectiveId(null);
            stuTotal.setAchievementValue(svo.getTotalAchievement());
            stuTotal.setWeightedScore(svo.getTotalWeightedScore());
            stuTotal.setWeightedMax(svo.getTotalWeightedMax());
            stuTotal.setCalcTime(now);
            stuTotal.setVersion(version);
            snapshotMapper.insert(stuTotal);
        }
        log.info("Achievement snapshot v{} created for offering {}: {}",
                version, offeringId, reason);
    }

    @Override
    public List<AchievementSnapshot> getSnapshots(Integer offeringId) {
        return snapshotMapper.selectList(new LambdaQueryWrapper<AchievementSnapshot>()
                .eq(AchievementSnapshot::getOfferingId, offeringId)
                .orderByDesc(AchievementSnapshot::getVersion)
                .orderByDesc(AchievementSnapshot::getCalcTime));
    }
}
