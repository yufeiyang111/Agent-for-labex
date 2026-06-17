# LabexAgent 重构设计文档

## 目标

重构 LabexAgent 的三大核心系统：
1. **终端系统** — 复刻 VSCode 终端 UI 和实际功能
2. **Skill/MCP 系统** — 文件夹导入 + 自动检索 + 工具调用
3. **功能对齐 Opencode** — 复刻 Opencode 的核心功能

## 一、终端系统重构

### 现状问题
- 纯前端模拟终端，通过 REST API 执行命令
- 无 ANSI 色彩支持、无光标移动、无交互式程序支持
- 无真实 PTY，无法运行 vim/top/htop 等程序

### 设计方案

#### 前端：xterm.js 集成
- 使用 `xterm.js` + `xterm-addon-fit` + `xterm-addon-web-links`
- WebSocket 通信替代 REST API
- 支持多终端标签页
- 支持 ANSI 色彩、光标控制、鼠标事件

#### 后端：WebSocket PTY 服务
- 使用 `pty4j` 或 JNI-based PTY 实现
- WebSocket endpoint: `/ws/terminal/{sessionId}`
- 支持 Windows cmd/PowerShell/Git Bash 自动检测
- 支持 resize 事件同步终端大小

#### 文件变更
```
前端:
├── 新建: src/components/terminal/TerminalPanel.vue      # 主终端面板
├── 新建: src/components/terminal/TerminalTab.vue         # 终端标签页
├── 新建: src/components/terminal/TerminalInstance.vue    # 单个终端实例
├── 新建: src/composables/useTerminal.js                 # 终端 composable
└── 修改: src/views/student/CloudWorkspace.vue           # 集成新终端

后端:
├── 新建: labexagent/terminal/WebSocketTerminalHandler.java  # WebSocket 处理
├── 新建: labexagent/terminal/PtyProcess.java               # PTY 进程管理
├── 新建: labexagent/terminal/TerminalSession.java          # 终端会话
└── 修改: pom.xml                                           # 添加 pty4j 依赖
```

## 二、Skill/MCP 系统重构

### 现状问题
- Skill 存储在数据库，不支持文件夹导入
- MCP 只支持 HTTP JSON-RPC，不支持 stdio/SSE
- 无自动工具发现，需手动定义 tools_json
- Agent 无法自动检索可用的 Skill/MCP 工具

### 设计方案

#### Skill 系统
- 支持文件夹导入：用户上传包含 SKILL.md 的文件夹
- 自动解析 YAML frontmatter (name, description)
- Skill 内容注入系统提示词
- Agent 可通过 `skill` 工具按需加载

#### MCP 系统
- 支持三种传输：stdio（本地进程）、HTTP、SSE
- 自动工具发现：连接后调用 `tools/list` 获取工具列表
- 工具定义自动转换为 AgentTool 格式
- 动态工具注册：MCP 工具变更时自动更新

#### 文件变更
```
后端:
├── 新建: labexagent/mcp/McpClient.java                  # MCP 客户端
├── 新建: labexagent/mcp/McpTransport.java               # 传输抽象
├── 新建: labexagent/mcp/StdioTransport.java             # stdio 传输
├── 新建: labexagent/mcp/HttpTransport.java              # HTTP 传输
├── 新建: labexagent/mcp/SseTransport.java               # SSE 传输
├── 新建: labexagent/mcp/McpToolAdapter.java             # MCP→AgentTool 适配器
├── 新建: labexagent/skill/SkillDiscoveryService.java    # Skill 发现服务
├── 修改: tool/impl/SkillTool.java                       # 增强 Skill 工具
├── 修改: tool/impl/McpCallTool.java                     # 增强 MCP 工具
├── 修改: tool/ToolRegistry.java                         # 动态工具注册
└── 修改: controller/AgentExtensionController.java       # 文件夹导入 API

前端:
├── 新建: src/components/cloud/SkillImportDialog.vue     # Skill 导入对话框
├── 新建: src/components/cloud/McpConfigDialog.vue       # MCP 配置对话框
└── 修改: src/views/student/CloudWorkspace.vue           # 集成新 UI
```

## 三、功能对齐 Opencode

### 需要复刻的功能

| 功能 | Opencode 实现 | LabexAgent 计划 |
|------|--------------|----------------|
| 子代理 (Task) | 前台/后台子代理 | 实现 TaskTool 增强 |
| 上下文压缩 | LLM 摘要压缩 | 增强 compactWithLlmSummary |
| 自定义工具 | JS/TS 文件加载 | 支持 JS 脚本工具 |
| 系统提示词 | Provider 特定提示词 | 增强 LabexSystemPrompt |
| 会话分支 | Fork 会话 | 已有，增强 UI |
| 文件附件 | @file 引用 | 增强输入框 |
| 自动补全 | 命令/文件补全 | 增强输入框 |
| 主题系统 | 多主题支持 | CSS 变量主题 |
| 快捷键 | 全局快捷键 | 增加快捷键 |
| 导出/导入 | 会话导出 | 增加导出功能 |

### 优先级
1. **P0**: 终端系统、Skill/MCP 系统
2. **P1**: 子代理、上下文压缩、自定义工具
3. **P2**: 系统提示词增强、文件附件、自动补全
4. **P3**: 主题系统、快捷键、导出/导入
