# 课程教学闭环模块设计文档（Course Teaching Loop, CTL）

> **版本**：v1.0 · **日期**：2026-06-12 · **作者**：opencode-agent
> **范围**：完整教学闭环 MVP（课程大纲→课程目标→评分项→成绩录入→达成度→课程质量评价）
> **参考文档**：`D:\workfordasan\Class-docs\课程大纲.pdf` / `课程质量评价资料汇编.pdf` / `课程分组及成绩明细表.xlsx`

---

## 0. 决策摘要（已与用户确认）

| # | 决策点 | 选择 |
|---|--------|------|
| 1 | 本轮交付范围 | 全闭环 MVP（不含 KG 修复、不含 KG↔目标关联） |
| 2 | 课程实体建模 | 双层：`t_course` (模板) + `t_course_offering` (开课实例) |
| 3 | 评分项建模 | 独立 `t_scoring_item` 层，引用现有 homework/experiment/exam |
| 4 | 毕业要求建模 | 三层：`t_graduation_requirement` → `t_graduation_indicator` → `t_course_objective` |
| 5 | 课程质量评价 | 教师自评 + 系统自动生成 4 张报告 |
| 6 | 实施路径 | Approach B 端到端切片（6 个 vertical slice） |

---

## 1. 总体架构

### 1.1 教学闭环 → 切片映射

| 切片 | 教学环节 | 新增表 | 新增 Controller | 新前端页面 |
|------|---------|--------|----------------|----------|
| **S1** | 课程大纲拟定 | `t_course`、`t_course_offering`、`t_syllabus`、`t_syllabus_chapter` | `CourseController`、`CourseOfferingController`、`SyllabusController` | CourseList、CourseEdit、OfferingList、SyllabusEditor |
| **S2** | 课程目标设定 | `t_graduation_requirement`、`t_graduation_indicator`、`t_course_objective`、`t_objective_support` | `GraduationRequirementController`、`CourseObjectiveController` | GRManager、IndicatorManager、ObjectiveEditor、SupportMatrix |
| **S3** | 评分项设定 | `t_scoring_item`、`t_scoring_item_objective` | `ScoringItemController` | ScoringItemConfig、WeightMatrix |
| **S4** | 成绩录入(增强) | `t_scoring_score` | `ScoringScoreController` | GradeEntryV2（单/批/Excel 导入） |
| **S5** | 达成度计算 | `t_achievement_snapshot` | `AchievementController` | AchievementDashboard（教师）、MyAchievementDashboard（学生） |
| **S6** | 课程质量评价 | `t_quality_evaluation` | `QualityEvaluationController`、`QualityReportController` | EvaluationForm、4ReportViewer |

**总计**：12 张新表、8 个新 Controller、12+ 个前端页面/组件、25+ API。

### 1.2 系统分层

```
┌──────────────────────────────────────────────────────┐
│  前端 (Vue 3 + Element Plus + Vite 5)               │
│  ├─ teacher/course/ (S1)                            │
│  ├─ teacher/objective/ (S2)                         │
│  ├─ teacher/scoring/ (S3)                           │
│  ├─ teacher/grading/GradeEntryV2.vue (S4)           │
│  ├─ teacher/achievement/ (S5)                       │
│  ├─ teacher/quality/ (S6)                           │
│  └─ student/achievement/MyDashboard.vue (S5)        │
├──────────────────────────────────────────────────────┤
│  后端 (Spring Boot 3.2 + MyBatis-Plus 3.5)          │
│  ├─ controller/teaching/ (8 个新 Controller)         │
│  ├─ service/teaching/ (8 个 Service)                 │
│  │   ├─ AchievementCalcEngine ★ 核心算法            │
│  │   └─ QualityReportGenerator ★ 4 报告生成         │
│  ├─ entity/teaching/ (12 个 Entity)                  │
│  ├─ mapper/teaching/ (12 个 Mapper)                  │
│  ├─ dto/teaching/ (16 个 DTO)                        │
│  └─ vo/teaching/ (8 个 VO)                           │
├──────────────────────────────────────────────────────┤
│  数据库 (MySQL 8.0)                                  │
│  └─ 12 张新表（通过 SchemaCompatibilityInitializer） │
└──────────────────────────────────────────────────────┘
```

### 1.3 与现有系统的集成方式

| 现有概念 | 集成方式 | 是否修改 |
|---------|---------|---------|
| `t_clazz` 班级 | 通过 `t_course_offering.clazz_id` 关联 | 不动 |
| `t_homework`、`t_experiment`、`t_exam` | 评分项以 `(source_table, source_id)` 引用 | 不动 |
| `t_score` 实验总分 | 保留现有行为；新增 `t_scoring_score` 存评分项级 | 不动 |
| `t_student_question`/`t_student_item`/`t_student_homework_question` 答题记录 | 达成度引擎自动汇总到 `t_scoring_score` | 不动 |
| 知识图谱 KG | 本轮不打通课程目标↔KP | 不动 |

---

## 2. 数据库 ER 设计

### 2.1 ER 总览

```
┌──────────────┐  N:M  ┌──────────────────────┐  N:M  ┌────────────────────┐
│ t_graduation │◄─────►│ t_graduation_        │◄─────►│ t_course_objective │
│ _requirement │       │ indicator (5.1,5.2..)│       │ (本课程目标 1/2)   │
└──────────────┘       └──────────────────────┘       └─────────┬──────────┘
                                                                 │ N:M (t_objective_support)
                                                                 │ + 1:N
┌─────────────────────┐ 1:N ┌──────────────────────┐ 1:N ┌──────▼──────────────┐
│ t_course (课程模板) │────►│ t_course_offering    │────►│ t_scoring_item      │
│ - name/code/credit  │     │ - course_id          │     │ - offering_id       │
│ - hours/major       │     │ - clazz_id           │     │ - source_table      │
│ - intro             │     │ - teacher_id         │     │ - source_id         │
└──────────┬──────────┘     │ - semester           │     │ - max_score         │
           │ 1:1            │ - status             │     │ - passing_score(70) │
           │                └──────────┬───────────┘     │ - weight            │
           │                           │ 1:1             └──────┬──────────────┘
┌──────────▼─────────┐                 │                        │ 1:N
│ t_syllabus         │                 │                        │
│ - course_id        │                 │                        ▼
│ - intro/goal/...   │                 │                ┌────────────────┐
└──────────┬─────────┘                 │                │ t_scoring_     │
           │ 1:N                       │                │ score          │
┌──────────▼──────────┐                │                │ - scoring_item │
│ t_syllabus_chapter  │                │                │ - student_id   │
│ - syllabus_id       │                │                │ - score        │
│ - chapter_no        │                │                └────────────────┘
│ - topic             │                │
│ - knowledge_req     │                │
│ - hours             │                ▼
│ - method            │       ┌──────────────────────────┐   1:N
│ - objective_ref     │       │ t_achievement_snapshot   │
└─────────────────────┘       │ - offering_id            │
                              │ - student_id / NULL=班级 │
                              │ - objective_id           │
                              │ - achievement_value      │
                              │ - reached_count          │
                              │ - total_count            │
                              │ - calc_time              │
                              └──────────────────────────┘
                                       │ 1:N
                              ┌────────▼──────────────────┐
                              │ t_quality_evaluation       │
                              │ - offering_id              │
                              │ - eval_round               │
                              │ - objective_rationality    │
                              │ - contains_knowledge_abil  │
                              │ - achievement_analysis     │
                              │ - improvement_plan         │
                              │ - last_round_issues        │
                              │ - this_round_improvements  │
                              │ - conclusion               │
                              └────────────────────────────┘
```

### 2.2 详细字段（按表）

#### 2.2.1 `t_graduation_requirement` 毕业要求

| 字段 | 类型 | 说明 |
|------|------|------|
| id | BIGINT PK | 主键 |
| code | VARCHAR(16) UQ | 编号（"5"） |
| title | VARCHAR(255) | 名称（"使用现代工具"） |
| description | TEXT | 详细描述 |
| major | VARCHAR(64) | 适用专业 |
| created_at / updated_at | DATETIME | 时间戳 |
| deleted | TINYINT | 逻辑删除 |

#### 2.2.2 `t_graduation_indicator` 毕业要求指标点

| 字段 | 类型 | 说明 |
|------|------|------|
| id | BIGINT PK | 主键 |
| requirement_id | BIGINT FK→`t_graduation_requirement` | 所属毕业要求 |
| code | VARCHAR(16) | 编号（"5.1"） |
| description | TEXT | 描述（"理解软件工程专业常用现代工程工具…"） |
| created_at / updated_at | DATETIME | 时间戳 |
| deleted | TINYINT | 逻辑删除 |

#### 2.2.3 `t_course` 课程（模板）

| 字段 | 类型 | 说明 |
|------|------|------|
| id | BIGINT PK | 主键 |
| code | VARCHAR(32) UQ | 课程编号 |
| name_cn | VARCHAR(128) | 中文名 |
| name_en | VARCHAR(255) | 英文名 |
| credit | DECIMAL(3,1) | 学分 |
| hours | INT | 总学时 |
| theory_hours | INT | 理论学时 |
| lab_hours | INT | 实验学时 |
| major | VARCHAR(64) | 适用专业 |
| prerequisite | VARCHAR(255) | 先修课程 |
| department | VARCHAR(64) | 开课系 |
| intro | TEXT | 课程简介 |
| owner_id | BIGINT FK→`t_teacher` | 课程负责人 |
| created_at / updated_at | DATETIME | 时间戳 |
| deleted | TINYINT | 逻辑删除 |

#### 2.2.4 `t_course_offering` 开课实例

| 字段 | 类型 | 说明 |
|------|------|------|
| id | BIGINT PK | 主键 |
| course_id | BIGINT FK→`t_course` | 所属课程 |
| clazz_id | BIGINT FK→`t_clazz` | 班级 |
| teacher_id | BIGINT FK→`t_teacher` | 任课教师 |
| semester | VARCHAR(16) | 学期（"2022-2023-1"） |
| student_count | INT | 学生人数（缓存） |
| status | VARCHAR(16) | 状态（draft/active/finished/archived） |
| created_at / updated_at | DATETIME | 时间戳 |
| deleted | TINYINT | 逻辑删除 |

**唯一约束**：`(course_id, clazz_id, semester)`。

#### 2.2.5 `t_syllabus` 课程大纲

| 字段 | 类型 | 说明 |
|------|------|------|
| id | BIGINT PK | 主键 |
| course_id | BIGINT FK→`t_course` UQ | 一门课一份大纲 |
| course_intro | TEXT | 课程简介 |
| main_task | TEXT | 主要任务 |
| knowledge_goals | TEXT | 知识目标（JSON 数组） |
| ability_goals | TEXT | 能力目标 |
| quality_goals | TEXT | 素质目标 |
| teaching_methods | TEXT | 教学方法（讲授/实验/习题） |
| exercise_requirements | TEXT | 习题要求 |
| assessment_methods | TEXT | 考核方式总述 |
| achievement_formula | TEXT | 达成度计算公式说明（默认自动生成） |
| textbooks | TEXT | 推荐教材（JSON 数组） |
| references_list | TEXT | 参考书（JSON 数组） |
| version | INT DEFAULT 1 | 大纲版本号 |
| created_at / updated_at | DATETIME | 时间戳 |
| deleted | TINYINT | 逻辑删除 |

#### 2.2.6 `t_syllabus_chapter` 大纲章节（教学内容）

| 字段 | 类型 | 说明 |
|------|------|------|
| id | BIGINT PK | 主键 |
| syllabus_id | BIGINT FK→`t_syllabus` | 所属大纲 |
| chapter_no | VARCHAR(16) | 章节号（"第一章"） |
| topic | VARCHAR(255) | 教学内容主题 |
| knowledge_requirements | TEXT | 知识/能力教学要求 |
| ideological_elements | TEXT | 思政元素 |
| recommended_hours | INT | 推荐学时 |
| teaching_method | VARCHAR(32) | 教学方式（讲授/实验/上机） |
| objective_ref | VARCHAR(64) | 对应课程目标（"课程目标 1,2"，逗号分隔编号） |
| sort_order | INT | 排序 |
| created_at / updated_at | DATETIME | 时间戳 |
| deleted | TINYINT | 逻辑删除 |

#### 2.2.7 `t_course_objective` 课程目标

| 字段 | 类型 | 说明 |
|------|------|------|
| id | BIGINT PK | 主键 |
| course_id | BIGINT FK→`t_course` | 所属课程 |
| code | VARCHAR(16) | 编号（"课程目标 1"） |
| category | VARCHAR(16) | 类别（knowledge/ability/quality） |
| description | TEXT | 描述 |
| sort_order | INT | 排序 |
| created_at / updated_at | DATETIME | 时间戳 |
| deleted | TINYINT | 逻辑删除 |

**唯一约束**：`(course_id, code)`。

#### 2.2.8 `t_objective_support` 课程目标 ↔ 毕业要求指标点

| 字段 | 类型 | 说明 |
|------|------|------|
| id | BIGINT PK | 主键 |
| objective_id | BIGINT FK→`t_course_objective` | 课程目标 |
| indicator_id | BIGINT FK→`t_graduation_indicator` | 毕业要求指标点 |
| support_strength | TINYINT DEFAULT 1 | 支撑强度（H=3/M=2/L=1） |
| created_at | DATETIME | 时间戳 |
| deleted | TINYINT | 逻辑删除 |

**唯一约束**：`(objective_id, indicator_id)`。

#### 2.2.9 `t_scoring_item` 评分项

| 字段 | 类型 | 说明 |
|------|------|------|
| id | BIGINT PK | 主键 |
| offering_id | BIGINT FK→`t_course_offering` | 所属开课 |
| name | VARCHAR(64) | 名称（"作业 1"、"实验 1"、"期末"） |
| type | VARCHAR(16) | 类型（homework/experiment/exam/project/other） |
| source_table | VARCHAR(32) NULL | 引用表名（"t_homework"等） |
| source_id | BIGINT NULL | 引用 ID（NULL 表示纯虚拟评分项） |
| max_score | INT DEFAULT 100 | 满分 |
| passing_score | INT DEFAULT 70 | 期望及格分（参考文档示例 70） |
| weight | DECIMAL(5,4) | 权重（0.0500） |
| sort_order | INT | 排序 |
| created_at / updated_at | DATETIME | 时间戳 |
| deleted | TINYINT | 逻辑删除 |

**校验规则**：同一 offering 下所有 `weight` 之和 = 1.0000（在 service 层校验，UI 实时显示）。

#### 2.2.10 `t_scoring_item_objective` 评分项 ↔ 课程目标

| 字段 | 类型 | 说明 |
|------|------|------|
| id | BIGINT PK | 主键 |
| scoring_item_id | BIGINT FK→`t_scoring_item` | 评分项 |
| objective_id | BIGINT FK→`t_course_objective` | 课程目标 |
| weight_in_objective | DECIMAL(5,4) | 该评分项在目标内的权重（一个评分项可挂多个目标） |
| created_at | DATETIME | 时间戳 |
| deleted | TINYINT | 逻辑删除 |

**唯一约束**：`(scoring_item_id, objective_id)`。

#### 2.2.11 `t_scoring_score` 评分项得分

| 字段 | 类型 | 说明 |
|------|------|------|
| id | BIGINT PK | 主键 |
| scoring_item_id | BIGINT FK→`t_scoring_item` | 评分项 |
| student_id | BIGINT FK→`t_student` | 学生 |
| score | DECIMAL(6,2) | 得分（NULL = 缺考） |
| source | VARCHAR(16) | 来源（manual/imported/calculated） |
| graded_by | BIGINT FK→`t_teacher` NULL | 录入教师 |
| created_at / updated_at | DATETIME | 时间戳 |
| deleted | TINYINT | 逻辑删除 |

**唯一约束**：`(scoring_item_id, student_id)`。

#### 2.2.12 `t_achievement_snapshot` 达成度快照

| 字段 | 类型 | 说明 |
|------|------|------|
| id | BIGINT PK | 主键 |
| offering_id | BIGINT FK→`t_course_offering` | 开课 |
| student_id | BIGINT FK→`t_student` NULL | NULL=班级聚合 |
| objective_id | BIGINT FK→`t_course_objective` NULL | NULL=课程总目标 |
| achievement_value | DECIMAL(6,4) | 达成度值（0.7857） |
| weighted_score | DECIMAL(6,2) | 加权得分（学生级） |
| weighted_max | DECIMAL(6,2) | 加权满分（学生级） |
| reached_count | INT NULL | 达到学生人数（班级级） |
| total_count | INT NULL | 参与学生总数（班级级） |
| calc_time | DATETIME | 计算时间 |
| version | INT | 版本号（支持历史快照） |

**唯一约束**：`(offering_id, student_id, objective_id, version)`。

#### 2.2.13 `t_quality_evaluation` 课程质量评价

| 字段 | 类型 | 说明 |
|------|------|------|
| id | BIGINT PK | 主键 |
| offering_id | BIGINT FK→`t_course_offering` | 开课 |
| evaluator_id | BIGINT FK→`t_teacher` | 评价人（=任课教师） |
| eval_round | VARCHAR(16) | 评价轮次（"2022-2023-1-Round1"） |
| course_responsible | VARCHAR(64) | 课程负责人 |
| course_members | TEXT | 课程组成员（JSON） |
| eval_group_members | TEXT | 评价小组成员（JSON，本版本仅显示） |
| objective_indicator_rationality | VARCHAR(16) | 课程目标与指标点对应合理性（reasonable/relatively/unreasonable） |
| objective_contains_kaq | VARCHAR(16) | 目标是否含知识/能力/素质（contain/partial/none） |
| achievement_values | TEXT | 各目标达成值（JSON：{"1":0.78,"2":0.83}） |
| expected_rationality | VARCHAR(16) | 期望值合理性 |
| analysis_rationality | VARCHAR(16) | 达成情况分析合理性 |
| improvement_rationality | VARCHAR(16) | 改进措施合理性 |
| existing_issues | TEXT | 课程存在的问题 |
| evaluation_validity | TEXT | 达成评价有效性说明 |
| last_round_improvements | TEXT | 上一轮问题改进情况 |
| conclusion_and_suggestions | TEXT | 评价结论及改进意见 |
| status | VARCHAR(16) DEFAULT 'draft' | 状态（draft/finalized） |
| created_at / updated_at | DATETIME | 时间戳 |
| deleted | TINYINT | 逻辑删除 |

### 2.3 SchemaCompatibilityInitializer 集成方式

按 AGENTS.md 规定，**所有 DDL 通过 `SchemaCompatibilityInitializer.java` 在启动时执行**，绝不写独立 migration 文件。

具体追加 12 个 `createTableIfMissing` 调用（按 S1→S6 顺序），并对现有表无任何 alter。

---

## 3. 核心算法：达成度计算引擎

### 3.1 计算公式（来自 `课程大纲.pdf` 第 3 页 + 成绩明细表.xlsx）

#### 3.1.1 学生个体层

```
对于学生 s、课程目标 o，达成度计算：

  S(s, o)   = Σ over (i ∈ scoring_items_of_o) [ score(s, i) × weight(i) ]
  M(o)      = Σ over (i ∈ scoring_items_of_o) [ max_score(i) × weight(i) ]
  Ach(s, o) = S(s, o) / M(o)

其中 weight(i) 已归一化（权重之和=1.0）；
若 score(s, i) IS NULL（缺考），按 0 计入分子（不可配置，与示例 Excel 一致），分母 M(o) 不变。
```

**示例**（参考 Excel 成绩明细表 行 155）：
- 学生 1 的目标 1 = 已知达成度 0.785714 = `Σ(各环节得分 × 0.05) / (满分×0.05)`
- 当 8 个环节满分 100×0.05 = 4×7 + 28 = 28，分子 ≈ 22

#### 3.1.2 课程总目标层

```
对于学生 s：
  Total(s) = Σ over (o) [ Ach(s, o) × Σ weight(i) for i in o ]
           = Σ (i in all_items) [ score(s, i) × weight(i) ] / 100

注：因为 Σ_o weight(o) = 1.0，所以可直接累加所有评分项加权分。
```

#### 3.1.3 班级聚合层（用于评价报告）

```
对于课程目标 o（在 offering 内）：
  ClassAch(o) = 达到期望分值学生数 / 参与评价学生总数

  reached_count = COUNT(s WHERE Ach(s, o) × max_total >= passing_total)
  total_count   = COUNT(s 参与评价)

实际等价于：
  ClassAch(o) = COUNT(Ach(s, o) >= 期望比例) / COUNT(s)
  期望比例 = passing_score / max_score  （示例：70/100 = 0.7）
```

#### 3.1.4 课程总达成度

```
CourseTotalAch = COUNT(Total(s) >= 0.6) / COUNT(s)   ★ 60 = 总成绩及格线
```

### 3.2 达成度引擎 AchievementCalcEngine 接口

```java
public interface AchievementCalcEngine {
    /** 计算单个学生在所有目标上的达成度 */
    List<AchievementVO> calcForStudent(Long offeringId, Long studentId);

    /** 计算开课级班级聚合 */
    List<AchievementVO> calcForOffering(Long offeringId);

    /** 触发快照保存（写 t_achievement_snapshot） */
    void snapshot(Long offeringId, String reason);

    /** 拉取历史快照 */
    List<AchievementSnapshotVO> getSnapshots(Long offeringId, Long objectiveId);

    /** 拉取当前（最新计算结果，不写库） */
    AchievementMatrixVO getCurrentMatrix(Long offeringId);
}
```

### 3.3 触发时机

- **手动**：教师在 `AchievementController.recalc(offeringId)` 显式触发
- **自动**：评分项得分有变更时，标记 offering 为"待重算"（Redis 缓存），下次查询时懒计算
- **快照**：教师"完成评价"时强制写一次快照（用于评价报告锁定）

### 3.4 权重校验规则

- **评分项内**：`Σ weight = 1.0`（offering 维度），允许 ±0.0001 误差
- **目标内**：`Σ weight_in_objective` 可任意，但报告会标注
- **校验时机**：评分项编辑 / 评价开始前

---

## 4. 后端 API 设计

### 4.1 路由总览（25 个核心 API）

#### S1 课程 + 大纲
- `GET    /api/teacher/course/list` — 课程列表（owner=当前教师）
- `POST   /api/teacher/course` — 新建课程
- `PUT    /api/teacher/course/{id}` — 编辑课程
- `DELETE /api/teacher/course/{id}` — 删除课程
- `GET    /api/teacher/course/{id}` — 课程详情
- `GET    /api/teacher/offering/list?courseId=` — 开课列表
- `POST   /api/teacher/offering` — 新建开课（绑定 course + clazz + teacher + semester）
- `GET    /api/teacher/syllabus/{courseId}` — 获取课程大纲
- `PUT    /api/teacher/syllabus/{courseId}` — 保存大纲
- `POST   /api/teacher/syllabus/{courseId}/chapter` — 添加章节
- `PUT    /api/teacher/syllabus/chapter/{id}` — 更新章节
- `DELETE /api/teacher/syllabus/chapter/{id}` — 删除章节

#### S2 毕业要求 + 课程目标
- `GET    /api/teacher/gr/list` — 毕业要求列表
- `POST   /api/teacher/gr` — 新建毕业要求
- `POST   /api/teacher/gr/{id}/indicator` — 添加指标点
- `GET    /api/teacher/objective/list?courseId=` — 课程目标列表
- `POST   /api/teacher/objective` — 新建课程目标
- `PUT    /api/teacher/objective/{id}` — 编辑课程目标
- `POST   /api/teacher/objective/{id}/support` — 绑定指标点

#### S3 评分项
- `GET    /api/teacher/scoring/list?offeringId=` — 评分项列表
- `POST   /api/teacher/scoring` — 新建评分项（自动校验权重和）
- `PUT    /api/teacher/scoring/{id}` — 编辑
- `DELETE /api/teacher/scoring/{id}` — 删除
- `POST   /api/teacher/scoring/{id}/objective` — 绑定课程目标
- `GET    /api/teacher/scoring/template?offeringId=` — 获取按目标排布的模板

#### S4 成绩录入
- `POST   /api/teacher/scoring-score` — 单条录入
- `POST   /api/teacher/scoring-score/batch` — 批量录入（一次提交多个 (student_id, score)）
- `POST   /api/teacher/scoring-score/import` — Excel 导入（按成绩明细表模板）
- `GET    /api/teacher/scoring-score/list?offeringId=&itemId=` — 成绩查询
- `GET    /api/teacher/scoring-score/matrix?offeringId=` — 学生×评分项矩阵
- `GET    /api/teacher/scoring-score/template?offeringId=` — Excel 模板下载

#### S5 达成度
- `POST   /api/teacher/achievement/recalc?offeringId=` — 显式重算
- `GET    /api/teacher/achievement/student?offeringId=&studentId=` — 学生达成度
- `GET    /api/teacher/achievement/offering?offeringId=` — 开课聚合
- `GET    /api/student/achievement/me?offeringId=` — 学生看自己
- `POST   /api/teacher/achievement/snapshot?offeringId=` — 创建快照

#### S6 评价 + 报告
- `POST   /api/teacher/quality-evaluation` — 创建评价
- `PUT    /api/teacher/quality-evaluation/{id}` — 保存草稿
- `POST   /api/teacher/quality-evaluation/{id}/finalize` — 终稿
- `GET    /api/teacher/quality-report/grade-stat?offeringId=` — 成绩统计表（自动）
- `GET    /api/teacher/quality-report/consistency?offeringId=` — 考核合理性审核表
- `GET    /api/teacher/quality-report/attainment?offeringId=` — 达成情况评价报告
- `GET    /api/teacher/quality-report/quality?evaluationId=` — 课程质量评价表
- `GET    /api/teacher/quality-report/export?offeringId=&format=pdf|excel` — 导出

### 4.2 统一响应包装

按现有 `Result<T>` 包装（`code=0` 表示成功）：

```json
{ "code": 0, "msg": "success", "data": { ... } }
```

### 4.3 权限

按 AGENTS.md，使用 `@PreAuthorize("hasRole('TEACHER')")`，学生端 API 用 `@PreAuthorize("hasRole('STUDENT')")`。

---

## 5. 前端设计

### 5.1 路由扩展

```typescript
// frontend/src/router/index.js 中追加
const teachingRoutes = [
  // S1
  { path: 'course', component: () => import('@/views/teacher/course/CourseList.vue') },
  { path: 'course/:id/edit', component: () => import('@/views/teacher/course/CourseEdit.vue') },
  { path: 'course/:id/syllabus', component: () => import('@/views/teacher/course/SyllabusEditor.vue') },
  { path: 'offering', component: () => import('@/views/teacher/course/OfferingList.vue') },
  // S2
  { path: 'objective/gr', component: () => import('@/views/teacher/objective/GRManager.vue') },
  { path: 'objective/:courseId', component: () => import('@/views/teacher/objective/ObjectiveEditor.vue') },
  // S3
  { path: 'scoring/:offeringId', component: () => import('@/views/teacher/scoring/ScoringItemConfig.vue') },
  // S4 (增强已有 Score.vue → 新增 GradeEntryV2)
  { path: 'grading-v2/:offeringId', component: () => import('@/views/teacher/grading/GradeEntryV2.vue') },
  // S5
  { path: 'achievement/:offeringId', component: () => import('@/views/teacher/achievement/AchievementDashboard.vue') },
  // S6
  { path: 'quality/:offeringId', component: () => import('@/views/teacher/quality/EvaluationForm.vue') },
  { path: 'quality/:offeringId/reports', component: () => import('@/views/teacher/quality/ReportViewer.vue') },
];

// 学生端
{ path: 'achievement', component: () => import('@/views/student/achievement/MyAchievementDashboard.vue') }
```

### 5.2 API 客户端扩展

在 `frontend/src/api/index.js` 中新增：

```javascript
// 课程
export const courseApi = {
  list: () => http.get('/teacher/course/list'),
  detail: (id) => http.get(`/teacher/course/${id}`),
  create: (data) => http.post('/teacher/course', data),
  update: (id, data) => http.put(`/teacher/course/${id}`, data),
  remove: (id) => http.delete(`/teacher/course/${id}`),
};

// 开课
export const offeringApi = { ... };
export const syllabusApi = { ... };
export const grApi = { ... };
export const objectiveApi = { ... };
export const scoringApi = { ... };
export const scoringScoreApi = { ... };
export const achievementApi = { ... };
export const qualityApi = { ... };
export const qualityReportApi = { ... };
```

### 5.3 关键 UI 设计

#### 5.3.1 课程目标 ↔ 毕业要求支撑矩阵（S2）

```
                指标点 5.1   指标点 5.2   ...
课程目标 1       [✓]H          [ ]          ...
课程目标 2       [✓]M          [ ]          ...
```

#### 5.3.2 评分项 + 目标 + 权重矩阵（S3）

```
                                目标 1   目标 2   合计权重
作业 1                            0.05     -        0.05
作业 2                            0.05     -        0.05
实验 1                            0.05     -        0.05
...
大作业 1                          -        0.10     0.10
期末                              0.40    0.10     0.50
─────────────────────────────────────────────────
目标内权重和                      0.40     0.60     1.0 ✓
```

#### 5.3.3 达成度仪表板（S5）

- 教师端：班级达成度雷达图 + 学生明细表 + 历史趋势
- 学生端：自己各目标达成值 + 达成与否标签

---

## 6. 4 张评价报告自动生成

### 6.1 表 1：成绩统计表

```
教研室         | 软件工程教研室
课程名称       | XX 编程
任课教师       | 张三
授课班级       | 2023 软工 1 班
期望值         | 70
成绩分布       | (100-90: 5 人) (89-80: 12 人) ...
平均分         | 78.3
最高分         | 95
最低分         | 56
及格率         | 92.5%
正态分布       | ✓
```

**数据源**：`t_scoring_score` 聚合所有评分项加权得分

### 6.2 表 2：考核合理性审核表

```
课程名称       | XX 编程
开课学期       | 2022-2023-1
课程负责人     | 张三
...
考核合理性
─────────────────────────────────────────────────
课程目标 1   | 考核内容: 作业 1-5 + 期末
              考核方式: 平时 + 笔试
              考核分值: 40
              合理性: ✓
课程目标 2   | ...
```

**数据源**：`t_scoring_item` + `t_scoring_item_objective`

### 6.3 表 3：课程目标达成情况评价报告

完整复现参考文档第 4-6 页结构：
- 一、课程基本信息（取自 `t_course` + `t_course_offering` + `t_teacher`）
- 二、课程目标 ↔ 毕业要求对应关系（取自 `t_objective_support`）
- 三、考核方式分值分配（取自 `t_scoring_item` 按 type 聚合）
- 四、合理性分析（教师在 `t_quality_evaluation` 填写）
- 五、达成情况：5.1 主要考核数据 + 5.2 各课程目标达成情况
- 六、达成评价分析（教师填写）
- 七、上一轮问题及改进效果（教师填写）
- 八、下一轮改进措施（教师填写）

### 6.4 表 4：课程质量评价表

完整复现参考文档第 7-8 页结构：
- 基本信息 + 评价小组成员
- 评价项目（4 项）：
  - 课程目标合理性（含 2 子项）
  - 课程目标达成情况（含 5 子项）
- 评价结论及意见（教师填写）

### 6.5 报告生成器接口

```java
public interface QualityReportGenerator {
    GradeStatReportVO gradeStat(Long offeringId);
    ConsistencyReportVO consistency(Long offeringId);
    AttainmentReportVO attainment(Long offeringId, Long evaluationId);
    QualityReportVO quality(Long evaluationId);

    /** 导出 PDF/Excel */
    byte[] exportPdf(Long offeringId, ReportType type);
    byte[] exportExcel(Long offeringId, ReportType type);
}
```

### 6.6 导出实现

- PDF：使用 iText 7 或现有项目已有的工具（探索中确认）
- Excel：使用 Apache POI（项目已通过 openpyxl/POI 处理 Excel）
- 模板：`backend/src/main/resources/report-templates/`

---

## 7. 与现有系统集成

### 7.1 评分项自动建议

教师建立开课时，系统扫描该 clazz_id 下已有的：
- `t_homework`：自动建议每个作业作为一个评分项（作业 1-N）
- `t_experiment`：自动建议每个实验作为评分项（实验 1-N）
- `t_exam`：自动建议每场考试作为评分项

**前端 UI**：S3 评分项页面提供「从已有作业/实验/考试一键导入」按钮。

### 7.2 成绩自动同步

当 `t_scoring_item.source_table != NULL` 时：
- 后台任务（每晚 02:30 或手动触发）从原始作业/实验/考试成绩聚合到 `t_scoring_score`
- 教师可在 GradeEntryV2 看到「已同步：78 / 80 人」状态并手动覆盖

### 7.3 与原 `t_score`（实验总分）的关系

- 不动 `t_score` 表
- 评分项类型为 `experiment` 且 `source_table='t_experiment'` 时，`t_scoring_score.score` 自动从对应的 `t_score.score` 计算
- 教师手动录入仍可覆盖

---

## 8. 测试策略

### 8.1 后端

按 AGENTS.md，后端 `src/test/` 当前为空。本轮我们**新增最关键的 3 个测试**（不强求覆盖率）：

- `AchievementCalcEngineTest`：验证算法用 Excel 行 155 的数据（学生 1 目标 1 达成度 = 0.7857）
- `WeightValidationTest`：验证评分项权重和 = 1.0 的校验
- `QualityReportGeneratorTest`：用 mock 数据验证 4 报告字段不为空

### 8.2 前端

按 AGENTS.md，frontend 已有 Vitest + jsdom 设置。新增：

- `ScoringItemConfig.test.js`：验证权重和实时计算
- `AchievementDashboard.test.js`：验证基本渲染

### 8.3 验收（手动）

- 全流程：建课 → 大纲 → 目标 → 评分项 → 成绩 → 达成度 → 评价
- 数据契合度：用参考文档 Excel 的样例数据导入，对比达成度计算结果是否一致

---

## 9. 验收标准（DoD）

- [ ] **S1**：教师能创建课程、编辑大纲（含 9 节模板）、查看大纲，至少 1 个开课实例
- [ ] **S2**：教师能录入毕业要求 + 指标点；为课程添加 ≥ 2 个目标；为目标绑定指标点
- [ ] **S3**：教师能为开课配置 ≥ 5 个评分项；权重和校验通过；可绑目标
- [ ] **S4**：教师能单/批/Excel 导入成绩；可下载与示例文件同构的 Excel 模板
- [ ] **S5**：教师/学生能看到个体目标达成度（含数值与是否达到期望值）；班级聚合达成度可视化
- [ ] **S6**：教师能填写评价表 + 自动生成 4 张报告 + 导出 PDF
- [ ] **算法验证**：用参考文档 Excel 样例数据，达成度计算结果误差 < 0.001
- [ ] **集成不破坏**：原 t_homework/t_experiment/t_exam/t_score 不动，回归测试现有功能
- [ ] **DDL 集成**：所有 12 张新表通过 `SchemaCompatibilityInitializer` 启动时自动建/迁
- [ ] **角色权限**：教师 API 用 `@PreAuthorize('hasRole(\\'TEACHER\\')')`，学生 API 同理
- [ ] **API 契约**：所有 API 返回统一 `Result<T>` 包装

---

## 10. 风险与缓解

| 风险 | 缓解措施 |
|------|---------|
| 12 张表与现有表同步 | 全部新增、不动现有表；DDL 通过 SchemaCompatibilityInitializer |
| 达成度算法误差 | 用参考文档 Excel 样例数据做单元测试基准 |
| 4 报告生成性能 | 报告 = 实时计算；当数据量大时降级为读快照 |
| Excel 导入与示例文件不一致 | 完全复现成绩明细表.xlsx 列结构（行 145-154）作为标准模板 |
| 教师重复配置评分项 | 「一键从已有作业/实验/考试导入」简化操作 |

---

## 11. 后续轮次（不在本轮范围）

按 brainstorming 决策 #1，以下功能留待后续：

- [ ] KG 推荐 bug 修复（goToPractice 直跳题目 + errorRate 按 KP 分组）
- [ ] 课程目标 ↔ 知识点 关联（让达成度引擎可以基于 KP 掌握度间接评估）
- [ ] 课程评价小组多人评议（评价小组成员独立填表 + 汇总）
- [ ] 学生评教问卷（学生端反向评价）
- [ ] 跨学期达成度对比可视化
- [ ] 课程目标达成度的 LLM 文字分析（自动写"达成情况分析"段落）

---

## 附录 A：参考文档关键截图引用

- 课程大纲.pdf 第 1 页"基本信息" → `t_course`
- 课程大纲.pdf 第 1 页"课程目标对毕业要求的支撑关系" → `t_objective_support`
- 课程大纲.pdf 第 2 页"教学内容与课程目标关系" → `t_syllabus_chapter`
- 课程大纲.pdf 第 3 页"课程目标达成度评价" → AchievementCalcEngine 公式
- 课程质量评价资料汇编.pdf 第 2-3 页"成绩统计表/考核合理性表" → 报告 1/2
- 课程质量评价资料汇编.pdf 第 4-6 页"达成情况评价报告" → 报告 3
- 课程质量评价资料汇编.pdf 第 7-8 页"课程质量评价表" → 报告 4
- 课程分组及成绩明细表.xlsx Sheet2 → 评分项权重 + 达成度算法基准
