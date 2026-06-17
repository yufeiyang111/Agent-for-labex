package com.labex.service.teaching.export;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.labex.entity.Teacher;
import com.labex.entity.teaching.*;
import com.labex.mapper.TeacherMapper;
import com.labex.mapper.teaching.*;
import com.labex.service.teaching.AchievementCalcEngine;
import com.labex.service.teaching.QualityReportGenerator;
import com.labex.service.teaching.export.PdfDrawingHelper.PageStream;
import com.labex.vo.teaching.StudentAchievementVO;
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
 * 课程质量评价资料汇编 PDF 生成器 V2
 * 按 Class-docs/课程质量评价资料汇编.pdf 模板结构，从零创建 PDF。
 * 与 SyllabusPdfGenerator 相同方式：new PDDocument + PdfDrawingHelper 画完整布局。
 */
@Service("qualityCompendiumPdfGeneratorV2")
@Slf4j
public class QualityCompendiumPdfGeneratorV2 {

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

    public byte[] generate(Integer offeringId, Integer evaluationId) {
        try (PDDocument doc = new PDDocument();
             ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            Data d = loadData(offeringId, evaluationId);
            PDFont font = draw.loadChineseFont(doc);

            // 创建 8 页，逐页绘制
            PageStream ps = startPage(doc, font);

            // P1: 封面 + 资料目录
            ps = drawCover(doc, ps, font, d);
            // P2: 成绩统计表
            ps = drawGradeStats(doc, ps, font, d);
            // P3: 考核合理性审核表
            ps = drawAssessmentRationality(doc, ps, font, d);
            // P4: 报告 - 课程基本信息 + 对应关系
            ps = drawReportPart1(doc, ps, font, d);
            // P5: 报告 - 考核方式 + 合理性分析
            ps = drawReportPart2(doc, ps, font, d);
            // P6: 报告 - 达成情况 + 评价分析 + 改进
            ps = drawReportPart3(doc, ps, font, d);
            // P7: 课程质量评价表
            ps = drawQualityEval1(doc, ps, font, d);
            // P8: 评价意见
            ps = drawQualityEval2(doc, ps, font, d);

            ps.stream().close();
            doc.save(out);
            log.info("Quality compendium V2 generated for offering {}, pages: {}", offeringId, doc.getNumberOfPages());
            return out.toByteArray();
        } catch (Exception e) {
            log.error("生成质量评价资料汇编失败: offeringId={}, evaluationId={}", offeringId, evaluationId, e);
            throw new RuntimeException("生成质量评价资料汇编失败: " + e.getMessage(), e);
        }
    }

    // ======================== 数据 ========================

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
        if (evaluationId != null) d.evaluation = evaluationMapper.selectById(evaluationId);
        if (d.evaluation == null) {
            d.evaluation = evaluationMapper.selectOne(new LambdaQueryWrapper<QualityEvaluation>()
                    .eq(QualityEvaluation::getOfferingId, offeringId)
                    .orderByDesc(QualityEvaluation::getEvaluationId).last("LIMIT 1"));
        }
        try { d.report = reportGen.attainment(offeringId, d.evaluation == null ? null : d.evaluation.getEvaluationId()); }
        catch (Exception ignore) { d.report = null; }
        d.achievement = achievementEngine.calcForOffering(offeringId);
        List<StudentAchievementVO> students = d.achievement.getStudents();
        d.studentCount = students == null ? 0 : students.size();

        // 从学生成绩计算统计
        if (students != null && !students.isEmpty()) {
            List<Double> scores = students.stream()
                    .map(s -> s.getTotalWeightedScore() == null ? 0.0 : s.getTotalWeightedScore().doubleValue())
                    .collect(Collectors.toList());
            d.avgScore = scores.stream().mapToDouble(Double::doubleValue).average().orElse(0);
            d.maxScore = scores.stream().mapToDouble(Double::doubleValue).max().orElse(0);
            d.minScore = scores.stream().mapToDouble(Double::doubleValue).min().orElse(0);
            long passed = scores.stream().filter(s -> s >= 60).count();
            d.passRate = (double) passed / scores.size();
            // 成绩分布
            d.scoreDist = new LinkedHashMap<>();
            d.scoreDist.put("100-90", 0); d.scoreDist.put("89-80", 0);
            d.scoreDist.put("79-70", 0); d.scoreDist.put("69-60", 0); d.scoreDist.put("60-", 0);
            for (double s : scores) {
                if (s >= 90) d.scoreDist.merge("100-90", 1, Integer::sum);
                else if (s >= 80) d.scoreDist.merge("89-80", 1, Integer::sum);
                else if (s >= 70) d.scoreDist.merge("79-70", 1, Integer::sum);
                else if (s >= 60) d.scoreDist.merge("69-60", 1, Integer::sum);
                else d.scoreDist.merge("60-", 1, Integer::sum);
            }
        } else {
            d.avgScore = 0; d.maxScore = 0; d.minScore = 0; d.passRate = 0;
            d.scoreDist = new LinkedHashMap<>();
        }
        return d;
    }

    // ======================== 辅助 ========================

    private PageStream startPage(PDDocument doc, PDFont font) throws IOException {
        PDPage page = new PDPage(PDRectangle.A4);
        doc.addPage(page);
        PDPageContentStream cs = new PDPageContentStream(doc, page);
        return new PageStream(page, cs, PAGE_TOP);
    }

    private PageStream section(PDDocument doc, PageStream ps, PDFont font, String title) throws IOException {
        ps = ensureSpace(doc, ps, font, 30);
        float newY = draw.drawSectionTitle(ps.stream(), title, PAGE_LEFT, ps.y(), font);
        return new PageStream(ps.page(), ps.stream(), newY);
    }

    private PageStream text(PDDocument doc, PageStream ps, PDFont font, String content) throws IOException {
        ps = ensureSpace(doc, ps, font, 20);
        float newY = draw.drawText(ps.stream(), content, PAGE_LEFT, ps.y(), 11, font);
        return new PageStream(ps.page(), ps.stream(), newY);
    }

    private PageStream paragraph(PDDocument doc, PageStream ps, PDFont font, String label, String content) throws IOException {
        if (content == null || content.isEmpty()) return ps;
        ps = ensureSpace(doc, ps, font, 30);
        float newY = draw.drawText(ps.stream(), label + "：", PAGE_LEFT, ps.y(), 11, font);
        newY = draw.drawWrappedText(ps.stream(), content, PAGE_LEFT + 10, newY, CONTENT_WIDTH - 10, 10, 13, font);
        return new PageStream(ps.page(), ps.stream(), newY - 4);
    }

    private PageStream table(PDDocument doc, PageStream ps, PDFont font,
                              String[][] data, float[] colWidths, float minRowHeight) throws IOException {
        ps = ensureSpace(doc, ps, font, Math.min(data.length * minRowHeight + 20, 400));
        float newY = draw.drawTable(ps.stream(), data, colWidths, PAGE_LEFT, ps.y(), minRowHeight, 9, font);
        return new PageStream(ps.page(), ps.stream(), newY);
    }

    private PageStream ensureSpace(PDDocument doc, PageStream ps, PDFont font, float required) throws IOException {
        return draw.ensureSpace(doc, ps.stream(), ps.page(), ps.y(), required, font);
    }

    private PageStream newPage(PDDocument doc, PageStream ps, PDFont font) throws IOException {
        ps.stream().close();
        PDPage page = new PDPage(PDRectangle.A4);
        doc.addPage(page);
        PDPageContentStream cs = new PDPageContentStream(doc, page);
        return new PageStream(page, cs, PAGE_TOP);
    }

    // ======================== P1 封面 + 资料目录 ========================

    private PageStream drawCover(PDDocument doc, PageStream ps, PDFont font, Data d) throws IOException {
        float y = ps.y();
        y = draw.drawCenteredTitle(ps.stream(), "课程质量评价资料汇编", y, 24, font);
        y -= 10;
        y = draw.drawCenteredTitle(ps.stream(), "（ " + n(d.offering.getSemester()) + " 学期 ）", y, 14, font);
        y -= 30;

        // 课程信息
        String courseName = d.course == null ? "" : n(d.course.getNameCn());
        String courseCode = d.course == null ? "" : n(d.course.getCode());
        y = draw.drawText(ps.stream(), "课程名称：" + courseName, PAGE_LEFT + 60, y, 12, font);
        y -= 16;
        y = draw.drawText(ps.stream(), "课程代码：" + courseCode, PAGE_LEFT + 60, y, 12, font);
        y -= 16;
        y = draw.drawText(ps.stream(), "编制日期：" + java.time.LocalDate.now(), PAGE_LEFT + 60, y, 12, font);
        y -= 30;

        // 资料目录
        y = draw.drawCenteredTitle(ps.stream(), "资料目录", y, 18, font);
        y -= 10;
        String[] toc = {
                "1. 成绩统计表",
                "2. 课程考核合理性审核表",
                "3. 课程目标达成情况评价报告",
                "4. 课程质量评价表"
        };
        for (String s : toc) {
            y = draw.drawText(ps.stream(), s, PAGE_LEFT + 50, y, 13, font);
            y -= 20;
        }
        return new PageStream(ps.page(), ps.stream(), y);
    }

    // ======================== P2 成绩统计表 ========================

    private PageStream drawGradeStats(PDDocument doc, PageStream ps, PDFont font, Data d) throws IOException {
        ps = newPage(doc, ps, font);
        float y = ps.y();
        y = draw.drawCenteredTitle(ps.stream(), "成绩统计表", y, 18, font);
        y -= 8;
        ps = new PageStream(ps.page(), ps.stream(), y);

        String[][] head = {
                {"教研室", d.course == null ? "" : n(d.course.getDepartment()), "课程名称", d.course == null ? "" : n(d.course.getNameCn())},
                {"授课班级", n(d.offering.getClazzNo()), "任课教师", n(d.teacherName)},
                {"命题教师", n(d.teacherName), "期望值", "0.7"},
                {"平均分", String.format("%.2f", d.avgScore), "最高分/最低分", String.format("%.1f / %.1f", d.maxScore, d.minScore)},
                {"成绩分布", formatScoreDist(d.scoreDist), "成绩是否达到期望值并符合正态分布",
                        "及格率 " + String.format("%.1f%%", d.passRate * 100) + "   □是   □否"}
        };
        ps = table(doc, ps, font, head, new float[]{80, 180, 80, 165}, 22);
        ps = text(doc, ps, font, "");
        ps = text(doc, ps, font, "检查人：              检查时间：");
        ps = text(doc, ps, font, "（注：自查时可使用，仅供参考）");
        return ps;
    }

    // ======================== P3 考核合理性审核表 ========================

    private PageStream drawAssessmentRationality(PDDocument doc, PageStream ps, PDFont font, Data d) throws IOException {
        ps = newPage(doc, ps, font);
        float y = ps.y();
        y = draw.drawCenteredTitle(ps.stream(), "考核合理性审核表", y, 18, font);
        y -= 8;
        ps = new PageStream(ps.page(), ps.stream(), y);

        String hours = d.course == null ? "" : str(d.course.getHours());
        String credit = d.course == null ? "" : str(d.course.getCredit());
        String[][] head = {
                {"课程名称", d.course == null ? "" : n(d.course.getNameCn()), "课程类别", ""},
                {"授课学时", hours, "课程学分", credit},
                {"开课学期", n(d.offering.getSemester()), "授课对象", n(d.offering.getClazzNo())},
                {"授课人数", String.valueOf(d.studentCount), "课程负责人", n(d.teacherName)}
        };
        ps = table(doc, ps, font, head, new float[]{80, 180, 80, 165}, 22);

        ps = text(doc, ps, font, "");
        ps = text(doc, ps, font, "课程考核合理性审核：");

        // 审核表
        List<String[]> rows = new ArrayList<>();
        rows.add(new String[]{"课程目标", "考核内容", "考核方式", "考核分值", "合理性审核意见"});
        for (CourseObjective o : d.objectives) {
            List<ScoringItem> my = itemsFor(d, o);
            String content = my.isEmpty() ? "—" : my.stream().map(ScoringItem::getName).collect(Collectors.joining("、"));
            String way = my.isEmpty() ? "—" : my.stream().map(it -> tl(it.getType())).distinct().collect(Collectors.joining("、"));
            double score = my.stream().mapToDouble(it -> it.getWeight() == null ? 0 : it.getWeight().doubleValue() * 100).sum();
            rows.add(new String[]{n(o.getCode()), content, way, String.format("%.0f", score), ""});
        }
        ps = table(doc, ps, font, rows.toArray(new String[0][]), new float[]{80, 130, 90, 60, 145}, 24);
        ps = text(doc, ps, font, "");
        ps = text(doc, ps, font, "审核人：");
        return ps;
    }

    // ======================== P4 报告 - 基本信息 + 对应关系 ========================

    private PageStream drawReportPart1(PDDocument doc, PageStream ps, PDFont font, Data d) throws IOException {
        ps = newPage(doc, ps, font);
        float y = ps.y();
        y = draw.drawCenteredTitle(ps.stream(), "课程目标达成情况评价报告", y, 18, font);
        y -= 8;
        ps = new PageStream(ps.page(), ps.stream(), y);

        // 一、课程基本信息
        ps = section(doc, ps, font, "一、课程基本信息");
        String theory = d.course == null ? "" : str(d.course.getTheoryHours());
        String lab = d.course == null ? "" : str(d.course.getLabHours());
        String hours = d.course == null ? "" : str(d.course.getHours());
        String[][] basicInfo = {
                {"课程名称", d.course == null ? "" : n(d.course.getNameCn()), "学期", n(d.offering.getSemester())},
                {"学时", hours, "理论/实验", theory + " / " + lab},
                {"授课班级", n(d.offering.getClazzNo()), "考核方式", "考试"}
        };
        ps = table(doc, ps, font, basicInfo, new float[]{70, 200, 70, 165}, 22);

        // 1.1 课程任课教师
        ps = text(doc, ps, font, "");
        ps = text(doc, ps, font, "1.1 课程任课教师");
        String[][] teacherInfo = {
                {"任课教师", n(d.teacherName), "职称", ""},
                {"学生人数", String.valueOf(d.studentCount), "", ""}
        };
        ps = table(doc, ps, font, teacherInfo, new float[]{70, 200, 70, 165}, 22);

        // 二、对应关系
        ps = section(doc, ps, font, "二、课程目标与毕业要求观测点的对应关系及达成途径");
        List<String[]> mapRows = new ArrayList<>();
        mapRows.add(new String[]{"课程目标", "所支撑毕业要求", "所支撑的毕业要求观测点", "主要达成途径（教学设计）"});
        for (CourseObjective o : d.objectives) {
            List<ObjectiveSupport> my = d.supports.stream()
                    .filter(s -> s.getObjectiveId().equals(o.getObjectiveId())).collect(Collectors.toList());
            String reqCodes = my.stream().map(s -> d.indMap.get(s.getIndicatorId())).filter(Objects::nonNull)
                    .map(ind -> d.reqMap.get(ind.getRequirementId())).filter(Objects::nonNull)
                    .map(GraduationRequirement::getCode).distinct().collect(Collectors.joining(", "));
            String indCodes = my.stream().map(s -> d.indMap.get(s.getIndicatorId())).filter(Objects::nonNull)
                    .map(GraduationIndicator::getCode).distinct().collect(Collectors.joining(", "));
            String way = "通过" + d.items.stream()
                    .filter(it -> d.itemObjs.getOrDefault(it.getItemId(), Set.of()).contains(o.getObjectiveId()))
                    .map(ScoringItem::getName).collect(Collectors.joining("、")) + " 环节达成。";
            mapRows.add(new String[]{n(o.getCode()),
                    reqCodes.isEmpty() ? "—" : reqCodes,
                    indCodes.isEmpty() ? "—" : indCodes,
                    way});
        }
        ps = table(doc, ps, font, mapRows.toArray(new String[0][]), new float[]{55, 150, 110, 190}, 30);
        return ps;
    }

    // ======================== P5 报告 - 考核方式 + 合理性分析 ========================

    private PageStream drawReportPart2(PDDocument doc, PageStream ps, PDFont font, Data d) throws IOException {
        ps = newPage(doc, ps, font);

        // 三、课程考核方式、方法和标准
        ps = section(doc, ps, font, "三、课程考核方式、方法和标准");
        ps = text(doc, ps, font, "3.1 课程考核方式及分值分配");
        ps = text(doc, ps, font, "课程考核以检验课程目标的达成度为手段，根据各课程目标与考核环节的对应关系，建议值及考核细则如表 1 所示：");
        ps = text(doc, ps, font, "表 1 各课程目标考核方式、分数分配及达成期望（表中数字为样例）");

        // 表1
        List<String[]> t1Rows = new ArrayList<>();
        t1Rows.add(new String[]{"课程目标", "实验（权重20%）", "作业（权重30%）", "期末（权重50%）", "合计分值", "期望值", ""});
        double totalEx = 0, totalHw = 0, totalExm = 0;
        for (CourseObjective o : d.objectives) {
            double ex = 0, hw = 0, exm = 0;
            for (ScoringItem it : d.items) {
                if (!d.itemObjs.getOrDefault(it.getItemId(), Set.of()).contains(o.getObjectiveId())) continue;
                double w = it.getWeight() == null ? 0 : it.getWeight().doubleValue() * 100;
                String t = it.getType();
                if ("experiment".equals(t)) ex += w; else if ("homework".equals(t)) hw += w; else if ("exam".equals(t)) exm += w;
            }
            totalEx += ex; totalHw += hw; totalExm += exm;
            t1Rows.add(new String[]{n(o.getCode()),
                    String.format("%.0f", ex), String.format("%.0f", hw), String.format("%.0f", exm),
                    String.format("%.0f", ex + hw + exm), "0.7", ""});
        }
        t1Rows.add(new String[]{"合计",
                String.format("%.0f", totalEx), String.format("%.0f", totalHw), String.format("%.0f", totalExm),
                String.format("%.0f", totalEx + totalHw + totalExm), "—", ""});
        ps = table(doc, ps, font, t1Rows.toArray(new String[0][]), new float[]{80, 70, 70, 70, 70, 70, 70}, 22);

        // 3.2
        ps = text(doc, ps, font, "");
        ps = text(doc, ps, font, "3.2 课程考核方法及主要考核内容");
        List<String[]> t2Rows = new ArrayList<>();
        t2Rows.add(new String[]{"课程目标", "考核环节", "考核方法", "考核内容"});
        for (CourseObjective o : d.objectives) {
            List<ScoringItem> my = itemsFor(d, o);
            if (my.isEmpty()) {
                t2Rows.add(new String[]{n(o.getCode()), "—", "—", "—"});
            } else {
                for (int j = 0; j < my.size(); j++) {
                    ScoringItem it = my.get(j);
                    String type = switch (it.getType() == null ? "other" : it.getType()) {
                        case "homework" -> "作业"; case "experiment" -> "实验";
                        case "exam" -> "期末考试"; case "project" -> "大作业"; default -> "其他";
                    };
                    t2Rows.add(new String[]{j == 0 ? n(o.getCode()) : "", type, "评分制", n(it.getName())});
                }
            }
        }
        ps = table(doc, ps, font, t2Rows.toArray(new String[0][]), new float[]{70, 80, 90, 265}, 24);

        // 四、合理性分析
        ps = section(doc, ps, font, "四、考核环节、方式、内容的合理性分析");
        String analysisText = d.evaluation != null && d.evaluation.getAnalysisRationality() != null
                ? d.evaluation.getAnalysisRationality()
                : "（分析和说明平时作业、实验、课程报告、期末考试等各考核环节内容是否能够评价学生达成课程目标情况。即分课程目标证明，各课程目标的考核环节、考核方式和考核内容是合理的。）";
        ps = text(doc, ps, font, analysisText);
        return ps;
    }

    // ======================== P6 报告 - 达成情况 + 评价分析 + 改进 ========================

    private PageStream drawReportPart3(PDDocument doc, PageStream ps, PDFont font, Data d) throws IOException {
        ps = newPage(doc, ps, font);

        // 五、课程目标达成情况
        ps = section(doc, ps, font, "五、课程目标达成情况");
        ps = text(doc, ps, font, "5.1 主要考核数据");

        // 分布表
        List<String[]> distRows = new ArrayList<>();
        distRows.add(new String[]{"总成绩统计", "最高分", "最低分", "平均分", "", "", "", ""});
        distRows.add(new String[]{"", String.format("%.1f", d.maxScore), String.format("%.1f", d.minScore),
                String.format("%.1f", d.avgScore), "", "", "", ""});
        distRows.add(new String[]{"成绩分布图", "100-90", "89-80", "79-70", "69-60", "60分以下", "", ""});
        distRows.add(new String[]{"人数", strOr(d.scoreDist.get("100-90"), "0"), strOr(d.scoreDist.get("89-80"), "0"),
                strOr(d.scoreDist.get("79-70"), "0"), strOr(d.scoreDist.get("69-60"), "0"),
                strOr(d.scoreDist.get("60-"), "0"), "", ""});
        distRows.add(new String[]{"百分比",
                pct(d.scoreDist.get("100-90"), d.studentCount), pct(d.scoreDist.get("89-80"), d.studentCount),
                pct(d.scoreDist.get("79-70"), d.studentCount), pct(d.scoreDist.get("69-60"), d.studentCount),
                pct(d.scoreDist.get("60-"), d.studentCount), "", ""});
        ps = table(doc, ps, font, distRows.toArray(new String[0][]), new float[]{70, 60, 60, 60, 60, 60, 60, 75}, 24);

        // 5.2 达成表
        ps = text(doc, ps, font, "");
        ps = text(doc, ps, font, "5.2 各课程目标达成情况");
        List<String[]> achRows = new ArrayList<>();
        achRows.add(new String[]{"课程目标", "考核环节", "满分分值", "平均得分", "权重", "期望值", "达成人数", "达成值"});
        for (CourseObjective o : d.objectives) {
            List<ScoringItem> my = itemsFor(d, o);
            Double achVal = d.achievement.getByObjective() == null ? 0.0
                    : d.achievement.getByObjective().get(o.getObjectiveId()) == null ? 0.0
                    : (d.achievement.getByObjective().get(o.getObjectiveId()).getValue() == null ? 0.0
                        : d.achievement.getByObjective().get(o.getObjectiveId()).getValue().doubleValue());
            Integer reachedCount = d.achievement.getByObjective() == null ? 0
                    : d.achievement.getByObjective().get(o.getObjectiveId()) == null ? 0
                    : d.achievement.getByObjective().get(o.getObjectiveId()).getReachedCount();
            if (my.isEmpty()) {
                achRows.add(new String[]{n(o.getCode()), "—", "—", "—", "—", "0.7", "—", "—"});
            } else {
                for (int j = 0; j < my.size(); j++) {
                    ScoringItem it = my.get(j);
                    achRows.add(new String[]{j == 0 ? n(o.getCode()) : "",
                            n(it.getName()),
                            String.format("%.0f", it.getMaxScore() == null ? 100.0 : it.getMaxScore().doubleValue()),
                            "—",
                            String.format("%.2f", it.getWeight() == null ? 0 : it.getWeight()),
                            "0.7",
                            String.valueOf(reachedCount == null ? 0 : reachedCount),
                            achVal == null ? "—" : String.format("%.4f", achVal)});
                }
            }
        }
        ps = table(doc, ps, font, achRows.toArray(new String[0][]), new float[]{50, 70, 50, 60, 60, 70, 60, 85}, 24);

        // 六、达成评价分析
        ps = section(doc, ps, font, "六、课程目标达成评价分析");
        String text6 = d.evaluation != null && d.evaluation.getExistingIssues() != null
                ? d.evaluation.getExistingIssues()
                : "（结合直接和间接评价结果，分析学生在各课程目标及相应毕业要求指标点上的达成情况）";
        ps = text(doc, ps, font, text6);
        ps = text(doc, ps, font, "");
        ps = text(doc, ps, font, "总体课程达成情况分析：");
        String overall = d.evaluation != null && d.evaluation.getEvaluationValidity() != null
                ? d.evaluation.getEvaluationValidity()
                : String.format("本课程总达成度为 %s，学生在课程目标整体上达到期望水平。",
                        String.format("%.2f", d.achievement.getOverallReachedRatio()));
        ps = text(doc, ps, font, overall);

        // 七、上一轮改进
        ps = section(doc, ps, font, "七、上一轮存在问题及本轮改进效果");
        String last = d.evaluation != null && d.evaluation.getLastRoundImprovements() != null
                ? d.evaluation.getLastRoundImprovements() : "（无）";
        ps = text(doc, ps, font, last);

        // 八、下一轮改进
        ps = section(doc, ps, font, "八、下一轮教学改进措施");
        String next = d.evaluation != null && d.evaluation.getConclusionAndSuggestions() != null
                ? d.evaluation.getConclusionAndSuggestions() : "（待定）";
        ps = text(doc, ps, font, next);
        return ps;
    }

    // ======================== P7 课程质量评价表 ========================

    private PageStream drawQualityEval1(PDDocument doc, PageStream ps, PDFont font, Data d) throws IOException {
        ps = newPage(doc, ps, font);
        float y = ps.y();
        y = draw.drawCenteredTitle(ps.stream(), "课程质量评价表", y, 18, font);
        y -= 8;
        ps = new PageStream(ps.page(), ps.stream(), y);

        String hours = d.course == null ? "" : str(d.course.getHours());
        String credit = d.course == null ? "" : str(d.course.getCredit());
        String[][] head = {
                {"课程名称", d.course == null ? "" : n(d.course.getNameCn()), "课程类别", ""},
                {"授课学时", hours, "课程学分", credit},
                {"开课学期", n(d.offering.getSemester()), "授课对象", n(d.offering.getClazzNo())},
                {"授课人数", String.valueOf(d.studentCount), "课程负责人", n(d.teacherName)},
                {"课程组成员", d.evaluation != null && d.evaluation.getCourseMembers() != null ? d.evaluation.getCourseMembers() : "—", "", ""},
                {"课程评价小组成员", d.evaluation != null && d.evaluation.getEvalGroupMembers() != null ? d.evaluation.getEvalGroupMembers() : "—", "", ""}
        };
        ps = table(doc, ps, font, head, new float[]{80, 180, 80, 165}, 22);

        // 评价项目表
        List<String[]> evalRows = new ArrayList<>();
        evalRows.add(new String[]{"评价项目", "评价依据", "评价结果"});
        evalRows.add(new String[]{"课程目标合理性",
                "课程目标与所支撑的毕业要求指标点的对应关系是否合理",
                "合理（ ）/比较合理（ ）/不合理（ ）\n" + rational(d, "objective_indicator_rationality")});
        evalRows.add(new String[]{"",
                "课程目标是否包含知识、能力和素养目标",
                "包含（ ）/部分包含（ ）/不包含（ ）\n" + rational(d, "objective_contains_kaq")});
        evalRows.add(new String[]{"课程目标达成情况",
                "各课程目标达成值",
                "例如：0.8、0.7  ——  " + formatObjectiveAttainment(d)});
        evalRows.add(new String[]{"",
                "各课程目标期望值的合理性",
                "合理（ ）/比较合理（ ）/不合理（ ）\n" + rational(d, "expected_rationality")});
        evalRows.add(new String[]{"",
                "课程目标达成情况分析的合理性",
                "合理（ ）/比较合理（ ）/不合理（ ）\n" + rational(d, "analysis_rationality")});
        evalRows.add(new String[]{"持续改进",
                "持续改进措施的合理性",
                "合理（ ）/比较合理（ ）/不合理（ ）\n" + rational(d, "improvement_rationality")});
        ps = table(doc, ps, font, evalRows.toArray(new String[0][]), new float[]{100, 200, 205}, 36);
        return ps;
    }

    // ======================== P8 评价意见 ========================

    private PageStream drawQualityEval2(PDDocument doc, PageStream ps, PDFont font, Data d) throws IOException {
        ps = newPage(doc, ps, font);
        ps = text(doc, ps, font, "（根据以上课程质量评价情况，说明本课程在课程目标合理性、课程目标达成情况等方面存在的具体问题，并给出本次课程质量评价的结论及相关改进意见）");
        ps = text(doc, ps, font, "");

        ps = paragraph(doc, ps, font, "1、课程存在的问题",
                d.evaluation != null ? n(d.evaluation.getExistingIssues()) : "");
        ps = paragraph(doc, ps, font, "2、课程目标达成评价的有效性",
                d.evaluation != null ? n(d.evaluation.getEvaluationValidity()) : "");
        ps = paragraph(doc, ps, font, "3、上一轮评价中的问题在本轮课程中的改进情况评价",
                d.evaluation != null ? n(d.evaluation.getLastRoundImprovements()) : "");
        ps = paragraph(doc, ps, font, "4、课程质量评价结论及改进意见",
                d.evaluation != null ? n(d.evaluation.getConclusionAndSuggestions()) : "");
        return ps;
    }

    // ======================== 工具 ========================

    private List<ScoringItem> itemsFor(Data d, CourseObjective o) {
        return d.items.stream()
                .filter(it -> d.itemObjs.getOrDefault(it.getItemId(), Set.of()).contains(o.getObjectiveId()))
                .collect(Collectors.toList());
    }

    private String tl(String t) {
        if (t == null) return "其他";
        return switch (t) { case "homework" -> "作业"; case "experiment" -> "实验"; case "exam" -> "考试"; case "project" -> "大作业"; default -> "其他"; };
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
        return dist.entrySet().stream().map(e -> e.getKey() + "=" + e.getValue() + "人").collect(Collectors.joining("; "));
    }

    private static String strOr(Object o, String def) { return o == null ? def : o.toString(); }
    private static String pct(Integer count, int total) { if (count == null || total == 0) return "0%"; return String.format("%.1f%%", (count * 100.0) / total); }
    private static String n(String s) { return s == null ? "" : s; }
    private static String str(Object o) { return o == null ? "" : o.toString(); }
}
