# LabexAgent 复刻 OpenCode 完整计划

> 基于 anomalyco/opencode (v1.15.10) 源代码分析，TypeScript/Bun 技术栈

---

## 0. 复刻状态标记（2026-05-26）

| 阶段 | 状态 | 已落地内容 | 商业化剩余项 |
|------|------|------------|--------------|
| 阶段一：权限系统 | ✅ 已复刻核心闭环 | `allow / ask / deny` 规则、SSE 权限询问、一次允许/始终允许/拒绝、模式默认规则 | 项目级规则管理页、持久化审批审计 |
| 阶段二：Plan/Build/Explore 模式 | ✅ 已复刻主流程 | 前端模式切换、后端模式提示词、模式级工具权限 | 快捷键切换、模式级模型覆盖 |
| 阶段三：LSP 集成 | 🟡 部分完成 | `diagnostics`、`lsp_symbols` 工具和写入后诊断反馈 | 真 LSP server 生命周期、文件监听、跨语言诊断 |
| 阶段四：系统提示词工程 | 🟡 部分完成 | 基础分层提示词、模式策略、运行检查点 | Provider 专用提示词、严格 schema 修复链 |
| 阶段五：Session Fork 与多会话并行 | ✅ 已复刻可用版本 | 会话分支 API、分支字段、前端分支入口、历史消息复制 | 分支树可视化、按消息节点分支 UI |
| 阶段六：Auto-Compact 增强 | ✅ 已复刻可用版本 | 自动压缩、手动压缩 API、摘要复用、前端压缩入口 | 由模型生成高质量摘要、压缩前后可视化 |
| 阶段七：Git 深度集成 | ✅ 已复刻可用版本 | 数据库级 diff/apply/reject/undo、内部 Git snapshot、审批通过后的 shell/bash 变更记录、Changes 面板 Git 回退 | commit/branch UI、更细粒度的 restore 预览 |
| 阶段八：Provider 扩展与代码格式化 | 🟡 部分完成 | 学生级 OpenAI-compatible provider 配置、连接测试 | Provider 参数转换、格式化工具链 |
| 阶段九：插件系统与 SDK | 🟡 部分完成 | Skills、MCP HTTP JSON-RPC 工具接入 | 插件事件钩子、沙箱化 SDK |

> 标记规则：✅ 表示当前代码已有端到端可用闭环；🟡 表示已有骨架或核心子集；⬜ 表示尚未开始。

---

## 目录

1. [架构对比与复刻策略](#1-架构对比与复刻策略)
2. [阶段一：权限系统（Permission System）](#2-阶段一权限系统)
3. [阶段二：Plan/Build 双模式 Agent](#3-阶段二-planbuild-双模式-agent)
4. [阶段三：LSP 集成（最高价值）](#4-阶段三-lsp-集成)
5. [阶段四：系统提示词工程](#5-阶段四系统提示词工程)
6. [阶段五：Session Fork 与多会话并行](#6-阶段五-session-fork-与多会话并行)
7. [阶段六：Auto-Compact 增强](#7-阶段六-auto-compact-增强)
8. [阶段七：Git 深度集成](#8-阶段七-git-深度集成)
9. [阶段八：Provider 扩展与代码格式化](#9-阶段八-provider-扩展与代码格式化)
10. [阶段九：插件系统与 SDK](#10-阶段九插件系统与-sdk)
11. [附录：OpenCode 关键源代码文件索引](#11-附录opencode-关键源代码文件索引)

---

## 1. 架构对比与复刻策略

### 1.1 OpenCode 核心架构（TypeScript/Bun）

```
┌─────────────────────────────────────────────────┐
│                   Client Layer                    │
│   TUI (OpenTUI+SolidJS) │ Web Console │ Desktop  │
└─────────────────┬───────────────────────────────┘
                  │ HTTP/WebSocket
┌─────────────────▼───────────────────────────────┐
│               Server (port 4096)                 │
│    ┌─────────────────────────────────────────┐  │
│    │          Session Engine                  │  │
│    │  ┌──────────┐  ┌────────────────────┐   │  │
│    │  │  Agent   │  │   Permission Gate  │   │  │
│    │  │  System  │──▶  allow/ask/deny    │   │  │
│    │  └────┬─────┘  └────────────────────┘   │  │
│    │       │                                  │  │
│    │  ┌────▼─────────────────────┐            │  │
│    │  │   Tool Registry (20+)    │            │  │
│    │  └────┬─────────────────────┘            │  │
│    │       │                                  │  │
│    │  ┌────▼─────────────────────┐            │  │
│    │  │   Provider Layer (AI SDK)│            │  │
│    │  └──────────────────────────┘            │  │
│    └─────────────────────────────────────────┘  │
└─────────────────────────────────────────────────┘
```

### 1.2 LabexAgent 当前架构（Java Spring Boot）

```
┌──────────────────────────────────────────────────┐
│                CloudWorkspace.vue (Monaco IDE)     │
│   SSE Stream │ Tool Results │ Diff Viewer │ Plan  │
└───────────────────┬──────────────────────────────┘
                    │ SSE (Server-Sent Events)
┌───────────────────▼──────────────────────────────┐
│         StudentAgentController (REST/SSE)          │
│  ┌──────────────────────────────────────────────┐ │
│  │          AgentLoopEngine                      │ │
│  │  ┌──────────┐  ┌──────────────────────────┐  │ │
│  │  │  Tool    │  │  LlmProvider (OpenAI     │  │ │
│  │  │ Registry │  │  Compatible + MiniMax)   │  │ │
│  │  │  (27)    │  └──────────────────────────┘  │ │
│  │  └──────────┘                                │ │
│  │  ┌──────────────────────────────────────┐    │ │
│  │  │  DiffService (AgentFileChange 表)     │    │ │
│  │  └──────────────────────────────────────┘    │ │
│  └──────────────────────────────────────────────┘ │
└──────────────────────────────────────────────────┘
```

### 1.3 核心差距映射

| OpenCode 概念 | LabexAgent 现有 | 差距 |
|---------------|----------------|------|
| `Permission` 系统 | 无 | **完全缺失** |
| Agent `build` / `plan` 双模式 | 只有一个模式 | **缺失 plan 只读模式** |
| LSP 集成（`diagnostics` 工具） | 无 | **完全缺失** |
| 系统提示词分层架构 | `LabexSystemPrompt.java` 单层 | **需要扩展** |
| Session Fork（子会话） | 单会话 | **缺失** |
| Auto-Compact | `AgentConversationService` 有基础实现 | **需要增强** |
| Git undo/redo | 基于数据库的 Diff 追踪 | **需要 Git 集成** |
| 多 Provider（75+） | 仅 OpenAI 兼容 + MiniMax | **需要扩展** |
| 代码格式化 | 无 | **缺失** |
| 插件系统 | MCP 集成 | **需要扩展** |
| Provider-specific 提示词 | 无 | **缺失** |
| Tool 参数 Schema 校验 | 无 | **需要增强** |

---

## 2. 阶段一：权限系统

### 2.1 OpenCode 源码参考

**核心文件** (`anomalyco/opencode`):
- `packages/opencode/src/permission/index.ts` — 权限引擎（322行）
- `packages/opencode/src/permission/evaluate.ts` — 规则评估
- `packages/opencode/src/permission/schema.ts` — PermissionID Schema
- `packages/opencode/src/permission/arity.ts` — 权限粒度工具

**关键设计**:

```
Permission.Action = "allow" | "deny" | "ask"
Permission.Rule = { permission: string, pattern: string, action: Action }
Permission.Ruleset = Rule[]

评估流程:
1. 根据 {tool_name, input_pattern} 匹配 ruleset
2. "deny" → 抛出 PermissionDeniedError（含匹配到的规则）
3. "allow" → 直接放行
4. "ask" → 通过 Bus 发布 Permission.Asked 事件 → 等待用户回复
   回复选项: "once" | "always" | "reject"
   - "reject" 可附带 feedback → PermissionCorrectedError
   - "always" → 将 pattern 加入 approved 列表，后续自动 allow
```

**Agent 级默认权限** (`agent.ts`):

```
build agent:   question=allow, plan_enter=allow
plan agent:    edit/*=deny(除 plans/*.md 外), question=allow, plan_exit=allow
explore agent: *=deny(仅 grep/glob/list/bash/webfetch/websearch/read/external_directory=allow)
compaction:    *=deny(仅摘要生成用)
```

### 2.2 LabexAgent 实现方案

#### 新增表结构 (`SchemaCompatibilityInitializer.java`)

```java
-- t_agent_permission_rule
CREATE TABLE IF NOT EXISTS t_agent_permission_rule (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    project_id VARCHAR(64) NOT NULL,
    agent VARCHAR(64) NOT NULL DEFAULT 'build',
    permission VARCHAR(64) NOT NULL,   -- 工具名或 '*'
    pattern VARCHAR(255) NOT NULL DEFAULT '*',
    action VARCHAR(16) NOT NULL,       -- allow/deny/ask
    session_id VARCHAR(64),
    created_at BIGINT NOT NULL,
    INDEX idx_project_agent (project_id, agent)
);

-- t_agent_permission_approval (持久化 "always" 批准)
CREATE TABLE IF NOT EXISTS t_agent_permission_approval (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    project_id VARCHAR(64) NOT NULL,
    permission VARCHAR(64) NOT NULL,
    pattern VARCHAR(255) NOT NULL,
    created_at BIGINT NOT NULL,
    INDEX idx_project (project_id)
);
```

#### Java 实现

```java
// PermissionAction.java
public enum PermissionAction {
    ALLOW, DENY, ASK
}

// PermissionRule.java
@Data
public class PermissionRule {
    private String permission;  // 工具名 or "*"
    private String pattern;     // 参数 glob pattern or "*"
    private PermissionAction action;
}

// PermissionService.java — 核心引擎
public class PermissionService {
    // 评估规则链: 项目级 + Agent级默认 + 会话级已批准
    public PermissionAction evaluate(String toolName, String input,
                                     List<PermissionRule> rules) { ... }
    
    // 通配符匹配（支持 * 和 **）
    private boolean wildcardMatch(String pattern, String input) { ... }
    
    // 向用户发送审批请求（通过 SSE 事件通道）
    public void requestApproval(AgentContext ctx, PermissionRule matched,
                                String toolName, String input)
        throws PermissionDeniedException { ... }
}
```

#### 前端 SSE 事件扩展

在 `useAgentStream.js` 中添加事件处理：

```javascript
// 新增事件类型
case 'PERMISSION_ASK': {
    // 展示审批对话框: { permission, patterns, tool }
    // 按钮: 允许一次 | 始终允许 | 拒绝(可附带反馈)
    break;
}
```

#### 修改 Tool.execute 流程

当前 `AgentLoopEngine.execTool()` 中，在每个工具执行前加入：

```java
PermissionAction action = permissionService.evaluate(
    toolName, args.toString(), 
    merge(defaultRules, agentRules, approvedRules)
);

switch (action) {
    case DENY -> throw new PermissionDeniedError(matchedRules);
    case ASK -> {
        // 发送 SSE PERMISSION_ASK 事件
        // 等待用户响应（通过 interrupt/callback）
        // "reject" → PermissionCorrectedError(反馈)
        // "always" → 持久化到 t_agent_permission_approval
    }
    case ALLOW -> proceed();
}
```

### 2.3 Agent 默认权限配置

参照 OpenCode `agent.ts` 在 LabexAgent 中定义：

```java
// 在 AgentLoopEngine 初始化时构建
Map<String, List<PermissionRule>> AGENT_DEFAULT_RULES = Map.of(
    "build", List.of(
        new PermissionRule("*", "*", ALLOW),
        new PermissionRule("question", "*", ALLOW),
        new PermissionRule("plan_enter", "*", ALLOW)
    ),
    "plan", List.of(
        new PermissionRule("*", "*", ASK),
        new PermissionRule("edit", "*", DENY),
        new PermissionRule("edit", ".opencode/plans/*.md", ALLOW),
        new PermissionRule("question", "*", ALLOW),
        new PermissionRule("plan_exit", "*", ALLOW),
        new PermissionRule("shell", "*", DENY)  // plan 模式禁止 shell
    ),
    "explore", List.of(
        new PermissionRule("*", "*", DENY),
        new PermissionRule("grep", "*", ALLOW),
        new PermissionRule("glob", "*", ALLOW),
        new PermissionRule("read", "*", ALLOW),
        new PermissionRule("shell", "*", ALLOW),
        new PermissionRule("websearch", "*", ALLOW),
        new PermissionRule("webfetch", "*", ALLOW)
    )
);
```

---

## 3. 阶段二：Plan/Build 双模式 Agent

### 3.1 OpenCode 源码参考

**核心文件**:
- `packages/opencode/src/agent/agent.ts` — Agent 定义（build, plan, explore, general, compaction, title, summary）
- `packages/opencode/src/agent/generate.txt` — Agent 生成提示词
- `packages/opencode/src/agent/prompt/explore.txt` — Explore agent 提示词
- `packages/opencode/src/agent/prompt/compaction.txt` — Compaction agent 提示词

**关键设计**:

```
Agent 属性:
  - name: string           // 唯一标识
  - description: string    // 对 LLM 可见的描述
  - mode: "subagent" | "primary" | "all"
  - native: boolean        // 内置 agent
  - hidden: boolean        // 对用户隐藏
  - permission: Ruleset    // 权限规则
  - model?: { modelID, providerID }
  - prompt?: string        // 自定义系统提示词
  - options: Record<string, any>

Tab 键切换机制:
  1. 按 Tab → 检查当前 agent
  2. 如果是 plan → 切换到 build
  3. 如果是 build → 切换到 plan
  4. TUI 右下角显示当前 agent 指示器
```

### 3.2 LabexAgent 实现方案

#### 后端修改

**`AgentStreamRequest.java`** 添加 `mode` 字段：

```java
public class AgentStreamRequest {
    private String sessionId;
    private String conversationId;
    private String mode;        // "build" | "plan" | "explore"
    private String message;
    private String activePath;
    private Long modelConfigId;
}
```

**`AgentContext.java`** 添加 `mode`：

```java
public class AgentContext {
    private String mode;  // "build" or "plan"
    
    public boolean isPlanMode() {
        return "plan".equals(mode);
    }
}
```

**`AgentLoopEngine.java`** 修改：

```java
// 1. 根据 mode 切换工具列表
private List<ToolDefinition> buildToolDefinitions(AgentContext ctx) {
    if ("plan".equals(ctx.getMode())) {
        // Plan 模式: 移除写文件类工具
        return allTools.stream()
            .filter(t -> !isWriteTool(t.getName()))
            .collect(Collectors.toList());
    }
    return allTools;
}

private boolean isWriteTool(String name) {
    return Set.of("write_file", "edit_file", "apply_patch", "shell").contains(name);
}

// 2. 系统提示词根据 mode 调整
private String buildSystemPrompt(AgentContext ctx) {
    if ("plan".equals(ctx.getMode())) {
        return PLAN_SYSTEM_PROMPT;  // 只读分析
    }
    return BUILD_SYSTEM_PROMPT;     // 完整执行
}
```

#### Plan 模式系统提示词

参考 OpenCode 的 plan agent 设计：

```java
private static final String PLAN_SYSTEM_PROMPT = """
你是一个代码分析专家，工作在学习者的云工作区中。

## 你的工作模式
你处于 **Plan（计划）模式**。这意味着：
- ✅ 你可以读取文件、搜索代码、浏览目录、运行只读命令
- ✅ 你可以创建/更新 `.opencode/plans/*.md` 中的计划文件
- ✅ 你可以向用户提问以澄清需求
- ❌ 你不能创建、编辑或删除任何项目文件
- ❌ 你不能运行有副作用的命令（编译、构建、测试运行等——需要进入 Build 模式）

## 工作流程
1. 首先理解用户需求
2. 探索代码库中相关的文件和结构
3. 分析影响范围（哪些文件需要修改、新增、删除）
4. 输出一个清晰的实施计划，包含步骤和执行顺序
5. 询问用户是否要切换到 Build 模式来执行计划

## 输出格式
输出计划时使用 Markdown，包含：
- **目标**：需要实现什么
- **影响范围**：需要修改的文件列表
- **实施步骤**：每步的具体操作
- **风险点**：实施时需要注意的问题
""";
```

#### 前端修改

**`CloudWorkspace.vue`** 添加模式切换 UI：

```vue
<template>
  <!-- 模式切换按钮（右下角或底部状态栏） -->
  <div class="agent-mode-indicator">
    <el-button-group size="small">
      <el-button
        :type="agentMode === 'plan' ? 'warning' : 'default'"
        @click="toggleAgentMode"
        :disabled="isStreaming"
      >
        <el-icon><View /></el-icon>
        {{ agentMode === 'plan' ? 'Plan' : 'Build' }}
      </el-button>
      <el-button
        v-if="agentMode === 'plan'"
        size="small"
        type="warning"
        @click="executePlan"
        :disabled="isStreaming"
      >
        执行计划
      </el-button>
    </el-button-group>
  </div>
</template>
```

**`useAgentStream.js`** 添加 mode 支持：

```javascript
const sendMessage = async ({ message, activePath, mode, conversationId, modelConfigId }) => {
    // mode 参数传入 SSE 请求
    const response = await fetch(`/api/student/projects/${projectId}/agent/stream`, {
        method: 'POST',
        body: JSON.stringify({ sessionId, conversationId, mode, message, activePath, modelConfigId }),
    });
};
```

#### `plan_exit` / `plan_enter` 工具

参考 OpenCode 的设计，添加两个元工具：

```java
@Tool(id = "plan_enter", description = "切换到 Plan 模式（只读分析）")
public ToolResult planEnter(AgentContext ctx) {
    ctx.setMode("plan");
    return ToolResult.ok("已切换到 Plan 模式，现在只能读取文件，不能修改。");
}

@Tool(id = "plan_exit", description = "切换到 Build 模式（可以修改文件）")
public ToolResult planExit(AgentContext ctx) {
    ctx.setMode("build");
    return ToolResult.ok("已切换到 Build 模式，现在可以修改文件了。");
}
```

---

## 4. 阶段三：LSP 集成

### 4.1 OpenCode 源码参考

**核心文件**:
- `packages/opencode/src/lsp/` — LSP 客户端实现
- `packages/opencode/src/tool/diagnostics.ts` — 诊断工具

**关键设计**:

```
LSP 客户端:
  - 支持多语言: go(gopls), typescript(typescript-language-server)
  - 配置方式: opencode.json → { lsp: { go: { command: "gopls" } } }
  - 文件监听: 自动通知 LSP server 文件变更
  - 暴露工具: diagnostics(file_path?) → 返回错误/警告列表
```

### 4.2 LabexAgent 实现方案

#### 引入 LSP4J

在 `pom.xml` 中添加依赖：

```xml
<dependency>
    <groupId>org.eclipse.lsp4j</groupId>
    <artifactId>org.eclipse.lsp4j</artifactId>
    <version>0.21.0</version>
</dependency>
<dependency>
    <groupId>org.eclipse.lsp4j</groupId>
    <artifactId>org.eclipse.lsp4j.debug</artifactId>
    <version>0.21.0</version>
</dependency>
```

#### LSP 服务架构

```java
// LspService.java — 语言服务器管理器
@Component
public class LspService {
    private final Map<String, LspLanguageServer> servers = new ConcurrentHashMap<>();
    private final Map<String, String> languageConfig;
    
    // 检测项目语言并启动对应 LSP
    public void startForProject(StudentProject project) {
        // 扫描项目文件类型
        // 匹配 languageConfig → 启动 LSP 进程
        // gopls, typescript-language-server, pyright, jdtls 等
    }
    
    // 获取文件诊断
    public List<Diagnostic> getDiagnostics(String filePath, String language) {
        LspLanguageServer server = servers.get(language);
        if (server == null) return List.of();
        return server.getDiagnostics(filePath);
    }
    
    // 通知文件变更
    public void notifyFileChanged(String filePath, String content) {
        servers.values().forEach(s -> s.didChange(filePath, content));
    }
}

// LspLanguageServer.java — 单个语言服务器抽象
public abstract class LspLanguageServer {
    private Process process;
    private LanguageClient client;
    private LanguageServer server;
    
    public abstract void start(String workspacePath);
    public abstract List<Diagnostic> getDiagnostics(String filePath);
    public abstract void didChange(String filePath, String content);
    public abstract void shutdown();
}
```

#### `diagnostics` 工具

```java
@Tool(id = "diagnostics", description = "获取文件的 LSP 诊断信息（编译错误、警告等）")
public ToolResult runDiagnostics(String filePath, AgentContext ctx) {
    String language = detectLanguage(filePath);
    List<Diagnostic> diagnostics = lspService.getDiagnostics(filePath, language);
    
    if (diagnostics.isEmpty()) {
        return ToolResult.ok("✅ 没有发现错误或警告");
    }
    
    long errors = diagnostics.stream().filter(d -> d.getSeverity() == DiagnosticSeverity.Error).count();
    long warnings = diagnostics.stream().filter(d -> d.getSeverity() == DiagnosticSeverity.Warning).count();
    
    StringBuilder sb = new StringBuilder();
    sb.append(String.format("发现 %d 个错误，%d 个警告：\n\n", errors, warnings));
    for (Diagnostic d : diagnostics) {
        sb.append(String.format("- [%s] 行 %d: %s\n",
            d.getSeverity(), d.getRange().getStart().getLine() + 1, d.getMessage()));
    }
    return ToolResult.ok(sb.toString());
}
```

#### Agent Loop 集成

在每次 `write_file` / `edit_file` / `apply_patch` 执行后，自动调用 diagnostics：

```java
// AgentLoopEngine.java — 在工具执行后的验证步骤
private void verifyAfterEdit(AgentContext ctx, ToolResult result) {
    if (result.getDiff() != null && result.getDiff().getRelativePath() != null) {
        String filePath = result.getDiff().getRelativePath();
        List<Diagnostic> diags = lspService.getDiagnostics(filePath, detectLanguage(filePath));
        
        if (hasErrors(diags)) {
            // 将诊断信息附加到 tool result 中，让 LLM 修正
            result.setLspDiagnostics(formatDiagnostics(diags));
            // 标记需要再次尝试
        }
    }
}
```

---

## 5. 阶段四：系统提示词工程

### 5.1 OpenCode 源码参考

**核心文件**:
- `packages/opencode/src/session/llm.ts` — 提示词组装
- `packages/opencode/src/session/prompt/anthropic.txt` — Claude 专用提示词
- `packages/opencode/src/session/prompt/beast.txt` — OpenAI 专用提示词
- `packages/opencode/src/session/prompt/gemini.txt` — Gemini 专用提示词
- `packages/opencode/src/session/prompt/qwen.txt` — Qwen 等模型提示词

**提示词分层架构**:

```
1. Header（Provider 特定前缀）
   - Anthropic: "You are Claude Code, Anthropic's official CLI for Claude"
   - Others: 空

2. Agent/Provider 指令（核心行为指南）
   - Agent 有自定义 prompt 字段 → 优先使用
   - OpenAI (beast.txt): 自主解决问题、广泛研究、逐步思考、迭代验证
   - Claude (anthropic.txt): 任务管理、Web 获取、详细计划+todos
   - Gemini (gemini.txt): 核心使命、规范、安全、验证工作流
   - Qwen/其他 (qwen.txt): 简洁直接、安全警告

3. 自定义提示词（每次 LLM 调用传入）

4. 用户消息
```

### 5.2 LabexAgent 实现方案

#### 当前架构问题

`LabexSystemPrompt.java` 只有单层结构，不区分 Provider：

```java
public String buildSystemPrompt(Project project, List<ToolDefinition> tools) {
    return identity() + "\n"
         + environment(project) + "\n"
         + workflow() + "\n"
         + toolPolicy(tools) + "\n"
         + ...;
}
```

#### 新架构：Provider 特定的提示词

```java
// LabexSystemPrompt.java 重构
public class LabexSystemPrompt {
    
    private static final Map<String, String> PROVIDER_PROMPTS = Map.of(
        "openai_compatible", loadPrompt("prompts/beast.txt"),
        "minimax", loadPrompt("prompts/minimax.txt"),
        "default", loadPrompt("prompts/default.txt")
    );
    
    public String buildSystemPrompt(
            Project project,
            List<ToolDefinition> tools,
            String providerId,
            String mode,       // "build" | "plan"
            String agentName,
            List<Skill> skills,
            List<McpServer> mcpServers) {
        
        StringBuilder sb = new StringBuilder();
        
        // 1. Identity（所有 Provider 通用）
        sb.append(identity(agentName));
        
        // 2. Environment（项目上下文）
        sb.append(environment(project));
        
        // 3. Workflow（根据 mode 不同）
        sb.append("build".equals(mode) ? buildWorkflow() : planWorkflow());
        
        // 4. Tool Definitions
        sb.append(toolPolicy(tools));
        
        // 5. Provider 特定行为指南
        sb.append(PROVIDER_PROMPTS.getOrDefault(providerId, PROVIDER_PROMPTS.get("default")));
        
        // 6. Skills Context
        if (!skills.isEmpty()) {
            sb.append(skillsPrompt(skills));
        }
        
        // 7. MCP Tools Context
        if (!mcpServers.isEmpty()) {
            sb.append(mcpPrompt(mcpServers));
        }
        
        return sb.toString();
    }
}
```

#### 新增提示词文件

**`backend/src/main/resources/prompts/default.txt`** — 通用行为指南：

```
## 行为指南

- 使用清晰的结构化 Markdown 输出
- 先理解需求，再执行操作
- 每次修改文件后检查是否有错误
- 如果发现操作可能导致数据丢失，先询问用户
- 遇到编译错误时，分析根因并修复，不要重复尝试相同方案
```

**`backend/src/main/resources/prompts/beast.txt`** — OpenAI 兼容模型优化（参考 OpenCode）：

```
## 自主问题解决

- 使用分步思考处理复杂问题
- 广泛探索代码库以理解完整的上下文
- 使用迭代验证确保每次修改的正确性
- 遇到测试失败时，分析失败原因而不是随机尝试
- 优先使用 `project_overview` 工具获取项目结构
```

**`backend/src/main/resources/prompts/llm.txt`** — 所有模型通用：

```
## 核心原则

1. **安全第一**: 不删除用户文件，不运行危险命令
2. **可验证**: 每次修改都应可被验证（运行测试 / 编译检查 / LSP 诊断）
3. **透明**: 解释你在做什么以及为什么
4. **高效**: 使用最直接的方式解决问题
```

---

## 6. 阶段五：Session Fork 与多会话并行

### 6.1 OpenCode 源码参考

**核心文件**:
- `packages/opencode/src/session/session.ts` — Session 管理（create, fork, children）
- `packages/opencode/src/session/schema.ts` — SessionID, MessageID Schema

**关键设计**:

```
Session 父子层级:
  - parentID 字段 → 支持 fork 分支
  - fork({sessionID, messageID?}) → 创建子会话
  - children(parentID) → 查看分支
  - 每个 session 独立运行、独立上下文

多会话并行:
  - Ctrl+N → 创建新 session
  - Ctrl+A → 切换 session
  - 每个 session 有独立的 agent、model、permission 配置
  - 后台 session 继续运行（通过 BackgroundJob）
```

### 6.2 LabexAgent 实现方案

#### 后端 Session Fork

```java
// 在 StudentAgentController.java 添加
@PostMapping("/session/{sessionId}/fork")
public Result<SessionDTO> forkSession(@PathVariable String sessionId,
                                       @RequestParam(required = false) String messageId) {
    // 1. 获取原会话
    // 2. 创建子会话（复制 title + " (fork #N)"）
    // 3. 复制到 messageId 为止的消息
    // 4. 返回子会话信息
}
```

#### 前端多 Tab 支持

**`CloudWorkspace.vue`** 添加 Tab 栏：

```vue
<template>
  <div class="workspace-container">
    <div class="session-tabs">
      <el-tabs
        v-model="activeSessionId"
        type="card"
        closable
        @tab-remove="closeSession"
        @tab-add="createSession"
      >
        <el-tab-pane
          v-for="session in sessions"
          :key="session.id"
          :label="session.title"
          :name="session.id"
          :closable="sessions.length > 1"
        />
      </el-tabs>
    </div>
    <!-- 聊天区（绑定到 activeSessionId） -->
    <ChatArea :session-id="activeSessionId" />
  </div>
</template>
```

**`useAgentStream.js`** 添加多 Session 支持：

```javascript
const sessions = ref(new Map());  // sessionId → { messages, isStreaming, ... }

const switchSession = (sessionId) => {
    currentSessionId.value = sessionId;
};

const createSession = async () => {
    const res = await projectApi.agentCreateSession(projectId);
    sessions.value.set(res.data.conversationId, {
        conversationId: res.data.conversationId,
        messages: [],
        isStreaming: false,
    });
};
```

---

## 7. 阶段六：Auto-Compact 增强

### 7.1 OpenCode 源码参考

**核心文件**:
- `packages/opencode/src/agent/agent.ts` — compaction agent definition
- `packages/opencode/src/agent/prompt/compaction.txt` — compaction 提示词
- `packages/opencode/src/agent/prompt/summary.txt` — summary 提示词

**Auto-Compact 机制**:

```
1. 监控 token 使用量（默认达到 95% 上下文窗口时触发）
2. 自动创建 compaction agent 会话
3. compaction agent 总结历史（输入旧会话消息）
4. 输出结构化的 anchored summary
5. 创建新 session（child session），以 summary 作为初始上下文
6. 继续执行，用户无感知
```

### 7.2 LabexAgent 现有实现

`AgentConversationService` 已有：
- `compactConversation()` — 手动压缩
- `autoCompactIfNeeded()` — 自动触发检查（16K 字符阈值）
- `MEMORY_CONTEXT_LIMIT = 12000` 等常量

### 7.3 增强方案

```java
// AgentConversationService.java 增强

private static final double COMPACT_THRESHOLD_RATIO = 0.95;  // 95%
private static final int MAX_TOKENS_PER_MODEL = 128000;      // 模型上下文窗口

public boolean autoCompactIfNeeded(AgentConversation conversation) {
    // 1. 估算当前 token 使用
    long usedTokens = estimateTokenUsage(conversation);
    long maxTokens = getModelContextWindow(conversation.getModel());
    
    // 2. 达到阈值 → 触发压缩
    if (usedTokens > maxTokens * COMPACT_THRESHOLD_RATIO) {
        compactConversation(conversation);
        return true;
    }
    return false;
}

private long estimateTokenUsage(AgentConversation conversation) {
    // 基于消息长度粗略估算
    List<AgentMessage> messages = getMessages(conversation.getConversationId());
    return messages.stream()
        .mapToLong(m -> estimateTokens(m.getContent()))
        .sum();
}

private long getModelContextWindow(String model) {
    // 不同模型的上下文窗口
    Map<String, Long> windows = Map.of(
        "MiniMax-M2.7", 128000L,
        "gpt-4", 128000L,
        "claude-3-sonnet", 200000L
    );
    return windows.getOrDefault(model, 128000L);
}
```

#### Summary Agent 提示词（参考 OpenCode）：

```java
private static final String SUMMARY_PROMPT = """
Summarize what was done in this conversation. Write like a pull request description.

Rules:
- 2-3 sentences max
- Describe the changes made, not the process
- Do not mention running tests, builds, or other validation steps
- Do not explain what the user asked for
- Write in first person (I added..., I fixed...)
- Never ask questions or add new questions
""";
```

#### Compaction Agent 提示词（参考 OpenCode）：

```java
private static final String COMPACTION_PROMPT = """
You are an anchored context summarization assistant for coding sessions.

Summarize only the conversation history you are given. The newest turns may be kept verbatim outside your summary, so focus on the older context that still matters for continuing the work.

If the prompt includes a <previous-summary> block, treat it as the current anchored summary. Update it with the new history by preserving still-true details, removing stale details, and merging in new facts.

Always follow the exact output structure requested by the user prompt. Keep every section, preserve exact file paths and identifiers when known, and prefer terse bullets over paragraphs.

Do not answer the conversation itself. Do not mention that you are summarizing, compacting, or merging context.
""";
```

---

## 8. 阶段七：Git 深度集成

### 8.1 OpenCode Git 集成

OpenCode 在 diff 追踪层面直接依赖 Git：
- `/undo` → `git checkout` 恢复文件
- `/redo` → 重新应用
- 每次变更自动 `git commit --allow-empty`
- `revert` 字段记录在 session 中

### 8.2 LabexAgent 实现方案

**当前**：LabexAgent 使用 `AgentFileChange` 数据库表追踪变更，不依赖 Git。

**增强方案**（可选，低优先级）：

```java
// GitDiffService.java — Git 集成选项
@Component
public class GitDiffService {
    
    public void autoCommitBeforeChange(StudentProject project, String relativePath) {
        // 在修改前自动 git add + git commit
        git.run(project, "add", relativePath);
        git.run(project, "commit", "-m", `"feat: AI agent change - ${relativePath}"`);
    }
    
    public void undoLastChange(StudentProject project) {
        // git revert HEAD
        git.run(project, "revert", "--no-edit", "HEAD");
    }
    
    public String getDiff(StudentProject project, String filePath) {
        return git.run(project, "diff", "HEAD~1", "--", filePath);
    }
}
```

**配置选项**：在 `AgentStreamRequest` 中添加 `useGit: boolean` 参数，默认 false（保持数据库追踪为主）。

---

## 9. 阶段八：Provider 扩展与代码格式化

### 9.1 Provider 扩展

**当前**：`LlmProviderFactory` + `OpenAiCompatibleProvider`，只支持 OpenAI 兼容。

**扩展方案**：

```java
// 新增 Provider 预设模板
public enum ProviderTemplate {
    OPENAI("openai", "https://api.openai.com/v1", List.of("gpt-4o", "gpt-4.1", "o3")),
    ANTHROPIC("anthropic", "https://api.anthropic.com/v1", List.of("claude-sonnet-4", "claude-3.5-sonnet")),
    GOOGLE("google", "https://generativelanguage.googleapis.com/v1beta", List.of("gemini-2.5-pro")),
    DEEPSEEK("deepseek", "https://api.deepseek.com/v1", List.of("deepseek-chat")),
    OLLAMA("ollama", "http://localhost:11434/v1", List.of("llama3", "qwen2.5")),
    OPENROUTER("openrouter", "https://openrouter.ai/api/v1", List.of("*")),
    CUSTOM("custom", "", List.of());
}
```

在 `AgentModelConfigController.providers()` 中返回所有模板：

```javascript
// 前端 agentExtensionApi 或 modelConfigApi
getProviders() → [
  { id: "openai", name: "OpenAI", models: ["gpt-4o", ...] },
  { id: "anthropic", name: "Anthropic", models: ["claude-sonnet-4", ...] },
  { id: "google", name: "Google Gemini", models: ["gemini-2.5-pro", ...] },
  { id: "ollama", name: "Ollama (本地)", models: ["llama3", ...] },
  { id: "openrouter", name: "OpenRouter", models: ["*"] },
  { id: "custom", name: "自定义", models: ["*"] },
]
```

### 9.2 代码格式化

**方案**：

```java
// CodeFormatterService.java
@Component
public class CodeFormatterService {
    
    public String format(String code, String filePath) {
        String ext = getExtension(filePath);
        return switch (ext) {
            case "java" -> formatJava(code);
            case "js", "ts", "jsx", "tsx" -> formatPrettier(code, ext);
            case "json", "yaml", "yml", "md" -> formatPrettier(code, ext);
            case "css", "scss", "less" -> formatPrettier(code, ext);
            case "py" -> formatBlack(code);
            case "go" -> formatGoFmt(code);
            default -> code;  // 不支持的不格式化
        };
    }
}
```

在 `DiffService.apply()` 中调用：

```java
public void apply(String studentId, String changeId) {
    PendingChange change = getChange(studentId, changeId);
    
    // 应用前先格式化
    String formatted = codeFormatterService.format(change.getAfterContent(), change.getRelativePath());
    change.setAfterContent(formatted);
    
    // 写入磁盘
    writeFile(change.getRelativePath(), formatted);
}
```

---

## 10. 阶段九：插件系统与 SDK

### 10.1 OpenCode 插件架构

**核心文件**:
- `packages/plugin/` — 插件 API 包
- `packages/sdk/` — JavaScript SDK

**插件能力**:
1. **添加自定义工具** — 注册新的 `ToolDefinition`
2. **事件钩子** — `tool.execute.before`, `tool.execute.after`, `session.compacting`
3. **Provider auth** — 自定义认证流程
4. **消息转换** — 拦截和修改消息

### 10.2 LabexAgent 插件方案

**当前**：已有 MCP 集成 (`McpCallTool` + `AgentMcpServer`)，支持 HTTP JSON-RPC 的 MCP 工具。

**扩展方向**：

```java
// AgentPlugin.java — 插件接口
public interface AgentPlugin {
    String getId();
    String getName();
    
    // 工具注册
    default List<AgentTool> getTools() { return List.of(); }
    
    // 事件钩子
    default void onToolExecuteBefore(ToolCall call, AgentContext ctx) {}
    default void onToolExecuteAfter(ToolResult result, AgentContext ctx) {}
    default void onSessionCompact(AgentConversation conv) {}
    default void onSessionCreate(AgentConversation conv) {}
    
    // 初始化/销毁
    default void init(AgentPluginContext ctx) {}
    default void destroy() {}
}
```

**插件加载**：支持从 `.opencode/plugins/*.jar` 或 `plugins/*.class` 加载。

---

## 11. 附录：OpenCode 关键源代码文件索引

> 以下文件来自 `anomalyco/opencode` (branch: dev) GitHub 仓库

### 核心引擎

| 文件 | 说明 |
|------|------|
| `packages/opencode/src/agent/agent.ts` | Agent 定义（build/plan/explore/compaction/title/summary） |
| `packages/opencode/src/agent/generate.txt` | Agent 生成提示词 |
| `packages/opencode/src/agent/prompt/explore.txt` | Explore agent 提示词 |
| `packages/opencode/src/agent/prompt/compaction.txt` | Compaction agent 提示词 |
| `packages/opencode/src/agent/prompt/title.txt` | Title agent 提示词 |
| `packages/opencode/src/agent/prompt/summary.txt` | Summary agent 提示词 |

### 权限系统

| 文件 | 说明 |
|------|------|
| `packages/opencode/src/permission/index.ts` | 权限引擎（322行） |
| `packages/opencode/src/permission/evaluate.ts` | 规则评估 |
| `packages/opencode/src/permission/schema.ts` | PermissionID Schema |
| `packages/opencode/src/permission/arity.ts` | 权限粒度 |

### 工具系统

| 文件 | 说明 |
|------|------|
| `packages/opencode/src/tool/tool.ts` | 工具定义 API（Tool.define, Tool.Context, ExecuteResult） |
| `packages/opencode/src/tool/truncate.ts` | 工具输出截断 |
| `packages/opencode/src/tool/read.ts` | read_file 工具 |
| `packages/opencode/src/tool/edit.ts` | edit_file 工具 |
| `packages/opencode/src/tool/diagnostics.ts` | LSP Diagnostics 工具 |

### Session 管理

| 文件 | 说明 |
|------|------|
| `packages/opencode/src/session/session.ts` | Session CRUD、Fork、Messages、Events |
| `packages/opencode/src/session/message-v2.ts` | 消息格式（User/Assistant/Tool/Compaction parts） |
| `packages/opencode/src/session/schema.ts` | SessionID、MessageID、PartID 定义 |
| `packages/opencode/src/session/llm.ts` | 系统提示词组装 + LLM 流式调用 |

### 提示词（Provider 特定）

| 文件 | 说明 |
|------|------|
| `packages/opencode/src/session/prompt/anthropic.txt` | Claude 专用行为指南 |
| `packages/opencode/src/session/prompt/beast.txt` | OpenAI GPT 系列行为指南 |
| `packages/opencode/src/session/prompt/gemini.txt` | Gemini 行为指南 |
| `packages/opencode/src/session/prompt/qwen.txt` | Qwen 等模型行为指南 |

### Provider / LLM

| 文件 | 说明 |
|------|------|
| `packages/opencode/src/provider/provider.ts` | Provider 抽象 + 模型解析 |
| `packages/opencode/src/provider/transform.ts` | Provider 特定参数转换 |

### Plugin / SDK

| 文件 | 说明 |
|------|------|
| `packages/plugin/src/index.ts` | 插件 API 定义 |
| `packages/sdk/` | JavaScript SDK |

---

## 实施路线图

| 阶段 | 功能 | 工作量估算 | 优先级 | 依赖 |
|------|------|-----------|--------|------|
| **P0** | 权限系统（Permission Gate） | 3-5 天 | 🔴 最高 | 无 |
| **P1** | Plan/Build 双模式 | 2-3 天 | 🔴 高 | 权限系统 |
| **P1** | LSP 集成 | 5-7 天 | 🔴 高 | 无 |
| **P2** | 提示词工程重构 | 2-3 天 | 🟡 中 | 双模式 |
| **P2** | Provider 模板扩展 | 1-2 天 | 🟡 中 | 无 |
| **P2** | Session Fork + 多 Tab | 3-4 天 | 🟡 中 | 无 |
| **P3** | Auto-Compact 增强 | 1-2 天 | 🟢 低 | 提示词工程 |
| **P3** | 代码格式化 | 1-2 天 | 🟢 低 | 无 |
| **P3** | Git 深度集成 | 2-3 天 | 🟢 低 | 无 |
| **P4** | 插件系统 | 5-7 天 | ⚪ 可选 | 权限系统 |

**推荐启动顺序**：
1. **权限系统**（所有其他功能的基础）
2. **LSP 集成**（最高用户价值）
3. **Plan/Build 双模式**（用户体验核心差异）
4. 并行：**Provider 扩展** + **提示词工程重构**
5. **Session Fork** + **Auto-Compact 增强**
6. 收尾：**代码格式化** + **Git 集成**
