package com.labex.service.teaching.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.labex.entity.Clazz;
import com.labex.entity.Student;
import com.labex.entity.Teacher;
import com.labex.entity.teaching.*;
import com.labex.mapper.teaching.*;
import com.labex.service.ClazzService;
import com.labex.service.StudentService;
import com.labex.service.TeacherService;
import com.labex.service.teaching.AchievementCalcEngine;
import com.labex.service.teaching.QualityReportGenerator;
import com.labex.vo.teaching.*;
import lombok.extern.slf4j.Slf4j;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDType0Font;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.*;
import java.util.stream.Collectors;

@Service
@Slf4j
public class QualityReportGeneratorImpl implements QualityReportGenerator {

    private static final ObjectMapper JSON = new ObjectMapper();

    @Autowired private CourseOfferingMapper offeringMapper;
    @Autowired private CourseMapper courseMapper;
    @Autowired private CourseObjectiveMapper objectiveMapper;
    @Autowired private ObjectiveSupportMapper supportMapper;
    @Autowired private GraduationIndicatorMapper indicatorMapper;
    @Autowired private GraduationRequirementMapper requirementMapper;
    @Autowired private ScoringItemMapper itemMapper;
    @Autowired private ScoringItemObjectiveMapper linkMapper;
    @Autowired private QualityEvaluationMapper evaluationMapper;
    @Autowired private TeacherService teacherService;
    @Autowired private ClazzService clazzService;
    @Autowired private StudentService studentService;
    @Autowired private AchievementCalcEngine achievementEngine;

    // ============ 报告 1: 成绩统计表 ============

    @Override
    public GradeStatReportVO gradeStat(Integer offeringId) {
        GradeStatReportVO vo = new GradeStatReportVO();
        CourseOffering offering = offeringMapper.selectById(offeringId);
        if (offering == null) return vo;
        Course course = courseMapper.selectById(offering.getCourseId());
        Teacher teacher = teacherService.getById(offering.getTeacherId());

        vo.setDepartment(course != null ? course.getDepartment() : null);
        vo.setCourseName(course != null ? course.getNameCn() : null);
        vo.setClazzNo(offering.getClazzNo());
        vo.setTeacherName(teacher != null ? teacher.getTeacherName() : null);
        vo.setQuestioner(teacher != null ? teacher.getTeacherName() : null);
        vo.setExpectedValue(60);

        OfferingAchievementVO ach = achievementEngine.calcForOffering(offeringId);
        List<StudentAchievementVO> students = ach.getStudents();
        if (students.isEmpty()) {
            vo.setDistribution(buildEmptyDistribution());
            return vo;
        }

        // 将 totalAchievement (0~1) 映射为百分制总分
        List<BigDecimal> scores = students.stream()
                .map(s -> s.getTotalAchievement().multiply(BigDecimal.valueOf(100)))
                .collect(Collectors.toList());

        BigDecimal sum = scores.stream().reduce(BigDecimal.ZERO, BigDecimal::add);
        vo.setAvgScore(sum.divide(BigDecimal.valueOf(scores.size()), 2, RoundingMode.HALF_UP));
        vo.setMaxScore(scores.stream().max(Comparator.naturalOrder()).orElse(BigDecimal.ZERO));
        vo.setMinScore(scores.stream().min(Comparator.naturalOrder()).orElse(BigDecimal.ZERO));

        long passing = scores.stream().filter(s -> s.compareTo(BigDecimal.valueOf(60)) >= 0).count();
        vo.setPassingRate(BigDecimal.valueOf(passing * 100.0 / scores.size()).setScale(2, RoundingMode.HALF_UP));

        // 分布
        List<GradeStatReportVO.ScoreRangeBucket> dist = buildEmptyDistribution();
        for (BigDecimal s : scores) {
            int range = bucketIndex(s);
            GradeStatReportVO.ScoreRangeBucket b = dist.get(range);
            b.setCount(b.getCount() + 1);
        }
        for (GradeStatReportVO.ScoreRangeBucket b : dist) {
            b.setPercent(BigDecimal.valueOf(b.getCount() * 100.0 / scores.size()).setScale(2, RoundingMode.HALF_UP));
        }
        vo.setDistribution(dist);

        vo.setReachedExpected(vo.getAvgScore().compareTo(BigDecimal.valueOf(60)) >= 0);
        vo.setNormalDistribution(isApproxNormal(dist));

        return vo;
    }

    private List<GradeStatReportVO.ScoreRangeBucket> buildEmptyDistribution() {
        List<GradeStatReportVO.ScoreRangeBucket> dist = new ArrayList<>();
        String[] ranges = {"100-90", "89-80", "79-70", "69-60", "60 分以下"};
        for (String r : ranges) {
            GradeStatReportVO.ScoreRangeBucket b = new GradeStatReportVO.ScoreRangeBucket();
            b.setRange(r);
            b.setCount(0);
            b.setPercent(BigDecimal.ZERO);
            dist.add(b);
        }
        return dist;
    }

    private int bucketIndex(BigDecimal score) {
        double v = score.doubleValue();
        if (v >= 90) return 0;
        if (v >= 80) return 1;
        if (v >= 70) return 2;
        if (v >= 60) return 3;
        return 4;
    }

    private boolean isApproxNormal(List<GradeStatReportVO.ScoreRangeBucket> dist) {
        // 简化判定：中间区段（80-89,70-79）人数占比 >= 35% 视为近似正态
        int mid = dist.get(1).getCount() + dist.get(2).getCount();
        int total = dist.stream().mapToInt(GradeStatReportVO.ScoreRangeBucket::getCount).sum();
        return total > 0 && mid * 1.0 / total >= 0.35;
    }

    // ============ 报告 2: 考核合理性审核表 ============

    @Override
    public ConsistencyReportVO consistency(Integer offeringId) {
        ConsistencyReportVO vo = new ConsistencyReportVO();
        CourseOffering offering = offeringMapper.selectById(offeringId);
        if (offering == null) return vo;
        Course course = courseMapper.selectById(offering.getCourseId());

        vo.setCourseName(course != null ? course.getNameCn() : null);
        vo.setCourseCategory(course != null ? course.getDepartment() : null);
        vo.setTeachingHours(course != null ? course.getHours() : null);
        vo.setCourseCredit(course != null ? course.getCredit() : null);
        vo.setSemester(offering.getSemester());
        vo.setTeachingTarget(course != null ? course.getMajor() : null);
        vo.setStudentCount(offering.getStudentCount());
        Teacher owner = course != null && course.getOwnerId() != null ? teacherService.getById(course.getOwnerId()) : null;
        vo.setCourseResponsible(owner != null ? owner.getTeacherName() : null);

        List<CourseObjective> objectives = course == null ? Collections.emptyList()
                : objectiveMapper.selectList(new LambdaQueryWrapper<CourseObjective>()
                .eq(CourseObjective::getCourseId, course.getCourseId())
                .orderByAsc(CourseObjective::getSortOrder));

        List<ScoringItem> items = itemMapper.selectList(new LambdaQueryWrapper<ScoringItem>()
                .eq(ScoringItem::getOfferingId, offeringId));
        Map<Integer, List<ScoringItem>> objItems = groupItemsByObjective(items);

        List<ConsistencyReportVO.ObjectiveRow> rows = new ArrayList<>();
        for (CourseObjective obj : objectives) {
            ConsistencyReportVO.ObjectiveRow row = new ConsistencyReportVO.ObjectiveRow();
            row.setObjectiveCode(obj.getCode());
            row.setObjectiveDescription(obj.getDescription());
            List<ScoringItem> myItems = objItems.getOrDefault(obj.getObjectiveId(), Collections.emptyList());
            row.setAssessmentContent(myItems.stream().map(ScoringItem::getName).collect(Collectors.joining("、")));
            row.setAssessmentMethod(myItems.stream().map(ScoringItem::getType).distinct().collect(Collectors.joining("/")));
            BigDecimal totalScore = myItems.stream()
                    .map(i -> i.getWeight().multiply(BigDecimal.valueOf(i.getMaxScore() == null ? 100 : i.getMaxScore())))
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
            row.setAssessmentScore(totalScore.setScale(2, RoundingMode.HALF_UP));
            row.setRationalityComment(myItems.isEmpty() ? "未配置评分项" : "合理");
            rows.add(row);
        }
        vo.setRows(rows);
        return vo;
    }

    private Map<Integer, List<ScoringItem>> groupItemsByObjective(List<ScoringItem> items) {
        Map<Integer, List<ScoringItem>> result = new HashMap<>();
        if (items.isEmpty()) return result;
        List<Integer> ids = items.stream().map(ScoringItem::getItemId).collect(Collectors.toList());
        List<ScoringItemObjective> links = linkMapper.selectList(new LambdaQueryWrapper<ScoringItemObjective>()
                .in(ScoringItemObjective::getItemId, ids));
        Map<Integer, ScoringItem> itemById = items.stream().collect(Collectors.toMap(ScoringItem::getItemId, i -> i));
        for (ScoringItemObjective l : links) {
            result.computeIfAbsent(l.getObjectiveId(), k -> new ArrayList<>()).add(itemById.get(l.getItemId()));
        }
        return result;
    }

    // ============ 报告 3: 课程目标达成情况评价报告 ============

    @Override
    public AttainmentReportVO attainment(Integer offeringId, Integer evaluationId) {
        AttainmentReportVO vo = new AttainmentReportVO();
        CourseOffering offering = offeringMapper.selectById(offeringId);
        if (offering == null) return vo;
        Course course = courseMapper.selectById(offering.getCourseId());
        Teacher teacher = teacherService.getById(offering.getTeacherId());
        QualityEvaluation eval = evaluationId == null ? null : evaluationMapper.selectById(evaluationId);

        // 一、基本信息
        AttainmentReportVO.CourseBasicInfo basic = new AttainmentReportVO.CourseBasicInfo();
        basic.setCourseName(course != null ? course.getNameCn() : null);
        basic.setSemester(offering.getSemester());
        basic.setTheoryHours(course != null ? course.getTheoryHours() : null);
        basic.setLabHours(course != null ? course.getLabHours() : null);
        basic.setAssessmentMethod("过程性 + 终结性");
        basic.setTeacherName(teacher != null ? teacher.getTeacherName() : null);
        basic.setTeacherTitle(teacher != null ? teacher.getRole() : null);
        basic.setClazzNo(offering.getClazzNo());
        basic.setStudentCount(offering.getStudentCount());
        vo.setBasicInfo(basic);

        // 二、目标 ↔ 毕业要求对应关系
        List<CourseObjective> objectives = course == null ? Collections.emptyList()
                : objectiveMapper.selectList(new LambdaQueryWrapper<CourseObjective>()
                .eq(CourseObjective::getCourseId, course.getCourseId())
                .orderByAsc(CourseObjective::getSortOrder));
        List<AttainmentReportVO.ObjectiveSupportRow> supports = new ArrayList<>();
        for (CourseObjective obj : objectives) {
            AttainmentReportVO.ObjectiveSupportRow row = new AttainmentReportVO.ObjectiveSupportRow();
            row.setObjectiveCode(obj.getCode());
            row.setObjectiveDescription(obj.getDescription());
            // 取支撑指标点
            List<ObjectiveSupport> os = supportMapper.selectList(new LambdaQueryWrapper<ObjectiveSupport>()
                    .eq(ObjectiveSupport::getObjectiveId, obj.getObjectiveId()));
            if (!os.isEmpty()) {
                List<Integer> indIds = os.stream().map(ObjectiveSupport::getIndicatorId).collect(Collectors.toList());
                List<GraduationIndicator> inds = indicatorMapper.selectBatchIds(indIds);
                row.setSupportedIndicators(inds.stream().map(GraduationIndicator::getCode).collect(Collectors.joining(", ")));
                Set<Integer> reqIds = inds.stream().map(GraduationIndicator::getRequirementId).collect(Collectors.toSet());
                if (!reqIds.isEmpty()) {
                    List<GraduationRequirement> reqs = requirementMapper.selectBatchIds(reqIds);
                    row.setSupportedRequirements(reqs.stream().map(GraduationRequirement::getCode).collect(Collectors.joining(", ")));
                }
            }
            row.setAttainmentMethod("课堂讲授 + 实验 + 作业");
            supports.add(row);
        }
        vo.setObjectiveSupports(supports);

        // 三、考核分配
        List<ScoringItem> items = itemMapper.selectList(new LambdaQueryWrapper<ScoringItem>()
                .eq(ScoringItem::getOfferingId, offeringId));
        Map<Integer, List<ScoringItem>> objItems = groupItemsByObjective(items);
        List<AttainmentReportVO.AssessmentDistribution> distList = new ArrayList<>();
        for (CourseObjective obj : objectives) {
            AttainmentReportVO.AssessmentDistribution d = new AttainmentReportVO.AssessmentDistribution();
            d.setObjectiveCode(obj.getCode());
            Map<String, BigDecimal> typeWeights = new LinkedHashMap<>();
            BigDecimal total = BigDecimal.ZERO;
            for (ScoringItem item : objItems.getOrDefault(obj.getObjectiveId(), Collections.emptyList())) {
                BigDecimal w = item.getWeight().multiply(BigDecimal.valueOf(item.getMaxScore() == null ? 100 : item.getMaxScore()));
                typeWeights.merge(item.getType(), w, BigDecimal::add);
                total = total.add(w);
            }
            d.setTypeWeights(typeWeights);
            d.setTotalScore(total.setScale(2, RoundingMode.HALF_UP));
            d.setExpectedValue(total.multiply(new BigDecimal("0.7")).setScale(2, RoundingMode.HALF_UP));
            d.setAssessmentContent(objItems.getOrDefault(obj.getObjectiveId(), Collections.emptyList())
                    .stream().map(ScoringItem::getName).collect(Collectors.joining("、")));
            distList.add(d);
        }
        vo.setAssessmentDistribution(distList);

        // 四、合理性分析（手填）
        vo.setRationalityAnalysis(eval != null ? eval.getEvaluationValidity() : "");

        // 五、达成情况
        GradeStatReportVO gradeStat = gradeStat(offeringId);
        AttainmentReportVO.MainScoreData main = new AttainmentReportVO.MainScoreData();
        main.setMaxScore(gradeStat.getMaxScore());
        main.setMinScore(gradeStat.getMinScore());
        main.setAvgScore(gradeStat.getAvgScore());
        main.setDistribution(gradeStat.getDistribution());
        vo.setMainScoreData(main);

        OfferingAchievementVO ach = achievementEngine.calcForOffering(offeringId);
        List<AttainmentReportVO.ObjectiveAttainmentRow> attainmentRows = new ArrayList<>();
        for (CourseObjective obj : objectives) {
            OfferingAchievementVO.ObjectiveSummary s = ach.getByObjective().get(obj.getObjectiveId());
            AttainmentReportVO.ObjectiveAttainmentRow r = new AttainmentReportVO.ObjectiveAttainmentRow();
            r.setObjectiveCode(obj.getCode());
            List<ScoringItem> myItems = objItems.getOrDefault(obj.getObjectiveId(), Collections.emptyList());
            r.setAssessmentLink(myItems.stream().map(ScoringItem::getName).collect(Collectors.joining("、")));
            BigDecimal totalW = myItems.stream().map(ScoringItem::getWeight).reduce(BigDecimal.ZERO, BigDecimal::add);
            r.setWeight(totalW);
            r.setMaxScore(100);
            r.setAvgScore(s != null ? s.getAvgScore() : BigDecimal.ZERO);
            r.setExpectedValue(s != null ? s.getExpectedRatio() : new BigDecimal("0.7"));
            r.setReachedCount(s != null ? s.getReachedCount() : 0);
            r.setTotalCount(s != null ? s.getTotalCount() : 0);
            r.setAttainmentValue(s != null ? s.getValue() : BigDecimal.ZERO);
            attainmentRows.add(r);
        }
        vo.setObjectiveAttainment(attainmentRows);

        // 六、七、八（教师手填）
        vo.setAttainmentAnalysis(eval != null ? eval.getEvaluationValidity() : "");
        vo.setLastRoundImprovements(eval != null ? eval.getLastRoundImprovements() : "");
        vo.setNextRoundImprovements(eval != null ? eval.getConclusionAndSuggestions() : "");

        return vo;
    }

    // ============ 报告 4: 课程质量评价表 ============

    @Override
    public QualityReportVO quality(Integer evaluationId) {
        QualityReportVO vo = new QualityReportVO();
        QualityEvaluation eval = evaluationMapper.selectById(evaluationId);
        if (eval == null) return vo;
        CourseOffering offering = offeringMapper.selectById(eval.getOfferingId());
        if (offering == null) return vo;
        Course course = courseMapper.selectById(offering.getCourseId());

        vo.setCourseName(course != null ? course.getNameCn() : null);
        vo.setCourseCategory(course != null ? course.getDepartment() : null);
        vo.setTeachingHours(course != null ? course.getHours() : null);
        vo.setCourseCredit(course != null ? course.getCredit() : null);
        vo.setSemester(offering.getSemester());
        vo.setTeachingTarget(course != null ? course.getMajor() : null);
        vo.setStudentCount(offering.getStudentCount());
        vo.setCourseResponsible(eval.getCourseResponsible());

        try {
            if (eval.getCourseMembers() != null) {
                vo.setCourseMembers(JSON.readValue(eval.getCourseMembers(), new TypeReference<>() {}));
            }
            if (eval.getEvalGroupMembers() != null) {
                vo.setEvalGroupMembers(JSON.readValue(eval.getEvalGroupMembers(), new TypeReference<>() {}));
            }
            if (eval.getAchievementValues() != null) {
                vo.setAttainmentValues(JSON.readValue(eval.getAchievementValues(), new TypeReference<>() {}));
            }
        } catch (JsonProcessingException e) {
            log.warn("JSON 解析失败", e);
        }

        vo.setObjectiveIndicatorRationality(eval.getObjectiveIndicatorRationality());
        vo.setObjectiveContainsKaq(eval.getObjectiveContainsKaq());
        vo.setExpectedRationality(eval.getExpectedRationality());
        vo.setAnalysisRationality(eval.getAnalysisRationality());
        vo.setImprovementRationality(eval.getImprovementRationality());
        vo.setExistingIssues(eval.getExistingIssues());
        vo.setEvaluationValidity(eval.getEvaluationValidity());
        vo.setLastRoundImprovements(eval.getLastRoundImprovements());
        vo.setConclusionAndSuggestions(eval.getConclusionAndSuggestions());

        return vo;
    }

    // ============ 导出 ============

    @Override
    public byte[] exportExcel(Integer offeringId, ReportType type, Integer evaluationId) {
        try (Workbook wb = new XSSFWorkbook(); ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            CellStyle title = wb.createCellStyle();
            Font tFont = wb.createFont();
            tFont.setBold(true);
            tFont.setFontHeightInPoints((short) 14);
            title.setFont(tFont);
            title.setAlignment(HorizontalAlignment.CENTER);

            CellStyle header = wb.createCellStyle();
            Font hFont = wb.createFont();
            hFont.setBold(true);
            header.setFont(hFont);
            header.setAlignment(HorizontalAlignment.CENTER);
            header.setFillForegroundColor(IndexedColors.LIGHT_BLUE.getIndex());
            header.setFillPattern(FillPatternType.SOLID_FOREGROUND);

            switch (type) {
                case GRADE_STAT -> renderGradeStat(wb, gradeStat(offeringId), title, header);
                case CONSISTENCY -> renderConsistency(wb, consistency(offeringId), title, header);
                case ATTAINMENT -> renderAttainment(wb, attainment(offeringId, evaluationId), title, header);
                case QUALITY -> renderQuality(wb, quality(evaluationId), title, header);
            }
            wb.write(out);
            return out.toByteArray();
        } catch (IOException e) {
            log.error("Excel 报告导出失败", e);
            throw new RuntimeException("Excel 报告导出失败: " + e.getMessage(), e);
        }
    }

    private void renderGradeStat(Workbook wb, GradeStatReportVO vo, CellStyle title, CellStyle header) {
        Sheet sheet = wb.createSheet("成绩统计表");
        int r = 0;
        Row titleRow = sheet.createRow(r++);
        Cell tc = titleRow.createCell(0);
        tc.setCellValue("成绩统计表");
        tc.setCellStyle(title);
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 5));

        String[][] basics = {
                {"教研室", vo.getDepartment() == null ? "" : vo.getDepartment()},
                {"课程名称", vo.getCourseName() == null ? "" : vo.getCourseName()},
                {"授课班级", vo.getClazzNo() == null ? "" : vo.getClazzNo()},
                {"任课教师", vo.getTeacherName() == null ? "" : vo.getTeacherName()},
                {"命题教师", vo.getQuestioner() == null ? "" : vo.getQuestioner()},
                {"期望值", String.valueOf(vo.getExpectedValue())},
                {"平均分", vo.getAvgScore() == null ? "" : vo.getAvgScore().toString()},
                {"最高分", vo.getMaxScore() == null ? "" : vo.getMaxScore().toString()},
                {"最低分", vo.getMinScore() == null ? "" : vo.getMinScore().toString()},
                {"及格率(%)", vo.getPassingRate() == null ? "" : vo.getPassingRate().toString()},
                {"达到期望值", vo.getReachedExpected() != null && vo.getReachedExpected() ? "是" : "否"},
                {"正态分布", vo.getNormalDistribution() != null && vo.getNormalDistribution() ? "是" : "否"}
        };
        for (String[] b : basics) {
            Row row = sheet.createRow(r++);
            Cell c0 = row.createCell(0);
            c0.setCellValue(b[0]);
            c0.setCellStyle(header);
            row.createCell(1).setCellValue(b[1]);
        }

        r++;
        Row dHead = sheet.createRow(r++);
        String[] dh = {"分数段", "人数", "百分比(%)"};
        for (int i = 0; i < dh.length; i++) {
            Cell c = dHead.createCell(i);
            c.setCellValue(dh[i]);
            c.setCellStyle(header);
        }
        if (vo.getDistribution() != null) {
            for (GradeStatReportVO.ScoreRangeBucket b : vo.getDistribution()) {
                Row row = sheet.createRow(r++);
                row.createCell(0).setCellValue(b.getRange());
                row.createCell(1).setCellValue(b.getCount());
                row.createCell(2).setCellValue(b.getPercent() == null ? 0 : b.getPercent().doubleValue());
            }
        }
        for (int i = 0; i < 6; i++) sheet.autoSizeColumn(i);
    }

    private void renderConsistency(Workbook wb, ConsistencyReportVO vo, CellStyle title, CellStyle header) {
        Sheet sheet = wb.createSheet("考核合理性审核表");
        int r = 0;
        Row tr = sheet.createRow(r++);
        Cell tc = tr.createCell(0);
        tc.setCellValue("课程考核合理性审核表");
        tc.setCellStyle(title);
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 5));

        String[][] basics = {
                {"课程名称", str(vo.getCourseName())},
                {"课程类别", str(vo.getCourseCategory())},
                {"授课学时", String.valueOf(vo.getTeachingHours())},
                {"课程学分", String.valueOf(vo.getCourseCredit())},
                {"开课学期", str(vo.getSemester())},
                {"授课对象", str(vo.getTeachingTarget())},
                {"授课人数", String.valueOf(vo.getStudentCount())},
                {"课程负责人", str(vo.getCourseResponsible())}
        };
        for (String[] b : basics) {
            Row row = sheet.createRow(r++);
            Cell c0 = row.createCell(0);
            c0.setCellValue(b[0]);
            c0.setCellStyle(header);
            row.createCell(1).setCellValue(b[1]);
        }
        r++;

        Row dHead = sheet.createRow(r++);
        String[] dh = {"课程目标", "考核内容", "考核方式", "考核分值", "合理性审核意见"};
        for (int i = 0; i < dh.length; i++) {
            Cell c = dHead.createCell(i);
            c.setCellValue(dh[i]);
            c.setCellStyle(header);
        }
        if (vo.getRows() != null) {
            for (ConsistencyReportVO.ObjectiveRow row : vo.getRows()) {
                Row r2 = sheet.createRow(r++);
                r2.createCell(0).setCellValue(row.getObjectiveCode() + " " + str(row.getObjectiveDescription()));
                r2.createCell(1).setCellValue(str(row.getAssessmentContent()));
                r2.createCell(2).setCellValue(str(row.getAssessmentMethod()));
                r2.createCell(3).setCellValue(row.getAssessmentScore() == null ? 0 : row.getAssessmentScore().doubleValue());
                r2.createCell(4).setCellValue(str(row.getRationalityComment()));
            }
        }
        for (int i = 0; i < 5; i++) sheet.autoSizeColumn(i);
    }

    private void renderAttainment(Workbook wb, AttainmentReportVO vo, CellStyle title, CellStyle header) {
        Sheet sheet = wb.createSheet("达成情况评价报告");
        int r = 0;
        Row tr = sheet.createRow(r++);
        Cell tc = tr.createCell(0);
        tc.setCellValue("课程目标达成情况评价报告");
        tc.setCellStyle(title);
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 7));

        if (vo.getBasicInfo() != null) {
            r = writeSection(sheet, r, "一、课程基本信息", header);
            AttainmentReportVO.CourseBasicInfo b = vo.getBasicInfo();
            r = writeKV(sheet, r, "课程名称", str(b.getCourseName()));
            r = writeKV(sheet, r, "学期", str(b.getSemester()));
            r = writeKV(sheet, r, "理论/实验学时", b.getTheoryHours() + " / " + b.getLabHours());
            r = writeKV(sheet, r, "考核方式", str(b.getAssessmentMethod()));
            r = writeKV(sheet, r, "任课教师", str(b.getTeacherName()));
            r = writeKV(sheet, r, "授课班级", str(b.getClazzNo()));
            r = writeKV(sheet, r, "学生人数", String.valueOf(b.getStudentCount()));
        }

        if (vo.getObjectiveSupports() != null) {
            r++;
            r = writeSection(sheet, r, "二、课程目标与毕业要求对应关系", header);
            Row h = sheet.createRow(r++);
            String[] hs = {"课程目标", "描述", "支撑毕业要求", "支撑指标点", "达成途径"};
            for (int i = 0; i < hs.length; i++) {
                Cell c = h.createCell(i);
                c.setCellValue(hs[i]);
                c.setCellStyle(header);
            }
            for (AttainmentReportVO.ObjectiveSupportRow row : vo.getObjectiveSupports()) {
                Row r2 = sheet.createRow(r++);
                r2.createCell(0).setCellValue(str(row.getObjectiveCode()));
                r2.createCell(1).setCellValue(str(row.getObjectiveDescription()));
                r2.createCell(2).setCellValue(str(row.getSupportedRequirements()));
                r2.createCell(3).setCellValue(str(row.getSupportedIndicators()));
                r2.createCell(4).setCellValue(str(row.getAttainmentMethod()));
            }
        }

        if (vo.getObjectiveAttainment() != null) {
            r++;
            r = writeSection(sheet, r, "五、各课程目标达成情况", header);
            Row h = sheet.createRow(r++);
            String[] hs = {"目标", "考核环节", "权重", "满分", "平均得分", "期望值", "达到人数", "总人数", "达成度"};
            for (int i = 0; i < hs.length; i++) {
                Cell c = h.createCell(i);
                c.setCellValue(hs[i]);
                c.setCellStyle(header);
            }
            for (AttainmentReportVO.ObjectiveAttainmentRow row : vo.getObjectiveAttainment()) {
                Row r2 = sheet.createRow(r++);
                r2.createCell(0).setCellValue(str(row.getObjectiveCode()));
                r2.createCell(1).setCellValue(str(row.getAssessmentLink()));
                r2.createCell(2).setCellValue(row.getWeight() == null ? 0 : row.getWeight().doubleValue());
                r2.createCell(3).setCellValue(row.getMaxScore() == null ? 0 : row.getMaxScore());
                r2.createCell(4).setCellValue(row.getAvgScore() == null ? 0 : row.getAvgScore().doubleValue());
                r2.createCell(5).setCellValue(row.getExpectedValue() == null ? 0 : row.getExpectedValue().doubleValue());
                r2.createCell(6).setCellValue(row.getReachedCount() == null ? 0 : row.getReachedCount());
                r2.createCell(7).setCellValue(row.getTotalCount() == null ? 0 : row.getTotalCount());
                r2.createCell(8).setCellValue(row.getAttainmentValue() == null ? 0 : row.getAttainmentValue().doubleValue());
            }
        }

        r++;
        r = writeKV(sheet, r, "六、达成评价分析", str(vo.getAttainmentAnalysis()));
        r = writeKV(sheet, r, "七、上一轮问题改进效果", str(vo.getLastRoundImprovements()));
        r = writeKV(sheet, r, "八、下一轮改进措施", str(vo.getNextRoundImprovements()));

        for (int i = 0; i < 9; i++) sheet.autoSizeColumn(i);
    }

    private void renderQuality(Workbook wb, QualityReportVO vo, CellStyle title, CellStyle header) {
        Sheet sheet = wb.createSheet("课程质量评价表");
        int r = 0;
        Row tr = sheet.createRow(r++);
        Cell tc = tr.createCell(0);
        tc.setCellValue("课程质量评价表");
        tc.setCellStyle(title);
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 5));

        r = writeKV(sheet, r, "课程名称", str(vo.getCourseName()));
        r = writeKV(sheet, r, "课程类别", str(vo.getCourseCategory()));
        r = writeKV(sheet, r, "学时/学分", vo.getTeachingHours() + " / " + vo.getCourseCredit());
        r = writeKV(sheet, r, "开课学期", str(vo.getSemester()));
        r = writeKV(sheet, r, "授课对象", str(vo.getTeachingTarget()));
        r = writeKV(sheet, r, "授课人数", String.valueOf(vo.getStudentCount()));
        r = writeKV(sheet, r, "课程负责人", str(vo.getCourseResponsible()));
        r = writeKV(sheet, r, "课程组成员", vo.getCourseMembers() == null ? "" : String.join("、", vo.getCourseMembers()));
        r = writeKV(sheet, r, "评价小组成员", vo.getEvalGroupMembers() == null ? "" : String.join("、", vo.getEvalGroupMembers()));

        r++;
        r = writeSection(sheet, r, "评价项目", header);
        Row h = sheet.createRow(r++);
        String[] hs = {"评价项目", "评价依据", "评价结果"};
        for (int i = 0; i < hs.length; i++) {
            Cell c = h.createCell(i);
            c.setCellValue(hs[i]);
            c.setCellStyle(header);
        }
        String[][] items = {
                {"课程目标合理性", "课程目标与所支撑的毕业要求指标点对应关系", chineseRationality(vo.getObjectiveIndicatorRationality())},
                {"课程目标合理性", "课程目标是否包含知识/能力/素养目标", chineseContains(vo.getObjectiveContainsKaq())},
                {"课程目标达成情况", "各课程目标达成值",
                        vo.getAttainmentValues() == null ? "" : vo.getAttainmentValues().toString()},
                {"课程目标达成情况", "各课程目标期望值合理性", chineseRationality(vo.getExpectedRationality())},
                {"课程目标达成情况", "课程目标达成情况分析合理性", chineseRationality(vo.getAnalysisRationality())},
                {"课程目标达成情况", "持续改进措施合理性", chineseRationality(vo.getImprovementRationality())}
        };
        for (String[] it : items) {
            Row row = sheet.createRow(r++);
            row.createCell(0).setCellValue(it[0]);
            row.createCell(1).setCellValue(it[1]);
            row.createCell(2).setCellValue(it[2]);
        }

        r++;
        r = writeKV(sheet, r, "1、课程存在的问题", str(vo.getExistingIssues()));
        r = writeKV(sheet, r, "2、达成评价的有效性", str(vo.getEvaluationValidity()));
        r = writeKV(sheet, r, "3、上一轮问题改进", str(vo.getLastRoundImprovements()));
        r = writeKV(sheet, r, "4、结论及改进意见", str(vo.getConclusionAndSuggestions()));

        for (int i = 0; i < 3; i++) sheet.autoSizeColumn(i);
    }

    private String chineseRationality(String v) {
        if (v == null) return "未填写";
        return switch (v) {
            case "reasonable" -> "合理";
            case "relatively" -> "比较合理";
            case "unreasonable" -> "不合理";
            default -> v;
        };
    }

    private String chineseContains(String v) {
        if (v == null) return "未填写";
        return switch (v) {
            case "contain" -> "包含";
            case "partial" -> "部分包含";
            case "none" -> "不包含";
            default -> v;
        };
    }

    private int writeKV(Sheet sheet, int r, String k, String v) {
        Row row = sheet.createRow(r);
        row.createCell(0).setCellValue(k);
        row.createCell(1).setCellValue(v == null ? "" : v);
        return r + 1;
    }

    private int writeSection(Sheet sheet, int r, String section, CellStyle style) {
        Row row = sheet.createRow(r);
        Cell c = row.createCell(0);
        c.setCellValue(section);
        c.setCellStyle(style);
        return r + 1;
    }

    private String str(Object o) {
        return o == null ? "" : o.toString();
    }

    // ============ PDF 导出（简化版） ============

    @Override
    public byte[] exportPdf(Integer offeringId, ReportType type, Integer evaluationId) {
        try (PDDocument doc = new PDDocument(); ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            PDPage page = new PDPage();
            doc.addPage(page);
            try (PDPageContentStream cs = new PDPageContentStream(doc, page)) {
                // 中文支持：尝试加载系统字体
                org.apache.pdfbox.pdmodel.font.PDFont font = loadChineseFont(doc);
                cs.beginText();
                cs.setFont(font, 14);
                cs.newLineAtOffset(50, 750);
                cs.showText(reportTypeTitle(type));
                cs.endText();

                cs.beginText();
                cs.setFont(font, 10);
                cs.newLineAtOffset(50, 720);
                String content = buildPdfContent(type, offeringId, evaluationId);
                // 简单按行写
                for (String line : content.split("\n")) {
                    if (line.length() > 60) line = line.substring(0, 60) + "...";
                    cs.showText(line);
                    cs.newLineAtOffset(0, -15);
                }
                cs.endText();
            }
            doc.save(out);
            return out.toByteArray();
        } catch (IOException e) {
            log.error("PDF 导出失败", e);
            throw new RuntimeException("PDF 导出失败: " + e.getMessage(), e);
        }
    }

    private org.apache.pdfbox.pdmodel.font.PDFont loadChineseFont(PDDocument doc) throws IOException {
        // 优先用项目自带字体（fonts/ 目录）
        try {
            Resource r = new ClassPathResource("fonts/SourceHanSansCN-Normal.ttf");
            if (r.exists()) {
                return PDType0Font.load(doc, r.getInputStream(), true);
            }
        } catch (Exception ignored) {
        }
        // 退化：用 PDFBox 内置 Helvetica（中文会乱码，但不会报错）
        return PDType1Font.HELVETICA;
    }

    private String reportTypeTitle(ReportType type) {
        return switch (type) {
            case GRADE_STAT -> "成绩统计表";
            case CONSISTENCY -> "考核合理性审核表";
            case ATTAINMENT -> "课程目标达成情况评价报告";
            case QUALITY -> "课程质量评价表";
        };
    }

    private String buildPdfContent(ReportType type, Integer offeringId, Integer evaluationId) {
        try {
            return switch (type) {
                case GRADE_STAT -> JSON.writerWithDefaultPrettyPrinter().writeValueAsString(gradeStat(offeringId));
                case CONSISTENCY -> JSON.writerWithDefaultPrettyPrinter().writeValueAsString(consistency(offeringId));
                case ATTAINMENT -> JSON.writerWithDefaultPrettyPrinter().writeValueAsString(attainment(offeringId, evaluationId));
                case QUALITY -> JSON.writerWithDefaultPrettyPrinter().writeValueAsString(quality(evaluationId));
            };
        } catch (JsonProcessingException e) {
            return "Error: " + e.getMessage();
        }
    }
}
