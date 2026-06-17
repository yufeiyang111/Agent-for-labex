package com.labex.service.teaching.export;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.labex.entity.Teacher;
import com.labex.entity.teaching.*;
import com.labex.mapper.teaching.*;
import com.labex.service.TeacherService;
import com.labex.service.teaching.export.PdfDrawingHelper.PageStream;
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
 * 课程大纲 PDF 生成器（按 Class-docs/课程大纲.pdf 模板 9 节）
 */
@Service
@Slf4j
public class SyllabusPdfGenerator {

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

    /**
     * 生成课程大纲 PDF
     */
    public byte[] generate(Integer courseId) {
        try (PDDocument doc = new PDDocument(); ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            validateTemplate();
            Course course = courseMapper.selectById(courseId);
            if (course == null) {
                throw new RuntimeException("课程不存在: " + courseId);
            }

            // 加载数据
            Syllabus syllabus = syllabusMapper.selectOne(new LambdaQueryWrapper<Syllabus>()
                    .eq(Syllabus::getCourseId, courseId));
            List<SyllabusChapter> chapters = syllabus == null ? Collections.emptyList()
                    : chapterMapper.selectList(new LambdaQueryWrapper<SyllabusChapter>()
                            .eq(SyllabusChapter::getSyllabusId, syllabus.getSyllabusId())
                            .orderByAsc(SyllabusChapter::getSortOrder));
            List<CourseObjective> objectives = objectiveMapper.selectList(new LambdaQueryWrapper<CourseObjective>()
                    .eq(CourseObjective::getCourseId, courseId)
                    .orderByAsc(CourseObjective::getSortOrder));
            // 取支撑关系
            List<ObjectiveSupport> supports = objectives.isEmpty() ? Collections.emptyList()
                    : supportMapper.selectList(new LambdaQueryWrapper<ObjectiveSupport>()
                            .in(ObjectiveSupport::getObjectiveId,
                                    objectives.stream().map(CourseObjective::getObjectiveId).collect(Collectors.toList())));
            Map<Integer, GraduationIndicator> indMap = supports.isEmpty() ? Collections.emptyMap()
                    : indicatorMapper.selectBatchIds(supports.stream().map(ObjectiveSupport::getIndicatorId).distinct().collect(Collectors.toList()))
                            .stream().collect(Collectors.toMap(GraduationIndicator::getIndicatorId, i -> i));
            Map<Integer, GraduationRequirement> reqMap = indMap.isEmpty() ? Collections.emptyMap()
                    : requirementMapper.selectBatchIds(indMap.values().stream().map(GraduationIndicator::getRequirementId).distinct().collect(Collectors.toList()))
                            .stream().collect(Collectors.toMap(GraduationRequirement::getRequirementId, r -> r));
            // 评分项汇总（取任一开课的评分项做考核方式展示）
            List<CourseOffering> offerings = offeringMapper.selectList(new LambdaQueryWrapper<CourseOffering>()
                    .eq(CourseOffering::getCourseId, courseId));
            List<ScoringItem> items = Collections.emptyList();
            if (!offerings.isEmpty()) {
                items = itemMapper.selectList(new LambdaQueryWrapper<ScoringItem>()
                        .eq(ScoringItem::getOfferingId, offerings.get(0).getOfferingId())
                        .orderByAsc(ScoringItem::getSortOrder));
            }
            Teacher owner = course.getOwnerId() == null ? null : teacherService.getById(course.getOwnerId());

            // 开始绘制
            PDPage page = new PDPage(PDRectangle.A4);
            doc.addPage(page);
            PDPageContentStream cs = new PDPageContentStream(doc, page);
            PDFont font = draw.loadChineseFont(doc);

            float y = PAGE_TOP;

            // 顶部 +【课程编号】
            y = draw.drawText(cs, "【" + (course.getCode() == null ? "" : course.getCode()) + "】",
                    PAGE_LEFT, y, 11, font);
            // 大标题
            y -= 4;
            y = draw.drawCenteredTitle(cs, course.getNameCn() + " 课程大纲", y, 18, font);
            y -= 10;

            PageStream ps = new PageStream(page, cs, y);

            // (一) 基本信息
            ps = section(doc, ps, font, "（一）基本信息");
            String[][] basicInfo = {
                    {"中文课程名称", n(course.getNameCn()), "英文课程名称", n(course.getNameEn())},
                    {"课程编号", n(course.getCode()), "学分", course.getCredit() == null ? "" : course.getCredit().toString()},
                    {"学时", course.getHours() == null ? "" : course.getHours().toString(),
                            "理论/实验", (course.getTheoryHours() == null ? "0" : course.getTheoryHours().toString()) + " / "
                                    + (course.getLabHours() == null ? "0" : course.getLabHours().toString())},
                    {"适用专业", n(course.getMajor()), "先修课程", n(course.getPrerequisite())},
                    {"开课系（教研部）", n(course.getDepartment()), "执笔", owner != null ? n(owner.getTeacherName()) : "—"},
                    {"审核", "—", "课程简介", ""}
            };
            ps = renderTable(doc, ps, font, basicInfo, new float[]{90, 165, 90, 150}, 16);
            // 课程简介
            String intro = (syllabus != null && syllabus.getCourseIntro() != null && !syllabus.getCourseIntro().isEmpty())
                    ? syllabus.getCourseIntro()
                    : n(course.getIntro());
            if (!intro.isEmpty()) {
                ps = ensureSpace(doc, ps, font, 60);
                float newY = draw.drawText(ps.stream(), "课程简介：", PAGE_LEFT, ps.y(), 11, font);
                newY = draw.drawWrappedText(ps.stream(), intro, PAGE_LEFT, newY - 14,
                        CONTENT_WIDTH, 10, 13, font);
                ps = new PageStream(ps.page(), ps.stream(), newY - 6);
            }

            // (二) 课程目标
            ps = section(doc, ps, font, "（二）课程目标");
            if (syllabus != null) {
                ps = paragraph(doc, ps, font, "1.知识目标", syllabus.getKnowledgeGoals());
                ps = paragraph(doc, ps, font, "2.能力目标", syllabus.getAbilityGoals());
                ps = paragraph(doc, ps, font, "3.素质目标", syllabus.getQualityGoals());
            }
            // 课程目标对毕业要求的支撑关系（模板 3 列：毕业要求 / 毕业要求指标点 / 课程目标）
            if (!objectives.isEmpty()) {
                ps = ensureSpace(doc, ps, font, 30);
                float newY = draw.drawText(ps.stream(), "课程目标对毕业要求的支撑关系：",
                        PAGE_LEFT, ps.y(), 11, font);
                ps = new PageStream(ps.page(), ps.stream(), newY);
                String[][] supportTable = buildSupportTable3Col(objectives, supports, indMap, reqMap);
                ps = renderTable(doc, ps, font, supportTable, new float[]{140, 100, 255}, 20);
            }

            // (三) 教学内容与课程目标的关系（模板 7 列：序号/教学内容/知识能力教学要求/思政元素及内容/推荐学时/教学方式/对应的课程目标）
            ps = section(doc, ps, font, "（三）教学内容与课程目标的关系");
            if (chapters.isEmpty()) {
                ps = simpleText(doc, ps, font, "（暂未配置教学内容章节）");
            } else {
                String[][] chapterTable = new String[chapters.size() + 1][7];
                chapterTable[0] = new String[]{"序号", "教学内容", "知识、能力教学要求", "思政元素及内容", "推荐学时", "教学方式", "对应的课程目标"};
                for (int i = 0; i < chapters.size(); i++) {
                    SyllabusChapter c = chapters.get(i);
                    chapterTable[i + 1] = new String[]{
                            String.valueOf(i + 1),
                            n(c.getTopic()),
                            n(c.getKnowledgeRequirements()),
                            n(c.getIdeologicalElements()),
                            c.getRecommendedHours() == null ? "" : c.getRecommendedHours().toString(),
                            n(c.getTeachingMethod()),
                            n(c.getObjectiveRef())
                    };
                }
                ps = renderTable(doc, ps, font, chapterTable, new float[]{28, 110, 130, 80, 35, 45, 67}, 24);
            }

            // (四) 实践教学安排（6 列表 + 合计行 + 必修/选修学时）
            ps = section(doc, ps, font, "（四）实践教学安排");
            List<ScoringItem> labItems = items.stream()
                    .filter(it -> "experiment".equals(it.getType()) || "project".equals(it.getType()))
                    .collect(Collectors.toList());
            if (labItems.isEmpty()) {
                ps = simpleText(doc, ps, font, "（未配置实践教学评分项）");
            } else {
                int labTotal = 0;
                String[][] practiceTable = new String[labItems.size() + 2][6];
                practiceTable[0] = new String[]{"项目编号", "实验项目", "学时", "类型", "要求", "每组人数"};
                for (int i = 0; i < labItems.size(); i++) {
                    ScoringItem it = labItems.get(i);
                    int h = 2;
                    labTotal += h;
                    practiceTable[i + 1] = new String[]{
                            String.valueOf(i + 1),
                            n(it.getName()),
                            String.valueOf(h), "设计性", "必修", "1"
                    };
                }
                practiceTable[labItems.size() + 1] = new String[]{"合计", "", String.valueOf(labTotal), "", "", ""};
                ps = renderTable(doc, ps, font, practiceTable, new float[]{55, 175, 45, 60, 55, 80}, 20);
                // 必修/选修学时
                ps = ensureSpace(doc, ps, font, 25);
                float ay = draw.drawText(ps.stream(),
                        "必修学时：" + labTotal + "        选修学时：0",
                        PAGE_LEFT, ps.y(), 11, font);
                ps = new PageStream(ps.page(), ps.stream(), ay);
            }

            // (五) 教学方法与习题要求
            ps = section(doc, ps, font, "（五）教学方法与习题要求");
            if (syllabus != null) {
                ps = paragraph(doc, ps, font, "教学方法", syllabus.getTeachingMethods());
                ps = paragraph(doc, ps, font, "习题要求", syllabus.getExerciseRequirements());
            }

            // (六) 考核方式及成绩评定（4 列表：考核依据/建议分值/考核、评价细则/对应的课程目标）
            ps = section(doc, ps, font, "（六）考核方式及成绩评定");
            ps = ensureSpace(doc, ps, font, 25);
            float yint = draw.drawWrappedText(ps.stream(),
                    "课程考核以检验课程目标的达成度为手段，根据各课程目标与考核环节的对应关系，建议值及考核细则如下：",
                    PAGE_LEFT, ps.y(), CONTENT_WIDTH, 10, 13, font);
            ps = new PageStream(ps.page(), ps.stream(), yint - 4);
            if (!items.isEmpty()) {
                String[][] assessTable = buildAssessmentTableTemplate(items, objectives);
                ps = renderTable(doc, ps, font, assessTable, new float[]{90, 70, 200, 135}, 32);
            }

            // (七) 课程目标达成度评价
            ps = section(doc, ps, font, "（七）课程目标达成度评价");
            ps = ensureSpace(doc, ps, font, 30);
            float y7 = draw.drawWrappedText(ps.stream(),
                    "课程目标达成度评价包括课程分目标达成度评价和课程总目标达成度评价，具体计算方法如下：",
                    PAGE_LEFT, ps.y(), CONTENT_WIDTH, 10, 13, font);
            y7 = draw.drawWrappedText(ps.stream(),
                    "课程分目标达成度 = 达到课程分目标分值学生人数 / 学生总人数",
                    PAGE_LEFT, y7 - 14, CONTENT_WIDTH, 10, 13, font);
            y7 = draw.drawWrappedText(ps.stream(),
                    "课程总目标达成度 = 达到课程总目标分值学生人数 / 学生总人数",
                    PAGE_LEFT, y7 - 14, CONTENT_WIDTH, 10, 13, font);
            ps = new PageStream(ps.page(), ps.stream(), y7 - 4);
            // 详细评价表（按模板 4 列：支撑环节 / 学生总人数 / 达到课程分目标分值学生数 / 达成度计算示例）
            String[][] evalTable = buildEvalDetailTable(items, objectives);
            if (evalTable.length > 1) {
                ps = renderTable(doc, ps, font, evalTable, new float[]{150, 80, 110, 155}, 22);
            }

            // (八) 推荐教材
            ps = section(doc, ps, font, "（八）推荐教材或讲义及主要参考书");
            if (syllabus != null) {
                ps = paragraph(doc, ps, font, "推荐教材", syllabus.getTextbooks());
                ps = paragraph(doc, ps, font, "参考书", syllabus.getReferencesList());
            }

            // (九) 学时分配（6 列表：序号/教学内容/学时分配/其中-讲授/其中-实验/其中-上机/其中-实践 → 实际 5 列+合并"其中" 4 子列）
            ps = section(doc, ps, font, "（九）学时分配");
            if (chapters.isEmpty()) {
                ps = simpleText(doc, ps, font, "（暂未配置章节学时）");
            } else {
                // 模板表头：序号 | 教学内容 | 学时分配 | 其中（讲授/实验/上机/实践）
                // 简化：6 列：序号/教学内容/分配/讲授/实验/上机+实践(合并)
                String[][] hoursTable = new String[chapters.size() + 2][6];
                hoursTable[0] = new String[]{"序号", "教学内容", "学时分配", "其中：讲授", "其中：实验", "其中：上机/实践"};
                int total = 0, tLec = 0, tLab = 0, tPrac = 0;
                for (int i = 0; i < chapters.size(); i++) {
                    SyllabusChapter c = chapters.get(i);
                    int h = c.getRecommendedHours() == null ? 0 : c.getRecommendedHours();
                    int lec = ("讲授".equals(n(c.getTeachingMethod()))) ? h : 0;
                    int lab = ("实验".equals(n(c.getTeachingMethod()))) ? h : 0;
                    int prac = ("上机".equals(n(c.getTeachingMethod())) || "实践".equals(n(c.getTeachingMethod()))) ? h : 0;
                    total += h; tLec += lec; tLab += lab; tPrac += prac;
                    hoursTable[i + 1] = new String[]{
                            String.valueOf(i + 1),
                            n(c.getTopic()),
                            String.valueOf(h),
                            String.valueOf(lec),
                            String.valueOf(lab),
                            String.valueOf(prac)
                    };
                }
                hoursTable[chapters.size() + 1] = new String[]{"合计", "",
                        String.valueOf(total),
                        String.valueOf(tLec),
                        String.valueOf(tLab),
                        String.valueOf(tPrac)};
                ps = renderTable(doc, ps, font, hoursTable, new float[]{30, 160, 70, 70, 65, 100}, 18);
            }

            ps.stream().close();

            doc.save(out);
            log.info("Syllabus PDF generated for course {}, pages: {}", courseId, doc.getNumberOfPages());
            return out.toByteArray();
        } catch (IOException e) {
            log.error("生成大纲 PDF 失败", e);
            throw new RuntimeException("生成大纲 PDF 失败: " + e.getMessage(), e);
        }
    }

    // ============ Helpers ============

    private void validateTemplate() throws IOException {
        try (PDDocument template = templateService.openPdfTemplate("课程大纲.pdf")) {
            if (template.getNumberOfPages() < 3) {
                throw new IllegalStateException("课程大纲.pdf 模板页数异常，至少需要 3 页");
            }
        }
    }

    private PageStream section(PDDocument doc, PageStream ps, PDFont font, String title) throws IOException {
        ps = ensureSpace(doc, ps, font, 30);
        float newY = draw.drawSectionTitle(ps.stream(), title, PAGE_LEFT, ps.y(), font);
        return new PageStream(ps.page(), ps.stream(), newY);
    }

    private PageStream paragraph(PDDocument doc, PageStream ps, PDFont font,
                                  String label, String content) throws IOException {
        if (content == null || content.isEmpty()) return ps;
        ps = ensureSpace(doc, ps, font, 30);
        float newY = draw.drawText(ps.stream(), label + "：", PAGE_LEFT, ps.y(), 11, font);
        newY = draw.drawWrappedText(ps.stream(), content, PAGE_LEFT + 10, newY,
                CONTENT_WIDTH - 10, 10, 13, font);
        return new PageStream(ps.page(), ps.stream(), newY - 4);
    }

    private PageStream simpleText(PDDocument doc, PageStream ps, PDFont font, String content) throws IOException {
        ps = ensureSpace(doc, ps, font, 30);
        float newY = draw.drawWrappedText(ps.stream(), content, PAGE_LEFT, ps.y(),
                CONTENT_WIDTH, 10, 13, font);
        return new PageStream(ps.page(), ps.stream(), newY - 4);
    }

    private PageStream renderTable(PDDocument doc, PageStream ps, PDFont font,
                                    String[][] data, float[] colWidths, float minRowHeight) throws IOException {
        // 估算所需高度，如果超过当前页剩余空间则换页
        ps = ensureSpace(doc, ps, font, Math.min(data.length * minRowHeight + 20, 300));
        float newY = draw.drawTable(ps.stream(), data, colWidths,
                PAGE_LEFT, ps.y(), minRowHeight, 9, font);
        return new PageStream(ps.page(), ps.stream(), newY);
    }

    private PageStream ensureSpace(PDDocument doc, PageStream ps, PDFont font, float required) throws IOException {
        return draw.ensureSpace(doc, ps.stream(), ps.page(), ps.y(), required, font);
    }

    private String n(String s) {
        return s == null ? "" : s;
    }

    private String[][] buildSupportTable(List<CourseObjective> objectives, List<ObjectiveSupport> supports,
                                          Map<Integer, GraduationIndicator> indMap,
                                          Map<Integer, GraduationRequirement> reqMap) {
        // 按目标分组
        Map<Integer, List<ObjectiveSupport>> grouped = new HashMap<>();
        for (ObjectiveSupport s : supports) {
            grouped.computeIfAbsent(s.getObjectiveId(), k -> new ArrayList<>()).add(s);
        }
        String[][] table = new String[objectives.size() + 1][4];
        table[0] = new String[]{"毕业要求", "毕业要求指标点", "指标点描述", "课程目标"};
        for (int i = 0; i < objectives.size(); i++) {
            CourseObjective obj = objectives.get(i);
            List<ObjectiveSupport> mine = grouped.getOrDefault(obj.getObjectiveId(), Collections.emptyList());
            String reqStr = mine.stream()
                    .map(s -> {
                        GraduationIndicator ind = indMap.get(s.getIndicatorId());
                        if (ind == null) return "—";
                        GraduationRequirement r = reqMap.get(ind.getRequirementId());
                        return r == null ? "—" : (r.getCode() + " " + n(r.getTitle()));
                    })
                    .distinct()
                    .collect(Collectors.joining(", "));
            String indStr = mine.stream()
                    .map(s -> indMap.get(s.getIndicatorId()))
                    .filter(Objects::nonNull)
                    .map(GraduationIndicator::getCode)
                    .distinct()
                    .collect(Collectors.joining(", "));
            String indDesc = mine.stream()
                    .map(s -> indMap.get(s.getIndicatorId()))
                    .filter(Objects::nonNull)
                    .map(ind -> n(ind.getDescription()))
                    .findFirst()
                    .orElse("—");
            table[i + 1] = new String[]{
                    reqStr.isEmpty() ? "—" : reqStr,
                    indStr.isEmpty() ? "—" : indStr,
                    indDesc,
                    obj.getCode() + (obj.getDescription() != null ? " " + obj.getDescription() : "")
            };
        }
        return table;
    }

    private String[][] buildAssessmentTable(List<ScoringItem> items, ScoringItemObjectiveMapper linkMapper,
                                             List<CourseObjective> objectives) {
        // 按 type 聚合
        Map<String, List<ScoringItem>> byType = new LinkedHashMap<>();
        for (ScoringItem it : items) {
            byType.computeIfAbsent(it.getType() == null ? "other" : it.getType(), k -> new ArrayList<>()).add(it);
        }
        Map<Integer, String> objCodeMap = objectives.stream()
                .collect(Collectors.toMap(CourseObjective::getObjectiveId, CourseObjective::getCode));
        List<Integer> itemIds = items.stream().map(ScoringItem::getItemId).collect(Collectors.toList());
        Map<Integer, Set<Integer>> itemObjs = new HashMap<>();
        if (!itemIds.isEmpty()) {
            for (ScoringItemObjective l : linkMapper.selectList(new LambdaQueryWrapper<ScoringItemObjective>()
                    .in(ScoringItemObjective::getItemId, itemIds))) {
                itemObjs.computeIfAbsent(l.getItemId(), k -> new HashSet<>()).add(l.getObjectiveId());
            }
        }

        List<String[]> rows = new ArrayList<>();
        rows.add(new String[]{"考核依据", "建议分值", "考核/评价细则", "对应的课程目标"});
        for (var entry : byType.entrySet()) {
            String typeLabel = typeLabel(entry.getKey());
            List<ScoringItem> list = entry.getValue();
            double totalWeight = list.stream()
                    .mapToDouble(it -> it.getWeight() == null ? 0 : it.getWeight().doubleValue() * 100)
                    .sum();
            Set<String> objCodes = new LinkedHashSet<>();
            for (ScoringItem it : list) {
                Set<Integer> objs = itemObjs.getOrDefault(it.getItemId(), Collections.emptySet());
                for (Integer o : objs) {
                    String code = objCodeMap.get(o);
                    if (code != null) objCodes.add(code);
                }
            }
            String detail = list.stream().map(ScoringItem::getName).collect(Collectors.joining("、"));
            rows.add(new String[]{
                    typeLabel,
                    String.format("%.0f", totalWeight),
                    "包括：" + detail,
                    objCodes.isEmpty() ? "—" : String.join("，", objCodes)
            });
        }
        return rows.toArray(new String[0][]);
    }

    private String typeLabel(String type) {
        return switch (type) {
            case "homework" -> "作业";
            case "experiment" -> "实验";
            case "exam" -> "考试";
            case "project" -> "项目/大作业";
            default -> "其他";
        };
    }

    // ============ 严格按模板 3 列支撑关系表 ============
    private String[][] buildSupportTable3Col(List<CourseObjective> objectives, List<ObjectiveSupport> supports,
                                              Map<Integer, GraduationIndicator> indMap,
                                              Map<Integer, GraduationRequirement> reqMap) {
        Map<Integer, List<ObjectiveSupport>> grouped = new HashMap<>();
        for (ObjectiveSupport s : supports) {
            grouped.computeIfAbsent(s.getObjectiveId(), k -> new ArrayList<>()).add(s);
        }
        String[][] table = new String[objectives.size() + 1][3];
        table[0] = new String[]{"毕业要求", "毕业要求指标点", "课程目标"};
        for (int i = 0; i < objectives.size(); i++) {
            CourseObjective obj = objectives.get(i);
            List<ObjectiveSupport> mine = grouped.getOrDefault(obj.getObjectiveId(), Collections.emptyList());
            String reqStr = mine.stream()
                    .map(s -> {
                        GraduationIndicator ind = indMap.get(s.getIndicatorId());
                        if (ind == null) return "—";
                        GraduationRequirement r = reqMap.get(ind.getRequirementId());
                        return r == null ? "—" : (r.getCode() + " " + n(r.getTitle()));
                    })
                    .distinct()
                    .collect(Collectors.joining(", "));
            String indStr = mine.stream()
                    .map(s -> indMap.get(s.getIndicatorId()))
                    .filter(Objects::nonNull)
                    .map(GraduationIndicator::getCode)
                    .distinct()
                    .collect(Collectors.joining(", "));
            table[i + 1] = new String[]{
                    reqStr.isEmpty() ? "—" : reqStr,
                    indStr.isEmpty() ? "—" : indStr,
                    obj.getCode() + (obj.getDescription() != null ? " " + n(obj.getDescription()) : "")
            };
        }
        return table;
    }

    // ============ (六) 考核方式 4 列表（按 Class-docs 模板）============
    private String[][] buildAssessmentTableTemplate(List<ScoringItem> items, List<CourseObjective> objectives) {
        Map<String, List<ScoringItem>> byType = new LinkedHashMap<>();
        for (ScoringItem it : items) {
            byType.computeIfAbsent(it.getType() == null ? "other" : it.getType(), k -> new ArrayList<>()).add(it);
        }
        // 评分区间建议（10-30 作业 / 10-30 实验 / 40-80 考试）
        String[][] rows = new String[byType.size() + 1][4];
        rows[0] = new String[]{"考核依据", "建议分值", "考核、评价细则", "对应的课程目标"};
        int r = 1;
        for (var entry : byType.entrySet()) {
            String type = entry.getKey();
            String label = typeLabel(type);
            String range = switch (type) {
                case "homework" -> "10-30";
                case "experiment" -> "10-30";
                case "exam" -> "40-80";
                case "project" -> "10-30";
                default -> "—";
            };
            String detail = switch (type) {
                case "homework" -> "（1）主要考察学生对本章知识点的掌握与运用；\n（2）作业形式不限，可采用习题、报告、项目设计等。";
                case "experiment" -> "（1）理解和掌握实验原理、操作步骤与结果分析；\n（2）实验报告完整、规范。";
                case "exam" -> "（1）主要考察学生对课程整体知识体系的综合理解；\n（2）考试形式不限，可采用闭卷/开卷/项目答辩等。";
                case "project" -> "（1）项目选题、方案设计与实施；\n（2）团队协作与成果展示。";
                default -> "其他考核方式。";
            };
            // 收集所有 objectives
            StringBuilder objs = new StringBuilder();
            for (CourseObjective o : objectives) {
                if (objs.length() > 0) objs.append("，");
                objs.append(o.getCode());
            }
            rows[r++] = new String[]{label, range, detail, objs.toString()};
        }
        return rows;
    }

    // ============ (七) 课程目标详细评价表（4 列表）============
    private String[][] buildEvalDetailTable(List<ScoringItem> items, List<CourseObjective> objectives) {
        // 模板 4 列：课程目标 | 支撑环节 | 学生总人数 | 达到课程分目标分值学生数 | 达成度计算示例
        // 实际数据未提供时，列头 + 5 个目标各 3 行（作业/实验/考试）
        String[] typeLabelArr = {"作业", "实验", "考试"};
        // 每个目标占 3 行
        int targetCount = Math.max(1, objectives.size());
        int rowCount = 1 + targetCount * typeLabelArr.length;
        String[][] rows = new String[rowCount][4];
        rows[0] = new String[]{"课程目标", "支撑环节", "学生总人数", "达到课程分目标分值学生数 | 达成度计算示例"};
        int r = 1;
        for (CourseObjective o : objectives) {
            for (int t = 0; t < typeLabelArr.length; t++) {
                String prefix = (t == 0) ? o.getCode() : "";
                char letter = (char) ('W' + t); // W/E/T
                rows[r++] = new String[]{
                        prefix,
                        typeLabelArr[t],
                        "W" + r,
                        letter + (r - 1) + "Q  |  " + letter + (r - 1) + "Q / W" + r
                };
            }
        }
        return rows;
    }
}
