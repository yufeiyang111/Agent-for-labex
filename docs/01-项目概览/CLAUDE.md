# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 回答规则

- **必须使用中文**回答所有问题，包括代码注释、错误分析、技术说明等。
- **每次回答必须带有一个"主人"称呼**，在回答开头或合适的位置称呼用户为"主人"。

## Project Overview

Labex — AI-assisted experiment teaching management platform. Built with Vue 3 + Spring Boot 3, supporting three roles (ADMIN, TEACHER, STUDENT). Features include experiment management, online exams, homework, programming code execution with test-case scoring, knowledge graph, RAG question-answering, and a cloud IDE workspace with AI agent.

## Build & Run Commands

### Backend (Spring Boot 3.2 + Maven, Java 17)
```bash
cd backend
mvn clean compile spring-boot:run    # Dev mode on :8080/api
mvn clean package                    # Production JAR
mvn compile -q                       # Quick compile check
```

### Frontend (Vue 3.4 + Vite 5)
```bash
cd frontend
npm install                          # Install deps
npm run dev                          # Dev server on :3000 (proxies /api to :8080)
npm run build                        # Production build to dist/
npm run test                         # Run tests with Vitest
npm run test:ui                      # Run tests with UI
npm run test:coverage                # Run tests with coverage report
```

### AI Services (must be running for RAG features)
```bash
cd embedding_service && pip install -r requirements.txt && python app.py  # BGE-M3 on :5000
```

The `code_exec/` directory is **runtime output only** (compiled student code binaries). Not a service you start.

### Docker
```bash
docker-compose up -d                  # MySQL 8 (port 3307), Redis 7, Backend, Frontend
```

### Windows One-Click Scripts
```bash
start-all.bat                         # Start all services (Redis, Neo4j, Embedding, Backend, Frontend) in separate windows
close-all.bat                         # Stop all services
```

## Database credentials (direct mode)
- MySQL: root / yu6670980506 at localhost:3306/labex
- Redis: localhost:6379 no password
- Neo4j: neo4j / yu6670980506 at bolt://localhost:7687

## Architecture

### Backend (`backend/`)
```
com.labex
├── common/          # Result<T> (code=0 success), PageResult
├── config/          # SecurityConfig, SchemaCompatibilityInitializer, RAG config, etc.
├── controller/
│   ├── teacher/     # Clazz, Student, Experiment, Question, Paper, Exam, Homework, TrainingSet, Grading, KnowledgeGraph
│   ├── student/     # Experiment, Exam, Homework, Training, CloudProject, RAG Chat
│   └── admin/       # Dashboard, Teacher/Student/Clazz management
├── service/impl     # Service layer with MyBatis-Plus CRUD
├── entity/          # ~47 entities (@TableName, @TableId)
├── mapper/          # BaseMapper<T> extensions + custom XML mappers
├── filter/          # JwtAuthenticationFilter
├── security/        # JwtUtil, CustomAuthenticationProvider
├── kg/              # Knowledge Graph (Neo4j via Java driver), question-knowledge linking
├── rag/             # RAG (chunking via Python embedding service, MiniMax LLM, vector search)
├── labexagent/      # Cloud IDE agent (MCP tools, diff management, command execution)
└── langchain4j/     # LangChain4j integration (agent, embedding models)
```

Key patterns:
- **Auth**: JWT via `Authorization: Bearer <token>`. Login at `POST /auth/login`. Password supports BCrypt + MD5 + plaintext (legacy). Teachers and Admins both in `t_teacher` (role field). Student ID extracted via `Integer.parseInt(auth.getName())`.
- **Controller**: Field injection `@Autowired`, `@PreAuthorize("hasRole('TEACHER')")`, methods return `Result<T>`
- **API prefix**: All endpoints under `/api`, e.g. `/api/student/training/list`
- **Response wrapper**: `Result<T>` with `.code` (0=success), `.message`, `.data`, `.timestamp`
- **DB**: MyBatis-Plus 3.5.5, Druid pool, logical delete enabled
- **Schema compatibility**: `SchemaCompatibilityInitializer` auto-adds missing columns on startup — add new columns here, not raw SQL. There is **no DDL in the repo** (init.sql is empty).
- **No backend tests** — `backend/src/test/` is empty despite test deps in pom.xml
- **Frontend tests**: Vitest with jsdom, setup in `frontend/tests/setup.js`, component tests in `frontend/tests/components/`
- **Single config file** — `application.yml` serves all environments (Docker uses `--spring.profiles.active=prod` but no `application-prod.yml` exists)
- **Code execution** base path: `D:/workfordasan/code_exec` (compile-and-run sandbox for student Java/C code)

### Frontend (`frontend/`)
```
src/
├── api/index.js       # All API modules: authApi, teacherApi, studentApi, adminApi, ragApi, kgApi, trainingApi, projectApi
├── router/index.js    # Role-based routing: /teacher/*, /student/*, /admin/*, /workspace/:projectId
├── stores/user.js     # Pinia: token, userInfo, role, login/logout
├── utils/request.js   # Axios (baseURL=/api, JWT interceptor, 401 -> logout)
├── views/
│   ├── teacher/       # Dashboard, Clazz, Student, Experiment, Lecture, Score, Question, Paper, Exam, Homework, TrainingSet, KnowledgeGraph
│   ├── student/       # Experiment, Exam, Homework, Training, CloudSpace/Workspace, RagChat, Recommendation
│   └── admin/         # Dashboard, Teacher, Student, Clazz
├── components/        # MonacoEditor, Breadcrumb, Pagination, MasteryRadar, RecommendationCard
│   └── cloud/         # FileTreeNode, ToolCallCard, DiffViewer, PlanDisplay, TokenChart
└── styles/            # variables.scss (Apple-inspired green #4caf50), global.scss
```

Key patterns:
- **API calls**: All in `src/api/index.js`, exported as named objects
- **Auth interceptor**: `request.js` attaches JWT token, handles 401 (logout + redirect)
- **Monaco editor**: `@/components/MonacoEditor.vue` (props: modelValue, language, height, readOnly)
- **Route guard**: `router/index.js` `beforeEach` guard checking localStorage token/role
- **Vite aliases**: `@` -> src, `@api`, `@stores`, `@components`, `@utils`, `@styles`, `@assets`

## Question Type System

| Type | Name | Scoring |
|------|------|---------|
| 1 | Fill-blank (填空) | Auto (exact match, partial per-blank with `\|\|\|`) |
| 2 | Single choice (单选) | Auto (exact match) |
| 3 | Multiple choice (多选) | Auto (set comparison, order independent) |
| 4 | True/false (判断) | Auto (exact match) |
| 5 | Short answer (简答) | Manual grading |
| 6 | Programming (编程) | Auto (compile + run test cases via CodeExecutionService) |
| 7 | Comprehensive (综合) | Manual grading |

## Programming Code Execution

`CodeExecutionService` compiles and runs Java/C code locally (configured `code-exec.base-path`):
- `runCode(code, language, input)` — compile + execute with optional stdin
- `executeAndGrade(code, language, testCases)` — run against test cases from `t_question_test_case`, scoring by `score_weight`

### Adding run-tests for a new student feature:
1. Backend: Create `POST /student/{feature}/question/{questionId}/run-tests` — call `codeExecutionService.executeAndGrade()`, return `{status, passedCount, totalCount, compileError, details}`
2. Frontend: Add `runProgrammingTests()` to API module, use `<MonacoEditor>` + judge panel

## RAG System

- **Embedding**: `embedding_service/` — Python Flask app with BGE-M3 (`BAAI/bge-m3`) on port 5000. Endpoints: `/embed`, `/chunk/semantic`, `/nlp/sentences`, etc.
- **LLM**: MiniMax API (`MiniMax-M2.7`) at `https://api.minimaxi.com/v1`
- **Vector store**: In-memory cosine similarity on chunk embeddings (not a dedicated vector DB)
- **Session memory**: `RagSession`, `RagMessage` tables auto-created by `SchemaCompatibilityInitializer`
- **Startup order**: embedding service must be running before backend RAG features work

## Knowledge Graph (Neo4j)

- Neo4j via Java driver in `kg/` package, embedded REST endpoints in `KnowledgeGraphController`
- `ProductionQuestionLinkingService` links questions to knowledge points by embedding similarity
- Requires knowledge points to have pre-computed embeddings before question linking works

## Cloud IDE / AI Agent (`labexagent/`)

- **Agent loop**: `AgentLoopEngine.java` (30 iteration limit), SSE streaming frontend via `frontend/src/composables/useAgentStream.js`
- **LLM providers**: `LlmProvider` interface, `OpenAiCompatibleProvider` main impl, falls back to global MiniMax config
- **27 tools** registered in `ToolRegistry`: `read_file`, `write_file`, `edit_file`, `shell`, `glob`, `grep`, `web_search`, `understand_image`, `diagnostics`, `apply_patch`, `create_plan`, `execute_code`, etc.
- **Diff management**: `DiffService` + `GitSnapshotService` for file change tracking, apply/reject/undo via `AgentChangeSet` / `AgentFileChange`
- **Permission system**: `PermissionService` + `DefaultPermissionRuleset` controls tool execution access
- **LSP diagnostics**: `DiagnosticsService` for code analysis
- Agent conversations stored in `t_agent_conversation`, `t_agent_message`, `t_agent_task`
- `StudentProject` ties student cloud workspaces to agent sessions

## Key Implementation Notes

- **Component reuse**: TrainingPractice.vue follows same Monaco + judge-panel pattern as Homework.vue for programming questions
- **Answer serialization**: Programming answers stored as JSON `{"code":"...", "language":"java"}` — helper functions in frontend
- **Question IDs**: Training uses `questionId`, Homework/Exam use `id` for the same concept
- **File upload**: Configured via `upload-path: D:/workfordasan/uploads`, max 100MB
- **Schema changes**: Add new columns to `SchemaCompatibilityInitializer.java` (not raw SQL migrations)
- **Controller response**: Always wrap in `Result.success(data)` or `Result.error(message)`
- **Stress tests**: `tests/stress/stress_test.sh` for load testing
