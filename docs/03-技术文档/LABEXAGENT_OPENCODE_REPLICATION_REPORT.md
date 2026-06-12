# LabexAgent Replication Report

Date: 2026-05-26

Reference source:
- Repository: https://github.com/sst/opencode.git
- Local path: `D:\workfordasan\_reference\opencode`
- Branch: `dev`
- Commit: `ca354f8e8a9b07986e3c668277f37f4173b6c48a`

## Source Files Reviewed

- `packages/opencode/src/agent/agent.ts`
- `packages/opencode/src/agent/subagent-permissions.ts`
- `packages/opencode/src/tool/task.ts`
- `packages/opencode/src/tool/websearch.ts`
- `packages/opencode/src/tool/repo_overview.ts`
- `packages/opencode/src/tool/external-directory.ts`
- `packages/opencode/src/session/compaction.ts`
- `packages/opencode/src/permission/*`

## Implemented Or Marked As Usable

| Area | Status | LabexAgent implementation |
| --- | --- | --- |
| Permission gate | Usable | `allow / ask / deny`, SSE approval, one-time/always/reject flow, persisted approvals |
| Build / plan / explore modes | Usable baseline | Mode-aware prompt and default tool permissions |
| Tool aliases | Improved | Added/recognized `list`, `todowrite`, `websearch`, `webfetch`, `read`, `write`, `edit`, `patch`, `image`, `repo_overview` |
| Web search | Improved | Exact entity/version preservation, larger dynamic result pool, recent/news search path, page excerpt fetching, source freshness and exact-match metadata |
| Image understanding | Usable baseline | `understand_image` / `image` tool path and RAG attachment analysis |
| Project overview | Usable baseline | `project_overview` and `repo_overview` alias over the local project index |
| LSP-style diagnostics | Partial | Lightweight `diagnostics` and `lsp_symbols`; not a real language-server lifecycle yet |
| Session fork and compaction | Usable baseline | Conversation fork, manual/auto compact path, memory context reuse |
| Git-backed rollback | Usable baseline | Internal Git snapshots around command tools plus Changes panel undo support |
| Subagent task tool | Improved | `task` now runs a focused read-only subagent model call and returns `<task_result>` output |

## Still Missing For Commercial-Grade Parity

| Area | Gap |
| --- | --- |
| Full subagent runtime | Current `task` is read-only one-shot analysis. It does not yet create independent child sessions with their own tool loop, cancellation, resume, and background completion injection. |
| Agent registry | Built-in modes exist, but there is no user-configurable agent registry with per-agent model, prompt, permissions, temperature, and visibility. |
| Background jobs | No persistent background subagent queue or completion notification injection into the parent conversation. |
| Real LSP integration | Current diagnostics are lightweight static checks. Missing managed LSP server lifecycle, file watching, workspace diagnostics, references, definitions, and multi-language capability detection. |
| Provider transforms | Provider abstraction exists, but lacks detailed provider-specific request transforms, model capability maps, and prompt variants. |
| Plugin SDK | MCP and skills exist, but there is no first-class plugin SDK with event hooks, custom tool registration, auth hooks, and sandbox boundaries. |
| External repository cache | `repo_clone` is intentionally disabled for student workspace safety. A managed read-only repository cache is still needed before enabling external source inspection. |
| Session timeline UX | Fork/compact exists, but branch tree, timeline selection, message-level restore, and richer diff navigation are not complete. |
| Tool schema validation | Tool definitions are available, but runtime schema validation and typed error repair are still shallow. |

## Recommended Next Build Order

1. Full subagent sessions: child conversation, independent loop, cancellation, foreground/background result injection.
2. Agent registry: database-backed custom agents with prompt/model/permission settings.
3. Managed repo cache: safe clone path outside student workspace, read-only overview and web/source scouting.
4. Real LSP lifecycle: server start/stop, diagnostics cache, symbols/references/definitions.
5. Plugin hooks: internal extension points for tool/session/provider events.

