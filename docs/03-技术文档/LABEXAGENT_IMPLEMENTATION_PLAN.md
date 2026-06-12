# LabexAgent 功能完善实施计划

> 参考公开 Agent 项目架构设计，结合当前项目已有后端能力，系统性补齐前端交互和功能缺口。

---

## 一、现状总览

### 后端已具备（成熟度高）

| 模块 | 能力 | 状态 |
|------|------|------|
| Agent 循环引擎 | while-true tool-calling loop, 质量门禁, 错误恢复, checkpoint | ✅ 完成 |
| 22+ 工具集 | 文件读写编辑, 搜索, Shell, 计划, Web, 代码执行 | ✅ 完成 |
| SSE 流式推送 | AgentSsePublisher + 完整事件类型 | ✅ 完成 |
| 会话管理 | 持久化, 自动压缩, 摘要, 内存上下文 | ✅ 完成 |
| 任务追踪 | AgentTaskService, 状态机, 变更集 | ✅ 完成 |
| Diff 系统 | 文件变更暂存, 应用/拒绝/撤销 | ✅ 完成 |
| Checkpoint | 断点恢复, 运行日志 | ✅ 完成 |
| 斜杠命令 | /init, /index, /compact, /doctor 等 | ✅ 完成 |
| 安全检查 | 危险命令拦截, 路径安全 | ✅ 完成 |
| Prompt 优化 | optimizePrompt 端点 | ✅ 完成 |

### 前端现状（UI 壳子，核心交互缺失）

| 功能 | 状态 | 说明 |
|------|------|------|
| AI 面板布局 | ✅ | 顶栏, 标签页, 上下文指示器, 输入框 |
| 基础对话 | ⚠️ | 使用 REST `askAgent()` 而非 SSE 流式 |
| SSE 流式连接 | ❌ | 未接入 `/agent/stream` 端点 |
| Agent 事件渲染 | ❌ | THINK/TOOL_CALL/OBSERVE 未展示 |
| 计划/任务看板 | ❌ | 后端有 PLAN_UPDATE 事件，前端无 UI |
| 工具调用可视化 | ❌ | 无工具执行状态展示 |
| Diff 查看器 | ❌ | 后端生成 unified diff，前端无渲染 |
| 变更面板 | ❌ | 无待定变更列表, 无应用/拒绝/撤销 |
| 命令审批弹窗 | ❌ | COMMAND_APPROVAL_REQUIRED 事件未处理 |
| 中断/取消 | ❌ | stopGeneration 仅设本地状态，未调后端 |
| 会话历史 | ❌ | 无历史会话列表/加载 |
| Review 标签页 | ❌ | 硬编码 mock 数据 |
| Terminal 标签页 | ❌ | 硬编码 mock 数据 |
| Prompt 优化 | ❌ | 后端已实现，前端显示"开发中" |
| @文件引用 | ❌ | 未接线 |
| 插入编辑器 | ❌ | 未实现 |
| 模型配置 | ❌ | 按钮存在，无配置 UI |
| 会话持久化 | ❌ | 刷新后消息丢失 |

---

## 二、参考开源 Agent 核心设计理念

| 参考设计 | LabexAgent 适配方案 |
|---------------|---------------------|
| Effect-TS 类型安全 | Java 强类型 + DTO 校验 |
| Schema-first 工具定义 | ToolDefinition Builder 模式 |
| Agent Loop with streaming events | 已有 SSE 事件体系，需前端对接 |
| Permission system (allow/deny/ask) | 已有 ProjectCommandSafety，需前端审批 UI |
| Tool registry with auto-discovery | 已有 Spring @Component 自动注册 |
| Session compaction | 已有 auto-compaction + summary |
| Checkpoint & resume | 已有 .labex/agent-checkpoint.md |
| Plugin hooks | 可通过 Spring AOP 扩展 |
| Task tool (subagent) | 已有 TaskTool + AgentTaskService |
| Snapshot tracking | 可基于 DiffService 扩展 |

---

## 三、分阶段实施计划

### Phase 1：SSE 流式连接 + 基础事件渲染（核心，优先级最高）

**目标：** 将前端从 REST 轮询切换到 SSE 流式，实现打字机效果的实时输出。

#### 1.1 前端 SSE 连接层

**文件：** `frontend/src/api/index.js`

```
新增 projectApi.agentStream(projectId, data) 方法：
- 使用 fetch() + ReadableStream 处理 SSE
- 解析 SSE 事件流（event: xxx\ndata: xxx 格式）
- 返回 AsyncGenerator 或 EventBus 供组件消费
- 支持 AbortController 中断
```

**关键实现：**
- SSE 端点：`POST /student/projects/{projectId}/agent/stream`
- 请求体：`{ sessionId, conversationId, mode, message, activePath }`
- 事件解析：按 `\n\n` 分割，解析 `event:` 和 `data:` 行

#### 1.2 Agent 事件处理器

**新文件：** `frontend/src/composables/useAgentStream.js`

```javascript
// 职责：
// 1. 管理 SSE 连接生命周期
// 2. 解析事件类型分发到对应 handler
// 3. 维护消息状态（thinking, toolCalls, finalAnswer）
// 4. 处理错误和重连

事件映射：
SESSION        → 初始化会话元数据
THINK_START    → 开始显示思考过程
THINK_DELTA    → 追加思考内容（流式）
THINK          → 思考完成
TOOL_CALL      → 显示工具调用（名称+参数）
OBSERVE        → 显示工具结果
PLAN_UPDATE    → 更新任务看板
FINAL_DELTA    → 流式追加最终回答（打字机效果）
FINAL          → 最终回答完成
DONE           → 标记完成
ERROR          → 显示错误
INTERRUPTED    → 标记中断
COMMAND_APPROVAL_REQUIRED → 弹出审批对话框
```

#### 1.3 消息状态模型

**新文件：** `frontend/src/composables/agentState.js`

```javascript
// 消息结构
{
  id: string,
  role: 'user' | 'assistant',
  content: string,          // 最终文本
  thinking: string,         // 思考过程
  toolCalls: [{             // 工具调用列表
    name: string,
    args: object,
    result: string,
    status: 'running' | 'completed' | 'error',
    startTime: number,
    endTime: number
  }],
  plan: [{                  // 计划项
    step: number,
    description: string,
    status: 'pending' | 'in_progress' | 'completed'
  }],
  isStreaming: boolean,
  error: string | null
}
```

#### 1.4 CloudWorkspace.vue 改造

**修改文件：** `frontend/src/views/student/CloudWorkspace.vue`

- `sendMessage()` 改为调用 `agentStream()` 而非 `askAgent()`
- 监听 SSE 事件，实时更新消息状态
- `stopGeneration()` 调用 `/agent/interrupt` 端点
- 消息列表支持渲染 thinking/toolCall/diff 内容

---

### Phase 2：工具调用可视化 + 思考过程展示

**目标：** 展示 Agent 的思考过程和每个工具调用的详情。

#### 2.1 思考过程组件

**新文件：** `frontend/src/components/agent/AgentThinking.vue`

- 可折叠的思考卡片
- 流式显示 THINK_DELTA 内容
- 支持 Markdown 渲染
- 淡入动画

#### 2.2 工具调用卡片

**新文件：** `frontend/src/components/agent/AgentToolCall.vue`

```
卡片结构：
┌─────────────────────────────────────┐
│ 🔧 read_file                       │
│ 📄 src/main.java                    │
│ ⏱ 0.3s                             │
├─────────────────────────────────────┤
│ 参数: { path: "src/main.java" }     │
│ 结果: [成功] 返回 245 行            │
└─────────────────────────────────────┘

状态指示器：
- running: 旋转图标 + 蓝色边框
- completed: 绿色勾 + 耗时
- error: 红色叉 + 错误信息
```

#### 2.3 工具调用图标映射

```javascript
const toolIcons = {
  read_file: '📄', write_file: '✏️', edit_file: '🔧',
  bash: '🖥️', shell: '🖥️', grep: '🔍', glob: '📁',
  search_code: '🔎', create_plan: '📋', web_fetch: '🌐',
  // ... 每个工具对应一个 SVG 图标
}
```

---

### Phase 3：计划/任务看板

**目标：** 可视化展示 Agent 的任务计划和执行进度。

#### 3.1 任务看板组件

**新文件：** `frontend/src/components/agent/AgentPlanBoard.vue`

```
┌─────────────────────────────────────┐
│ 📋 任务计划                    3/5  │
├─────────────────────────────────────┤
│ ✅ 1. 分析项目结构                  │
│ ✅ 2. 读取配置文件                  │
│ 🔄 3. 修改 UserService.java        │
│ ⬜ 4. 添加单元测试                  │
│ ⬜ 5. 更新文档                      │
├─────────────────────────────────────┤
│ 进度条: ████████░░░░ 60%            │
└─────────────────────────────────────┘
```

#### 3.2 后端事件对接

- `PLAN_UPDATE` 事件携带 `{ plan: [{step, description, status}] }`
- 前端接收后更新看板状态
- 每个步骤状态变化时触发 UI 更新

---

### Phase 4：Diff 查看器 + 变更面板

**目标：** 展示 Agent 修改的文件差异，支持应用/拒绝/撤销。

#### 4.1 Diff 查看器组件

**新文件：** `frontend/src/components/agent/AgentDiffViewer.vue`

```
使用 Monaco Editor 的 DiffEditor 模式：
- 左侧：修改前（只读）
- 右侧：修改后（只读）
- 行级差异高亮
- 支持并排/内联视图切换
```

#### 4.2 变更面板

**新文件：** `frontend/src/components/agent/AgentChangesPanel.vue`

```
┌─────────────────────────────────────┐
│ 📝 待审变更 (3)              全部应用 │
├─────────────────────────────────────┤
│ 📄 src/UserService.java    +12 -3  │
│    [查看] [应用] [拒绝]             │
│ 📄 src/UserController.java +5 -1   │
│    [查看] [应用] [拒绝]             │
│ 📄 tests/UserServiceTest.java +45  │
│    [查看] [应用] [拒绝]             │
├─────────────────────────────────────┤
│ 已应用 (2)  已拒绝 (1)             │
└─────────────────────────────────────┘
```

#### 4.3 API 对接

```
后端已有端点：
GET  /student/projects/{id}/changes          → 获取变更列表
POST /student/projects/{id}/changes/{id}/apply  → 应用变更
POST /student/projects/{id}/changes/{id}/reject → 拒绝变更
POST /student/projects/{id}/changes/undo        → 撤销上一步
```

---

### Phase 5：命令审批 + 中断控制

**目标：** 危险命令执行前弹出审批对话框，支持中断 Agent 执行。

#### 5.1 命令审批弹窗

**新文件：** `frontend/src/components/agent/AgentCommandApproval.vue`

```
┌─────────────────────────────────────┐
│ ⚠️ 危险命令审批                      │
├─────────────────────────────────────┤
│ 命令: rm -rf /tmp/build             │
│ 风险等级: 🔴 高                      │
│ 原因: 删除操作不可逆                  │
├─────────────────────────────────────┤
│     [拒绝]        [允许一次]         │
└─────────────────────────────────────┘
```

#### 5.2 中断控制

```javascript
// 前端
async function stopGeneration() {
  await projectApi.agentInterrupt(projectId, sessionId)
  agentState.value.isStreaming = false
}

// 后端已有端点
POST /student/projects/{id}/agent/interrupt
Body: { sessionId }
→ 将 sessionId 加入 AgentCancellationRegistry
```

---

### Phase 6：会话管理

**目标：** 支持历史会话列表、加载、删除、新建。

#### 6.1 会话列表侧边栏

**新文件：** `frontend/src/components/agent/AgentSessionList.vue`

```
┌─────────────────────────────────────┐
│ 💬 会话列表                   [新建] │
├─────────────────────────────────────┤
│ 📅 2024-01-15 14:30                 │
│    "帮我修改 UserService 的..."      │
│    [加载] [删除]                     │
│ 📅 2024-01-14 09:15                 │
│    "分析这个项目的架构..."            │
│    [加载] [删除]                     │
└─────────────────────────────────────┘
```

#### 6.2 API 对接

```
后端已有端点：
GET    /student/projects/{id}/conversations           → 会话列表
GET    /student/projects/{id}/conversations/{convId}  → 会话详情+消息
DELETE /student/projects/{id}/conversations/{convId}  → 删除会话
```

---

### Phase 7：Review 标签页（真实代码审查）

**目标：** 接入真实的代码审查功能。

#### 7.1 实现方案

```
触发方式：用户点击 Review 标签页时，调用 Agent 的 review 模式
POST /student/projects/{id}/agent/stream
Body: { mode: "review", message: "审查当前文件的代码质量", activePath: "..." }

后端 Agent 会使用以下工具：
- read_file → 读取文件
- grep/glob → 搜索相关文件
- search_code → 查找代码模式

前端渲染：
- THINK 事件 → 显示审查思考过程
- FINAL 事件 → 解析结构化审查结果
- 严重等级映射：error/warning/info
```

#### 7.2 结构化输出解析

```javascript
// Agent 返回格式（在 FINAL 事件中）
{
  issues: [
    { severity: "error", file: "src/UserService.java", line: 45, message: "空指针", suggestion: "..." },
    { severity: "warning", file: "src/utils.js", line: 12, message: "未使用变量", fixable: true }
  ],
  score: 85
}
```

---

### Phase 8：Terminal 标签页（真实命令执行）

**目标：** 接入真实的命令生成和执行。

#### 8.1 实现方案

```
命令生成：
POST /student/projects/{id}/agent/stream
Body: { mode: "code", message: "生成命令: {用户描述}" }

命令执行：
POST /student/projects/{id}/terminal/run
Body: { command: "npm run dev", path: "...", timeoutSeconds: 60 }

显示最近 3 条命令历史 + 输出
```

#### 8.2 推荐命令

```javascript
// 根据项目类型自动推荐
const recommendedCommands = {
  vue: ['npm run dev', 'npm run build', 'npm test'],
  react: ['npm start', 'npm run build', 'npm test'],
  springboot: ['mvn spring-boot:run', 'mvn test', 'mvn package'],
  flask: ['python run.py', 'pip install -r requirements.txt'],
  python: ['python main.py', 'pytest', 'pip install -r requirements.txt']
}
```

---

### Phase 9：@文件引用 + 插入编辑器

**目标：** 支持在对话中引用文件，以及将 AI 生成的代码插入编辑器。

#### 9.1 @文件引用

```javascript
// 用户输入 @ 时弹出文件选择器
// 选择后将文件路径和内容附加到上下文
function atFile() {
  // 弹出文件选择弹窗
  // 选择文件后：
  selectedContext.value = {
    type: 'file',
    path: selectedPath,
    content: fileContent
  }
}
```

#### 9.2 插入编辑器

```javascript
// 点击消息中的"插入"按钮
function insertToEditor(content) {
  // 获取 Monaco Editor 实例
  const editor = monacoRef.value
  const selection = editor.getSelection()
  // 在光标位置插入
  editor.executeEdits('agent-insert', [{
    range: selection,
    text: content
  }])
}
```

---

### Phase 10：模型配置 + Prompt 优化

#### 10.1 模型配置弹窗

**新文件：** `frontend/src/components/agent/AgentModelConfig.vue`

```
┌─────────────────────────────────────┐
│ ⚙️ 模型配置                          │
├─────────────────────────────────────┤
│ 模型提供商: [MiniMax ▾]              │
│ 模型名称:   [abab6.5s-chat ▾]       │
│ Temperature: [0.7] (0-2)            │
│ Max Tokens:  [4096]                 │
│ Top P:       [0.9]                  │
├─────────────────────────────────────┤
│     [取消]        [保存]             │
└─────────────────────────────────────┘
```

#### 10.2 Prompt 优化

```javascript
// 后端已有端点
POST /student/projects/{id}/agent/optimize-prompt
Body: { prompt: "用户输入的原始提示词" }
→ 返回优化后的提示词

// 前端实现
async function optimizePrompt() {
  const optimized = await projectApi.optimizePrompt(projectId, agentInput.value)
  agentInput.value = optimized
}
```

---

## 四、技术架构图

```
┌─────────────────────────────────────────────────────────┐
│                    CloudWorkspace.vue                    │
│  ┌──────────┬──────────────────┬─────────────────────┐  │
│  │ FileTree │  Monaco Editor   │   AI Panel (30%)    │  │
│  │          │                  │  ┌───────────────┐  │  │
│  │          │                  │  │  Top Bar      │  │  │
│  │          │                  │  │  Context      │  │  │
│  │          │                  │  │  Tabs         │  │  │
│  │          │                  │  │  ┌─────────┐  │  │  │
│  │          │                  │  │  │ Chat    │  │  │  │
│  │          │                  │  │  │ Review  │  │  │  │
│  │          │                  │  │  │ Terminal│  │  │  │
│  │          │                  │  │  └─────────┘  │  │  │
│  │          │                  │  │  Input Area   │  │  │
│  │          │                  │  │  Status Bar   │  │  │
│  │          │                  │  └───────────────┘  │  │
│  └──────────┴──────────────────┴─────────────────────┘  │
└─────────────────────────────────────────────────────────┘
         │                              │
         │ REST API                     │ SSE Stream
         │                              │
┌────────┴──────────────────────────────┴────────────────┐
│                   Spring Boot Backend                   │
│  ┌──────────────────────────────────────────────────┐  │
│  │            StudentProjectController               │  │
│  │  /agent/stream  /agent/interrupt  /changes/*     │  │
│  └──────────────┬──────────────────┬────────────────┘  │
│                 │                  │                    │
│  ┌──────────────┴──┐  ┌───────────┴────────────────┐  │
│  │ AgentLoopEngine │  │ AgentConversationService   │  │
│  │ (tool-calling)  │  │ (persistence, memory)      │  │
│  └──────┬──────────┘  └────────────────────────────┘  │
│         │                                              │
│  ┌──────┴──────────────────────────────────────────┐  │
│  │              ToolRegistry (22+ tools)            │  │
│  │  read_file | write_file | edit_file | bash      │  │
│  │  grep | glob | search_code | create_plan        │  │
│  │  web_fetch | run_tests | apply_patch ...        │  │
│  └─────────────────────────────────────────────────┘  │
└───────────────────────────────────────────────────────┘
```

---

## 五、实施优先级排序

| 阶段 | 功能 | 复杂度 | 预估工时 | 依赖 |
|------|------|--------|----------|------|
| **P1** | SSE 流式连接 + 事件处理器 | 高 | 3-4天 | 无 |
| **P1** | 最终回答流式渲染 (FINAL_DELTA) | 中 | 1天 | P1-SSE |
| **P2** | 思考过程展示 (THINK) | 中 | 1天 | P1-SSE |
| **P2** | 工具调用卡片 (TOOL_CALL/OBSERVE) | 中 | 2天 | P1-SSE |
| **P3** | 计划/任务看板 (PLAN_UPDATE) | 中 | 2天 | P1-SSE |
| **P4** | Diff 查看器 + 变更面板 | 高 | 3天 | P1-SSE |
| **P5** | 命令审批弹窗 | 低 | 1天 | P1-SSE |
| **P5** | 中断控制 (/agent/interrupt) | 低 | 0.5天 | P1-SSE |
| **P6** | 会话管理 (列表/加载/删除) | 中 | 2天 | 无 |
| **P7** | Review 标签页真实接入 | 中 | 2天 | P1-SSE |
| **P8** | Terminal 标签页真实接入 | 中 | 2天 | 无 |
| **P9** | @文件引用 + 插入编辑器 | 低 | 1天 | 无 |
| **P10** | 模型配置弹窗 | 低 | 1天 | 无 |
| **P10** | Prompt 优化接入 | 低 | 0.5天 | 无 |
| | **总计** | | **约 22-24天** | |

---

## 六、新文件清单

```
frontend/src/
├── composables/
│   ├── useAgentStream.js          # SSE 连接管理 + 事件解析
│   └── agentState.js              # Agent 状态管理 (reactive)
├── components/agent/
│   ├── AgentThinking.vue          # 思考过程展示卡片
│   ├── AgentToolCall.vue          # 工具调用详情卡片
│   ├── AgentPlanBoard.vue         # 计划/任务看板
│   ├── AgentDiffViewer.vue        # Diff 查看器 (Monaco DiffEditor)
│   ├── AgentChangesPanel.vue      # 变更面板 (应用/拒绝/撤销)
│   ├── AgentCommandApproval.vue   # 命令审批弹窗
│   ├── AgentSessionList.vue       # 会话历史列表
│   ├── AgentModelConfig.vue       # 模型配置弹窗
│   └── AgentCodeBlock.vue         # 代码块组件 (复制/插入)
```

---

## 七、后端新增/修改清单

| 文件 | 修改内容 |
|------|----------|
| `StudentProjectController.java` | 新增 `/agent/stream` SSE 端点, `/agent/interrupt` 中断端点, `/conversations` 会话 CRUD, `/changes` 变更管理 |
| `StudentProjectService.java` | 新增 `listConversations()`, `getConversationMessages()`, `deleteConversation()` 方法 |
| `StudentProjectServiceImpl.java` | 实现上述方法 |
| `AgentLoopEngine.java` | 微调：确保 SSE 事件格式与前端约定一致 |
| `MiniMaxChat.java` | 可选：添加 streaming 回调支持 |

---

## 八、风险与注意事项

1. **SSE 兼容性：** Spring Boot 的 `SseEmitter` 在生产环境需要配置超时和连接池
2. **长连接稳定性：** 需处理网络断开、代理超时等问题，前端需要重连机制
3. **大文件 Diff：** Monaco DiffEditor 对超大文件可能卡顿，需要分页/懒加载
4. **并发安全：** 多个 Agent 运行时需要确保文件系统操作的原子性
5. **Token 限制：** 长对话的 token 累积需要依赖后端的 auto-compaction
6. **浏览器兼容性：** `ReadableStream` API 在旧版浏览器中可能不可用

---

*文档生成时间：2026-05-14*
*参考项目：公开 Agent 项目稳定版本*
