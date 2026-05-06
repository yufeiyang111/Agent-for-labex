const pptxgen = require("pptxgenjs");

let pres = new pptxgen();
pres.layout = "LAYOUT_16x9";
pres.title = "Labex 实验教学管理系统";
pres.author = "Labex Team";

// 配色方案
const colors = {
  primary: "1E3A5F",
  secondary: "2E86AB",
  accent: "48CAE4",
  light: "CAF0F8",
  white: "FFFFFF",
  dark: "1A1A2E",
  gray: "64748B",
  lightGray: "E2E8F0",
  success: "10B981",
  warning: "F59E0B"
};

// ========== 辅助函数 ==========
function addHeader(slide, title, pageNum) {
  slide.addShape(pres.shapes.RECTANGLE, {
    x: 0, y: 0, w: 10, h: 0.8,
    fill: { color: colors.primary }
  });
  slide.addText(title, {
    x: 0.5, y: 0.15, w: 8.5, h: 0.5,
    fontSize: 22, fontFace: "Arial", color: colors.white, bold: true
  });
  slide.addText(pageNum, {
    x: 9, y: 0.15, w: 0.8, h: 0.5,
    fontSize: 14, fontFace: "Arial", color: colors.accent, align: "right"
  });
}

function addFooter(slide) {
  slide.addShape(pres.shapes.RECTANGLE, {
    x: 0, y: 5.4, w: 10, h: 0.225,
    fill: { color: colors.lightGray }
  });
  slide.addText("Labex 实验教学管理系统", {
    x: 0.5, y: 5.42, w: 4, h: 0.2,
    fontSize: 9, color: colors.gray
  });
}

// ========== 第1页：封面 ==========
let slide1 = pres.addSlide();
slide1.background = { color: colors.primary };

slide1.addShape(pres.shapes.OVAL, {
  x: -2, y: -2, w: 5, h: 5,
  fill: { color: colors.secondary, transparency: 50 }
});
slide1.addShape(pres.shapes.OVAL, {
  x: 7, y: 3, w: 5, h: 5,
  fill: { color: colors.accent, transparency: 40 }
});
slide1.addShape(pres.shapes.OVAL, {
  x: 8, y: -1, w: 3, h: 3,
  fill: { color: colors.light, transparency: 60 }
});

slide1.addText("Labex", {
  x: 0.5, y: 1.5, w: 9, h: 1.2,
  fontSize: 72, fontFace: "Arial Black", color: colors.white, bold: true, align: "center"
});
slide1.addText("实验教学管理系统", {
  x: 0.5, y: 2.7, w: 9, h: 0.8,
  fontSize: 36, fontFace: "Arial", color: colors.accent, align: "center"
});

slide1.addShape(pres.shapes.RECTANGLE, {
  x: 3.5, y: 3.7, w: 3, h: 0.04,
  fill: { color: colors.white }
});

slide1.addText("技术方案汇报", {
  x: 0.5, y: 4.0, w: 9, h: 0.5,
  fontSize: 20, fontFace: "Arial", color: colors.lightGray, align: "center"
});

// ========== 第2页：目录 ==========
let slide2 = pres.addSlide();
slide2.background = { color: colors.white };

addHeader(slide2, "目录", "02");
addFooter(slide2);

const tocData = [
  { num: "01", title: "项目背景与目标", pages: "P3" },
  { num: "02", title: "需求分析", pages: "P4-5" },
  { num: "03", title: "系统架构设计", pages: "P6-8" },
  { num: "04", title: "数据库设计", pages: "P9-10" },
  { num: "05", title: "功能模块详解", pages: "P11-14" },
  { num: "06", title: "安全与性能优化", pages: "P15-16" },
  { num: "07", title: "部署方案", pages: "P17" },
  { num: "08", title: "总结与展望", pages: "P18" }
];

tocData.forEach((item, i) => {
  const row = Math.floor(i / 2);
  const col = i % 2;
  const x = 0.5 + col * 4.8;
  const y = 1.1 + row * 1.0;

  slide2.addShape(pres.shapes.RECTANGLE, {
    x: x, y: y, w: 4.5, h: 0.85,
    fill: { color: i % 4 === 0 ? colors.light : colors.white },
    line: { color: colors.lightGray, width: 1 }
  });

  slide2.addShape(pres.shapes.RECTANGLE, {
    x: x, y: y, w: 0.6, h: 0.85,
    fill: { color: colors.secondary }
  });

  slide2.addText(item.num, {
    x: x, y: y, w: 0.6, h: 0.85,
    fontSize: 14, fontFace: "Arial", color: colors.white, bold: true,
    align: "center", valign: "middle"
  });

  slide2.addText(item.title, {
    x: x + 0.7, y: y + 0.15, w: 3.3, h: 0.35,
    fontSize: 14, fontFace: "Arial", color: colors.dark, bold: true
  });

  slide2.addText(item.pages, {
    x: x + 0.7, y: y + 0.5, w: 3.3, h: 0.25,
    fontSize: 10, fontFace: "Arial", color: colors.gray
  });
});

// ========== 第3页：项目背景 ==========
let slide3 = pres.addSlide();
slide3.background = { color: colors.white };
addHeader(slide3, "01 项目背景与目标", "03");
addFooter(slide3);

// 背景卡片
slide3.addShape(pres.shapes.RECTANGLE, {
  x: 0.5, y: 1.1, w: 9, h: 1.6,
  fill: { color: colors.light }
});
slide3.addText("项目背景", {
  x: 0.7, y: 1.2, w: 2, h: 0.4,
  fontSize: 16, fontFace: "Arial", color: colors.primary, bold: true
});
slide3.addText("随着高校信息化建设的推进，传统实验教学管理模式存在以下问题：\n• 纸质材料管理繁琐，效率低下\n• 实验报告批改周期长，反馈不及时\n• 成绩统计困难，难以进行学情分析\n• 学生实验过程缺乏有效跟踪", {
  x: 0.7, y: 1.6, w: 8.6, h: 1.0,
  fontSize: 12, fontFace: "Arial", color: colors.dark
});

// 目标卡片
slide3.addShape(pres.shapes.RECTANGLE, {
  x: 0.5, y: 2.9, w: 9, h: 2.2,
  fill: { color: colors.white },
  line: { color: colors.secondary, width: 2 }
});
slide3.addText("项目目标", {
  x: 0.7, y: 3.0, w: 2, h: 0.4,
  fontSize: 16, fontFace: "Arial", color: colors.primary, bold: true
});

const goals = [
  { icon: "🎯", text: "构建统一的实验教学管理平台，实现全流程数字化" },
  { icon: "📊", text: "提供数据分析功能，支持教学决策" },
  { icon: "🔒", text: "确保系统安全稳定，保护教学数据" },
  { icon: "📱", text: "支持多终端访问，提升用户体验" }
];

goals.forEach((g, i) => {
  slide3.addText(g.icon + "  " + g.text, {
    x: 0.9, y: 3.45 + i * 0.4, w: 8.4, h: 0.35,
    fontSize: 12, fontFace: "Arial", color: colors.dark
  });
});

// ========== 第4页：用户角色分析 ==========
let slide4 = pres.addSlide();
slide4.background = { color: colors.white };
addHeader(slide4, "02 需求分析 - 用户角色", "04");
addFooter(slide4);

const roles = [
  {
    title: "系统管理员",
    color: colors.primary,
    tasks: ["账号管理与权限分配", "系统参数配置", "数据备份与恢复", "系统运行监控"]
  },
  {
    title: "教师用户",
    color: colors.secondary,
    tasks: ["课程与实验管理", "学生信息管理", "在线出题与组卷", "成绩录入与分析"]
  },
  {
    title: "学生用户",
    color: colors.accent,
    tasks: ["查看实验任务", "在线完成实验", "提交实验报告", "查询成绩反馈"]
  }
];

roles.forEach((role, i) => {
  const x = 0.5 + i * 3.1;

  slide4.addShape(pres.shapes.RECTANGLE, {
    x: x, y: 1.1, w: 2.9, h: 4.0,
    fill: { color: colors.white },
    line: { color: role.color, width: 2 },
    shadow: { type: "outer", color: "000000", blur: 6, offset: 2, angle: 135, opacity: 0.1 }
  });

  slide4.addShape(pres.shapes.RECTANGLE, {
    x: x, y: 1.1, w: 2.9, h: 0.6,
    fill: { color: role.color }
  });

  slide4.addText(role.title, {
    x: x, y: 1.1, w: 2.9, h: 0.6,
    fontSize: 14, fontFace: "Arial", color: colors.white, bold: true,
    align: "center", valign: "middle"
  });

  role.tasks.forEach((task, j) => {
    slide4.addShape(pres.shapes.OVAL, {
      x: x + 0.2, y: 1.9 + j * 0.65, w: 0.25, h: 0.25,
      fill: { color: role.color }
    });
    slide4.addText((j + 1).toString(), {
      x: x + 0.2, y: 1.9 + j * 0.65, w: 0.25, h: 0.25,
      fontSize: 10, color: colors.white, align: "center", valign: "middle"
    });
    slide4.addText(task, {
      x: x + 0.55, y: 1.88 + j * 0.65, w: 2.2, h: 0.3,
      fontSize: 11, fontFace: "Arial", color: colors.dark
    });
  });
});

// ========== 第5页：功能需求 ==========
let slide5 = pres.addSlide();
slide5.background = { color: colors.white };
addHeader(slide5, "02 需求分析 - 功能需求", "05");
addFooter(slide5);

const features = [
  { cat: "实验管理", items: ["创建/编辑实验内容", "设置实验要求", "管理实验题目", "实验时间安排"] },
  { cat: "考试管理", items: ["多种题型支持", "自动组卷功能", "在线答题系统", "自动评分机制"] },
  { cat: "成绩管理", items: ["成绩录入导出", "成绩统计分析", "学情数据分析", "成绩对比报表"] },
  { cat: "系统管理", items: ["用户权限管理", "班级信息管理", "系统参数配置", "操作日志审计"] }
];

features.forEach((f, i) => {
  const row = Math.floor(i / 2);
  const col = i % 2;
  const x = 0.5 + col * 4.7;
  const y = 1.1 + row * 2.0;

  slide5.addShape(pres.shapes.RECTANGLE, {
    x: x, y: y, w: 4.4, h: 1.8,
    fill: { color: colors.white },
    line: { color: colors.lightGray, width: 1 }
  });

  slide5.addShape(pres.shapes.RECTANGLE, {
    x: x, y: y, w: 4.4, h: 0.5,
    fill: { color: colors.secondary }
  });

  slide5.addText(f.cat, {
    x: x, y: y, w: 4.4, h: 0.5,
    fontSize: 14, fontFace: "Arial", color: colors.white, bold: true,
    align: "center", valign: "middle"
  });

  f.items.forEach((item, j) => {
    slide5.addText("✓  " + item, {
      x: x + 0.2, y: y + 0.6 + j * 0.28, w: 4, h: 0.25,
      fontSize: 11, fontFace: "Arial", color: colors.dark
    });
  });
});

// ========== 第6页：系统架构图 ==========
let slide6 = pres.addSlide();
slide6.background = { color: colors.white };
addHeader(slide6, "03 系统架构设计 - 整体架构", "06");
addFooter(slide6);

// 客户端层
slide6.addShape(pres.shapes.RECTANGLE, {
  x: 1, y: 1.1, w: 8, h: 0.7,
  fill: { color: colors.accent }
});
slide6.addText("客户端层 - 浏览器 / 移动端", {
  x: 1, y: 1.1, w: 8, h: 0.7,
  fontSize: 14, fontFace: "Arial", color: colors.dark, bold: true,
  align: "center", valign: "middle"
});

// 前端层
slide6.addShape(pres.shapes.RECTANGLE, {
  x: 1, y: 2.0, w: 8, h: 0.7,
  fill: { color: colors.secondary }
});
slide6.addText("前端层 - Vue 3 + Element Plus + ECharts", {
  x: 1, y: 2.0, w: 8, h: 0.7,
  fontSize: 14, fontFace: "Arial", color: colors.white, bold: true,
  align: "center", valign: "middle"
});

// 网关层
slide6.addShape(pres.shapes.RECTANGLE, {
  x: 1, y: 2.9, w: 8, h: 0.7,
  fill: { color: colors.primary }
});
slide6.addText("网关层 - Nginx 反向代理 + 负载均衡", {
  x: 1, y: 2.9, w: 8, h: 0.7,
  fontSize: 14, fontFace: "Arial", color: colors.white, bold: true,
  align: "center", valign: "middle"
});

// 后端层
slide6.addShape(pres.shapes.RECTANGLE, {
  x: 1, y: 3.8, w: 8, h: 0.7,
  fill: { color: "2563EB" }
});
slide6.addText("后端层 - Spring Boot + Spring Security + MyBatis-Plus", {
  x: 1, y: 3.8, w: 8, h: 0.7,
  fontSize: 14, fontFace: "Arial", color: colors.white, bold: true,
  align: "center", valign: "middle"
});

// 数据层
slide6.addShape(pres.shapes.RECTANGLE, {
  x: 1, y: 4.7, w: 3.8, h: 0.6,
  fill: { color: colors.success }
});
slide6.addText("MySQL 数据库", {
  x: 1, y: 4.7, w: 3.8, h: 0.6,
  fontSize: 12, fontFace: "Arial", color: colors.white, bold: true,
  align: "center", valign: "middle"
});

slide6.addShape(pres.shapes.RECTANGLE, {
  x: 5.2, y: 4.7, w: 3.8, h: 0.6,
  fill: { color: colors.warning }
});
slide6.addText("Redis 缓存", {
  x: 5.2, y: 4.7, w: 3.8, h: 0.6,
  fontSize: 12, fontFace: "Arial", color: colors.white, bold: true,
  align: "center", valign: "middle"
});

// ========== 第7页：技术选型 ==========
let slide7 = pres.addSlide();
slide7.background = { color: colors.white };
addHeader(slide7, "03 系统架构设计 - 技术选型", "07");
addFooter(slide7);

// 左列 - 前端
slide7.addShape(pres.shapes.RECTANGLE, {
  x: 0.5, y: 1.1, w: 4.3, h: 4.0,
  fill: { color: colors.white },
  line: { color: colors.secondary, width: 2 }
});

slide7.addShape(pres.shapes.RECTANGLE, {
  x: 0.5, y: 1.1, w: 4.3, h: 0.55,
  fill: { color: colors.secondary }
});
slide7.addText("前端技术栈", {
  x: 0.5, y: 1.1, w: 4.3, h: 0.55,
  fontSize: 14, fontFace: "Arial", color: colors.white, bold: true,
  align: "center", valign: "middle"
});

const feTech = [
  { name: "Vue 3", desc: "渐进式前端框架，Composition API" },
  { name: "Vite", desc: "下一代构建工具，热更新快" },
  { name: "Pinia", desc: "Vue 3 官方推荐状态管理" },
  { name: "Element Plus", desc: "优秀的 UI 组件库" },
  { name: "Axios", desc: "HTTP 请求库，支持拦截器" },
  { name: "ECharts", desc: "数据可视化图表库" }
];

feTech.forEach((t, i) => {
  slide7.addText(t.name, {
    x: 0.7, y: 1.75 + i * 0.52, w: 1.3, h: 0.4,
    fontSize: 11, fontFace: "Arial", color: colors.primary, bold: true
  });
  slide7.addText(t.desc, {
    x: 2.0, y: 1.75 + i * 0.52, w: 2.6, h: 0.4,
    fontSize: 10, fontFace: "Arial", color: colors.gray
  });
});

// 右列 - 后端
slide7.addShape(pres.shapes.RECTANGLE, {
  x: 5.2, y: 1.1, w: 4.3, h: 4.0,
  fill: { color: colors.white },
  line: { color: colors.primary, width: 2 }
});

slide7.addShape(pres.shapes.RECTANGLE, {
  x: 5.2, y: 1.1, w: 4.3, h: 0.55,
  fill: { color: colors.primary }
});
slide7.addText("后端技术栈", {
  x: 5.2, y: 1.1, w: 4.3, h: 0.55,
  fontSize: 14, fontFace: "Arial", color: colors.white, bold: true,
  align: "center", valign: "middle"
});

const beTech = [
  { name: "Spring Boot", desc: "主流企业级开发框架" },
  { name: "Spring Security", desc: "安全框架，认证授权" },
  { name: "MyBatis-Plus", desc: "ORM框架，简化CRUD" },
  { name: "JWT", desc: "无状态身份认证令牌" },
  { name: "Druid", desc: "数据库连接池，SQL监控" },
  { name: "Redis", desc: "高性能缓存数据库" }
];

beTech.forEach((t, i) => {
  slide7.addText(t.name, {
    x: 5.4, y: 1.75 + i * 0.52, w: 1.5, h: 0.4,
    fontSize: 11, fontFace: "Arial", color: colors.primary, bold: true
  });
  slide7.addText(t.desc, {
    x: 6.9, y: 1.75 + i * 0.52, w: 2.4, h: 0.4,
    fontSize: 10, fontFace: "Arial", color: colors.gray
  });
});

// ========== 第8页：Spring Security 安全架构 ==========
let slide8 = pres.addSlide();
slide8.background = { color: colors.white };
addHeader(slide8, "03 系统架构设计 - 安全架构", "08");
addFooter(slide8);

slide8.addText("Spring Security 认证授权流程", {
  x: 0.5, y: 1.0, w: 9, h: 0.4,
  fontSize: 14, fontFace: "Arial", color: colors.primary, bold: true
});

// 流程图
const steps = [
  { text: "用户登录", y: 1.5 },
  { text: "认证过滤器", y: 2.1 },
  { text: "UserDetailsService", y: 2.7 },
  { text: "JWT Token 生成", y: 3.3 },
  { text: "授权过滤器验证", y: 3.9 },
  { text: "资源访问", y: 4.5 }
];

steps.forEach((s, i) => {
  slide8.addShape(pres.shapes.RECTANGLE, {
    x: 1, y: s.y, w: 3.5, h: 0.5,
    fill: { color: i === 0 || i === 5 ? colors.success : colors.secondary }
  });
  slide8.addText(s.text, {
    x: 1, y: s.y, w: 3.5, h: 0.5,
    fontSize: 12, fontFace: "Arial", color: colors.white,
    align: "center", valign: "middle"
  });

  if (i < steps.length - 1) {
    slide8.addShape(pres.shapes.LINE, {
      x: 2.75, y: s.y + 0.5, w: 0, h: 0.1,
      line: { color: colors.gray, width: 2 }
    });
  }
});

// 右侧说明
slide8.addShape(pres.shapes.RECTANGLE, {
  x: 5, y: 1.5, w: 4.5, h: 3.5,
  fill: { color: colors.light }
});

const secPoints = [
  "• JWT Token 无状态认证",
  "• 支持 Token 自动续期",
  "• BCrypt 密码加密存储",
  "• RBAC 角色权限控制",
  "• 页面级权限注解",
  "• 接口级权限校验",
  "• 密码错误次数限制",
  "• 支持 IP 地址绑定"
];

slide8.addText(secPoints.join("\n"), {
  x: 5.2, y: 1.6, w: 4.1, h: 3.3,
  fontSize: 12, fontFace: "Arial", color: colors.dark,
  paraSpaceAfter: 6
});

// ========== 第9页：数据库设计 - ER图 ==========
let slide9 = pres.addSlide();
slide9.background = { color: colors.white };
addHeader(slide9, "04 数据库设计 - ER 关系图", "09");
addFooter(slide9);

// 实体框
const entities = [
  { name: "t_teacher", x: 0.5, y: 1.3, w: 2, h: 0.5 },
  { name: "t_student", x: 0.5, y: 3.2, w: 2, h: 0.5 },
  { name: "t_clazz", x: 3.5, y: 2.2, w: 2, h: 0.5 },
  { name: "t_experiment", x: 6.5, y: 1.3, w: 2.5, h: 0.5 },
  { name: "t_experiment_item", x: 6.5, y: 3.2, w: 2.5, h: 0.5 },
  { name: "t_score", x: 3.5, y: 4.2, w: 2, h: 0.5 }
];

entities.forEach(e => {
  slide9.addShape(pres.shapes.RECTANGLE, {
    x: e.x, y: e.y, w: e.w, h: e.h,
    fill: { color: colors.secondary },
    line: { color: colors.primary, width: 1 }
  });
  slide9.addText(e.name, {
    x: e.x, y: e.y, w: e.w, h: e.h,
    fontSize: 10, fontFace: "Consolas", color: colors.white,
    align: "center", valign: "middle"
  });
});

// 关系连线说明
slide9.addText("关系说明：", {
  x: 0.5, y: 4.85, w: 1.5, h: 0.3,
  fontSize: 10, fontFace: "Arial", color: colors.primary, bold: true
});

const relations = [
  "教师 ↔ 班级：1对多",
  "班级 ↔ 学生：1对多",
  "实验 ↔ 题目：1对多",
  "学生 ↔ 成绩：1对多"
];

relations.forEach((r, i) => {
  slide9.addText(r, {
    x: 2 + i * 2, y: 4.85, w: 2, h: 0.3,
    fontSize: 9, fontFace: "Arial", color: colors.gray
  });
});

// ========== 第10页：数据库表结构 ==========
let slide10 = pres.addSlide();
slide10.background = { color: colors.white };
addHeader(slide10, "04 数据库设计 - 核心表结构", "10");
addFooter(slide10);

// 教师表
slide10.addShape(pres.shapes.RECTANGLE, {
  x: 0.5, y: 1.1, w: 4.3, h: 2.0,
  fill: { color: colors.white },
  line: { color: colors.secondary, width: 1 }
});
slide10.addText("t_teacher 教师表", {
  x: 0.5, y: 1.1, w: 4.3, h: 0.4,
  fontSize: 11, fontFace: "Arial", color: colors.white, bold: true,
  fill: { color: colors.secondary }, align: "center"
});
slide10.addText("teacher_id (PK)  INT\nteacher_account  VARCHAR(20)\nteacher_password  VARCHAR(255)\nteacher_name  VARCHAR(20)\nrole  VARCHAR(20)  [TEACHER/ADMIN]\nstate  INT  [0禁用/1启用]", {
  x: 0.6, y: 1.55, w: 4.1, h: 1.5,
  fontSize: 9, fontFace: "Consolas", color: colors.dark
});

// 学生表
slide10.addShape(pres.shapes.RECTANGLE, {
  x: 5.2, y: 1.1, w: 4.3, h: 2.0,
  fill: { color: colors.white },
  line: { color: colors.accent, width: 1 }
});
slide10.addText("t_student 学生表", {
  x: 5.2, y: 1.1, w: 4.3, h: 0.4,
  fontSize: 11, fontFace: "Arial", color: colors.dark, bold: true,
  fill: { color: colors.accent }, align: "center"
});
slide10.addText("student_id (PK)  INT\nstudent_no  VARCHAR(20)  UNIQUE\nstudent_name  VARCHAR(20)\nstudent_password  VARCHAR(255)\nclazz_no (FK)  VARCHAR(20)\nstate  INT  [0禁用/1启用]\nerror_count  INT  [密码错误次数]", {
  x: 5.3, y: 1.55, w: 4.1, h: 1.5,
  fontSize: 9, fontFace: "Consolas", color: colors.dark
});

// 实验表
slide10.addShape(pres.shapes.RECTANGLE, {
  x: 0.5, y: 3.3, w: 4.3, h: 1.8,
  fill: { color: colors.white },
  line: { color: colors.success, width: 1 }
});
slide10.addText("t_experiment 实验表", {
  x: 0.5, y: 3.3, w: 4.3, h: 0.4,
  fontSize: 11, fontFace: "Arial", color: colors.white, bold: true,
  fill: { color: colors.success }, align: "center"
});
slide10.addText("experiment_id (PK)  INT\nexperiment_no  INT  UNIQUE\nexperiment_name  VARCHAR(100)\nexperiment_type  INT\nexperiment_requirement  TEXT\nexperiment_content  TEXT", {
  x: 0.6, y: 3.75, w: 4.1, h: 1.3,
  fontSize: 9, fontFace: "Consolas", color: colors.dark
});

// 成绩表
slide10.addShape(pres.shapes.RECTANGLE, {
  x: 5.2, y: 3.3, w: 4.3, h: 1.8,
  fill: { color: colors.white },
  line: { color: colors.warning, width: 1 }
});
slide10.addText("t_score 成绩表", {
  x: 5.2, y: 3.3, w: 4.3, h: 0.4,
  fontSize: 11, fontFace: "Arial", color: colors.white, bold: true,
  fill: { color: colors.warning }, align: "center"
});
slide10.addText("score_id (PK)  INT\nstudent_id (FK)  INT\nexperiment_id (FK)  INT\nscore  INT  [分数]\nsubmit_time  DATETIME\nstatus  INT  [0未提交/1已提交]", {
  x: 5.3, y: 3.75, w: 4.1, h: 1.3,
  fontSize: 9, fontFace: "Consolas", color: colors.dark
});

// ========== 第11页：管理员功能模块 ==========
let slide11 = pres.addSlide();
slide11.background = { color: colors.white };
addHeader(slide11, "05 功能模块详解 - 管理员模块", "11");
addFooter(slide11);

const adminFeatures = [
  { title: "账号管理", items: ["教师账号创建与禁用", "重置教师密码", "角色分配（教师/管理员）", "登录状态监控"] },
  { title: "学生管理", items: ["批量导入学生信息", "学生账号批量创建", "学生账号禁用/启用", "导出学生数据"] },
  { title: "班级管理", items: ["创建/编辑班级", "分配班主任/教师", "班级学生列表管理", "班级合并与拆分"] },
  { title: "系统配置", items: ["系统参数设置", "数据备份与恢复", "操作日志查询", "系统状态监控"] }
];

adminFeatures.forEach((f, i) => {
  const row = Math.floor(i / 2);
  const col = i % 2;
  const x = 0.5 + col * 4.7;
  const y = 1.1 + row * 2.1;

  slide11.addShape(pres.shapes.RECTANGLE, {
    x: x, y: y, w: 4.4, h: 1.9,
    fill: { color: colors.white },
    line: { color: colors.primary, width: 1 },
    shadow: { type: "outer", color: "000000", blur: 4, offset: 1, angle: 135, opacity: 0.08 }
  });

  slide11.addShape(pres.shapes.RECTANGLE, {
    x: x, y: y, w: 4.4, h: 0.45,
    fill: { color: colors.primary }
  });

  slide11.addText(f.title, {
    x: x, y: y, w: 4.4, h: 0.45,
    fontSize: 13, fontFace: "Arial", color: colors.white, bold: true,
    align: "center", valign: "middle"
  });

  f.items.forEach((item, j) => {
    slide11.addText("▸  " + item, {
      x: x + 0.15, y: y + 0.55 + j * 0.32, w: 4.1, h: 0.28,
      fontSize: 10, fontFace: "Arial", color: colors.dark
    });
  });
});

// ========== 第12页：教师功能模块 ==========
let slide12 = pres.addSlide();
slide12.background = { color: colors.white };
addHeader(slide12, "05 功能模块详解 - 教师模块", "12");
addFooter(slide12);

const teacherFeatures = [
  { title: "实验管理", items: ["创建实验课程", "设置实验要求与内容", "管理实验题目", "设置实验时间"] },
  { title: "题库管理", items: ["添加/编辑题目", "题目类型：单选/多选/填空/判断/简答", "设置题目分值", "题目分类管理"] },
  { title: "成绩管理", items: ["查看学生成绩", "成绩统计分析", "导出成绩报表", "设置及格线"] },
  { title: "学生管理", items: ["查看班级学生", "学生实验进度跟踪", "催交实验报告", "学生留言回复"] }
];

teacherFeatures.forEach((f, i) => {
  const row = Math.floor(i / 2);
  const col = i % 2;
  const x = 0.5 + col * 4.7;
  const y = 1.1 + row * 2.1;

  slide12.addShape(pres.shapes.RECTANGLE, {
    x: x, y: y, w: 4.4, h: 1.9,
    fill: { color: colors.white },
    line: { color: colors.secondary, width: 1 },
    shadow: { type: "outer", color: "000000", blur: 4, offset: 1, angle: 135, opacity: 0.08 }
  });

  slide12.addShape(pres.shapes.RECTANGLE, {
    x: x, y: y, w: 4.4, h: 0.45,
    fill: { color: colors.secondary }
  });

  slide12.addText(f.title, {
    x: x, y: y, w: 4.4, h: 0.45,
    fontSize: 13, fontFace: "Arial", color: colors.white, bold: true,
    align: "center", valign: "middle"
  });

  f.items.forEach((item, j) => {
    slide12.addText("▸  " + item, {
      x: x + 0.15, y: y + 0.55 + j * 0.32, w: 4.1, h: 0.28,
      fontSize: 10, fontFace: "Arial", color: colors.dark
    });
  });
});

// ========== 第13页：学生功能模块 ==========
let slide13 = pres.addSlide();
slide13.background = { color: colors.white };
addHeader(slide13, "05 功能模块详解 - 学生模块", "13");
addFooter(slide13);

// 左侧大卡片
slide13.addShape(pres.shapes.RECTANGLE, {
  x: 0.5, y: 1.1, w: 5.5, h: 4.0,
  fill: { color: colors.white },
  line: { color: colors.accent, width: 2 }
});

slide13.addShape(pres.shapes.RECTANGLE, {
  x: 0.5, y: 1.1, w: 5.5, h: 0.55,
  fill: { color: colors.accent }
});

slide13.addText("学生核心功能", {
  x: 0.5, y: 1.1, w: 5.5, h: 0.55,
  fontSize: 14, fontFace: "Arial", color: colors.dark, bold: true,
  align: "center", valign: "middle"
});

const studentFeatures = [
  { icon: "📚", name: "实验列表", desc: "查看所有已布置的实验任务" },
  { icon: "✍️", name: "在线答题", desc: "完成实验题目并提交答案" },
  { icon: "📤", name: "报告提交", desc: "上传实验报告及附件" },
  { icon: "📊", name: "成绩查询", desc: "查看历史成绩与评分详情" },
  { icon: "📖", name: "理论课程", desc: "学习课程资料与讲义" },
  { icon: "👤", name: "个人中心", desc: "修改密码、查看个人信息" }
];

studentFeatures.forEach((f, i) => {
  const row = Math.floor(i / 2);
  const col = i % 2;
  const x = 0.7 + col * 2.7;
  const y = 1.8 + row * 1.1;

  slide13.addText(f.icon, {
    x: x, y: y, w: 0.5, h: 0.5,
    fontSize: 24
  });

  slide13.addText(f.name, {
    x: x + 0.5, y: y, w: 2, h: 0.35,
    fontSize: 12, fontFace: "Arial", color: colors.primary, bold: true
  });

  slide13.addText(f.desc, {
    x: x + 0.5, y: y + 0.35, w: 2, h: 0.3,
    fontSize: 9, fontFace: "Arial", color: colors.gray
  });
});

// 右侧流程
slide13.addShape(pres.shapes.RECTANGLE, {
  x: 6.3, y: 1.1, w: 3.2, h: 4.0,
  fill: { color: colors.light }
});

slide13.addText("学习流程", {
  x: 6.3, y: 1.2, w: 3.2, h: 0.4,
  fontSize: 13, fontFace: "Arial", color: colors.primary, bold: true,
  align: "center"
});

const flow = ["查看实验", "学习理论", "完成答题", "提交报告", "等待批改", "查看成绩"];
flow.forEach((f, i) => {
  slide13.addShape(pres.shapes.OVAL, {
    x: 7.0, y: 1.7 + i * 0.55, w: 0.35, h: 0.35,
    fill: { color: colors.secondary }
  });
  slide13.addText((i + 1).toString(), {
    x: 7.0, y: 1.7 + i * 0.55, w: 0.35, h: 0.35,
    fontSize: 10, color: colors.white, align: "center", valign: "middle"
  });
  slide13.addText(f, {
    x: 7.45, y: 1.7 + i * 0.55, w: 1.8, h: 0.35,
    fontSize: 11, fontFace: "Arial", color: colors.dark, valign: "middle"
  });
});

// ========== 第14页：题目类型支持 ==========
let slide14 = pres.addSlide();
slide14.background = { color: colors.white };
addHeader(slide14, "05 功能模块详解 - 题型支持", "14");
addFooter(slide14);

const questionTypes = [
  { icon: "1.", name: "单选题", desc: "从多个选项中选择唯一正确答案\n自动评分，立即显示结果" },
  { icon: "2.", name: "多选题", desc: "从多个选项中选择多个正确答案\n部分得分可配置" },
  { icon: "3.", name: "填空题", desc: "在空白处填写正确答案\n支持模糊匹配" },
  { icon: "4.", name: "判断题", desc: "判断陈述的正确性\n二选一，简单直接" },
  { icon: "5.", name: "简答题", desc: "自由发挥的主观题\n需要教师手动批改" }
];

questionTypes.forEach((q, i) => {
  const y = 1.1 + i * 0.85;

  slide14.addShape(pres.shapes.RECTANGLE, {
    x: 0.5, y: y, w: 9, h: 0.75,
    fill: { color: i % 2 === 0 ? colors.white : colors.lightGray }
  });

  slide14.addShape(pres.shapes.RECTANGLE, {
    x: 0.5, y: y, w: 0.5, h: 0.75,
    fill: { color: colors.secondary }
  });

  slide14.addText(q.icon, {
    x: 0.5, y: y, w: 0.5, h: 0.75,
    fontSize: 12, fontFace: "Arial", color: colors.white, bold: true,
    align: "center", valign: "middle"
  });

  slide14.addText(q.name, {
    x: 1.1, y: y + 0.1, w: 1.5, h: 0.55,
    fontSize: 13, fontFace: "Arial", color: colors.primary, bold: true,
    valign: "middle"
  });

  slide14.addText(q.desc, {
    x: 2.7, y: y + 0.1, w: 6.6, h: 0.55,
    fontSize: 10, fontFace: "Arial", color: colors.dark,
    valign: "middle"
  });
});

// ========== 第15页：安全性设计 ==========
let slide15 = pres.addSlide();
slide15.background = { color: colors.white };
addHeader(slide15, "06 安全与性能优化 - 安全性设计", "15");
addFooter(slide15);

const secFeatures = [
  {
    title: "身份认证",
    items: ["JWT 无状态 Token 认证", "Token 有效期 24 小时", "支持 Token 自动续期", "支持强制下线"]
  },
  {
    title: "密码安全",
    items: ["BCrypt 强哈希加密", "密码错误次数限制（5次）", "IP 地址绑定功能", "定期密码更新提醒"]
  },
  {
    title: "权限控制",
    items: ["RBAC 角色权限模型", "@PreAuthorize 注解控制", "页面级权限验证", "按钮级权限隐藏"]
  },
  {
    title: "日志审计",
    items: ["操作日志记录", "登录日志追踪", "异常信息捕获", "日志查询与导出"]
  }
];

secFeatures.forEach((f, i) => {
  const row = Math.floor(i / 2);
  const col = i % 2;
  const x = 0.5 + col * 4.7;
  const y = 1.1 + row * 2.1;

  slide15.addShape(pres.shapes.RECTANGLE, {
    x: x, y: y, w: 4.4, h: 1.9,
    fill: { color: colors.white },
    line: { color: colors.lightGray, width: 1 }
  });

  slide15.addShape(pres.shapes.RECTANGLE, {
    x: x, y: y, w: 0.08, h: 1.9,
    fill: { color: colors.success }
  });

  slide15.addText(f.title, {
    x: x + 0.2, y: y + 0.1, w: 4, h: 0.4,
    fontSize: 13, fontFace: "Arial", color: colors.primary, bold: true
  });

  f.items.forEach((item, j) => {
    slide15.addText("✓  " + item, {
      x: x + 0.2, y: y + 0.55 + j * 0.32, w: 4, h: 0.28,
      fontSize: 10, fontFace: "Arial", color: colors.dark
    });
  });
});

// ========== 第16页：性能优化 ==========
let slide16 = pres.addSlide();
slide16.background = { color: colors.white };
addHeader(slide16, "06 安全与性能优化 - 性能优化", "16");
addFooter(slide16);

// 优化措施
const optimizations = [
  { icon: "🚀", title: "Redis 缓存", desc: "高频访问数据缓存\n减少数据库查询压力" },
  { icon: "🔗", title: "连接池优化", desc: "Druid 连接池配置\n合理的连接复用策略" },
  { icon: "📦", title: "SQL 优化", desc: "索引优化\n避免全表扫描" },
  { icon: "📁", title: "文件上传", desc: "支持 100MB 大文件\n异步处理机制" }
];

optimizations.forEach((opt, i) => {
  const x = 0.5 + (i % 2) * 4.7;
  const y = 1.1 + Math.floor(i / 2) * 2.1;

  slide16.addShape(pres.shapes.RECTANGLE, {
    x: x, y: y, w: 4.4, h: 1.9,
    fill: { color: colors.white },
    line: { color: colors.secondary, width: 1 },
    shadow: { type: "outer", color: "000000", blur: 6, offset: 2, angle: 135, opacity: 0.08 }
  });

  slide16.addText(opt.icon, {
    x: x, y: y + 0.15, w: 4.4, h: 0.5,
    fontSize: 28, align: "center"
  });

  slide16.addText(opt.title, {
    x: x, y: y + 0.7, w: 4.4, h: 0.4,
    fontSize: 14, fontFace: "Arial", color: colors.primary, bold: true,
    align: "center"
  });

  slide16.addText(opt.desc, {
    x: x + 0.3, y: y + 1.15, w: 3.8, h: 0.65,
    fontSize: 10, fontFace: "Arial", color: colors.gray, align: "center"
  });
});

// ========== 第17页：部署方案 ==========
let slide17 = pres.addSlide();
slide17.background = { color: colors.white };
addHeader(slide17, "07 部署方案", "17");
addFooter(slide17);

// 架构图
slide17.addText("Docker 容器化部署架构", {
  x: 0.5, y: 1.0, w: 9, h: 0.4,
  fontSize: 14, fontFace: "Arial", color: colors.primary, bold: true
});

// Nginx
slide17.addShape(pres.shapes.RECTANGLE, {
  x: 3.5, y: 1.5, w: 3, h: 0.6,
  fill: { color: colors.success }
});
slide17.addText("Nginx", {
  x: 3.5, y: 1.5, w: 3, h: 0.6,
  fontSize: 12, fontFace: "Arial", color: colors.white, bold: true,
  align: "center", valign: "middle"
});

// 后端
slide17.addShape(pres.shapes.RECTANGLE, {
  x: 1.5, y: 2.4, w: 3, h: 0.8,
  fill: { color: colors.secondary }
});
slide17.addText("Spring Boot\nJava Application", {
  x: 1.5, y: 2.4, w: 3, h: 0.8,
  fontSize: 11, fontFace: "Arial", color: colors.white,
  align: "center", valign: "middle"
});

// 前端
slide17.addShape(pres.shapes.RECTANGLE, {
  x: 5.5, y: 2.4, w: 3, h: 0.8,
  fill: { color: colors.accent }
});
slide17.addText("Vue 3\nNginx Static", {
  x: 5.5, y: 2.4, w: 3, h: 0.8,
  fontSize: 11, fontFace: "Arial", color: colors.dark,
  align: "center", valign: "middle"
});

// 数据库
slide17.addShape(pres.shapes.RECTANGLE, {
  x: 1.5, y: 3.5, w: 3, h: 0.8,
  fill: { color: colors.primary }
});
slide17.addText("MySQL 8.0", {
  x: 1.5, y: 3.5, w: 3, h: 0.8,
  fontSize: 12, fontFace: "Arial", color: colors.white, bold: true,
  align: "center", valign: "middle"
});

slide17.addShape(pres.shapes.RECTANGLE, {
  x: 5.5, y: 3.5, w: 3, h: 0.8,
  fill: { color: colors.warning }
});
slide17.addText("Redis", {
  x: 5.5, y: 3.5, w: 3, h: 0.8,
  fontSize: 12, fontFace: "Arial", color: colors.white, bold: true,
  align: "center", valign: "middle"
});

// 部署说明
slide17.addShape(pres.shapes.RECTANGLE, {
  x: 0.5, y: 4.5, w: 9, h: 0.7,
  fill: { color: colors.light }
});
slide17.addText("使用 docker-compose 一键部署：前端静态资源 + 后端服务 + MySQL + Redis", {
  x: 0.5, y: 4.5, w: 9, h: 0.7,
  fontSize: 11, fontFace: "Arial", color: colors.dark,
  align: "center", valign: "middle"
});

// ========== 第18页：总结与展望 ==========
let slide18 = pres.addSlide();
slide18.background = { color: colors.primary };

slide18.addShape(pres.shapes.OVAL, {
  x: -2, y: -2, w: 5, h: 5,
  fill: { color: colors.secondary, transparency: 50 }
});
slide18.addShape(pres.shapes.OVAL, {
  x: 7, y: 3, w: 5, h: 5,
  fill: { color: colors.accent, transparency: 40 }
});

slide18.addText("08  总结与展望", {
  x: 0.5, y: 0.8, w: 9, h: 0.6,
  fontSize: 28, fontFace: "Arial", color: colors.white, bold: true,
  align: "center"
});

// 成果
slide18.addShape(pres.shapes.RECTANGLE, {
  x: 0.5, y: 1.6, w: 4.3, h: 2.3,
  fill: { color: colors.white, transparency: 10 }
});
slide18.addText("项目成果", {
  x: 0.5, y: 1.7, w: 4.3, h: 0.4,
  fontSize: 14, fontFace: "Arial", color: colors.accent, bold: true,
  align: "center"
});
slide18.addText("✓ 完整的实验教学管理功能\n✓ 前后端分离架构\n✓ 安全可靠的认证授权\n✓ 响应式界面设计\n✓ Docker 容器化部署", {
  x: 0.7, y: 2.15, w: 4, h: 1.6,
  fontSize: 11, fontFace: "Arial", color: colors.white
});

// 展望
slide18.addShape(pres.shapes.RECTANGLE, {
  x: 5.2, y: 1.6, w: 4.3, h: 2.3,
  fill: { color: colors.white, transparency: 10 }
});
slide18.addText("未来规划", {
  x: 5.2, y: 1.7, w: 4.3, h: 0.4,
  fontSize: 14, fontFace: "Arial", color: colors.accent, bold: true,
  align: "center"
});
slide18.addText("▸ 移动端 App 开发\n▸ 智能题库与自动组卷\n▸ 学习数据分析与可视化\n▸ AI 辅助批改功能\n▸ 微服务架构改造", {
  x: 5.4, y: 2.15, w: 4, h: 1.6,
  fontSize: 11, fontFace: "Arial", color: colors.white
});

// 底部
slide18.addShape(pres.shapes.RECTANGLE, {
  x: 3.5, y: 4.2, w: 3, h: 0.04,
  fill: { color: colors.white }
});

slide18.addText("感谢观看", {
  x: 0.5, y: 4.5, w: 9, h: 0.6,
  fontSize: 32, fontFace: "Arial", color: colors.white, bold: true,
  align: "center"
});

slide18.addText("Labex 实验教学管理系统", {
  x: 0.5, y: 5.1, w: 9, h: 0.3,
  fontSize: 12, fontFace: "Arial", color: colors.lightGray,
  align: "center"
});

// 保存文件
pres.writeFile({ fileName: "d:/workfordasan/Labex项目详细介绍.pptx" })
  .then(() => console.log("PPT 生成成功: Labex项目详细介绍.pptx（共18页）"))
  .catch(err => console.error("生成失败:", err));
