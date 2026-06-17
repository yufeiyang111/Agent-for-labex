package com.labex.service.impl;

import com.labex.entity.Score;
import com.labex.entity.Homework;
import com.labex.entity.TrainingSet;
import com.labex.entity.Lecture;
import com.labex.mapper.ScoreMapper;
import com.labex.mapper.HomeworkMapper;
import com.labex.mapper.TrainingSetMapper;
import com.labex.mapper.LectureMapper;
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
 * 成绩服务测试
 * 测试人员：杨宇润
 * 测试内容：成绩管理、作业管理、训练集管理、讲义管理
 */
@ExtendWith(MockitoExtension.class)
public class ScoreServiceTest {

    @InjectMocks
    private ScoreService scoreService;

    @Mock
    private ScoreMapper scoreMapper;

    @Mock
    private HomeworkMapper homeworkMapper;

    @Mock
    private TrainingSetMapper trainingSetMapper;

    @Mock
    private LectureMapper lectureMapper;

    // ==================== 成绩管理测试 ====================

    /**
     * 测试获取成绩列表
     */
    @Test
    public void testGetScoreList() {
        Long teacherId = 1L;

        Score score1 = new Score();
        score1.setId(1L);
        score1.setStudentId(1L);
        score1.setExamId(1L);
        score1.setScore(new BigDecimal("85"));

        Score score2 = new Score();
        score2.setId(2L);
        score2.setStudentId(2L);
        score2.setExamId(1L);
        score2.setScore(new BigDecimal("90"));

        when(scoreMapper.selectList(any())).thenReturn(Arrays.asList(score1, score2));

        List<Score> result = scoreService.getScoreList(teacherId);

        assertNotNull(result);
        assertEquals(2, result.size());
        assertEquals(new BigDecimal("85"), result.get(0).getScore());
        verify(scoreMapper).selectList(any());
    }

    /**
     * 测试录入成绩
     */
    @Test
    public void testEnterScore() {
        Score score = new Score();
        score.setStudentId(1L);
        score.setExamId(1L);
        score.setScore(new BigDecimal("85"));

        when(scoreMapper.insert(any(Score.class))).thenReturn(1);

        Score result = scoreService.enterScore(score);

        assertNotNull(result);
        assertNotNull(result.getId());
        assertEquals(new BigDecimal("85"), result.getScore());
        verify(scoreMapper).insert(any(Score.class));
    }

    /**
     * 测试批量录入成绩
     */
    @Test
    public void testBatchEnterScores() {
        List<Score> scores = Arrays.asList(
                createScore(1L, 1L, new BigDecimal("85")),
                createScore(2L, 1L, new BigDecimal("90")),
                createScore(3L, 1L, new BigDecimal("78"))
        );

        when(scoreMapper.insertBatch(anyList())).thenReturn(3);

        int result = scoreService.batchEnterScores(scores);

        assertEquals(3, result);
        verify(scoreMapper).insertBatch(anyList());
    }

    /**
     * 测试更新成绩
     */
    @Test
    public void testUpdateScore() {
        Score score = new Score();
        score.setId(1L);
        score.setScore(new BigDecimal("95"));

        when(scoreMapper.updateById(any(Score.class))).thenReturn(1);

        Score result = scoreService.updateScore(score);

        assertNotNull(result);
        assertEquals(new BigDecimal("95"), result.getScore());
        verify(scoreMapper).updateById(any(Score.class));
    }

    /**
     * 测试删除成绩
     */
    @Test
    public void testDeleteScore() {
        Long scoreId = 1L;

        when(scoreMapper.deleteById(scoreId)).thenReturn(1);

        scoreService.deleteScore(scoreId);

        verify(scoreMapper).deleteById(scoreId);
    }

    /**
     * 测试成绩统计分析
     */
    @Test
    public void testScoreStatistics() {
        Long examId = 1L;

        Score score1 = new Score();
        score1.setScore(new BigDecimal("85"));

        Score score2 = new Score();
        score2.setScore(new BigDecimal("90"));

        Score score3 = new Score();
        score3.setScore(new BigDecimal("78"));

        when(scoreMapper.selectList(any())).thenReturn(Arrays.asList(score1, score2, score3));

        var statistics = scoreService.getScoreStatistics(examId);

        assertNotNull(statistics);
        verify(scoreMapper).selectList(any());
    }

    // ==================== 作业管理测试 ====================

    /**
     * 测试获取作业列表
     */
    @Test
    public void testGetHomeworkList() {
        Long teacherId = 1L;

        Homework homework1 = new Homework();
        homework1.setId(1L);
        homework1.setTitle("Java基础作业");
        homework1.setStatus("未完成");

        Homework homework2 = new Homework();
        homework2.setId(2L);
        homework2.setTitle("Java面向对象作业");
        homework2.setStatus("未完成");

        when(homeworkMapper.selectList(any())).thenReturn(Arrays.asList(homework1, homework2));

        List<Homework> result = scoreService.getHomeworkList(teacherId);

        assertNotNull(result);
        assertEquals(2, result.size());
        assertEquals("Java基础作业", result.get(0).getTitle());
        verify(homeworkMapper).selectList(any());
    }

    /**
     * 测试创建作业
     */
    @Test
    public void testCreateHomework() {
        Homework homework = new Homework();
        homework.setTitle("新作业");
        homework.setDescription("新作业描述");
        homework.setCourseId(1L);

        when(homeworkMapper.insert(any(Homework.class))).thenReturn(1);

        Homework result = scoreService.createHomework(homework);

        assertNotNull(result);
        assertNotNull(result.getId());
        assertEquals("新作业", result.getTitle());
        verify(homeworkMapper).insert(any(Homework.class));
    }

    /**
     * 测试更新作业
     */
    @Test
    public void testUpdateHomework() {
        Homework homework = new Homework();
        homework.setId(1L);
        homework.setTitle("更新作业");
        homework.setDescription("更新作业描述");

        when(homeworkMapper.updateById(any(Homework.class))).thenReturn(1);

        Homework result = scoreService.updateHomework(homework);

        assertNotNull(result);
        assertEquals("更新作业", result.getTitle());
        verify(homeworkMapper).updateById(any(Homework.class));
    }

    /**
     * 测试删除作业
     */
    @Test
    public void testDeleteHomework() {
        Long homeworkId = 1L;

        when(homeworkMapper.deleteById(homeworkId)).thenReturn(1);

        scoreService.deleteHomework(homeworkId);

        verify(homeworkMapper).deleteById(homeworkId);
    }

    // ==================== 训练集管理测试 ====================

    /**
     * 测试获取训练集列表
     */
    @Test
    public void testGetTrainingSetList() {
        Long teacherId = 1L;

        TrainingSet trainingSet1 = new TrainingSet();
        trainingSet1.setId(1L);
        trainingSet1.setName("Java基础训练");
        trainingSet1.setDescription("Java基础知识训练集");

        TrainingSet trainingSet2 = new TrainingSet();
        trainingSet2.setId(2L);
        trainingSet2.setName("Java面向对象训练");
        trainingSet2.setDescription("Java面向对象编程训练集");

        when(trainingSetMapper.selectList(any())).thenReturn(Arrays.asList(trainingSet1, trainingSet2));

        List<TrainingSet> result = scoreService.getTrainingSetList(teacherId);

        assertNotNull(result);
        assertEquals(2, result.size());
        assertEquals("Java基础训练", result.get(0).getName());
        verify(trainingSetMapper).selectList(any());
    }

    /**
     * 测试创建训练集
     */
    @Test
    public void testCreateTrainingSet() {
        TrainingSet trainingSet = new TrainingSet();
        trainingSet.setName("新训练集");
        trainingSet.setDescription("新训练集描述");
        trainingSet.setCourseId(1L);

        when(trainingSetMapper.insert(any(TrainingSet.class))).thenReturn(1);

        TrainingSet result = scoreService.createTrainingSet(trainingSet);

        assertNotNull(result);
        assertNotNull(result.getId());
        assertEquals("新训练集", result.getName());
        verify(trainingSetMapper).insert(any(TrainingSet.class));
    }

    /**
     * 测试更新训练集
     */
    @Test
    public void testUpdateTrainingSet() {
        TrainingSet trainingSet = new TrainingSet();
        trainingSet.setId(1L);
        trainingSet.setName("更新训练集");
        trainingSet.setDescription("更新训练集描述");

        when(trainingSetMapper.updateById(any(TrainingSet.class))).thenReturn(1);

        TrainingSet result = scoreService.updateTrainingSet(trainingSet);

        assertNotNull(result);
        assertEquals("更新训练集", result.getName());
        verify(trainingSetMapper).updateById(any(TrainingSet.class));
    }

    /**
     * 测试删除训练集
     */
    @Test
    public void testDeleteTrainingSet() {
        Long trainingSetId = 1L;

        when(trainingSetMapper.deleteById(trainingSetId)).thenReturn(1);

        scoreService.deleteTrainingSet(trainingSetId);

        verify(trainingSetMapper).deleteById(trainingSetId);
    }

    // ==================== 讲义管理测试 ====================

    /**
     * 测试获取讲义列表
     */
    @Test
    public void testGetLectureList() {
        Long teacherId = 1L;

        Lecture lecture1 = new Lecture();
        lecture1.setId(1L);
        lecture1.setTitle("Java基础讲义");
        lecture1.setContent("Java基础知识讲解");

        Lecture lecture2 = new Lecture();
        lecture2.setId(2L);
        lecture2.setTitle("Java面向对象讲义");
        lecture2.setContent("Java面向对象编程讲解");

        when(lectureMapper.selectList(any())).thenReturn(Arrays.asList(lecture1, lecture2));

        List<Lecture> result = scoreService.getLectureList(teacherId);

        assertNotNull(result);
        assertEquals(2, result.size());
        assertEquals("Java基础讲义", result.get(0).getTitle());
        verify(lectureMapper).selectList(any());
    }

    /**
     * 测试创建讲义
     */
    @Test
    public void testCreateLecture() {
        Lecture lecture = new Lecture();
        lecture.setTitle("新讲义");
        lecture.setContent("新讲义内容");
        lecture.setCourseId(1L);

        when(lectureMapper.insert(any(Lecture.class))).thenReturn(1);

        Lecture result = scoreService.createLecture(lecture);

        assertNotNull(result);
        assertNotNull(result.getId());
        assertEquals("新讲义", result.getTitle());
        verify(lectureMapper).insert(any(Lecture.class));
    }

    /**
     * 测试更新讲义
     */
    @Test
    public void testUpdateLecture() {
        Lecture lecture = new Lecture();
        lecture.setId(1L);
        lecture.setTitle("更新讲义");
        lecture.setContent("更新讲义内容");

        when(lectureMapper.updateById(any(Lecture.class))).thenReturn(1);

        Lecture result = scoreService.updateLecture(lecture);

        assertNotNull(result);
        assertEquals("更新讲义", result.getTitle());
        verify(lectureMapper).updateById(any(Lecture.class));
    }

    /**
     * 测试删除讲义
     */
    @Test
    public void testDeleteLecture() {
        Long lectureId = 1L;

        when(lectureMapper.deleteById(lectureId)).thenReturn(1);

        scoreService.deleteLecture(lectureId);

        verify(lectureMapper).deleteById(lectureId);
    }

    // ==================== 辅助方法 ====================

    private Score createScore(Long studentId, Long examId, BigDecimal score) {
        Score scoreObj = new Score();
        scoreObj.setStudentId(studentId);
        scoreObj.setExamId(examId);
        scoreObj.setScore(score);
        return scoreObj;
    }
}
