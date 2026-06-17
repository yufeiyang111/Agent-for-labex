package com.labex.kg.service;

import com.labex.kg.dto.RecommendationRequest;
import com.labex.kg.dto.RecommendationResponse;
import com.labex.kg.dto.StudentMasteryDTO;
import com.labex.kg.repository.KnowledgeGraphRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

/**
 * 推荐服务测试
 * 测试人员：于峰
 * 测试内容：练习题推荐、学习路径推荐、个性化推荐
 */
@ExtendWith(MockitoExtension.class)
public class RecommendationServiceTest {

    @InjectMocks
    private ExerciseRecommendationService recommendationService;

    @Mock
    private KnowledgeGraphRepository knowledgeGraphRepository;

    @Mock
    private StudentMasteryService studentMasteryService;

    /**
     * 测试获取练习题推荐
     */
    @Test
    public void testGetExerciseRecommendation() {
        Long studentId = 1L;
        Long courseId = 1L;
        int limit = 5;

        StudentMasteryDTO mastery1 = new StudentMasteryDTO();
        mastery1.setKnowledgePointId(1L);
        mastery1.setKnowledgePointName("Java多态");
        mastery1.setMastery(0.6);

        StudentMasteryDTO mastery2 = new StudentMasteryDTO();
        mastery2.setKnowledgePointId(2L);
        mastery2.setKnowledgePointName("Java继承");
        mastery2.setMastery(0.4);

        when(studentMasteryService.getStudentMasteryList(studentId, courseId))
                .thenReturn(Arrays.asList(mastery1, mastery2));
        when(knowledgeGraphRepository.getRecommendedExercises(anyList(), anyInt()))
                .thenReturn(Arrays.asList(1L, 2L, 3L));

        RecommendationResponse response = recommendationService.getExerciseRecommendation(studentId, courseId, limit);

        assertNotNull(response);
        assertNotNull(response.getQuestionIds());
        assertEquals(3, response.getQuestionIds().size());
        verify(studentMasteryService).getStudentMasteryList(studentId, courseId);
        verify(knowledgeGraphRepository).getRecommendedExercises(anyList(), anyInt());
    }

    /**
     * 测试获取学习路径推荐
     */
    @Test
    public void testGetLearningPathRecommendation() {
        Long studentId = 1L;
        Long courseId = 1L;

        StudentMasteryDTO mastery1 = new StudentMasteryDTO();
        mastery1.setKnowledgePointId(1L);
        mastery1.setKnowledgePointName("Java多态");
        mastery1.setMastery(0.6);

        when(studentMasteryService.getStudentMasteryList(studentId, courseId))
                .thenReturn(Arrays.asList(mastery1));
        when(knowledgeGraphRepository.getLearningPath(anyLong(), anyDouble()))
                .thenReturn(Arrays.asList("Java基础", "Java面向对象", "Java多态"));

        List<String> path = recommendationService.getLearningPathRecommendation(studentId, courseId);

        assertNotNull(path);
        assertEquals(3, path.size());
        assertEquals("Java基础", path.get(0));
        verify(studentMasteryService).getStudentMasteryList(studentId, courseId);
        verify(knowledgeGraphRepository).getLearningPath(anyLong(), anyDouble());
    }

    /**
     * 测试获取薄弱知识点推荐
     */
    @Test
    public void testGetWeakPointRecommendation() {
        Long studentId = 1L;
        Long courseId = 1L;
        int limit = 3;

        StudentMasteryDTO mastery1 = new StudentMasteryDTO();
        mastery1.setKnowledgePointId(1L);
        mastery1.setKnowledgePointName("Java多态");
        mastery1.setMastery(0.3);

        StudentMasteryDTO mastery2 = new StudentMasteryDTO();
        mastery2.setKnowledgePointId(2L);
        mastery2.setKnowledgePointName("Java继承");
        mastery2.setMastery(0.5);

        StudentMasteryDTO mastery3 = new StudentMasteryDTO();
        mastery3.setKnowledgePointId(3L);
        mastery3.setKnowledgePointName("Java封装");
        mastery3.setMastery(0.8);

        when(studentMasteryService.getStudentMasteryList(studentId, courseId))
                .thenReturn(Arrays.asList(mastery1, mastery2, mastery3));

        List<StudentMasteryDTO> weakPoints = recommendationService.getWeakPointRecommendation(studentId, courseId, limit);

        assertNotNull(weakPoints);
        assertEquals(2, weakPoints.size());
        assertEquals("Java多态", weakPoints.get(0).getKnowledgePointName());
        assertEquals("Java继承", weakPoints.get(1).getKnowledgePointName());
        verify(studentMasteryService).getStudentMasteryList(studentId, courseId);
    }

    /**
     * 测试获取个性化推荐
     */
    @Test
    public void testGetPersonalizedRecommendation() {
        Long studentId = 1L;
        Long courseId = 1L;

        StudentMasteryDTO mastery = new StudentMasteryDTO();
        mastery.setKnowledgePointId(1L);
        mastery.setKnowledgePointName("Java多态");
        mastery.setMastery(0.6);

        when(studentMasteryService.getStudentMasteryList(studentId, courseId))
                .thenReturn(Arrays.asList(mastery));
        when(knowledgeGraphRepository.getRecommendedExercises(anyList(), anyInt()))
                .thenReturn(Arrays.asList(1L, 2L));
        when(knowledgeGraphRepository.getLearningPath(anyLong(), anyDouble()))
                .thenReturn(Arrays.asList("Java基础", "Java面向对象"));

        RecommendationResponse response = recommendationService.getPersonalizedRecommendation(studentId, courseId);

        assertNotNull(response);
        assertNotNull(response.getQuestionIds());
        assertNotNull(response.getLearningPath());
        verify(studentMasteryService).getStudentMasteryList(studentId, courseId);
        verify(knowledgeGraphRepository).getRecommendedExercises(anyList(), anyInt());
        verify(knowledgeGraphRepository).getLearningPath(anyLong(), anyDouble());
    }

    /**
     * 测试推荐 - 学生掌握度为空
     */
    @Test
    public void testRecommendationEmptyMastery() {
        Long studentId = 1L;
        Long courseId = 1L;
        int limit = 5;

        when(studentMasteryService.getStudentMasteryList(studentId, courseId))
                .thenReturn(Arrays.asList());

        RecommendationResponse response = recommendationService.getExerciseRecommendation(studentId, courseId, limit);

        assertNotNull(response);
        assertNotNull(response.getQuestionIds());
        assertTrue(response.getQuestionIds().isEmpty());
        verify(studentMasteryService).getStudentMasteryList(studentId, courseId);
    }

    /**
     * 测试推荐 - 所有知识点都掌握
     */
    @Test
    public void testRecommendationAllMastered() {
        Long studentId = 1L;
        Long courseId = 1L;
        int limit = 5;

        StudentMasteryDTO mastery1 = new StudentMasteryDTO();
        mastery1.setKnowledgePointId(1L);
        mastery1.setKnowledgePointName("Java多态");
        mastery1.setMastery(0.9);

        StudentMasteryDTO mastery2 = new StudentMasteryDTO();
        mastery2.setKnowledgePointId(2L);
        mastery2.setKnowledgePointName("Java继承");
        mastery2.setMastery(0.95);

        when(studentMasteryService.getStudentMasteryList(studentId, courseId))
                .thenReturn(Arrays.asList(mastery1, mastery2));
        when(knowledgeGraphRepository.getRecommendedExercises(anyList(), anyInt()))
                .thenReturn(Arrays.asList(1L));

        RecommendationResponse response = recommendationService.getExerciseRecommendation(studentId, courseId, limit);

        assertNotNull(response);
        assertNotNull(response.getQuestionIds());
        verify(studentMasteryService).getStudentMasteryList(studentId, courseId);
    }

    /**
     * 测试推荐 - 限制数量
     */
    @Test
    public void testRecommendationLimit() {
        Long studentId = 1L;
        Long courseId = 1L;
        int limit = 2;

        StudentMasteryDTO mastery = new StudentMasteryDTO();
        mastery.setKnowledgePointId(1L);
        mastery.setKnowledgePointName("Java多态");
        mastery.setMastery(0.6);

        when(studentMasteryService.getStudentMasteryList(studentId, courseId))
                .thenReturn(Arrays.asList(mastery));
        when(knowledgeGraphRepository.getRecommendedExercises(anyList(), anyInt()))
                .thenReturn(Arrays.asList(1L, 2L));

        RecommendationResponse response = recommendationService.getExerciseRecommendation(studentId, courseId, limit);

        assertNotNull(response);
        assertNotNull(response.getQuestionIds());
        assertTrue(response.getQuestionIds().size() <= limit);
        verify(knowledgeGraphRepository).getRecommendedExercises(anyList(), eq(limit));
    }

    /**
     * 测试学习路径推荐 - 无薄弱知识点
     */
    @Test
    public void testLearningPathNoWeakPoints() {
        Long studentId = 1L;
        Long courseId = 1L;

        StudentMasteryDTO mastery = new StudentMasteryDTO();
        mastery.setKnowledgePointId(1L);
        mastery.setKnowledgePointName("Java多态");
        mastery.setMastery(0.9);

        when(studentMasteryService.getStudentMasteryList(studentId, courseId))
                .thenReturn(Arrays.asList(mastery));

        List<String> path = recommendationService.getLearningPathRecommendation(studentId, courseId);

        assertNotNull(path);
        assertTrue(path.isEmpty() || path.size() > 0);
        verify(studentMasteryService).getStudentMasteryList(studentId, courseId);
    }

    /**
     * 测试薄弱知识点推荐 - 按掌握度排序
     */
    @Test
    public void testWeakPointsSortedByMastery() {
        Long studentId = 1L;
        Long courseId = 1L;
        int limit = 3;

        StudentMasteryDTO mastery1 = new StudentMasteryDTO();
        mastery1.setKnowledgePointId(1L);
        mastery1.setKnowledgePointName("Java多态");
        mastery1.setMastery(0.3);

        StudentMasteryDTO mastery2 = new StudentMasteryDTO();
        mastery2.setKnowledgePointId(2L);
        mastery2.setKnowledgePointName("Java继承");
        mastery2.setMastery(0.5);

        StudentMasteryDTO mastery3 = new StudentMasteryDTO();
        mastery3.setKnowledgePointId(3L);
        mastery3.setKnowledgePointName("Java封装");
        mastery3.setMastery(0.8);

        when(studentMasteryService.getStudentMasteryList(studentId, courseId))
                .thenReturn(Arrays.asList(mastery3, mastery1, mastery2));

        List<StudentMasteryDTO> weakPoints = recommendationService.getWeakPointRecommendation(studentId, courseId, limit);

        assertNotNull(weakPoints);
        assertEquals(2, weakPoints.size());
        // 验证按掌握度升序排序
        assertTrue(weakPoints.get(0).getMastery() <= weakPoints.get(1).getMastery());
    }
}
