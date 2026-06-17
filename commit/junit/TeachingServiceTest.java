package com.labex.service.impl;

import com.labex.entity.Course;
import com.labex.entity.CourseOffering;
import com.labex.entity.Syllabus;
import com.labex.entity.CourseObjective;
import com.labex.entity.GraduationRequirement;
import com.labex.entity.ScoringItem;
import com.labex.entity.ScoringScore;
import com.labex.entity.QualityEvaluation;
import com.labex.entity.QualityReport;
import com.labex.mapper.CourseMapper;
import com.labex.mapper.CourseOfferingMapper;
import com.labex.mapper.SyllabusMapper;
import com.labex.mapper.CourseObjectiveMapper;
import com.labex.mapper.GraduationRequirementMapper;
import com.labex.mapper.ScoringItemMapper;
import com.labex.mapper.ScoringScoreMapper;
import com.labex.mapper.QualityEvaluationMapper;
import com.labex.mapper.QualityReportMapper;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

/**
 * 教学服务测试
 * 测试人员：于峰
 * 测试内容：课程管理、课程开设、教学大纲、课程目标、毕业要求、评分项、成绩录入、质量评价、质量报告
 */
@ExtendWith(MockitoExtension.class)
public class TeachingServiceTest {

    @InjectMocks
    private TeachingService teachingService;

    @Mock
    private CourseMapper courseMapper;

    @Mock
    private CourseOfferingMapper courseOfferingMapper;

    @Mock
    private SyllabusMapper syllabusMapper;

    @Mock
    private CourseObjectiveMapper courseObjectiveMapper;

    @Mock
    private GraduationRequirementMapper graduationRequirementMapper;

    @Mock
    private ScoringItemMapper scoringItemMapper;

    @Mock
    private ScoringScoreMapper scoringScoreMapper;

    @Mock
    private QualityEvaluationMapper qualityEvaluationMapper;

    @Mock
    private QualityReportMapper qualityReportMapper;

    // ==================== 课程管理测试 ====================

    /**
     * 测试获取课程列表
     */
    @Test
    public void testGetCourseList() {
        Course course1 = new Course();
        course1.setId(1L);
        course1.setName("Java程序设计");
        course1.setCode("CS101");
        course1.setCredits(3);

        Course course2 = new Course();
        course2.setId(2L);
        course2.setName("数据结构");
        course2.setCode("CS102");
        course2.setCredits(4);

        when(courseMapper.selectList(any())).thenReturn(Arrays.asList(course1, course2));

        List<Course> result = teachingService.getCourseList();

        assertNotNull(result);
        assertEquals(2, result.size());
        assertEquals("Java程序设计", result.get(0).getName());
        verify(courseMapper).selectList(any());
    }

    /**
     * 测试创建课程
     */
    @Test
    public void testCreateCourse() {
        Course course = new Course();
        course.setName("新课程");
        course.setCode("CS103");
        course.setDescription("新课程描述");
        course.setCredits(3);

        when(courseMapper.insert(any(Course.class))).thenReturn(1);

        Course result = teachingService.createCourse(course);

        assertNotNull(result);
        assertNotNull(result.getId());
        assertEquals("新课程", result.getName());
        verify(courseMapper).insert(any(Course.class));
    }

    /**
     * 测试更新课程
     */
    @Test
    public void testUpdateCourse() {
        Course course = new Course();
        course.setId(1L);
        course.setName("更新课程");
        course.setDescription("更新课程描述");
        course.setCredits(4);

        when(courseMapper.updateById(any(Course.class))).thenReturn(1);

        Course result = teachingService.updateCourse(course);

        assertNotNull(result);
        assertEquals("更新课程", result.getName());
        verify(courseMapper).updateById(any(Course.class));
    }

    /**
     * 测试删除课程
     */
    @Test
    public void testDeleteCourse() {
        Long courseId = 1L;

        when(courseMapper.deleteById(courseId)).thenReturn(1);

        teachingService.deleteCourse(courseId);

        verify(courseMapper).deleteById(courseId);
    }

    // ==================== 课程开设测试 ====================

    /**
     * 测试获取课程开设列表
     */
    @Test
    public void testGetCourseOfferingList() {
        Long teacherId = 1L;

        CourseOffering offering1 = new CourseOffering();
        offering1.setId(1L);
        offering1.setCourseId(1L);
        offering1.setSemester("2024-2025-1");
        offering1.setTeacherId(teacherId);

        CourseOffering offering2 = new CourseOffering();
        offering2.setId(2L);
        offering2.setCourseId(2L);
        offering2.setSemester("2024-2025-1");
        offering2.setTeacherId(teacherId);

        when(courseOfferingMapper.selectList(any())).thenReturn(Arrays.asList(offering1, offering2));

        List<CourseOffering> result = teachingService.getCourseOfferingList(teacherId);

        assertNotNull(result);
        assertEquals(2, result.size());
        assertEquals("2024-2025-1", result.get(0).getSemester());
        verify(courseOfferingMapper).selectList(any());
    }

    /**
     * 测试创建课程开设
     */
    @Test
    public void testCreateCourseOffering() {
        CourseOffering offering = new CourseOffering();
        offering.setCourseId(1L);
        offering.setSemester("2024-2025-2");
        offering.setTeacherId(1L);
        offering.setClazzId(1L);

        when(courseOfferingMapper.insert(any(CourseOffering.class))).thenReturn(1);

        CourseOffering result = teachingService.createCourseOffering(offering);

        assertNotNull(result);
        assertNotNull(result.getId());
        assertEquals("2024-2025-2", result.getSemester());
        verify(courseOfferingMapper).insert(any(CourseOffering.class));
    }

    // ==================== 教学大纲测试 ====================

    /**
     * 测试获取教学大纲
     */
    @Test
    public void testGetSyllabus() {
        Long offeringId = 1L;

        Syllabus syllabus = new Syllabus();
        syllabus.setId(1L);
        syllabus.setOfferingId(offeringId);
        syllabus.setContent("课程教学大纲内容");
        syllabus.setVersion("1.0");

        when(syllabusMapper.selectOne(any())).thenReturn(syllabus);

        Syllabus result = teachingService.getSyllabus(offeringId);

        assertNotNull(result);
        assertEquals("课程教学大纲内容", result.getContent());
        verify(syllabusMapper).selectOne(any());
    }

    /**
     * 测试创建教学大纲
     */
    @Test
    public void testCreateSyllabus() {
        Syllabus syllabus = new Syllabus();
        syllabus.setOfferingId(1L);
        syllabus.setContent("新教学大纲内容");
        syllabus.setVersion("1.0");

        when(syllabusMapper.insert(any(Syllabus.class))).thenReturn(1);

        Syllabus result = teachingService.createSyllabus(syllabus);

        assertNotNull(result);
        assertNotNull(result.getId());
        assertEquals("新教学大纲内容", result.getContent());
        verify(syllabusMapper).insert(any(Syllabus.class));
    }

    /**
     * 测试更新教学大纲
     */
    @Test
    public void testUpdateSyllabus() {
        Syllabus syllabus = new Syllabus();
        syllabus.setId(1L);
        syllabus.setContent("更新教学大纲内容");
        syllabus.setVersion("1.1");

        when(syllabusMapper.updateById(any(Syllabus.class))).thenReturn(1);

        Syllabus result = teachingService.updateSyllabus(syllabus);

        assertNotNull(result);
        assertEquals("更新教学大纲内容", result.getContent());
        verify(syllabusMapper).updateById(any(Syllabus.class));
    }

    // ==================== 课程目标测试 ====================

    /**
     * 测试获取课程目标列表
     */
    @Test
    public void testGetCourseObjectiveList() {
        Long courseId = 1L;

        CourseObjective objective1 = new CourseObjective();
        objective1.setId(1L);
        objective1.setCourseId(courseId);
        objective1.setName("课程目标1");
        objective1.setDescription("掌握Java基础语法");
        objective1.setWeight(new BigDecimal("0.3"));

        CourseObjective objective2 = new CourseObjective();
        objective2.setId(2L);
        objective2.setCourseId(courseId);
        objective2.setName("课程目标2");
        objective2.setDescription("掌握面向对象编程");
        objective2.setWeight(new BigDecimal("0.4"));

        when(courseObjectiveMapper.selectList(any())).thenReturn(Arrays.asList(objective1, objective2));

        List<CourseObjective> result = teachingService.getCourseObjectiveList(courseId);

        assertNotNull(result);
        assertEquals(2, result.size());
        assertEquals("课程目标1", result.get(0).getName());
        verify(courseObjectiveMapper).selectList(any());
    }

    /**
     * 测试创建课程目标
     */
    @Test
    public void testCreateCourseObjective() {
        CourseObjective objective = new CourseObjective();
        objective.setCourseId(1L);
        objective.setName("新课程目标");
        objective.setDescription("新课程目标描述");
        objective.setWeight(new BigDecimal("0.3"));

        when(courseObjectiveMapper.insert(any(CourseObjective.class))).thenReturn(1);

        CourseObjective result = teachingService.createCourseObjective(objective);

        assertNotNull(result);
        assertNotNull(result.getId());
        assertEquals("新课程目标", result.getName());
        verify(courseObjectiveMapper).insert(any(CourseObjective.class));
    }

    /**
     * 测试更新课程目标
     */
    @Test
    public void testUpdateCourseObjective() {
        CourseObjective objective = new CourseObjective();
        objective.setId(1L);
        objective.setName("更新课程目标");
        objective.setDescription("更新课程目标描述");
        objective.setWeight(new BigDecimal("0.4"));

        when(courseObjectiveMapper.updateById(any(CourseObjective.class))).thenReturn(1);

        CourseObjective result = teachingService.updateCourseObjective(objective);

        assertNotNull(result);
        assertEquals("更新课程目标", result.getName());
        verify(courseObjectiveMapper).updateById(any(CourseObjective.class));
    }

    /**
     * 测试删除课程目标
     */
    @Test
    public void testDeleteCourseObjective() {
        Long objectiveId = 1L;

        when(courseObjectiveMapper.deleteById(objectiveId)).thenReturn(1);

        teachingService.deleteCourseObjective(objectiveId);

        verify(courseObjectiveMapper).deleteById(objectiveId);
    }

    // ==================== 毕业要求测试 ====================

    /**
     * 测试获取毕业要求列表
     */
    @Test
    public void testGetGraduationRequirementList() {
        GraduationRequirement requirement1 = new GraduationRequirement();
        requirement1.setId(1L);
        requirement1.setName("毕业要求1");
        requirement1.setDescription("工程知识");

        GraduationRequirement requirement2 = new GraduationRequirement();
        requirement2.setId(2L);
        requirement2.setName("毕业要求2");
        requirement2.setDescription("问题分析");

        when(graduationRequirementMapper.selectList(any())).thenReturn(Arrays.asList(requirement1, requirement2));

        List<GraduationRequirement> result = teachingService.getGraduationRequirementList();

        assertNotNull(result);
        assertEquals(2, result.size());
        assertEquals("毕业要求1", result.get(0).getName());
        verify(graduationRequirementMapper).selectList(any());
    }

    /**
     * 测试创建毕业要求
     */
    @Test
    public void testCreateGraduationRequirement() {
        GraduationRequirement requirement = new GraduationRequirement();
        requirement.setName("新毕业要求");
        requirement.setDescription("新毕业要求描述");

        when(graduationRequirementMapper.insert(any(GraduationRequirement.class))).thenReturn(1);

        GraduationRequirement result = teachingService.createGraduationRequirement(requirement);

        assertNotNull(result);
        assertNotNull(result.getId());
        assertEquals("新毕业要求", result.getName());
        verify(graduationRequirementMapper).insert(any(GraduationRequirement.class));
    }

    // ==================== 评分项测试 ====================

    /**
     * 测试获取评分项列表
     */
    @Test
    public void testGetScoringItemList() {
        Long offeringId = 1L;

        ScoringItem item1 = new ScoringItem();
        item1.setId(1L);
        item1.setOfferingId(offeringId);
        item1.setName("平时成绩");
        item1.setWeight(new BigDecimal("0.3"));

        ScoringItem item2 = new ScoringItem();
        item2.setId(2L);
        item2.setOfferingId(offeringId);
        item2.setName("期末考试");
        item2.setWeight(new BigDecimal("0.7"));

        when(scoringItemMapper.selectList(any())).thenReturn(Arrays.asList(item1, item2));

        List<ScoringItem> result = teachingService.getScoringItemList(offeringId);

        assertNotNull(result);
        assertEquals(2, result.size());
        assertEquals("平时成绩", result.get(0).getName());
        verify(scoringItemMapper).selectList(any());
    }

    /**
     * 测试创建评分项
     */
    @Test
    public void testCreateScoringItem() {
        ScoringItem item = new ScoringItem();
        item.setOfferingId(1L);
        item.setName("新评分项");
        item.setWeight(new BigDecimal("0.3"));
        item.setDescription("新评分项描述");

        when(scoringItemMapper.insert(any(ScoringItem.class))).thenReturn(1);

        ScoringItem result = teachingService.createScoringItem(item);

        assertNotNull(result);
        assertNotNull(result.getId());
        assertEquals("新评分项", result.getName());
        verify(scoringItemMapper).insert(any(ScoringItem.class));
    }

    /**
     * 测试更新评分项
     */
    @Test
    public void testUpdateScoringItem() {
        ScoringItem item = new ScoringItem();
        item.setId(1L);
        item.setName("更新评分项");
        item.setWeight(new BigDecimal("0.4"));
        item.setDescription("更新评分项描述");

        when(scoringItemMapper.updateById(any(ScoringItem.class))).thenReturn(1);

        ScoringItem result = teachingService.updateScoringItem(item);

        assertNotNull(result);
        assertEquals("更新评分项", result.getName());
        verify(scoringItemMapper).updateById(any(ScoringItem.class));
    }

    /**
     * 测试删除评分项
     */
    @Test
    public void testDeleteScoringItem() {
        Long itemId = 1L;

        when(scoringItemMapper.deleteById(itemId)).thenReturn(1);

        teachingService.deleteScoringItem(itemId);

        verify(scoringItemMapper).deleteById(itemId);
    }

    // ==================== 成绩录入测试 ====================

    /**
     * 测试批量录入成绩
     */
    @Test
    public void testBatchEnterScores() {
        List<ScoringScore> scores = Arrays.asList(
                createScoringScore(1L, 1L, new BigDecimal("85")),
                createScoringScore(2L, 1L, new BigDecimal("90")),
                createScoringScore(3L, 1L, new BigDecimal("78"))
        );

        when(scoringScoreMapper.insertBatch(anyList())).thenReturn(3);

        int result = teachingService.batchEnterScores(scores);

        assertEquals(3, result);
        verify(scoringScoreMapper).insertBatch(anyList());
    }

    /**
     * 测试导入成绩
     */
    @Test
    public void testImportScores() {
        List<ScoringScore> scores = Arrays.asList(
                createScoringScore(1L, 1L, new BigDecimal("85")),
                createScoringScore(2L, 1L, new BigDecimal("90"))
        );

        when(scoringScoreMapper.insertBatch(anyList())).thenReturn(2);

        int result = teachingService.importScores(scores);

        assertEquals(2, result);
        verify(scoringScoreMapper).insertBatch(anyList());
    }

    // ==================== 质量评价测试 ====================

    /**
     * 测试获取质量评价列表
     */
    @Test
    public void testGetQualityEvaluationList() {
        Long offeringId = 1L;

        QualityEvaluation evaluation1 = new QualityEvaluation();
        evaluation1.setId(1L);
        evaluation1.setOfferingId(offeringId);
        evaluation1.setEvaluatorType("STUDENT");
        evaluation1.setScore(90);

        QualityEvaluation evaluation2 = new QualityEvaluation();
        evaluation2.setId(2L);
        evaluation2.setOfferingId(offeringId);
        evaluation2.setEvaluatorType("TEACHER");
        evaluation2.setScore(85);

        when(qualityEvaluationMapper.selectList(any())).thenReturn(Arrays.asList(evaluation1, evaluation2));

        List<QualityEvaluation> result = teachingService.getQualityEvaluationList(offeringId);

        assertNotNull(result);
        assertEquals(2, result.size());
        assertEquals(90, result.get(0).getScore());
        verify(qualityEvaluationMapper).selectList(any());
    }

    /**
     * 测试创建质量评价
     */
    @Test
    public void testCreateQualityEvaluation() {
        QualityEvaluation evaluation = new QualityEvaluation();
        evaluation.setOfferingId(1L);
        evaluation.setEvaluatorType("STUDENT");
        evaluation.setScore(90);
        evaluation.setComment("课程内容丰富");

        when(qualityEvaluationMapper.insert(any(QualityEvaluation.class))).thenReturn(1);

        QualityEvaluation result = teachingService.createQualityEvaluation(evaluation);

        assertNotNull(result);
        assertNotNull(result.getId());
        assertEquals(90, result.getScore());
        verify(qualityEvaluationMapper).insert(any(QualityEvaluation.class));
    }

    // ==================== 质量报告测试 ====================

    /**
     * 测试获取质量报告列表
     */
    @Test
    public void testGetQualityReportList() {
        Long offeringId = 1L;

        QualityReport report1 = new QualityReport();
        report1.setId(1L);
        report1.setOfferingId(offeringId);
        report1.setTitle("2024年春季学期质量报告");

        QualityReport report2 = new QualityReport();
        report2.setId(2L);
        report2.setOfferingId(offeringId);
        report2.setTitle("2024年秋季学期质量报告");

        when(qualityReportMapper.selectList(any())).thenReturn(Arrays.asList(report1, report2));

        List<QualityReport> result = teachingService.getQualityReportList(offeringId);

        assertNotNull(result);
        assertEquals(2, result.size());
        assertEquals("2024年春季学期质量报告", result.get(0).getTitle());
        verify(qualityReportMapper).selectList(any());
    }

    /**
     * 测试生成质量报告
     */
    @Test
    public void testGenerateQualityReport() {
        Long offeringId = 1L;

        QualityReport report = new QualityReport();
        report.setOfferingId(offeringId);
        report.setTitle("质量报告");
        report.setContent("报告内容");

        when(qualityReportMapper.insert(any(QualityReport.class))).thenReturn(1);

        QualityReport result = teachingService.generateQualityReport(offeringId);

        assertNotNull(result);
        assertNotNull(result.getId());
        verify(qualityReportMapper).insert(any(QualityReport.class));
    }

    // ==================== 辅助方法 ====================

    private ScoringScore createScoringScore(Long studentId, Long scoringItemId, BigDecimal score) {
        ScoringScore scoringScore = new ScoringScore();
        scoringScore.setStudentId(studentId);
        scoringScore.setScoringItemId(scoringItemId);
        scoringScore.setScore(score);
        return scoringScore;
    }
}
