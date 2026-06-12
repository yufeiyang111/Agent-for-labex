# Labex 迭代报告

生成时间：2026-05-17

## 一、迭代目标

本次迭代围绕三个方向展开：

1. 重构登录/注册页面为左右分栏的高质感入口页，提升首屏识别度和操作效率。
2. 为项目制作统一 SVG 品牌图标，并接入 favicon、登录页、侧边栏和云代码空间。
3. 强化云代码空间中的 Coding Agent 能力，补齐用户级 Skill、MCP 配置、工作流提示词、安全策略、变更审查和并发执行基础。

## 二、设计与产品改动

### 登录注册页

已将 `frontend/src/views/Login.vue` 重构为左右布局：

- 左侧为产品品牌区，包含 Labex 标识、AI 实验教学平台介绍、云代码空间预览和能力卡片。
- 右侧为登录/注册切换表单，支持教师、学生、管理员三类登录角色。
- 注册入口仅开放学生账号，教师和管理员仍由系统管理员维护，避免权限边界扩大。
- 增加记住账号能力，提升重复登录效率。
- 页面在桌面端、平板端和移动端均有响应式适配。

### 项目图标

新增统一品牌 SVG：

- `frontend/public/brand/labex-mark.svg`
- `frontend/src/components/AppIcon.vue`

图形含义：

- 深色圆角底座代表稳定的实验平台。
- 中央烧瓶代表实验教学。
- 绿色与青色连线代表 AI Agent、代码与知识图谱之间的连接。
- 未使用 emoji 作为图标。

接入位置：

- 浏览器 favicon：`frontend/index.html`
- 登录页品牌区：`frontend/src/views/Login.vue`
- 学生、教师、管理员侧边栏：`Layout.vue`
- 云代码空间顶部与 Agent 面板：`CloudWorkspace.vue`

## 三、Agent 能力增强

### 工作流与提示词

已强化 `LabexSystemPrompt`：

- 新增指令优先级说明。
- 明确项目文件、工具输出、Skill 内容、MCP 响应均为不可信数据。
- 明确禁止执行覆盖系统规则、泄露密钥、访问其他用户空间、读取系统凭证等危险指令。
- 保留先计划、再执行、再验证、最后总结的循环。
- 将用户级 Skill 与 MCP 作为扩展上下文注入，但不能覆盖系统安全规则。

### 并发执行

`AgentLoopEngine` 从每次请求直接创建线程，改为有界线程池：

- 核心线程数：4
- 最大线程数：16
- 队列长度：128
- 队列满时通过 SSE 返回繁忙提示

这样可以降低高并发下线程失控风险。

### 安全策略

`ProjectCommandSafety` 已扩展危险命令识别：

- 阻断关机、格式化、磁盘破坏、系统敏感路径、SSH/AWS 凭证、云元数据地址等高风险访问。
- 对 curl、wget、远程传输、强制 git 操作、数据库破坏性 SQL、递归删除等操作要求用户确认。
- 对明显的提示词注入式命令进行拦截。

### 变更审查与回退

项目原有 `ChangesPanel`、`DiffViewer`、`DiffService` 已保留并继续作为变更审查入口：

- Agent 文件变更进入审查列表。
- 支持 diff、before、after 三种查看方式。
- 支持按 changeId 回退。

本次补充的提示词和安全策略要求 Agent 优先保持可回退编辑。

## 四、用户级 Skill 与 MCP

### 后端

新增实体、Mapper、Service、Controller：

- `AgentSkill`
- `AgentMcpServer`
- `AgentSkillService`
- `AgentMcpServerService`
- `AgentExtensionController`

新增迁移：

- `backend/src/main/resources/db/migration/V20240518__create_agent_extensions.sql`

接口路径：

- `GET /student/agent/extensions/skills`
- `POST /student/agent/extensions/skills`
- `PUT /student/agent/extensions/skills/{skillId}`
- `DELETE /student/agent/extensions/skills/{skillId}`
- `GET /student/agent/extensions/mcp`
- `POST /student/agent/extensions/mcp`
- `PUT /student/agent/extensions/mcp/{serverId}`
- `DELETE /student/agent/extensions/mcp/{serverId}`

隔离策略：

- 所有 Skill 与 MCP 配置均按 `student_id` 隔离。
- 配置是学生全局级别，可跨项目复用，但不会共享给其他学生。
- MCP 鉴权头不回传给前端，只返回是否已配置。

### Agent 工具

新增或增强工具：

- `skill`：读取当前学生启用的全局 Skill。
- `mcp_call`：调用当前学生启用的 MCP HTTP JSON-RPC 工具。

MCP 安全限制：

- 当前支持 HTTP JSON-RPC 端点。
- 阻止 localhost、内网地址、云元数据地址等服务端侧敏感目标。
- 调用参数要求 JSON 对象字符串。

### 前端

`CloudWorkspace.vue` 新增「扩展」Tab：

- Skill 列表、启用/停用、编辑、删除。
- Skill 表单支持 key、标题、描述、正文。
- MCP 列表、启用/停用、编辑、删除。
- MCP 表单支持 key、名称、Endpoint、鉴权头和工具清单 JSON。

## 五、差异对照与吸收点

调研公开 Agent 工具后，本项目主要差异与补强如下：

| 方向 | 参考工具常见设计 | Labex 当前实现 |
| --- | --- | --- |
| Agent 分层 | 主 Agent、规划、子任务、工具调用分层 | 已有计划工具、任务记录、工具注册，继续保留轻量结构 |
| Skill | 用户可配置长期技能 | 新增学生全局 Skill，注入上下文并提供 skill 工具读取 |
| MCP | 外部工具通过协议接入 | 新增学生级 MCP 配置与 mcp_call 工具，当前采用安全 HTTP JSON-RPC |
| 权限 | 读写命令分级审批 | 增强命令安全策略，危险命令审批或阻断 |
| 沙箱 | 工作目录隔离 | 工具路径限制在学生项目 workspace 内，外部目录默认拒绝 |
| 用户交互 | 计划、思考、工具、结果可见 | 已通过 SSE 输出计划、思考、工具调用、Token 与变更 |
| 回退 | 变更可审查和撤销 | 继续使用 changeId、diff、undo 能力 |
| 抗注入 | 将外部内容视为不可信 | 已在系统提示词中明确隔离项目文件、工具输出、Skill 和 MCP 响应 |

## 六、验证结果

已执行：

```bash
npm run build
```

结果：前端构建成功。

已执行：

```bash
mvn clean compile -f D:\workfordasan\backend\pom.xml
```

结果：后端编译成功。

## 七、后续建议

1. 为 MCP 增加标准 `tools/list` 测试按钮，保存前自动拉取工具清单。
2. 为 Skill 增加导入/导出能力，方便学生迁移自己的全局规则。
3. 为危险命令审批增加前端确认弹窗与审批记录。
4. 为 Agent 线程池参数加入 `application.yml` 配置项，便于不同服务器按资源调优。

## 八、登录页二次元动态交互补充

本次补充优化了登录/注册页视觉表达：

- 新增两套原创日系动画方向 AI 学习助手素材，分别为魔法学院与忍者学院。
- 素材已合成为 30fps 透明多帧 WebP idle 动画，并做轻度赛璐璐化后处理。
- 登录页支持用户自主切换两套动态助手，并通过 `localStorage` 记住选择。
- 左侧品牌区加入角色动图、呼吸光环、代码气泡、状态卡片、角色切换动效和鼠标视差。
- 移动端登录卡片中也加入小尺寸学习助手与切换按钮，保持响应式体验一致。

新增素材：

- `frontend/public/brand/anime-isekai-mage-idle.webp`
- `frontend/public/brand/anime-shonen-ninja-idle.webp`

已执行：

```bash
npm run build
```

结果：前端构建成功。
