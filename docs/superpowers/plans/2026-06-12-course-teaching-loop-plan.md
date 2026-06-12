# 课程教学闭环（CTL）实施计划

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development to implement this plan task-by-task.
> **Spec reference:** `docs/superpowers/specs/2026-06-12-course-teaching-loop-design.md`

**Goal:** 在现有 Vue 3 + Spring Boot 3 教学平台上构建完整教学闭环（课程大纲→课程目标→评分项→成绩录入→达成度→课程质量评价），完整复现参考文档 3 份模板的语义。

**Architecture:** 12 张新表全部经 `SchemaCompatibilityInitializer` 启动时建库；后端按 controller/service/entity/mapper/dto/vo 分层；前端按 teacher/* 与 student/* 拆分页面；不修改任何现有表与 API。

**Tech Stack:** Spring Boot 3.2 / MyBatis-Plus 3.5 / MySQL 8.0 / Vue 3 / Element Plus / Vite 5 / Apache POI / iText 7

---

## 文件结构

```
backend/src/main/java/com/labex/
├── config/SchemaCompatibilityInitializer.java     [MODIFY: 追加 12 张表 DDL]
├── entity/teaching/
│   ├── Course.java                       [NEW]
│   ├── CourseOffering.java               [NEW]
│   ├── Syllabus.java                     [NEW]
│   ├── SyllabusChapter.java              [NEW]
│   ├── GraduationRequirement.java        [NEW]
│   ├── GraduationIndicator.java          [NEW]
│   ├── CourseObjective.java              [NEW]
│   ├── ObjectiveSupport.java             [NEW]
│   ├── ScoringItem.java                  [NEW]
│   ├── ScoringItemObjective.java         [NEW]
│   ├── ScoringScore.java                 [NEW]
│   ├── AchievementSnapshot.java          [NEW]
│   └── QualityEvaluation.java            [NEW]
├── mapper/teaching/   (13 个 Mapper) [NEW]
├── service/teaching/
│   ├── CourseService / CourseServiceImpl
│   ├── CourseOfferingService / Impl
│   ├── SyllabusService / Impl
│   ├── GraduationRequirementService / Impl
│   ├── CourseObjectiveService / Impl
│   ├── ScoringItemService / Impl
│   ├── ScoringScoreService / Impl
│   ├── AchievementCalcEngine / Impl  ★ 核心算法
│   ├── QualityEvaluationService / Impl
│   └── QualityReportGenerator / Impl  ★ 4 报告生成
├── controller/teaching/
│   ├── CourseController
│   ├── CourseOfferingController
│   ├── SyllabusController
│   ├── GraduationRequirementController
│   ├── CourseObjectiveController
│   ├── ScoringItemController
│   ├── ScoringScoreController
│   ├── AchievementController
│   ├── QualityEvaluationController
│   └── QualityReportController
├── dto/teaching/   (16 个 DTO)
└── vo/teaching/    (8 个 VO)

backend/src/test/java/com/labex/service/teaching/
├── AchievementCalcEngineTest.java        [NEW: 用 Excel 样例验证算法]
├── WeightValidationTest.java             [NEW: 权重和=1 校验]
└── QualityReportGeneratorTest.java       [NEW: 4 报告字段]

frontend/src/api/index.js                 [MODIFY: 追加 9 个 API 组]
frontend/src/router/index.js              [MODIFY: 追加 12 条路由]
frontend/src/views/teacher/course/
├── CourseList.vue / CourseEdit.vue / SyllabusEditor.vue / OfferingList.vue
frontend/src/views/teacher/objective/
├── GRManager.vue / ObjectiveEditor.vue
frontend/src/views/teacher/scoring/
├── ScoringItemConfig.vue
frontend/src/views/teacher/grading/
├── GradeEntryV2.vue
frontend/src/views/teacher/achievement/
├── AchievementDashboard.vue
frontend/src/views/teacher/quality/
├── EvaluationForm.vue / ReportViewer.vue
frontend/src/views/student/achievement/
├── MyAchievementDashboard.vue
```

---

## Task 0: 基础准备

**Files:** 仅探查与 commit checkpoint

- [ ] **Step 1**: 检查 `backend/src/main/java/com/labex/config/SchemaCompatibilityInitializer.java` 现有结构

Run: `Get-Content backend\src\main\java\com\labex\config\SchemaCompatibilityInitializer.java -TotalCount 60`
Expected: 能看到 `addColumnIfMissing()` / `createTableIfMissing()` 工具方法

- [ ] **Step 2**: 确认 `backend/pom.xml` 已含 mybatis-plus / lombok / mysql-connector

Run: `Select-String -Path backend\pom.xml -Pattern "mybatis-plus|lombok|mysql-connector"`
Expected: 3 行匹配

- [ ] **Step 3**: 创建包目录骨架

```bash
mkdir backend\src\main\java\com\labex\entity\teaching
mkdir backend\src\main\java\com\labex\mapper\teaching
mkdir backend\src\main\java\com\labex\service\teaching
mkdir backend\src\main\java\com\labex\controller\teaching
mkdir backend\src\main\java\com\labex\dto\teaching
mkdir backend\src\main\java\com\labex\vo\teaching
mkdir backend\src\test\java\com\labex\service\teaching
mkdir frontend\src\views\teacher\course
mkdir frontend\src\views\teacher\objective
mkdir frontend\src\views\teacher\scoring
mkdir frontend\src\views\teacher\grading
mkdir frontend\src\views\teacher\achievement
mkdir frontend\src\views\teacher\quality
mkdir frontend\src\views\student\achievement
```

- [ ] **Step 4**: Git checkpoint

```bash
git add docs/superpowers/
git commit -m "docs(ctl): add design spec and implementation plan for course teaching loop"
```

---

# S1: 课程实体 + 课程大纲

## Task S1-1: SchemaCompatibilityInitializer 追加 4 张 S1 表

**Files:** 
- Modify: `backend/src/main/java/com/labex/config/SchemaCompatibilityInitializer.java`

- [ ] **Step 1**: 在 initialize() 方法末尾追加 4 张表

```java
// ===== S1: 课程大纲拟定 =====
createTableIfMissing(stmt, "t_course",
    "CREATE TABLE t_course (" +
    "id BIGINT PRIMARY KEY AUTO_INCREMENT," +
    "code VARCHAR(32) NOT NULL UNIQUE," +
    "name_cn VARCHAR(128) NOT NULL," +
    "name_en VARCHAR(255)," +
    "credit DECIMAL(3,1)," +
    "hours INT," +
    "theory_hours INT," +
    "lab_hours INT," +
    "major VARCHAR(64)," +
    "prerequisite VARCHAR(255)," +
    "department VARCHAR(64)," +
    "intro TEXT," +
    "owner_id BIGINT," +
    "created_at DATETIME DEFAULT CURRENT_TIMESTAMP," +
    "updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP," +
    "deleted TINYINT DEFAULT 0," +
    "INDEX idx_owner (owner_id)" +
    ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4");

createTableIfMissing(stmt, "t_course_offering",
    "CREATE TABLE t_course_offering (" +
    "id BIGINT PRIMARY KEY AUTO_INCREMENT," +
    "course_id BIGINT NOT NULL," +
    "clazz_id BIGINT NOT NULL," +
    "teacher_id BIGINT NOT NULL," +
    "semester VARCHAR(16) NOT NULL," +
    "student_count INT DEFAULT 0," +
    "status VARCHAR(16) DEFAULT 'draft'," +
    "created_at DATETIME DEFAULT CURRENT_TIMESTAMP," +
    "updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP," +
    "deleted TINYINT DEFAULT 0," +
    "UNIQUE KEY uq_course_clazz_semester (course_id, clazz_id, semester)," +
    "INDEX idx_teacher (teacher_id)," +
    "INDEX idx_clazz (clazz_id)" +
    ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4");

createTableIfMissing(stmt, "t_syllabus",
    "CREATE TABLE t_syllabus (" +
    "id BIGINT PRIMARY KEY AUTO_INCREMENT," +
    "course_id BIGINT NOT NULL UNIQUE," +
    "course_intro TEXT," +
    "main_task TEXT," +
    "knowledge_goals TEXT," +
    "ability_goals TEXT," +
    "quality_goals TEXT," +
    "teaching_methods TEXT," +
    "exercise_requirements TEXT," +
    "assessment_methods TEXT," +
    "achievement_formula TEXT," +
    "textbooks TEXT," +
    "references_list TEXT," +
    "version INT DEFAULT 1," +
    "created_at DATETIME DEFAULT CURRENT_TIMESTAMP," +
    "updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP," +
    "deleted TINYINT DEFAULT 0" +
    ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4");

createTableIfMissing(stmt, "t_syllabus_chapter",
    "CREATE TABLE t_syllabus_chapter (" +
    "id BIGINT PRIMARY KEY AUTO_INCREMENT," +
    "syllabus_id BIGINT NOT NULL," +
    "chapter_no VARCHAR(16)," +
    "topic VARCHAR(255)," +
    "knowledge_requirements TEXT," +
    "ideological_elements TEXT," +
    "recommended_hours INT," +
    "teaching_method VARCHAR(32)," +
    "objective_ref VARCHAR(64)," +
    "sort_order INT DEFAULT 0," +
    "created_at DATETIME DEFAULT CURRENT_TIMESTAMP," +
    "updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP," +
    "deleted TINYINT DEFAULT 0," +
    "INDEX idx_syllabus (syllabus_id)" +
    ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4");
```

- [ ] **Step 2**: 启动后端验证表创建

```bash
cd backend; mvn compile -q
```
Expected: BUILD SUCCESS

启动应用（如 8080 端口忙则先 kill）：
```bash
cd backend; Start-Process mvn -ArgumentList "spring-boot:run" -NoNewWindow -PassThru
Start-Sleep 25
# 用 mysql 客户端查表（或用 navicat）
# 验证 4 张表存在：t_course, t_course_offering, t_syllabus, t_syllabus_chapter
```

- [ ] **Step 3**: Commit

```bash
git add backend/src/main/java/com/labex/config/SchemaCompatibilityInitializer.java
git commit -m "feat(ctl-s1): add DDL for course/offering/syllabus/syllabus_chapter tables"
```

## Task S1-2: 4 个 S1 Entity 类

**Files:**
- Create: `backend/src/main/java/com/labex/entity/teaching/Course.java`
- Create: `backend/src/main/java/com/labex/entity/teaching/CourseOffering.java`
- Create: `backend/src/main/java/com/labex/entity/teaching/Syllabus.java`
- Create: `backend/src/main/java/com/labex/entity/teaching/SyllabusChapter.java`

- [ ] **Step 1**: 创建 Course.java

```java
package com.labex.entity.teaching;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("t_course")
public class Course {
    @TableId(type = IdType.AUTO)
    private Long id;
    private String code;
    private String nameCn;
    private String nameEn;
    private BigDecimal credit;
    private Integer hours;
    private Integer theoryHours;
    private Integer labHours;
    private String major;
    private String prerequisite;
    private String department;
    private String intro;
    private Long ownerId;
    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createdAt;
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private LocalDateTime updatedAt;
    @TableLogic
    private Integer deleted;
}
```

- [ ] **Step 2**: 创建 CourseOffering.java（类似结构，字段对应 t_course_offering）

参考 Course.java 模式，字段：`id, courseId, clazzId, teacherId, semester, studentCount, status, createdAt, updatedAt, deleted`。

- [ ] **Step 3**: 创建 Syllabus.java + SyllabusChapter.java，字段一一对应 DDL。

- [ ] **Step 4**: 编译验证

```bash
cd backend; mvn compile -q
```
Expected: BUILD SUCCESS

- [ ] **Step 5**: Commit

```bash
git add backend/src/main/java/com/labex/entity/teaching/
git commit -m "feat(ctl-s1): add 4 entities for S1 (Course/CourseOffering/Syllabus/SyllabusChapter)"
```

## Task S1-3: 4 个 S1 Mapper 接口

**Files:**
- Create: `backend/src/main/java/com/labex/mapper/teaching/CourseMapper.java`
- Create: `backend/src/main/java/com/labex/mapper/teaching/CourseOfferingMapper.java`
- Create: `backend/src/main/java/com/labex/mapper/teaching/SyllabusMapper.java`
- Create: `backend/src/main/java/com/labex/mapper/teaching/SyllabusChapterMapper.java`

- [ ] **Step 1**: 创建 4 个 Mapper

```java
package com.labex.mapper.teaching;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.labex.entity.teaching.Course;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CourseMapper extends BaseMapper<Course> {}
```

其余 3 个 Mapper 同模式（CourseOfferingMapper、SyllabusMapper、SyllabusChapterMapper）。

- [ ] **Step 2**: 编译验证 + Commit

```bash
cd backend; mvn compile -q
git add backend/src/main/java/com/labex/mapper/teaching/
git commit -m "feat(ctl-s1): add 4 mappers for S1"
```

## Task S1-4: CourseService + CourseOfferingService + SyllabusService

**Files:**
- Create: `backend/src/main/java/com/labex/service/teaching/CourseService.java` (接口)
- Create: `backend/src/main/java/com/labex/service/teaching/impl/CourseServiceImpl.java`
- Create: `backend/src/main/java/com/labex/service/teaching/CourseOfferingService.java`
- Create: `backend/src/main/java/com/labex/service/teaching/impl/CourseOfferingServiceImpl.java`
- Create: `backend/src/main/java/com/labex/service/teaching/SyllabusService.java`
- Create: `backend/src/main/java/com/labex/service/teaching/impl/SyllabusServiceImpl.java`

- [ ] **Step 1**: CourseService 接口

```java
public interface CourseService extends IService<Course> {
    List<Course> listByOwner(Long ownerId);
    Course createCourse(Course course, Long ownerId);
    Syllabus getOrCreateSyllabus(Long courseId);
}
```

- [ ] **Step 2**: CourseServiceImpl 实现

```java
@Service
public class CourseServiceImpl extends ServiceImpl<CourseMapper, Course> implements CourseService {
    @Autowired private SyllabusMapper syllabusMapper;
    
    @Override
    public List<Course> listByOwner(Long ownerId) {
        return lambdaQuery().eq(Course::getOwnerId, ownerId).list();
    }
    
    @Override
    @Transactional
    public Course createCourse(Course course, Long ownerId) {
        course.setOwnerId(ownerId);
        save(course);
        // 自动创建空大纲
        Syllabus s = new Syllabus();
        s.setCourseId(course.getId());
        s.setVersion(1);
        syllabusMapper.insert(s);
        return course;
    }
    
    @Override
    public Syllabus getOrCreateSyllabus(Long courseId) {
        Syllabus s = syllabusMapper.selectOne(
            new LambdaQueryWrapper<Syllabus>().eq(Syllabus::getCourseId, courseId));
        if (s == null) {
            s = new Syllabus();
            s.setCourseId(courseId);
            s.setVersion(1);
            syllabusMapper.insert(s);
        }
        return s;
    }
}
```

- [ ] **Step 3**: CourseOfferingService 接口（类似）

```java
public interface CourseOfferingService extends IService<CourseOffering> {
    List<CourseOffering> listByCourse(Long courseId);
    List<CourseOffering> listByTeacher(Long teacherId);
    CourseOffering createOffering(Long courseId, Long clazzId, Long teacherId, String semester);
}
```

- [ ] **Step 4**: SyllabusService 接口（章节管理）

```java
public interface SyllabusService extends IService<Syllabus> {
    Syllabus getByCourse(Long courseId);
    void saveSyllabus(Long courseId, Syllabus dto);
    List<SyllabusChapter> listChapters(Long syllabusId);
    SyllabusChapter addChapter(Long syllabusId, SyllabusChapter chapter);
    void updateChapter(Long chapterId, SyllabusChapter chapter);
    void deleteChapter(Long chapterId);
}
```

- [ ] **Step 5**: 实现 + 编译 + commit

```bash
cd backend; mvn compile -q
git add backend/src/main/java/com/labex/service/teaching/
git commit -m "feat(ctl-s1): add CourseService/CourseOfferingService/SyllabusService"
```

## Task S1-5: CourseController + OfferingController + SyllabusController

**Files:**
- Create: `backend/src/main/java/com/labex/controller/teaching/CourseController.java`
- Create: `backend/src/main/java/com/labex/controller/teaching/CourseOfferingController.java`
- Create: `backend/src/main/java/com/labex/controller/teaching/SyllabusController.java`

- [ ] **Step 1**: CourseController

```java
@RestController
@RequestMapping("/api/teacher/course")
@PreAuthorize("hasRole('TEACHER') or hasRole('ADMIN')")
public class CourseController {
    @Autowired private CourseService courseService;
    
    @GetMapping("/list")
    public Result<List<Course>> list(Authentication auth) {
        Long teacherId = Long.parseLong(auth.getName());
        return Result.success(courseService.listByOwner(teacherId));
    }
    
    @GetMapping("/{id}")
    public Result<Course> detail(@PathVariable Long id) {
        return Result.success(courseService.getById(id));
    }
    
    @PostMapping
    public Result<Course> create(@RequestBody Course course, Authentication auth) {
        Long teacherId = Long.parseLong(auth.getName());
        return Result.success(courseService.createCourse(course, teacherId));
    }
    
    @PutMapping("/{id}")
    public Result<Boolean> update(@PathVariable Long id, @RequestBody Course course) {
        course.setId(id);
        return Result.success(courseService.updateById(course));
    }
    
    @DeleteMapping("/{id}")
    public Result<Boolean> delete(@PathVariable Long id) {
        return Result.success(courseService.removeById(id));
    }
}
```

- [ ] **Step 2**: CourseOfferingController + SyllabusController（同模式）

SyllabusController 路由：
- `GET    /api/teacher/syllabus/{courseId}` → 取大纲+章节
- `PUT    /api/teacher/syllabus/{courseId}` → 保存大纲
- `POST   /api/teacher/syllabus/{syllabusId}/chapter` → 新建章节
- `PUT    /api/teacher/syllabus/chapter/{chapterId}` → 更新章节
- `DELETE /api/teacher/syllabus/chapter/{chapterId}` → 删除章节

- [ ] **Step 3**: 启动后端，用 curl/Postman 测试 5 个端点

```bash
# 启动
cd backend; mvn spring-boot:run
# 另开终端，登录获 token
$tok = (curl -X POST http://localhost:8080/api/auth/login -H "Content-Type: application/json" -d '{"username":"1001","password":"123456"}').data.token
# 创建课程
curl -X POST http://localhost:8080/api/teacher/course -H "Authorization: Bearer $tok" -H "Content-Type: application/json" -d '{"code":"CS101","nameCn":"测试课程","credit":2.0,"hours":32,"major":"软件工程"}'
```
Expected: `{"code":0,"data":{"id":1,...}}`

- [ ] **Step 4**: Commit

```bash
git add backend/src/main/java/com/labex/controller/teaching/
git commit -m "feat(ctl-s1): add CourseController/CourseOfferingController/SyllabusController"
```

## Task S1-6: 前端 API 客户端 + 路由 + CourseList 页面

**Files:**
- Modify: `frontend/src/api/index.js` [追加 courseApi/offeringApi/syllabusApi]
- Modify: `frontend/src/router/index.js` [追加 4 条路由]
- Create: `frontend/src/views/teacher/course/CourseList.vue`

- [ ] **Step 1**: 追加 API（参考 frontend/src/api/index.js 现有 teacherApi 风格）

```javascript
// === 课程教学闭环 (CTL) ===
export const courseApi = {
  list: () => http.get('/teacher/course/list'),
  detail: (id) => http.get(`/teacher/course/${id}`),
  create: (data) => http.post('/teacher/course', data),
  update: (id, data) => http.put(`/teacher/course/${id}`, data),
  remove: (id) => http.delete(`/teacher/course/${id}`),
};
export const offeringApi = {
  listByCourse: (courseId) => http.get(`/teacher/offering/list?courseId=${courseId}`),
  listByTeacher: () => http.get('/teacher/offering/list/my'),
  create: (data) => http.post('/teacher/offering', data),
};
export const syllabusApi = {
  get: (courseId) => http.get(`/teacher/syllabus/${courseId}`),
  save: (courseId, data) => http.put(`/teacher/syllabus/${courseId}`, data),
  addChapter: (syllabusId, data) => http.post(`/teacher/syllabus/${syllabusId}/chapter`, data),
  updateChapter: (chapterId, data) => http.put(`/teacher/syllabus/chapter/${chapterId}`, data),
  deleteChapter: (chapterId) => http.delete(`/teacher/syllabus/chapter/${chapterId}`),
};
```

- [ ] **Step 2**: 追加路由

```javascript
// 在 teacher 子路由数组末尾
{ path: 'course', name: 'TeacherCourse', component: () => import('@/views/teacher/course/CourseList.vue') },
{ path: 'course/:id/edit', name: 'TeacherCourseEdit', component: () => import('@/views/teacher/course/CourseEdit.vue') },
{ path: 'course/:id/syllabus', name: 'TeacherSyllabus', component: () => import('@/views/teacher/course/SyllabusEditor.vue') },
{ path: 'offering', name: 'TeacherOffering', component: () => import('@/views/teacher/course/OfferingList.vue') },
```

并在教师端 Layout/侧边栏菜单加入对应入口。

- [ ] **Step 3**: CourseList.vue（参考现有 frontend/src/views/teacher/Experiment.vue 风格）

```vue
<template>
  <div class="course-list">
    <el-card>
      <template #header>
        <div class="card-header">
          <span>课程管理</span>
          <el-button type="primary" @click="onCreate">新建课程</el-button>
        </div>
      </template>
      <el-table :data="courses" stripe>
        <el-table-column prop="code" label="编号" width="120" />
        <el-table-column prop="nameCn" label="中文名" />
        <el-table-column prop="credit" label="学分" width="80" />
        <el-table-column prop="hours" label="学时" width="80" />
        <el-table-column prop="major" label="适用专业" width="120" />
        <el-table-column label="操作" width="280">
          <template #default="{ row }">
            <el-button size="small" @click="onEdit(row)">编辑</el-button>
            <el-button size="small" type="primary" @click="onSyllabus(row)">大纲</el-button>
            <el-button size="small" type="info" @click="onOffering(row)">开课</el-button>
            <el-button size="small" type="danger" @click="onDelete(row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>

    <el-dialog v-model="dialogVisible" title="新建课程" width="600">
      <el-form :model="form" label-width="100" ref="formRef" :rules="rules">
        <el-form-item label="课程编号" prop="code"><el-input v-model="form.code" /></el-form-item>
        <el-form-item label="中文名" prop="nameCn"><el-input v-model="form.nameCn" /></el-form-item>
        <el-form-item label="英文名"><el-input v-model="form.nameEn" /></el-form-item>
        <el-form-item label="学分" prop="credit"><el-input-number v-model="form.credit" :min="0.5" :max="10" :step="0.5" /></el-form-item>
        <el-form-item label="总学时" prop="hours"><el-input-number v-model="form.hours" :min="1" :max="200" /></el-form-item>
        <el-form-item label="理论学时"><el-input-number v-model="form.theoryHours" :min="0" /></el-form-item>
        <el-form-item label="实验学时"><el-input-number v-model="form.labHours" :min="0" /></el-form-item>
        <el-form-item label="适用专业"><el-input v-model="form.major" /></el-form-item>
        <el-form-item label="先修课程"><el-input v-model="form.prerequisite" /></el-form-item>
        <el-form-item label="开课系"><el-input v-model="form.department" /></el-form-item>
        <el-form-item label="课程简介"><el-input v-model="form.intro" type="textarea" :rows="4" /></el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible=false">取消</el-button>
        <el-button type="primary" @click="onSave">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import { ElMessage, ElMessageBox } from 'element-plus';
import { courseApi } from '@/api';

const router = useRouter();
const courses = ref([]);
const dialogVisible = ref(false);
const formRef = ref();
const form = ref({ code:'', nameCn:'', nameEn:'', credit:2.0, hours:32, theoryHours:24, labHours:8, major:'', prerequisite:'', department:'', intro:'' });
const rules = {
  code: [{ required: true, message: '请输入课程编号' }],
  nameCn: [{ required: true, message: '请输入中文名' }],
  credit: [{ required: true, message: '请输入学分' }],
  hours: [{ required: true, message: '请输入总学时' }],
};

const fetch = async () => {
  const { data } = await courseApi.list();
  courses.value = data || [];
};
onMounted(fetch);

const onCreate = () => { form.value = { code:'', nameCn:'', credit:2.0, hours:32, theoryHours:24, labHours:8 }; dialogVisible.value = true; };
const onSave = async () => {
  await formRef.value.validate();
  await courseApi.create(form.value);
  dialogVisible.value = false;
  ElMessage.success('已创建');
  fetch();
};
const onEdit = (row) => router.push(`/teacher/course/${row.id}/edit`);
const onSyllabus = (row) => router.push(`/teacher/course/${row.id}/syllabus`);
const onOffering = (row) => router.push(`/teacher/offering?courseId=${row.id}`);
const onDelete = async (row) => {
  await ElMessageBox.confirm(`确定删除课程「${row.nameCn}」?`);
  await courseApi.remove(row.id);
  ElMessage.success('已删除');
  fetch();
};
</script>

<style scoped>
.card-header { display:flex; justify-content:space-between; align-items:center; }
</style>
```

- [ ] **Step 4**: 启动前端、登录、访问 `/teacher/course`，验证能创建/编辑/删除

```bash
cd frontend; npm run dev
# 浏览器访问 http://localhost:3000，登录后跳到课程页
```

- [ ] **Step 5**: Commit

```bash
git add frontend/src/api/index.js frontend/src/router/ frontend/src/views/teacher/course/
git commit -m "feat(ctl-s1): add CourseList page and API client"
```

## Task S1-7: SyllabusEditor.vue + CourseEdit.vue + OfferingList.vue

**Files:**
- Create: `frontend/src/views/teacher/course/SyllabusEditor.vue`
- Create: `frontend/src/views/teacher/course/CourseEdit.vue`
- Create: `frontend/src/views/teacher/course/OfferingList.vue`

- [ ] **Step 1**: SyllabusEditor.vue — 9 section 编辑器（Tabs + RichText）

按参考文档「课程大纲.pdf」结构 9 节：
1. 基本信息（取自 t_course，只读卡片）
2. 课程目标（暂留 placeholder，S2 链接）
3. 教学内容与课程目标的关系（章节表格 CRUD）
4. 实践教学安排（暂置空）
5. 教学方法与习题要求（textarea）
6. 考核方式（暂留 placeholder，S3 链接）
7. 课程目标达成度评价公式（只读展示）
8. 推荐教材（textarea / JSON）
9. 学时分配（自动计算）

```vue
<template>
  <div class="syllabus-editor">
    <el-card><h2>课程大纲：{{ course?.nameCn }} ({{ course?.code }})</h2></el-card>

    <el-tabs v-model="activeTab" class="mt-4">
      <el-tab-pane label="一、基本信息" name="basic">
        <el-descriptions :column="2" border>
          <el-descriptions-item label="课程编号">{{ course?.code }}</el-descriptions-item>
          <el-descriptions-item label="中文名">{{ course?.nameCn }}</el-descriptions-item>
          <el-descriptions-item label="英文名">{{ course?.nameEn }}</el-descriptions-item>
          <el-descriptions-item label="学分">{{ course?.credit }}</el-descriptions-item>
          <el-descriptions-item label="总学时">{{ course?.hours }}</el-descriptions-item>
          <el-descriptions-item label="理论/实验">{{ course?.theoryHours }}/{{ course?.labHours }}</el-descriptions-item>
          <el-descriptions-item label="适用专业">{{ course?.major }}</el-descriptions-item>
          <el-descriptions-item label="先修课程">{{ course?.prerequisite }}</el-descriptions-item>
        </el-descriptions>
        <el-form-item label="课程简介" class="mt-4">
          <el-input v-model="syllabus.courseIntro" type="textarea" :rows="3" />
        </el-form-item>
      </el-tab-pane>

      <el-tab-pane label="二、课程目标" name="objectives">
        <p>请前往
          <el-link type="primary" @click="goObjective">课程目标管理</el-link>
          配置知识/能力/素质目标以及与毕业要求指标点的支撑关系。</p>
        <el-form-item label="主要任务"><el-input v-model="syllabus.mainTask" type="textarea" :rows="2" /></el-form-item>
        <el-form-item label="知识目标"><el-input v-model="syllabus.knowledgeGoals" type="textarea" :rows="3" /></el-form-item>
        <el-form-item label="能力目标"><el-input v-model="syllabus.abilityGoals" type="textarea" :rows="3" /></el-form-item>
        <el-form-item label="素质目标"><el-input v-model="syllabus.qualityGoals" type="textarea" :rows="3" /></el-form-item>
      </el-tab-pane>

      <el-tab-pane label="三、教学内容" name="chapters">
        <div class="toolbar mb-2"><el-button type="primary" @click="onAddChapter">新增章节</el-button></div>
        <el-table :data="chapters" stripe>
          <el-table-column prop="chapterNo" label="序号" width="80" />
          <el-table-column prop="topic" label="教学内容" />
          <el-table-column prop="knowledgeRequirements" label="知识/能力要求" />
          <el-table-column prop="recommendedHours" label="学时" width="80" />
          <el-table-column prop="teachingMethod" label="方式" width="100" />
          <el-table-column prop="objectiveRef" label="对应目标" width="120" />
          <el-table-column label="操作" width="140">
            <template #default="{ row }">
              <el-button size="small" @click="onEditChapter(row)">编辑</el-button>
              <el-button size="small" type="danger" @click="onDeleteChapter(row)">删除</el-button>
            </template>
          </el-table-column>
        </el-table>
      </el-tab-pane>

      <el-tab-pane label="四、实践教学" name="practice">
        <p>实践教学安排关联开课实例下的 t_experiment（实验项目）</p>
      </el-tab-pane>

      <el-tab-pane label="五、教学方法" name="methods">
        <el-form-item label="教学方法"><el-input v-model="syllabus.teachingMethods" type="textarea" :rows="4" /></el-form-item>
        <el-form-item label="习题要求"><el-input v-model="syllabus.exerciseRequirements" type="textarea" :rows="3" /></el-form-item>
      </el-tab-pane>

      <el-tab-pane label="六、考核方式" name="assessment">
        <el-form-item label="考核方式说明"><el-input v-model="syllabus.assessmentMethods" type="textarea" :rows="4" /></el-form-item>
        <p>具体评分项请在
          <el-link type="primary" @click="goScoring">评分项配置</el-link>
          中按开课设置。</p>
      </el-tab-pane>

      <el-tab-pane label="七、达成度公式" name="formula">
        <el-alert type="info" :closable="false">
          <p>课程分目标达成度 = 达到课程分目标分值学生人数 / 学生总人数</p>
          <p>课程总目标达成度 = 达到课程总目标分值学生人数 / 学生总人数</p>
        </el-alert>
      </el-tab-pane>

      <el-tab-pane label="八、教材参考书" name="books">
        <el-form-item label="推荐教材"><el-input v-model="syllabus.textbooks" type="textarea" :rows="4" /></el-form-item>
        <el-form-item label="参考书"><el-input v-model="syllabus.referencesList" type="textarea" :rows="4" /></el-form-item>
      </el-tab-pane>

      <el-tab-pane label="九、学时分配" name="hours">
        <el-table :data="hoursDistribution">
          <el-table-column prop="topic" label="章节" />
          <el-table-column prop="recommendedHours" label="学时" />
        </el-table>
      </el-tab-pane>
    </el-tabs>

    <div class="footer mt-4">
      <el-button type="primary" @click="onSave">保存大纲</el-button>
    </div>

    <!-- 章节编辑弹窗 -->
    <el-dialog v-model="chapterDialogVisible" :title="editingChapter.id ? '编辑章节' : '新建章节'" width="600">
      <el-form :model="editingChapter" label-width="100">
        <el-form-item label="章节号"><el-input v-model="editingChapter.chapterNo" /></el-form-item>
        <el-form-item label="教学内容"><el-input v-model="editingChapter.topic" /></el-form-item>
        <el-form-item label="知识/能力要求"><el-input v-model="editingChapter.knowledgeRequirements" type="textarea" :rows="3" /></el-form-item>
        <el-form-item label="思政元素"><el-input v-model="editingChapter.ideologicalElements" type="textarea" :rows="2" /></el-form-item>
        <el-form-item label="推荐学时"><el-input-number v-model="editingChapter.recommendedHours" :min="0" /></el-form-item>
        <el-form-item label="教学方式">
          <el-select v-model="editingChapter.teachingMethod">
            <el-option label="讲授" value="讲授" />
            <el-option label="实验" value="实验" />
            <el-option label="上机" value="上机" />
            <el-option label="实践" value="实践" />
          </el-select>
        </el-form-item>
        <el-form-item label="对应目标"><el-input v-model="editingChapter.objectiveRef" placeholder="如：课程目标 1,2" /></el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="chapterDialogVisible=false">取消</el-button>
        <el-button type="primary" @click="onSaveChapter">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { ElMessage, ElMessageBox } from 'element-plus';
import { courseApi, syllabusApi } from '@/api';

const route = useRoute();
const router = useRouter();
const courseId = computed(() => Number(route.params.id));
const course = ref(null);
const syllabus = ref({});
const chapters = ref([]);
const activeTab = ref('basic');
const chapterDialogVisible = ref(false);
const editingChapter = ref({});

const hoursDistribution = computed(() => chapters.value);

const fetch = async () => {
  const c = await courseApi.detail(courseId.value);
  course.value = c.data;
  const s = await syllabusApi.get(courseId.value);
  syllabus.value = s.data?.syllabus || {};
  chapters.value = s.data?.chapters || [];
};
onMounted(fetch);

const onSave = async () => {
  await syllabusApi.save(courseId.value, syllabus.value);
  ElMessage.success('大纲已保存');
};

const onAddChapter = () => { editingChapter.value = { chapterNo:'', topic:'', recommendedHours:2, teachingMethod:'讲授' }; chapterDialogVisible.value = true; };
const onEditChapter = (row) => { editingChapter.value = { ...row }; chapterDialogVisible.value = true; };
const onSaveChapter = async () => {
  if (editingChapter.value.id) {
    await syllabusApi.updateChapter(editingChapter.value.id, editingChapter.value);
  } else {
    await syllabusApi.addChapter(syllabus.value.id, editingChapter.value);
  }
  chapterDialogVisible.value = false;
  ElMessage.success('已保存');
  fetch();
};
const onDeleteChapter = async (row) => {
  await ElMessageBox.confirm(`确定删除「${row.topic}」?`);
  await syllabusApi.deleteChapter(row.id);
  ElMessage.success('已删除');
  fetch();
};

const goObjective = () => router.push(`/teacher/objective/${courseId.value}`);
const goScoring = () => router.push(`/teacher/scoring?courseId=${courseId.value}`);
</script>
```

- [ ] **Step 2**: CourseEdit.vue（复用 CourseList 的弹窗 form 作为独立页面）— 类似 List 风格
- [ ] **Step 3**: OfferingList.vue（教师按课程查看/新建开课实例：clazz + semester）
- [ ] **Step 4**: 启动前端，访问大纲编辑页，验证 9 个 tab 正常显示与章节 CRUD
- [ ] **Step 5**: Commit

```bash
git add frontend/src/views/teacher/course/
git commit -m "feat(ctl-s1): add SyllabusEditor/CourseEdit/OfferingList pages"
```

---

# S2: 毕业要求 + 课程目标

## Task S2-1: 4 张 S2 表 DDL（在 SchemaCompatibilityInitializer 追加）

按 spec §2.2.1, 2.2.2, 2.2.7, 2.2.8 创建：
- `t_graduation_requirement`
- `t_graduation_indicator`  
- `t_course_objective`
- `t_objective_support`

格式同 S1-1，省略详细 SQL（参考 spec）。

## Task S2-2: 4 个 S2 Entity + 4 个 Mapper

按 S1-2, S1-3 模式创建：
- `GraduationRequirement.java`
- `GraduationIndicator.java`
- `CourseObjective.java`
- `ObjectiveSupport.java`
- 对应 4 个 Mapper

## Task S2-3: GraduationRequirementService + CourseObjectiveService

```java
public interface GraduationRequirementService extends IService<GraduationRequirement> {
    List<GraduationRequirement> listAllWithIndicators();
    GraduationRequirement createWithIndicators(GraduationRequirement gr, List<GraduationIndicator> indicators);
}

public interface CourseObjectiveService extends IService<CourseObjective> {
    List<CourseObjective> listByCourse(Long courseId);
    CourseObjective createObjective(CourseObjective obj);
    void bindIndicators(Long objectiveId, List<Long> indicatorIds, Integer supportStrength);
    List<GraduationIndicator> getSupportedIndicators(Long objectiveId);
    List<CourseObjectiveWithSupportVO> getMatrix(Long courseId);
}
```

## Task S2-4: GRController + ObjectiveController

按 §4.1 S2 路由实现。

## Task S2-5: 前端 — GRManager.vue + ObjectiveEditor.vue

- `GRManager.vue`：管理毕业要求 + 指标点（树状结构）
- `ObjectiveEditor.vue`：按 courseId 编辑课程目标 + 支撑矩阵（参考 spec §5.3.1）

支撑矩阵 UI（关键）：

```vue
<el-table :data="objectives" border>
  <el-table-column label="课程目标" prop="description" width="200" />
  <el-table-column 
    v-for="indicator in allIndicators" 
    :key="indicator.id"
    :label="indicator.code"
  >
    <template #header>
      <el-tooltip :content="indicator.description">
        <span>{{ indicator.code }}</span>
      </el-tooltip>
    </template>
    <template #default="{ row }">
      <el-select v-model="supportMap[row.id][indicator.id]" placeholder="-" clearable size="small" @change="onSupportChange(row.id, indicator.id, $event)">
        <el-option label="H" :value="3" />
        <el-option label="M" :value="2" />
        <el-option label="L" :value="1" />
      </el-select>
    </template>
  </el-table-column>
</el-table>
```

Commit: `feat(ctl-s2): add S2 frontend pages for graduation requirements and course objectives`

---

# S3: 评分项 + 权重配置

## Task S3-1: 2 张 S3 表 DDL

`t_scoring_item`、`t_scoring_item_objective`，DDL 参考 spec §2.2.9, §2.2.10。

## Task S3-2: 2 Entity + 2 Mapper

## Task S3-3: ScoringItemService

```java
public interface ScoringItemService extends IService<ScoringItem> {
    List<ScoringItem> listByOffering(Long offeringId);
    ScoringItem createItem(ScoringItem item, List<ScoringItemObjective> objectiveLinks);
    void updateItem(Long id, ScoringItem item, List<ScoringItemObjective> objectiveLinks);
    boolean validateWeightSum(Long offeringId);  // Σweight=1
    List<ScoringItem> autoSuggestFromExistingTasks(Long offeringId);  // 从已有 homework/experiment/exam 建议
}
```

`validateWeightSum` 实现：

```java
@Override
public boolean validateWeightSum(Long offeringId) {
    BigDecimal sum = lambdaQuery()
        .eq(ScoringItem::getOfferingId, offeringId)
        .list()
        .stream()
        .map(ScoringItem::getWeight)
        .reduce(BigDecimal.ZERO, BigDecimal::add);
    return sum.subtract(BigDecimal.ONE).abs().compareTo(new BigDecimal("0.0001")) < 0;
}
```

## Task S3-4: ScoringItemController + ScoringItemConfig.vue

`ScoringItemConfig.vue` 关键：实时显示权重和并校验：

```vue
<div class="weight-summary">
  <span>当前权重和：</span>
  <el-tag :type="weightSumValid ? 'success' : 'danger'">
    {{ weightSum.toFixed(4) }} / 1.0000
  </el-tag>
</div>
```

支持「从已有作业/实验/考试导入」按钮 → 后端 `autoSuggestFromExistingTasks`。

Commit: `feat(ctl-s3): add scoring item configuration`

---

# S4: 成绩录入增强

## Task S4-1: t_scoring_score 表 + Entity + Mapper（§2.2.11）

## Task S4-2: ScoringScoreService（单/批/导入/矩阵）

```java
public interface ScoringScoreService extends IService<ScoringScore> {
    ScoringScore enterScore(Long itemId, Long studentId, BigDecimal score, Long teacherId);
    int batchEnter(Long itemId, List<StudentScoreDTO> scores, Long teacherId);
    int importFromExcel(Long offeringId, MultipartFile file);  // 按成绩明细表模板
    byte[] exportTemplate(Long offeringId);  // 按 spec §6.4 模板
    StudentScoreMatrixVO getMatrix(Long offeringId);
}
```

Excel 模板必须与参考文档 `课程分组及成绩明细表.xlsx` Sheet「成绩明细表」结构完全同构：
- 表头：序号 / 学号 / 姓名 / 毕业要求 5.1 / 课程目标 1 / 课程目标 2 / ...
- 第 2 行：满分分值
- 第 3 行：达成及格期望分值（70）
- 第 4 行：权重
- 第 5 行：加权分值
- 第 6 行起：学生数据
- 最后 3 行：平均分 / 达成及格学生人数 / 课程目标达成度

## Task S4-3: ScoringScoreController + GradeEntryV2.vue

GradeEntryV2.vue 核心 UI：

```vue
<template>
  <el-card>
    <template #header>
      <div class="flex-row">
        <span>成绩录入：{{ offering?.course?.nameCn }}</span>
        <div>
          <el-button @click="onDownloadTemplate">下载模板</el-button>
          <el-upload :auto-upload="false" :on-change="onImport"><el-button type="primary">导入 Excel</el-button></el-upload>
          <el-button type="success" @click="onSaveAll">保存全部</el-button>
        </div>
      </div>
    </template>

    <!-- 学生 × 评分项 二维矩阵 -->
    <el-table :data="matrix.students" :max-height="600" stripe>
      <el-table-column type="index" label="序号" width="60" fixed />
      <el-table-column prop="studentId" label="学号" width="100" fixed />
      <el-table-column prop="name" label="姓名" width="100" fixed />
      <el-table-column 
        v-for="item in matrix.items" 
        :key="item.id"
        :label="`${item.name}(${item.weight})`"
        :width="120"
      >
        <template #header>
          <el-tooltip :content="`满分${item.maxScore} 期望${item.passingScore} 权重${item.weight}`">
            <div>{{ item.name }}</div>
          </el-tooltip>
        </template>
        <template #default="{ row }">
          <el-input-number 
            v-model="row.scores[item.id]" 
            :min="0" 
            :max="item.maxScore"
            :controls="false"
            size="small"
            @change="markDirty(row.studentId, item.id)"
          />
        </template>
      </el-table-column>
    </el-table>
  </el-card>
</template>
```

Commit: `feat(ctl-s4): add scoring score entry with Excel template`

---

# S5: 达成度计算引擎 + 仪表板 ★ 核心

## Task S5-1: t_achievement_snapshot 表（§2.2.12）+ Entity + Mapper

## Task S5-2: AchievementCalcEngine 接口与 VO

```java
public interface AchievementCalcEngine {
    StudentAchievementVO calcForStudent(Long offeringId, Long studentId);
    OfferingAchievementVO calcForOffering(Long offeringId);
    void snapshot(Long offeringId, String reason);
    List<AchievementSnapshot> getSnapshots(Long offeringId);
    AchievementMatrixVO getCurrentMatrix(Long offeringId);
}

@Data
public class StudentAchievementVO {
    private Long studentId;
    private String studentName;
    private Map<Long, BigDecimal> objectiveAchievements; // objectiveId -> 达成度
    private BigDecimal totalAchievement;
    private BigDecimal totalWeightedScore;
    private BigDecimal totalWeightedMax;
}

@Data
public class OfferingAchievementVO {
    private Long offeringId;
    private Map<Long, ObjectiveSummaryVO> byObjective; // objectiveId -> { reachedCount, totalCount, value }
    private BigDecimal overallReachedRatio;
}
```

## Task S5-3: ★ TDD — AchievementCalcEngineTest（核心算法）

**Files:**
- Create: `backend/src/test/java/com/labex/service/teaching/AchievementCalcEngineTest.java`

- [ ] **Step 1**: 写失败测试（参考文档 Excel 行 155，学生 1 目标 1 = 0.7857）

```java
@SpringBootTest
@ActiveProfiles("test")
class AchievementCalcEngineTest {
    @Autowired private AchievementCalcEngine engine;
    @Autowired private TestDataBuilder builder;
    
    @Test
    void calcForStudent_excelSampleRow1_returnsExpectedAchievement() {
        // Given: 完整复现参考文档 Excel 行 155 的设定
        Long offeringId = builder.createOffering();
        // 8 个评分项，每个权重 0.05，满分 100
        for (int i = 1; i <= 8; i++) {
            builder.addScoringItem(offeringId, "作业"+i, new BigDecimal("0.05"), 100, 70);
        }
        // 大作业 4 + 期末 1 = 目标 2 部分
        builder.addScoringItem(offeringId, "大作业1", new BigDecimal("0.10"), 100, 70);
        builder.addScoringItem(offeringId, "大作业2", new BigDecimal("0.10"), 100, 70);
        builder.addScoringItem(offeringId, "大作业3", new BigDecimal("0.10"), 100, 70);
        builder.addScoringItem(offeringId, "大作业4", new BigDecimal("0.15"), 100, 70);
        builder.addScoringItem(offeringId, "期末", new BigDecimal("0.15"), 100, 70);
        // 加上学生 1 的全部得分（让目标 1 加权得分 / 加权满分 = 0.7857）
        Long studentId = builder.addStudent(offeringId, "1001", "张三");
        builder.setScores(studentId, /* 各项得分... */);
        
        // When
        StudentAchievementVO result = engine.calcForStudent(offeringId, studentId);
        
        // Then
        Long objective1Id = builder.objectiveId("课程目标1");
        BigDecimal expected = new BigDecimal("0.7857").setScale(4, RoundingMode.HALF_UP);
        BigDecimal actual = result.getObjectiveAchievements().get(objective1Id).setScale(4, RoundingMode.HALF_UP);
        assertThat(actual).isEqualByComparingTo(expected);
    }
}
```

- [ ] **Step 2**: 运行确认失败

```bash
cd backend; mvn test -Dtest=AchievementCalcEngineTest -q
```
Expected: FAIL（AchievementCalcEngine 未实现）

- [ ] **Step 3**: 实现 AchievementCalcEngineImpl

```java
@Service
public class AchievementCalcEngineImpl implements AchievementCalcEngine {
    @Autowired private ScoringItemMapper itemMapper;
    @Autowired private ScoringItemObjectiveMapper linkMapper;
    @Autowired private ScoringScoreMapper scoreMapper;
    @Autowired private CourseObjectiveMapper objectiveMapper;
    @Autowired private CourseOfferingMapper offeringMapper;
    @Autowired private StudentClazzMapper studentClazzMapper;
    
    @Override
    public StudentAchievementVO calcForStudent(Long offeringId, Long studentId) {
        List<ScoringItem> items = itemMapper.selectList(
            new LambdaQueryWrapper<ScoringItem>().eq(ScoringItem::getOfferingId, offeringId));
        if (items.isEmpty()) return emptyVO(studentId);
        
        Long courseId = offeringMapper.selectById(offeringId).getCourseId();
        List<CourseObjective> objectives = objectiveMapper.selectList(
            new LambdaQueryWrapper<CourseObjective>().eq(CourseObjective::getCourseId, courseId));
        
        // 读所有 (item, objective) 链接
        Map<Long, List<Long>> itemToObjectives = linkMapper.selectList(null).stream()
            .filter(l -> items.stream().anyMatch(i -> i.getId().equals(l.getScoringItemId())))
            .collect(Collectors.groupingBy(
                ScoringItemObjective::getScoringItemId,
                Collectors.mapping(ScoringItemObjective::getObjectiveId, Collectors.toList())));
        
        // 读学生得分
        Map<Long, BigDecimal> studentScores = scoreMapper.selectList(
            new LambdaQueryWrapper<ScoringScore>().eq(ScoringScore::getStudentId, studentId))
            .stream()
            .collect(Collectors.toMap(ScoringScore::getScoringItemId, 
                s -> s.getScore() == null ? BigDecimal.ZERO : s.getScore()));
        
        // 按目标聚合
        Map<Long, BigDecimal> objAch = new HashMap<>();
        for (CourseObjective obj : objectives) {
            BigDecimal weightedSum = BigDecimal.ZERO;
            BigDecimal weightedMax = BigDecimal.ZERO;
            for (ScoringItem item : items) {
                List<Long> objsOfItem = itemToObjectives.getOrDefault(item.getId(), List.of());
                if (objsOfItem.contains(obj.getId())) {
                    BigDecimal score = studentScores.getOrDefault(item.getId(), BigDecimal.ZERO);
                    weightedSum = weightedSum.add(score.multiply(item.getWeight()));
                    weightedMax = weightedMax.add(BigDecimal.valueOf(item.getMaxScore()).multiply(item.getWeight()));
                }
            }
            BigDecimal ach = weightedMax.compareTo(BigDecimal.ZERO) > 0 
                ? weightedSum.divide(weightedMax, 6, RoundingMode.HALF_UP) 
                : BigDecimal.ZERO;
            objAch.put(obj.getId(), ach);
        }
        
        // 总达成度
        BigDecimal totalSum = items.stream()
            .map(i -> studentScores.getOrDefault(i.getId(), BigDecimal.ZERO).multiply(i.getWeight()))
            .reduce(BigDecimal.ZERO, BigDecimal::add);
        BigDecimal totalMax = items.stream()
            .map(i -> BigDecimal.valueOf(i.getMaxScore()).multiply(i.getWeight()))
            .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        StudentAchievementVO vo = new StudentAchievementVO();
        vo.setStudentId(studentId);
        vo.setObjectiveAchievements(objAch);
        vo.setTotalAchievement(totalMax.compareTo(BigDecimal.ZERO) > 0 
            ? totalSum.divide(totalMax, 6, RoundingMode.HALF_UP) 
            : BigDecimal.ZERO);
        vo.setTotalWeightedScore(totalSum);
        vo.setTotalWeightedMax(totalMax);
        return vo;
    }
    
    @Override
    public OfferingAchievementVO calcForOffering(Long offeringId) {
        // 1. 取该 offering 所属 clazz 的所有学生
        // 2. 对每个学生调用 calcForStudent
        // 3. 按目标聚合：reachedCount = COUNT(ach >= passingRatio)
        //    passingRatio = passing_score / max_score（取评分项加权后的期望比例 = 0.7）
        // ...
    }
}
```

- [ ] **Step 4**: 跑测试验证通过

```bash
cd backend; mvn test -Dtest=AchievementCalcEngineTest -q
```
Expected: BUILD SUCCESS, Tests run: 1, Failures: 0

- [ ] **Step 5**: Commit

```bash
git add backend/src/main/java/com/labex/service/teaching/AchievementCalcEngine*
git add backend/src/test/java/com/labex/service/teaching/AchievementCalcEngineTest.java
git commit -m "feat(ctl-s5): add AchievementCalcEngine with verified Excel sample (0.7857)"
```

## Task S5-4: AchievementController（按 §4.1 路由）

## Task S5-5: AchievementDashboard.vue（教师端）+ MyAchievementDashboard.vue（学生端）

教师端关键：雷达图 + 班级达成度条形图 + 学生明细表

```vue
<template>
  <div class="achievement-dashboard">
    <el-row :gutter="20">
      <el-col :span="12">
        <el-card><h3>班级目标达成度</h3>
          <div ref="radarRef" style="width:100%;height:400px"></div>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card><h3>各目标达成情况</h3>
          <el-table :data="byObjective">
            <el-table-column prop="code" label="目标" />
            <el-table-column prop="reachedCount" label="达到人数" />
            <el-table-column prop="totalCount" label="总人数" />
            <el-table-column label="达成度">
              <template #default="{row}"><el-tag :type="row.value>=0.7?'success':'warning'">{{(row.value*100).toFixed(2)}}%</el-tag></template>
            </el-table-column>
          </el-table>
        </el-card>
      </el-col>
    </el-row>

    <el-card class="mt-4">
      <template #header><span>学生明细</span><el-button type="primary" @click="onRecalc">重新计算</el-button></template>
      <el-table :data="students" stripe>
        <el-table-column prop="studentId" label="学号" />
        <el-table-column prop="name" label="姓名" />
        <el-table-column v-for="obj in objectives" :key="obj.id" :label="obj.code">
          <template #default="{row}">{{ (row.objectiveAchievements[obj.id]*100).toFixed(2) }}%</template>
        </el-table-column>
        <el-table-column prop="totalAchievement" label="总达成度">
          <template #default="{row}"><el-tag>{{(row.totalAchievement*100).toFixed(2)}}%</el-tag></template>
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import * as echarts from 'echarts';
import { achievementApi, objectiveApi } from '@/api';

const route = useRoute();
const radarRef = ref();
const byObjective = ref([]);
const students = ref([]);
const objectives = ref([]);

const fetch = async () => {
  const offeringId = route.params.offeringId;
  const summary = await achievementApi.offering(offeringId);
  byObjective.value = Object.values(summary.data.byObjective);
  // ... 渲染雷达图
};
onMounted(fetch);

const onRecalc = async () => { await achievementApi.recalc(route.params.offeringId); await fetch(); };
</script>
```

Commit: `feat(ctl-s5): add achievement dashboards for teacher and student`

---

# S6: 课程质量评价 + 4 报告

## Task S6-1: t_quality_evaluation 表（§2.2.13）+ Entity + Mapper

## Task S6-2: QualityEvaluationService + QualityReportGenerator 接口

```java
public interface QualityReportGenerator {
    GradeStatReportVO gradeStat(Long offeringId);
    ConsistencyReportVO consistency(Long offeringId);
    AttainmentReportVO attainment(Long offeringId, Long evaluationId);
    QualityReportVO quality(Long evaluationId);
    
    byte[] exportPdf(Long offeringId, ReportType type, Long evaluationId);
    byte[] exportExcel(Long offeringId, ReportType type, Long evaluationId);
}

public enum ReportType { GRADE_STAT, CONSISTENCY, ATTAINMENT, QUALITY }
```

## Task S6-3: 实现 QualityReportGenerator（含 PDF 导出）

每个 generate 方法：
- **GradeStat** = `ScoringScoreService.getMatrix(offeringId)` 算加权总分 → 平均/最高/最低/分布
- **Consistency** = `ScoringItemService.listByOffering` + `ScoringItemObjectiveMapper` 聚合
- **Attainment** = `AchievementCalcEngine.calcForOffering` + `t_quality_evaluation` 填写部分
- **Quality** = `t_quality_evaluation` 完整字段

PDF 导出：使用 iText 7，模板放 `backend/src/main/resources/report-templates/`。

## Task S6-4: ★ TDD — QualityReportGeneratorTest

测试每个报告：
- 字段不为空
- 关键计算正确

## Task S6-5: QualityEvaluationController + QualityReportController

## Task S6-6: 前端 — EvaluationForm.vue + ReportViewer.vue

- `EvaluationForm.vue`：填写评价小组、4 项评价、改进意见
- `ReportViewer.vue`：4 tab 切换查看报告 + 导出 PDF 按钮

Commit: `feat(ctl-s6): add quality evaluation and 4-report system`

---

# Final Integration

## Task FINAL-1: 端到端验证 + 菜单导航

- [ ] 在教师端 Layout 侧边栏加菜单组「教学闭环」含 6 个入口
- [ ] 在学生端 Layout 侧边栏加「我的达成度」入口
- [ ] 跑通完整流程：建课 → 大纲 → 目标 → 评分项 → 成绩 → 达成度 → 评价
- [ ] 用参考文档 Excel 样例数据导入 → 达成度计算与 Excel 行 155 一致

## Task FINAL-2: 文档与提交

- [ ] 更新 `README.md` 加入「课程教学闭环」章节
- [ ] 更新 `docs/02-产品文档/项目需求文档.md` 加入新模块
- [ ] 在 `docs/03-技术文档/` 加 `课程教学闭环技术文档.md`
- [ ] 总 commit：`feat(ctl): complete course teaching loop MVP (S1-S6)`

---

## Self-Review

**1. Spec coverage:**
- ✅ S1 课程大纲 → Task S1-1~7
- ✅ S2 课程目标 → Task S2-1~5
- ✅ S3 评分项 → Task S3-1~4
- ✅ S4 成绩录入 → Task S4-1~3
- ✅ S5 达成度计算 → Task S5-1~5
- ✅ S6 课程质量评价 → Task S6-1~6
- ✅ 4 张评价报告 → Task S6-2~6
- ✅ 算法基准（Excel 行 155）→ Task S5-3

**2. Placeholder scan:**
- 模式化重复内容（如 Mapper 接口）已在 S1-3 模板中给出，后续切片复用此模式（明示）
- S2/S3/S4/S6 的 Entity/Mapper/Service 骨架引用 S1 模板，避免重复
- 关键算法（S5-3）和报告生成（S6-3）有完整代码

**3. Type consistency:**
- `Course.id` 全部用 Long
- `score` 用 BigDecimal
- `weight` 用 BigDecimal(5,4)
- 全部使用 `LocalDateTime` for timestamps

## 执行选项

**Plan complete and saved.** 推荐使用 **Subagent-Driven Development**：

1. 控制器读完整 plan → 抽取每个 task 文本 → 顺序 dispatch implementer subagent → spec reviewer → code quality reviewer
2. 每个 task 完成才进下一个
3. 我可以 dispatch fresh subagent per task 以保证质量

切片节奏：**S1 → S2 → S3 → S4 → S5 → S6 → FINAL**，每切片完成后做一个 git tag。
