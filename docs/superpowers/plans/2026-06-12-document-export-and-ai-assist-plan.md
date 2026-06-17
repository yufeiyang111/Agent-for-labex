# 文档导出 + LLM 辅助填写 — 实施增补 Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development to implement this plan task-by-task.
> **Spec reference:** docs/superpowers/specs/2026-06-12-course-teaching-loop-design.md (CTL 主 spec)
> **本 plan 关系**：CTL 主功能已完成，本 plan 增补 3 个文档导出 + LLM 辅助填写。

**Goal:** 按 Class-docs 3 个参考文档模板生成「课程大纲.pdf / 成绩明细.xlsx / 质量评价资料汇编.pdf」，并提供预览/下载接口与 LLM 辅助填写。

**Architecture:** 复用 PDFBox 2.0.30（已配置中文字体回退）+ POI XSSFWorkbook + 项目已有 LlmProviderFactory。3 个生成器 + 1 个 AI Assistant + 2 个 Controller + 前端 1 组件 + 3 页面集成。

**Tech Stack:** Spring Boot 3.2 / PDFBox 2.0.30 / Apache POI 5.x / LangChain4j / Vue 3 / Element Plus

---

## 关键决策（已确认）

| # | 决策 | 选择 |
|---|------|------|
| 1 | PDF 生成 | PDFBox 纯代码绘制（复用现有字体回退） |
| 2 | LLM 调用 | 复用 LlmProviderFactory.getDefaultProvider() + buildConfig(null) |
| 3 | Excel 预览 | 后端同时返回 JSON（结构化）+ 二进制（下载） |

---

## 文件结构

```
backend/src/main/java/com/labex/service/teaching/export/
├── PdfDrawingHelper.java                 NEW (通用工具：字体加载、行绘制、表格绘制)
├── SyllabusPdfGenerator.java             NEW (大纲 PDF, 9 节)
├── GradeDetailExcelGenerator.java        NEW (成绩明细 Excel, 2 sheet)
└── QualityCompendiumPdfGenerator.java    NEW (质量评价汇编 PDF, 4 表)

backend/src/main/java/com/labex/service/teaching/ai/
└── SyllabusAiAssistant.java              NEW (LLM 辅助填写)

backend/src/main/java/com/labex/vo/teaching/
└── GradeDetailMatrixVO.java              NEW (成绩明细完整结构 - 用于 JSON 预览)

backend/src/main/java/com/labex/controller/teaching/
├── DocumentExportController.java         NEW (6 个预览/下载端点)
└── AiAssistController.java               NEW (LLM 辅助接口)

frontend/src/components/
└── PdfPreviewDialog.vue                  NEW (统一 PDF 预览 dialog)

frontend/src/views/teacher/course/SyllabusEditor.vue                MODIFY (加 3 按钮)
frontend/src/views/teacher/grading/GradeEntryV2.vue                 MODIFY (加 2 按钮)
frontend/src/views/teacher/quality/EvaluationForm.vue               MODIFY (加 3 按钮)
frontend/src/api/index.js                                            MODIFY (加 exportApi/aiAssistApi)
```

---

## Task 1: PdfDrawingHelper + SyllabusPdfGenerator

**Files:**
- Create: `backend/src/main/java/com/labex/service/teaching/export/PdfDrawingHelper.java`
- Create: `backend/src/main/java/com/labex/service/teaching/export/SyllabusPdfGenerator.java`

**输入:**
- courseId
- 自动 join: `Course + Syllabus + SyllabusChapter[] + CourseObjective[] + ObjectiveSupport[] + GraduationIndicator[] + GraduationRequirement[]`

**输出:** byte[] (PDF)

**布局（按 Class-docs/课程大纲.pdf 模板）:**
1. 标题 + 【课程编号】
2. (一) 基本信息表（中/英文名、编号、学分、学时、专业、先修、开课系、执笔、审核、简介）
3. (二) 课程目标（知识/能力/素质 3 段 + 支撑关系矩阵表）
4. (三) 教学内容与课程目标的关系（序号|内容|要求|思政|学时|方式|对应目标）
5. (四) 实践教学安排（项目|名称|学时|类型|要求|每组人数）
6. (五) 教学方法与习题要求
7. (六) 考核方式及成绩评定（作业/实验/考试 - 取自评分项汇总）
8. (七) 达成度评价公式
9. (八) 推荐教材
10. (九) 学时分配（章节学时表 + 合计）

**PdfDrawingHelper 公共方法:**
```java
public PDFont loadChineseFont(PDDocument doc);
public float drawText(PDPageContentStream cs, String text, float x, float y, float fontSize, PDFont font);
public float drawWrappedText(PDPageContentStream cs, String text, float x, float y, float maxWidth, float fontSize, float lineHeight, PDFont font);
public float drawSectionTitle(PDPageContentStream cs, String title, float x, float y);
public float drawTable(PDPageContentStream cs, String[][] data, float[] colWidths, float x, float y, float rowHeight);
public PDPage newPageIfNeeded(PDDocument doc, PDPage current, float currentY, float minY);
```

## Task 2: GradeDetailExcelGenerator

**Files:**
- Create: `backend/src/main/java/com/labex/service/teaching/export/GradeDetailExcelGenerator.java`
- Create: `backend/src/main/java/com/labex/vo/teaching/GradeDetailMatrixVO.java`

**输入:** offeringId

**输出:** 
- byte[] (xlsx)  — 用于下载
- GradeDetailMatrixVO  — 用于 JSON 预览

**Sheet 1: 分组信息（保留模板结构，学生数据来自 t_student WHERE clazz_no）**

**Sheet 2: 成绩明细表（严格复现 Class-docs/课程分组及成绩明细表.xlsx 行 145-197）:**
- Row 1: 标题（合并 A1:U1） "南昌航空大学学生课程目标达成度计算表"
- Row 2: "开课学期：xxx 课程：xxx 教师：xxx 班级：xxx"
- Row 3: 第一级表头（序号|学号|姓名|毕业要求 5.1|...|平时成绩（占 50%）|期末成绩（占 50%）|总成绩）
- Row 4: 第二级表头（按目标分组：课程目标 1 跨多列、课程目标 2 跨多列）
- Row 5: 第三级表头（评分项名: 作业 1...实验 1...大作业 1...达成度）
- Row 6: 满分分值
- Row 7: 达成及格期望分值
- Row 8: 权重
- Row 9: 加权分值（passing×weight）
- Row 10+: 学生数据
- 倒数第 3 行: 平均分
- 倒数第 2 行: 达成期望分值的学生人数
- 倒数第 1 行: 课程目标达成度

## Task 3: QualityCompendiumPdfGenerator

**Files:**
- Create: `backend/src/main/java/com/labex/service/teaching/export/QualityCompendiumPdfGenerator.java`

**输入:** offeringId, evaluationId

**输出:** byte[] (单个 PDF 含 4 张表，按 Class-docs/课程质量评价资料汇编.pdf 模板)

**布局（每张表独立 page）:**
- Page 1-2: 资料 1 - 成绩统计表（取 gradeStat）
- Page 3-4: 资料 2 - 考核合理性审核表（取 consistency）
- Page 5-8: 资料 3 - 课程目标达成情况评价报告（取 attainment, 8 节内容）
- Page 9-10: 资料 4 - 课程质量评价表（取 quality）

复用现有 QualityReportGenerator 的 VO 数据（gradeStat/consistency/attainment/quality）。

## Task 4: SyllabusAiAssistant

**Files:**
- Create: `backend/src/main/java/com/labex/service/teaching/ai/SyllabusAiAssistant.java`

**接口:**
```java
String generateCourseIntro(Integer courseId);
String generateGoals(Integer courseId, String type); // type: knowledge/ability/quality
List<SyllabusChapter> generateChapters(Integer courseId);
String generateTeachingMethods(Integer courseId);
String generateTextbooks(Integer courseId);
String generateObjectiveDescription(Integer objectiveId);
String generateAttainmentAnalysis(Integer offeringId, Integer objectiveId);
String generateLastRoundImprovements(Integer offeringId);
String generateQualityConclusion(Integer evaluationId);
```

**实现细节:**
- 调 `llmFactory.getDefaultProvider().chatWithTools(sysPrompt, msgs, null, config)`
- 每个方法：构造 system prompt + 上下文消息 → 调 LLM → 提取 `content` 字符串返回
- 失败时返回提示性占位文本（不抛异常）

## Task 5: DocumentExportController

**Files:**
- Create: `backend/src/main/java/com/labex/controller/teaching/DocumentExportController.java`

**端点（6 个，全部 @PreAuthorize("hasRole('TEACHER')")）:**
- `GET /teacher/export/syllabus/preview?courseId=` → application/pdf inline
- `GET /teacher/export/syllabus/download?courseId=` → application/pdf attachment
- `GET /teacher/export/grade-detail/preview-json?offeringId=` → JSON 结构（GradeDetailMatrixVO）
- `GET /teacher/export/grade-detail/download?offeringId=` → xlsx
- `GET /teacher/export/quality-compendium/preview?offeringId=&evaluationId=` → PDF inline
- `GET /teacher/export/quality-compendium/download?...` → PDF attachment

## Task 6: AiAssistController

**Files:**
- Create: `backend/src/main/java/com/labex/controller/teaching/AiAssistController.java`

**端点（5-9 个）:**
- `POST /teacher/ai-assist/syllabus/intro?courseId=` → {content:"..."}
- `POST /teacher/ai-assist/syllabus/goals?courseId=&type=knowledge|ability|quality`
- `POST /teacher/ai-assist/syllabus/chapters?courseId=` → 列表
- `POST /teacher/ai-assist/syllabus/methods?courseId=`
- `POST /teacher/ai-assist/syllabus/textbooks?courseId=`
- `POST /teacher/ai-assist/objective/{id}/description`
- `POST /teacher/ai-assist/quality/attainment-analysis?offeringId=&objectiveId=`
- `POST /teacher/ai-assist/quality/conclusion?evaluationId=`

## Task 7: 前端 PdfPreviewDialog + 3 页面集成

**Files:**
- Create: `frontend/src/components/PdfPreviewDialog.vue`
- Modify: `frontend/src/api/index.js` (加 exportApi/aiAssistApi)
- Modify: `frontend/src/views/teacher/course/SyllabusEditor.vue`
- Modify: `frontend/src/views/teacher/grading/GradeEntryV2.vue`
- Modify: `frontend/src/views/teacher/quality/EvaluationForm.vue`

**PdfPreviewDialog.vue:**
```vue
<el-dialog v-model="visible" :title="title" width="90%" top="5vh">
  <iframe :src="pdfUrl" style="width:100%;height:75vh;border:none"></iframe>
  <template #footer>
    <el-button @click="onDownload">下载</el-button>
    <el-button @click="visible=false">关闭</el-button>
  </template>
</el-dialog>
```

**SyllabusEditor 加按钮:**
- 顶部工具栏：`[AI 自动填写]` `[预览大纲 PDF]` `[下载大纲 PDF]`
- 课程简介 textarea 旁：`[✨ AI 生成]` 按钮
- 知识/能力/素质目标 textarea 旁：`[✨ AI 生成]`
- 推荐教材 textarea 旁：`[✨ AI 生成]`

**GradeEntryV2 加按钮:** 顶部 `[预览成绩明细 Excel]` `[下载成绩明细 Excel]`

**EvaluationForm 加按钮:** 顶部 `[AI 辅助填写]` `[预览汇编 PDF]` `[下载汇编 PDF]`，textarea 旁加 `[✨ AI 生成]`

## Task 8: 编译验证

```bash
cd backend; mvn compile -q
cd backend; mvn test -Dtest=AchievementCalcEngineTest
cd frontend; npm run build
```

---

## Self-Review

- ✅ 3 个生成器对齐 Class-docs 3 个模板的字段
- ✅ LLM 复用现有 OpenAiCompatibleProvider，零新依赖
- ✅ PDF 字体复用现有回退（Windows msyh 优先）
- ✅ Excel 同时支持下载与 JSON 预览（用户决策 #3）
- ✅ 所有按钮集成进现有 3 页面
- ✅ 复用现有 QualityReportGenerator 数据源（不重复算）
