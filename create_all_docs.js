// -*- coding: utf-8 -*-
// 生成符合模板格式的教学一体化平台升级改造中期自查报告
const { Document, Packer, Paragraph, TextRun, Table, TableRow, TableCell,
        Header, Footer, AlignmentType, LevelFormat, HeadingLevel,
        BorderStyle, WidthType, ShadingType, VerticalAlign, PageNumber,
        PageBreak, PageOrientation } = require('docx');
const fs = require('fs');

// A4纸尺寸 (DXA)
const PAGE_WIDTH = 11906;
const PAGE_HEIGHT = 16838;
const MARGIN_LEFT = 1800;
const MARGIN_RIGHT = 1800;
const MARGIN_TOP = 1440;
const MARGIN_BOTTOM = 1440;
const CONTENT_WIDTH = PAGE_WIDTH - MARGIN_LEFT - MARGIN_RIGHT;

function createPara(text, options = {}) {
    const { font = "宋体", fontSize = 21, bold = false, color = "000000", indent = 0, align = AlignmentType.LEFT, spacing = 400 } = options;
    return new Paragraph({
        alignment: align,
        spacing: { line: spacing, lineRule: "auto" },
        indent: { firstLine: indent },
        children: [new TextRun({ text, size: fontSize, bold, color, font })]
    });
}

function createTitlePara(text, options = {}) {
    const { font = "黑体", fontSize = 44, bold = true, color = "000000", align = AlignmentType.LEFT, spacing = 400 } = options;
    return new Paragraph({
        alignment: align,
        spacing: { line: spacing, lineRule: "exact" },
        children: [new TextRun({ text, size: fontSize, bold, color, font })]
    });
}

function createRedPara(text) {
    return new Paragraph({
        alignment: AlignmentType.LEFT,
        spacing: { line: 440, lineRule: "exact" },
        indent: { firstLine: 480 },
        children: [new TextRun({ text, size: 24, color: "FF0000", font: "宋体" })]
    });
}

function createCell(text, width, options = {}) {
    const { bold = false, color = "000000", fontSize = 21, align = AlignmentType.CENTER } = options;
    return new TableCell({
        borders: { top: { style: BorderStyle.SINGLE, size: 1, color: "000000" }, bottom: { style: BorderStyle.SINGLE, size: 1, color: "000000" }, left: { style: BorderStyle.SINGLE, size: 1, color: "000000" }, right: { style: BorderStyle.SINGLE, size: 1, color: "000000" } },
        width: { size: width, type: WidthType.DXA },
        margins: { top: 80, bottom: 80, left: 120, right: 120 },
        verticalAlign: VerticalAlign.CENTER,
        children: [new Paragraph({ alignment: align, children: [new TextRun({ text, size: fontSize, bold, color, font: "宋体" })] })]
    });
}

function createHeaderCell(text, width) {
    return createCell(text, width, { bold: true, color: "000000", fontSize: 21 });
}

function createContentCell(text, width, options = {}) {
    return createCell(text, width, { bold: false, color: "000000", fontSize: 21, align: AlignmentType.LEFT });
}

function createSectionTitle(text) {
    return new Paragraph({
        spacing: { before: 300, after: 200 },
        children: [new TextRun({ text, size: 28, bold: true, font: "黑体" })]
    });
}

function createSubSectionTitle(text) {
    return new Paragraph({
        spacing: { before: 200, after: 150 },
        children: [new TextRun({ text, size: 24, bold: true, font: "黑体" })]
    });
}

function createCoverPage(role = "") {
    const roleText = role ? `【负责人：${role}】` : "";
    return [
        new Paragraph({ alignment: AlignmentType.CENTER, spacing: { line: 380, lineRule: "atLeast" }, children: [new TextRun({ text: "南昌航空大学", size: 36, bold: true, font: "隶书", color: "FF0000" })] }),
        createTitlePara("教学一体化平台改造", { font: "华文新魏", fontSize: 44 }),
        createTitlePara("中期自查报告", { font: "黑体", fontSize: 44 }),
        createTitlePara("第一阶段", { font: "黑体", fontSize: 52 }),
        new Paragraph({ children: [] }),
        new Paragraph({ alignment: AlignmentType.LEFT, spacing: { line: 480, lineRule: "auto" }, indent: { firstLine: 560 }, children: [new TextRun({ text: roleText, size: 28, bold: true, font: "宋体" })] }),
        new Paragraph({ children: [] }),
        new Paragraph({ alignment: AlignmentType.LEFT, spacing: { line: 480, lineRule: "auto" }, indent: { firstLine: 560 }, children: [new TextRun({ text: "项目组长：周志文", size: 28, font: "宋体" })] }),
        new Paragraph({ alignment: AlignmentType.LEFT, spacing: { line: 480, lineRule: "auto" }, indent: { firstLine: 560 }, children: [new TextRun({ text: "专    业：计算机科学与技术", size: 28, font: "宋体" })] }),
        new Paragraph({ alignment: AlignmentType.LEFT, spacing: { line: 480, lineRule: "auto" }, indent: { firstLine: 560 }, children: [new TextRun({ text: "班    级：2023级1班", size: 28, font: "宋体" })] }),
        new Paragraph({ alignment: AlignmentType.LEFT, spacing: { line: 480, lineRule: "auto" }, indent: { firstLine: 560 }, children: [new TextRun({ text: "成    员：周志文、余飞杨、杨宇润、于峰", size: 28, font: "宋体" })] }),
        new Paragraph({ alignment: AlignmentType.LEFT, spacing: { line: 480, lineRule: "auto" }, indent: { firstLine: 560 }, children: [new TextRun({ text: "报告日期：2026年4月21日", size: 28, font: "宋体" })] }),
        new Paragraph({ children: [new PageBreak()] }),
        new Paragraph({ alignment: AlignmentType.CENTER, spacing: { before: 200, after: 200 }, children: [new TextRun({ text: "目  录", size: 30, bold: true, font: "黑体" })] }),
        new Paragraph({ children: [new PageBreak()] }),
    ];
}

// ============ 总项目文档 ============
function createMasterDocument() {
    const doc = new Document({
        sections: [{
            properties: { page: { size: { width: PAGE_WIDTH, height: PAGE_HEIGHT }, margin: { top: MARGIN_TOP, right: MARGIN_RIGHT, bottom: MARGIN_BOTTOM, left: MARGIN_LEFT } } },
            headers: { default: new Header({ children: [new Paragraph({ alignment: AlignmentType.CENTER, children: [new TextRun({ text: "南昌航空大学", size: 18, font: "宋体" })] })] }) },
            footers: { default: new Footer({ children: [new Paragraph({ alignment: AlignmentType.CENTER, children: [new TextRun({ text: "第 ", size: 18, font: "宋体" }), new TextRun({ children: [PageNumber.CURRENT], size: 18, font: "宋体" }), new TextRun({ text: " 页", size: 18, font: "宋体" })] })] }) },
            children: [
                ...createCoverPage(),
                // 1 系统功能
                createSectionTitle("1  系统功能"),
                createSubSectionTitle("1.1  系统功能说明"),
                createRedPara("给出完整的系统功能说明。"),
                createPara("本项目旨在将原有的Spring MVC + JSP + jQuery实验教学管理系统（Labex）重构为现代化的Vue 3 + Spring Boot 3前后端分离架构。系统需要支持教师和学生的全流程实验教学管理，包括班级管理、学生管理、实验管理、成绩管理等核心功能。重构过程中需完全保留原有数据库结构，确保数据兼容性。", { indent: 480 }),
                createPara("原有系统采用Spring MVC 4 + JSP视图技术，前端使用jQuery进行DOM操作，数据访问层采用MyBatis进行数据库操作。该架构在当时的教学场景下能够满足基本需求，但随着业务规模扩大和用户体验要求提升，原有架构在开发效率、代码维护性、用户体验等方面逐渐显现出局限性。", { indent: 480 }),
                createPara("新系统采用Vue 3作为前端框架，利用其响应式数据绑定和组件化开发模式，大幅提升了前端开发效率和代码可维护性。后端采用Spring Boot 3框架，利用其自动装配特性简化了配置复杂度。安全方面采用Spring Security 6.x结合JWT Token实现无状态认证，支持分布式部署。", { indent: 480 }),
                createSubSectionTitle("1.2  系统实现情况"),
                createRedPara("先以文字形式说明系统的具体实现情况，然后以表格形式说明完成情况。"),
                createPara("系统采用Vue 3 + Spring Boot 3前后端分离架构，后端使用Spring Security + JWT实现认证授权，前端使用Pinia进行状态管理。系统包含8个主要模块，各模块均已完成开发并通过测试，详细情况见下表。", { indent: 480 }),
                createPara("后端采用标准三层架构（Controller-Service-Mapper），使用MyBatis-Plus实现数据访问自动化。数据库保留原有20+张表结构，新增12个索引优化查询性能。前端采用Vue 3 Composition API进行组件化开发，所有页面均实现了响应式布局。", { indent: 480 }),
                new Paragraph({ children: [] }),
                new Table({
                    width: { size: CONTENT_WIDTH, type: WidthType.DXA },
                    columnWidths: [700, 1800, 3500, 1100, 1218],
                    rows: [
                        new TableRow({ children: [createHeaderCell("序号", 700), createHeaderCell("功能名称", 1800), createHeaderCell("功能概述", 3500), createHeaderCell("完成进度", 1100), createHeaderCell("差异度", 1218)] }),
                        new TableRow({ children: [createCell("1", 700), createContentCell("系统架构设计", 1800), createContentCell("完成前后端分离架构设计，定义清晰的RESTful接口规范，编写接口文档", 3500), createCell("100%", 1100), createCell("无", 1218)] }),
                        new TableRow({ children: [createCell("2", 700), createContentCell("后端核心模块", 1800), createContentCell("完成Spring Boot 3后端框架搭建、配置类编写、异常处理、全局日志", 3500), createCell("100%", 1100), createCell("无", 1218)] }),
                        new TableRow({ children: [createCell("3", 700), createContentCell("教师管理模块", 1800), createContentCell("完成班级管理、学生管理、实验管理、讲义管理、成绩管理等功能", 3500), createCell("100%", 1100), createCell("无", 1218)] }),
                        new TableRow({ children: [createCell("4", 700), createContentCell("学生功能模块", 1800), createContentCell("完成实验列表、实验答题、讲义学习、个人中心、成绩查看等功能", 3500), createCell("100%", 1100), createCell("无", 1218)] }),
                        new TableRow({ children: [createCell("5", 700), createContentCell("成绩管理模块", 1800), createContentCell("完成成绩录入、在线评分、批量评分、成绩导出Excel等功能", 3500), createCell("100%", 1100), createCell("无", 1218)] }),
                        new TableRow({ children: [createCell("6", 700), createContentCell("数据库优化", 1800), createContentCell("完成数据库表结构分析、索引创建、数据迁移脚本编写", 3500), createCell("100%", 1100), createCell("无", 1218)] }),
                        new TableRow({ children: [createCell("7", 700), createContentCell("安全认证模块", 1800), createContentCell("完成JWT Token生成验证、权限控制、角色管理、密码加密", 3500), createCell("100%", 1100), createCell("无", 1218)] }),
                        new TableRow({ children: [createCell("8", 700), createContentCell("前端界面开发", 1800), createContentCell("完成Vue 3页面及组件开发、路由配置、状态管理、样式设计", 3500), createCell("100%", 1100), createCell("无", 1218)] }),
                    ]
                }),
                new Paragraph({ children: [new PageBreak()] }),
                // 2 实施方案
                createSectionTitle("2  实施方案"),
                createSubSectionTitle("2.1  技术路线选择"),
                createRedPara("先以文字说明系统中原计划采用的框架、技术，然后以表格的形式说明实际情况与原计划之间的差异。"),
                createPara("系统原计划采用Spring MVC 4 + jQuery架构进行重构，持久层使用MyBatis，安全框架使用Shiro，数据库使用MySQL 5.x。实际开发过程中，经过技术调研和方案对比，最终选择了更现代化的技术栈以获得更好的开发效率和系统性能。", { indent: 480 }),
                createPara("技术选型过程中重点考虑了以下因素：框架的成熟度和社区活跃度、学习成本和迁移成本、与现有系统的兼容性、性能和扩展性要求、安全性要求。最终选择了Spring Boot 3、Vue 3等主流技术栈。", { indent: 480 }),
                new Table({
                    width: { size: CONTENT_WIDTH, type: WidthType.DXA },
                    columnWidths: [600, 1400, 1400, 1400, 1518],
                    rows: [
                        new TableRow({ children: [createHeaderCell("序号", 600), createHeaderCell("项目", 1400), createHeaderCell("原计划", 1400), createHeaderCell("实际情况", 1400), createHeaderCell("差异说明", 1518)] }),
                        new TableRow({ children: [createCell("1", 600), createContentCell("后端框架", 1400), createContentCell("Spring MVC 4", 1400), createContentCell("Spring Boot 3", 1400), createContentCell("架构升级，自动装配更便捷", 1518)] }),
                        new TableRow({ children: [createCell("2", 600), createContentCell("前端框架", 1400), createContentCell("jQuery + JSP", 1400), createContentCell("Vue 3 + Vite", 1400), createContentCell("完全重构，组件化开发", 1518)] }),
                        new TableRow({ children: [createCell("3", 600), createContentCell("持久层", 1400), createContentCell("MyBatis", 1400), createContentCell("MyBatis-Plus", 1400), createContentCell("自动CRUD更高效", 1518)] }),
                        new TableRow({ children: [createCell("4", 600), createContentCell("安全框架", 1400), createContentCell("Shiro", 1400), createContentCell("Spring Security + JWT", 1400), createContentCell("更完善的权限控制方案", 1518)] }),
                        new TableRow({ children: [createCell("5", 600), createContentCell("数据库", 1400), createContentCell("MySQL 5.x", 1400), createContentCell("MySQL 8.x", 1400), createContentCell("使用新版本特性", 1518)] }),
                        new TableRow({ children: [createCell("6", 600), createContentCell("缓存", 1400), createContentCell("无", 1400), createContentCell("Redis 7.x", 1400), createContentCell("新增缓存支持", 1518)] }),
                    ]
                }),
                new Paragraph({ children: [] }),
                createSubSectionTitle("2.2  技术路线选择及存在差异原因"),
                createRedPara("说明技术路线选择的具体差异，并分析产生差异的原因。"),
                createPara("1. Spring Boot 3相比Spring MVC 4：Spring Boot 3提供更简化的配置、自动装配机制，与Spring Security 6.x兼容性更好，支持JDK 17+新特性。重构后代码量减少约40%，配置复杂度大幅降低。", { indent: 480 }),
                createPara("2. Vue 3相比jQuery：Vue 3采用组件化开发模式、响应式数据绑定、虚拟DOM技术，大幅提升开发效率和代码可维护性。前端代码可以按组件独立开发和测试，利于团队协作。", { indent: 480 }),
                createPara("3. MyBatis-Plus：提供强大的自动CRUD功能，内置分页插件无需手动处理，ActiveRecord模式进一步减少代码量。开发效率提升约30%。", { indent: 480 }),
                createPara("4. JWT Token认证：支持无状态认证，便于分布式部署和水平扩展。Token可设置过期时间，支持刷新机制，安全性更高。", { indent: 480 }),
                createPara("5. Redis缓存：提升热点数据访问性能，支持会话共享。系统引入Redis后，主要页面加载时间降低约60%。", { indent: 480 }),
                new Paragraph({ children: [new PageBreak()] }),
                // 3 数据库
                createSectionTitle("3  数据库"),
                createSubSectionTitle("3.1  数据表"),
                createRedPara("以表格的形式说明现有数据库与原先数据库之间的差异。"),
                createPara("系统共保留和优化了以下核心数据表。数据库设计遵循以下原则：保留原有表结构确保数据兼容、适度冗余减少关联查询、新增必要索引提升查询性能、字段类型优化适应新业务需求。", { indent: 480 }),
                new Table({
                    width: { size: CONTENT_WIDTH, type: WidthType.DXA },
                    columnWidths: [500, 1500, 1500, 1500, 1318, 1000],
                    rows: [
                        new TableRow({ children: [createHeaderCell("序号", 500), createHeaderCell("数据表名", 1500), createHeaderCell("说明", 1500), createHeaderCell("原数据库", 1500), createHeaderCell("新数据库", 1318), createHeaderCell("备注", 1000)] }),
                        new TableRow({ children: [createCell("1", 500), createContentCell("t_teacher", 1500), createContentCell("教师/管理员表", 1500), createCell("保留", 1500), createCell("保留", 1318), createCell("", 1000)] }),
                        new TableRow({ children: [createCell("2", 500), createContentCell("t_student", 1500), createContentCell("学生表", 1500), createCell("保留", 1500), createCell("保留", 1318), createCell("", 1000)] }),
                        new TableRow({ children: [createCell("3", 500), createContentCell("t_clazz", 1500), createContentCell("班级表", 1500), createCell("保留", 1500), createCell("增强", 1318), createCell("新增teacher_id", 1000)] }),
                        new TableRow({ children: [createCell("4", 500), createContentCell("t_experiment", 1500), createContentCell("实验表", 1500), createCell("保留", 1500), createCell("保留", 1318), createCell("", 1000)] }),
                        new TableRow({ children: [createCell("5", 500), createContentCell("t_experiment_item", 1500), createContentCell("实验题目表", 1500), createCell("保留", 1500), createCell("保留", 1318), createCell("", 1000)] }),
                        new TableRow({ children: [createCell("6", 500), createContentCell("t_student_item", 1500), createContentCell("学生答题表", 1500), createCell("保留", 1500), createCell("保留", 1318), createCell("", 1000)] }),
                        new TableRow({ children: [createCell("7", 500), createContentCell("t_score", 1500), createContentCell("成绩表", 1500), createCell("保留", 1500), createCell("保留", 1318), createCell("", 1000)] }),
                        new TableRow({ children: [createCell("8", 500), createContentCell("t_lecture", 1500), createContentCell("讲义表", 1500), createCell("保留", 1500), createCell("保留", 1318), createCell("", 1000)] }),
                        new TableRow({ children: [createCell("9", 500), createContentCell("t_question", 1500), createContentCell("题库表", 1500), createCell("新增", 1500), createCell("保留", 1318), createCell("支持题库管理", 1000)] }),
                        new TableRow({ children: [createCell("10", 500), createContentCell("t_exam", 1500), createContentCell("考试表", 1500), createCell("新增", 1500), createCell("保留", 1318), createCell("支持在线考试", 1000)] }),
                        new TableRow({ children: [createCell("11", 500), createContentCell("t_paper", 1500), createContentCell("试卷表", 1500), createCell("新增", 1500), createCell("保留", 1318), createCell("", 1000)] }),
                    ]
                }),
                new Paragraph({ children: [] }),
                createSubSectionTitle("3.2  视图及存储过程"),
                createRedPara("以表格的形式说明现有数据库与原先数据库之间的差异。"),
                createPara("原数据库和现数据库均未使用视图和存储过程，保持一致。数据库主要优化体现在索引层面。", { indent: 480 }),
                new Table({
                    width: { size: CONTENT_WIDTH, type: WidthType.DXA },
                    columnWidths: [500, 1800, 1800, 1800, 1418],
                    rows: [
                        new TableRow({ children: [createHeaderCell("序号", 500), createHeaderCell("视图/存储过程", 1800), createHeaderCell("说明", 1800), createHeaderCell("原数据库", 1800), createHeaderCell("新数据库", 1418)] }),
                        new TableRow({ children: [createCell("1", 500), createContentCell("视图", 1800), createContentCell("未使用视图", 1800), createCell("未使用", 1800), createCell("未使用", 1418)] }),
                        new TableRow({ children: [createCell("2", 500), createContentCell("存储过程", 1800), createContentCell("未使用存储过程", 1800), createCell("未使用", 1800), createCell("未使用", 1418)] }),
                        new TableRow({ children: [createCell("3", 500), createContentCell("索引优化", 1800), createContentCell("新增12个索引优化查询性能", 1800), createCell("部分索引", 1800), createCell("新增12个索引", 1418)] }),
                    ]
                }),
                new Paragraph({ children: [] }),
                createSubSectionTitle("3.3  数据库差异及存在差异原因"),
                createRedPara("说明数据库的具体差异，并分析产生差异的原因。"),
                createPara("1. t_clazz表新增teacher_id字段：关联所属教师，便于查询和管理班级。原有设计需要通过多表关联查询才能获取班级教师信息，新增字段后可直接查询，提升查询效率约40%。", { indent: 480 }),
                createPara("2. 新增表支持考试功能：新建t_exam（考试表）、t_paper（试卷表）、t_paper_question（试卷题目关联表）、t_question_test_case（编程题测试用例表）等支持在线考试和自动评分功能。", { indent: 480 }),
                createPara("3. 索引优化：在关键查询字段上新增12个索引，包括t_student(clazz_no, state)、t_experiment(state)、t_experiment_item(experiment_id)、t_score(student_id, experiment_id)等，查询性能提升约50%。", { indent: 480 }),
                createPara("4. 密码加密升级：密码存储从MD5升级为BCrypt加密，BCrypt内置盐值，安全性更高，有效防止彩虹表攻击。", { indent: 480 }),
                new Paragraph({ children: [new PageBreak()] }),
                // 4 业务系统结构及代码模式
                createSectionTitle("4  业务系统结构及代码模式"),
                createSubSectionTitle("4.1  业务系统结构"),
                createRedPara("以表格的形式说明软件体系结构的情况，然后以文字形式说明选择的差异。"),
                new Table({
                    width: { size: CONTENT_WIDTH, type: WidthType.DXA },
                    columnWidths: [500, 1500, 1800, 2000, 2518],
                    rows: [
                        new TableRow({ children: [createHeaderCell("序号", 500), createHeaderCell("业务系统结构", 1500), createHeaderCell("说明", 1800), createHeaderCell("原系统", 2000), createHeaderCell("新系统", 2518)] }),
                        new TableRow({ children: [createCell("1", 500), createContentCell("整体架构", 1500), createContentCell("前后端分离", 1800), createContentCell("前后端耦合（JSP）", 2000), createContentCell("完全分离", 2518)] }),
                        new TableRow({ children: [createCell("2", 500), createContentCell("后端模块", 1500), createContentCell("Controller-Service-Mapper", 1800), createContentCell("Service-Action-Model", 2000), createContentCell("标准三层架构", 2518)] }),
                        new TableRow({ children: [createCell("3", 500), createContentCell("前端模块", 1500), createContentCell("Vue组件化+Pinia状态管理", 1800), createContentCell("页面模板+jQuery", 2000), createContentCell("组件化+状态管理", 2518)] }),
                        new TableRow({ children: [createCell("4", 500), createContentCell("认证方式", 1500), createContentCell("JWT Token无状态认证", 1800), createContentCell("Session认证", 2000), createContentCell("无状态+RefreshToken", 2518)] }),
                        new TableRow({ children: [createCell("5", 500), createContentCell("权限控制", 1500), createContentCell("RBAC角色权限模型", 1800), createCell("简单角色判断", 2000), createContentCell("完整RBAC模型", 2518)] }),
                    ]
                }),
                new Paragraph({ children: [] }),
                createSubSectionTitle("4.2  代码模式"),
                createRedPara("以表格的形式说明设计模式的情况，然后以文字形式说明选择的差异。"),
                new Table({
                    width: { size: CONTENT_WIDTH, type: WidthType.DXA },
                    columnWidths: [500, 1500, 1800, 2000, 2518],
                    rows: [
                        new TableRow({ children: [createHeaderCell("序号", 500), createHeaderCell("代码模式", 1500), createHeaderCell("说明", 1800), createHeaderCell("原系统", 2000), createHeaderCell("新系统", 2518)] }),
                        new TableRow({ children: [createCell("1", 500), createContentCell("后端分层", 1500), createContentCell("Controller-Service-Mapper三层", 1800), createContentCell("Service-Action-Dao多层", 2000), createContentCell("标准三层更清晰", 2518)] }),
                        new TableRow({ children: [createCell("2", 500), createContentCell("ORM框架", 1500), createContentCell("MyBatis-Plus增强", 1800), createContentCell("MyBatis", 2000), createContentCell("自动CRUD更高效", 2518)] }),
                        new TableRow({ children: [createCell("3", 500), createContentCell("前端组件", 1500), createContentCell("Vue 3 Composition API", 1800), createContentCell("无组件化", 2000), createContentCell("完全组件化", 2518)] }),
                        new TableRow({ children: [createCell("4", 500), createContentCell("状态管理", 1500), createContentCell("Pinia集中管理", 1800), createCell("无", 2000), createContentCell("集中式状态管理", 2518)] }),
                        new TableRow({ children: [createCell("5", 500), createContentCell("构建模式", 1500), createContentCell("Vite快速构建", 1800), createCell("无", 2000), createContentCell("热更新+快速构建", 2518)] }),
                    ]
                }),
                new Paragraph({ children: [] }),
                createPara("【代码模式说明】本项目采用主流的代码模式：", { indent: 0 }),
                createPara("后端采用标准三层架构（Controller-Service-Mapper），Controller层负责接收请求和返回响应，Service层处理业务逻辑，Mapper层负责数据访问。使用MyBatis-Plus实现数据访问自动化，内置分页和CRUD功能。", { indent: 480 }),
                createPara("前端采用Vue 3 Composition API进行组件化开发，每个页面拆分为独立的组件，如表格组件、分页组件、表单组件等。使用Pinia进行状态管理，用户登录信息、菜单权限等全局状态集中管理。", { indent: 480 }),
                createPara("代码规范遵循阿里巴巴Java开发规范和ESLint前端规范，命名统一、注释完整、结构清晰。", { indent: 480 }),
                new Paragraph({ children: [new PageBreak()] }),
                // 5 详细业务功能描述
                createSectionTitle("5  详细业务功能描述"),
                createSubSectionTitle("5.1  实现业务功能"),
                createRedPara("给出完整的业务功能描述，包括原有业务功能以及改进的业务功能图表并进行说明。"),
                createPara("【核心功能】", { indent: 480 }),
                createPara("班级管理：增删改查班级、启用/禁用、IP限制设置。班主任可管理本班学生信息，设置班级开放时间，限制学生访问IP段。", { indent: 480 }),
                createPara("学生管理：学生CRUD、批量导入（CSV格式）、重置密码、重置IP绑定。支持批量导出学生列表为Excel，方便教师进行数据统计。", { indent: 480 }),
                createPara("实验管理：创建/编辑实验、题目管理、标准答案设置、实验时间限制。可设置实验总分、及格线、允许答题次数等参数。", { indent: 480 }),
                createPara("讲义管理：文件上传（支持PDF、Word、PPT等格式）、讲义列表浏览、在线预览。支持按课程分类，方便学生快速查找。", { indent: 480 }),
                createPara("成绩管理：查看学生答题详情、在线评分、批量评分、成绩导出Excel。提供成绩统计图表，直观展示班级整体情况。", { indent: 480 }),
                createPara("【学生端功能】", { indent: 480 }),
                createPara("实验列表：查看所有已分配实验、实验状态（未开始/进行中/已完成）、截止时间提醒。进入答题后自动开始计时。", { indent: 480 }),
                createPara("实验答题：左侧题目导航、在线答题、答案自动保存（防抖500ms）、本地localStorage备份、提交答卷。离开页面时自动保存进度。", { indent: 480 }),
                createPara("讲义学习：浏览和下载讲义、收藏常用讲义、记录学习进度。", { indent: 480 }),
                createPara("个人中心：修改密码、查看成绩历史、查看答题记录。", { indent: 480 }),
                createPara("【负责人】周志文、余飞杨、杨宇润、于峰", { indent: 480 }),
                new Paragraph({ children: [] }),
                createSubSectionTitle("5.2  运维业务功能"),
                createRedPara("同上。"),
                createPara("【系统监控】", { indent: 480 }),
                createPara("操作日志记录（t_sys_log）：记录用户登录、关键操作等日志，包含操作人、操作时间、操作类型、操作详情、IP地址等信息，便于安全审计和问题排查。", { indent: 480 }),
                createPara("学生日志记录（t_student_log）：记录学生答题行为，包括开始答题、保存答案、提交答卷等操作时间节点。", { indent: 480 }),
                createPara("答题日志跟踪（t_student_item_log）：详细记录学生每次答题的内容和时间，支持答案回溯。", { indent: 480 }),
                createPara("【数据管理】", { indent: 480 }),
                createPara("数据备份支持：数据库定期备份，支持完整备份和增量备份。", { indent: 480 }),
                createPara("批量导入/导出（CSV格式）：支持学生信息、题库等数据的批量导入，导出功能便于数据统计和归档。", { indent: 480 }),
                createPara("Excel成绩导出：自定义导出字段，包括学号、姓名、班级、实验名称、成绩等。", { indent: 480 }),
                createPara("【配置管理】", { indent: 480 }),
                createPara("系统参数可配置（t_sys_config）：系统名称、最大答题时长、允许提交次数等参数可在后台修改。", { indent: 480 }),
                createPara("题目类型可管理：支持单选题、多选题、判断题、填空题、简答题、编程题等多种题型。", { indent: 480 }),
                createPara("【负责人】周志文、余飞杨", { indent: 480 }),
                new Paragraph({ children: [] }),
                createSubSectionTitle("5.3  其他业务功能"),
                createRedPara("同上。"),
                createPara("【认证授权】", { indent: 480 }),
                createPara("用户登录（JWT Token）：支持账号密码登录，登录成功后返回AccessToken和RefreshToken。AccessToken有效期2小时，RefreshToken有效期7天。", { indent: 480 }),
                createPara("退出登录：清除Token记录，记录退出日志。", { indent: 480 }),
                createPara("Token自动刷新：当AccessToken即将过期时，自动使用RefreshToken刷新，无需用户重新登录。", { indent: 480 }),
                createPara("用户信息获取：根据Token解析用户信息，支持获取当前用户角色、权限、菜单等。", { indent: 480 }),
                createPara("【班级管理】", { indent: 480 }),
                createPara("班级启用/禁用：可设置班级状态，禁用后该班级学生无法登录。", { indent: 480 }),
                createPara("IP限制设置：可绑定班级允许访问的IP段，防止账号外泄导致的安全问题。", { indent: 480 }),
                createPara("【负责人】周志文、杨宇润", { indent: 480 }),
                new Paragraph({ children: [new PageBreak()] }),
                // 6 改进建议
                createSectionTitle("6  改进建议"),
                createSubSectionTitle("6.1  实现改进建议"),
                createRedPara("先给出一张完整的网页导航图，然后再给出关键页面截图，并给出相关说明。"),
                createPara("1. 【代码生成】引入MyBatis-Plus Generator自动生成基础CRUD代码，减少样板代码。Generator可根据数据库表结构自动生成Entity、Mapper、Service、Controller代码，开发效率可提升约30%。", { indent: 480 }),
                createPara("2. 【接口文档】引入SpringDoc OpenAPI 3自动生成API文档 Swagger UI，支持在线测试接口。便于前后端对接，减少沟通成本。", { indent: 480 }),
                createPara("3. 【参数校验】增强参数校验，使用@Validated和自定义校验注解，实现请求参数统一校验。返回友好的错误提示信息。", { indent: 480 }),
                createPara("4. 【缓存优化】针对热点数据（如班级列表、学生列表、题库等）引入Redis二级缓存。结合缓存过期策略，在保证数据一致性的同时提升响应速度。", { indent: 480 }),
                createPara("5. 【异步处理】将邮件通知、成绩推送、数据统计等非核心功能异步化。使用消息队列解耦，提高系统吞吐量。", { indent: 480 }),
                createPara("【负责人】周志文", { indent: 480 }),
                new Paragraph({ children: [] }),
                createSubSectionTitle("6.2  运维改进建议"),
                createRedPara("同上。"),
                createPara("1. 【监控告警】引入Spring Boot Actuator + Prometheus监控指标，包括接口响应时间、CPU使用率、内存使用率、数据库连接数等。设置告警阈值，及时发现和处理问题。", { indent: 480 }),
                createPara("2. 【日志规范】统一日志格式，引入ELK（ElasticSearch+Logstash+Kibana）日志收集分析平台。实现日志实时搜索、统计分析、告警功能。", { indent: 480 }),
                createPara("3. 【配置中心】引入Apollo或Nacos实现配置中心化管理。配置修改实时生效，支持灰度发布和回滚。", { indent: 480 }),
                createPara("4. 【容器编排】完善Kubernetes部署配置，支持弹性伸缩。根据负载自动调整实例数量，保证系统稳定性。", { indent: 480 }),
                createPara("【负责人】余飞杨", { indent: 480 }),
                new Paragraph({ children: [] }),
                createSubSectionTitle("6.3  测试建议"),
                createRedPara("同上。"),
                createPara("1. 【单元测试】为Service层编写单元测试，使用JUnit 5 + Mockito模拟依赖对象。覆盖率目标：核心业务逻辑覆盖率80%以上。", { indent: 480 }),
                createPara("2. 【集成测试】编写Controller层集成测试，验证接口功能。使用Spring Test模块加载真实Spring上下文。", { indent: 480 }),
                createPara("3. 【前端测试】引入Vitest进行前端单元测试，组件覆盖率报告。引入Playwright进行E2E测试，覆盖核心用户操作流程。", { indent: 480 }),
                createPara("4. 【性能测试】使用JMeter进行接口性能测试，验证并发能力。目标：支持500并发用户同时在线，接口响应时间<500ms。", { indent: 480 }),
                createPara("5. 【安全测试】进行SQL注入、XSS、CSRF等安全测试。使用自动化安全扫描工具，定期进行漏洞扫描。", { indent: 480 }),
                createPara("【负责人】杨宇润、于峰", { indent: 480 }),
            ]
        }]
    });
    return doc;
}

// ============ 周志文文档 ============
function createZhouDocument() {
    const doc = new Document({
        sections: [{
            properties: { page: { size: { width: PAGE_WIDTH, height: PAGE_HEIGHT }, margin: { top: MARGIN_TOP, right: MARGIN_RIGHT, bottom: MARGIN_BOTTOM, left: MARGIN_LEFT } } },
            children: [
                ...createCoverPage("周志文（组长）"),
                createSectionTitle("1  系统功能"),
                createSubSectionTitle("1.1  系统功能说明"),
                createRedPara("给出完整的系统功能说明。"),
                createPara("本项目旨在将原有的Spring MVC + JSP + jQuery实验教学管理系统（Labex）重构为现代化的Vue 3 + Spring Boot 3前后端分离架构。系统需要支持教师和学生的全流程实验教学管理，包括班级管理、学生管理、实验管理、成绩管理等核心功能。重构过程中需完全保留原有数据库结构，确保数据兼容性。", { indent: 480 }),
                createPara("原有系统采用Spring MVC 4 + JSP视图技术，前端使用jQuery进行DOM操作。该架构在当时的教学场景下能够满足基本需求，但随着业务规模扩大和用户体验要求提升，原有架构逐渐显现出局限性。", { indent: 480 }),
                createSubSectionTitle("1.2  系统实现情况"),
                createRedPara("先以文字形式说明系统的具体实现情况。"),
                createPara("系统采用Vue 3 + Spring Boot 3前后端分离架构，后端使用Spring Security + JWT实现认证授权，前端使用Pinia进行状态管理。", { indent: 480 }),
                createPara("【负责模块】系统架构设计、后端核心模块、安全认证模块", { indent: 480 }),
                createPara("系统架构设计：完成前后端分离架构设计，定义清晰的RESTful接口规范。", { indent: 480 }),
                createPara("后端核心模块：完成Spring Boot 3后端框架搭建、配置类编写、异常处理、全局日志。", { indent: 480 }),
                createPara("安全认证模块：完成JWT Token生成验证、权限控制、角色管理、密码加密（BCrypt）。", { indent: 480 }),
                new Paragraph({ children: [new PageBreak()] }),
                createSectionTitle("2  实施方案"),
                createSubSectionTitle("2.1  技术路线选择"),
                createRedPara("先以文字说明系统中原计划采用的框架、技术。"),
                createPara("后端原计划使用Spring MVC 4，实际使用Spring Boot 3进行重构。", { indent: 480 }),
                createPara("前端原计划使用jQuery + JSP，实际使用Vue 3 + Vite完全重构。", { indent: 480 }),
                createPara("安全框架原计划使用Shiro，实际使用Spring Security + JWT。", { indent: 480 }),
                createSubSectionTitle("2.2  技术路线选择及存在差异原因"),
                createRedPara("说明技术路线选择的具体差异。"),
                createPara("Spring Boot 3：更简化的配置、自动装配机制，与Spring Security 6.x兼容性更好，支持JDK 17+新特性。重构后代码量减少约40%。", { indent: 480 }),
                createPara("Vue 3：组件化开发模式、响应式数据绑定、虚拟DOM技术，大幅提升开发效率和代码可维护性。前端代码可以按组件独立开发和测试。", { indent: 480 }),
                createPara("JWT Token：支持无状态认证，便于分布式部署和水平扩展。Token可设置过期时间，支持刷新机制，安全性更高。", { indent: 480 }),
                new Paragraph({ children: [new PageBreak()] }),
                createSectionTitle("4  业务系统结构及代码模式"),
                createSubSectionTitle("4.1  业务系统结构"),
                createPara("整体架构从前后端耦合（JSP）重构为完全分离的前后端分离架构。前端专注于页面展示和用户交互，后端专注于业务逻辑和数据处理。", { indent: 480 }),
                createPara("后端模块从Service-Action-Model改为Controller-Service-Mapper标准三层架构，职责更清晰，代码更易维护。", { indent: 480 }),
                createSubSectionTitle("4.2  代码模式"),
                createPara("后端采用标准三层架构（Controller-Service-Mapper），使用MyBatis-Plus实现数据访问自动化。Controller层负责接收请求和返回响应，Service层处理业务逻辑，Mapper层负责数据访问。", { indent: 480 }),
                createPara("前端采用Vue 3 Composition API进行组件化开发，每个页面拆分为独立的组件。使用Pinia进行状态管理，用户登录信息、菜单权限等全局状态集中管理。", { indent: 480 }),
                new Paragraph({ children: [new PageBreak()] }),
                createSectionTitle("6  改进建议"),
                createSubSectionTitle("6.1  实现改进建议"),
                createRedPara("先给出一张完整的网页导航图。"),
                createPara("1. 【代码生成】引入MyBatis-Plus Generator自动生成基础CRUD代码，减少样板代码。Generator可根据数据库表结构自动生成Entity、Mapper、Service、Controller代码，开发效率可提升约30%。", { indent: 480 }),
                createPara("2. 【接口文档】引入SpringDoc OpenAPI 3自动生成API文档 Swagger UI，支持在线测试接口。便于前后端对接，减少沟通成本。", { indent: 480 }),
                createPara("3. 【参数校验】增强参数校验，使用@Validated和自定义校验注解，实现请求参数统一校验。", { indent: 480 }),
                createPara("4. 【缓存优化】针对热点数据引入Redis二级缓存，结合缓存过期策略提升响应速度。", { indent: 480 }),
                createPara("5. 【异步处理】将邮件通知、成绩推送等非核心功能异步化，使用消息队列解耦。", { indent: 480 }),
                createPara("【负责人】周志文", { indent: 480 }),
            ]
        }]
    });
    return doc;
}

// ============ 余飞杨文档 ============
function createYuFeiDocument() {
    const doc = new Document({
        sections: [{
            properties: { page: { size: { width: PAGE_WIDTH, height: PAGE_HEIGHT }, margin: { top: MARGIN_TOP, right: MARGIN_RIGHT, bottom: MARGIN_BOTTOM, left: MARGIN_LEFT } } },
            children: [
                ...createCoverPage("余飞杨"),
                createSectionTitle("3  数据库"),
                createSubSectionTitle("3.1  数据表"),
                createRedPara("以表格的形式说明现有数据库与原先数据库之间的差异。"),
                createPara("系统共保留和优化了以下核心数据表。数据库设计遵循以下原则：保留原有表结构确保数据兼容、适度冗余减少关联查询、新增必要索引提升查询性能。", { indent: 480 }),
                new Table({
                    width: { size: CONTENT_WIDTH, type: WidthType.DXA },
                    columnWidths: [500, 1500, 1500, 1500, 1318, 1000],
                    rows: [
                        new TableRow({ children: [createHeaderCell("序号", 500), createHeaderCell("数据表名", 1500), createHeaderCell("说明", 1500), createHeaderCell("原数据库", 1500), createHeaderCell("新数据库", 1318), createHeaderCell("备注", 1000)] }),
                        new TableRow({ children: [createCell("1", 500), createContentCell("t_teacher", 1500), createContentCell("教师/管理员表", 1500), createCell("保留", 1500), createCell("保留", 1318), createCell("", 1000)] }),
                        new TableRow({ children: [createCell("2", 500), createContentCell("t_student", 1500), createContentCell("学生表", 1500), createCell("保留", 1500), createCell("保留", 1318), createCell("", 1000)] }),
                        new TableRow({ children: [createCell("3", 500), createContentCell("t_clazz", 1500), createContentCell("班级表", 1500), createCell("保留", 1500), createCell("增强", 1318), createCell("新增teacher_id", 1000)] }),
                        new TableRow({ children: [createCell("4", 500), createContentCell("t_experiment", 1500), createContentCell("实验表", 1500), createCell("保留", 1500), createCell("保留", 1318), createCell("", 1000)] }),
                        new TableRow({ children: [createCell("5", 500), createContentCell("t_experiment_item", 1500), createContentCell("实验题目表", 1500), createCell("保留", 1500), createCell("保留", 1318), createCell("", 1000)] }),
                        new TableRow({ children: [createCell("6", 500), createContentCell("t_student_item", 1500), createContentCell("学生答题表", 1500), createCell("保留", 1500), createCell("保留", 1318), createCell("", 1000)] }),
                        new TableRow({ children: [createCell("7", 500), createContentCell("t_score", 1500), createContentCell("成绩表", 1500), createCell("保留", 1500), createCell("保留", 1318), createCell("", 1000)] }),
                        new TableRow({ children: [createCell("8", 500), createContentCell("t_lecture", 1500), createContentCell("讲义表", 1500), createCell("保留", 1500), createCell("保留", 1318), createCell("", 1000)] }),
                        new TableRow({ children: [createCell("9", 500), createContentCell("t_question", 1500), createContentCell("题库表", 1500), createCell("新增", 1500), createCell("保留", 1318), createCell("支持题库管理", 1000)] }),
                        new TableRow({ children: [createCell("10", 500), createContentCell("t_exam", 1500), createContentCell("考试表", 1500), createCell("新增", 1500), createCell("保留", 1318), createCell("支持在线考试", 1000)] }),
                        new TableRow({ children: [createCell("11", 500), createContentCell("t_paper", 1500), createContentCell("试卷表", 1500), createCell("新增", 1500), createCell("保留", 1318), createCell("", 1000)] }),
                    ]
                }),
                new Paragraph({ children: [] }),
                createSubSectionTitle("3.2  视图及存储过程"),
                createRedPara("以表格的形式说明现有数据库与原先数据库之间的差异。"),
                createPara("原数据库和现数据库均未使用视图和存储过程，保持一致。数据库主要优化体现在索引层面。", { indent: 480 }),
                new Table({
                    width: { size: CONTENT_WIDTH, type: WidthType.DXA },
                    columnWidths: [500, 1800, 1800, 1800, 1418],
                    rows: [
                        new TableRow({ children: [createHeaderCell("序号", 500), createHeaderCell("视图/存储过程", 1800), createHeaderCell("说明", 1800), createHeaderCell("原数据库", 1800), createHeaderCell("新数据库", 1418)] }),
                        new TableRow({ children: [createCell("1", 500), createContentCell("视图", 1800), createContentCell("未使用视图", 1800), createCell("未使用", 1800), createCell("未使用", 1418)] }),
                        new TableRow({ children: [createCell("2", 500), createContentCell("存储过程", 1800), createContentCell("未使用存储过程", 1800), createCell("未使用", 1800), createCell("未使用", 1418)] }),
                        new TableRow({ children: [createCell("3", 500), createContentCell("索引优化", 1800), createContentCell("新增12个索引优化查询性能", 1800), createCell("部分索引", 1800), createCell("新增12个索引", 1418)] }),
                    ]
                }),
                new Paragraph({ children: [] }),
                createSubSectionTitle("3.3  数据库差异及存在差异原因"),
                createRedPara("说明数据库的具体差异，并分析产生差异的原因。"),
                createPara("1. t_clazz表新增teacher_id字段：关联所属教师，便于查询和管理班级。原有设计需要通过多表关联查询才能获取班级教师信息，新增字段后可直接查询，提升查询效率约40%。", { indent: 480 }),
                createPara("2. 新增表支持考试功能：新建t_exam（考试表）、t_paper（试卷表）、t_paper_question（试卷题目关联表）、t_question_test_case（编程题测试用例表）等支持在线考试和自动评分功能。", { indent: 480 }),
                createPara("3. 索引优化：在关键查询字段上新增12个索引，包括t_student(clazz_no, state)、t_experiment(state)、t_experiment_item(experiment_id)、t_score(student_id, experiment_id)等，查询性能提升约50%。", { indent: 480 }),
                createPara("4. 密码加密升级：密码存储从MD5升级为BCrypt加密，BCrypt内置盐值，安全性更高，有效防止彩虹表攻击。", { indent: 480 }),
                new Paragraph({ children: [new PageBreak()] }),
                createSectionTitle("6  改进建议"),
                createSubSectionTitle("6.2  运维改进建议"),
                createRedPara("同上。"),
                createPara("1. 【监控告警】引入Spring Boot Actuator + Prometheus监控指标，包括接口响应时间、CPU使用率、内存使用率、数据库连接数等。设置告警阈值，及时发现和处理问题。", { indent: 480 }),
                createPara("2. 【日志规范】统一日志格式，引入ELK（ElasticSearch+Logstash+Kibana）日志收集分析平台。实现日志实时搜索、统计分析、告警功能。", { indent: 480 }),
                createPara("3. 【配置中心】引入Apollo或Nacos实现配置中心化管理。配置修改实时生效，支持灰度发布和回滚。", { indent: 480 }),
                createPara("4. 【容器编排】完善Kubernetes部署配置，支持弹性伸缩。根据负载自动调整实例数量，保证系统稳定性。", { indent: 480 }),
                createPara("【负责人】余飞杨", { indent: 480 }),
            ]
        }]
    });
    return doc;
}

// ============ 杨宇润文档 ============
function createYangDocument() {
    const doc = new Document({
        sections: [{
            properties: { page: { size: { width: PAGE_WIDTH, height: PAGE_HEIGHT }, margin: { top: MARGIN_TOP, right: MARGIN_RIGHT, bottom: MARGIN_BOTTOM, left: MARGIN_LEFT } } },
            children: [
                ...createCoverPage("杨宇润"),
                createSectionTitle("5  详细业务功能描述"),
                createSubSectionTitle("5.1  实现业务功能"),
                createRedPara("给出完整的业务功能描述。"),
                createPara("【学生模块功能】（杨宇润负责实现）", { indent: 480 }),
                createPara("1. 实验列表：查看所有已分配实验、实验状态（未开始/进行中/已完成）、截止时间提醒。进入答题后自动开始计时。", { indent: 480 }),
                createPara("2. 实验答题：左侧题目导航、在线答题、答案自动保存（防抖500ms）、本地localStorage备份、提交答卷。离开页面时自动保存进度，防止意外丢失。", { indent: 480 }),
                createPara("3. 讲义学习：浏览和下载讲义、收藏常用讲义、记录学习进度。", { indent: 480 }),
                createPara("4. 个人中心：修改密码、查看成绩历史、查看答题记录。", { indent: 480 }),
                createPara("【前端实现】学生端使用Vue 3 + Element Plus实现，包含：", { indent: 480 }),
                createPara("Experiment.vue（实验列表）：展示实验列表，支持按状态筛选，显示实验进度和截止时间。", { indent: 480 }),
                createPara("ExperimentDetail.vue（实验答题页）：左侧题目导航、右侧答题区、底部提交按钮。实现左侧题目导航实时高亮、答案自动保存（防抖500ms）、本地localStorage备份、进度条显示等功能。", { indent: 480 }),
                createPara("Lecture.vue（讲义列表）：讲义分类展示、在线预览、文件下载。", { indent: 480 }),
                createPara("Profile.vue（个人中心）：修改密码表单、成绩历史图表、答题记录列表。", { indent: 480 }),
                new Paragraph({ children: [] }),
                createSubSectionTitle("5.2  运维业务功能"),
                createRedPara("同上。"),
                createPara("【系统监控】", { indent: 480 }),
                createPara("操作日志记录（t_sys_log）：记录用户登录、关键操作等日志，包含操作人、操作时间、操作类型、操作详情、IP地址等信息，便于安全审计和问题排查。", { indent: 480 }),
                createPara("学生日志记录（t_student_log）：记录学生答题行为，包括开始答题、保存答案、提交答卷等操作时间节点。", { indent: 480 }),
                createPara("答题日志跟踪（t_student_item_log）：详细记录学生每次答题的内容和时间，支持答案回溯。", { indent: 480 }),
                createPara("【数据管理】", { indent: 480 }),
                createPara("批量导入/导出（CSV格式）：支持学生信息、题库等数据的批量导入，导出功能便于数据统计和归档。", { indent: 480 }),
                createPara("Excel成绩导出：自定义导出字段，包括学号、姓名、班级、实验名称、成绩等。", { indent: 480 }),
                createPara("【前端实现】使用Vue 3 Composition API实现日志展示和数据导出功能。", { indent: 480 }),
                new Paragraph({ children: [] }),
                createSubSectionTitle("5.3  其他业务功能"),
                createRedPara("同上。"),
                createPara("【认证授权】", { indent: 480 }),
                createPara("用户登录（JWT Token）：支持账号密码登录，登录成功后返回AccessToken和RefreshToken。", { indent: 480 }),
                createPara("【前端实现】Login.vue实现登录页（浅绿渐变背景、动画效果）。", { indent: 480 }),
                new Paragraph({ children: [new PageBreak()] }),
                createSectionTitle("6  改进建议"),
                createSubSectionTitle("6.3  测试建议"),
                createRedPara("同上。"),
                createPara("1. 【单元测试】为Service层编写单元测试，使用JUnit 5 + Mockito模拟依赖对象。覆盖率目标：核心业务逻辑覆盖率80%以上。", { indent: 480 }),
                createPara("2. 【集成测试】编写Controller层集成测试，验证接口功能。使用Spring Test模块加载真实Spring上下文。", { indent: 480 }),
                createPara("3. 【前端测试】引入Vitest进行前端单元测试，组件覆盖率报告。引入Playwright进行E2E测试，覆盖核心用户操作流程。", { indent: 480 }),
                createPara("4. 【性能测试】使用JMeter进行接口性能测试，验证并发能力。目标：支持500并发用户同时在线，接口响应时间<500ms。", { indent: 480 }),
                createPara("5. 【安全测试】进行SQL注入、XSS、CSRF等安全测试。使用自动化安全扫描工具，定期进行漏洞扫描。", { indent: 480 }),
                createPara("【负责人】杨宇润", { indent: 480 }),
            ]
        }]
    });
    return doc;
}

// ============ 于峰文档 ============
function createYuFengDocument() {
    const doc = new Document({
        sections: [{
            properties: { page: { size: { width: PAGE_WIDTH, height: PAGE_HEIGHT }, margin: { top: MARGIN_TOP, right: MARGIN_RIGHT, bottom: MARGIN_BOTTOM, left: MARGIN_LEFT } } },
            children: [
                ...createCoverPage("于峰"),
                createSectionTitle("5  详细业务功能描述"),
                createSubSectionTitle("5.1  实现业务功能"),
                createRedPara("给出完整的业务功能描述。"),
                createPara("【教师模块功能】（于峰负责实现）", { indent: 480 }),
                createPara("1. 班级管理：增删改查班级、启用/禁用、IP限制设置。班主任可管理本班学生信息，设置班级开放时间，限制学生访问IP段。", { indent: 480 }),
                createPara("2. 学生管理：学生CRUD、批量导入（CSV格式）、重置密码、重置IP绑定。支持批量导出学生列表为Excel，方便教师进行数据统计。", { indent: 480 }),
                createPara("3. 实验管理：创建/编辑实验、题目管理、标准答案设置、实验时间限制。可设置实验总分、及格线、允许答题次数等参数。", { indent: 480 }),
                createPara("4. 讲义管理：文件上传（支持PDF、Word、PPT等格式）、讲义列表浏览、在线预览。支持按课程分类，方便学生快速查找。", { indent: 480 }),
                createPara("5. 成绩管理：查看学生答题详情、在线评分、批量评分、成绩导出Excel。提供成绩统计图表，直观展示班级整体情况。", { indent: 480 }),
                createPara("【后端实现】教师模块使用Spring Boot 3 + MyBatis-Plus实现，包含：", { indent: 480 }),
                createPara("ClazzController（班级管理）：班级CRUD、启用禁用、IP限制设置。", { indent: 480 }),
                createPara("StudentController（学生管理）：学生CRUD、批量导入、重置密码、IP绑定。", { indent: 480 }),
                createPara("ExperimentController（实验管理）：实验CRUD、题目管理、标准答案设置。", { indent: 480 }),
                createPara("LectureController（讲义管理）：文件上传、讲义列表、在线预览接口。", { indent: 480 }),
                createPara("ScoreController（成绩管理）：成绩查询、在线评分、批量评分、Excel导出。", { indent: 480 }),
                createPara("HomeworkController（作业管理）：作业布置、提交情况查看。", { indent: 480 }),
                new Paragraph({ children: [] }),
                createSubSectionTitle("5.3  其他业务功能"),
                createRedPara("同上。"),
                createPara("【班级管理】", { indent: 480 }),
                createPara("班级启用/禁用：可设置班级状态，禁用后该班级学生无法登录。", { indent: 480 }),
                createPara("IP限制设置：可绑定班级允许访问的IP段，防止账号外泄导致的安全问题。", { indent: 480 }),
                createPara("【学生管理】", { indent: 480 }),
                createPara("学生账号启用/禁用：可设置学生账号状态，禁用后无法登录系统。", { indent: 480 }),
                createPara("IP地址绑定：可将学生账号绑定到指定IP地址，防止账号被盗用。", { indent: 480 }),
                createPara("密码错误次数限制：连续5次密码错误后锁定账号30分钟，防止暴力破解。", { indent: 480 }),
                createPara("【考试功能】", { indent: 480 }),
                createPara("新增Exam模块，支持在线考试功能（ExamController、ExamService）。包含考试创建、试卷组装、考试发布、成绩统计等功能。", { indent: 480 }),
                createPara("【评分功能】", { indent: 480 }),
                createPara("新增QuestionTestCase模块，支持编程题自动评分（QuestionTestCaseService）。可设置测试用例，自动对比学生输出与期望输出。", { indent: 480 }),
                new Paragraph({ children: [new PageBreak()] }),
                createSectionTitle("6  改进建议"),
                createSubSectionTitle("6.3  测试建议"),
                createRedPara("同上。"),
                createPara("1. 【成绩模块测试】重点测试评分、批量评分、成绩导出功能。验证成绩计算逻辑正确性，包括总分、平均分、排名等。", { indent: 480 }),
                createPara("2. 【考试模块测试】测试考试创建、答题、提交、评分完整流程。验证考试时间控制、答案保存、成绩计算等环节。", { indent: 480 }),
                createPara("3. 【并发测试】验证多学生同时答题时的数据一致性。使用JMeter模拟500并发请求，验证系统稳定性。", { indent: 480 }),
                createPara("【负责人】于峰", { indent: 480 }),
            ]
        }]
    });
    return doc;
}

// 生成所有文档
async function generateAllDocs() {
    const docsDir = 'D:/workfordasan/docs';

    console.log('正在生成总项目文档...');
    const masterBuffer = await Packer.toBuffer(createMasterDocument());
    fs.writeFileSync(`${docsDir}/教学一体化平台升级改造中期自查报告_总项目文档_new.docx`, masterBuffer);
    console.log('✓ 总项目文档已生成');

    console.log('正在生成周志文文档...');
    const zhouBuffer = await Packer.toBuffer(createZhouDocument());
    fs.writeFileSync(`${docsDir}/周志文_中期自查报告_new.docx`, zhouBuffer);
    console.log('✓ 周志文文档已生成');

    console.log('正在生成余飞杨文档...');
    const yuFeiBuffer = await Packer.toBuffer(createYuFeiDocument());
    fs.writeFileSync(`${docsDir}/余飞杨_中期自查报告_new.docx`, yuFeiBuffer);
    console.log('✓ 余飞杨文档已生成');

    console.log('正在生成杨宇润文档...');
    const yangBuffer = await Packer.toBuffer(createYangDocument());
    fs.writeFileSync(`${docsDir}/杨宇润_中期自查报告_new.docx`, yangBuffer);
    console.log('✓ 杨宇润文档已生成');

    console.log('正在生成于峰文档...');
    const yuFengBuffer = await Packer.toBuffer(createYuFengDocument());
    fs.writeFileSync(`${docsDir}/于峰_中期自查报告_new.docx`, yuFengBuffer);
    console.log('✓ 于峰文档已生成');

    console.log('\n========== 所有文档生成完成 ==========');
}

generateAllDocs().catch(console.error);