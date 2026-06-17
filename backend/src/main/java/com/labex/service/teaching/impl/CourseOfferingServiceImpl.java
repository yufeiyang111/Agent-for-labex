package com.labex.service.teaching.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.Clazz;
import com.labex.entity.teaching.CourseObjective;
import com.labex.entity.teaching.CourseOffering;
import com.labex.entity.teaching.ScoringItem;
import com.labex.entity.teaching.ScoringItemObjective;
import com.labex.mapper.ClazzMapper;
import com.labex.mapper.teaching.CourseObjectiveMapper;
import com.labex.mapper.teaching.CourseOfferingMapper;
import com.labex.mapper.teaching.ScoringItemMapper;
import com.labex.mapper.teaching.ScoringItemObjectiveMapper;
import com.labex.service.StudentService;
import com.labex.service.teaching.AchievementCalcEngine;
import com.labex.service.teaching.CourseOfferingService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

@Service
@Slf4j
public class CourseOfferingServiceImpl extends ServiceImpl<CourseOfferingMapper, CourseOffering>
        implements CourseOfferingService {

    @Autowired private CourseObjectiveMapper objectiveMapper;
    @Autowired private ScoringItemMapper scoringItemMapper;
    @Autowired private ScoringItemObjectiveMapper scoringItemObjectiveMapper;
    @Autowired private ClazzMapper clazzMapper;
    @Autowired private StudentService studentService;
    @Autowired private AchievementCalcEngine achievementCalcEngine;

    @Override
    public List<CourseOffering> listByCourse(Integer courseId) {
        return list(new LambdaQueryWrapper<CourseOffering>()
                .eq(CourseOffering::getCourseId, courseId)
                .ne(CourseOffering::getStatus, "archived")
                .orderByDesc(CourseOffering::getSemester));
    }

    @Override
    public List<CourseOffering> listByTeacher(Integer teacherId) {
        return list(new LambdaQueryWrapper<CourseOffering>()
                .eq(CourseOffering::getTeacherId, teacherId)
                .ne(CourseOffering::getStatus, "archived")
                .orderByDesc(CourseOffering::getSemester));
    }

    @Override
    @Transactional
    public CourseOffering createOffering(Integer courseId, String clazzNo, Integer teacherId, String semester) {
        if (courseId == null) {
            throw new RuntimeException("Course is required");
        }
        if (teacherId == null) {
            throw new RuntimeException("Teacher identity is missing");
        }
        String normalizedClazzNo = clazzNo == null ? "" : clazzNo.trim();
        String normalizedSemester = semester == null ? "" : semester.trim();
        if (normalizedClazzNo.isBlank()) {
            throw new RuntimeException("Class is required");
        }
        if (normalizedSemester.isBlank()) {
            throw new RuntimeException("Semester is required");
        }

        Clazz clazz = clazzMapper.selectById(normalizedClazzNo);
        if (clazz == null) {
            throw new RuntimeException("Class does not exist: " + normalizedClazzNo);
        }
        if (clazz.getTeacherId() != null && !clazz.getTeacherId().equals(teacherId)) {
            throw new RuntimeException("The class does not belong to current teacher");
        }
        if (clazz.getState() != null && clazz.getState() == 0) {
            throw new RuntimeException("The class is disabled");
        }

        CourseOffering existing = getOne(new LambdaQueryWrapper<CourseOffering>()
                .eq(CourseOffering::getCourseId, courseId)
                .eq(CourseOffering::getClazzNo, normalizedClazzNo)
                .eq(CourseOffering::getSemester, normalizedSemester));
        if (existing != null) {
            if (existing.getTeacherId() != null && !existing.getTeacherId().equals(teacherId)) {
                throw new RuntimeException("This course/class/semester offering belongs to another teacher");
            }
            existing.setTeacherId(teacherId);
            existing.setStudentCount(countStudents(normalizedClazzNo));
            if (existing.getStatus() == null || existing.getStatus().isBlank()) {
                existing.setStatus("active");
            }
            updateById(existing);
            ensureDefaultScoringItems(existing);
            return existing;
        }

        CourseOffering offering = new CourseOffering();
        offering.setCourseId(courseId);
        offering.setClazzNo(normalizedClazzNo);
        offering.setTeacherId(teacherId);
        offering.setSemester(normalizedSemester);
        offering.setStatus("active");
        offering.setStudentCount(countStudents(normalizedClazzNo));
        save(offering);
        ensureDefaultScoringItems(offering);
        log.info("Created offering courseId={}, clazzNo={}, semester={}", courseId, normalizedClazzNo, normalizedSemester);
        return offering;
    }

    @Override
    @Transactional
    public CourseOffering cloneOffering(Integer sourceOfferingId, String clazzNo) {
        CourseOffering source = getById(sourceOfferingId);
        if (source == null) {
            throw new RuntimeException("Source offering not found");
        }

        String normalizedClazzNo = clazzNo == null ? "" : clazzNo.trim();
        if (normalizedClazzNo.isBlank()) {
            throw new RuntimeException("Class is required");
        }

        // 检查是否已存在相同配置的开课
        CourseOffering existing = getOne(new LambdaQueryWrapper<CourseOffering>()
                .eq(CourseOffering::getCourseId, source.getCourseId())
                .eq(CourseOffering::getClazzNo, normalizedClazzNo)
                .eq(CourseOffering::getSemester, source.getSemester()));
        if (existing != null) {
            throw new RuntimeException("班级 " + normalizedClazzNo + " 在学期 " + source.getSemester() + " 已存在此课程的开课");
        }

        // 不能复制到自己
        if (source.getClazzNo().equals(normalizedClazzNo)) {
            throw new RuntimeException("不能复制到源开课相同的班级");
        }

        // 创建新开课
        CourseOffering newOffering = new CourseOffering();
        newOffering.setCourseId(source.getCourseId());
        newOffering.setClazzNo(normalizedClazzNo);
        newOffering.setTeacherId(source.getTeacherId());
        newOffering.setSemester(source.getSemester());
        newOffering.setStatus(source.getStatus());
        newOffering.setStudentCount(countStudents(normalizedClazzNo));
        save(newOffering);

        // 复制评分项
        List<ScoringItem> sourceItems = scoringItemMapper.selectList(
                new LambdaQueryWrapper<ScoringItem>()
                        .eq(ScoringItem::getOfferingId, sourceOfferingId));

        for (ScoringItem sourceItem : sourceItems) {
            ScoringItem newItem = new ScoringItem();
            newItem.setOfferingId(newOffering.getOfferingId());
            newItem.setName(sourceItem.getName());
            newItem.setType(sourceItem.getType());
            newItem.setMaxScore(sourceItem.getMaxScore());
            newItem.setPassingScore(sourceItem.getPassingScore());
            newItem.setWeight(sourceItem.getWeight());
            newItem.setSortOrder(sourceItem.getSortOrder());
            scoringItemMapper.insert(newItem);

            // 复制评分项与课程目标的关联
            List<ScoringItemObjective> links = scoringItemObjectiveMapper.selectList(
                    new LambdaQueryWrapper<ScoringItemObjective>()
                            .eq(ScoringItemObjective::getItemId, sourceItem.getItemId()));

            for (ScoringItemObjective link : links) {
                ScoringItemObjective newLink = new ScoringItemObjective();
                newLink.setItemId(newItem.getItemId());
                newLink.setObjectiveId(link.getObjectiveId());
                newLink.setWeightInObjective(link.getWeightInObjective());
                scoringItemObjectiveMapper.insert(newLink);
            }
        }

        log.info("Cloned offering {} to new offering {} for clazz {}", sourceOfferingId, newOffering.getOfferingId(), normalizedClazzNo);
        return newOffering;
    }

    @Override
    @Transactional
    public CourseOffering refreshStudentCount(Integer offeringId) {
        CourseOffering offering = getById(offeringId);
        if (offering == null) {
            throw new RuntimeException("Offering not found");
        }
        offering.setStudentCount(countStudents(offering.getClazzNo()));
        updateById(offering);
        return offering;
    }

    @Override
    @Transactional
    public CourseOffering updateStatus(Integer offeringId, Integer teacherId, String status) {
        CourseOffering offering = getById(offeringId);
        if (offering == null) {
            throw new RuntimeException("Offering not found");
        }
        if (teacherId != null && offering.getTeacherId() != null && !teacherId.equals(offering.getTeacherId())) {
            throw new RuntimeException("No permission to update this offering");
        }
        String normalizedStatus = normalizeStatus(status);
        offering.setStudentCount(countStudents(offering.getClazzNo()));
        if ("finished".equals(normalizedStatus)) {
            achievementCalcEngine.snapshot(offeringId, "finish offering");
        }
        offering.setStatus(normalizedStatus);
        updateById(offering);
        return offering;
    }

    private int countStudents(String clazzNo) {
        List<com.labex.entity.Student> students = studentService.listByTeachingClazz(clazzNo);
        return students == null ? 0 : students.size();
    }

    private String normalizeStatus(String status) {
        if (status == null || status.isBlank()) {
            throw new RuntimeException("Status is required");
        }
        String value = status.trim().toLowerCase();
        if (!List.of("draft", "active", "finished", "archived").contains(value)) {
            throw new RuntimeException("Unsupported offering status: " + status);
        }
        return value;
    }

    private void ensureDefaultScoringItems(CourseOffering offering) {
        Long count = scoringItemMapper.selectCount(new LambdaQueryWrapper<ScoringItem>()
                .eq(ScoringItem::getOfferingId, offering.getOfferingId()));
        if (count != null && count > 0) {
            return;
        }

        List<CourseObjective> objectives = objectiveMapper.selectList(new LambdaQueryWrapper<CourseObjective>()
                .eq(CourseObjective::getCourseId, offering.getCourseId())
                .orderByAsc(CourseObjective::getSortOrder)
                .orderByAsc(CourseObjective::getCode));

        createDefaultItem(offering.getOfferingId(), "Homework", "homework", new BigDecimal("0.20"), 0, objectives);
        createDefaultItem(offering.getOfferingId(), "Practice", "experiment", new BigDecimal("0.30"), 1, objectives);
        createDefaultItem(offering.getOfferingId(), "Final", "exam", new BigDecimal("0.50"), 2, objectives);
        log.info("Created default scoring items for offering {}", offering.getOfferingId());
    }

    private void createDefaultItem(Integer offeringId, String name, String type, BigDecimal weight,
                                   int sortOrder, List<CourseObjective> objectives) {
        ScoringItem item = new ScoringItem();
        item.setOfferingId(offeringId);
        item.setName(name);
        item.setType(type);
        item.setMaxScore(100);
        item.setPassingScore(70);
        item.setWeight(weight);
        item.setSortOrder(sortOrder);
        scoringItemMapper.insert(item);

        if (objectives == null || objectives.isEmpty()) {
            return;
        }
        BigDecimal linkWeight = BigDecimal.ONE.divide(new BigDecimal(objectives.size()), 4, java.math.RoundingMode.HALF_UP);
        for (CourseObjective objective : objectives) {
            ScoringItemObjective link = new ScoringItemObjective();
            link.setItemId(item.getItemId());
            link.setObjectiveId(objective.getObjectiveId());
            link.setWeightInObjective(linkWeight);
            scoringItemObjectiveMapper.insert(link);
        }
    }
}
