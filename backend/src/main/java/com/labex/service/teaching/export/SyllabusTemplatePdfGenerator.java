package com.labex.service.teaching.export;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.labex.entity.Teacher;
import com.labex.entity.teaching.*;
import com.labex.mapper.teaching.*;
import com.labex.service.TeacherService;
import lombok.extern.slf4j.Slf4j;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.font.PDFont;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import java.awt.Color;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

import static com.labex.service.teaching.export.PdfDrawingHelper.*;

/**
 * Template-backed syllabus PDF generator.
 *
 * The official Class-docs/课程大纲.pdf file is a static PDF without AcroForm
 * fields, so export must use it as the page background and then write course
 * data into the same black-and-white syllabus structure. Content is allowed to
 * flow to following template pages and newly appended continuation pages.
 */
@Service
@Primary
@Slf4j
public class SyllabusTemplatePdfGenerator extends SyllabusPdfGenerator {

    private static final String TEMPLATE = "课程大纲.pdf";
    private static final float LEFT = 54f;
    private static final float RIGHT = 541f;
    private static final float TOP = 760f;
    private static final float BOTTOM = 54f;
    private static final float WIDTH = RIGHT - LEFT;

    @Autowired private PdfDrawingHelper draw;
    @Autowired private CourseMapper courseMapper;
    @Autowired private SyllabusMapper syllabusMapper;
    @Autowired private SyllabusChapterMapper chapterMapper;
    @Autowired private CourseObjectiveMapper objectiveMapper;
    @Autowired private ObjectiveSupportMapper supportMapper;
    @Autowired private GraduationIndicatorMapper indicatorMapper;
    @Autowired private GraduationRequirementMapper requirementMapper;
    @Autowired private CourseOfferingMapper offeringMapper;
    @Autowired private ScoringItemMapper itemMapper;
    @Autowired private ScoringItemObjectiveMapper linkMapper;
    @Autowired private TeacherService teacherService;
    @Autowired private ClassDocTemplateService templateService;

    @Override
    public byte[] generate(Integer courseId) {
        try (PDDocument doc = templateService.openPdfTemplate(TEMPLATE);
             ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            if (doc.getNumberOfPages() < 3) {
                throw new IllegalStateException(TEMPLATE + " 模板页数异常，至少需要 3 页");
            }

            Data data = loadData(courseId);
            PDFont font = draw.loadChineseFont(doc);
            Flow flow = new Flow(doc, font);

            drawHeader(flow, data.course);
            drawBasicInfo(flow, data);
            drawObjectives(flow, data);
            drawChapters(flow, data);
            drawPractice(flow, data);
            drawMethods(flow, data);
            drawAssessment(flow, data);
            drawAchievement(flow, data);
            drawBooks(flow, data);
            drawHours(flow, data);

            flow.close();
            doc.save(out);
            log.info("Template syllabus PDF generated for course {}, pages: {}", courseId, doc.getNumberOfPages());
            return out.toByteArray();
        } catch (IOException e) {
            log.error("生成模板课程大纲 PDF 失败", e);
            throw new RuntimeException("生成模板课程大纲 PDF 失败: " + e.getMessage(), e);
        }
    }

    private Data loadData(Integer courseId) {
        Data d = new Data();
        d.course = courseMapper.selectById(courseId);
        if (d.course == null) {
            throw new RuntimeException("课程不存在: " + courseId);
        }
        d.syllabus = syllabusMapper.selectOne(new LambdaQueryWrapper<Syllabus>()
                .eq(Syllabus::getCourseId, courseId));
        d.chapters = d.syllabus == null ? Collections.emptyList()
                : chapterMapper.selectList(new LambdaQueryWrapper<SyllabusChapter>()
                        .eq(SyllabusChapter::getSyllabusId, d.syllabus.getSyllabusId())
                        .orderByAsc(SyllabusChapter::getSortOrder)
                        .orderByAsc(SyllabusChapter::getChapterId));
        d.objectives = objectiveMapper.selectList(new LambdaQueryWrapper<CourseObjective>()
                .eq(CourseObjective::getCourseId, courseId)
                .orderByAsc(CourseObjective::getSortOrder)
                .orderByAsc(CourseObjective::getCode));
        d.supports = d.objectives.isEmpty() ? Collections.emptyList()
                : supportMapper.selectList(new LambdaQueryWrapper<ObjectiveSupport>()
                        .in(ObjectiveSupport::getObjectiveId,
                                d.objectives.stream().map(CourseObjective::getObjectiveId).collect(Collectors.toList())));
        d.indMap = d.supports.isEmpty() ? Collections.emptyMap()
                : indicatorMapper.selectBatchIds(d.supports.stream()
                        .map(ObjectiveSupport::getIndicatorId).distinct().collect(Collectors.toList()))
                        .stream().collect(Collectors.toMap(GraduationIndicator::getIndicatorId, i -> i));
        d.reqMap = d.indMap.isEmpty() ? Collections.emptyMap()
                : requirementMapper.selectBatchIds(d.indMap.values().stream()
                        .map(GraduationIndicator::getRequirementId).distinct().collect(Collectors.toList()))
                        .stream().collect(Collectors.toMap(GraduationRequirement::getRequirementId, r -> r));

        List<CourseOffering> offerings = offeringMapper.selectList(new LambdaQueryWrapper<CourseOffering>()
                .eq(CourseOffering::getCourseId, courseId)
                .orderByDesc(CourseOffering::getSemester));
        if (!offerings.isEmpty()) {
            d.items = itemMapper.selectList(new LambdaQueryWrapper<ScoringItem>()
                    .eq(ScoringItem::getOfferingId, offerings.get(0).getOfferingId())
                    .orderByAsc(ScoringItem::getSortOrder)
                    .orderByAsc(ScoringItem::getItemId));
        }
        if (!d.items.isEmpty()) {
            d.itemLinks = linkMapper.selectList(new LambdaQueryWrapper<ScoringItemObjective>()
                    .in(ScoringItemObjective::getItemId,
                            d.items.stream().map(ScoringItem::getItemId).collect(Collectors.toList())));
        }
        d.owner = d.course.getOwnerId() == null ? null : teacherService.getById(d.course.getOwnerId());
        return d;
    }

    private void drawHeader(Flow flow, Course course) throws IOException {
        flow.ensure(75);
        flow.text("【" + n(course.getCode()) + "】", LEFT, TOP, 11);
        flow.center(n(course.getNameCn()) + " 课程大纲", TOP - 25, 18);
        flow.y = TOP - 64;
    }

    private void drawBasicInfo(Flow flow, Data d) throws IOException {
        section(flow, "（一）基本信息");
        Course c = d.course;
        String owner = d.owner == null ? "" : n(d.owner.getTeacherName());
        String[][] rows = {
                {"中文课程名称：", n(c.getNameCn())},
                {"英文课程名称：", n(c.getNameEn())},
                {"课程编号：", n(c.getCode())},
                {"学分：", c.getCredit() == null ? "" : c.getCredit().stripTrailingZeros().toPlainString()},
                {"学时：", c.getHours() == null ? "" : c.getHours().toString()},
                {"适用专业：", n(c.getMajor())},
                {"先修课程：", n(c.getPrerequisite())},
                {"开课系（教研部）：", n(c.getDepartment())},
                {"执笔：", owner},
                {"审核：", ""}
        };
        for (String[] row : rows) {
            flow.ensure(16);
            flow.text(row[0] + row[1], LEFT, flow.y, 10.5f);
            flow.y -= 15.6f;
        }
        paragraph(flow, "课程简介：", firstNonBlank(s(d.syllabus, Syllabus::getCourseIntro), n(c.getIntro())));
    }

    private void drawObjectives(Flow flow, Data d) throws IOException {
        section(flow, "（二）课程目标");
        paragraph(flow, "本课程的主要任务是", s(d.syllabus, Syllabus::getMainTask));
        text(flow, "课程目标对学生的能力要求如下：");
        paragraph(flow, "1.知识目标", s(d.syllabus, Syllabus::getKnowledgeGoals));
        paragraph(flow, "2.能力目标", s(d.syllabus, Syllabus::getAbilityGoals));
        paragraph(flow, "3.素质目标", s(d.syllabus, Syllabus::getQualityGoals));

        text(flow, "课程目标对结课要求的支撑关系");
        List<String[]> rows = new ArrayList<>();
        rows.add(new String[]{"结课要求", "结课要求指标点", "课程目标"});
        for (CourseObjective obj : d.objectives) {
            List<ObjectiveSupport> mine = d.supports.stream()
                    .filter(s -> Objects.equals(s.getObjectiveId(), obj.getObjectiveId()))
                    .collect(Collectors.toList());
            rows.add(new String[]{
                    supportRequirements(mine, d),
                    supportIndicators(mine, d),
                    n(obj.getCode()) + " " + n(obj.getDescription())
            });
        }
        table(flow, rows, new float[]{115, 165, 205}, 9f, Set.of(0, 1));
    }

    private void drawChapters(Flow flow, Data d) throws IOException {
        section(flow, "（三）教学内容与课程目标的关系");
        List<String[]> rows = new ArrayList<>();
        rows.add(new String[]{"序号", "教学内容", "知识、能力教学要求", "思政元素及内容", "推荐学时", "教学方式", "对应课程目标"});
        for (int i = 0; i < d.chapters.size(); i++) {
            SyllabusChapter c = d.chapters.get(i);
            rows.add(new String[]{
                    String.valueOf(i + 1), n(c.getTopic()), n(c.getKnowledgeRequirements()),
                    n(c.getIdeologicalElements()),
                    c.getRecommendedHours() == null ? "" : c.getRecommendedHours().toString(),
                    n(c.getTeachingMethod()), n(c.getObjectiveRef())
            });
        }
        table(flow, rows, new float[]{24, 92, 135, 92, 38, 42, 62}, 8.5f);
    }

    private void drawPractice(Flow flow, Data d) throws IOException {
        section(flow, "（四）实践教学安排");
        List<ScoringItem> labs = d.items.stream()
                .filter(i -> "experiment".equals(i.getType()) || "project".equals(i.getType()))
                .collect(Collectors.toList());
        List<String[]> rows = new ArrayList<>();
        rows.add(new String[]{"项目编号", "实验项目", "实验学时", "实验类型", "实验要求", "每组人数"});
        int total = 0;
        for (int i = 0; i < labs.size(); i++) {
            total += 2;
            rows.add(new String[]{String.valueOf(i + 1), n(labs.get(i).getName()), "2", "设计性", "必修", "1"});
        }
        if (labs.isEmpty()) {
            rows.add(new String[]{"1", "课程实践或综合训练", "2", "设计性", "必修", "1"});
            total = 2;
        }
        rows.add(new String[]{"合计", "", String.valueOf(total), "", "", ""});
        table(flow, rows, new float[]{55, 150, 60, 70, 70, 80}, 9f);
        text(flow, "必修学时：" + total + "        选修学时：0");
    }

    private void drawMethods(Flow flow, Data d) throws IOException {
        section(flow, "（五）教学方法与习题要求");
        paragraph(flow, "1、课堂讲授", s(d.syllabus, Syllabus::getTeachingMethods));
        paragraph(flow, "2、习题要求", s(d.syllabus, Syllabus::getExerciseRequirements));
    }

    private void drawAssessment(Flow flow, Data d) throws IOException {
        section(flow, "（六）考核方式及成绩评定");
        paragraph(flow, "", firstNonBlank(s(d.syllabus, Syllabus::getAssessmentMethods),
                "课程考核以检验课程目标的达成度为手段，根据各课程目标与考核环节的对应关系，建议值及考核细则如下："));
        List<String[]> rows = new ArrayList<>();
        rows.add(new String[]{"考核依据", "建议分值", "考核/评价细则", "对应的课程目标"});
        if (d.items.isEmpty()) {
            rows.add(new String[]{"作业", "10-30", "主要考察学生对课程基础知识和典型方法的理解与运用。", objectiveCodes(d.objectives)});
            rows.add(new String[]{"实验", "10-30", "主要考察实验过程、结果分析和报告规范性。", objectiveCodes(d.objectives)});
            rows.add(new String[]{"考试", "40-80", "主要考察课程知识体系的综合理解和应用能力。", objectiveCodes(d.objectives)});
        } else {
            for (ScoringItem item : d.items) {
                rows.add(new String[]{typeLabel(item.getType()), percent(item), assessmentDetail(item), itemObjectiveCodes(item, d)});
            }
        }
        table(flow, rows, new float[]{62, 58, 245, 120}, 8.5f);
    }

    private void drawAchievement(Flow flow, Data d) throws IOException {
        section(flow, "（七）课程目标达成度评价");
        paragraph(flow, "", firstNonBlank(s(d.syllabus, Syllabus::getAchievementFormula),
                "课程目标达成度评价包括课程分目标达成度评价和课程总目标达成度评价，具体计算方法如下："));
        text(flow, "课程分目标达成度 = 达到课程分目标分值学生人数 / 学生总人数");
        text(flow, "课程总目标达成度 = 达到课程总目标分值学生人数 / 学生总人数");
        List<String[]> rows = new ArrayList<>();
        rows.add(new String[]{"课程目标", "支撑环节", "学生总人数", "达到课程分目标分值学生数", "达成度计算示例"});
        for (CourseObjective obj : d.objectives) {
            String code = n(obj.getCode());
            rows.add(new String[]{code, "作业", "W", "WQ", "WQ / W"});
            rows.add(new String[]{code, "实验", "E", "EQ", "EQ / E"});
            rows.add(new String[]{code, "考试", "T", "TQ", "TQ / T"});
        }
        table(flow, rows, new float[]{72, 70, 75, 125, 143}, 8.5f, Set.of(0));
    }

    private void drawBooks(Flow flow, Data d) throws IOException {
        section(flow, "（八）推荐教材或讲义及主要参考书");
        paragraph(flow, "推荐教材", s(d.syllabus, Syllabus::getTextbooks));
        paragraph(flow, "主要参考书", s(d.syllabus, Syllabus::getReferencesList));
    }

    private void drawHours(Flow flow, Data d) throws IOException {
        section(flow, "（九）学时分配");
        List<String[]> rows = new ArrayList<>();
        rows.add(new String[]{"序号", "教学内容", "学时分配", "讲授", "实验", "上机", "实践"});
        int total = 0, lecture = 0, lab = 0, machine = 0, practice = 0;
        for (int i = 0; i < d.chapters.size(); i++) {
            SyllabusChapter c = d.chapters.get(i);
            int h = c.getRecommendedHours() == null ? 0 : c.getRecommendedHours();
            int l = "讲授".equals(n(c.getTeachingMethod())) ? h : 0;
            int e = "实验".equals(n(c.getTeachingMethod())) ? h : 0;
            int m = "上机".equals(n(c.getTeachingMethod())) ? h : 0;
            int p = "实践".equals(n(c.getTeachingMethod())) ? h : 0;
            total += h; lecture += l; lab += e; machine += m; practice += p;
            rows.add(new String[]{String.valueOf(i + 1), n(c.getTopic()), String.valueOf(h),
                    String.valueOf(l), String.valueOf(e), String.valueOf(m), String.valueOf(p)});
        }
        rows.add(new String[]{"合计", "", String.valueOf(total), String.valueOf(lecture),
                String.valueOf(lab), String.valueOf(machine), String.valueOf(practice)});
        table(flow, rows, new float[]{35, 210, 60, 45, 45, 45, 45}, 9f);
    }

    private void section(Flow flow, String title) throws IOException {
        flow.ensure(30);
        flow.text(title, LEFT, flow.y, 11f);
        flow.y -= 20f;
    }

    private void text(Flow flow, String content) throws IOException {
        if (!hasText(content)) return;
        flow.ensure(16);
        flow.text(content, LEFT + 21, flow.y, 10.5f);
        flow.y -= 15.6f;
    }

    private void paragraph(Flow flow, String label, String content) throws IOException {
        if (!hasText(content) && !hasText(label)) return;
        flow.ensure(18);
        if (hasText(label)) {
            flow.text(label + (label.endsWith("：") || label.endsWith("是") ? "" : "："), LEFT, flow.y, 10.5f);
            flow.y -= 15.6f;
        }
        flow.wrapped(content, LEFT + 21, WIDTH - 21, 10.5f, 15.6f);
    }

    private void table(Flow flow, List<String[]> rows, float[] colWidths, float fontSize) throws IOException {
        table(flow, rows, colWidths, fontSize, Collections.emptySet());
    }

    private void table(Flow flow, List<String[]> rows, float[] colWidths, float fontSize,
                       Set<Integer> mergeColumns) throws IOException {
        if (rows.isEmpty()) return;
        float lineHeight = fontSize + 4f;
        String[][] cleanRows = cleanRows(rows, colWidths.length);
        float[] rowHeights = rowHeights(cleanRows, colWidths, fontSize, lineHeight, flow.font, mergeColumns);

        for (int r = 0; r < cleanRows.length; r++) {
            float rowHeight = rowHeights[r];
            float beforeY = flow.y;
            flow.ensure(rowHeight + 2);
            boolean pageBreak = flow.y > beforeY;
            float x = LEFT;
            float yTop = flow.y;

            flow.cs.setStrokingColor(Color.GRAY);
            for (int c = 0; c < colWidths.length; c++) {
                String cell = cleanRows[r][c];
                boolean samePrev = isMergeContinuation(cleanRows, r, c, mergeColumns) && !pageBreak;
                boolean sameNext = isMergeContinuation(cleanRows, r + 1, c, mergeColumns)
                        && flow.y - rowHeight - rowHeights[r + 1] - 2 >= BOTTOM;
                strokeCell(flow, x, yTop, colWidths[c], rowHeight, !samePrev, !sameNext, true, true);
                if (!samePrev) {
                    flow.cell(cell, x + 3, yTop - fontSize - 4, colWidths[c] - 6, fontSize, lineHeight);
                }
                x += colWidths[c];
            }
            flow.cs.setStrokingColor(Color.BLACK);
            flow.y -= rowHeight;
        }
        flow.y -= 8f;
    }

    private String[][] cleanRows(List<String[]> rows, int colCount) {
        String[][] out = new String[rows.size()][colCount];
        for (int r = 0; r < rows.size(); r++) {
            String[] row = rows.get(r);
            for (int c = 0; c < colCount; c++) {
                out[r][c] = cleanText(c < row.length ? row[c] : "");
            }
        }
        return out;
    }

    private float[] rowHeights(String[][] rows, float[] colWidths, float fontSize, float lineHeight,
                               PDFont font, Set<Integer> mergeColumns) throws IOException {
        float[] heights = new float[rows.length];
        for (int r = 0; r < rows.length; r++) {
            int maxLines = 1;
            for (int c = 0; c < colWidths.length; c++) {
                String cell = isMergeContinuation(rows, r, c, mergeColumns) ? "" : rows[r][c];
                maxLines = Math.max(maxLines, draw.wrapLines(cell, colWidths[c] - 6, fontSize, font).size());
            }
            heights[r] = Math.max(21f, maxLines * lineHeight + 8f);
        }
        return heights;
    }

    private boolean isMergeContinuation(String[][] rows, int r, int c, Set<Integer> mergeColumns) {
        if (r <= 1 || r >= rows.length || !mergeColumns.contains(c)) return false;
        String current = mergeKey(rows[r][c]);
        String previous = mergeKey(rows[r - 1][c]);
        return hasText(current) && current.equals(previous);
    }

    private String mergeKey(String value) {
        return cleanText(value).replaceAll("\\s+", " ").trim();
    }

    private void strokeCell(Flow flow, float x, float yTop, float width, float height,
                            boolean top, boolean bottom, boolean left, boolean right) throws IOException {
        if (top) strokeLine(flow, x, yTop, x + width, yTop);
        if (bottom) strokeLine(flow, x, yTop - height, x + width, yTop - height);
        if (left) strokeLine(flow, x, yTop, x, yTop - height);
        if (right) strokeLine(flow, x + width, yTop, x + width, yTop - height);
    }

    private void strokeLine(Flow flow, float x1, float y1, float x2, float y2) throws IOException {
        flow.cs.moveTo(x1, y1);
        flow.cs.lineTo(x2, y2);
        flow.cs.stroke();
    }

    private String supportRequirements(List<ObjectiveSupport> supports, Data d) {
        return supports.stream().map(s -> {
            GraduationIndicator ind = d.indMap.get(s.getIndicatorId());
            GraduationRequirement req = ind == null ? null : d.reqMap.get(ind.getRequirementId());
            return req == null ? "" : n(req.getCode()) + "." + n(req.getTitle());
        }).filter(this::hasText).distinct().collect(Collectors.joining("、"));
    }

    private String supportIndicators(List<ObjectiveSupport> supports, Data d) {
        return supports.stream()
                .map(s -> d.indMap.get(s.getIndicatorId()))
                .filter(Objects::nonNull)
                .map(i -> n(i.getCode()) + " " + n(i.getDescription()))
                .distinct()
                .collect(Collectors.joining("、"));
    }

    private String itemObjectiveCodes(ScoringItem item, Data d) {
        Set<Integer> ids = d.itemLinks.stream()
                .filter(l -> Objects.equals(l.getItemId(), item.getItemId()))
                .map(ScoringItemObjective::getObjectiveId)
                .collect(Collectors.toCollection(LinkedHashSet::new));
        if (ids.isEmpty()) return objectiveCodes(d.objectives);
        return d.objectives.stream()
                .filter(o -> ids.contains(o.getObjectiveId()))
                .map(CourseObjective::getCode)
                .collect(Collectors.joining("、"));
    }

    private String objectiveCodes(List<CourseObjective> objectives) {
        return objectives.stream().map(CourseObjective::getCode).filter(this::hasText).collect(Collectors.joining("、"));
    }

    private String assessmentDetail(ScoringItem item) {
        return switch (n(item.getType())) {
            case "homework" -> "主要考察课程知识点的理解、练习完成质量和阶段性学习效果。";
            case "experiment" -> "主要考察实验过程、工具使用、结果分析和实验报告规范性。";
            case "project" -> "主要考察综合设计、实现过程、团队协作和成果表达。";
            case "exam" -> "主要考察课程知识体系的综合理解、分析和应用能力。";
            default -> "结合课程目标设置评价标准，考察学生学习过程和成果质量。";
        };
    }

    private String typeLabel(String type) {
        return switch (n(type)) {
            case "homework" -> "作业";
            case "experiment" -> "实验";
            case "project" -> "项目";
            case "exam" -> "考试";
            default -> "其他";
        };
    }

    private String percent(ScoringItem item) {
        if (item.getWeight() == null) return "";
        return item.getWeight().multiply(new java.math.BigDecimal("100")).stripTrailingZeros().toPlainString();
    }

    private static class Data {
        Course course;
        Syllabus syllabus;
        Teacher owner;
        List<SyllabusChapter> chapters = Collections.emptyList();
        List<CourseObjective> objectives = Collections.emptyList();
        List<ObjectiveSupport> supports = Collections.emptyList();
        Map<Integer, GraduationIndicator> indMap = Collections.emptyMap();
        Map<Integer, GraduationRequirement> reqMap = Collections.emptyMap();
        List<ScoringItem> items = Collections.emptyList();
        List<ScoringItemObjective> itemLinks = Collections.emptyList();
    }

    private class Flow {
        final PDDocument doc;
        final PDFont font;
        PDPage page;
        PDPageContentStream cs;
        int pageIndex = 0;
        float y = TOP;

        Flow(PDDocument doc, PDFont font) throws IOException {
            this.doc = doc;
            this.font = font;
            this.page = doc.getPage(0);
            this.cs = stream(page);
            clearPage(page);
        }

        void ensure(float requiredHeight) throws IOException {
            if (y - requiredHeight >= BOTTOM) return;
            nextPage();
        }

        void nextPage() throws IOException {
            close();
            pageIndex++;
            if (pageIndex < doc.getNumberOfPages()) {
                page = doc.getPage(pageIndex);
            } else {
                page = new PDPage(PDRectangle.A4);
                doc.addPage(page);
            }
            cs = stream(page);
            clearPage(page);
            y = TOP;
        }

        PDPageContentStream stream(PDPage p) throws IOException {
            return new PDPageContentStream(doc, p, PDPageContentStream.AppendMode.APPEND, true, true);
        }

        void clearPage(PDPage p) throws IOException {
            PDRectangle box = p.getMediaBox();
            cs.setNonStrokingColor(Color.WHITE);
            cs.addRect(45, 45, box.getWidth() - 90, box.getHeight() - 90);
            cs.fill();
            cs.setNonStrokingColor(Color.BLACK);
        }

        void text(String text, float x, float y, float size) throws IOException {
            String safe = draw.sanitize(cleanText(text), font);
            cs.beginText();
            cs.setFont(font, size);
            cs.newLineAtOffset(x, y);
            cs.showText(safe);
            cs.endText();
        }

        void center(String text, float y, float size) throws IOException {
            String safe = draw.sanitize(cleanText(text), font);
            float textWidth = font.getStringWidth(safe) / 1000f * size;
            text(safe, LEFT + (WIDTH - textWidth) / 2, y, size);
        }

        void wrapped(String text, float x, float width, float size, float lineHeight) throws IOException {
            String safe = cleanText(text);
            if (!hasText(safe)) return;
            List<String> lines = draw.wrapLines(safe, width, size, font);
            for (String line : lines) {
                ensure(lineHeight);
                text(line, x, y, size);
                y -= lineHeight;
            }
            y -= 4f;
        }

        void cell(String text, float x, float y, float width, float size, float lineHeight) throws IOException {
            List<String> lines = draw.wrapLines(cleanText(text), width, size, font);
            for (String line : lines) {
                text(line, x, y, size);
                y -= lineHeight;
            }
        }

        void close() throws IOException {
            if (cs != null) {
                cs.close();
                cs = null;
            }
        }
    }

    private String s(Syllabus syllabus, java.util.function.Function<Syllabus, String> getter) {
        return syllabus == null ? "" : n(getter.apply(syllabus));
    }

    private String firstNonBlank(String first, String second) {
        return hasText(first) ? first : n(second);
    }

    private boolean hasText(String value) {
        return value != null && !value.trim().isEmpty();
    }

    private String cleanText(String value) {
        if (value == null) return "";
        String text = value.replace("\r\n", "\n").replace('\r', '\n');
        text = text.replaceAll("(?m)^\\s*```[A-Za-z0-9_-]*\\s*$", "");
        text = text.replace("```", "");
        text = text.replaceAll("(?m)^\\s{0,3}#{1,6}\\s*", "");
        text = text.replaceAll("(?m)^\\s*>\\s?", "");
        text = text.replaceAll("(?m)^\\s*\\|?\\s*:?-{3,}:?\\s*(\\|\\s*:?-{3,}:?\\s*)+\\|?\\s*$", "");
        text = text.replaceAll("\\*\\*([^*]+)\\*\\*", "$1");
        text = text.replaceAll("__([^_]+)__", "$1");
        text = text.replace("**", "").replace("__", "").replace("`", "");
        text = text.replaceAll("(?m)^\\s*[-*+]\\s+", "");

        text = text.replace("\\left", "").replace("\\right", "");
        text = text.replaceAll("\\\\frac\\s*\\{([^{}]+)}\\s*\\{([^{}]+)}", "$1 / $2");
        text = text.replace("\\times", " x ").replace("\\cdot", " x ").replace("\\sum", "sum");
        text = text.replaceAll("([A-Za-z])_\\{?([A-Za-z0-9]+)\\}?", "$1$2");
        text = text.replaceAll("\\^\\{([^{}]+)}", "^$1");
        text = text.replaceAll("\\$+", "");
        text = text.replace("{", "").replace("}", "");
        text = text.replaceAll("\\\\[A-Za-z]+", "");
        text = text.replace("*", "");

        StringBuilder out = new StringBuilder();
        for (String line : text.split("\\n")) {
            String trimmed = line.trim();
            if (trimmed.isEmpty()) {
                if (out.length() > 0 && out.charAt(out.length() - 1) != '\n') {
                    out.append('\n');
                }
                continue;
            }
            if (out.length() > 0 && out.charAt(out.length() - 1) != '\n') {
                out.append('\n');
            }
            out.append(trimmed);
        }
        return out.toString().replaceAll("\\n{3,}", "\n\n").trim();
    }

    private String n(String s) {
        return s == null ? "" : s;
    }
}
