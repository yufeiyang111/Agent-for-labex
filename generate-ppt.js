const pptxgen = require("pptxgenjs");

let pres = new pptxgen();
pres.layout = "LAYOUT_16x9";
pres.title = "Labex 实验教学管理系统";
pres.author = "Labex Team";

// 配色方案 - 深蓝专业风格
const colors = {
  primary: "1E3A5F",      // 深蓝
  secondary: "2E86AB",    // 中蓝
  accent: "48CAE4",       // 亮蓝
  light: "CAF0F8",        // 浅蓝
  white: "FFFFFF",
  dark: "1A1A2E",
  gray: "64748B",
  lightGray: "E2E8F0"
};

// ========== 封面页 ==========
let slide1 = pres.addSlide();
slide1.background = { color: colors.primary };

// 装饰圆形
slide1.addShape(pres.shapes.OVAL, {
  x: -1.5, y: -1.5, w: 4, h: 4,
  fill: { color: colors.secondary, transparency: 50 }
});
slide1.addShape(pres.shapes.OVAL, {
  x: 7.5, y: 3.5, w: 4, h: 4,
  fill: { color: colors.accent, transparency: 40 }
});

// 主标题
slide1.addText("Labex", {
  x: 0.5, y: 1.8, w: 9, h: 1.2,
  fontSize: 60, fontFace: "Arial Black", color: colors.white,
  bold: true, align: "center"
});

slide1.addText("实验教学管理系统", {
  x: 0.5, y: 3.0, w: 9, h: 0.8,
  fontSize: 36, fontFace: "Arial", color: colors.accent,
  align: "center"
});

// 分隔线
slide1.addShape(pres.shapes.RECTANGLE, {
  x: 3.5, y: 4.0, w: 3, h: 0.05,
  fill: { color: colors.white }
});

slide1.addText("项目技术方案介绍", {
  x: 0.5, y: 4.3, w: 9, h: 0.5,
  fontSize: 18, fontFace: "Arial", color: colors.lightGray,
  align: "center"
});

// ========== 目录页 ==========
let slide2 = pres.addSlide();
slide2.background = { color: colors.white };

// 左侧色块
slide2.addShape(pres.shapes.RECTANGLE, {
  x: 0, y: 0, w: 0.15, h: 5.625,
  fill: { color: colors.primary }
});

slide2.addText("目录", {
  x: 0.5, y: 0.4, w: 9, h: 0.8,
  fontSize: 36, fontFace: "Arial", color: colors.primary,
  bold: true
});

const tocItems = [
  { num: "01", title: "项目概述" },
  { num: "02", title: "技术架构" },
  { num: "03", title: "功能模块" },
  { num: "04", title: "数据库设计" },
  { num: "05", title: "技术亮点" }
];

tocItems.forEach((item, i) => {
  const y = 1.5 + i * 0.75;

  // 序号圆形
  slide2.addShape(pres.shapes.OVAL, {
    x: 0.8, y: y, w: 0.5, h: 0.5,
    fill: { color: colors.secondary }
  });

  slide2.addText(item.num, {
    x: 0.8, y: y, w: 0.5, h: 0.5,
    fontSize: 14, fontFace: "Arial", color: colors.white,
    bold: true, align: "center", valign: "middle"
  });

  slide2.addText(item.title, {
    x: 1.5, y: y, w: 6, h: 0.5,
    fontSize: 20, fontFace: "Arial", color: colors.dark,
    valign: "middle"
  });
});

// ========== 项目概述页 ==========
let slide3 = pres.addSlide();
slide3.background = { color: colors.white };

// 顶部装饰条
slide3.addShape(pres.shapes.RECTANGLE, {
  x: 0, y: 0, w: 10, h: 0.8,
  fill: { color: colors.primary }
});

slide3.addText("01  项目概述", {
  x: 0.5, y: 0.15, w: 9, h: 0.5,
  fontSize: 24, fontFace: "Arial", color: colors.white,
  bold: true
});

// 项目介绍卡片
slide3.addShape(pres.shapes.RECTANGLE, {
  x: 0.5, y: 1.2, w: 9, h: 1.2,
  fill: { color: colors.light },
  line: { color: colors.secondary, width: 1 }
});

slide3.addText("Labex 实验教学管理系统是一套面向高校实验室的数字化教学管理平台，\n支持实验教学、在线考试、成绩管理等核心功能。", {
  x: 0.7, y: 1.35, w: 8.6, h: 0.9,
  fontSize: 16, fontFace: "Arial", color: colors.dark,
  align: "center", valign: "middle"
});

// 三列特点
const features = [
  { icon: "📚", title: "教学管理", desc: "实验内容管理\n在线预习复习" },
  { icon: "✍️", title: "在线考试", desc: "多种题型支持\n自动评分系统" },
  { icon: "📊", title: "数据分析", desc: "成绩统计\n学情分析" }
];

features.forEach((f, i) => {
  const x = 0.8 + i * 3;

  slide3.addShape(pres.shapes.RECTANGLE, {
    x: x, y: 2.7, w: 2.6, h: 2.5,
    fill: { color: colors.white },
    line: { color: colors.lightGray, width: 1 },
    shadow: { type: "outer", color: "000000", blur: 8, offset: 2, angle: 135, opacity: 0.1 }
  });

  slide3.addText(f.icon, {
    x: x, y: 2.9, w: 2.6, h: 0.6,
    fontSize: 32, align: "center"
  });

  slide3.addText(f.title, {
    x: x, y: 3.5, w: 2.6, h: 0.5,
    fontSize: 16, fontFace: "Arial", color: colors.primary,
    bold: true, align: "center"
  });

  slide3.addText(f.desc, {
    x: x + 0.2, y: 4.0, w: 2.2, h: 1,
    fontSize: 12, fontFace: "Arial", color: colors.gray,
    align: "center"
  });
});

// ========== 技术架构页 ==========
let slide4 = pres.addSlide();
slide4.background = { color: colors.white };

slide4.addShape(pres.shapes.RECTANGLE, {
  x: 0, y: 0, w: 10, h: 0.8,
  fill: { color: colors.primary }
});

slide4.addText("02  技术架构", {
  x: 0.5, y: 0.15, w: 9, h: 0.5,
  fontSize: 24, fontFace: "Arial", color: colors.white,
  bold: true
});

// 左侧 - 后端
slide4.addShape(pres.shapes.RECTANGLE, {
  x: 0.5, y: 1.2, w: 4.3, h: 4,
  fill: { color: colors.light },
  line: { color: colors.secondary, width: 2 }
});

slide4.addText("后端技术栈", {
  x: 0.5, y: 1.35, w: 4.3, h: 0.5,
  fontSize: 18, fontFace: "Arial", color: colors.primary,
  bold: true, align: "center"
});

const backendTech = [
  "Spring Boot 2.x",
  "Spring Security",
  "MyBatis-Plus",
  "MySQL 8.0",
  "Redis 缓存",
  "JWT 认证",
  "Druid 连接池"
];

slide4.addText(
  backendTech.map((t, i) => ({
    text: "●  " + t,
    options: { breakLine: i < backendTech.length - 1 }
  })),
  {
    x: 0.8, y: 2.0, w: 3.8, h: 3,
    fontSize: 14, fontFace: "Arial", color: colors.dark,
    paraSpaceAfter: 8
  }
);

// 右侧 - 前端
slide4.addShape(pres.shapes.RECTANGLE, {
  x: 5.2, y: 1.2, w: 4.3, h: 4,
  fill: { color: colors.light },
  line: { color: colors.secondary, width: 2 }
});

slide4.addText("前端技术栈", {
  x: 5.2, y: 1.35, w: 4.3, h: 0.5,
  fontSize: 18, fontFace: "Arial", color: colors.primary,
  bold: true, align: "center"
});

const frontendTech = [
  "Vue 3 + Composition API",
  "Vite 构建工具",
  "Vue Router",
  "Pinia 状态管理",
  "Element Plus",
  "ECharts 可视化",
  "Axios HTTP 客户端"
];

slide4.addText(
  frontendTech.map((t, i) => ({
    text: "●  " + t,
    options: { breakLine: i < frontendTech.length - 1 }
  })),
  {
    x: 5.5, y: 2.0, w: 3.8, h: 3,
    fontSize: 14, fontFace: "Arial", color: colors.dark,
    paraSpaceAfter: 8
  }
);

// ========== 功能模块页 ==========
let slide5 = pres.addSlide();
slide5.background = { color: colors.white };

slide5.addShape(pres.shapes.RECTANGLE, {
  x: 0, y: 0, w: 10, h: 0.8,
  fill: { color: colors.primary }
});

slide5.addText("03  功能模块", {
  x: 0.5, y: 0.15, w: 9, h: 0.5,
  fontSize: 24, fontFace: "Arial", color: colors.white,
  bold: true
});

// 管理员模块
slide5.addShape(pres.shapes.RECTANGLE, {
  x: 0.5, y: 1.1, w: 4.3, h: 2,
  fill: { color: colors.secondary }
});

slide5.addText("管理员模块", {
  x: 0.5, y: 1.2, w: 4.3, h: 0.5,
  fontSize: 16, fontFace: "Arial", color: colors.white,
  bold: true, align: "center"
});

slide5.addText("• 账号管理\n• 学生信息管理\n• 班级管理\n• 系统配置", {
  x: 0.7, y: 1.7, w: 4, h: 1.3,
  fontSize: 12, fontFace: "Arial", color: colors.white
});

// 教师模块
slide5.addShape(pres.shapes.RECTANGLE, {
  x: 5.2, y: 1.1, w: 4.3, h: 2,
  fill: { color: colors.accent }
});

slide5.addText("教师模块", {
  x: 5.2, y: 1.2, w: 4.3, h: 0.5,
  fontSize: 16, fontFace: "Arial", color: colors.dark,
  bold: true, align: "center"
});

slide5.addText("• 实验管理\n• 实验题目管理\n• 成绩管理\n• 学生管理", {
  x: 5.4, y: 1.7, w: 4, h: 1.3,
  fontSize: 12, fontFace: "Arial", color: colors.dark
});

// 学生模块
slide5.addShape(pres.shapes.RECTANGLE, {
  x: 0.5, y: 3.3, w: 4.3, h: 2,
  fill: { color: colors.primary }
});

slide5.addText("学生模块", {
  x: 0.5, y: 3.4, w: 4.3, h: 0.5,
  fontSize: 16, fontFace: "Arial", color: colors.white,
  bold: true, align: "center"
});

slide5.addText("• 在线学习\n• 实验答题\n• 查看成绩\n• 个人中心", {
  x: 0.7, y: 3.9, w: 4, h: 1.3,
  fontSize: 12, fontFace: "Arial", color: colors.white
});

// 公共模块
slide5.addShape(pres.shapes.RECTANGLE, {
  x: 5.2, y: 3.3, w: 4.3, h: 2,
  fill: { color: colors.lightGray }
});

slide5.addText("公共功能", {
  x: 5.2, y: 3.4, w: 4.3, h: 0.5,
  fontSize: 16, fontFace: "Arial", color: colors.dark,
  bold: true, align: "center"
});

slide5.addText("• 用户认证\n• 权限控制\n• 数据统计\n• 系统日志", {
  x: 5.4, y: 3.9, w: 4, h: 1.3,
  fontSize: 12, fontFace: "Arial", color: colors.dark
});

// ========== 数据库设计页 ==========
let slide6 = pres.addSlide();
slide6.background = { color: colors.white };

slide6.addShape(pres.shapes.RECTANGLE, {
  x: 0, y: 0, w: 10, h: 0.8,
  fill: { color: colors.primary }
});

slide6.addText("04  数据库设计", {
  x: 0.5, y: 0.15, w: 9, h: 0.5,
  fontSize: 24, fontFace: "Arial", color: colors.white,
  bold: true
});

// 数据库表列表
const tables = [
  { name: "t_teacher", desc: "教师/管理员表" },
  { name: "t_student", desc: "学生表" },
  { name: "t_clazz", desc: "班级表" },
  { name: "t_experiment", desc: "实验表" },
  { name: "t_experiment_item", desc: "实验题目表" },
  { name: "t_score", desc: "成绩表" },
  { name: "t_lecture", desc: "理论课表" },
  { name: "t_exam", desc: "考试表" },
  { name: "t_paper_question", desc: "试卷题目表" },
  { name: "t_student_answer", desc: "学生答题表" },
  { name: "t_sys_log", desc: "系统日志表" }
];

// 左列
tables.slice(0, 6).forEach((t, i) => {
  const y = 1.1 + i * 0.55;

  slide6.addShape(pres.shapes.RECTANGLE, {
    x: 0.5, y: y, w: 0.1, h: 0.4,
    fill: { color: colors.secondary }
  });

  slide6.addText(t.name, {
    x: 0.7, y: y, w: 2, h: 0.4,
    fontSize: 12, fontFace: "Consolas", color: colors.primary,
    bold: true, valign: "middle"
  });

  slide6.addText(t.desc, {
    x: 2.7, y: y, w: 2.3, h: 0.4,
    fontSize: 11, fontFace: "Arial", color: colors.gray,
    valign: "middle"
  });
});

// 右列
tables.slice(6).forEach((t, i) => {
  const y = 1.1 + i * 0.55;

  slide6.addShape(pres.shapes.RECTANGLE, {
    x: 5.2, y: y, w: 0.1, h: 0.4,
    fill: { color: colors.accent }
  });

  slide6.addText(t.name, {
    x: 5.4, y: y, w: 2, h: 0.4,
    fontSize: 12, fontFace: "Consolas", color: colors.primary,
    bold: true, valign: "middle"
  });

  slide6.addText(t.desc, {
    x: 7.4, y: y, w: 2.3, h: 0.4,
    fontSize: 11, fontFace: "Arial", color: colors.gray,
    valign: "middle"
  });
});

// 底部说明
slide6.addShape(pres.shapes.RECTANGLE, {
  x: 0.5, y: 4.6, w: 9, h: 0.7,
  fill: { color: colors.light }
});

slide6.addText("数据库引擎: InnoDB  |  字符集: utf8mb4  |  支持逻辑删除", {
  x: 0.5, y: 4.6, w: 9, h: 0.7,
  fontSize: 12, fontFace: "Arial", color: colors.dark,
  align: "center", valign: "middle"
});

// ========== 技术亮点页 ==========
let slide7 = pres.addSlide();
slide7.background = { color: colors.white };

slide7.addShape(pres.shapes.RECTANGLE, {
  x: 0, y: 0, w: 10, h: 0.8,
  fill: { color: colors.primary }
});

slide7.addText("05  技术亮点", {
  x: 0.5, y: 0.15, w: 9, h: 0.5,
  fontSize: 24, fontFace: "Arial", color: colors.white,
  bold: true
});

const highlights = [
  { title: "JWT 无状态认证", desc: "支持 Token 自动续期，安全高效" },
  { title: "RBAC 权限控制", desc: "细粒度权限管理，支持页面级控制" },
  { title: "Redis 缓存优化", desc: "高频数据缓存，提升系统响应速度" },
  { title: "Druid 监控", desc: "SQL 监控、连接池管理、性能分析" },
  { title: "逻辑删除设计", desc: "数据可恢复，符合教学数据管理需求" },
  { title: "响应式设计", desc: "适配多端访问，支持大文件上传" }
];

highlights.forEach((h, i) => {
  const row = Math.floor(i / 2);
  const col = i % 2;
  const x = 0.5 + col * 4.7;
  const y = 1.1 + row * 1.4;

  slide7.addShape(pres.shapes.RECTANGLE, {
    x: x, y: y, w: 4.4, h: 1.2,
    fill: { color: colors.white },
    line: { color: colors.lightGray, width: 1 },
    shadow: { type: "outer", color: "000000", blur: 6, offset: 2, angle: 135, opacity: 0.08 }
  });

  // 左侧装饰条
  slide7.addShape(pres.shapes.RECTANGLE, {
    x: x, y: y, w: 0.08, h: 1.2,
    fill: { color: colors.secondary }
  });

  slide7.addText(h.title, {
    x: x + 0.2, y: y + 0.15, w: 4, h: 0.45,
    fontSize: 14, fontFace: "Arial", color: colors.primary,
    bold: true, valign: "middle"
  });

  slide7.addText(h.desc, {
    x: x + 0.2, y: y + 0.6, w: 4, h: 0.45,
    fontSize: 11, fontFace: "Arial", color: colors.gray,
    valign: "middle"
  });
});

// ========== 结束页 ==========
let slide8 = pres.addSlide();
slide8.background = { color: colors.primary };

slide8.addShape(pres.shapes.OVAL, {
  x: -2, y: 2, w: 5, h: 5,
  fill: { color: colors.secondary, transparency: 50 }
});

slide8.addShape(pres.shapes.OVAL, {
  x: 7, y: -1, w: 5, h: 5,
  fill: { color: colors.accent, transparency: 40 }
});

slide8.addText("感谢观看", {
  x: 0.5, y: 2.0, w: 9, h: 1,
  fontSize: 48, fontFace: "Arial", color: colors.white,
  bold: true, align: "center"
});

slide8.addShape(pres.shapes.RECTANGLE, {
  x: 4, y: 3.2, w: 2, h: 0.05,
  fill: { color: colors.white }
});

slide8.addText("Labex 实验教学管理系统", {
  x: 0.5, y: 3.5, w: 9, h: 0.5,
  fontSize: 16, fontFace: "Arial", color: colors.lightGray,
  align: "center"
});

// 保存文件
pres.writeFile({ fileName: "d:/workfordasan/Labex项目介绍.pptx" })
  .then(() => console.log("PPT 生成成功: Labex项目介绍.pptx"))
  .catch(err => console.error("生成失败:", err));
