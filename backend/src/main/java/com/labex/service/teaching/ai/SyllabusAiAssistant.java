package com.labex.service.teaching.ai;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.labex.entity.StudentCourseEvaluation;
import com.labex.entity.teaching.*;
import com.labex.labexagent.llm.LlmProvider;
import com.labex.labexagent.llm.LlmProviderFactory;
import com.labex.mapper.StudentCourseEvaluationMapper;
import com.labex.mapper.teaching.*;
import com.labex.service.teaching.AchievementCalcEngine;
import com.labex.vo.teaching.OfferingAchievementVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 课程大纲 / 质量评价 AI 辅助填写
 * 复用项目现有 OpenAiCompatibleProvider（labexagent.llm 包）
 */
@Service
@Slf4j
public class SyllabusAiAssistant {

    private static final ObjectMapper JSON = new ObjectMapper();

    @Autowired private LlmProviderFactory llmFactory;
    @Autowired private CourseMapper courseMapper;
    @Autowired private SyllabusMapper syllabusMapper;
    @Autowired private SyllabusChapterMapper chapterMapper;
    @Autowired private CourseObjectiveMapper objectiveMapper;
    @Autowired private ObjectiveSupportMapper supportMapper;
    @Autowired private GraduationRequirementMapper requirementMapper;
    @Autowired private GraduationIndicatorMapper indicatorMapper;
    @Autowired private CourseOfferingMapper offeringMapper;
    @Autowired private ScoringItemMapper scoringItemMapper;
    @Autowired private ScoringItemObjectiveMapper scoringItemObjectiveMapper;
    @Autowired private QualityEvaluationMapper evaluationMapper;
    @Autowired private StudentCourseEvaluationMapper studentEvalMapper;
    @Autowired private AchievementCalcEngine achievementEngine;

    // ============ 课程大纲字段 ============

    /**
     * AI 一键生成完整教学闭环基础数据，并直接持久化。
     * 覆盖范围：课程大纲正文、教学章节、课程目标、课程目标-结课要求支撑矩阵。
     */
    @Transactional
    public Map<String, Object> generateCompleteCourseSetup(Integer courseId) {
        Course course = courseMapper.selectById(courseId);
        if (course == null) {
            throw new IllegalArgumentException("课程不存在: " + courseId);
        }

        Syllabus syllabus = getOrCreateSyllabus(courseId);
        syllabus.setCourseIntro(safeText(generateCourseIntro(courseId), fallbackCourseIntro(course)));
        syllabus.setMainTask(safeText(generateMainTask(courseId), fallbackMainTask(course)));
        syllabus.setKnowledgeGoals(safeText(generateGoals(courseId, "knowledge"), fallbackGoalText(course, "knowledge")));
        syllabus.setAbilityGoals(safeText(generateGoals(courseId, "ability"), fallbackGoalText(course, "ability")));
        syllabus.setQualityGoals(safeText(generateGoals(courseId, "quality"), fallbackGoalText(course, "quality")));
        syllabus.setTeachingMethods(safeText(generateTeachingMethods(courseId), fallbackTeachingMethods(course)));
        syllabus.setExerciseRequirements(safeText(generateExerciseRequirements(courseId), fallbackExerciseRequirements(course)));
        syllabus.setAssessmentMethods(safeText(generateAssessmentMethods(courseId), fallbackAssessmentMethods(course)));
        syllabus.setAchievementFormula(safeText(generateAchievementFormula(courseId), fallbackAchievementFormula()));
        syllabus.setTextbooks(safeText(generateTextbooks(courseId), fallbackTextbooks(course)));
        syllabus.setReferencesList(safeText(generateReferencesList(courseId), fallbackReferences(course)));
        syllabusMapper.updateById(syllabus);

        List<SyllabusChapter> chapters = generateChapters(courseId);
        replaceChapters(syllabus.getSyllabusId(), chapters);

        List<CourseObjective> objectives = upsertGeneratedObjectives(course, syllabus);
        List<GraduationIndicator> indicators = ensureConclusionIndicators(course);
        int supportCount = replaceObjectiveSupports(objectives, indicators);
        int scoringLinkCount = ensureOfferingScoringLinks(courseId, objectives);

        Map<String, Object> result = new LinkedHashMap<>();
        result.put("syllabusId", syllabus.getSyllabusId());
        result.put("textFields", 11);
        result.put("chapterCount", chapters.size());
        result.put("objectiveCount", objectives.size());
        result.put("indicatorCount", indicators.size());
        result.put("supportCount", supportCount);
        result.put("scoringLinkCount", scoringLinkCount);
        result.put("message", "课程大纲、教学章节、课程目标和支撑矩阵已全部生成");
        return result;
    }

    public String generateCourseIntro(Integer courseId) {
        Course course = courseMapper.selectById(courseId);
        if (course == null) return "";
        String sys = "你是一位资深课程设计专家。请用专业、丰富、详尽的语言撰写课程简介。\n" +
                "要求：400-600 字；包含 1) 课程性质与定位 2) 主要研究对象与核心问题 3) 与学科/专业的支撑关系 4) 课程价值与意义 5) 主要内容脉络。\n" +
                "只输出正文，禁止任何思考过程、标签、解释、前后缀。";
        String user = String.format("课程名称：%s\n适用专业：%s\n学分：%s 学时：%s\n理论学时：%s 实验学时：%s\n请撰写 400-600 字的课程简介。",
                n(course.getNameCn()), n(course.getMajor()),
                str(course.getCredit()), str(course.getHours()),
                str(course.getTheoryHours()), str(course.getLabHours()));
        return chat(sys, user, 1500);
    }

    public String generateGoals(Integer courseId, String type) {
        Course course = courseMapper.selectById(courseId);
        if (course == null) return "";
        String typeLabel = switch (type) {
            case "knowledge" -> "知识目标";
            case "ability" -> "能力目标";
            case "quality" -> "素质目标";
            default -> "课程目标";
        };
        String sys = String.format("你是一位资深课程设计专家。请为指定课程撰写详尽的%s。\n" +
                "要求：5-8 条；每条 60-100 字；要求可量化、可考核；分 3-4 个层次（基础/核心/拓展/应用）。\n" +
                "只输出编号列表，禁止任何思考过程、标签、解释、前后缀。", typeLabel);
        String user = String.format("课程名称：%s\n适用专业：%s\n总学时：%s\n请撰写 5-8 条详尽的%s。",
                n(course.getNameCn()), n(course.getMajor()),
                str(course.getHours()), typeLabel);
        return chat(sys, user, 2000);
    }

    /**
     * 生成章节列表（返回 SyllabusChapter 列表，未持久化）
     */
    public List<SyllabusChapter> generateChapters(Integer courseId) {
        Course course = courseMapper.selectById(courseId);
        if (course == null) return Collections.emptyList();
        int totalHours = course.getHours() == null ? 32 : course.getHours();
        int sections = Math.max(5, Math.min(10, totalHours / 4));

        String sys = "你是一位资深课程设计专家。请为给定课程设计教学章节大纲。" +
                "严格输出 JSON 数组，每个元素含字段 chapterNo、topic、knowledgeRequirements、ideologicalElements、recommendedHours、teachingMethod、objectiveRef。" +
                "topic 20-40 字；knowledgeRequirements 80-150 字，详细描述本章核心知识点、技能、难点。\n" +
                "ideologicalElements 40-80 字，写明工程伦理、规范意识、创新意识、团队协作或社会责任等课程思政融入点。\n" +
                "禁止任何思考过程、标签、解释；只输出纯 JSON 数组。";
        String user = String.format(
                "课程名称：%s\n适用专业：%s\n总学时：%d\n请生成 %d 个章节，章节序号用「第一章」「第二章」等。" +
                        "teachingMethod 从 讲授/实验/上机/实践 中选。" +
                        "objectiveRef 用 「课程目标1」或「课程目标1,2」格式。" +
                "knowledgeRequirements 要丰富详尽。",
                n(course.getNameCn()), n(course.getMajor()), totalHours, sections);
        String raw = chat(sys, user, 3000);
        List<SyllabusChapter> parsed = parseChapters(raw);
        if (parsed.isEmpty()) {
            log.warn("AI chapter generation returned no usable rows for course {}, fallback chapters will be used", courseId);
            return fallbackChapters(course, sections, totalHours);
        }
        return normalizeChapters(course, parsed, sections, totalHours);
    }

    public String generateTeachingMethods(Integer courseId) {
        Course course = courseMapper.selectById(courseId);
        if (course == null) return "";
        String sys = "你是教育教学专家。请详细描述某课程的教学方法与习题要求。\n" +
                "要求：800-1200 字；分 4 段：1) 教学方法总论 2) 课堂讲授方法（含案例、互动、启发式）3) 实验/实践教学方法 4) 习题与作业要求。\n" +
                "只输出正文，禁止任何思考过程、标签、解释、前后缀。";
        String user = String.format(
                "课程名称：%s\n适用专业：%s\n总学时：%s\n请撰写 800-1200 字的教学方法说明。",
                n(course.getNameCn()), n(course.getMajor()), str(course.getHours()));
        return chat(sys, user, 2000);
    }

    public String generateTextbooks(Integer courseId) {
        Course course = courseMapper.selectById(courseId);
        if (course == null) return "";
        String sys = "你是教学资料专家。请为给定课程推荐 5-8 本经典教材与参考书。\n" +
                "要求：每本配 30-60 字推荐理由；教材与参考书混合；覆盖基础、核心、前沿、应用。\n" +
                "只输出推荐列表，禁止任何思考过程、标签、解释。";
        String user = String.format(
                "课程名称：%s\n适用专业：%s\n请按「1. 作者，《书名》，出版社，年份 — 推荐理由」格式输出。",
                n(course.getNameCn()), n(course.getMajor()));
        return chat(sys, user, 1500);
    }

    public String generateReferencesList(Integer courseId) {
        Course course = courseMapper.selectById(courseId);
        if (course == null) return "";
        String sys = "你是教学资料专家。请为给定课程推荐 6-10 本参考书与扩展阅读资源。\n" +
                "要求：每本配 30-50 字推荐理由；覆盖 1) 经典著作 2) 前沿研究 3) 工具书/手册 4) 期刊与会议 5) 知名高校公开课。\n" +
                "只输出推荐列表，禁止任何思考过程、标签、解释。";
        String user = String.format(
                "课程名称：%s\n适用专业：%s\n请按「1. 作者/来源，《书名/资源名》，出版社/平台，年份 — 推荐理由」格式输出。",
                n(course.getNameCn()), n(course.getMajor()));
        return chat(sys, user, 1500);
    }

    public String generateMainTask(Integer courseId) {
        Course course = courseMapper.selectById(courseId);
        if (course == null) return "";
        String sys = "你是课程设计专家。请撰写某课程的「主要任务」段落。\n" +
                "要求：200-350 字；说明 1) 课程在专业培养中的定位 2) 学生应完成的核心学习任务 3) 与后续课程的衔接关系 4) 对学生能力提升的预期贡献。\n" +
                "只输出正文，禁止任何思考过程、标签、解释。";
        String user = String.format(
                "课程名称：%s\n适用专业：%s\n总学时：%s\n请撰写 200-350 字的主要任务说明。",
                n(course.getNameCn()), n(course.getMajor()), str(course.getHours()));
        return chat(sys, user, 1000);
    }

    public String generateExerciseRequirements(Integer courseId) {
        Course course = courseMapper.selectById(courseId);
        if (course == null) return "";
        String sys = "你是教学专家。请撰写某课程的「习题要求」段落。\n" +
                "要求：200-350 字；分 3 段：1) 习题类型与覆盖范围 2) 提交与批改要求 3) 学术诚信与查重要求。\n" +
                "只输出正文，禁止任何思考过程、标签、解释。";
        String user = String.format(
                "课程名称：%s\n适用专业：%s\n请撰写 200-350 字的习题要求。",
                n(course.getNameCn()), n(course.getMajor()));
        return chat(sys, user, 1000);
    }

    public String generateAssessmentMethods(Integer courseId) {
        Course course = courseMapper.selectById(courseId);
        if (course == null) return "";
        String sys = "你是课程评价专家。请撰写某课程的「考核方式说明」段落。\n" +
                "要求：250-400 字；分 4 段：1) 总体考核理念 2) 各考核环节与权重（平时/实验/项目/期末） 3) 评分标准 4) 课程目标达成的对应关系。\n" +
                "只输出正文，禁止任何思考过程、标签、解释。";
        String user = String.format(
                "课程名称：%s\n适用专业：%s\n总学时：%s\n请撰写 250-400 字的考核方式说明。",
                n(course.getNameCn()), n(course.getMajor()), str(course.getHours()));
        return chat(sys, user, 1200);
    }

    public String generateAchievementFormula(Integer courseId) {
        Course course = courseMapper.selectById(courseId);
        if (course == null) return "";
        String sys = "你是教学评估专家。请撰写某课程的「课程目标达成度评价」公式说明。\n" +
                "要求：200-350 字；包含 1) 课程分目标达成度计算公式 2) 课程总目标达成度计算公式 3) 各公式中符号含义 4) 评价结果与课程质量的关系。\n" +
                "只输出正文，禁止任何思考过程、标签、解释。";
        String user = String.format(
                "课程名称：%s\n适用专业：%s\n请撰写 200-350 字的达成度计算公式说明。",
                n(course.getNameCn()), n(course.getMajor()));
        return chat(sys, user, 1000);
    }

    public String generateObjectiveDescription(Integer objectiveId) {
        CourseObjective obj = objectiveMapper.selectById(objectiveId);
        if (obj == null) return "";
        Course course = courseMapper.selectById(obj.getCourseId());
        String typeLabel = switch (n(obj.getCategory())) {
            case "knowledge" -> "知识";
            case "ability" -> "能力";
            case "quality" -> "素质";
            default -> "综合";
        };
        String sys = String.format("你是课程目标设计专家。请为指定课程的%s目标写一条详尽描述。\n" +
                "要求：150-250 字；明确 1) 学生应掌握的具体知识点/技能 2) 可衡量的达成标准 3) 与结课要求指标点的支撑关系。\n" +
                "只输出正文，禁止任何思考过程、标签、解释。", typeLabel);
        String user = String.format("课程：%s\n目标编号：%s\n类别：%s\n请写出 150-250 字的详尽描述。",
                course == null ? "" : course.getNameCn(),
                obj.getCode(), typeLabel);
        return chat(sys, user, 800);
    }

    // ============ 质量评价分析字段 ============

    public String generateAttainmentAnalysis(Integer offeringId, Integer objectiveId) {
        if (offeringId == null) return "";
        OfferingAchievementVO ach = achievementEngine.calcForOffering(offeringId);
        if (objectiveId != null) {
            var s = ach.getByObjective().get(objectiveId);
            if (s == null) return "暂无该目标的数据。";
            CourseObjective obj = objectiveMapper.selectById(objectiveId);
            String sys = "你是教学评估专家。请基于实际达成数据，分析该课程目标的达成情况。\n" +
                    "要求：300-500 字；从 1) 达成情况总体判断 2) 达成度与期望值对比 3) 失分/未达成学生特征分析 4) 主要原因 5) 后续改进方向 这 5 个方面详写。\n" +
                    "只输出正文，禁止任何思考过程、标签、解释。";
            String user = String.format("课程目标：%s\n描述：%s\n班级达成度：%s\n达到学生人数：%d / %d\n期望比例：%s\n班级平均：%s\n" +
                            "请撰写 300-500 字的达成情况分析。",
                    s.getCode(), n(s.getDescription()), str(s.getValue()),
                    s.getReachedCount() == null ? 0 : s.getReachedCount(),
                    s.getTotalCount() == null ? 0 : s.getTotalCount(),
                    str(s.getExpectedRatio()), str(s.getAvgScore()));
            return chat(sys, user, 1500);
        } else {
            String sys = "你是教学评估专家。请基于全部目标的达成数据，给出总体达成情况分析。\n" +
                    "要求：500-800 字；分 4 段：1) 整体达成情况 2) 各分目标达成情况对比 3) 主要问题归因 4) 改进建议。\n" +
                    "只输出正文，禁止任何思考过程、标签、解释。";
            StringBuilder data = new StringBuilder();
            for (var e : ach.getByObjective().entrySet()) {
                data.append(String.format("- %s 达成度=%s（%d/%d 学生，期望比例 %s）\n",
                        e.getValue().getCode(), str(e.getValue().getValue()),
                        e.getValue().getReachedCount() == null ? 0 : e.getValue().getReachedCount(),
                        e.getValue().getTotalCount() == null ? 0 : e.getValue().getTotalCount(),
                        str(e.getValue().getExpectedRatio())));
            }
            data.append(String.format("总课程达成度：%s\n", str(ach.getOverallReachedRatio())));
            String user = "数据如下：\n" + data + "\n请撰写 500-800 字的总体达成情况分析。";
            return chat(sys, user, 2000);
        }
    }

    public String generateLastRoundImprovements(Integer offeringId) {
        String sys = "你是教学评估专家。请详细描述上一轮存在问题在本轮课程中的改进措施与效果。\n" +
                "要求：300-500 字；分 3 段：1) 上一轮存在的主要问题 2) 本轮采取的具体改进措施 3) 改进效果与下一步计划。\n" +
                "只输出正文，禁止任何思考过程、标签、解释。";
        String user = String.format("开课ID：%d\n（暂无历史快照对比数据）\n请围绕 1) 学生参与度不足 2) 实验环节较弱 这两个问题，" +
                "撰写 300-500 字的改进措施与效果描述。", offeringId);
        return chat(sys, user, 1500);
    }

    public String generateQualityConclusion(Integer evaluationId) {
        QualityEvaluation eval = evaluationMapper.selectById(evaluationId);
        if (eval == null) return "";
        OfferingAchievementVO ach = achievementEngine.calcForOffering(eval.getOfferingId());
        String sys = "你是课程质量评价专家。请基于全部评价数据，写出课程质量评价的总体结论及改进意见。\n" +
                "要求：500-800 字；分 5 段：1) 课程目标合理性评价 2) 达成情况评价 3) 目标达成有效性 4) 主要问题 5) 改进建议与下轮计划。\n" +
                "只输出正文，禁止任何思考过程、标签、解释。";
        String user = String.format(
                "开课ID：%d\n评价轮次：%s\n目标合理性：%s\n目标含 KAQ：%s\n期望值合理性：%s\n分析合理性：%s\n改进措施合理性：%s\n" +
                        "总达成度：%s\n请撰写 500-800 字的总体结论及改进意见。",
                eval.getOfferingId(), n(eval.getEvalRound()),
                n(eval.getObjectiveIndicatorRationality()),
                n(eval.getObjectiveContainsKaq()),
                n(eval.getExpectedRationality()),
                n(eval.getAnalysisRationality()),
                n(eval.getImprovementRationality()),
                str(ach.getOverallReachedRatio()));
        return chat(sys, user, 2000);
    }

    public String generateExistingIssues(Integer evaluationId) {
        QualityEvaluation eval = evaluationMapper.selectById(evaluationId);
        if (eval == null) return "";
        OfferingAchievementVO ach = achievementEngine.calcForOffering(eval.getOfferingId());

        // 收集学生评价评论
        List<StudentCourseEvaluation> studentEvals = studentEvalMapper.selectList(
                new LambdaQueryWrapper<StudentCourseEvaluation>()
                        .eq(StudentCourseEvaluation::getOfferingId, eval.getOfferingId()));
        StringBuilder comments = new StringBuilder();
        studentEvals.stream()
                .filter(e -> e.getComment() != null && !e.getComment().isBlank())
                .limit(20)
                .forEach(e -> comments.append("- ").append(e.getComment()).append("\n"));

        String sys = "你是教学评估专家。请基于学生评价数据和达成度数据，分析课程存在的主要问题。\n" +
                "要求：300-500 字；从 1) 教学内容方面 2) 教学方法方面 3) 考核方式方面 4) 实践环节方面 分析存在的问题，" +
                "每个方面列出 1-2 个具体问题并给出数据支撑。\n" +
                "只输出正文，禁止任何思考过程、标签、解释。";
        String user = String.format(
                "开课ID：%d\n总达成度：%s\n学生评价数量：%d\n学生文字评价：\n%s\n请分析课程存在的主要问题。",
                eval.getOfferingId(), str(ach.getOverallReachedRatio()),
                studentEvals.size(),
                comments.length() > 0 ? comments.toString() : "（暂无文字评价）");
        return chat(sys, user, 1500);
    }

    public String generateEvaluationValidity(Integer evaluationId) {
        QualityEvaluation eval = evaluationMapper.selectById(evaluationId);
        if (eval == null) return "";

        List<StudentCourseEvaluation> studentEvals = studentEvalMapper.selectList(
                new LambdaQueryWrapper<StudentCourseEvaluation>()
                        .eq(StudentCourseEvaluation::getOfferingId, eval.getOfferingId()));

        int totalCount = studentEvals.size();
        long satisfiedCount = studentEvals.stream()
                .filter(e -> e.getOverallSatisfaction() != null && e.getOverallSatisfaction() >= 4)
                .count();
        double avgSatisfaction = studentEvals.stream()
                .filter(e -> e.getOverallSatisfaction() != null)
                .mapToInt(StudentCourseEvaluation::getOverallSatisfaction)
                .average().orElse(0);

        String sys = "你是教学评估专家。请分析本次课程评价的有效性和代表性。\n" +
                "要求：200-400 字；从 1) 评价样本量与代表性 2) 评价结果的一致性与可信度 3) 评价指标的合理性 三个方面分析。\n" +
                "只输出正文，禁止任何思考过程、标签、解释。";
        String user = String.format(
                "评价人数：%d\n满意（4-5分）人数：%d\n满意度平均分：%.1f\n评价轮次：%s\n请分析本次评价的有效性。",
                totalCount, satisfiedCount, avgSatisfaction, n(eval.getEvalRound()));
        return chat(sys, user, 1200);
    }

    // ============ 私有方法 ============

    private Syllabus getOrCreateSyllabus(Integer courseId) {
        Syllabus syllabus = syllabusMapper.selectOne(new LambdaQueryWrapper<Syllabus>()
                .eq(Syllabus::getCourseId, courseId));
        if (syllabus == null) {
            syllabus = new Syllabus();
            syllabus.setCourseId(courseId);
            syllabus.setVersion(1);
            syllabusMapper.insert(syllabus);
        }
        return syllabus;
    }

    private void replaceChapters(Integer syllabusId, List<SyllabusChapter> chapters) {
        chapterMapper.delete(new LambdaQueryWrapper<SyllabusChapter>()
                .eq(SyllabusChapter::getSyllabusId, syllabusId));
        int order = 0;
        for (SyllabusChapter chapter : chapters) {
            chapter.setChapterId(null);
            chapter.setSyllabusId(syllabusId);
            chapter.setSortOrder(order++);
            chapterMapper.insert(chapter);
        }
    }

    private List<CourseObjective> upsertGeneratedObjectives(Course course, Syllabus syllabus) {
        List<CourseObjective> generated = generateObjectivePlan(course, syllabus);
        List<CourseObjective> existing = objectiveMapper.selectList(new LambdaQueryWrapper<CourseObjective>()
                .eq(CourseObjective::getCourseId, course.getCourseId()));

        if (!existing.isEmpty()) {
            supportMapper.delete(new LambdaQueryWrapper<ObjectiveSupport>()
                    .in(ObjectiveSupport::getObjectiveId,
                            existing.stream().map(CourseObjective::getObjectiveId).collect(Collectors.toList())));
        }

        Map<String, CourseObjective> existingByCode = existing.stream()
                .collect(Collectors.toMap(CourseObjective::getCode, o -> o, (a, b) -> a, LinkedHashMap::new));
        Set<Integer> keepIds = new HashSet<>();
        List<CourseObjective> saved = new ArrayList<>();

        for (int i = 0; i < generated.size(); i++) {
            CourseObjective src = generated.get(i);
            String code = hasText(src.getCode()) ? src.getCode() : "课程目标" + (i + 1);
            CourseObjective target = existingByCode.get(code);
            if (target == null) {
                target = new CourseObjective();
                target.setCourseId(course.getCourseId());
                target.setCode(code);
            }
            target.setCategory(hasText(src.getCategory()) ? src.getCategory() : objectiveCategory(i));
            target.setDescription(safeText(src.getDescription(), fallbackObjectiveDescription(course, i)));
            target.setSortOrder(i);
            if (target.getObjectiveId() == null) {
                objectiveMapper.insert(target);
            } else {
                objectiveMapper.updateById(target);
            }
            keepIds.add(target.getObjectiveId());
            saved.add(target);
        }

        for (CourseObjective old : existing) {
            if (!keepIds.contains(old.getObjectiveId())) {
                objectiveMapper.deleteById(old.getObjectiveId());
            }
        }
        return saved;
    }

    private List<CourseObjective> generateObjectivePlan(Course course, Syllabus syllabus) {
        String sys = "你是课程目标与结课要求矩阵设计专家。请为课程生成 5 条课程目标。" +
                "严格输出 JSON 数组，每个元素含 code、category、description。" +
                "code 使用「课程目标1」到「课程目标5」；category 只能是 knowledge/ability/quality；" +
                "description 120-220 字，必须可衡量、可考核，并体现知识、能力、素质目标。只输出 JSON。";
        String user = String.format(
                "课程名称：%s\n适用专业：%s\n总学时：%s\n知识目标：%s\n能力目标：%s\n素质目标：%s\n请生成完整课程目标。",
                n(course.getNameCn()), n(course.getMajor()), str(course.getHours()),
                n(syllabus.getKnowledgeGoals()), n(syllabus.getAbilityGoals()), n(syllabus.getQualityGoals()));
        List<CourseObjective> parsed = parseObjectives(chat(sys, user, 2500));
        if (parsed.size() >= 5) {
            return parsed.subList(0, 5);
        }
        return fallbackObjectives(course);
    }

    private List<GraduationIndicator> ensureConclusionIndicators(Course course) {
        String major = n(course.getMajor()).trim();
        LambdaQueryWrapper<GraduationRequirement> reqWrapper = new LambdaQueryWrapper<>();
        if (hasText(major)) {
            reqWrapper.and(w -> w.eq(GraduationRequirement::getMajor, major)
                    .or().isNull(GraduationRequirement::getMajor)
                    .or().eq(GraduationRequirement::getMajor, ""));
        }
        reqWrapper.orderByAsc(GraduationRequirement::getCode);
        List<GraduationRequirement> requirements = requirementMapper.selectList(reqWrapper);

        List<GraduationIndicator> indicators = Collections.emptyList();
        if (!requirements.isEmpty()) {
            indicators = indicatorMapper.selectList(new LambdaQueryWrapper<GraduationIndicator>()
                    .in(GraduationIndicator::getRequirementId,
                            requirements.stream().map(GraduationRequirement::getRequirementId).collect(Collectors.toList()))
                    .orderByAsc(GraduationIndicator::getCode));
        }
        if (!indicators.isEmpty()) {
            return indicators;
        }

        GraduationRequirement requirement = new GraduationRequirement();
        requirement.setCode("1");
        requirement.setTitle("课程结课要求");
        requirement.setDescription("学生完成本课程学习后，应在基础知识、工程实践、问题分析、规范意识和持续学习等方面达到本课程结课要求。");
        requirement.setMajor(hasText(major) ? major : null);
        requirementMapper.insert(requirement);

        String[] descriptions = {
                "能够准确理解并说明本课程核心概念、基本原理和关键方法，形成完整的课程知识框架。",
                "能够运用课程知识分析专业问题，完成必要的建模、设计、实现、验证或论证过程。",
                "能够按照规范完成实验、实践、项目或综合训练，记录过程并解释结果。",
                "能够在课程任务中体现工程伦理、质量意识、团队协作和社会责任意识。",
                "能够结合课程反馈持续改进学习方法，具备进一步学习相关专业课程的基础能力。"
        };
        List<GraduationIndicator> created = new ArrayList<>();
        for (int i = 0; i < descriptions.length; i++) {
            GraduationIndicator indicator = new GraduationIndicator();
            indicator.setRequirementId(requirement.getRequirementId());
            indicator.setCode("1." + (i + 1));
            indicator.setDescription(descriptions[i]);
            indicatorMapper.insert(indicator);
            created.add(indicator);
        }
        return created;
    }

    private int replaceObjectiveSupports(List<CourseObjective> objectives, List<GraduationIndicator> indicators) {
        if (objectives.isEmpty() || indicators.isEmpty()) {
            return 0;
        }
        supportMapper.delete(new LambdaQueryWrapper<ObjectiveSupport>()
                .in(ObjectiveSupport::getObjectiveId,
                        objectives.stream().map(CourseObjective::getObjectiveId).collect(Collectors.toList())));

        int count = 0;
        for (int i = 0; i < objectives.size(); i++) {
            CourseObjective objective = objectives.get(i);
            GraduationIndicator primary = indicators.get(i % indicators.size());
            count += insertSupport(objective.getObjectiveId(), primary.getIndicatorId(), 3);

            if (indicators.size() > 1) {
                GraduationIndicator secondary = indicators.get((i + 1) % indicators.size());
                if (!Objects.equals(primary.getIndicatorId(), secondary.getIndicatorId())) {
                    count += insertSupport(objective.getObjectiveId(), secondary.getIndicatorId(), 2);
                }
            }
        }
        return count;
    }

    private int insertSupport(Integer objectiveId, Integer indicatorId, Integer strength) {
        ObjectiveSupport support = new ObjectiveSupport();
        support.setObjectiveId(objectiveId);
        support.setIndicatorId(indicatorId);
        support.setSupportStrength(strength);
        supportMapper.insert(support);
        return 1;
    }

    private int ensureOfferingScoringLinks(Integer courseId, List<CourseObjective> objectives) {
        if (objectives.isEmpty()) return 0;
        List<CourseOffering> offerings = offeringMapper.selectList(new LambdaQueryWrapper<CourseOffering>()
                .eq(CourseOffering::getCourseId, courseId));
        int linkCount = 0;
        for (CourseOffering offering : offerings) {
            List<ScoringItem> items = scoringItemMapper.selectList(new LambdaQueryWrapper<ScoringItem>()
                    .eq(ScoringItem::getOfferingId, offering.getOfferingId())
                    .orderByAsc(ScoringItem::getSortOrder)
                    .orderByAsc(ScoringItem::getItemId));
            if (items.isEmpty()) {
                items = createDefaultScoringItems(offering.getOfferingId());
            }
            if (items.isEmpty()) continue;

            scoringItemObjectiveMapper.delete(new LambdaQueryWrapper<ScoringItemObjective>()
                    .in(ScoringItemObjective::getItemId,
                            items.stream().map(ScoringItem::getItemId).collect(Collectors.toList())));
            BigDecimal perObjective = BigDecimal.ONE.divide(new BigDecimal(objectives.size()), 4, RoundingMode.HALF_UP);
            for (ScoringItem item : items) {
                for (CourseObjective objective : objectives) {
                    ScoringItemObjective link = new ScoringItemObjective();
                    link.setItemId(item.getItemId());
                    link.setObjectiveId(objective.getObjectiveId());
                    link.setWeightInObjective(perObjective);
                    scoringItemObjectiveMapper.insert(link);
                    linkCount++;
                }
            }
        }
        return linkCount;
    }

    private List<ScoringItem> createDefaultScoringItems(Integer offeringId) {
        List<ScoringItem> items = new ArrayList<>();
        items.add(defaultScoringItem(offeringId, "平时作业", "homework", "0.20", 0));
        items.add(defaultScoringItem(offeringId, "实验/实践", "experiment", "0.30", 1));
        items.add(defaultScoringItem(offeringId, "期末考核", "exam", "0.50", 2));
        for (ScoringItem item : items) {
            scoringItemMapper.insert(item);
        }
        return items;
    }

    private ScoringItem defaultScoringItem(Integer offeringId, String name, String type, String weight, int sortOrder) {
        ScoringItem item = new ScoringItem();
        item.setOfferingId(offeringId);
        item.setName(name);
        item.setType(type);
        item.setMaxScore(100);
        item.setPassingScore(70);
        item.setWeight(new BigDecimal(weight));
        item.setSortOrder(sortOrder);
        return item;
    }

    private List<CourseObjective> parseObjectives(String json) {
        if (json == null || json.isBlank()) return Collections.emptyList();
        int start = json.indexOf('[');
        int end = json.lastIndexOf(']');
        if (start < 0 || end < 0) return Collections.emptyList();
        try {
            List<Map<String, Object>> raw = JSON.readValue(json.substring(start, end + 1), new TypeReference<>() {});
            List<CourseObjective> out = new ArrayList<>();
            int order = 0;
            for (Map<String, Object> m : raw) {
                CourseObjective obj = new CourseObjective();
                obj.setCode(getStrAny(m, "code", "目标编号", "课程目标"));
                obj.setCategory(normalizeCategory(getStrAny(m, "category", "类别", "type")));
                obj.setDescription(getStrAny(m, "description", "目标描述", "描述", "content"));
                obj.setSortOrder(order++);
                if (hasText(obj.getDescription())) {
                    out.add(obj);
                }
            }
            return out;
        } catch (Exception e) {
            log.warn("Failed parsing AI objectives JSON: {}", e.getMessage());
            return Collections.emptyList();
        }
    }

    private List<CourseObjective> fallbackObjectives(Course course) {
        List<CourseObjective> list = new ArrayList<>();
        for (int i = 0; i < 5; i++) {
            CourseObjective obj = new CourseObjective();
            obj.setCode("课程目标" + (i + 1));
            obj.setCategory(objectiveCategory(i));
            obj.setDescription(fallbackObjectiveDescription(course, i));
            obj.setSortOrder(i);
            list.add(obj);
        }
        return list;
    }

    private String fallbackObjectiveDescription(Course course, int index) {
        String courseName = n(course.getNameCn());
        String[] descriptions = {
                "能够系统掌握" + courseName + "的基本概念、核心原理、知识结构和典型方法，准确解释课程中的关键术语、基本流程与适用条件，并能够在课堂练习、实验报告和阶段测试中达到可考核要求。",
                "能够运用" + courseName + "相关知识对专业问题进行分析、拆解和建模，选择合适的方法完成方案设计、过程推导或技术实现，并能够说明方案依据、关键步骤和结果合理性。",
                "能够完成" + courseName + "配套实验、上机、实践或综合项目任务，规范记录过程数据，分析实验结果与异常原因，形成结构完整、表达清晰、结论可靠的课程成果。",
                "能够在课程学习和实践任务中体现规范意识、质量意识、工程伦理和团队协作精神，理解课程知识对专业发展、行业应用和社会责任的支撑作用。",
                "能够根据课程反馈持续改进学习策略，查阅教材、参考资料和相关技术文档，完成知识迁移与拓展应用，为后续专业课程学习、课程设计和毕业设计奠定基础。"
        };
        return descriptions[Math.max(0, Math.min(index, descriptions.length - 1))];
    }

    private String objectiveCategory(int index) {
        return switch (index) {
            case 0 -> "knowledge";
            case 1, 2 -> "ability";
            default -> "quality";
        };
    }

    private String normalizeCategory(String raw) {
        String value = n(raw).trim().toLowerCase(Locale.ROOT);
        if (value.contains("ability") || value.contains("能力")) return "ability";
        if (value.contains("quality") || value.contains("素质")) return "quality";
        return "knowledge";
    }

    private List<SyllabusChapter> normalizeChapters(Course course, List<SyllabusChapter> parsed,
                                                     int sections, int totalHours) {
        List<SyllabusChapter> fallback = fallbackChapters(course, sections, totalHours);
        List<SyllabusChapter> out = new ArrayList<>();
        int count = Math.max(sections, parsed.size());
        for (int i = 0; i < count; i++) {
            SyllabusChapter base = i < fallback.size() ? fallback.get(i) : fallback.get(fallback.size() - 1);
            SyllabusChapter src = i < parsed.size() ? parsed.get(i) : new SyllabusChapter();
            SyllabusChapter c = new SyllabusChapter();
            c.setChapterNo(hasText(src.getChapterNo()) ? src.getChapterNo() : base.getChapterNo());
            c.setTopic(hasText(src.getTopic()) ? src.getTopic() : base.getTopic());
            c.setKnowledgeRequirements(hasText(src.getKnowledgeRequirements())
                    ? src.getKnowledgeRequirements() : base.getKnowledgeRequirements());
            c.setIdeologicalElements(hasText(src.getIdeologicalElements())
                    ? src.getIdeologicalElements() : base.getIdeologicalElements());
            c.setRecommendedHours(src.getRecommendedHours() == null || src.getRecommendedHours() <= 0
                    ? base.getRecommendedHours() : src.getRecommendedHours());
            c.setTeachingMethod(hasText(src.getTeachingMethod()) ? src.getTeachingMethod() : base.getTeachingMethod());
            c.setObjectiveRef(hasText(src.getObjectiveRef()) ? src.getObjectiveRef() : base.getObjectiveRef());
            c.setSortOrder(i);
            out.add(c);
        }
        return out;
    }

    private List<SyllabusChapter> fallbackChapters(Course course, int sections, int totalHours) {
        String courseName = hasText(course.getNameCn()) ? course.getNameCn() : "本课程";
        String[] topics = {
                courseName + "课程导论与知识体系",
                courseName + "基础概念、基本原理与方法框架",
                courseName + "核心技术、关键模型与典型流程",
                courseName + "综合设计、实现方法与案例分析",
                courseName + "实验实践、工具应用与结果评价",
                courseName + "复杂问题分析与方案优化",
                courseName + "工程规范、质量控制与团队协作",
                courseName + "综合训练、课程总结与拓展应用",
                courseName + "前沿发展、行业应用与创新实践",
                courseName + "复习提升、目标达成与持续改进"
        };
        List<SyllabusChapter> chapters = new ArrayList<>();
        int safeSections = Math.max(1, sections);
        int baseHours = Math.max(1, totalHours / safeSections);
        int remain = Math.max(0, totalHours - baseHours * safeSections);
        for (int i = 0; i < safeSections; i++) {
            SyllabusChapter c = new SyllabusChapter();
            c.setChapterNo(chapterNo(i));
            c.setTopic(topics[Math.min(i, topics.length - 1)]);
            c.setKnowledgeRequirements("围绕" + c.getTopic() + "展开，要求学生理解本章核心概念、关键原理、典型方法和常见问题，能够结合课堂案例、练习或实验任务完成知识迁移、过程分析和结果解释。");
            c.setIdeologicalElements("融入规范意识、质量意识、工程伦理、团队协作和社会责任，引导学生在解决问题过程中形成严谨、负责、持续改进的专业态度。");
            c.setRecommendedHours(baseHours + (i < remain ? 1 : 0));
            c.setTeachingMethod(defaultTeachingMethod(course, i, safeSections));
            c.setObjectiveRef("课程目标" + Math.min(5, i + 1));
            c.setSortOrder(i);
            chapters.add(c);
        }
        return chapters;
    }

    private String defaultTeachingMethod(Course course, int index, int sections) {
        int labHours = course.getLabHours() == null ? 0 : course.getLabHours();
        if (labHours > 0 && index >= Math.max(1, sections / 2)) {
            return index % 2 == 0 ? "实验" : "上机";
        }
        return index == sections - 1 ? "实践" : "讲授";
    }

    private String chapterNo(int index) {
        String[] cn = {"一", "二", "三", "四", "五", "六", "七", "八", "九", "十"};
        return "第" + cn[Math.min(index, cn.length - 1)] + "章";
    }

    private String safeText(String candidate, String fallback) {
        if (!hasText(candidate)) return fallback;
        String text = cleanGeneratedText(candidate);
        if (text.startsWith("（AI 生成失败") || text.startsWith("（AI 生成异常")) {
            return fallback;
        }
        return hasText(text) ? text : fallback;
    }

    private String fallbackCourseIntro(Course course) {
        String name = hasText(course.getNameCn()) ? course.getNameCn() : "本课程";
        return name + "是面向" + n(course.getMajor()) + "专业教学闭环建设的重要课程，围绕课程基础理论、核心方法、实践训练和综合应用展开。" +
                "课程强调知识体系、能力训练和素质养成的统一，帮助学生理解专业问题的基本规律，掌握解决问题的关键步骤，形成规范表达、严谨分析和持续改进的学习习惯。";
    }

    private String fallbackMainTask(Course course) {
        String name = hasText(course.getNameCn()) ? course.getNameCn() : "本课程";
        return name + "的主要任务是建立完整的课程知识框架，训练学生运用课程理论分析和解决专业问题的能力，并通过课堂练习、实验实践、综合任务和过程评价支撑课程目标达成。";
    }

    private String fallbackGoalText(Course course, String type) {
        String name = hasText(course.getNameCn()) ? course.getNameCn() : "本课程";
        return switch (type) {
            case "ability" -> "1. 能够运用" + name + "的核心方法分析专业问题，完成方案设计、过程实现和结果说明。\n" +
                    "2. 能够结合实验、实践或项目任务进行数据记录、问题定位和结果评价，形成可检查的课程成果。\n" +
                    "3. 能够将课程知识迁移到后续课程、课程设计或综合实践中，支撑复杂问题解决能力培养。";
            case "quality" -> "1. 能够在课程学习中体现规范意识、质量意识、工程伦理和学术诚信。\n" +
                    "2. 能够在团队协作、过程记录和成果表达中保持严谨态度，理解专业知识与社会责任的关系。\n" +
                    "3. 能够根据评价反馈持续改进学习方法，形成自主学习和终身学习意识。";
            default -> "1. 掌握" + name + "的基本概念、核心原理和知识结构，能够准确解释关键术语与基本流程。\n" +
                    "2. 理解课程主要方法的适用条件、操作步骤和评价标准，能够完成基础练习与阶段测试。\n" +
                    "3. 建立课程知识与专业培养目标之间的联系，为后续课程和综合实践奠定基础。";
        };
    }

    private String fallbackTeachingMethods(Course course) {
        return "课程采用课堂讲授、案例分析、实验实践、讨论互动和过程评价相结合的教学方法。课堂教学突出核心概念、关键方法和典型问题；实践环节强调任务驱动、过程记录和结果分析；课后学习通过习题、报告或项目成果巩固知识并支撑课程目标达成。";
    }

    private String fallbackExerciseRequirements(Course course) {
        return "习题与作业围绕课程核心知识点、典型方法和实践任务设置，覆盖基础理解、方法应用和综合分析。学生应按时提交，过程记录完整、结论清晰，实验或项目成果应符合课程规范。所有作业须遵守学术诚信要求，不得抄袭或伪造数据。";
    }

    private String fallbackAssessmentMethods(Course course) {
        return "课程考核采用过程性评价与终结性评价相结合的方式，综合作业、实验实践、项目任务、课堂表现和期末考核等环节。各考核环节围绕课程目标设置评价标准，用于检验学生对知识、能力和素质目标的达成情况。";
    }

    private String fallbackAchievementFormula() {
        return "课程分目标达成度按支撑该目标的各评分项加权得分与加权期望分的比值计算；课程总体达成度综合各课程目标达成情况确定。评价结果用于判断目标达成质量，并作为后续课程改进和教学闭环优化的依据。";
    }

    private String fallbackTextbooks(Course course) {
        String name = hasText(course.getNameCn()) ? course.getNameCn() : "相关课程";
        return "1. 课程组，《" + name + "讲义》，校内教学资料，最新版 — 覆盖课程核心知识与实践任务。\n" +
                "2. 相关领域经典教材，最新版 — 支撑基础理论学习和方法训练。\n" +
                "3. 相关技术手册或规范文档，最新版 — 支撑实验实践、规范表达和综合应用。";
    }

    private String fallbackReferences(Course course) {
        String name = hasText(course.getNameCn()) ? course.getNameCn() : "相关课程";
        return "1. " + name + "相关经典教材与公开课程资源 — 用于补充基础知识和典型案例。\n" +
                "2. 相关领域期刊、会议论文和行业报告 — 用于了解前沿发展与应用场景。\n" +
                "3. 相关工具文档、标准规范和实践指南 — 用于支撑实验、项目和综合训练。";
    }

    private String chat(String sysPrompt, String userMsg, int maxTokens) {
        try {
            LlmProvider provider = llmFactory.getDefaultProvider();
            LlmProvider.LlmConfig config = llmFactory.buildConfig(null);
            LlmProvider.LlmConfig sized = new LlmProvider.LlmConfig(
                    config.apiKey(), config.baseUrl(), config.modelName(),
                    maxTokens, 0.7);

            List<Map<String, Object>> msgs = new ArrayList<>();
            Map<String, Object> m = new HashMap<>();
            m.put("role", "user");
            m.put("content", userMsg);
            msgs.add(m);

            Map<String, Object> result = provider.chatWithTools(sysPrompt, msgs, null, sized);
            if (result == null) return "（AI 生成失败：无响应）";
            Object type = result.get("type");
            if ("error".equals(type)) {
                log.warn("AI assist LLM error: {}", result.get("message"));
                return "（AI 生成失败：" + n((String) result.get("message")) + "）";
            }
            String content = (String) result.getOrDefault("content", "");
            return stripMarkdownEnvelope(stripThinkTags(content));
        } catch (Exception e) {
            log.error("AI assist chat error", e);
            return "（AI 生成异常：" + e.getMessage() + "）";
        }
    }

    /**
     * 剥离模型思考过程标签
     * MiniMax 系列模型在 content 中可能直接暴露 <think>...<think>/> 或 <think>...</think>
     * 兼容：<think>...</think>、<think>...<think>/>、<think>...<think/>
     */
    private static final java.util.regex.Pattern THINK_TAG =
            java.util.regex.Pattern.compile("<think>[\\s\\S]*?(?:</think>|<think>\\s*/>\\s*|<think\\s*/>\\s*)",
                    java.util.regex.Pattern.CASE_INSENSITIVE);

    private String stripThinkTags(String content) {
        if (content == null || content.isEmpty()) return content;
        // 多轮清理直到没有匹配（处理嵌套/多段）
        String prev;
        String cur = content;
        int safety = 5;
        do {
            prev = cur;
            cur = THINK_TAG.matcher(cur).replaceAll("");
        } while (!cur.equals(prev) && --safety > 0);
        return cur.trim();
    }

    private String stripMarkdownEnvelope(String content) {
        if (content == null || content.isEmpty()) return "";
        String text = content.replace("\r\n", "\n").replace('\r', '\n');
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
        text = text.replaceAll("\\$+", "");
        return trimLines(text);
    }

    private String cleanGeneratedText(String content) {
        String text = stripMarkdownEnvelope(stripThinkTags(content));
        text = text.replace("\\left", "").replace("\\right", "");
        text = text.replaceAll("\\\\frac\\s*\\{([^{}]+)}\\s*\\{([^{}]+)}", "$1 / $2");
        text = text.replace("\\times", " x ").replace("\\cdot", " x ").replace("\\sum", "sum");
        text = text.replaceAll("([A-Za-z])_\\{?([A-Za-z0-9]+)\\}?", "$1$2");
        text = text.replaceAll("\\^\\{([^{}]+)}", "^$1");
        text = text.replaceAll("\\$+", "");
        text = text.replace("{", "").replace("}", "");
        text = text.replaceAll("\\\\[A-Za-z]+", "");
        text = text.replace("*", "");
        return trimLines(text);
    }

    private String trimLines(String content) {
        if (content == null || content.isEmpty()) return "";
        StringBuilder out = new StringBuilder();
        for (String line : content.split("\\n")) {
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

    private List<SyllabusChapter> parseChapters(String json) {
        if (json == null || json.isBlank()) return Collections.emptyList();
        // 提取首个 JSON 数组（LLM 有时会带 ```json 包裹）
        int start = json.indexOf('[');
        int end = json.lastIndexOf(']');
        if (start < 0 || end < 0) return Collections.emptyList();
        String arr = json.substring(start, end + 1);
        try {
            List<Map<String, Object>> raw = JSON.readValue(arr, new TypeReference<>() {});
            List<SyllabusChapter> out = new ArrayList<>();
            int order = 0;
            for (Map<String, Object> m : raw) {
                SyllabusChapter c = new SyllabusChapter();
                c.setChapterNo(getStrAny(m, "chapterNo", "chapter_no", "章节号", "章节序号"));
                c.setTopic(getStrAny(m, "topic", "title", "教学内容", "主题"));
                c.setKnowledgeRequirements(getStrAny(m, "knowledgeRequirements", "knowledge_requirements", "知识能力要求", "教学要求"));
                c.setIdeologicalElements(getStrAny(m, "ideologicalElements", "ideological_elements", "思政元素", "课程思政"));
                c.setRecommendedHours(getIntAny(m, "recommendedHours", "recommended_hours", "学时", "推荐学时"));
                c.setTeachingMethod(getStrAny(m, "teachingMethod", "teaching_method", "教学方式", "教学方法"));
                c.setObjectiveRef(getStrAny(m, "objectiveRef", "objective_ref", "对应课程目标", "课程目标"));
                c.setSortOrder(order++);
                out.add(c);
            }
            return out;
        } catch (Exception e) {
            log.warn("Failed parsing AI chapters JSON: {}", e.getMessage());
            return Collections.emptyList();
        }
    }

    private String getStr(Map<String, Object> m, String k) {
        Object v = m.get(k);
        return v == null ? "" : v.toString();
    }

    private String getStrAny(Map<String, Object> m, String... keys) {
        for (String key : keys) {
            String value = getStr(m, key);
            if (hasText(value)) return value;
        }
        return "";
    }

    private Integer getInt(Map<String, Object> m, String k) {
        Object v = m.get(k);
        if (v == null) return null;
        if (v instanceof Number n) return n.intValue();
        try {
            return Integer.parseInt(v.toString());
        } catch (Exception e) {
            return null;
        }
    }

    private Integer getIntAny(Map<String, Object> m, String... keys) {
        for (String key : keys) {
            Integer value = getInt(m, key);
            if (value != null) return value;
        }
        return null;
    }

    private boolean hasText(String s) {
        return s != null && !s.trim().isEmpty();
    }

    private String n(String s) { return s == null ? "" : s; }
    private String str(Object o) { return o == null ? "" : o.toString(); }
}
