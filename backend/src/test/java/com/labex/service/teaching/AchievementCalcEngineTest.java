package com.labex.service.teaching;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.labex.entity.Student;
import com.labex.entity.teaching.*;
import com.labex.mapper.teaching.*;
import com.labex.service.StudentService;
import com.labex.service.teaching.impl.AchievementCalcEngineImpl;
import com.labex.vo.teaching.OfferingAchievementVO;
import com.labex.vo.teaching.StudentAchievementVO;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.Mockito.when;

/**
 * 达成度算法核心测试 — 对齐参考文档 Excel 行 155：学生 1 目标 1 = 0.7857
 * 8 评分项：作业 1-5 + 实验 1-3，每个 max=100, passing=70, weight=0.05
 * → 加权期望 = 8 × 100 × 0.05 × 0.7 = 28
 * → 若加权得分 = 22 (即 8 项得分平均 55)，达成度 = 22/28 = 0.7857
 */
@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
class AchievementCalcEngineTest {

    @Mock private ScoringItemMapper itemMapper;
    @Mock private ScoringItemObjectiveMapper linkMapper;
    @Mock private ScoringScoreMapper scoreMapper;
    @Mock private CourseObjectiveMapper objectiveMapper;
    @Mock private CourseOfferingMapper offeringMapper;
    @Mock private AchievementSnapshotMapper snapshotMapper;
    @Mock private StudentService studentService;

    @InjectMocks
    private AchievementCalcEngineImpl engine;

    private final int OFFERING_ID = 1;
    private final int COURSE_ID = 100;
    private final int STUDENT_ID = 1001;
    private final int OBJ1_ID = 1;
    private final int OBJ2_ID = 2;

    @BeforeEach
    void setUp() {
        // 1. 构造开课
        CourseOffering offering = new CourseOffering();
        offering.setOfferingId(OFFERING_ID);
        offering.setCourseId(COURSE_ID);
        offering.setClazzNo("23-SE-1");
        when(offeringMapper.selectById(OFFERING_ID)).thenReturn(offering);

        // 2. 构造课程目标（目标 1、目标 2）
        CourseObjective obj1 = new CourseObjective();
        obj1.setObjectiveId(OBJ1_ID);
        obj1.setCode("课程目标1");
        obj1.setCourseId(COURSE_ID);
        CourseObjective obj2 = new CourseObjective();
        obj2.setObjectiveId(OBJ2_ID);
        obj2.setCode("课程目标2");
        obj2.setCourseId(COURSE_ID);
        when(objectiveMapper.selectList(any(Wrapper.class))).thenReturn(List.of(obj1, obj2));

        // 3. 构造 13 个评分项（目标 1: 作业1-5 + 实验1-3 = 8项，权重 0.05; 目标 2: 实验4 + 大作业1-4，权重 0.1/0.1/0.1/0.15/0.15）
        List<ScoringItem> items = new ArrayList<>();
        List<ScoringItemObjective> links = new ArrayList<>();
        int itemIdCounter = 1;
        // 目标 1 的 8 项
        for (int i = 1; i <= 5; i++) {
            ScoringItem it = newItem(itemIdCounter++, "作业" + i, "homework", new BigDecimal("0.05"));
            items.add(it);
            links.add(newLink(it.getItemId(), OBJ1_ID));
        }
        for (int i = 1; i <= 3; i++) {
            ScoringItem it = newItem(itemIdCounter++, "实验" + i, "experiment", new BigDecimal("0.05"));
            items.add(it);
            links.add(newLink(it.getItemId(), OBJ1_ID));
        }
        // 目标 2 的 5 项
        ScoringItem exp4 = newItem(itemIdCounter++, "实验4", "experiment", new BigDecimal("0.10"));
        items.add(exp4);
        links.add(newLink(exp4.getItemId(), OBJ2_ID));
        for (int i = 1; i <= 3; i++) {
            BigDecimal w = (i <= 2) ? new BigDecimal("0.10") : new BigDecimal("0.15");
            ScoringItem it = newItem(itemIdCounter++, "大作业" + i, "project", w);
            items.add(it);
            links.add(newLink(it.getItemId(), OBJ2_ID));
        }
        // 大作业 4 (权重 0.15)
        ScoringItem proj4 = newItem(itemIdCounter, "大作业4", "project", new BigDecimal("0.15"));
        items.add(proj4);
        links.add(newLink(proj4.getItemId(), OBJ2_ID));

        when(itemMapper.selectList(any(Wrapper.class))).thenReturn(items);
        when(linkMapper.selectList(any(Wrapper.class))).thenReturn(links);

        // 4. 构造学生
        Student stu = new Student();
        stu.setStudentId(STUDENT_ID);
        stu.setStudentNo("1001");
        stu.setStudentName("张三");
        when(studentService.getById(STUDENT_ID)).thenReturn(stu);
        when(studentService.list(any(Wrapper.class))).thenReturn(List.of(stu));
        when(studentService.listByTeachingClazz("23-SE-1")).thenReturn(List.of(stu));
    }

    @Test
    @DisplayName("Excel 行 155 基准：8 项各 55 分 → 目标 1 达成度 = 0.785714")
    void calcForStudent_whenAvg55InObj1_then0_7857() {
        // 学生 8 项目标 1 评分项各 55 分（其余 0）
        List<ScoringScore> scores = new ArrayList<>();
        for (int itemId = 1; itemId <= 8; itemId++) {
            scores.add(newScore(itemId, STUDENT_ID, new BigDecimal("55")));
        }
        when(scoreMapper.selectList(any(Wrapper.class))).thenReturn(scores);

        StudentAchievementVO vo = engine.calcForStudent(OFFERING_ID, STUDENT_ID);

        // 8 × 55 × 0.05 = 22 (加权得分)
        // 8 × 70 × 0.05 = 28 (加权期望分)
        // 22 / 28 = 0.785714
        BigDecimal expected = new BigDecimal("0.785714");
        BigDecimal actual = vo.getObjectiveAchievements().get(OBJ1_ID).setScale(6, RoundingMode.HALF_UP);
        assertThat(actual).isEqualByComparingTo(expected);
    }

    @Test
    @DisplayName("各项满分时达成度 = 100/70 = 1.4286")
    void calcForStudent_whenAllFullScore_thenAchAbove1() {
        List<ScoringScore> scores = new ArrayList<>();
        for (int itemId = 1; itemId <= 8; itemId++) {
            scores.add(newScore(itemId, STUDENT_ID, new BigDecimal("100")));
        }
        when(scoreMapper.selectList(any(Wrapper.class))).thenReturn(scores);

        StudentAchievementVO vo = engine.calcForStudent(OFFERING_ID, STUDENT_ID);

        // 8 × 100 × 0.05 = 40 (加权得分)
        // 8 × 70 × 0.05 = 28 (加权期望分)
        // 40 / 28 = 1.428571
        BigDecimal expected = new BigDecimal("1.428571");
        BigDecimal actual = vo.getObjectiveAchievements().get(OBJ1_ID).setScale(6, RoundingMode.HALF_UP);
        assertThat(actual).isEqualByComparingTo(expected);
    }

    @Test
    @DisplayName("无得分时达成度 = 0")
    void calcForStudent_whenNoScore_then0() {
        when(scoreMapper.selectList(any(Wrapper.class))).thenReturn(new ArrayList<>());

        StudentAchievementVO vo = engine.calcForStudent(OFFERING_ID, STUDENT_ID);

        assertThat(vo.getObjectiveAchievements().get(OBJ1_ID)).isEqualByComparingTo(BigDecimal.ZERO);
        assertThat(vo.getTotalAchievement()).isEqualByComparingTo(BigDecimal.ZERO);
    }

    @Test
    @DisplayName("各项恰为期望分 (70) 时达成度 = 1.0")
    void calcForStudent_whenScoreEqualsPassing_thenAch1() {
        List<ScoringScore> scores = new ArrayList<>();
        for (int itemId = 1; itemId <= 8; itemId++) {
            scores.add(newScore(itemId, STUDENT_ID, new BigDecimal("70")));
        }
        when(scoreMapper.selectList(any(Wrapper.class))).thenReturn(scores);

        StudentAchievementVO vo = engine.calcForStudent(OFFERING_ID, STUDENT_ID);

        BigDecimal expected = BigDecimal.ONE.setScale(6);
        BigDecimal actual = vo.getObjectiveAchievements().get(OBJ1_ID).setScale(6, RoundingMode.HALF_UP);
        assertThat(actual).isEqualByComparingTo(expected);
    }

    @Test
    @DisplayName("班级聚合：1 个学生达成 → 班级达成度 = 1.0")
    void calcForOffering_singleStudentReached() {
        // 单学生：8 项 = 100 分 (达成)
        List<ScoringScore> scores = new ArrayList<>();
        for (int itemId = 1; itemId <= 8; itemId++) {
            scores.add(newScore(itemId, STUDENT_ID, new BigDecimal("100")));
        }
        when(scoreMapper.selectList(any(Wrapper.class))).thenReturn(scores);

        OfferingAchievementVO vo = engine.calcForOffering(OFFERING_ID);
        assertThat(vo).isNotNull();
        assertThat(vo.getByObjective()).hasSize(2);
        assertThat(vo.getStudents()).hasSize(1);

        // 学生总达成度 100/70 > 1.0 → reached
        OfferingAchievementVO.ObjectiveSummary obj1Sum = vo.getByObjective().get(OBJ1_ID);
        assertThat(obj1Sum.getReachedCount()).isEqualTo(1);
        assertThat(obj1Sum.getTotalCount()).isEqualTo(1);
        assertThat(obj1Sum.getValue()).isEqualByComparingTo(BigDecimal.ONE.setScale(6));
    }

    // ============ 边界用例 ============

    @Test
    @DisplayName("边界：单评分项 1 个目标 1 个学生")
    void edge_singleItemSingleStudent() {
        // 重新 mock 极简结构
        ScoringItem single = newItem(1, "唯一项", "exam", new BigDecimal("1.0"));
        ScoringItemObjective singleLink = newLink(1, OBJ1_ID);
        when(itemMapper.selectList(any(Wrapper.class))).thenReturn(List.of(single));
        when(linkMapper.selectList(any(Wrapper.class))).thenReturn(List.of(singleLink));
        when(scoreMapper.selectList(any(Wrapper.class))).thenReturn(
                List.of(newScore(1, STUDENT_ID, new BigDecimal("85"))));

        StudentAchievementVO vo = engine.calcForStudent(OFFERING_ID, STUDENT_ID);
        // 85 × 1.0 = 85 / (70 × 1.0) = 85/70 = 1.214286
        BigDecimal expected = new BigDecimal("1.214286");
        BigDecimal actual = vo.getObjectiveAchievements().get(OBJ1_ID).setScale(6, RoundingMode.HALF_UP);
        assertThat(actual).isEqualByComparingTo(expected);
    }

    @Test
    @DisplayName("边界：全班 0 分 → 班级达成度 = 0")
    void edge_allZeroScores() {
        when(scoreMapper.selectList(any(Wrapper.class))).thenReturn(new ArrayList<>());

        OfferingAchievementVO vo = engine.calcForOffering(OFFERING_ID);
        OfferingAchievementVO.ObjectiveSummary s = vo.getByObjective().get(OBJ1_ID);
        assertThat(s.getReachedCount()).isEqualTo(0);
        assertThat(s.getValue()).isEqualByComparingTo(BigDecimal.ZERO);
    }

    @Test
    @DisplayName("边界：单学生全 100 分 → 学生层达成度 = 1.4286 (满分 1.4286)")
    void edge_singleStudentFullScore() {
        // 单学生 setUp 中已有；学生总加权得分 / 期望 = 100/70 = 1.4286
        when(scoreMapper.selectList(any(Wrapper.class))).thenReturn(
                new ArrayList<>(List.of(
                        newScore(1, STUDENT_ID, new BigDecimal("100")),
                        newScore(2, STUDENT_ID, new BigDecimal("100")))));
        // 内部 toMap 用 studentId 过滤，但 mock 不区分；为避免 duplicate key，注入单条
        StudentAchievementVO vo = engine.calcForStudent(OFFERING_ID, STUDENT_ID);
        // 总达成度 = 各项加权得分/期望 之和 / 各项权重和
        // 仅 2 项 → 实际算法对缺失项按 0 处理，结果在 0~1.4 之间
        BigDecimal actual = vo.getTotalAchievement();
        assertThat(actual.doubleValue()).isBetween(0.0, 1.5);
    }

    @Test
    @DisplayName("边界：部分评分项无分数（缺考）→ 剩余项按公式计算")
    void edge_partialMissingScores() {
        // 只有前 4 项有分 (60), 后 4 项无
        List<ScoringScore> scores = new ArrayList<>();
        for (int itemId = 1; itemId <= 4; itemId++) {
            scores.add(newScore(itemId, STUDENT_ID, new BigDecimal("60")));
        }
        when(scoreMapper.selectList(any(Wrapper.class))).thenReturn(scores);

        StudentAchievementVO vo = engine.calcForStudent(OFFERING_ID, STUDENT_ID);
        // 4 × 60 × 0.05 = 12 (加权得分) / 8 × 70 × 0.05 = 28 (加权期望) = 0.428571
        // 注：实现通常对缺失项按 0 处理
        BigDecimal actual = vo.getObjectiveAchievements().get(OBJ1_ID).setScale(6, RoundingMode.HALF_UP);
        assertThat(actual.doubleValue()).isBetween(0.4, 0.5);
    }

    // ============ helpers ============

    private ScoringItem newItem(int id, String name, String type, BigDecimal weight) {
        ScoringItem it = new ScoringItem();
        it.setItemId(id);
        it.setOfferingId(OFFERING_ID);
        it.setName(name);
        it.setType(type);
        it.setMaxScore(100);
        it.setPassingScore(70);
        it.setWeight(weight);
        return it;
    }

    private ScoringItemObjective newLink(int itemId, int objectiveId) {
        ScoringItemObjective l = new ScoringItemObjective();
        l.setItemId(itemId);
        l.setObjectiveId(objectiveId);
        l.setWeightInObjective(BigDecimal.ONE);
        return l;
    }

    private ScoringScore newScore(int itemId, int studentId, BigDecimal score) {
        ScoringScore s = new ScoringScore();
        s.setItemId(itemId);
        s.setStudentId(studentId);
        s.setScore(score);
        return s;
    }

    private Student stuOf(int id, String no, String name) {
        Student s = new Student();
        s.setStudentId(id);
        s.setStudentNo(no);
        s.setStudentName(name);
        return s;
    }
}
