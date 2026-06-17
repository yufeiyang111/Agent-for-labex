# LabexAgent Context Engine Design

## Goal

Upgrade LabexAgent from a prompt-concatenation coding assistant into a more engineering-grade coding agent. The first module focuses on context orchestration, prompt-cache friendliness, workspace memory, project indexing, and stage-aware execution.

## Current Problems

- Context is built as large text blocks and trimmed by character/token estimates.
- Project indexing is shallow and does not preserve module symbols, changed files, verification state, or file-read cache.
- Conversation memory keeps summaries and recent events, but not durable engineering facts.
- The loop requires plans, but it does not enforce engineering phases such as exploration, design, implementation, verification, and repair.
- Prompt cache usage is not visible, and stable prompt blocks are mixed with dynamic context.

## Architecture

### 1. Context Orchestrator

Create a backend service that composes context into stable and dynamic sections:

- Stable prefix: project rules, tool policy, skills, MCP summary, project identity.
- Workspace map: compact project index, entrypoints, scripts, APIs, symbols, hot files.
- Durable memory: decisions, touched files, failed commands, verification results.
- Session tail: latest run log, checkpoint, active file, user request.

The orchestrator also emits a context budget report so the UI and logs can show what was included or trimmed.

### 2. Workspace Memory

Persist workspace memory under `.labex/agent-memory.json` inside each project. This avoids schema migration risk and keeps memory close to the project.

Memory records:

- file cache entries: path, hash, size, summary, last read time
- touched files
- recent failed commands
- recent verification commands
- durable decisions

### 3. Enhanced Project Index

Extend `ProjectIndexService` to produce an adaptive index with:

- entrypoints
- scripts and commands
- routes/controllers
- symbols from Java, Vue, JS, TS, Python
- recently modified files
- task-related search hits

### 4. Engineering Stage Machine

Track a lightweight stage in `AgentContext`:

- `intake`
- `explore`
- `design`
- `implement`
- `verify`
- `repair`
- `final`

The loop adds the current stage to context and advances it based on tool behavior. This does not block the user, but it gives the model an explicit execution frame and prevents premature final answers.

### 5. Prompt Cache Observability

Provider usage parsing records prompt cache details when the model returns them:

- `prompt_tokens_details.cached_tokens`
- `input_token_details.cache_read`
- compatible vendor variants when present

The backend emits cache statistics through existing token usage events when available.

## Implementation Scope

- Add new service classes under `com.labex.labexagent.service`.
- Add context/stage fields to `AgentContext`.
- Integrate the orchestrator in `AgentLoopEngine`.
- Update file read/write/tool result hooks to feed workspace memory.
- Enhance project index generation without changing database schema.
- Keep all changes backend-only for this module.

## Verification

- `mvn compile -q` must pass.
- The agent should continue using existing tools, permissions, SSE events, and change tracking.
- Context reports should appear in run logs/SSE without exposing secrets.

