package com.labex.service.teaching.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.Exam;
import com.labex.entity.Experiment;
import com.labex.entity.Homework;
import com.labex.entity.teaching.CourseOffering;
import com.labex.entity.teaching.ScoringItem;
import com.labex.entity.teaching.ScoringItemObjective;
import com.labex.mapper.teaching.CourseOfferingMapper;
import com.labex.mapper.teaching.ScoringItemMapper;
import com.labex.mapper.teaching.ScoringItemObjectiveMapper;
import com.labex.service.ExamService;
import com.labex.service.ExperimentService;
import com.labex.service.HomeworkService;
import com.labex.service.teaching.ScoringItemService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
public class ScoringItemServiceImpl extends ServiceImpl<ScoringItemMapper, ScoringItem>
        implements ScoringItemService {

    private static final BigDecimal WEIGHT_TOLERANCE = new BigDecimal("0.0001");

    @Autowired
    private ScoringItemObjectiveMapper linkMapper;

    @Autowired
    private CourseOfferingMapper offeringMapper;

    @Autowired
    private HomeworkService homeworkService;

    @Autowired
    private ExperimentService experimentService;

    @Autowired
    private ExamService examService;

    @Override
    public List<ScoringItem> listByOffering(Integer offeringId) {
        return list(new LambdaQueryWrapper<ScoringItem>()
                .eq(ScoringItem::getOfferingId, offeringId)
                .orderByAsc(ScoringItem::getSortOrder)
                .orderByAsc(ScoringItem::getItemId));
    }

    @Override
    @Transactional
    public ScoringItem createItem(ScoringItem item, List<ScoringItemObjective> objectiveLinks) {
        if (item.getSortOrder() == null) {
            item.setSortOrder(0);
        }
        if (item.getMaxScore() == null) {
            item.setMaxScore(100);
        }
        if (item.getPassingScore() == null) {
            item.setPassingScore(70);
        }
        save(item);
        if (objectiveLinks != null) {
            for (ScoringItemObjective link : objectiveLinks) {
                link.setItemId(item.getItemId());
                if (link.getWeightInObjective() == null) {
                    link.setWeightInObjective(BigDecimal.ONE);
                }
                linkMapper.insert(link);
            }
        }
        return item;
    }

    @Override
    @Transactional
    public void updateItem(Integer itemId, ScoringItem item, List<ScoringItemObjective> objectiveLinks) {
        item.setItemId(itemId);
        updateById(item);
        // 全量覆盖目标关联
        linkMapper.delete(new LambdaQueryWrapper<ScoringItemObjective>()
                .eq(ScoringItemObjective::getItemId, itemId));
        if (objectiveLinks != null) {
            for (ScoringItemObjective link : objectiveLinks) {
                link.setItemId(itemId);
                if (link.getWeightInObjective() == null) {
                    link.setWeightInObjective(BigDecimal.ONE);
                }
                linkMapper.insert(link);
            }
        }
    }

    @Override
    @Transactional
    public void deleteItem(Integer itemId) {
        linkMapper.delete(new LambdaQueryWrapper<ScoringItemObjective>()
                .eq(ScoringItemObjective::getItemId, itemId));
        removeById(itemId);
    }

    @Override
    public boolean validateWeightSum(Integer offeringId) {
        List<ScoringItem> items = listByOffering(offeringId);
        if (items.isEmpty()) {
            return false;
        }
        BigDecimal sum = items.stream()
                .map(i -> i.getWeight() == null ? BigDecimal.ZERO : i.getWeight())
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        return sum.subtract(BigDecimal.ONE).abs().compareTo(WEIGHT_TOLERANCE) < 0;
    }

    @Override
    public List<ScoringItemObjective> listObjectiveLinks(Integer itemId) {
        return linkMapper.selectList(new LambdaQueryWrapper<ScoringItemObjective>()
                .eq(ScoringItemObjective::getItemId, itemId));
    }

    @Override
    public List<ScoringItem> suggestFromExistingTasks(Integer offeringId) {
        CourseOffering offering = offeringMapper.selectById(offeringId);
        if (offering == null) {
            return new ArrayList<>();
        }
        Integer teacherId = offering.getTeacherId();
        List<ScoringItem> suggestions = new ArrayList<>();
        int sort = 0;

        // 作业建议
        List<Homework> homeworks = homeworkService.list(new LambdaQueryWrapper<Homework>()
                .eq(Homework::getTeacherId, teacherId)
                .eq(Homework::getState, 1)
                .orderByAsc(Homework::getHomeworkId));
        int hwIdx = 1;
        for (Homework hw : homeworks) {
            ScoringItem item = new ScoringItem();
            item.setOfferingId(offeringId);
            item.setName(hw.getHomeworkName() != null ? hw.getHomeworkName() : ("作业" + hwIdx));
            item.setType("homework");
            item.setSourceTable("t_homework");
            item.setSourceId(hw.getHomeworkId());
            item.setMaxScore(hw.getTotalScore() != null ? hw.getTotalScore() : 100);
            item.setPassingScore(70);
            item.setWeight(BigDecimal.ZERO);  // 待教师手动设置
            item.setSortOrder(sort++);
            suggestions.add(item);
            hwIdx++;
        }

        // 实验建议
        List<Experiment> experiments = experimentService.list(new LambdaQueryWrapper<Experiment>()
                .eq(Experiment::getTeacherId, teacherId)
                .eq(Experiment::getState, 1)
                .orderByAsc(Experiment::getExperimentNo));
        int expIdx = 1;
        for (Experiment exp : experiments) {
            ScoringItem item = new ScoringItem();
            item.setOfferingId(offeringId);
            item.setName(exp.getExperimentName() != null ? exp.getExperimentName() : ("实验" + expIdx));
            item.setType("experiment");
            item.setSourceTable("t_experiment");
            item.setSourceId(exp.getExperimentId());
            item.setMaxScore(100);
            item.setPassingScore(70);
            item.setWeight(BigDecimal.ZERO);
            item.setSortOrder(sort++);
            suggestions.add(item);
            expIdx++;
        }

        // 考试建议
        List<Exam> exams = examService.list(new LambdaQueryWrapper<Exam>()
                .eq(Exam::getTeacherId, teacherId));
        int examIdx = 1;
        for (Exam exam : exams) {
            ScoringItem item = new ScoringItem();
            item.setOfferingId(offeringId);
            item.setName(exam.getExamName() != null ? exam.getExamName() : ("考试" + examIdx));
            item.setType("exam");
            item.setSourceTable("t_exam");
            item.setSourceId(exam.getId());
            item.setMaxScore(exam.getTotalScore() != null ? exam.getTotalScore() : 100);
            item.setPassingScore(70);
            item.setWeight(BigDecimal.ZERO);
            item.setSortOrder(sort++);
            suggestions.add(item);
            examIdx++;
        }

        log.info("Suggested {} scoring items for offering {} (hw={}, exp={}, exam={})",
                suggestions.size(), offeringId, homeworks.size(), experiments.size(), exams.size());
        return suggestions;
    }
}
