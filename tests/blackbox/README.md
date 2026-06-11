# 黑盒测试方案

## 一、概述

本文档描述Labex项目的黑盒测试方案，使用Chrome DevTools MCP进行浏览器自动化测试。

## 二、测试环境

- Frontend: http://localhost:3000
- Backend API: http://localhost:8080/api
- 测试工具: Chrome DevTools MCP

## 三、前置条件

1. 启动Backend服务 (端口8080)
2. 启动Frontend服务 (端口3000)
3. Chrome浏览器已打开并连接MCP
4. 准备好测试账号

## 四、测试用例清单

### 4.1 登录功能测试 (BB-Login)

| 测试编号 | 测试点 | 操作步骤 | 预期结果 | 状态 |
|---------|--------|----------|----------|------|
| BB-Login-01 | 学生登录成功 | 输入正确学号/密码，点击登录 | 跳转至学生仪表盘 | ⏳ |
| BB-Login-02 | 教师登录成功 | 输入正确账号/密码，点击登录 | 跳转至教师仪表盘 | ⏳ |
| BB-Login-03 | 管理员登录成功 | 输入正确账号/密码，点击登录 | 跳转至管理员仪表盘 | ⏳ |
| BB-Login-04 | 密码错误 | 输入错误密码 | 显示"账号或密码错误" | ⏳ |
| BB-Login-05 | 空字段提交 | 不输入任何内容点击登录 | 提示必填字段 | ⏳ |

### 4.2 学生端功能测试 (BB-Stu)

| 测试编号 | 测试点 | 操作步骤 | 预期结果 | 状态 |
|---------|--------|----------|----------|------|
| BB-Stu-01 | 查看实验列表 | 登录后进入实验页面 | 显示所有可用实验 | ⏳ |
| BB-Stu-02 | 开始实验 | 点击"开始实验"按钮 | 进入实验详情页面 | ⏳ |
| BB-Stu-03 | 解答填空题 | 在空白处输入答案 | 答案被保存 | ⏳ |
| BB-Stu-04 | 解答单选题 | 选择一个选项 | 选项高亮显示 | ⏳ |
| BB-Stu-05 | 解答编程题 | 在Monaco编辑器中编写代码 | 代码正确显示 | ⏳ |
| BB-Stu-06 | 运行代码 | 点击"运行代码"按钮 | 显示输出结果 | ⏳ |
| BB-Stu-07 | 提交实验 | 点击"提交"按钮 | 显示提交成功提示 | ⏳ |
| BB-Stu-08 | 查看作业列表 | 进入作业页面 | 显示所有作业 | ⏳ |
| BB-Stu-09 | 查看考试列表 | 进入考试页面 | 显示所有考试 | ⏳ |
| BB-Stu-10 | 进行RAG问答 | 输入问题并发送 | 显示AI回答 | ⏳ |

### 4.3 教师端功能测试 (BB-Tch)

| 测试编号 | 测试点 | 操作步骤 | 预期结果 | 状态 |
|---------|--------|----------|----------|------|
| BB-Tch-01 | 查看班级列表 | 登录后进入班级管理 | 显示所有班级 | ⏳ |
| BB-Tch-02 | 添加班级 | 点击添加班级，填写信息 | 班级创建成功 | ⏳ |
| BB-Tch-03 | 查看题目列表 | 进入题目管理 | 显示所有题目 | ⏳ |
| BB-Tch-04 | 创建题目 | 点击新建题目，选择类型 | 显示题目编辑器 | ⏳ |
| BB-Tch-05 | 创建试卷 | 点击新建试卷 | 显示试卷编辑器 | ⏳ |
| BB-Tch-06 | 创建考试 | 点击新建考试 | 显示考试设置 | ⏳ |
| BB-Tch-07 | 批改作业 | 进入批改页面 | 显示待批改作业 | ⏳ |
| BB-Tch-08 | 批改简答题 | 输入分数和评语 | 保存批改结果 | ⏳ |
| BB-Tch-09 | 查看知识图谱 | 进入知识图谱页面 | 显示知识节点图 | ⏳ |
| BB-Tch-10 | 导出成绩 | 点击导出按钮 | 下载成绩Excel | ⏳ |

### 4.4 管理端功能测试 (BB-Admin)

| 测试编号 | 测试点 | 操作步骤 | 预期结果 | 状态 |
|---------|--------|----------|----------|------|
| BB-Admin-01 | 查看教师列表 | 登录后进入教师管理 | 显示所有教师 | ⏳ |
| BB-Admin-02 | 添加教师 | 点击添加教师，填写信息 | 教师创建成功 | ⏳ |
| BB-Admin-03 | 查看学生列表 | 进入学生管理 | 显示所有学生 | ⏳ |
| BB-Admin-04 | 批量导入学生 | 上传Excel文件 | 显示导入结果 | ⏳ |
| BB-Admin-05 | 查看统计面板 | 进入仪表盘 | 显示统计数据 | ⏳ |

### 4.5 云IDE功能测试 (BB-IDE)

| 测试编号 | 测试点 | 操作步骤 | 预期结果 | 状态 |
|---------|--------|----------|----------|------|
| BB-IDE-01 | 创建项目 | 点击新建项目 | 项目创建成功 | ⏳ |
| BB-IDE-02 | 创建文件 | 右键新建文件 | 文件创建成功 | ⏳ |
| BB-IDE-03 | 编辑代码 | 在编辑器中输入代码 | 代码被保存 | ⏳ |
| BB-IDE-04 | 与AI Agent对话 | 发送消息给Agent | Agent回复消息 | ⏳ |
| BB-IDE-05 | 查看代码差异 | AI修改后查看Diff | 显示代码变更 | ⏳ |
| BB-IDE-06 | 应用代码变更 | 点击"应用"按钮 | 代码被应用 | ⏳ |

## 五、测试脚本

### 5.1 登录测试脚本

```javascript
// tests/blackbox/scripts/login_test.js
async function testStudentLogin() {
  console.log('开始测试: 学生登录');
  const page = await mcp__chrome-devtools__new_page();
  await mcp__chrome-devtools__navigate_page({url: "http://localhost:3000/login"});

  // 等待页面加载
  await mcp__chrome-devtools__wait_for({text: ["登录", "Login"]});

  // 获取登录表单元素
  const snapshot = await mcp__chrome-devtools__take_snapshot();

  // 查找并填写用户名和密码
  const usernameInput = snapshot.find(el => el.inputType === 'text' || el.type === 'text');
  const passwordInput = snapshot.find(el => el.type === 'password');

  if (usernameInput && passwordInput) {
    await mcp__chrome-devtools__fill({
      uid: usernameInput.uid,
      value: "2021001"
    });
    await mcp__chrome-devtools__fill({
      uid: passwordInput.uid,
      value: "password123"
    });
  }

  // 查找并点击登录按钮
  const loginButton = snapshot.find(el => el.text?.includes('登录') || el.text?.includes('Login'));
  if (loginButton) {
    await mcp__chrome-devtools__click({uid: loginButton.uid});
  }

  // 等待页面跳转
  await mcp__chrome-devtools__wait_for({text: ["仪表盘", "Dashboard", "实验"]});

  // 截图
  await mcp__chrome-devtools__take_screenshot({
    filePath: "tests/blackbox/screenshots/login_success.png"
  });

  await mcp__chrome-devtools__close_page({pageId: 0});
  console.log('学生登录测试完成');
}

async function testTeacherLogin() {
  console.log('开始测试: 教师登录');
  // 类似实现...
}

async function testAdminLogin() {
  console.log('开始测试: 管理员登录');
  // 类似实现...
}

async function testInvalidLogin() {
  console.log('开始测试: 无效登录');
  const page = await mcp__chrome-devtools__new_page();
  await mcp__chrome-devtools__navigate_page({url: "http://localhost:3000/login"});

  // 填写错误密码
  const snapshot = await mcp__chrome-devtools__take_snapshot();
  const usernameInput = snapshot.find(el => el.inputType === 'text');
  const passwordInput = snapshot.find(el => el.type === 'password');

  if (usernameInput && passwordInput) {
    await mcp__chrome-devtools__fill({uid: usernameInput.uid, value: "2021001"});
    await mcp__chrome-devtools__fill({uid: passwordInput.uid, value: "wrongpassword"});
  }

  // 点击登录
  const loginButton = snapshot.find(el => el.text?.includes('登录'));
  if (loginButton) {
    await mcp__chrome-devtools__click({uid: loginButton.uid});
  }

  // 等待错误提示
  await mcp__chrome-devtools__wait_for({text: ["账号或密码错误", "错误", "失败"]});

  // 截图
  await mcp__chrome-devtools__take_screenshot({
    filePath: "tests/blackbox/screenshots/login_failed.png"
  });

  await mcp__chrome-devtools__close_page({pageId: 0});
  console.log('无效登录测试完成');
}

// 运行测试
(async () => {
  try {
    await testStudentLogin();
    await testTeacherLogin();
    await testAdminLogin();
    await testInvalidLogin();
    console.log('所有登录测试完成');
  } catch (error) {
    console.error('测试失败:', error);
  }
})();
```

### 5.2 学生端测试脚本

```javascript
// tests/blackbox/scripts/student_test.js
async function testStudentExperiments() {
  console.log('开始测试: 学生实验列表');

  // 1. 登录
  const page = await mcp__chrome-devtools__new_page();
  await mcp__chrome-devtools__navigate_page({url: "http://localhost:3000/login"});
  // ... 登录流程 ...

  // 2. 进入实验页面
  await mcp__chrome-devtools__navigate_page({url: "http://localhost:3000/student/experiment"});
  await mcp__chrome-devtools__wait_for({text: ["实验", "Experiment"]});

  // 3. 截图
  await mcp__chrome-devtools__take_screenshot({
    filePath: "tests/blackbox/screenshots/student_experiments.png"
  });

  console.log('学生实验列表测试完成');
}

async function testStudentHomework() {
  console.log('开始测试: 学生作业列表');
  // 实现类似...
}

async function testStudentExam() {
  console.log('开始测试: 学生考试列表');
  // 实现类似...
}

async function testProgrammingQuestion() {
  console.log('开始测试: 编程题解答');

  // 进入实验详情
  const page = await mcp__chrome-devtools__new_page();
  await mcp__chrome-devtools__navigate_page({url: "http://localhost:3000/student/experiment/1"});

  // 等待Monaco编辑器加载
  await mcp__chrome-devtools__wait_for({text: ["编辑器", "Editor", "运行"]});

  // 在编辑器中输入代码
  const editorSnapshot = await mcp__chrome-devtools__take_snapshot();
  const monacoEditor = editorSnapshot.find(el => el.role === 'textbox');

  if (monacoEditor) {
    await mcp__chrome-devtools__fill({
      uid: monacoEditor.uid,
      value: 'public class Main { public static void main(String[] args) { System.out.println("Hello"); } }'
    });
  }

  // 点击运行按钮
  const runButton = editorSnapshot.find(el => el.text?.includes('运行'));
  if (runButton) {
    await mcp__chrome-devtools__click({uid: runButton.uid});
  }

  // 等待输出
  await mcp__chrome-devtools__wait_for({text: ["输出", "Hello", "结果"]});

  // 截图
  await mcp__chrome-devtools__take_screenshot({
    filePath: "tests/blackbox/screenshots/programming_result.png"
  });

  await mcp__chrome-devtools__close_page({pageId: 0});
  console.log('编程题测试完成');
}

// 运行所有学生端测试
(async () => {
  try {
    await testStudentExperiments();
    await testStudentHomework();
    await testStudentExam();
    await testProgrammingQuestion();
    console.log('所有学生端测试完成');
  } catch (error) {
    console.error('测试失败:', error);
  }
})();
```

## 六、测试执行

### 6.1 手动执行

```bash
# 启动服务
cd backend && mvn spring-boot:run &
cd frontend && npm run dev &

# 等待服务启动后，运行测试
node tests/blackbox/scripts/login_test.js
node tests/blackbox/scripts/student_test.js
```

### 6.2 自动化执行

```javascript
// tests/blackbox/run_all_tests.js
const { exec } = require('child_process');
const path = require('path');

const testFiles = [
  'scripts/login_test.js',
  'scripts/student_test.js',
  'scripts/teacher_test.js',
  'scripts/admin_test.js',
  'scripts/cloudide_test.js'
];

async function runTest(testFile) {
  return new Promise((resolve, reject) => {
    const fullPath = path.join(__dirname, testFile);
    exec(`node ${fullPath}`, (error, stdout, stderr) => {
      if (error) {
        console.error(`测试失败 ${testFile}:`, error);
        reject(error);
      } else {
        console.log(`测试完成 ${testFile}:`, stdout);
        resolve();
      }
    });
  });
}

(async () => {
  for (const testFile of testFiles) {
    try {
      await runTest(testFile);
    } catch (error) {
      console.error(`跳过下一个测试: ${testFile}`);
    }
  }
  console.log('所有测试执行完成');
})();
```

## 七、测试结果

### 7.1 截图保存位置

- `tests/blackbox/screenshots/login_success.png` - 登录成功截图
- `tests/blackbox/screenshots/login_failed.png` - 登录失败截图
- `tests/blackbox/screenshots/student_experiments.png` - 学生实验列表截图
- `tests/blackbox/screenshots/teacher_dashboard.png` - 教师仪表盘截图
- `tests/blackbox/screenshots/admin_dashboard.png` - 管理员仪表盘截图

### 7.2 测试日志

所有测试执行日志将保存至：
- `tests/blackbox/logs/test_execution_YYYYMMDD.log`

## 八、常见问题

### 8.1 元素定位失败
- 使用 `take_snapshot` 获取最新页面元素
- 使用 `wait_for` 等待元素加载
- 增加等待时间timeout参数

### 8.2 页面跳转失败
- 检查网络连接
- 确认服务是否正常运行
- 使用 `navigate_page` 重新导航

### 8.3 截图不清晰
- 使用 `fullPage: true` 截取全屏
- 调整浏览器窗口大小