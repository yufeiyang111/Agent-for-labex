# 后端 API 接口函数文档（AI 知识助手工具函数调用）

> 本文档描述项目中所有后端 API 接口的功能、参数及用途，供 AI 知识问答助手将其作为工具函数调用。
> 所有接口的通用前缀为 `/api`。例如：登录接口完整路径为 `POST /api/auth/login`。

---

## 安全等级说明

每个接口标注了 AI 调用的安全等级：

| 等级 | 标记 | 含义 | AI 行为 |
|------|------|------|---------|
| 安全 | 🟢 | 只读查询，无副作用 | AI 自动调用，无需用户确认 |
| 受限 | 🟡 | 非破坏性写入（保存草稿、创建会话等） | AI 可调用，但需提示用户 |
| 危险 | 🔴 | 删除/修改密码/状态变更/批量操作等 | AI **禁止**调用，只供参考 |

**核心原则**：AI 知识助手只能**查询数据**和**执行非破坏性操作**，所有删除、权限变更、密码重置、批量导入等操作均禁止调用。

---

## 目录

1. [认证模块 (Auth)](#1-认证模块-auth)
2. [公共预览模块 (Preview)](#2-公共预览模块-preview)
3. [管理员模块 (Admin)](#3-管理员模块-admin)
4. [学生模块 (Student)](#4-学生模块-student)
5. [学生考试模块 (Student Exam)](#5-学生考试模块-student-exam)
6. [学生作业模块 (Student Homework)](#6-学生作业模块-student-homework)
7. [教师-班级管理 (Teacher Clazz)](#7-教师-班级管理-teacher-clazz)
8. [教师-学生管理 (Teacher Student)](#8-教师-学生管理-teacher-student)
9. [教师-实验管理 (Teacher Experiment)](#9-教师-实验管理-teacher-experiment)
10. [教师-实验题目管理 (Teacher Experiment Item)](#10-教师-实验题目管理-teacher-experiment-item)
11. [教师-成绩管理 (Teacher Score)](#11-教师-成绩管理-teacher-score)
12. [教师-考试管理 (Teacher Exam)](#12-教师-考试管理-teacher-exam)
13. [教师-试卷管理 (Teacher Paper)](#13-教师-试卷管理-teacher-paper)
14. [教师-题目管理 (Teacher Question)](#14-教师-题目管理-teacher-question)
15. [教师-讲义管理 (Teacher Lecture)](#15-教师-讲义管理-teacher-lecture)
16. [教师-作业管理 (Teacher Homework)](#16-教师-作业管理-teacher-homework)
17. [教师-批改管理 (Teacher Grading)](#17-教师-批改管理-teacher-grading)
18. [教师-仪表盘 (Teacher Dashboard)](#18-教师-仪表盘-teacher-dashboard)
19. [知识图谱模块 (Knowledge Graph)](#19-知识图谱模块-knowledge-graph)
20. [学生掌握度模块 (Mastery)](#20-学生掌握度模块-mastery)
21. [智能推荐模块 (Recommendation)](#21-智能推荐模块-recommendation)
22. [RAG 知识库问答模块](#22-rag-知识库问答模块)
23. [Embedding 向量化服务 (Flask)](#23-embedding-向量化服务-flask)

---

## 通用说明

- **认证方式**：所有接口（除 `/auth/login`、`/preview/**`、`/rag/**` 部分接口外）均需在请求头中携带 `Authorization: Bearer {token}`
- **响应格式**：统一返回 `Result<T>` 结构体：
  ```json
  {
    "code": 200,       // 200 成功，其他为失败
    "msg": "操作成功",  // 提示消息
    "data": { ... }    // 具体数据
  }
  ```
- **角色控制**：`@PreAuthorize("hasRole('ADMIN')")` 表示仅管理员可访问

---

## 1. 认证模块 (Auth)

**功能**：处理用户的登录、登出、信息查询、密码修改、头像管理等认证相关操作。

### 1.1 🟡 用户登录
- **接口**：`POST /auth/login`
- **功能**：支持教师/管理员/学生三种角色登录，自动识别 BCrypt/MD5/明文密码
- **角色**：无需登录
- **请求体**：
  ```json
  {
    "account": "账号",
    "password": "密码",
    "role": "TEACHER | STUDENT | ADMIN"
  }
  ```
- **返回**：`LoginResponse`（包含 token、过期时间、用户信息）

### 1.2 🟡 退出登录
- **接口**：`POST /auth/logout`
- **功能**：用户退出登录（服务端记录日志）
- **角色**：需登录

### 1.3 🟢 获取当前用户信息
- **接口**：`GET /auth/userinfo`
- **功能**：从 token 解析当前用户，查询详细的用户信息（含班级名称、头像等）
- **角色**：需登录

### 1.4 🔴 修改密码
- **接口**：`PUT /auth/update-password`
- **功能**：验证原密码后，修改当前用户的登录密码
- **角色**：需登录

### 1.5 🔴 上传头像
- **接口**：`POST /auth/avatar`
- **功能**：上传头像图片（最大 5MB，仅支持图片格式），返回头像访问 URL
- **角色**：需登录

### 1.6 🟢 获取当前用户头像
- **接口**：`GET /auth/avatar`
- **功能**：返回当前登录用户的头像图片二进制数据
- **角色**：需登录

### 1.7 🟢 获取指定头像文件
- **接口**：`GET /auth/avatar/{fileName}`
- **功能**：根据文件名直接访问头像图片
- **角色**：无需登录

---

## 2. 公共预览模块 (Preview)

> 本模块全部为 🟢 安全，AI 可调用。

**功能**：提供讲义文件预览、PPT 课件幻灯片在线预览（含图片渲染和调试信息）。

### 2.1 🟢 预览讲义文件
- **接口**：`GET /preview/lecture/{id}`
- **功能**：根据讲义 ID 预览文件内容（PDF/PPT/图片等直接浏览器内预览，其他类型触发下载）

### 2.2 🟢 预览作业文件
- **接口**：`GET /preview/homework/{id}`
- **功能**：预留接口，目前返回"开发中"

### 2.3 🟢 获取 PPT 幻灯片列表
- **接口**：`GET /preview/lecture/{id}/slides`
- **功能**：将 PPT/PPTX 讲义渲染为 PNG 图片并缓存，返回所有幻灯片的总数、索引和访问 URL
- **参数**：`debug`（可选 boolean）

### 2.4 🟢 PPT 幻灯片调试
- **接口**：`GET /preview/lecture/{id}/slides/debug`
- **功能**：返回 PPT 渲染的详细调试信息（字体、缺失字体列表、文本抽样等）

### 2.5 🟢 获取单张幻灯片图片
- **接口**：`GET /preview/lecture/{id}/slides/{slideIndex}`
- **功能**：返回指定页数的幻灯片 PNG 图片

---

## 3. 管理员模块 (Admin)

> 所有接口需 `ADMIN` 角色。**大部分写操作为 🔴 危险**，仅查询类为 🟢 安全。

**功能**：系统管理员专属接口，管理教师、学生、班级及查看统计信息。

### 3.1 教师管理

#### 3.1.1 🟢 分页查询教师列表
- **接口**：`GET /admin/teacher/list`
- **参数**：`pageNum`（默认1）、`pageSize`（默认20）、`keyword`（可选）

#### 3.1.2 🟢 获取所有教师
- **接口**：`GET /admin/teacher/all`

#### 3.1.3 🟢 根据 ID 查询教师
- **接口**：`GET /admin/teacher/{id}`

#### 3.1.4 🔴 新增教师
- **接口**：`POST /admin/teacher`

#### 3.1.5 🔴 更新教师
- **接口**：`PUT /admin/teacher/{id}`

#### 3.1.6 🔴 删除教师
- **接口**：`DELETE /admin/teacher/{id}`
- **注意**：不能删除管理员账号

#### 3.1.7 🔴 更新教师状态
- **接口**：`PUT /admin/teacher/{id}/state`
- **功能**：启用或禁用教师账号（0=禁用 1=启用）

#### 3.1.8 🔴 重置教师密码
- **接口**：`PUT /admin/teacher/{id}/reset-password`
- **功能**：将教师密码重置为其账号名

### 3.2 学生管理

#### 3.2.1 🟢 分页查询学生列表
- **接口**：`GET /admin/student/list`
- **参数**：`pageNum`、`pageSize`、`clazzNo`（可选）、`keyword`（可选）

#### 3.2.2 🟢 获取所有学生
- **接口**：`GET /admin/student/all`

#### 3.2.3 🟢 根据 ID 查询学生
- **接口**：`GET /admin/student/{id}`

#### 3.2.4 🔴 新增学生
- **接口**：`POST /admin/student`

#### 3.2.5 🔴 更新学生
- **接口**：`PUT /admin/student/{id}`

#### 3.2.6 🔴 删除学生
- **接口**：`DELETE /admin/student/{id}`

#### 3.2.7 🔴 启用/禁用学生
- **接口**：`PUT /admin/student/{id}/state`

#### 3.2.8 🔴 重置学生密码
- **接口**：`PUT /admin/student/{id}/reset-password`

#### 3.2.9 🔴 重置学生 IP
- **接口**：`PUT /admin/student/{id}/reset-ip`

#### 3.2.10 🔴 批量导入学生
- **接口**：`POST /admin/student/import`
- **功能**：通过 CSV 文件批量导入学生到指定班级
- **参数**：`file`（CSV 文件）、`clazzNo`（班级编号）

### 3.3 班级管理

#### 3.3.1 🟢 分页查询班级列表
- **接口**：`GET /admin/clazz/list`
- **参数**：`pageNum`、`pageSize`、`keyword`（可选）

#### 3.3.2 🟢 获取所有班级
- **接口**：`GET /admin/clazz/all`

#### 3.3.3 🟢 根据编号查询班级
- **接口**：`GET /admin/clazz/{no}`

#### 3.3.4 🔴 新增班级
- **接口**：`POST /admin/clazz`

#### 3.3.5 🔴 更新班级
- **接口**：`PUT /admin/clazz/{no}`

#### 3.3.6 🔴 删除班级
- **接口**：`DELETE /admin/clazz/{no}`

#### 3.3.7 🔴 更新班级状态
- **接口**：`PUT /admin/clazz/{no}/state`

### 3.4 统计信息

#### 3.4.1 🟢 获取系统统计
- **接口**：`GET /admin/stats`
- **功能**：返回教师总数、学生总数、班级总数

---

## 4. 学生模块 (Student)

> 所有接口需 `STUDENT` 角色。查询类为 🟢 安全，提交类为 🔴 危险。

**功能**：学生端核心功能——实验列表、答题、成绩查询、学习统计、讲义查看。

### 4.1 🟢 获取可用实验列表
- **接口**：`GET /student/experiments`

### 4.2 🟢 获取实验题目
- **接口**：`GET /student/experiment/{experimentId}/items`

### 4.3 🟢 获取答题进度
- **接口**：`GET /student/experiment/{experimentId}/progress`

### 4.4 🟡 保存答案（自动保存）
- **接口**：`POST /student/experiment/{experimentId}/item/{itemId}/save`
- **功能**：保存单个题目的作答内容（已有答案则更新）
- **参数**：`content`（答案内容字符串）

### 4.5 🔴 提交实验答案
- **接口**：`POST /student/experiment/{experimentId}/submit`
- **功能**：批量提交实验中的所有题目答案（提交后不可修改）

### 4.6 🟢 查询个人成绩
- **接口**：`GET /student/scores`

### 4.7 🟢 学习统计数据
- **接口**：`GET /student/stats`

### 4.8 🟢 获取讲义列表
- **接口**：`GET /student/lectures`

### 4.9 🟢 根据 ID 查询讲义
- **接口**：`GET /student/lecture/{id}`

---

## 5. 学生考试模块 (Student Exam)

> 所有接口需 `STUDENT` 角色。

### 5.1 🟢 获取可用考试列表
- **接口**：`GET /student/exam/list`

### 5.2 🟢 获取考试详情
- **接口**：`GET /student/exam/{id}`

### 5.3 🟢 获取我的考试答案
- **接口**：`GET /student/exam/{id}/my-answers`

### 5.4 🟡 保存单题答案
- **接口**：`POST /student/exam/{examId}/question/{questionId}/save`
- **参数**：`answer`（答案内容）

### 5.5 🟡 运行编程题测试
- **接口**：`POST /student/exam/{examId}/question/{questionId}/run-tests`
- **功能**：对编程题提交代码，运行预设的测试用例，返回测试结果
- **参数**：`code`、`language`

### 5.6 🔴 提交考试
- **接口**：`POST /student/exam/{examId}/submit`

### 5.7 🔴 上报考试监控事件
- **接口**：`POST /student/exam/{examId}/monitor-event`

### 5.8 🟡 运行代码
- **接口**：`POST /student/exam/run-code`
- **功能**：通用代码运行接口（非考试环境），支持多种编程语言
- **参数**：`code`、`language`、`stdin`（可选）

---

## 6. 学生作业模块 (Student Homework)

> 所有接口需 `STUDENT` 角色。

### 6.1 🟢 获取可用作业列表
- **接口**：`GET /student/homework/list`

### 6.2 🟢 获取作业详情
- **接口**：`GET /student/homework/{id}`

### 6.3 🟢 获取作业题目
- **接口**：`GET /student/homework/{id}/questions`

### 6.4 🟢 获取我的作业答案
- **接口**：`GET /student/homework/{id}/my-answers`

### 6.5 🟡 保存单题答案
- **接口**：`POST /student/homework/{homeworkId}/question/{questionId}/save`

### 6.6 🟡 运行编程题测试
- **接口**：`POST /student/homework/{homeworkId}/question/{questionId}/run-tests`
- **参数**：`code`、`language`

### 6.7 🔴 提交作业
- **接口**：`POST /student/homework/{homeworkId}/submit`

### 6.8 🟢 获取我的提交记录
- **接口**：`GET /student/homework/{id}/my-submission`

### 6.9 🟢 获取我的所有提交
- **接口**：`GET /student/homework/my-list`

### 6.10 🔴 提交文本作业
- **接口**：`POST /student/homework/{id}/submit-text`

### 6.11 🔴 提交文件作业
- **接口**：`POST /student/homework/{id}/submit-file`

### 6.12 🟢 下载作业文件
- **接口**：`GET /student/homework/{id}/download`

---

## 7. 教师-班级管理 (Teacher Clazz)

> 所有接口需 `TEACHER` 角色。仅查询类为 🟢 安全。

### 7.1 🟢 分页查询班级列表
- **接口**：`GET /teacher/clazz/list`

### 7.2 🟢 获取所有班级
- **接口**：`GET /teacher/clazz/all`

### 7.3 🟢 根据编号查询班级
- **接口**：`GET /teacher/clazz/{no}`

### 7.4 🔴 新增班级
- **接口**：`POST /teacher/clazz`

### 7.5 🔴 更新班级
- **接口**：`PUT /teacher/clazz/{no}`

### 7.6 🔴 删除班级
- **接口**：`DELETE /teacher/clazz/{no}`

### 7.7 🔴 更新班级状态
- **接口**：`PUT /teacher/clazz/{no}/state`

---

## 8. 教师-学生管理 (Teacher Student)

> 所有接口需 `TEACHER` 角色。

### 8.1 🟢 分页查询学生列表
- **接口**：`GET /teacher/student/list`
- **参数**：`page`、`pageSize`、`clazzNo`（可选）、`keyword`（可选）

### 8.2 🟢 根据班级获取学生
- **接口**：`GET /teacher/student/clazz/{clazzNo}`

### 8.3 🟢 根据 ID 查询学生
- **接口**：`GET /teacher/student/{id}`

### 8.4 🔴 新增学生
- **接口**：`POST /teacher/student`

### 8.5 🔴 更新学生
- **接口**：`PUT /teacher/student/{id}`

### 8.6 🔴 删除学生
- **接口**：`DELETE /teacher/student/{id}`

### 8.7 🔴 启用/禁用学生
- **接口**：`PUT /teacher/student/{id}/state`

### 8.8 🔴 重置学生密码
- **接口**：`PUT /teacher/student/{id}/reset-password`

### 8.9 🔴 重置学生 IP
- **接口**：`PUT /teacher/student/{id}/reset-ip`

### 8.10 🔴 批量导入学生
- **接口**：`POST /teacher/student/import`

---

## 9. 教师-实验管理 (Teacher Experiment)

> 所有接口需 `TEACHER` 角色。

### 9.1 🟢 分页查询实验列表
- **接口**：`GET /teacher/experiment/list`

### 9.2 🟢 获取已启用的实验
- **接口**：`GET /teacher/experiment/enabled`

### 9.3 🟢 根据 ID 查询实验
- **接口**：`GET /teacher/experiment/{id}`

### 9.4 🔴 新增实验
- **接口**：`POST /teacher/experiment`

### 9.5 🔴 更新实验
- **接口**：`PUT /teacher/experiment/{id}`

### 9.6 🔴 删除实验
- **接口**：`DELETE /teacher/experiment/{id}`

### 9.7 🔴 更新实验状态
- **接口**：`PUT /teacher/experiment/{id}/state`

---

## 10. 教师-实验题目管理 (Teacher Experiment Item)

> 所有接口需 `TEACHER` 角色。

### 10.1 🟢 根据实验 ID 查询题目列表
- **接口**：`GET /teacher/experiment-item/experiment/{experimentId}`

### 10.2 🟢 分页查询题目
- **接口**：`GET /teacher/experiment-item/list`

### 10.3 🟢 根据 ID 查询题目
- **接口**：`GET /teacher/experiment-item/{id}`

### 10.4 🔴 新增题目
- **接口**：`POST /teacher/experiment-item`

### 10.5 🔴 更新题目
- **接口**：`PUT /teacher/experiment-item/{id}`

### 10.6 🔴 删除题目
- **接口**：`DELETE /teacher/experiment-item/{id}`

### 10.7 🔴 批量删除题目
- **接口**：`DELETE /teacher/experiment-item/batch`

---

## 11. 教师-成绩管理 (Teacher Score)

> 所有接口需 `TEACHER` 角色。

### 11.1 🟢 查询学生实验答题列表
- **接口**：`GET /teacher/score/experiment/{experimentId}/students`

### 11.2 🟢 查询学生实验答题详情
- **接口**：`GET /teacher/score/student/{studentId}/experiment/{experimentId}`

### 11.3 🔴 评分单个题目
- **接口**：`PUT /teacher/score/item/{studentItemId}`

### 11.4 🔴 批量评分
- **接口**：`PUT /teacher/score/batch`

### 11.5 🟢 导出实验成绩
- **接口**：`GET /teacher/score/export/{experimentId}`
- **功能**：导出某实验的全部成绩为 Excel 文件

---

## 12. 教师-考试管理 (Teacher Exam)

> 所有接口需 `TEACHER` 角色。

### 12.1 🟢 获取试卷列表
- **接口**：`GET /teacher/exam/papers`

### 12.2 🟢 分页查询考试列表
- **接口**：`GET /teacher/exam/list`

### 12.3 🟢 获取所有考试
- **接口**：`GET /teacher/exam/all`

### 12.4 🟢 根据 ID 查询考试
- **接口**：`GET /teacher/exam/{id}`

### 12.5 🔴 新增考试
- **接口**：`POST /teacher/exam`

### 12.6 🔴 更新考试
- **接口**：`PUT /teacher/exam/{id}`

### 12.7 🔴 删除考试
- **接口**：`DELETE /teacher/exam/{id}`

---

## 13. 教师-试卷管理 (Teacher Paper)

> 所有接口需 `TEACHER` 角色。

### 13.1 🟢 分页查询试卷列表
- **接口**：`GET /teacher/paper/list`

### 13.2 🟢 获取所有试卷
- **接口**：`GET /teacher/paper/all`

### 13.3 🟢 根据 ID 查询试卷
- **接口**：`GET /teacher/paper/{id}`

### 13.4 🟢 获取试卷题目列表
- **接口**：`GET /teacher/paper/{id}/questions`

### 13.5 🔴 新增试卷
- **接口**：`POST /teacher/paper`

### 13.6 🔴 更新试卷
- **接口**：`PUT /teacher/paper/{id}`

### 13.7 🔴 删除试卷
- **接口**：`DELETE /teacher/paper/{id}`

### 13.8 🔴 为试卷添加题目
- **接口**：`POST /teacher/paper/{id}/questions`

---

## 14. 教师-题目管理 (Teacher Question)

> 所有接口需 `TEACHER` 角色。

### 14.1 🟢 分页查询题目列表
- **接口**：`GET /teacher/question/list`

### 14.2 🟢 获取所有题目
- **接口**：`GET /teacher/question/all`

### 14.3 🟢 根据 ID 查询题目
- **接口**：`GET /teacher/question/{id}`

### 14.4 🔴 新增题目
- **接口**：`POST /teacher/question`

### 14.5 🔴 创建题目（完整版）
- **接口**：`POST /teacher/question/create`

### 14.6 🔴 填充示例题目
- **接口**：`POST /teacher/question/seed-demo`

### 14.7 🔴 更新题目
- **接口**：`PUT /teacher/question/{id}`

### 14.8 🔴 删除题目
- **接口**：`DELETE /teacher/question/{id}`

### 14.9 🟢 获取题目的测试用例
- **接口**：`GET /teacher/question/{id}/test-cases`

### 14.10 🔴 保存测试用例
- **接口**：`POST /teacher/question/{id}/test-cases`

### 14.11 🔴 删除测试用例
- **接口**：`DELETE /teacher/question/test-case/{testCaseId}`

---

## 15. 教师-讲义管理 (Teacher Lecture)

> 所有接口需 `TEACHER` 角色。

### 15.1 🟢 分页查询讲义列表
- **接口**：`GET /teacher/lecture/list`

### 15.2 🟢 获取讲义分类
- **接口**：`GET /teacher/lecture/categories`

### 15.3 🟢 获取所有讲义
- **接口**：`GET /teacher/lecture/all`

### 15.4 🟢 根据 ID 查询讲义
- **接口**：`GET /teacher/lecture/{id}`

### 15.5 🔴 新增讲义
- **接口**：`POST /teacher/lecture`

### 15.6 🔴 更新讲义
- **接口**：`PUT /teacher/lecture/{id}`

### 15.7 🔴 删除讲义
- **接口**：`DELETE /teacher/lecture/{id}`

### 15.8 🔴 上传讲义文件
- **接口**：`POST /teacher/lecture/upload`

### 15.9 🔴 上传并向量化
- **接口**：`POST /teacher/lecture/upload-with-vectorize`

### 15.10 🟢 预览讲义文件
- **接口**：`GET /teacher/lecture/preview/{id}`

### 15.11 🟢 下载讲义文件
- **接口**：`GET /teacher/lecture/download/{id}`

---

## 16. 教师-作业管理 (Teacher Homework)

> 所有接口需 `TEACHER` 角色。

### 16.1 🟢 分页查询作业列表
- **接口**：`GET /teacher/homework/list`

### 16.2 🟢 获取所有作业
- **接口**：`GET /teacher/homework/all`

### 16.3 🟢 根据 ID 查询作业
- **接口**：`GET /teacher/homework/{id}`

### 16.4 🔴 新增作业
- **接口**：`POST /teacher/homework`

### 16.5 🔴 更新作业
- **接口**：`PUT /teacher/homework/{id}`

### 16.6 🔴 删除作业
- **接口**：`DELETE /teacher/homework/{id}`

### 16.7 🔴 上传作业文件
- **接口**：`POST /teacher/homework/upload`

### 16.8 🟢 下载作业文件
- **接口**：`GET /teacher/homework/download/{id}`

### 16.9 🟢 获取作业提交列表
- **接口**：`GET /teacher/homework/{id}/submissions`

### 16.10 🟢 获取作业题目
- **接口**：`GET /teacher/homework/{id}/questions`

### 16.11 🔴 为作业添加题目
- **接口**：`POST /teacher/homework/{id}/questions`

### 16.12 🔴 从作业移除题目
- **接口**：`DELETE /teacher/homework/{homeworkId}/question/{questionId}`

### 16.13 🟢 获取可选题目
- **接口**：`GET /teacher/homework/available-questions`

### 16.14 🔴 给作业评分
- **接口**：`PUT /teacher/homework/submission/{id}`

### 16.15 🟢 查看学生作业作答
- **接口**：`GET /teacher/homework/{homeworkId}/student/{studentId}/answers`

### 16.16 🔴 评分学生作业中某题
- **接口**：`PUT /teacher/homework/{homeworkId}/student/{studentId}/question/{questionId}/score`

### 16.17 🟢 下载学生提交文件
- **接口**：`GET /teacher/homework/submission/download/{id}`

---

## 17. 教师-批改管理 (Teacher Grading)

> 所有接口需 `TEACHER` 角色。

### 17.1 🟢 获取待批改的考试列表
- **接口**：`GET /teacher/grading/pending-exams`

### 17.2 🟢 获取待批改的学生列表
- **接口**：`GET /teacher/grading/exam/{examId}/pending-students`

### 17.3 🟢 获取学生答题详情（批改用）
- **接口**：`GET /teacher/grading/exam/{examId}/student/{studentId}/questions`

### 17.4 🔴 批改单题
- **接口**：`PUT /teacher/grading/exam/{examId}/student/{studentId}/question/{questionId}`

### 17.5 🔴 提交全部批改
- **接口**：`POST /teacher/grading/exam/{examId}/student/{studentId}/submit-grades`

### 17.6 🟢 获取学生考试得分
- **接口**：`GET /teacher/grading/exam/{examId}/student/{studentId}/score`

### 17.7 🟢 获取考试监控事件
- **接口**：`GET /teacher/grading/exam/{examId}/invigilation-events`

---

## 18. 教师-仪表盘 (Teacher Dashboard)

> 需 `TEACHER` 角色。本模块全部为 🟢 安全。

### 18.1 🟢 获取总览数据
- **接口**：`GET /teacher/dashboard/overview`
- **功能**：返回教师的班级数、学生数、实验数、完成率、分数段分布、班级学生分布图、实验状态、近期实验列表、考试监控事件汇总等全面数据

---

## 19. 知识图谱模块 (Knowledge Graph)

> 知识点提取与管理。

### 19.1 🟡 从讲义提取知识点
- **接口**：`POST /kg/extract`
- **功能**：异步从指定讲义中提取知识点（只读分析，不破坏数据）
- **请求体**：`{"lectureIds": [1,2,3], "topicId": "可选主题ID"}`

### 19.2 🟢 列表查询知识点
- **接口**：`GET /kg/points`

### 19.3 🟢 查询知识点详情
- **接口**：`GET /kg/points/{id}`

### 19.4 🟡 手动创建知识点
- **接口**：`POST /kg/points`
- **功能**：手动创建一个知识点

### 19.5 🔴 删除知识点
- **接口**：`DELETE /kg/points/{id}`

### 19.6 🟡 批量关联题目到知识点
- **接口**：`POST /kg/link-questions`
- **功能**：将所有题目与知识点进行自动关联（基于内容相似度）

### 19.7 🟢 获取主题列表
- **接口**：`GET /kg/topics`

### 19.8 🟡 创建主题
- **接口**：`POST /kg/topics`

### 19.9 🔴 更新主题
- **接口**：`PUT /kg/topics/{id}`

### 19.10 🔴 删除主题
- **接口**：`DELETE /kg/topics/{id}`

### 19.11 🟢 获取知识图谱统计
- **接口**：`GET /kg/stats`

---

## 20. 学生掌握度模块 (Mastery)

> 本模块全部为 🟢 安全。

**功能**：基于知识图谱的学生知识点掌握度分析。

### 20.1 🟢 获取我的掌握度
- **接口**：`GET /mastery/my-state`

### 20.2 🟢 教师查看学生掌握度
- **接口**：`GET /mastery/student/{studentId}`

---

## 21. 智能推荐模块 (Recommendation)

> 本模块全部为 🟢 安全。

**功能**：基于学生薄弱知识点进行个性化题目推荐。

### 21.1 🟢 个性化推荐
- **接口**：`GET /recommendation/for-me`
- **参数**：`limit`（默认10）、`explain`（可选，是否返回推荐原因）

### 21.2 🟢 按知识点推荐
- **接口**：`GET /recommendation/by-knowledge`
- **参数**：`knowledgePointId`、`limit`（默认10）

### 21.3 🟢 相似题目推荐
- **接口**：`GET /recommendation/similar`
- **参数**：`questionId`、`limit`（默认5）

---

## 22. RAG 知识库问答模块

> 本模块专为 AI 问答设计，大部分为 🟢 安全或 🟡 受限。

**功能**：基于讲义内容的知识问答系统——管理问答会话、向知识库提问、管理知识库文档。基于 Hybrid Retrieval + LLM 实现。

### 22.1 🟡 初始化知识库
- **接口**：`POST /rag/init`
- **功能**：对所有未向量化的讲义执行向量化处理，构建/更新知识库索引

### 22.2 🟡 创建问答会话
- **接口**：`POST /rag/session/create`
- **功能**：创建一个新的问答对话会话

### 22.3 🟢 获取用户会话列表
- **接口**：`GET /rag/sessions`

### 22.4 🟢 获取会话详情
- **接口**：`GET /rag/session/{sessionId}`

### 22.5 🔴 删除会话
- **接口**：`DELETE /rag/session/{sessionId}`

### 22.6 🟡 更新会话标题
- **接口**：`PUT /rag/session/{sessionId}/title`

### 22.7 🟢 向知识库提问（核心接口）
- **接口**：`POST /rag/query`
- **功能**：向知识库提交一个问题，系统检索相关讲义内容后让 AI 基于检索结果生成回答。如果知识库中没有相关内容，AI 会用自身知识回答并标注
- **请求体**：
  ```json
  {
    "question": "用户问题",
    "sessionId": "可选会话ID（不传则自动创建新会话）"
  }
  ```
- **返回**：包含回答内容、来源文档列表、会话ID、是否来自知识库标记

### 22.8 🟢 获取会话历史
- **接口**：`GET /rag/history/{sessionId}`

### 22.9 🟢 获取已向量化的文档列表
- **接口**：`GET /rag/documents`

### 22.10 🟢 获取讲义内容（知识库预览）
- **接口**：`GET /rag/lecture/{id}`

### 22.11 🟢 获取知识库状态
- **接口**：`GET /rag/status`
- **功能**：返回知识库的整体状态——总讲义数、已向量化数、待处理数、失败数、是否就绪

---

## 23. Embedding 向量化服务 (Flask)

> 内部微服务，供后端 Java RAG 模块调用，一般不需要 AI 直接调用。

### 23.1 🟢 健康检查
- **接口**：`GET http://localhost:5000/health`

### 23.2 🔴 生成文本向量
- **接口**：`POST http://localhost:5000/embed`
- **说明**：内部服务，由 RAG 模块自动调用

### 23.3 🟢 获取向量维度
- **接口**：`GET http://localhost:5000/embed/dimension`

### 23.4 🟡 分句
- **接口**：`POST http://localhost:5000/nlp/sentences`
- **参数**：`text`、`lang`（zh/en，默认zh）

### 23.5 🟡 命名实体识别
- **接口**：`POST http://localhost:5000/nlp/entities`

### 23.6 🟡 文本预处理
- **接口**：`POST http://localhost:5000/nlp/preprocess`

---

## 附录：安全等级汇总

| 安全等级 | 标记 | 数量 | AI 行为 |
|---------|------|------|---------|
| 安全 | 🟢 | **~90 个** | 可直接自动调用（只读查询） |
| 受限 | 🟡 | **~15 个** | 需提示用户后调用（非破坏性写入） |
| 危险 | 🔴 | **~88 个** | 禁止调用（删除/改密/状态变更/批量操作） |

### 🟢 AI 可直接调用的核心工具函数速查

| 功能 | 接口 |
|------|------|
| 获取用户信息 | `GET /auth/userinfo` |
| 预览讲义/PPT | `GET /preview/lecture/{id}`、`GET /preview/lecture/{id}/slides` |
| 管理员查询统计 | `GET /admin/stats` |
| 学生：查实验/成绩/讲义 | `GET /student/experiments`、`GET /student/scores`、`GET /student/stats` |
| 学生：查考试/作业 | `GET /student/exam/list`、`GET /student/homework/list` |
| 教师：查班级/学生/实验/讲义/作业 | 对应的 `GET /teacher/.../list` 和 `.../{id}` |
| 教师：查成绩/批改/监控 | `GET /teacher/score/...`、`GET /teacher/grading/...` |
| 教师仪表盘 | `GET /teacher/dashboard/overview` |
| 知识图谱查询 | `GET /kg/points`、`GET /kg/topics`、`GET /kg/stats` |
| 掌握度分析 | `GET /mastery/my-state` |
| 智能推荐 | `GET /recommendation/for-me`、`by-knowledge`、`similar` |
| **RAG 知识库问答** | **`POST /rag/query`（核心）** |
| 知识库状态 | `GET /rag/status`、`GET /rag/documents` |

### 🟡 AI 可调用但需提示用户的工具

| 功能 | 接口 |
|------|------|
| 用户登录/登出 | `POST /auth/login`、`POST /auth/logout` |
| 保存答题草稿 | `POST /student/.../save` |
| 运行代码测试 | `POST /student/exam/run-tests`、`POST /student/exam/run-code` |
| 初始化/更新知识库 | `POST /rag/init` |
| 管理问答会话 | `POST /rag/session/create`、`PUT /rag/session/{id}/title` |
| 知识点提取/关联 | `POST /kg/extract`、`POST /kg/link-questions` |
| NLP 文本处理 | `POST /nlp/sentences`、`POST /nlp/entities`、`POST /nlp/preprocess` |
