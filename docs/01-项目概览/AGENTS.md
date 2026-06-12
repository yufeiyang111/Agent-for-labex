# Labex — Agent Instructions

## Quick commands

```bash
# Backend (Java 17, Maven)
cd backend && mvn clean compile spring-boot:run   # :8080/api
mvn compile -q                                      # quick check only
rm -rf target/                                      # fix stale builds

# Frontend (Vue 3, Vite 5)
cd frontend && npm install && npm run dev           # :3000, proxies /api to :8080
npm run test                                        # Vitest (single file: tests/components/Pagination.test.js)
npm run test:coverage

# Embedding service (RAG prerequisite)
cd embedding_service && pip install -r requirements.txt && python app.py  # :5000

# Docker (MySQL :3307, Redis, Backend, Frontend)
docker-compose up -d
```

## Architecture

- **3 roles**: ADMIN, TEACHER, STUDENT. Teachers & Admins both in `t_teacher` (role column differentiates).
- **Auth**: JWT in `Authorization: Bearer <token>`. Student ID = `Integer.parseInt(auth.getName())`. Passwords support BCrypt + MD5 + plaintext (legacy compat).
- **API**: All endpoints behind `/api`. Response wrapper `Result<T>` — success is `code === 0`.
- **Controllers**: Field injection `@Autowired`, `@PreAuthorize("hasRole('TEACHER')")`.
- **DB**: MyBatis-Plus 3.5.5, Druid pool, logical delete enabled (`deleted` field, 1=deleted 0=active).
- **Frontend**: All API calls in `src/api/index.js`. Vite aliases: `@`→src, `@api`, `@stores`, `@components`, `@utils`, `@styles`, `@assets`.

## Schema changes — critical

**NEVER write raw SQL migrations.** The file `init.sql` at `backend/src/main/resources/sql/init.sql` is executed on fresh MySQL only and may contain placeholders. Instead, add new columns in `SchemaCompatibilityInitializer.java` (`backend/.../config/`). It auto-adds missing columns on startup — this is the repo's DDL mechanism.

## Testing reality

- **Backend**: Test deps exist (`spring-boot-starter-test`, `h2`) but `backend/src/test/` is **empty**. No backend tests exist.
- **Frontend**: Vitest + jsdom, setup at `frontend/tests/setup.js`. Single component test file: `frontend/tests/components/Pagination.test.js`.
- Run `npm run test` from `frontend/`.

## Cloud IDE / LabexAgent

- Agent loop lives in `backend/.../labexagent/runtime/AgentLoopEngine.java` (1238 lines, 30 iteration limit).
- File changes tracked via `AgentChangeSet` / `AgentFileChange` tables — apply/reject/undo supported through `DiffService`.
- SSE streaming frontend composable at `frontend/src/composables/useAgentStream.js`.
- LLM provider abstraction via `LlmProvider` interface; `OpenAiCompatibleProvider` is the main impl. Falls back to global MiniMax config.
- 27 tools registered in `ToolRegistry`. Key ones: `read_file`, `write_file`, `edit_file`, `shell`, `glob`, `grep`, `web_search`, `understand_image`.

## Key implementation gotchas

- **code_exec/** (runtime student code binaries only, **not a startable service**, gitignored).
- **student_projects/** is runtime data (gitignored).
- **uploads/** path hardcoded in `application.yml` as `D:/workfordasan/uploads`.
- **code-exec base-path** hardcoded as `D:/workfordasan/code_exec`.
- **DB creds** (dev): MySQL root/yu6670980506:3306/labex, Redis no password, Neo4j neo4j/yu6670980506:7687.
- **Start order**: `embedding_service` (Python Flask, BGE-M3) must be running **before** backend if RAG features are needed.
- **Single `application.yml`** for all environments despite Docker using `--spring.profiles.active=prod`.
- **Question IDs**: Training uses `questionId`, Homework/Exam use `id` for the same concept.
- **Programming answers** stored as JSON `{"code":"...", "language":"java"}`.
- **RAG vector store**: In-memory cosine similarity (not a dedicated vector DB).
- **Knowledge graph**: Neo4j via Java driver in `kg/` package, no Spring Data Neo4j.
