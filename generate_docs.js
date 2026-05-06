// -*- coding: utf-8 -*-
// 生成教学一体化平台升级改造中期自查报告
const { Document, Packer, Paragraph, TextRun, Table, TableRow, TableCell,
        Header, Footer, AlignmentType, LevelFormat, HeadingLevel,
        BorderStyle, WidthType, ShadingType, VerticalAlign, PageNumber,
        PageBreak, TableOfContents, UnderlineType } = require('docx');
const fs = require('fs');

// A4纸尺寸 (DXA)
const PAGE_WIDTH = 11906;
const PAGE_HEIGHT = 16838;
const MARGIN_LEFT = 1800;
const MARGIN_RIGHT = 1800;
const MARGIN_TOP = 1440;
const MARGIN_BOTTOM = 1440;
const CONTENT_WIDTH = PAGE_WIDTH - MARGIN_LEFT - MARGIN_RIGHT; // 8318

// 边框样式
const border = { style: BorderStyle.SINGLE, size: 1, color: "000000" };
const borders = { top: border, bottom: border, left: border, right: border };

// 创建表格单元格
function createCell(text, width, options = {}) {
    const { bold = false, color = "000000", fontSize = 21, shading = null, align = AlignmentType.CENTER } = options;
    return new TableCell({
        borders,
        width: { size: width, type: WidthType.DXA },
        shading: shading ? { fill: shading, type: ShadingType.CLEAR } : undefined,
        margins: { top: 80, bottom: 80, left: 120, right: 120 },
        verticalAlign: VerticalAlign.CENTER,
        children: [new Paragraph({
            alignment: align,
            children: [new TextRun({
                text,
                bold,
                color,
                size: fontSize,
                font: "宋体"
            })]
        })]
    });
}

// 创建带背景色的表头单元格
function createHeaderCell(text, width, bgColor = "D9EAD3") {
    return createCell(text, width, { bold: true, color: "000000", shading: bgColor });
}

// 创建普通文本段落
function createTextPara(text, options = {}) {
    const { fontSize = 21, bold = false, indent = 0, align = AlignmentType.LEFT, spacing = 400 } = options;
    return new Paragraph({
        alignment: align,
        spacing: { line: spacing, lineRule: "auto" },
        indent: { firstLine: indent },
        children: [new TextRun({
            text,
            size: fontSize,
            bold,
            font: "宋体"
        })]
    });
}

// 创建标题段落
function createHeadingPara(text, level) {
    const configs = {
        1: { fontSize: 28, bold: true, font: "黑体", spaceBefore: 400, spaceAfter: 200 },
        2: { fontSize: 24, bold: true, font: "黑体", spaceBefore: 300, spaceAfter: 150 },
        3: { fontSize: 22, bold: true, font: "楷体_GB2312", spaceBefore: 200, spaceAfter: 100 }
    };
    const config = configs[level] || configs[1];
    return new Paragraph({
        spacing: { before: config.spaceBefore, after: config.spaceAfter },
        children: [new TextRun({
            text,
            size: config.fontSize,
            bold: config.bold,
            font: config.font
        })]
    });
}

// 创建项目信息表
function createInfoTable(data) {
    const colWidths = [1500, 1500, 1500, 1500, 2000, 1318]; // 总计9338
    const headers = ['项目名称', '项目负责人', '专业', '班级', '成员', '填写日期'];

    const headerRow = new TableRow({
        children: headers.map((h, i) => createHeaderCell(h, colWidths[i]))
    });

    const dataRow = new TableRow({
        children: data.map((d, i) => createCell(d, colWidths[i]))
    });

    return new Table({
        width: { size: CONTENT_WIDTH, type: WidthType.DXA },
        columnWidths: colWidths,
        rows: [headerRow, dataRow]
    });
}

// 创建系统实现情况表
function createImplementationTable() {
    const colWidths = [600, 1500, 2800, 1200, 1200, 1018]; // 总计8318
    const headers = ['序号', '模块名称', '功能概述', '承诺人', '完成日期', '完成比例'];
    const data = [
        ['1', '系统架构设计', '完成前后端分离架构设计，定义清晰的接口规范', '周志文', '2026-04-15', '100%'],
        ['2', '后端核心模块', '完成Spring Boot 3后端框架搭建及核心业务逻辑实现', '周志文', '2026-04-16', '100%'],
        ['3', '教师管理模块', '完成班级管理、学生管理、实验管理等功能', '于峰', '2026-04-17', '100%'],
        ['4', '学生功能模块', '完成学生实验答题、讲义学习等功能', '杨宇润', '2026-04-18', '100%'],
        ['5', '成绩管理模块', '完成成绩录入、评分、导出等功能', '于峰', '2026-04-19', '100%'],
        ['6', '数据库优化', '完成数据库表结构优化及索引创建', '余飞杨', '2026-04-15', '100%'],
        ['7', '安全认证模块', '完成JWT认证、权限控制', '周志文', '2026-04-14', '100%'],
        ['8', '前端界面开发', '完成Vue 3前端页面及组件开发', '杨宇润', '2026-04-20', '100%'],
    ];

    const headerRow = new TableRow({
        children: headers.map((h, i) => createHeaderCell(h, colWidths[i]))
    });

    const dataRows = data.map(row =>
        new TableRow({
            children: row.map((d, i) => createCell(d, colWidths[i], { align: i === 2 ? AlignmentType.LEFT : AlignmentType.CENTER }))
        })
    );

    return new Table({
        width: { size: CONTENT_WIDTH, type: WidthType.DXA },
        columnWidths: colWidths,
        rows: [headerRow, ...dataRows]
    });
}

// 创建技术路线表
function createTechRouteTable() {
    const colWidths = [600, 1400, 1400, 1400, 1200, 2318]; // 总计8318
    const headers = ['序号', '项目', '计划', '实际', '差异'];
    const data = [
        ['1', '后端框架', 'Spring MVC 4', 'Spring Boot 3', '架构升级'],
        ['2', '前端框架', 'jQuery + JSP', 'Vue 3 + Vite', '完全重构'],
        ['3', '持久层', 'MyBatis', 'MyBatis-Plus', '自动CRUD更高效'],
        ['4', '安全框架', 'Shiro', 'Spring Security + JWT', '更完善的权限控制'],
        ['5', '数据库', 'MySQL 5.x', 'MySQL 8.x', '使用新版本特性'],
        ['6', '缓存', '无', 'Redis 7.x', '新增缓存支持'],
        ['7', '构建工具', 'Ant', 'Maven + Vite', '现代化构建流程'],
    ];

    const headerRow = new TableRow({
        children: headers.map((h, i) => createHeaderCell(h, colWidths[i]))
    });

    const dataRows = data.map(row =>
        new TableRow({
            children: row.map((d, i) => createCell(d, colWidths[i], { align: i <= 1 ? AlignmentType.CENTER : AlignmentType.LEFT }))
        })
    );

    return new Table({
        width: { size: CONTENT_WIDTH, type: WidthType.DXA },
        columnWidths: colWidths,
        rows: [headerRow, ...dataRows]
    });
}

// 创建数据表
function createDataTable() {
    const colWidths = [500, 1500, 1500, 1500, 1318, 1000]; // 总计7318
    const headers = ['序号', '数据表名', '说明', '原数据库', '新数据库', '备注'];
    const data = [
        ['1', 't_teacher', '教师/管理员表', '保留', '保留', ''],
        ['2', 't_student', '学生表', '保留', '保留', ''],
        ['3', 't_clazz', '班级表', '保留', '增强', '新增teacher_id'],
        ['4', 't_experiment', '实验表', '保留', '保留', ''],
        ['5', 't_experiment_item', '实验题目表', '保留', '保留', ''],
        ['6', 't_student_item', '学生答题表', '保留', '保留', ''],
        ['7', 't_score', '成绩表', '保留', '保留', ''],
        ['8', 't_lecture', '讲义表', '保留', '保留', ''],
        ['9', 't_question', '题库表', '新增', '保留', ''],
        ['10', 't_exam', '考试表', '新增', '保留', ''],
        ['11', 't_paper', '试卷表', '新增', '保留', ''],
        ['12', 't_paper_question', '试卷题目关联表', '新增', '保留', ''],
    ];

    const headerRow = new TableRow({
        children: headers.map((h, i) => createHeaderCell(h, colWidths[i]))
    });

    const dataRows = data.map(row =>
        new TableRow({
            children: row.map((d, i) => createCell(d, colWidths[i]))
        })
    );

    return new Table({
        width: { size: CONTENT_WIDTH, type: WidthType.DXA },
        columnWidths: colWidths,
        rows: [headerRow, ...dataRows]
    });
}

// 创建视图及存储过程表
function createViewTable() {
    const colWidths = [500, 1800, 1800, 1800, 1418]; // 总计7318
    const headers = ['序号', '视图/存储过程', '说明', '原数据库', '新数据库'];
    const data = [
        ['1', '无', '未使用视图', '未使用', '未使用'],
        ['2', '无', '未使用存储过程', '未使用', '未使用'],
        ['3', '索引优化', '新增12个索引优化查询性能', '部分索引', '新增12个索引'],
    ];

    const headerRow = new TableRow({
        children: headers.map((h, i) => createHeaderCell(h, colWidths[i]))
    });

    const dataRows = data.map(row =>
        new TableRow({
            children: row.map((d, i) => createCell(d, colWidths[i]))
        })
    );

    return new Table({
        width: { size: CONTENT_WIDTH, type: WidthType.DXA },
        columnWidths: colWidths,
        rows: [headerRow, ...dataRows]
    });
}

// 创建业务系统结构表
function createBusinessStructureTable() {
    const colWidths = [500, 1500, 1800, 2000, 2518]; // 总计8318
    const headers = ['序号', '业务系统结构', '说明', '原系统', '新系统'];
    const data = [
        ['1', '整体架构', '前后端分离', '前后端耦合（JSP）', '完全分离'],
        ['2', '后端模块', 'Controller-Service-Mapper', 'Service-Action-Model', '标准三层架构'],
        ['3', '前端模块', 'Vue组件化', '页面模板', '组件化+状态管理'],
        ['4', '认证方式', 'JWT Token无状态认证', 'Session认证', '无状态+RefreshToken'],
        ['5', '权限控制', 'RBAC角色权限', '简单角色判断', '完整RBAC模型'],
    ];

    const headerRow = new TableRow({
        children: headers.map((h, i) => createHeaderCell(h, colWidths[i]))
    });

    const dataRows = data.map(row =>
        new TableRow({
            children: row.map((d, i) => createCell(d, colWidths[i], { align: i <= 1 ? AlignmentType.CENTER : AlignmentType.LEFT }))
        })
    );

    return new Table({
        width: { size: CONTENT_WIDTH, type: WidthType.DXA },
        columnWidths: colWidths,
        rows: [headerRow, ...dataRows]
    });
}

// 创建代码模式表
function createCodePatternTable() {
    const colWidths = [500, 1500, 1800, 2000, 2518]; // 总计8318
    const headers = ['序号', '代码模式', '说明', '原系统', '新系统'];
    const data = [
        ['1', '后端分层', 'Controller-Service-Mapper三层', 'Action-Service-Dao多层', '标准三层更清晰'],
        ['2', 'ORM框架', 'MyBatis-Plus增强', 'MyBatis', '自动CRUD更高效'],
        ['3', '前端组件', 'Vue 3 Composition API', '无组件化', '完全组件化'],
        ['4', '状态管理', 'Pinia集中管理', '无', '集中式状态管理'],
        ['5', '构建模式', 'Vite快速构建', '无', '热更新+快速构建'],
        ['6', '代码规范', '阿里巴巴Java规范+ESLint', '无统一规范', '统一规范检查'],
    ];

    const headerRow = new TableRow({
        children: headers.map((h, i) => createHeaderCell(h, colWidths[i]))
    });

    const dataRows = data.map(row =>
        new TableRow({
            children: row.map((d, i) => createCell(d, colWidths[i], { align: i <= 1 ? AlignmentType.CENTER : AlignmentType.LEFT }))
        })
    );

    return new Table({
        width: { size: CONTENT_WIDTH, type: WidthType.DXA },
        columnWidths: colWidths,
        rows: [headerRow, ...dataRows]
    });
}

// 创建总项目文档
function createMasterDocument() {
    const doc = new Document({
        styles: {
            default: {
                document: {
                    run: { font: "宋体", size: 21 }
                }
            }
        },
        sections: [{
            properties: {
                page: {
                    size: { width: PAGE_WIDTH, height: PAGE_HEIGHT },
                    margin: { top: MARGIN_TOP, right: MARGIN_RIGHT, bottom: MARGIN_BOTTOM, left: MARGIN_LEFT }
                }
            },
            headers: {
                default: new Header({
                    children: [new Paragraph({
                        alignment: AlignmentType.CENTER,
                        children: [new TextRun({ text: "上海杉达学院", size: 18, font: "宋体" })]
                    })]
                })
            },
            footers: {
                default: new Footer({
                    children: [new Paragraph({
                        alignment: AlignmentType.CENTER,
                        children: [
                            new TextRun({ text: "第 ", size: 18, font: "宋体" }),
                            new TextRun({ children: [PageNumber.CURRENT], size: 18, font: "宋体" }),
                            new TextRun({ text: " 页", size: 18, font: "宋体" })
                        ]
                    })]
                })
            },
            children: [
                // 标题部分
                new Paragraph({
                    alignment: AlignmentType.CENTER,
                    spacing: { line: 380, lineRule: "atLeast" },
                    children: [new TextRun({ text: "上海杉达学院", size: 36, bold: true, font: "隶书", color: "FF0000" })]
                }),
                new Paragraph({
                    alignment: AlignmentType.CENTER,
                    spacing: { line: 400, lineRule: "exact" },
                    children: [new TextRun({ text: "教学一体化平台升级改造", size: 44, bold: true, font: "华文新魏" })]
                }),
                new Paragraph({
                    alignment: AlignmentType.CENTER,
                    spacing: { line: 400, lineRule: "exact" },
                    children: [new TextRun({ text: "中期自查报告", size: 44, bold: true, font: "黑体" })]
                }),
                new Paragraph({
                    alignment: AlignmentType.CENTER,
                    spacing: { line: 480, lineRule: "auto" },
                    children: [new TextRun({ text: "第一阶段", size: 52, bold: true, font: "黑体" })]
                }),
                new Paragraph({ children: [] }),

                // 项目信息表
                createInfoTable([
                    '教学一体化平台升级改造',
                    '周志文',
                    '计算机科学与技术',
                    '2023级1班',
                    '周志文、余飞杨、杨宇润、于峰',
                    '2026年4月21日'
                ]),

                new Paragraph({ children: [] }),

                // 目录
                new Paragraph({
                    alignment: AlignmentType.CENTER,
                    spacing: { before: 200, after: 200 },
                    children: [new TextRun({ text: "目  录", size: 30, bold: true, font: "黑体" })]
                }),

                new Paragraph({ children: [new PageBreak()] }),

                // 1 系统需求
                createHeadingPara('1  系统需求', 1),
                createHeadingPara('1.1  系统需求说明', 2),
                createTextPara('本项目旨在将原有的Spring MVC + JSP + jQuery实验教学管理系统（Labex）重构为现代化的Vue 3 + Spring Boot 3前后端分离架构。系统需要支持教师和学生的全流程实验教学管理，包括班级管理、学生管理、实验管理、成绩管理等核心功能。重构过程中需完全保留原有数据库结构，确保数据兼容性。'),

                createHeadingPara('1.2  系统实现情况', 2),
                createTextPara('系统各模块实现情况如下：'),
                createImplementationTable(),

                createHeadingPara('1.3  详细实现情况及存在差异', 2),
                createTextPara('【已完成】系统架构采用Vue 3 + Spring Boot 3前后端分离架构，后端使用Spring Security + JWT实现认证授权，前端使用Pinia进行状态管理。原有20+张数据库表结构完全保留，新增12个索引优化查询性能。'),
                createTextPara('【差异说明】原计划使用Shiro进行权限控制，实际采用Spring Security 6.x，因Spring Security与Spring Boot 3集成更紧密，安全性更高。原计划使用Session认证，实际采用JWT Token认证，支持无状态分布式部署。'),

                new Paragraph({ children: [new PageBreak()] }),

                // 2 实施方案
                createHeadingPara('2  实施方案', 1),
                createHeadingPara('2.1  技术路线选择', 2),
                createTechRouteTable(),

                createHeadingPara('2.2  技术路线选择及存在差异原因', 2),
                createTextPara('【差异原因说明】'),
                createTextPara('1. Spring Boot 3相比Spring MVC 4：提供更简化的配置、自动装配机制，与Spring Security 6.x兼容性更好，支持JDK 17+新特性。'),
                createTextPara('2. Vue 3相比jQuery：组件化开发模式、响应式数据绑定、虚拟DOM，大幅提升开发效率和代码可维护性。'),
                createTextPara('3. MyBatis-Plus：提供强大的自动CRUD功能，减少样板代码，内置分页插件无需手动处理。'),
                createTextPara('4. JWT Token：支持无状态认证，便于分布式部署和水平扩展。'),
                createTextPara('5. Redis缓存：提升热点数据访问性能，支持会话共享。'),

                new Paragraph({ children: [new PageBreak()] }),

                // 3 数据库
                createHeadingPara('3  数据库', 1),
                createHeadingPara('3.1  数据表', 2),
                createTextPara('系统共保留和优化了以下核心数据表：'),
                createDataTable(),

                createHeadingPara('3.2  视图及存储过程', 2),
                createViewTable(),

                createHeadingPara('3.3  数据库差异及存在差异原因', 2),
                createTextPara('【差异说明】数据库结构保持高度一致，主要差异在于：'),
                createTextPara('1. 新增字段：t_clazz表新增teacher_id字段，关联所属教师，便于查询和管理。'),
                createTextPara('2. 新增表：为支持新的考试功能，新增t_exam、t_paper、t_paper_question等表。'),
                createTextPara('3. 索引优化：在关键查询字段上新增12个索引，提升查询性能。'),
                createTextPara('4. 密码加密：密码存储从MD5升级为BCrypt加密，更安全。'),

                new Paragraph({ children: [new PageBreak()] }),

                // 4 业务系统结构及代码模式
                createHeadingPara('4  业务系统结构及代码模式', 1),
                createHeadingPara('4.1  业务系统结构', 2),
                createBusinessStructureTable(),

                createHeadingPara('4.2  代码模式', 2),
                createCodePatternTable(),

                new Paragraph({ children: [] }),
                createTextPara('【代码模式说明】本项目采用主流的代码模式：后端采用标准三层架构（Controller-Service-Mapper），使用MyBatis-Plus实现数据访问自动化；前端采用Vue 3 Composition API进行组件化开发，使用Pinia进行状态管理；使用统一的代码规范（阿里巴巴Java开发规范+ESLint）确保代码质量。'),

                new Paragraph({ children: [new PageBreak()] }),

                // 5 详细业务功能描述
                createHeadingPara('5  详细业务功能描述', 1),
                createHeadingPara('5.1  实现业务功能', 2),
                createTextPara('原有业务功能已在重构后系统中完整实现，主要包括：'),
                createTextPara('【核心功能】班级管理（增删改查、启用/禁用）、学生管理（CRUD、批量导入、重置密码）、实验管理（创建/编辑实验、题目管理）、讲义管理（文件上传、列表浏览）、成绩管理（查看答案、在线评分、批量评分、导出Excel）。'),
                createTextPara('【学生端】实验列表浏览、进入答题、题目导航、在线答题、自动保存、提交答卷、讲义学习（浏览和下载）、个人中心（修改密码、查看成绩）。'),
                createTextPara('【负责人】周志文、余飞杨、杨宇润、于峰'),

                createHeadingPara('5.2  运维业务功能', 2),
                createTextPara('运维相关业务功能已实现：'),
                createTextPara('【系统监控】操作日志记录（t_sys_log）、学生日志记录（t_student_log）、答题日志跟踪（t_student_item_log）。'),
                createTextPara('【数据管理】数据备份支持、批量导入/导出（CSV格式）、Excel成绩导出。'),
                createTextPara('【配置管理】系统参数可配置（t_sys_config）、题目类型可管理。'),
                createTextPara('【负责人】周志文、余飞杨'),

                createHeadingPara('5.3  其他业务功能', 2),
                createTextPara('其他已实现的业务功能：'),
                createTextPara('【认证授权】用户登录（JWT Token）、退出登录、Token自动刷新、用户信息获取。'),
                createTextPara('【班级管理】班级启用/禁用、IP限制设置。'),
                createTextPara('【学生管理】学生账号启用/禁用、IP地址绑定、密码错误次数限制。'),
                createTextPara('【负责人】周志文、杨宇润'),

                new Paragraph({ children: [new PageBreak()] }),

                // 6 改进建议
                createHeadingPara('6  改进建议', 1),
                createHeadingPara('6.1  实现改进建议', 2),
                createTextPara('基于当前实现情况，提出以下实现改进建议：'),
                createTextPara('1. 【代码生成】引入MyBatis-Plus Generator自动生成基础CRUD代码，减少样板代码。'),
                createTextPara('2. 【接口文档】引入SpringDoc OpenAPI 3自动生成API文档，便于前后端对接。'),
                createTextPara('3. 【参数校验】增强参数校验，使用@Validated和自定义校验注解。'),
                createTextPara('4. 【缓存优化】针对热点数据（如班级列表、学生列表）引入Redis二级缓存。'),
                createTextPara('5. 【异步处理】将邮件通知、成绩推送等非核心功能异步化。'),
                createTextPara('【负责人】周志文'),

                createHeadingPara('6.2  运维改进建议', 2),
                createTextPara('运维方面改进建议：'),
                createTextPara('1. 【监控告警】引入Spring Boot Actuator + Prometheus监控指标。'),
                createTextPara('2. 【日志规范】统一日志格式，引入ELK日志收集分析。'),
                createTextPara('3. 【配置中心】引入Apollo或Nacos实现配置中心化管理。'),
                createTextPara('4. 【容器编排】完善Kubernetes部署配置，支持弹性伸缩。'),
                createTextPara('【负责人】余飞杨'),

                createHeadingPara('6.3  测试建议', 2),
                createTextPara('测试方面改进建议：'),
                createTextPara('1. 【单元测试】为Service层编写单元测试，使用JUnit 5 + Mockito。'),
                createTextPara('2. 【集成测试】编写Controller层集成测试，验证接口功能。'),
                createTextPara('3. 【前端测试】引入Vitest进行前端单元测试，Playwright进行E2E测试。'),
                createTextPara('4. 【性能测试】使用JMeter进行接口性能测试，验证并发能力。'),
                createTextPara('5. 【安全测试】进行SQL注入、XSS等安全测试。'),
                createTextPara('【负责人】杨宇润、于峰'),
            ]
        }]
    });

    return doc;
}

// 创建周志文文档
function createZhouDocument() {
    const doc = new Document({
        styles: {
            default: {
                document: {
                    run: { font: "宋体", size: 21 }
                }
            }
        },
        sections: [{
            properties: {
                page: {
                    size: { width: PAGE_WIDTH, height: PAGE_HEIGHT },
                    margin: { top: MARGIN_TOP, right: MARGIN_RIGHT, bottom: MARGIN_BOTTOM, left: MARGIN_LEFT }
                }
            },
            children: [
                new Paragraph({
                    alignment: AlignmentType.CENTER,
                    spacing: { line: 380, lineRule: "atLeast" },
                    children: [new TextRun({ text: "上海杉达学院", size: 36, bold: true, font: "隶书", color: "FF0000" })]
                }),
                new Paragraph({
                    alignment: AlignmentType.CENTER,
                    children: [new TextRun({ text: "教学一体化平台升级改造中期自查报告", size: 44, bold: true, font: "黑体" })]
                }),
                new Paragraph({
                    alignment: AlignmentType.LEFT,
                    spacing: { line: 400 },
                    children: [
                        new TextRun({ text: "【负责人：周志文】（组长）", size: 24, bold: true, font: "宋体" })
                    ]
                }),
                new Paragraph({ children: [] }),

                createHeadingPara('1  系统需求', 1),
                createHeadingPara('1.1  系统需求说明', 2),
                createTextPara('本项目旨在将原有的Spring MVC + JSP + jQuery实验教学管理系统（Labex）重构为现代化的Vue 3 + Spring Boot 3前后端分离架构。系统需要支持教师和学生的全流程实验教学管理，包括班级管理、学生管理、实验管理、成绩管理等核心功能。重构过程中需完全保留原有数据库结构，确保数据兼容性。'),

                createHeadingPara('1.2  系统实现情况', 2),
                createTextPara('系统各模块实现情况如下：'),
                createImplementationTable(),

                createHeadingPara('1.3  详细实现情况及存在差异', 2),
                createTextPara('【已完成】系统架构采用Vue 3 + Spring Boot 3前后端分离架构，后端使用Spring Security + JWT实现认证授权，前端使用Pinia进行状态管理。原有20+张数据库表结构完全保留，新增12个索引优化查询性能。'),
                createTextPara('【差异说明】原计划使用Shiro进行权限控制，实际采用Spring Security 6.x，因Spring Security与Spring Boot 3集成更紧密，安全性更高。原计划使用Session认证，实际采用JWT Token认证，支持无状态分布式部署。'),

                new Paragraph({ children: [new PageBreak()] }),

                createHeadingPara('2  实施方案', 1),
                createHeadingPara('2.1  技术路线选择', 2),
                createTechRouteTable(),

                createHeadingPara('2.2  技术路线选择及存在差异原因', 2),
                createTextPara('【差异原因说明】'),
                createTextPara('1. Spring Boot 3相比Spring MVC 4：提供更简化的配置、自动装配机制，与Spring Security 6.x兼容性更好，支持JDK 17+新特性。'),
                createTextPara('2. Vue 3相比jQuery：组件化开发模式、响应式数据绑定、虚拟DOM，大幅提升开发效率和代码可维护性。'),
                createTextPara('3. JWT Token：支持无状态认证，便于分布式部署和水平扩展。'),

                new Paragraph({ children: [new PageBreak()] }),

                createHeadingPara('4  业务系统结构及代码模式', 1),
                createHeadingPara('4.1  业务系统结构', 2),
                createBusinessStructureTable(),

                createHeadingPara('4.2  代码模式', 2),
                createCodePatternTable(),

                new Paragraph({ children: [] }),
                createTextPara('【代码模式说明】后端采用标准三层架构（Controller-Service-Mapper），使用MyBatis-Plus实现数据访问自动化；前端采用Vue 3 Composition API进行组件化开发。'),

                new Paragraph({ children: [new PageBreak()] }),

                createHeadingPara('6  改进建议', 1),
                createHeadingPara('6.1  实现改进建议', 2),
                createTextPara('基于当前实现情况，提出以下实现改进建议：'),
                createTextPara('1. 【代码生成】引入MyBatis-Plus Generator自动生成基础CRUD代码。'),
                createTextPara('2. 【接口文档】引入SpringDoc OpenAPI 3自动生成API文档。'),
                createTextPara('3. 【参数校验】增强参数校验，使用@Validated和自定义校验注解。'),
                createTextPara('4. 【缓存优化】针对热点数据引入Redis二级缓存。'),
                createTextPara('5. 【异步处理】将邮件通知、成绩推送等非核心功能异步化。'),
                createTextPara('【负责人】周志文'),
            ]
        }]
    });

    return doc;
}

// 创建余飞杨文档
function createYuFeiDocument() {
    const doc = new Document({
        styles: {
            default: {
                document: {
                    run: { font: "宋体", size: 21 }
                }
            }
        },
        sections: [{
            properties: {
                page: {
                    size: { width: PAGE_WIDTH, height: PAGE_HEIGHT },
                    margin: { top: MARGIN_TOP, right: MARGIN_RIGHT, bottom: MARGIN_BOTTOM, left: MARGIN_LEFT }
                }
            },
            children: [
                new Paragraph({
                    alignment: AlignmentType.CENTER,
                    spacing: { line: 380, lineRule: "atLeast" },
                    children: [new TextRun({ text: "上海杉达学院", size: 36, bold: true, font: "隶书", color: "FF0000" })]
                }),
                new Paragraph({
                    alignment: AlignmentType.CENTER,
                    children: [new TextRun({ text: "教学一体化平台升级改造中期自查报告", size: 44, bold: true, font: "黑体" })]
                }),
                new Paragraph({
                    alignment: AlignmentType.LEFT,
                    spacing: { line: 400 },
                    children: [new TextRun({ text: "【负责人：余飞杨】", size: 24, bold: true, font: "宋体" })]
                }),
                new Paragraph({ children: [] }),

                createHeadingPara('3  数据库', 1),
                createHeadingPara('3.1  数据表', 2),
                createTextPara('系统共保留和优化了以下核心数据表：'),
                createDataTable(),

                createHeadingPara('3.2  视图及存储过程', 2),
                createViewTable(),

                createHeadingPara('3.3  数据库差异及存在差异原因', 2),
                createTextPara('【差异说明】数据库结构保持高度一致，主要差异在于：'),
                createTextPara('1. 新增字段：t_clazz表新增teacher_id字段，关联所属教师，便于查询和管理。'),
                createTextPara('2. 新增表：为支持新的考试功能，新增t_exam、t_paper、t_paper_question等表。'),
                createTextPara('3. 索引优化：在关键查询字段上新增12个索引，提升查询性能。'),
                createTextPara('4. 密码加密：密码存储从MD5升级为BCrypt加密，更安全。'),

                new Paragraph({ children: [new PageBreak()] }),

                createHeadingPara('6  改进建议', 1),
                createHeadingPara('6.2  运维改进建议', 2),
                createTextPara('运维方面改进建议：'),
                createTextPara('1. 【监控告警】引入Spring Boot Actuator + Prometheus监控指标。'),
                createTextPara('2. 【日志规范】统一日志格式，引入ELK日志收集分析。'),
                createTextPara('3. 【配置中心】引入Apollo或Nacos实现配置中心化管理。'),
                createTextPara('4. 【容器编排】完善Kubernetes部署配置，支持弹性伸缩。'),
                createTextPara('【负责人】余飞杨'),
            ]
        }]
    });

    return doc;
}

// 创建杨宇润文档
function createYangDocument() {
    const doc = new Document({
        styles: {
            default: {
                document: {
                    run: { font: "宋体", size: 21 }
                }
            }
        },
        sections: [{
            properties: {
                page: {
                    size: { width: PAGE_WIDTH, height: PAGE_HEIGHT },
                    margin: { top: MARGIN_TOP, right: MARGIN_RIGHT, bottom: MARGIN_BOTTOM, left: MARGIN_LEFT }
                }
            },
            children: [
                new Paragraph({
                    alignment: AlignmentType.CENTER,
                    spacing: { line: 380, lineRule: "atLeast" },
                    children: [new TextRun({ text: "上海杉达学院", size: 36, bold: true, font: "隶书", color: "FF0000" })]
                }),
                new Paragraph({
                    alignment: AlignmentType.CENTER,
                    children: [new TextRun({ text: "教学一体化平台升级改造中期自查报告", size: 44, bold: true, font: "黑体" })]
                }),
                new Paragraph({
                    alignment: AlignmentType.LEFT,
                    spacing: { line: 400 },
                    children: [new TextRun({ text: "【负责人：杨宇润】", size: 24, bold: true, font: "宋体" })]
                }),
                new Paragraph({ children: [] }),

                createHeadingPara('5  详细业务功能描述', 1),
                createHeadingPara('5.1  实现业务功能', 2),
                createTextPara('原有业务功能已在重构后系统中完整实现，主要包括：'),
                createTextPara('【学生模块功能】（杨宇润负责实现）'),
                createTextPara('1. 实验列表：查看可用实验、进入答题'),
                createTextPara('2. 实验答题：题目导航、在线答题、自动保存、提交答卷'),
                createTextPara('3. 讲义学习：浏览和下载讲义'),
                createTextPara('4. 个人中心：修改密码、查看成绩'),
                createTextPara('【前端实现】学生端使用Vue 3 + Element Plus实现，包含：Experiment.vue（实验列表）、ExperimentDetail.vue（实验答题页）、Lecture.vue（讲义列表）、Profile.vue（个人中心）。实现了左侧题目导航实时高亮、答案自动保存（防抖500ms）、本地localStorage备份、进度条显示等功能。'),

                createHeadingPara('5.2  运维业务功能', 2),
                createTextPara('运维相关业务功能已实现：'),
                createTextPara('【系统监控】操作日志记录（t_sys_log）、学生日志记录（t_student_log）、答题日志跟踪（t_student_item_log）。'),
                createTextPara('【数据管理】数据备份支持、批量导入/导出（CSV格式）、Excel成绩导出。'),
                createTextPara('【配置管理】系统参数可配置（t_sys_config）、题目类型可管理。'),
                createTextPara('【前端实现】使用Vue 3 Composition API实现日志展示和数据导出功能。'),

                createHeadingPara('5.3  其他业务功能', 2),
                createTextPara('【认证授权】用户登录（JWT Token）、退出登录、Token自动刷新、用户信息获取。'),
                createTextPara('【前端实现】Login.vue实现登录页（浅绿渐变背景、动画效果）。'),

                new Paragraph({ children: [new PageBreak()] }),

                createHeadingPara('6  改进建议', 1),
                createHeadingPara('6.3  测试建议', 2),
                createTextPara('测试方面改进建议：'),
                createTextPara('1. 【单元测试】为Service层编写单元测试，使用JUnit 5 + Mockito。'),
                createTextPara('2. 【集成测试】编写Controller层集成测试，验证接口功能。'),
                createTextPara('3. 【前端测试】引入Vitest进行前端单元测试，Playwright进行E2E测试。'),
                createTextPara('4. 【性能测试】使用JMeter进行接口性能测试，验证并发能力。'),
                createTextPara('5. 【安全测试】进行SQL注入、XSS等安全测试。'),
                createTextPara('【负责人】杨宇润'),
            ]
        }]
    });

    return doc;
}

// 创建于峰文档
function createYuFengDocument() {
    const doc = new Document({
        styles: {
            default: {
                document: {
                    run: { font: "宋体", size: 21 }
                }
            }
        },
        sections: [{
            properties: {
                page: {
                    size: { width: PAGE_WIDTH, height: PAGE_HEIGHT },
                    margin: { top: MARGIN_TOP, right: MARGIN_RIGHT, bottom: MARGIN_BOTTOM, left: MARGIN_LEFT }
                }
            },
            children: [
                new Paragraph({
                    alignment: AlignmentType.CENTER,
                    spacing: { line: 380, lineRule: "atLeast" },
                    children: [new TextRun({ text: "上海杉达学院", size: 36, bold: true, font: "隶书", color: "FF0000" })]
                }),
                new Paragraph({
                    alignment: AlignmentType.CENTER,
                    children: [new TextRun({ text: "教学一体化平台升级改造中期自查报告", size: 44, bold: true, font: "黑体" })]
                }),
                new Paragraph({
                    alignment: AlignmentType.LEFT,
                    spacing: { line: 400 },
                    children: [new TextRun({ text: "【负责人：于峰】", size: 24, bold: true, font: "宋体" })]
                }),
                new Paragraph({ children: [] }),

                createHeadingPara('5  详细业务功能描述', 1),
                createHeadingPara('5.1  实现业务功能', 2),
                createTextPara('原有业务功能已在重构后系统中完整实现，主要包括：'),
                createTextPara('【教师模块功能】（于峰负责实现）'),
                createTextPara('1. 班级管理：增删改查班级、启用/禁用、IP限制'),
                createTextPara('2. 学生管理：学生CRUD、批量导入（CSV）、重置密码/IP'),
                createTextPara('3. 实验管理：创建/编辑实验、题目管理、标准答案设置'),
                createTextPara('4. 讲义管理：文件上传、讲义列表'),
                createTextPara('5. 成绩管理：查看学生答案、在线评分、批量评分、导出Excel'),
                createTextPara('【后端实现】教师模块使用Spring Boot 3 + MyBatis-Plus实现，包含：ClazzController（班级管理）、StudentController（学生管理）、ExperimentController（实验管理）、LectureController（讲义管理）、ScoreController（成绩管理）、HomeworkController（作业管理）。'),

                createHeadingPara('5.3  其他业务功能', 2),
                createTextPara('【班级管理】班级启用/禁用、IP限制设置。'),
                createTextPara('【学生管理】学生账号启用/禁用、IP地址绑定、密码错误次数限制。'),
                createTextPara('【考试功能】新增Exam模块，支持在线考试功能（ExamController、ExamService）。'),
                createTextPara('【评分功能】新增QuestionTestCase模块，支持编程题自动评分（QuestionTestCaseService）。'),

                new Paragraph({ children: [new PageBreak()] }),

                createHeadingPara('6  改进建议', 1),
                createHeadingPara('6.3  测试建议', 2),
                createTextPara('测试方面改进建议：'),
                createTextPara('1. 【成绩模块测试】重点测试评分、批量评分、成绩导出功能。'),
                createTextPara('2. 【考试模块测试】测试考试创建、答题、提交、评分完整流程。'),
                createTextPara('3. 【并发测试】验证多学生同时答题时的数据一致性。'),
                createTextPara('【负责人】于峰'),
            ]
        }]
    });

    return doc;
}

// 生成文档
async function generateDocs() {
    const docsDir = 'D:/workfordasan/docs';

    // 生成总项目文档
    console.log('正在生成总项目文档...');
    const masterDoc = createMasterDocument();
    const masterBuffer = await Packer.toBuffer(masterDoc);
    fs.writeFileSync(`${docsDir}/教学一体化平台升级改造中期自查报告_总项目文档.docx`, masterBuffer);
    console.log('总项目文档已生成');

    // 生成周志文文档
    console.log('正在生成周志文文档...');
    const zhouDoc = createZhouDocument();
    const zhouBuffer = await Packer.toBuffer(zhouDoc);
    fs.writeFileSync(`${docsDir}/周志文_中期自查报告.docx`, zhouBuffer);
    console.log('周志文文档已生成');

    // 生成余飞杨文档
    console.log('正在生成余飞杨文档...');
    const yuFeiDoc = createYuFeiDocument();
    const yuFeiBuffer = await Packer.toBuffer(yuFeiDoc);
    fs.writeFileSync(`${docsDir}/余飞杨_中期自查报告.docx`, yuFeiBuffer);
    console.log('余飞杨文档已生成');

    // 生成杨宇润文档
    console.log('正在生成杨宇润文档...');
    const yangDoc = createYangDocument();
    const yangBuffer = await Packer.toBuffer(yangDoc);
    fs.writeFileSync(`${docsDir}/杨宇润_中期自查报告.docx`, yangBuffer);
    console.log('杨宇润文档已生成');

    // 生成于峰文档
    console.log('正在生成于峰文档...');
    const yuFengDoc = createYuFengDocument();
    const yuFengBuffer = await Packer.toBuffer(yuFengDoc);
    fs.writeFileSync(`${docsDir}/于峰_中期自查报告.docx`, yuFengBuffer);
    console.log('于峰文档已生成');

    console.log('\n所有文档生成完成！');
}

generateDocs().catch(console.error);