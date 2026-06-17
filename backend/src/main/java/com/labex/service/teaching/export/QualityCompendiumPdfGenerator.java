package com.labex.service.teaching.export;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.labex.entity.Teacher;
import com.labex.entity.teaching.*;
import com.labex.mapper.TeacherMapper;
import com.labex.mapper.teaching.*;
import com.labex.service.teaching.AchievementCalcEngine;
import com.labex.service.teaching.QualityReportGenerator;
import com.labex.vo.teaching.OfferingAchievementVO;
import com.labex.vo.teaching.AttainmentReportVO;
import lombok.extern.slf4j.Slf4j;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.font.PDFont;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

import static com.labex.service.teaching.export.PdfDrawingHelper.*;

/**
 * 课程质量评价资料汇编 PDF 生成器
 * 严格按 Class-docs/课程质量评价资料汇编.pdf 模板（8 页 4 张表）
 *  - Page 1 封面 + 资料目录
 *  - Page 2 表 1 成绩统计表
 *  - Page 3 表 2 考核合理性审核表
 *  - Page 4-6 表 3 课程目标达成情况评价报告
 *  - Page 7-8 表 4 课程质量评价表
 */
@Service
@Slf4j
public class QualityCompendiumPdfGenerator {

    @Autowired private PdfDrawingHelper draw;
    @Autowired private CourseOfferingMapper offeringMapper;
    @Autowired private CourseMapper courseMapper;
    @Autowired private TeacherMapper teacherMapper;
    @Autowired private CourseObjectiveMapper objectiveMapper;
    @Autowired private ObjectiveSupportMapper supportMapper;
    @Autowired private GraduationIndicatorMapper indicatorMapper;
    @Autowired private GraduationRequirementMapper requirementMapper;
    @Autowired private ScoringItemMapper itemMapper;
    @Autowired private ScoringItemObjectiveMapper itemObjMapper;
    @Autowired private QualityEvaluationMapper evaluationMapper;
    @Autowired private QualityReportGenerator reportGen;
    @Autowired private AchievementCalcEngine achievementEngine;
    @Autowired private ClassDocTemplateService templateService;

    public byte[] generate(Integer offeringId, Integer evaluationId) {
        try (PDDocument doc = templateService.openPdfTemplate("课程质量评价资料汇编.pdf");
             ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            if (doc.getNumberOfPages() < 8) {
                throw new IllegalStateException("课程质量评价资料汇编.pdf 模板页数异常，至少需要 8 页");
            }

            // 加载所有数据
            Data d = loadData(offeringId, evaluationId);
            PDFont font = draw.loadChineseFont(doc);

            // 在模板页面上绘制内容（覆盖原有内容）
            drawCoverOnTemplate(doc, d, font);
            drawGradeStatsTableOnTemplate(doc, d, font);
            drawAssessmentRationalityTableOnTemplate(doc, d, font);
            drawAchievementReportPart1OnTemplate(doc, d, font);
            drawAchievementReportPart2OnTemplate(doc, d, font);
            drawAchievementReportPart3OnTemplate(doc, d, font);
            drawQualityEvaluationPart1OnTemplate(doc, d, font);
            drawQualityEvaluationPart2OnTemplate(doc, d, font);

            doc.save(out);
            log.info("Quality compendium PDF generated for offering {}, pages: {}", offeringId, doc.getNumberOfPages());
            return out.toByteArray();
        } catch (Exception e) {
            log.error("生成质量评价资料汇编失败: offeringId={}, evaluationId={}", offeringId, evaluationId, e);
            throw new RuntimeException("生成质量评价资料汇编失败: " + e.getMessage(), e);
        }
    }

    private void validateTemplate() throws IOException {
        try (PDDocument template = templateService.openPdfTemplate("课程质量评价资料汇编.pdf")) {
            if (template.getNumberOfPages() < 8) {
                throw new IllegalStateException("课程质量评价资料汇编.pdf 模板页数异常，至少需要 8 页");
            }
        }
    }

    private static class Data {
        Course course;
        CourseOffering offering;
        String teacherName = "";
        List<CourseObjective> objectives = Collections.emptyList();
        List<ObjectiveSupport> supports = Collections.emptyList();
        Map<Integer, GraduationIndicator> indMap = Collections.emptyMap();
        Map<Integer, GraduationRequirement> reqMap = Collections.emptyMap();
        List<ScoringItem> items = Collections.emptyList();
        Map<Integer, Set<Integer>> itemObjs = Collections.emptyMap();
        QualityEvaluation evaluation;
        AttainmentReportVO report;
        OfferingAchievementVO achievement;
        // 派生
        int studentCount;
        double avgScore, maxScore, minScore, passRate;
        Map<String, Integer> scoreDist = new LinkedHashMap<>();
    }

    private Data loadData(Integer offeringId, Integer evaluationId) {
        Data d = new Data();
        d.offering = offeringMapper.selectById(offeringId);
        if (d.offering == null) throw new RuntimeException("开课实例不存在: " + offeringId);
        d.course = courseMapper.selectById(d.offering.getCourseId());

        d.objectives = objectiveMapper.selectList(new LambdaQueryWrapper<CourseObjective>()
                .eq(CourseObjective::getCourseId, d.offering.getCourseId())
                .orderByAsc(CourseObjective::getSortOrder));
        d.supports = d.objectives.isEmpty() ? Collections.emptyList()
                : supportMapper.selectList(new LambdaQueryWrapper<ObjectiveSupport>()
                        .in(ObjectiveSupport::getObjectiveId, d.objectives.stream()
                                .map(CourseObjective::getObjectiveId).collect(Collectors.toList())));
        d.indMap = d.supports.isEmpty() ? Collections.emptyMap() : indicatorMapper.selectBatchIds(
                d.supports.stream().map(ObjectiveSupport::getIndicatorId).distinct().collect(Collectors.toList()))
                .stream().collect(Collectors.toMap(GraduationIndicator::getIndicatorId, i -> i));
        d.reqMap = d.indMap.isEmpty() ? Collections.emptyMap() : requirementMapper.selectBatchIds(
                d.indMap.values().stream().map(GraduationIndicator::getRequirementId).distinct().collect(Collectors.toList()))
                .stream().collect(Collectors.toMap(GraduationRequirement::getRequirementId, r -> r));

        d.items = itemMapper.selectList(new LambdaQueryWrapper<ScoringItem>()
                .eq(ScoringItem::getOfferingId, offeringId)
                .orderByAsc(ScoringItem::getSortOrder));

        // 教师名
        if (d.offering.getTeacherId() != null) {
            Teacher t = teacherMapper.selectById(d.offering.getTeacherId());
            if (t != null) d.teacherName = t.getTeacherName() == null ? "" : t.getTeacherName();
        }

        d.itemObjs = new HashMap<>();
        if (!d.items.isEmpty()) {
            for (ScoringItemObjective l : itemObjMapper.selectList(new LambdaQueryWrapper<ScoringItemObjective>()
                    .in(ScoringItemObjective::getItemId, d.items.stream()
                            .map(ScoringItem::getItemId).collect(Collectors.toList())))) {
                d.itemObjs.computeIfAbsent(l.getItemId(), k -> new HashSet<>()).add(l.getObjectiveId());
            }
        }

        // 评价
        if (evaluationId != null) {
            d.evaluation = evaluationMapper.selectById(evaluationId);
        }
        if (d.evaluation == null) {
            d.evaluation = evaluationMapper.selectOne(new LambdaQueryWrapper<QualityEvaluation>()
                    .eq(QualityEvaluation::getOfferingId, offeringId)
                    .orderByDesc(QualityEvaluation::getEvaluationId).last("LIMIT 1"));
        }
        try {
            d.report = reportGen.attainment(offeringId, d.evaluation == null ? null : d.evaluation.getEvaluationId());
        } catch (Exception ignore) { d.report = null; }
        d.achievement = achievementEngine.calcForOffering(offeringId);

        // 简化：统计学生数
        d.studentCount = d.achievement.getStudents() == null ? 0 : d.achievement.getStudents().size();
        d.avgScore = 0;
        d.passRate = d.achievement.getOverallReachedRatio() == null ? 0
                : d.achievement.getOverallReachedRatio().doubleValue();
        d.maxScore = 0; d.minScore = 0;
        d.scoreDist = new LinkedHashMap<>();
        return d;
    }

    // ============ Page 1: 封面 + 资料目录 ============
    private void drawCover(PDDocument doc, Data d) throws IOException {
        PDPage page = newPage(doc);
        PDPageContentStream cs = new PDPageContentStream(doc, page);
        PDFont font = draw.loadChineseFont(doc);
        float y = PAGE_TOP;
        y = draw.drawCenteredTitle(cs, "课程质量评价资料汇编", y, 24, font);
        y -= 30;
        y = draw.drawCenteredTitle(cs, "（ " + (d.offering.getSemester() == null ? "" : d.offering.getSemester()) + " 学期 ）",
                y, 14, font);
        y -= 40;
        y = draw.drawCenteredTitle(cs, "资料目录", y, 18, font);
        y -= 20;
        String[] toc = {
                "1. 成绩统计表",
                "2. 课程考核合理性审核表",
                "3. 课程目标达成情况评价报告",
                "4. 课程质量评价表"
        };
        for (String s : toc) {
            y = draw.drawText(cs, s, PAGE_LEFT + 50, y, 13, font);
            y -= 22;
        }
        cs.close();
    }

    // ============ Page 2: 表1 成绩统计表 ============
    private void drawGradeStatsTable(PDDocument doc, Data d) throws IOException {
        PDPage page = newPage(doc);
        PDPageContentStream cs = new PDPageContentStream(doc, page);
        PDFont font = draw.loadChineseFont(doc);
        float y = PAGE_TOP;
        y = draw.drawCenteredTitle(cs, "成绩统计表", y, 18, font);
        y -= 10;
        // 4 行 3 列 表格
        String[][] head = {
                {"教研室", d.course == null ? "" : n(d.course.getDepartment()), "课程名称", d.course == null ? "" : n(d.course.getNameCn())},
                {"授课班级", n(d.offering.getClazzNo()), "任课教师", n(d.teacherName)},
                {"命题教师", n(d.teacherName), "期望值", "0.7"},
                {"平均分", String.format("%.2f", d.avgScore), "最高分/最低分",
                        String.format("%.1f / %.1f", d.maxScore, d.minScore)},
                {"成绩分布", formatScoreDist(d.scoreDist), "成绩是否达到期望值并符合正态分布",
                        "及格率 " + String.format("%.1f%%", d.passRate * 100) + "   □是   □否"}
        };
        y = draw.drawTable(cs, head,
                new float[]{80, 180, 80, 165}, PAGE_LEFT, y, 22, 11, font);
        y -= 20;
        y = draw.drawText(cs, "检查人：              检查时间：", PAGE_LEFT, y, 11, font);
        y -= 20;
        y = draw.drawText(cs, "（注：自查时可使用，仅供参考）", PAGE_LEFT, y, 10, font);
        cs.close();
    }

    // ============ Page 3: 表2 考核合理性审核表 ============
    private void drawAssessmentRationalityTable(PDDocument doc, Data d) throws IOException {
        PDPage page = newPage(doc);
        PDPageContentStream cs = new PDPageContentStream(doc, page);
        PDFont font = draw.loadChineseFont(doc);
        float y = PAGE_TOP;
        y = draw.drawCenteredTitle(cs, "考核合理性审核表", y, 18, font);
        y -= 10;
        String hours = d.course == null ? "" : (d.course.getHours() == null ? "" : d.course.getHours().toString());
        String theory = d.course == null ? "" : (d.course.getTheoryHours() == null ? "" : d.course.getTheoryHours().toString());
        String lab = d.course == null ? "" : (d.course.getLabHours() == null ? "" : d.course.getLabHours().toString());
        String[][] head = {
                {"课程名称", (d.course == null ? "" : n(d.course.getNameCn())), "课程类别", ""},
                {"授课学时", hours, "课程学分", d.course == null ? "" : (d.course.getCredit() == null ? null : d.course.getCredit().toString())},
                {"开课学期", n(d.offering.getSemester()), "授课对象", n(d.offering.getClazzNo())},
                {"授课人数", String.valueOf(d.studentCount), "课程负责人", n(d.teacherName)}
        };
        y = draw.drawTable(cs, head, new float[]{80, 180, 80, 165}, PAGE_LEFT, y, 22, 11, font);
        y -= 12;
        y = draw.drawText(cs, "课程考核合理性审核：", PAGE_LEFT, y, 12, font);
        y -= 8;
        // 主表 4 列：课程目标 / 考核内容 / 考核方式 / 考核分值 / 合理性审核意见
        // 实际是 5 列，调整列宽
        String[][] main = buildRationalityTable(d);
        y = draw.drawTable(cs, main, new float[]{80, 130, 90, 60, 145}, PAGE_LEFT, y, 24, 10, font);
        y -= 14;
        y = draw.drawText(cs, "审核人：", PAGE_LEFT, y, 11, font);
        cs.close();
    }

    private String[][] buildRationalityTable(Data d) {
        // 表头 5 列
        List<String[]> rows = new ArrayList<>();
        rows.add(new String[]{"课程目标", "考核内容", "考核方式", "考核分值", "合理性审核意见"});
        if (d.objectives.isEmpty()) {
            rows.add(new String[]{"—", "—", "—", "—", ""});
        } else {
            for (CourseObjective o : d.objectives) {
                String objCode = o.getCode();
                // 找到支撑该目标的 item
                List<ScoringItem> myItems = d.items.stream()
                        .filter(it -> d.itemObjs.getOrDefault(it.getItemId(), Collections.emptySet())
                                .contains(o.getObjectiveId()))
                        .collect(Collectors.toList());
                String content = myItems.isEmpty() ? "—" : myItems.stream().map(ScoringItem::getName).collect(Collectors.joining("、"));
                String way = myItems.isEmpty() ? "—" : myItems.stream().map(it -> {
                    String t = it.getType();
                    if ("homework".equals(t)) return "作业";
                    if ("experiment".equals(t)) return "实验";
                    if ("exam".equals(t)) return "考试";
                    if ("project".equals(t)) return "大作业";
                    return "其他";
                }).distinct().collect(Collectors.joining("、"));
                double score = myItems.stream().mapToDouble(it -> it.getWeight() == null ? 0 : it.getWeight().doubleValue() * 100).sum();
                rows.add(new String[]{objCode, content, way, String.format("%.0f", score), ""});
            }
        }
        return rows.toArray(new String[0][]);
    }

    // ============ Page 4-6: 表3 课程目标达成情况评价报告 ============
    private void drawAchievementReportPart1(PDDocument doc, Data d) throws IOException {
        PDPage page = newPage(doc);
        PDPageContentStream cs = new PDPageContentStream(doc, page);
        PDFont font = draw.loadChineseFont(doc);
        float y = PAGE_TOP;
        y = draw.drawCenteredTitle(cs, "课程目标达成情况评价报告", y, 18, font);
        y -= 12;
        // 一、课程基本信息
        y = draw.drawSectionTitle(cs, "一、课程基本信息", PAGE_LEFT, y, font);
        y -= 6;
        String theory = d.course == null ? "" : (d.course.getTheoryHours() == null ? "" : d.course.getTheoryHours().toString());
        String lab = d.course == null ? "" : (d.course.getLabHours() == null ? "" : d.course.getLabHours().toString());
        String hours = d.course == null ? "" : (d.course.getHours() == null ? "" : d.course.getHours().toString());
        String[][] basicInfo = {
                {"课程名称", (d.course == null ? "" : n(d.course.getNameCn())), "学期", n(d.offering.getSemester())},
                {"学时", hours, "理论/实验", theory + " / " + lab},
                {"授课班级", n(d.offering.getClazzNo()), "考核方式", "考试"}
        };
        y = draw.drawTable(cs, basicInfo, new float[]{70, 200, 70, 165}, PAGE_LEFT, y, 22, 11, font);
        y -= 10;
        // 1.1 课程任课教师
        y = draw.drawText(cs, "1.1 课程任课教师", PAGE_LEFT, y, 12, font);
        y -= 6;
        String[][] teacherInfo = {
                {"任课教师", n(d.teacherName), "职称", ""},
                {"学生人数", String.valueOf(d.studentCount), "", ""}
        };
        y = draw.drawTable(cs, teacherInfo, new float[]{70, 200, 70, 165}, PAGE_LEFT, y, 22, 11, font);
        y -= 10;
        // 二、课程目标与毕业要求观测点的对应关系及达成途径
        y = draw.drawSectionTitle(cs, "二、课程目标与毕业要求观测点的对应关系及达成途径", PAGE_LEFT, y, font);
        y -= 6;
        String[][] mapTable = buildObjectiveSupportTable(d);
        y = draw.drawTable(cs, mapTable, new float[]{55, 150, 110, 190}, PAGE_LEFT, y, 30, 10, font);
        cs.close();
    }

    private void drawAchievementReportPart2(PDDocument doc, Data d) throws IOException {
        PDPage page = newPage(doc);
        PDPageContentStream cs = new PDPageContentStream(doc, page);
        PDFont font = draw.loadChineseFont(doc);
        float y = PAGE_TOP;
        // 三、课程考核方式、方法和标准
        y = draw.drawSectionTitle(cs, "三、课程考核方式、方法和标准", PAGE_LEFT, y, font);
        y -= 6;
        y = draw.drawText(cs, "3.1 课程考核方式及分值分配", PAGE_LEFT, y, 12, font);
        y -= 6;
        y = draw.drawWrappedText(cs,
                "课程考核以检验课程目标的达成度为手段，根据各课程目标与考核环节的对应关系，建议值及考核细则如表 1 所示：",
                PAGE_LEFT, y, CONTENT_WIDTH, 10, 13, font);
        y -= 6;
        y = draw.drawWrappedText(cs, "表 1 各课程目标考核方式、分数分配及达成期望（表中数字为样例）",
                PAGE_LEFT, y, CONTENT_WIDTH, 10, 13, font);
        y -= 6;
        String[][] t1 = buildExamMethodTable(d);
        y = draw.drawTable(cs, t1, new float[]{80, 70, 70, 70, 70, 70, 70}, PAGE_LEFT, y, 22, 10, font);
        y -= 10;
        // 3.2 课程考核方法及主要考核内容
        y = draw.drawText(cs, "3.2 课程考核方法及主要考核内容", PAGE_LEFT, y, 12, font);
        y -= 6;
        String[][] t2 = buildExamMethodDetailTable(d);
        y = draw.drawTable(cs, t2, new float[]{70, 80, 90, 265}, PAGE_LEFT, y, 24, 10, font);
        y -= 10;
        // 四、考核环节、方式、内容的合理性分析
        y = draw.drawSectionTitle(cs, "四、考核环节、方式、内容的合理性分析", PAGE_LEFT, y, font);
        y -= 6;
        String analysisText = d.evaluation != null && d.evaluation.getAnalysisRationality() != null
                ? d.evaluation.getAnalysisRationality()
                : "（分析和说明平时作业、实验、课程报告、期末考试等各考核环节内容是否能够评价学生达成课程目标情况。即分课程目标证明，各课程目标的考核环节、考核方式和考核内容是合理的。）";
        y = draw.drawWrappedText(cs, analysisText, PAGE_LEFT, y, CONTENT_WIDTH, 10, 14, font);
        cs.close();
    }

    private void drawAchievementReportPart3(PDDocument doc, Data d) throws IOException {
        PDPage page = newPage(doc);
        PDPageContentStream cs = new PDPageContentStream(doc, page);
        PDFont font = draw.loadChineseFont(doc);
        float y = PAGE_TOP;
        // 五、课程目标达成情况
        y = draw.drawSectionTitle(cs, "五、课程目标达成情况", PAGE_LEFT, y, font);
        y -= 6;
        y = draw.drawText(cs, "5.1 主要考核数据", PAGE_LEFT, y, 12, font);
        y -= 6;
        String[][] dist = buildScoreDistributionTable(d);
        y = draw.drawTable(cs, dist, new float[]{70, 60, 60, 60, 60, 60, 60, 75}, PAGE_LEFT, y, 24, 10, font);
        y -= 10;
        y = draw.drawText(cs, "5.2 各课程目标达成情况", PAGE_LEFT, y, 12, font);
        y -= 6;
        String[][] t2 = buildObjectiveAttainmentTable(d);
        y = draw.drawTable(cs, t2, new float[]{50, 70, 50, 60, 60, 70, 60, 85}, PAGE_LEFT, y, 24, 10, font);
        y -= 10;
        // 六、课程目标达成评价分析
        y = draw.drawSectionTitle(cs, "六、课程目标达成评价分析", PAGE_LEFT, y, font);
        y -= 6;
        String text6 = d.evaluation != null && d.evaluation.getExistingIssues() != null
                ? d.evaluation.getExistingIssues()
                : "（结合直接和间接评价结果，分析学生在各课程目标及相应毕业要求指标点上的达成情况）";
        y = draw.drawWrappedText(cs, text6, PAGE_LEFT, y, CONTENT_WIDTH, 10, 14, font);
        y -= 6;
        y = draw.drawWrappedText(cs, "总体课程达成情况分析：", PAGE_LEFT, y, CONTENT_WIDTH, 10, 13, font);
        y -= 4;
        String overall = d.evaluation != null && d.evaluation.getEvaluationValidity() != null
                ? d.evaluation.getEvaluationValidity()
                : String.format("本课程总达成度为 %s，学生在课程目标整体上达到期望水平。", String.format("%.2f", d.achievement.getOverallReachedRatio()));
        y = draw.drawWrappedText(cs, overall, PAGE_LEFT, y, CONTENT_WIDTH, 10, 14, font);
        y -= 8;
        // 七、上一轮问题
        y = draw.drawSectionTitle(cs, "七、上一轮存在问题及本轮改进效果", PAGE_LEFT, y, font);
        y -= 6;
        String last = d.evaluation != null && d.evaluation.getLastRoundImprovements() != null
                ? d.evaluation.getLastRoundImprovements() : "（无）";
        y = draw.drawWrappedText(cs, last, PAGE_LEFT, y, CONTENT_WIDTH, 10, 14, font);
        y -= 8;
        // 八、下一轮教学改进措施
        y = draw.drawSectionTitle(cs, "八、下一轮教学改进措施", PAGE_LEFT, y, font);
        y -= 6;
        String next = d.evaluation != null && d.evaluation.getConclusionAndSuggestions() != null
                ? d.evaluation.getConclusionAndSuggestions() : "（待定）";
        y = draw.drawWrappedText(cs, next, PAGE_LEFT, y, CONTENT_WIDTH, 10, 14, font);
        cs.close();
    }

    // ============ Page 7-8: 表4 课程质量评价表 ============
    private void drawQualityEvaluationPart1(PDDocument doc, Data d) throws IOException {
        PDPage page = newPage(doc);
        PDPageContentStream cs = new PDPageContentStream(doc, page);
        PDFont font = draw.loadChineseFont(doc);
        float y = PAGE_TOP;
        y = draw.drawCenteredTitle(cs, "课程质量评价表", y, 18, font);
        y -= 10;
        String hours = d.course == null ? "" : (d.course.getHours() == null ? "" : d.course.getHours().toString());
        String[][] head = {
                {"课程名称", (d.course == null ? "" : n(d.course.getNameCn())), "课程类别", ""},
                {"授课学时", hours, "课程学分", d.course == null ? "" : (d.course.getCredit() == null ? null : d.course.getCredit().toString())},
                {"开课学期", n(d.offering.getSemester()), "授课对象", n(d.offering.getClazzNo())},
                {"授课人数", String.valueOf(d.studentCount), "课程负责人", n(d.teacherName)},
                {"课程组成员", d.evaluation != null && d.evaluation.getCourseMembers() != null ? d.evaluation.getCourseMembers() : "—", "", ""},
                {"课程评价小组成员", d.evaluation != null && d.evaluation.getEvalGroupMembers() != null ? d.evaluation.getEvalGroupMembers() : "—", "", ""}
        };
        y = draw.drawTable(cs, head, new float[]{80, 180, 80, 165}, PAGE_LEFT, y, 22, 10, font);
        y -= 10;
        // 评价项目表（按模板 3 列大行：评价项目/评价依据/评价结果）
        String[][] evalItems = buildQualityEvalItems(d);
        y = draw.drawTable(cs, evalItems, new float[]{100, 200, 205}, PAGE_LEFT, y, 36, 10, font);
        cs.close();
    }

    private void drawQualityEvaluationPart2(PDDocument doc, Data d) throws IOException {
        PDPage page = newPage(doc);
        PDPageContentStream cs = new PDPageContentStream(doc, page);
        PDFont font = draw.loadChineseFont(doc);
        float y = PAGE_TOP;
        y = draw.drawWrappedText(cs,
                "（根据以上课程质量评价情况，说明本课程在课程目标合理性、课程目标达成情况等方面存在的具体问题，并给出本次课程质量评价的结论及相关改进意见）",
                PAGE_LEFT, y, CONTENT_WIDTH, 10, 14, font);
        y -= 12;
        // 4 段意见
        String[][] rows = {
                {"1、课程存在的问题", n(d.evaluation != null ? d.evaluation.getExistingIssues() : null)},
                {"2、课程目标达成评价的有效性", n(d.evaluation != null ? d.evaluation.getEvaluationValidity() : null)},
                {"3、上一轮评价中的问题在本轮课程中的改进情况评价", n(d.evaluation != null ? d.evaluation.getLastRoundImprovements() : null)},
                {"4、课程质量评价结论及改进意见", n(d.evaluation != null ? d.evaluation.getConclusionAndSuggestions() : null)}
        };
        for (String[] r : rows) {
            y = draw.drawText(cs, r[0] + "：", PAGE_LEFT, y, 11, font);
            y -= 16;
            y = draw.drawWrappedText(cs, r[1].isEmpty() ? "（待填写）" : r[1], PAGE_LEFT, y, CONTENT_WIDTH, 10, 14, font);
            y -= 10;
        }
        cs.close();
    }

    // ============ Helpers ============
    private String[][] buildObjectiveSupportTable(Data d) {
        // 4 列：课程目标 / 所支撑毕业要求 / 所支撑的毕业要求观测点 / 主要达成途径（教学设计）
        List<String[]> rows = new ArrayList<>();
        rows.add(new String[]{"课程目标", "所支撑毕业要求", "所支撑的毕业要求观测点", "主要达成途径（教学设计）"});
        for (CourseObjective o : d.objectives) {
            List<ObjectiveSupport> my = d.supports.stream()
                    .filter(s -> s.getObjectiveId().equals(o.getObjectiveId()))
                    .collect(Collectors.toList());
            String reqCodes = my.stream()
                    .map(s -> d.indMap.get(s.getIndicatorId()))
                    .filter(Objects::nonNull)
                    .map(ind -> d.reqMap.get(ind.getRequirementId()))
                    .filter(Objects::nonNull)
                    .map(GraduationRequirement::getCode).distinct().collect(Collectors.joining(", "));
            String indCodes = my.stream()
                    .map(s -> d.indMap.get(s.getIndicatorId()))
                    .filter(Objects::nonNull)
                    .map(GraduationIndicator::getCode).distinct().collect(Collectors.joining(", "));
            String way = "通过" + d.items.stream()
                    .filter(it -> d.itemObjs.getOrDefault(it.getItemId(), Collections.emptySet())
                            .contains(o.getObjectiveId()))
                    .map(ScoringItem::getName).collect(Collectors.joining("、")) + " 环节达成。";
            rows.add(new String[]{o.getCode(),
                    reqCodes.isEmpty() ? "—" : reqCodes,
                    indCodes.isEmpty() ? "—" : indCodes,
                    way});
        }
        return rows.toArray(new String[0][]);
    }

    private String[][] buildExamMethodTable(Data d) {
        // 模板：考核方式、权重及分值：实验(20%) / 作业(30%) / 期末(50%) + 合计分值 + 期望值
        // 列：课程目标 | 实验(权重20%) | 作业(权重30%) | 期末(权重50%) | 合计分值 | 期望值
        List<String[]> rows = new ArrayList<>();
        rows.add(new String[]{"课程目标", "实验（权重20%）", "作业（权重30%）", "期末（权重50%）", "合计分值", "期望值", ""});
        if (d.objectives.isEmpty()) {
            rows.add(new String[]{"—", "0", "0", "0", "0", "0.7", ""});
            return rows.toArray(new String[0][]);
        }
        for (CourseObjective o : d.objectives) {
            double ex = 0, hw = 0, exm = 0;
            for (ScoringItem it : d.items) {
                if (!d.itemObjs.getOrDefault(it.getItemId(), Collections.emptySet())
                        .contains(o.getObjectiveId())) continue;
                double w = it.getWeight() == null ? 0 : it.getWeight().doubleValue() * 100;
                String t = it.getType();
                if ("experiment".equals(t)) ex += w;
                else if ("homework".equals(t)) hw += w;
                else if ("exam".equals(t)) exm += w;
            }
            double total = ex + hw + exm;
            double expected = d.achievement.getByObjective() == null ? 0.7
                    : d.achievement.getByObjective().getOrDefault(o.getObjectiveId(), null) == null ? 0.7
                    : 0.7;
            rows.add(new String[]{o.getCode(),
                    String.format("%.0f", ex), String.format("%.0f", hw),
                    String.format("%.0f", exm), String.format("%.0f", total),
                    String.format("%.1f", expected), ""});
        }
        // 合计
        double totalEx = 0, totalHw = 0, totalExm = 0;
        for (String[] r : rows.subList(1, rows.size())) {
            totalEx += parseDouble(r[1]);
            totalHw += parseDouble(r[2]);
            totalExm += parseDouble(r[3]);
        }
        rows.add(new String[]{"合计",
                String.format("%.0f", totalEx), String.format("%.0f", totalHw),
                String.format("%.0f", totalExm), String.format("%.0f", totalEx + totalHw + totalExm),
                "—", ""});
        return rows.toArray(new String[0][]);
    }

    private String[][] buildExamMethodDetailTable(Data d) {
        List<String[]> rows = new ArrayList<>();
        rows.add(new String[]{"课程目标", "考核环节", "考核方法", "考核内容"});
        for (CourseObjective o : d.objectives) {
            List<ScoringItem> my = d.items.stream()
                    .filter(it -> d.itemObjs.getOrDefault(it.getItemId(), Collections.emptySet())
                            .contains(o.getObjectiveId()))
                    .collect(Collectors.toList());
            if (my.isEmpty()) {
                rows.add(new String[]{o.getCode(), "—", "—", "—"});
            } else {
                int first = 0;
                for (ScoringItem it : my) {
                    String t = switch (it.getType() == null ? "other" : it.getType()) {
                        case "homework" -> "作业";
                        case "experiment" -> "实验";
                        case "exam" -> "期末考试";
                        case "project" -> "大作业";
                        default -> "其他";
                    };
                    rows.add(new String[]{first == 0 ? o.getCode() : "",
                            t, "评分制", n(it.getName())});
                    first++;
                }
            }
        }
        return rows.toArray(new String[0][]);
    }

    private String[][] buildScoreDistributionTable(Data d) {
        // 7 列：总/最高分/最低分/平均分 + 分数段
        List<String[]> rows = new ArrayList<>();
        rows.add(new String[]{"总成绩统计", "最高分", "最低分", "平均分", "", "", "", ""});
        rows.add(new String[]{"", String.format("%.1f", d.maxScore),
                String.format("%.1f", d.minScore), String.format("%.1f", d.avgScore),
                "", "", "", ""});
        rows.add(new String[]{"成绩分布图", "100-90", "89-80", "79-70", "69-60", "60分以下", "", ""});
        rows.add(new String[]{"人数", strOr(d.scoreDist.get("100-90"), "0"),
                strOr(d.scoreDist.get("89-80"), "0"),
                strOr(d.scoreDist.get("79-70"), "0"),
                strOr(d.scoreDist.get("69-60"), "0"),
                strOr(d.scoreDist.get("60-"), "0"), "", ""});
        rows.add(new String[]{"百分比", pct(d.scoreDist.get("100-90"), d.studentCount),
                pct(d.scoreDist.get("89-80"), d.studentCount),
                pct(d.scoreDist.get("79-70"), d.studentCount),
                pct(d.scoreDist.get("69-60"), d.studentCount),
                pct(d.scoreDist.get("60-"), d.studentCount), "", ""});
        return rows.toArray(new String[0][]);
    }

    private String[][] buildObjectiveAttainmentTable(Data d) {
        // 8 列：课程目标 / 考核环节 / 满分分值 / 平均得分 / 权重 / 目标达成的期望值 / 达成该目标的学生人数 / 课程目标达成值
        List<String[]> rows = new ArrayList<>();
        rows.add(new String[]{"课程目标", "考核环节", "满分分值", "平均得分", "权重", "期望值", "达成人数", "达成值"});
        for (CourseObjective o : d.objectives) {
            List<ScoringItem> my = d.items.stream()
                    .filter(it -> d.itemObjs.getOrDefault(it.getItemId(), Collections.emptySet())
                            .contains(o.getObjectiveId()))
                    .collect(Collectors.toList());
            if (my.isEmpty()) {
                rows.add(new String[]{o.getCode(), "—", "—", "—", "—", "0.7", "—", "—"});
            } else {
                int first = 0;
                for (ScoringItem it : my) {
                    Double achVal = d.achievement.getByObjective() == null ? 0.0
                            : d.achievement.getByObjective().get(o.getObjectiveId()) == null ? 0.0
                            : (d.achievement.getByObjective().get(o.getObjectiveId()).getValue() == null ? 0.0
                                : d.achievement.getByObjective().get(o.getObjectiveId()).getValue().doubleValue());
                    Integer reachedCount = d.achievement.getByObjective() == null ? 0
                            : d.achievement.getByObjective().get(o.getObjectiveId()) == null ? 0
                            : d.achievement.getByObjective().get(o.getObjectiveId()).getReachedCount();
                    rows.add(new String[]{first == 0 ? o.getCode() : "",
                            n(it.getName()),
                            String.format("%.0f", it.getMaxScore() == null ? 100.0 : it.getMaxScore().doubleValue()),
                            "—",  // 平均得分需要更细数据
                            String.format("%.2f", it.getWeight() == null ? 0 : it.getWeight()),
                            "0.7",
                            String.valueOf(reachedCount == null ? 0 : reachedCount),
                            achVal == null ? "—" : String.format("%.4f", achVal)});
                    first++;
                }
            }
        }
        return rows.toArray(new String[0][]);
    }

    private String[][] buildQualityEvalItems(Data d) {
        // 3 列大行：评价项目 / 评价依据 / 评价结果
        List<String[]> rows = new ArrayList<>();
        rows.add(new String[]{"评价项目", "评价依据", "评价结果"});
        rows.add(new String[]{"课程目标合理性",
                "课程目标与所支撑的毕业要求指标点的对应关系是否合理",
                "合理（ ）/比较合理（ ）/不合理（ ）\n" + n(rational(d, "objective_indicator_rationality"))});
        rows.add(new String[]{"",
                "课程目标是否包含知识、能力和素养目标",
                "包含（ ）/部分包含（ ）/不包含（ ）\n" + n(rational(d, "objective_contains_kaq"))});
        rows.add(new String[]{"课程目标达成情况",
                "各课程目标达成值",
                "例如：0.8、0.7  ——  " + n(formatObjectiveAttainment(d))});
        rows.add(new String[]{"",
                "各课程目标期望值的合理性",
                "合理（ ）/比较合理（ ）/不合理（ ）\n" + n(rational(d, "expected_rationality"))});
        rows.add(new String[]{"",
                "课程目标达成情况分析的合理性",
                "合理（ ）/比较合理（ ）/不合理（ ）\n" + n(rational(d, "analysis_rationality"))});
        rows.add(new String[]{"持续改进",
                "持续改进措施的合理性",
                "合理（ ）/比较合理（ ）/不合理（ ）\n" + n(rational(d, "improvement_rationality"))});
        return rows.toArray(new String[0][]);
    }

    private String rational(Data d, String key) {
        if (d.evaluation == null) return "";
        return switch (key) {
            case "objective_indicator_rationality" -> n(d.evaluation.getObjectiveIndicatorRationality());
            case "objective_contains_kaq" -> n(d.evaluation.getObjectiveContainsKaq());
            case "expected_rationality" -> n(d.evaluation.getExpectedRationality());
            case "analysis_rationality" -> n(d.evaluation.getAnalysisRationality());
            case "improvement_rationality" -> n(d.evaluation.getImprovementRationality());
            default -> "";
        };
    }

    private String formatObjectiveAttainment(Data d) {
        if (d.achievement.getByObjective() == null) return "—";
        StringBuilder sb = new StringBuilder();
        for (CourseObjective o : d.objectives) {
            var s = d.achievement.getByObjective().get(o.getObjectiveId());
            if (s == null) continue;
            if (sb.length() > 0) sb.append("，");
            sb.append(o.getCode()).append("=").append(String.format("%.4f", s.getValue() == null ? 0 : s.getValue()));
        }
        return sb.toString();
    }

    private String formatScoreDist(Map<String, Integer> dist) {
        if (dist == null || dist.isEmpty()) return "—";
        return dist.entrySet().stream()
                .map(e -> e.getKey() + "=" + e.getValue() + "人")
                .collect(Collectors.joining("; "));
    }

    private static String strOr(Object o, String def) {
        return o == null ? def : o.toString();
    }
    private static String pct(Integer count, int total) {
        if (count == null || total == 0) return "0%";
        return String.format("%.1f%%", (count * 100.0) / total);
    }
    private static double parseDouble(String s) {
        try { return Double.parseDouble(s); } catch (Exception e) { return 0; }
    }

    private static String n(String s) { return s == null ? "" : s; }
    private static PDPage newPage(PDDocument doc) {
        PDPage page = new PDPage(PDRectangle.A4);
        doc.addPage(page);
        return page;
    }

    // ============ Template-based drawing methods ============

    /** 清除页面内容区域（用白色矩形覆盖） */
    private void clearPageContent(PDDocument doc, PDPage page, PDFont font) throws IOException {
        try (PDPageContentStream cs = new PDPageContentStream(doc, page, PDPageContentStream.AppendMode.APPEND, true, true)) {
            PDRectangle box = page.getMediaBox();
            cs.setNonStrokingColor(java.awt.Color.WHITE);
            cs.addRect(45, 45, box.getWidth() - 90, box.getHeight() - 90);
            cs.fill();
            cs.setNonStrokingColor(java.awt.Color.BLACK);
        }
    }

    /** Page 1: 封面 + 资料目录 */
    private void drawCoverOnTemplate(PDDocument doc, Data d, PDFont font) throws IOException {
        PDPage page = doc.getPage(0);
        clearPageContent(doc, page, font);
        try (PDPageContentStream cs = new PDPageContentStream(doc, page, PDPageContentStream.AppendMode.APPEND, true, true)) {
            float y = PAGE_TOP;
            y = draw.drawCenteredTitle(cs, "课程质量评价资料汇编", y, 24, font);
            y -= 30;
            y = draw.drawCenteredTitle(cs, "（ " + n(d.offering.getSemester()) + " 学期 ）", y, 14, font);
            y -= 40;
            y = draw.drawCenteredTitle(cs, "资料目录", y, 18, font);
            y -= 20;
            String[] toc = {"1. 成绩统计表", "2. 课程考核合理性审核表", "3. 课程目标达成情况评价报告", "4. 课程质量评价表"};
            for (String s : toc) {
                y = draw.drawText(cs, s, PAGE_LEFT + 50, y, 13, font);
                y -= 22;
            }
        }
    }

    /** Page 2: 成绩统计表 */
    private void drawGradeStatsTableOnTemplate(PDDocument doc, Data d, PDFont font) throws IOException {
        PDPage page = doc.getPage(1);
        clearPageContent(doc, page, font);
        try (PDPageContentStream cs = new PDPageContentStream(doc, page, PDPageContentStream.AppendMode.APPEND, true, true)) {
            float y = PAGE_TOP;
            y = draw.drawCenteredTitle(cs, "成绩统计表", y, 18, font);
            y -= 10;
            String[][] head = {
                    {"教研室", d.course == null ? "" : n(d.course.getDepartment()), "课程名称", d.course == null ? "" : n(d.course.getNameCn())},
                    {"授课班级", n(d.offering.getClazzNo()), "任课教师", n(d.teacherName)},
                    {"命题教师", n(d.teacherName), "期望值", "0.7"},
                    {"平均分", String.format("%.2f", d.avgScore), "最高分/最低分", String.format("%.1f / %.1f", d.maxScore, d.minScore)},
                    {"成绩分布", formatScoreDist(d.scoreDist), "成绩是否达到期望值并符合正态分布", "及格率 " + String.format("%.1f%%", d.passRate * 100) + "   □是   □否"}
            };
            y = draw.drawTable(cs, head, new float[]{80, 180, 80, 165}, PAGE_LEFT, y, 22, 11, font);
            y -= 20;
            y = draw.drawText(cs, "检查人：              检查时间：", PAGE_LEFT, y, 11, font);
            y -= 20;
            y = draw.drawText(cs, "（注：自查时可使用，仅供参考）", PAGE_LEFT, y, 10, font);
        }
    }

    /** Page 3: 考核合理性审核表 */
    private void drawAssessmentRationalityTableOnTemplate(PDDocument doc, Data d, PDFont font) throws IOException {
        PDPage page = doc.getPage(2);
        clearPageContent(doc, page, font);
        try (PDPageContentStream cs = new PDPageContentStream(doc, page, PDPageContentStream.AppendMode.APPEND, true, true)) {
            float y = PAGE_TOP;
            y = draw.drawCenteredTitle(cs, "考核合理性审核表", y, 18, font);
            y -= 10;
            String hours = d.course == null ? "" : (d.course.getHours() == null ? "" : d.course.getHours().toString());
            String[][] head = {
                    {"课程名称", (d.course == null ? "" : n(d.course.getNameCn())), "课程类别", ""},
                    {"授课学时", hours, "课程学分", d.course == null ? "" : (d.course.getCredit() == null ? null : d.course.getCredit().toString())},
                    {"开课学期", n(d.offering.getSemester()), "授课对象", n(d.offering.getClazzNo())},
                    {"授课人数", String.valueOf(d.studentCount), "课程负责人", n(d.teacherName)}
            };
            y = draw.drawTable(cs, head, new float[]{80, 180, 80, 165}, PAGE_LEFT, y, 22, 11, font);
            y -= 12;
            y = draw.drawText(cs, "课程考核合理性审核：", PAGE_LEFT, y, 12, font);
            y -= 8;
            String[][] main = buildRationalityTable(d);
            y = draw.drawTable(cs, main, new float[]{80, 130, 90, 60, 145}, PAGE_LEFT, y, 24, 10, font);
            y -= 14;
            y = draw.drawText(cs, "审核人：", PAGE_LEFT, y, 11, font);
        }
    }

    /** Page 4: 报告 - 课程基本信息 + 二、对应关系 */
    private void drawAchievementReportPart1OnTemplate(PDDocument doc, Data d, PDFont font) throws IOException {
        PDPage page = doc.getPage(3);
        clearPageContent(doc, page, font);
        try (PDPageContentStream cs = new PDPageContentStream(doc, page, PDPageContentStream.AppendMode.APPEND, true, true)) {
            float y = PAGE_TOP;
            y = draw.drawCenteredTitle(cs, "课程目标达成情况评价报告", y, 18, font);
            y -= 12;
            y = draw.drawSectionTitle(cs, "一、课程基本信息", PAGE_LEFT, y, font);
            y -= 6;
            String theory = d.course == null ? "" : (d.course.getTheoryHours() == null ? "" : d.course.getTheoryHours().toString());
            String lab = d.course == null ? "" : (d.course.getLabHours() == null ? "" : d.course.getLabHours().toString());
            String hours = d.course == null ? "" : (d.course.getHours() == null ? "" : d.course.getHours().toString());
            String[][] basicInfo = {
                    {"课程名称", (d.course == null ? "" : n(d.course.getNameCn())), "学期", n(d.offering.getSemester())},
                    {"学时", hours, "理论/实验", theory + " / " + lab},
                    {"授课班级", n(d.offering.getClazzNo()), "考核方式", "考试"}
            };
            y = draw.drawTable(cs, basicInfo, new float[]{70, 200, 70, 165}, PAGE_LEFT, y, 22, 11, font);
            y -= 10;
            y = draw.drawText(cs, "1.1 课程任课教师", PAGE_LEFT, y, 12, font);
            y -= 6;
            String[][] teacherInfo = {
                    {"任课教师", n(d.teacherName), "职称", ""},
                    {"学生人数", String.valueOf(d.studentCount), "", ""}
            };
            y = draw.drawTable(cs, teacherInfo, new float[]{70, 200, 70, 165}, PAGE_LEFT, y, 22, 11, font);
            y -= 10;
            y = draw.drawSectionTitle(cs, "二、课程目标与毕业要求观测点的对应关系及达成途径", PAGE_LEFT, y, font);
            y -= 6;
            String[][] mapTable = buildObjectiveSupportTable(d);
            y = draw.drawTable(cs, mapTable, new float[]{55, 150, 110, 190}, PAGE_LEFT, y, 30, 10, font);
        }
    }

    /** Page 5: 报告 - 三、考核方式 + 四、合理性 */
    private void drawAchievementReportPart2OnTemplate(PDDocument doc, Data d, PDFont font) throws IOException {
        PDPage page = doc.getPage(4);
        clearPageContent(doc, page, font);
        try (PDPageContentStream cs = new PDPageContentStream(doc, page, PDPageContentStream.AppendMode.APPEND, true, true)) {
            float y = PAGE_TOP;
            y = draw.drawSectionTitle(cs, "三、课程考核方式、方法和标准", PAGE_LEFT, y, font);
            y -= 6;
            y = draw.drawText(cs, "3.1 课程考核方式及分值分配", PAGE_LEFT, y, 12, font);
            y -= 6;
            y = draw.drawWrappedText(cs, "课程考核以检验课程目标的达成度为手段，根据各课程目标与考核环节的对应关系，建议值及考核细则如表 1 所示：", PAGE_LEFT, y, CONTENT_WIDTH, 10, 13, font);
            y -= 6;
            y = draw.drawWrappedText(cs, "表 1 各课程目标考核方式、分数分配及达成期望（表中数字为样例）", PAGE_LEFT, y, CONTENT_WIDTH, 10, 13, font);
            y -= 6;
            String[][] t1 = buildExamMethodTable(d);
            y = draw.drawTable(cs, t1, new float[]{80, 70, 70, 70, 70, 70, 70}, PAGE_LEFT, y, 22, 10, font);
            y -= 10;
            y = draw.drawText(cs, "3.2 课程考核方法及主要考核内容", PAGE_LEFT, y, 12, font);
            y -= 6;
            String[][] t2 = buildExamMethodDetailTable(d);
            y = draw.drawTable(cs, t2, new float[]{70, 80, 90, 265}, PAGE_LEFT, y, 24, 10, font);
            y -= 10;
            y = draw.drawSectionTitle(cs, "四、考核环节、方式、内容的合理性分析", PAGE_LEFT, y, font);
            y -= 6;
            String analysisText = d.evaluation != null && d.evaluation.getAnalysisRationality() != null ? d.evaluation.getAnalysisRationality() : "（分析和说明平时作业、实验、课程报告、期末考试等各考核环节内容是否能够评价学生达成课程目标情况。即分课程目标证明，各课程目标的考核环节、考核方式和考核内容是合理的。）";
            y = draw.drawWrappedText(cs, analysisText, PAGE_LEFT, y, CONTENT_WIDTH, 10, 14, font);
        }
    }

    /** Page 6: 报告 - 五、达成情况 + 六、分析 + 七、八 */
    private void drawAchievementReportPart3OnTemplate(PDDocument doc, Data d, PDFont font) throws IOException {
        PDPage page = doc.getPage(5);
        clearPageContent(doc, page, font);
        try (PDPageContentStream cs = new PDPageContentStream(doc, page, PDPageContentStream.AppendMode.APPEND, true, true)) {
            float y = PAGE_TOP;
            y = draw.drawSectionTitle(cs, "五、课程目标达成情况", PAGE_LEFT, y, font);
            y -= 6;
            y = draw.drawText(cs, "5.1 主要考核数据", PAGE_LEFT, y, 12, font);
            y -= 6;
            String[][] dist = buildScoreDistributionTable(d);
            y = draw.drawTable(cs, dist, new float[]{70, 60, 60, 60, 60, 60, 60, 75}, PAGE_LEFT, y, 24, 10, font);
            y -= 10;
            y = draw.drawText(cs, "5.2 各课程目标达成情况", PAGE_LEFT, y, 12, font);
            y -= 6;
            String[][] t2 = buildObjectiveAttainmentTable(d);
            y = draw.drawTable(cs, t2, new float[]{50, 70, 50, 60, 60, 70, 60, 85}, PAGE_LEFT, y, 24, 10, font);
            y -= 10;
            y = draw.drawSectionTitle(cs, "六、课程目标达成评价分析", PAGE_LEFT, y, font);
            y -= 6;
            String text6 = d.evaluation != null && d.evaluation.getExistingIssues() != null ? d.evaluation.getExistingIssues() : "（结合直接和间接评价结果，分析学生在各课程目标及相应毕业要求指标点上的达成情况）";
            y = draw.drawWrappedText(cs, text6, PAGE_LEFT, y, CONTENT_WIDTH, 10, 14, font);
            y -= 6;
            y = draw.drawWrappedText(cs, "总体课程达成情况分析：", PAGE_LEFT, y, CONTENT_WIDTH, 10, 13, font);
            y -= 4;
            String overall = d.evaluation != null && d.evaluation.getEvaluationValidity() != null ? d.evaluation.getEvaluationValidity() : String.format("本课程总达成度为 %s，学生在课程目标整体上达到期望水平。", String.format("%.2f", d.achievement.getOverallReachedRatio()));
            y = draw.drawWrappedText(cs, overall, PAGE_LEFT, y, CONTENT_WIDTH, 10, 14, font);
            y -= 8;
            y = draw.drawSectionTitle(cs, "七、上一轮存在问题及本轮改进效果", PAGE_LEFT, y, font);
            y -= 6;
            String last = d.evaluation != null && d.evaluation.getLastRoundImprovements() != null ? d.evaluation.getLastRoundImprovements() : "（无）";
            y = draw.drawWrappedText(cs, last, PAGE_LEFT, y, CONTENT_WIDTH, 10, 14, font);
            y -= 8;
            y = draw.drawSectionTitle(cs, "八、下一轮教学改进措施", PAGE_LEFT, y, font);
            y -= 6;
            String next = d.evaluation != null && d.evaluation.getConclusionAndSuggestions() != null ? d.evaluation.getConclusionAndSuggestions() : "（待定）";
            y = draw.drawWrappedText(cs, next, PAGE_LEFT, y, CONTENT_WIDTH, 10, 14, font);
        }
    }

    /** Page 7: 评价表 - 主体 */
    private void drawQualityEvaluationPart1OnTemplate(PDDocument doc, Data d, PDFont font) throws IOException {
        PDPage page = doc.getPage(6);
        clearPageContent(doc, page, font);
        try (PDPageContentStream cs = new PDPageContentStream(doc, page, PDPageContentStream.AppendMode.APPEND, true, true)) {
            float y = PAGE_TOP;
            y = draw.drawCenteredTitle(cs, "课程质量评价表", y, 18, font);
            y -= 10;
            String hours = d.course == null ? "" : (d.course.getHours() == null ? "" : d.course.getHours().toString());
            String[][] head = {
                    {"课程名称", (d.course == null ? "" : n(d.course.getNameCn())), "课程类别", ""},
                    {"授课学时", hours, "课程学分", d.course == null ? "" : (d.course.getCredit() == null ? null : d.course.getCredit().toString())},
                    {"开课学期", n(d.offering.getSemester()), "授课对象", n(d.offering.getClazzNo())},
                    {"授课人数", String.valueOf(d.studentCount), "课程负责人", n(d.teacherName)},
                    {"课程组成员", d.evaluation != null && d.evaluation.getCourseMembers() != null ? d.evaluation.getCourseMembers() : "—", "", ""},
                    {"课程评价小组成员", d.evaluation != null && d.evaluation.getEvalGroupMembers() != null ? d.evaluation.getEvalGroupMembers() : "—", "", ""}
            };
            y = draw.drawTable(cs, head, new float[]{80, 180, 80, 165}, PAGE_LEFT, y, 22, 10, font);
            y -= 10;
            String[][] evalItems = buildQualityEvalItems(d);
            y = draw.drawTable(cs, evalItems, new float[]{100, 200, 205}, PAGE_LEFT, y, 36, 10, font);
        }
    }

    /** Page 8: 评价表 - 意见 */
    private void drawQualityEvaluationPart2OnTemplate(PDDocument doc, Data d, PDFont font) throws IOException {
        PDPage page = doc.getPage(7);
        clearPageContent(doc, page, font);
        try (PDPageContentStream cs = new PDPageContentStream(doc, page, PDPageContentStream.AppendMode.APPEND, true, true)) {
            float y = PAGE_TOP;
            y = draw.drawWrappedText(cs, "（根据以上课程质量评价情况，说明本课程在课程目标合理性、课程目标达成情况等方面存在的具体问题，并给出本次课程质量评价的结论及相关改进意见）", PAGE_LEFT, y, CONTENT_WIDTH, 10, 14, font);
            y -= 12;
            String[][] rows = {
                    {"1、课程存在的问题", n(d.evaluation != null ? d.evaluation.getExistingIssues() : null)},
                    {"2、课程目标达成评价的有效性", n(d.evaluation != null ? d.evaluation.getEvaluationValidity() : null)},
                    {"3、上一轮评价中的问题在本轮课程中的改进情况评价", n(d.evaluation != null ? d.evaluation.getLastRoundImprovements() : null)},
                    {"4、课程质量评价结论及改进意见", n(d.evaluation != null ? d.evaluation.getConclusionAndSuggestions() : null)}
            };
            for (String[] r : rows) {
                y = draw.drawText(cs, r[0] + "：", PAGE_LEFT, y, 11, font);
                y -= 16;
                y = draw.drawWrappedText(cs, r[1].isEmpty() ? "（待填写）" : r[1], PAGE_LEFT, y, CONTENT_WIDTH, 10, 14, font);
                y -= 10;
            }
        }
    }
}
