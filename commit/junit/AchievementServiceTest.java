package com.labex.service.impl;

import com.labex.entity.Achievement;
import com.labex.entity.ScoringItem;
import com.labex.entity.ScoringScore;
import com.labex.entity.CourseObjective;
import com.labex.entity.GraduationRequirement;
import com.labex.mapper.AchievementMapper;
import com.labex.mapper.ScoringItemMapper;
import com.labex.mapper.ScoringScoreMapper;
import com.labex.mapper.CourseObjectiveMapper;
import com.labex.mapper.GraduationRequirementMapper;
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
 * 达成度服务测试
 * 测试人员：于峰
 * 测试内容：课程目标达成度计算、毕业要求达成度计算
 */
@ExtendWith(MockitoExtension.class)
public class AchievementServiceTest {

    @InjectMocks
    private AchievementService achievementService;

    @Mock
    private AchievementMapper achievementMapper;

    @Mock
    private ScoringItemMapper scoringItemMapper;

    @Mock
    private ScoringScoreMapper scoringScoreMapper;

    @Mock
    private CourseObjectiveMapper courseObjectiveMapper;

    @Mock
    private GraduationRequirementMapper graduationRequirementMapper;

    /**
     * 测试计算课程目标达成度
     */
    @Test
    public void testCalculateCourseObjectiveAchievement() {
        Long offeringId = 1L;
        Long courseObjectiveId = 1L;

        // 模拟评分项
        ScoringItem scoringItem = new ScoringItem();
        scoringItem.setId(1L);
        scoringItem.setOfferingId(offeringId);
        scoringItem.setName("平时成绩");
        scoringItem.setWeight(new BigDecimal("0.3"));

        // 模拟评分成绩
        ScoringScore scoringScore = new ScoringScore();
        scoringScore.setId(1L);
        scoringScore.setScoringItemId(1L);
        scoringScore.setStudentId(1L);
        scoringScore.setScore(new BigDecimal("85"));

        // 模拟课程目标
        CourseObjective courseObjective = new CourseObjective();
        courseObjective.setId(courseObjectiveId);
        courseObjective.setCourseId(1L);
        courseObjective.setName("课程目标1");
        courseObjective.setWeight(new BigDecimal("0.3"));

        when(scoringItemMapper.selectList(any())).thenReturn(Arrays.asList(scoringItem));
        when(scoringScoreMapper.selectList(any())).thenReturn(Arrays.asList(scoringScore));
        when(courseObjectiveMapper.selectById(courseObjectiveId)).thenReturn(courseObjective);
        when(achievementMapper.insert(any(Achievement.class))).thenReturn(1);

        BigDecimal achievement = achievementService.calculateCourseObjectiveAchievement(offeringId, courseObjectiveId);

        assertNotNull(achievement);
        assertTrue(achievement.compareTo(BigDecimal.ZERO) > 0);
        verify(achievementMapper).insert(any(Achievement.class));
    }

    /**
     * 测试计算毕业要求达成度
     */
    @Test
    public void testCalculateGraduationRequirementAchievement() {
        Long offeringId = 1L;
        Long graduationRequirementId = 1L;

        // 模拟课程目标
        CourseObjective courseObjective = new CourseObjective();
        courseObjective.setId(1L);
        courseObjective.setCourseId(1L);
        courseObjective.setName("课程目标1");
        courseObjective.setWeight(new BigDecimal("0.3"));

        // 模拟毕业要求
        GraduationRequirement graduationRequirement = new GraduationRequirement();
        graduationRequirement.setId(graduationRequirementId);
        graduationRequirement.setName("毕业要求1");
        graduationRequirement.setDescription("工程知识");

        // 模拟达成度
        Achievement achievement = new Achievement();
        achievement.setId(1L);
        achievement.setOfferingId(offeringId);
        achievement.setCourseObjectiveId(1L);
        achievement.setAchievement(new BigDecimal("0.75"));

        when(courseObjectiveMapper.selectList(any())).thenReturn(Arrays.asList(courseObjective));
        when(graduationRequirementMapper.selectById(graduationRequirementId)).thenReturn(graduationRequirement);
        when(achievementMapper.selectList(any())).thenReturn(Arrays.asList(achievement));
        when(achievementMapper.insert(any(Achievement.class))).thenReturn(1);

        BigDecimal achievementResult = achievementService.calculateGraduationRequirementAchievement(offeringId, graduationRequirementId);

        assertNotNull(achievementResult);
        assertTrue(achievementResult.compareTo(BigDecimal.ZERO) > 0);
        verify(achievementMapper).insert(any(Achievement.class));
    }

    /**
     * 测试获取课程目标达成度列表
     */
    @Test
    public void testGetCourseObjectiveAchievementList() {
        Long offeringId = 1L;

        Achievement achievement1 = new Achievement();
        achievement1.setId(1L);
        achievement1.setOfferingId(offeringId);
        achievement1.setCourseObjectiveId(1L);
        achievement1.setAchievement(new BigDecimal("0.75"));

        Achievement achievement2 = new Achievement();
        achievement2.setId(2L);
        achievement2.setOfferingId(offeringId);
        achievement2.setCourseObjectiveId(2L);
        achievement2.setAchievement(new BigDecimal("0.80"));

        when(achievementMapper.selectList(any())).thenReturn(Arrays.asList(achievement1, achievement2));

        List<Achievement> result = achievementService.getCourseObjectiveAchievementList(offeringId);

        assertNotNull(result);
        assertEquals(2, result.size());
        verify(achievementMapper).selectList(any());
    }

    /**
     * 测试获取毕业要求达成度列表
     */
    @Test
    public void testGetGraduationRequirementAchievementList() {
        Long offeringId = 1L;

        Achievement achievement1 = new Achievement();
        achievement1.setId(1L);
        achievement1.setOfferingId(offeringId);
        achievement1.setGraduationRequirementId(1L);
        achievement1.setAchievement(new BigDecimal("0.70"));

        Achievement achievement2 = new Achievement();
        achievement2.setId(2L);
        achievement2.setOfferingId(offeringId);
        achievement2.setGraduationRequirementId(2L);
        achievement2.setAchievement(new BigDecimal("0.85"));

        when(achievementMapper.selectList(any())).thenReturn(Arrays.asList(achievement1, achievement2));

        List<Achievement> result = achievementService.getGraduationRequirementAchievementList(offeringId);

        assertNotNull(result);
        assertEquals(2, result.size());
        verify(achievementMapper).selectList(any());
    }

    /**
     * 测试达成度计算 - 权重计算
     */
    @Test
    public void testAchievementCalculationWeight() {
        BigDecimal score = new BigDecimal("85");
        BigDecimal totalScore = new BigDecimal("100");
        BigDecimal weight = new BigDecimal("0.3");

        BigDecimal expected = score.divide(totalScore, 4, BigDecimal.ROUND_HALF_UP)
                .multiply(weight);

        BigDecimal result = achievementService.calculateWeightedScore(score, totalScore, weight);

        assertNotNull(result);
        assertEquals(expected, result);
    }

    /**
     * 测试达成度计算 - 零分情况
     */
    @Test
    public void testAchievementCalculationZeroScore() {
        BigDecimal score = BigDecimal.ZERO;
        BigDecimal totalScore = new BigDecimal("100");
        BigDecimal weight = new BigDecimal("0.3");

        BigDecimal result = achievementService.calculateWeightedScore(score, totalScore, weight);

        assertNotNull(result);
        assertEquals(BigDecimal.ZERO, result);
    }

    /**
     * 测试达成度计算 - 满分情况
     */
    @Test
    public void testAchievementCalculationFullScore() {
        BigDecimal score = new BigDecimal("100");
        BigDecimal totalScore = new BigDecimal("100");
        BigDecimal weight = new BigDecimal("0.3");

        BigDecimal result = achievementService.calculateWeightedScore(score, totalScore, weight);

        assertNotNull(result);
        assertEquals(new BigDecimal("0.3000"), result);
    }

    /**
     * 测试达成度计算 - 多个评分项
     */
    @Test
    public void testAchievementCalculationMultipleItems() {
        Long offeringId = 1L;
        Long courseObjectiveId = 1L;

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

        ScoringScore score1 = new ScoringScore();
        score1.setScoringItemId(1L);
        score1.setStudentId(1L);
        score1.setScore(new BigDecimal("80"));

        ScoringScore score2 = new ScoringScore();
        score2.setScoringItemId(2L);
        score2.setStudentId(1L);
        score2.setScore(new BigDecimal("90"));

        CourseObjective courseObjective = new CourseObjective();
        courseObjective.setId(courseObjectiveId);
        courseObjective.setWeight(new BigDecimal("0.5"));

        when(scoringItemMapper.selectList(any())).thenReturn(Arrays.asList(item1, item2));
        when(scoringScoreMapper.selectList(any())).thenReturn(Arrays.asList(score1, score2));
        when(courseObjectiveMapper.selectById(courseObjectiveId)).thenReturn(courseObjective);
        when(achievementMapper.insert(any(Achievement.class))).thenReturn(1);

        BigDecimal achievement = achievementService.calculateCourseObjectiveAchievement(offeringId, courseObjectiveId);

        assertNotNull(achievement);
        assertTrue(achievement.compareTo(BigDecimal.ZERO) > 0);
    }

    /**
     * 测试达成度计算 - 边界值测试
     */
    @Test
    public void testAchievementCalculationBoundary() {
        // 测试权重为0的情况
        BigDecimal score = new BigDecimal("85");
        BigDecimal totalScore = new BigDecimal("100");
        BigDecimal weight = BigDecimal.ZERO;

        BigDecimal result = achievementService.calculateWeightedScore(score, totalScore, weight);

        assertNotNull(result);
        assertEquals(BigDecimal.ZERO, result);

        // 测试权重为1的情况
        weight = BigDecimal.ONE;
        result = achievementService.calculateWeightedScore(score, totalScore, weight);

        assertNotNull(result);
        assertEquals(new BigDecimal("0.8500"), result);
    }

    /**
     * 测试达成度计算 - 精度测试
     */
    @Test
    public void testAchievementCalculationPrecision() {
        BigDecimal score = new BigDecimal("85");
        BigDecimal totalScore = new BigDecimal("100");
        BigDecimal weight = new BigDecimal("0.3333");

        BigDecimal result = achievementService.calculateWeightedScore(score, totalScore, weight);

        assertNotNull(result);
        // 验证精度为4位小数
        assertTrue(result.scale() <= 4);
    }

    /**
     * 测试达成度导出
     */
    @Test
    public void testExportAchievementReport() {
        Long offeringId = 1L;

        Achievement achievement = new Achievement();
        achievement.setId(1L);
        achievement.setOfferingId(offeringId);
        achievement.setCourseObjectiveId(1L);
        achievement.setAchievement(new BigDecimal("0.75"));

        when(achievementMapper.selectList(any())).thenReturn(Arrays.asList(achievement));

        byte[] report = achievementService.exportAchievementReport(offeringId);

        assertNotNull(report);
        assertTrue(report.length > 0);
        verify(achievementMapper).selectList(any());
    }
}
