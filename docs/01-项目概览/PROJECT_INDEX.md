# Labex 项目文件索引与清理指南

> 生成日期：2026-05-21
> 本文档梳理项目根目录 `D:\workfordasan` 下所有文件和目录的用途，
> 区分"项目核心文件"和"可清理的冗余/中间过渡文件"。

---

## 一、项目核心文件（必须保留）

### 1.1 主应用代码

| 路径 | 说明 | 大小 |
|------|------|------|
| `backend/` | **Spring Boot 3 后端** (Maven, Java 17) | — |
| `frontend/` | **Vue 3 前端** (Vite, Element Plus) | — |
| `embedding_service/` | **Python 向量嵌入服务** (Flask, BGE-M3) | — |
| `docker/` | Docker 部署配置 (Dockerfile + nginx) | 3 文件 |
| `docker-compose.yml` | Docker Compose 编排文件 | 1.9 KB |

### 1.2 项目文档

| 文件 | 说明 |
|------|------|
| `README.md` | 项目介绍、启动方式、测试账号 |
| `CLAUDE.md` | Claude Code AI 助手工作指导 |
| `项目需求文档.md` | 项目需求文档（中文） |
| `frontend.md` | 前端架构说明 |
| `PROJECT_DELIVERY.md` | 项目交付件说明 |
| `SKILLS_GUIDE.md` | Skills 使用指南 |
| `backend-api-prompt.md` | 后端 API 接口说明 |
| `docs/` | 迭代报告、实施方案等文档 |

### 1.3 一键启停脚本

| 文件 | 说明 |
|------|------|
| `start-all.bat` | 启动所有服务 (Redis, Neo4j, Embedding, Backend, Frontend) |
| `close-all.bat` | 停止所有服务 |

---

## 二、运行时生成的文件（建议加入 .gitignore）

| 路径 | 说明 | 大小 | 处理建议 |
|------|------|------|----------|
| `backend/target/` | Maven 编译产物 | 可变 | 已 gitignore |
| `frontend/dist/` | Vite 构建产物 | 可变 | 已 gitignore |
| `node_modules/` | npm 依赖（根目录的，疑为误放） | 17 MB | **可删除** |
| `.venv/` | Python 虚拟环境 | 528 KB | **可删除**，每次 pip install 重建 |
| `uploads/` | 用户上传文件（作业/头像） | 17 MB | 保留（运行时数据） |
| `student_projects/` | 学生云 IDE 项目文件 | 94 MB | 保留（运行时数据） |
| `code_exec/` | 代码编译临时目录 | 0 | 保留（运行时生成） |

---

## 三、旧项目恢复/反编译产物（可安全删除）

这些文件来自从旧 JAR 恢复源码的过程。**现在 `backend/` 已有完整源码，这些不再需要。**

| 路径 | 说明 | 大小 |
|------|------|------|
| `_container_app.jar` | 原始 Spring Boot JAR（81.9 MB） | **81.9 MB** |
| `_recover2.jar` | JAR 副本 | **81.9 MB** |
| `_recover.jar` | 空 JAR | 0 |
| `_cfr.jar` | CFR Java 反编译器 | 2.2 MB |
| `_extract/` | JAR 解压目录（含 102 个依赖 JAR） | **81 MB** |
| `_decomp/` | 反编译器输出（大部分空文件） | 272 KB |
| `_decompiled_src/` | 反编译的 Java 源码 | 2.6 MB |
| `_opencode_src/` | OpenCode 源码 | 3.6 MB |
| `_missing_classes/` | 空目录 | 0 |
| `_recover/` | 空目录 | 0 |
| `_build_log.txt` | 构建日志 | 74 KB |
| `_jar_classes.txt` | JAR 类列表 | 11.8 KB |
| `_writer.cs` | C# 代码片段 | 322 B |

> **可释放空间：约 254 MB**

---

## 四、AI 技能市场（非项目代码，可独立存放）

这些是 Claude Code 的技能市场仓库，**不属于 Labex 项目本身**，只是作为开发辅助工具引入。

| 路径 | 说明 | 大小 |
|------|------|------|
| `agent-skills/` | Claude Code Agent Skills 市场（含 7 个技能） | **15 MB** |
| `cortex-ai-skills/` | Cortex AI 技能库（含 14 个技能） | 1.8 MB |
| `skills/` | 本地技能链接（feishu-doc-webify, gpt-image-2-gen） | 2.4 MB |
| `feishu-doc-webify/` | 飞书文档转网站工具 | 202 KB |
| `gpt-image-2-gen-skill/` | GPT 图片生成技能 | 2.2 MB |

> **建议**：移出项目目录或放入 `tools/` 子目录，非项目运行时依赖。
> **可释放空间：约 21.6 MB**

---

## 五、一次性题库生成脚本（可归档/删除）

这些 Python 和 JS 脚本用于批量生成测试题目数据，**只需运行一次，运行后的数据在 SQL 文件或数据库中**。

### Python 题库生成脚本

| 文件 | 说明 | 大小 |
|------|------|------|
| `generate_questions.py` | 基础题目生成 | 84 KB |
| `generate_2000_questions.py` | 生成 2000 道题 | 107 KB |
| `generate_2000_final.py` | 最终版生成 | 68 KB |
| `gen_2000_simple.py` | 简化版生成 | 85 KB |
| `gen_2000_final_v2.py` | 第二版最终生成 | 61 KB |
| `gen_2000_balanced.py` | 平衡版生成 | 107 KB |
| `insert_questions_direct.py` | 直接插入数据库 | 76 KB |
| `create_java_lectures.py` | Java 讲义生成 | 148 KB |
| `save_questions.py` | 保存题目到 DB | 0.7 KB |
| `save_testcases.py` | 保存测试用例到 DB | 0.6 KB |

### 文档/PPT 生成脚本

| 文件 | 说明 | 大小 |
|------|------|------|
| `create_all_docs.js` | 生成全部文档 | 64 KB |
| `create_final_docs.js` | 生成最终文档 | 42 KB |
| `generate_docs.js` | 文档生成器 | 44 KB |
| `generate-ppt.js` | PPT 生成 | 14 KB |
| `generate-ppt-detailed.js` | 详细 PPT 生成 | 36 KB |
| `generate_report.py` | 报告生成 | 18 KB |
| `generate_personal_reports.py` | 个人报告生成 | 19 KB |
| `edit_docx.py` | Word 文档编辑 | 25 KB |
| `fill_document.py` | 文档填充 | 0.7 KB |
| `extract_md.py` | Markdown 提取 | 2.1 KB |

### 生成的 SQL 数据文件

| 文件 | 说明 | 大小 |
|------|------|------|
| `2000_questions.sql` | 2000 道题 SQL | 866 KB |
| `2000_questions_balanced.sql` | 平衡版题目 SQL | 855 KB |
| `seed_questions.sql` | 种子题目 SQL | 23 KB |
| `111.sql` | 测试数据 | 100 KB |
| `database_schema.sql` | 数据库 Schema | 19 KB |
| `原项目数据库.sql` | 原数据库备份 | 30 KB |

### 校验输出文件

| 文件 | 说明 | 大小 |
|------|------|------|
| `question_check.txt` | 题目校验结果 | 0.8 KB |
| `testcase_check.txt` | 测试用例校验结果 | 0.3 KB |

> **建议**：将需要保留的 SQL 移入 `backend/src/main/resources/sql/`，其余可删除。
> **可释放空间：约 1.9 MB**

---

## 六、一次性调试/修复脚本（可删除）

### Python 脚本

| 文件 | 说明 |
|------|------|
| `_fix_api.py` | API 修复 |
| `_fix_cn.py` | 中文编码修复 |
| `check_bytes.py` | 字节检查 |
| `check_corruption.py` | 数据损坏检查 |
| `check_encoding.py` / `check_encoding2.py` | 编码验证 |
| `verify_db.py` | 数据库验证 |
| `verify_text.py` | 文本验证 |
| `test_charset.py` | 字符集测试 |
| `debug_arga27.py` | Arga27 调试 |
| `debug_pwd.py` | 密码调试 |
| `list_accounts.py` | 列出账号 |
| `list_drive.py` | 驱动器检测 |
| `cleanup_db.py` | 数据库清理 |
| `test_api.py` / `test_full.py` | API 测试 |

### PowerShell 脚本

| 文件 | 说明 |
|------|------|
| `_fix_batch.ps1` | 批量修复 |
| `clean_casts.ps1` | 类型转换清理 |
| `fix_script.ps1` | 通用修复 |
| `debug-login.ps1` | 登录调试 |
| `test-api.ps1` / `test-api-full.ps1` | API 测试 |

### 其他

| 文件 | 说明 |
|------|------|
| `admin-login.json` | 管理员登录测试 JSON |
| `test_write.txt` | 空测试文件 |

> **可释放空间：约 100 KB**

---

## 七、其他杂项

| 路径 | 说明 | 处理建议 |
|------|------|----------|
| `test_doc/` | 单个测试文档 "SQL Injection Protection Guide.md" | **可删除** |
| `fonts/` | 字体文件（可能用于 PPT 生成） | 按需保留 |
| `query` | 文本文件，内容为 "neo4j" | **可删除**（调试残留） |
| `init.sql/` | **这是一个目录**，不是 SQL 文件 | **可删除**（误创建） |
| `package.json` / `package-lock.json` | 根目录的 npm 配置（疑为误放，前端已有） | **可删除** |
| `.claude/` | Claude Code 配置 | 保留 |
| `.idea/` | JetBrains IDE 配置 | 保留 |
| `Labex架构分析.pptx` | 架构分析 PPT | 按需保留 |
| `Labex项目详细介绍.pptx` | 项目介绍 PPT | 按需保留 |

---

## 八、汇总：可清理空间

| 类别 | 可释放 |
|------|--------|
| 旧项目反编译产物 | ~254 MB |
| AI 技能市场 | ~21.6 MB |
| 试题生成脚本 | ~1 MB |
| 调试/修复脚本 | ~100 KB |
| 其他杂项 | ~20 MB |
| **总计** | **~297 MB** |

---

## 九、建议保留的最小目录结构

```
D:\workfordasan\
├── backend/                    # Spring Boot 后端
├── frontend/                   # Vue 3 前端
├── embedding_service/          # 向量嵌入服务
├── docker/                     # Docker 部署
├── docs/                       # 项目文档
├── uploads/                    # 用户上传文件（运行时）
├── student_projects/           # 学生项目文件（运行时）
├── fonts/                      # 字体（可选）
├── .claude/                    # Claude 配置
├── .idea/                      # IDE 配置
├── README.md
├── CLAUDE.md
├── 项目需求文档.md
├── frontend.md
├── PROJECT_DELIVERY.md
├── SKILLS_GUIDE.md
├── backend-api-prompt.md
├── docker-compose.yml
├── start-all.bat
└── close-all.bat
```

> **注意**：删除前请确认 `backend/` 下的源码已完整可编译（`mvn compile` 通过）。
> 建议将 AI 技能市场移至 `D:\tools\` 或其他独立路径，而非直接删除。
