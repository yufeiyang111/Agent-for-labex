// -*- coding: utf-8 -*-
// 生成符合模板格式的教学一体化平台升级改造中期自查报告
const { Document, Packer, Paragraph, TextRun, Table, TableRow, TableCell,
        Header, Footer, AlignmentType, LevelFormat, HeadingLevel,
        BorderStyle, WidthType, ShadingType, VerticalAlign, PageNumber,
        PageBreak, PageOrientation } = require('docx');
const fs = require('fs');

// A4纸尺寸 (DXA) - 与模板一致
const PAGE_WIDTH = 11906;
const PAGE_HEIGHT = 16838;
const MARGIN_LEFT = 1800;
const MARGIN_RIGHT = 1800;
const MARGIN_TOP = 1440;
const MARGIN_BOTTOM = 1440;
const CONTENT_WIDTH = PAGE_WIDTH - MARGIN_LEFT - MARGIN_RIGHT;

// 创建段落
function createPara(text, options = {}) {
    const {
        font = "宋体",
        fontSize = 21,
        bold = false,
        color = "000000",
        indent = 0,
        align = AlignmentType.LEFT,
        spacing = 400,
        lineRule = "auto",
        firstLine = 0
    } = options;

    return new Paragraph({
        alignment: align,
        spacing: { line: spacing, lineRule: lineRule },
        indent: { firstLine: firstLine },
        children: [new TextRun({
            text,
            size: fontSize,
            bold,
            color,
            font: font
        })]
    });
}

// 创建带标题格式的段落
function createTitlePara(text, options = {}) {
    const {
        font = "黑体",
        fontSize = 44,
        bold = true,
        color = "000000",
        align = AlignmentType.LEFT,
        spacing = 400
    } = options;

    return new Paragraph({
        alignment: align,
        spacing: { line: spacing, lineRule: "exact" },
        children: [new TextRun({
            text,
            size: fontSize,
            bold,
            color,
            font: font
        })]
    });
}

// 创建红色提示段落
function createRedPara(text) {
    return new Paragraph({
        alignment: AlignmentType.LEFT,
        spacing: { line: 440, lineRule: "exact" },
        indent: { firstLine: 480 },
        children: [new TextRun({
            text,
            size: 24,
            color: "FF0000",
            font: "宋体"
        })]
    });
}

// 创建表格单元格
function createCell(text, width, options = {}) {
    const { bold = false, color = "000000", fontSize = 21, align = AlignmentType.CENTER } = options;
    return new TableCell({
        borders: {
            top: { style: BorderStyle.SINGLE, size: 1, color: "000000" },
            bottom: { style: BorderStyle.SINGLE, size: 1, color: "000000" },
            left: { style: BorderStyle.SINGLE, size: 1, color: "000000" },
            right: { style: BorderStyle.SINGLE, size: 1, color: "000000" }
        },
        width: { size: width, type: WidthType.DXA },
        margins: { top: 80, bottom: 80, left: 120, right: 120 },
        verticalAlign: VerticalAlign.CENTER,
        children: [new Paragraph({
            alignment: align,
            children: [new TextRun({
                text,
                size: fontSize,
                bold,
                color,
                font: "宋体"
            })]
        })]
    });
}

// 创建表头单元格
function createHeaderCell(text, width) {
    return createCell(text, width, { bold: true, color: "000000", fontSize: 21 });
}

// 创建空单元格
function createEmptyCell(width) {
    return new TableCell({
        borders: {
            top: { style: BorderStyle.SINGLE, size: 1, color: "000000" },
            bottom: { style: BorderStyle.SINGLE, size: 1, color: "000000" },
            left: { style: BorderStyle.SINGLE, size: 1, color: "000000" },
            right: { style: BorderStyle.SINGLE, size: 1, color: "000000" }
        },
        width: { size: width, type: WidthType.DXA },
        margins: { top: 80, bottom: 80, left: 120, right: 120 },
        verticalAlign: VerticalAlign.CENTER,
        children: [new Paragraph({ children: [] })]
    });
}

// 创建内容单元格
function createContentCell(text, width, options = {}) {
    return createCell(text, width, { bold: false, color: "000000", fontSize: 21, align: AlignmentType.LEFT });
}

// 创建总项目文档
function createMasterDocument() {
    const doc = new Document({
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
                // 标题部分 - 模仿模板格式
                new Paragraph({
                    alignment: AlignmentType.CENTER,
                    spacing: { line: 380, lineRule: "atLeast" },
                    children: [new TextRun({ text: "上海杉达学院", size: 36, bold: true, font: "隶书", color: "FF0000" })]
                }),
                createTitlePara("教学一体化平台改造", { font: "华文新魏", fontSize: 44 }),
                createTitlePara("中期自查报告", { font: "黑体", fontSize: 44 }),
                createTitlePara("第一阶段", { font: "黑体", fontSize: 52 }),
                new Paragraph({ children: [] }),

                // 项目信息（模拟模板的格式）
                new Paragraph({
                    alignment: AlignmentType.LEFT,
                    spacing: { line: 480, lineRule: "auto" },
                    indent: { firstLine: 560 },
                    children: [
                        new TextRun({ text: "项目组长：", size: 28, font: "宋体" }),
                        new TextRun({ text: "周志文", size: 28, font: "宋体", underline: {} })
                    ]
                }),
                new Paragraph({
                    alignment: AlignmentType.LEFT,
                    spacing: { line: 480, lineRule: "auto" },
                    indent: { firstLine: 560 },
                    children: [
                        new TextRun({ text: "专    业：", size: 28, font: "宋体" }),
                        new TextRun({ text: "计算机科学与技术", size: 28, font: "宋体", underline: {} })
                    ]
                }),
                new Paragraph({
                    alignment: AlignmentType.LEFT,
                    spacing: { line: 480, lineRule: "auto" },
                    indent: { firstLine: 560 },
                    children: [
                        new TextRun({ text: "班    级：", size: 28, font: "宋体" }),
                        new TextRun({ text: "2023级1班", size: 28, font: "宋体", underline: {} })
                    ]
                }),
                new Paragraph({
                    alignment: AlignmentType.LEFT,
                    spacing: { line: 480, lineRule: "auto" },
                    indent: { firstLine: 560 },
                    children: [
                        new TextRun({ text: "成    员：", size: 28, font: "宋体" }),
                        new TextRun({ text: "周志文、余飞杨、杨宇润、于峰", size: 28, font: "宋体", underline: {} })
                    ]
                }),
                new Paragraph({
                    alignment: AlignmentType.LEFT,
                    spacing: { line: 480, lineRule: "auto" },
                    indent: { firstLine: 560 },
                    children: [
                        new TextRun({ text: "报告日期：", size: 28, font: "宋体" }),
                        new TextRun({ text: "2026年4月21日", size: 28, font: "宋体", underline: {} })
                    ]
                }),

                new Paragraph({ children: [new PageBreak()] }),

                // 目录
                new Paragraph({
                    alignment: AlignmentType.CENTER,
                    spacing: { before: 200, after: 200 },
                    children: [new TextRun({ text: "目  录", size: 30, bold: true, font: "黑体" })]
                }),

                new Paragraph({ children: [new PageBreak()] }),

                // ========== 1 系统功能 ==========
                new Paragraph({
                    spacing: { before: 300, after: 200 },
                    children: [new TextRun({ text: "1  系统功能", size: 28, bold: true, font: "黑体" })]
                }),
                new Paragraph({
                    spacing: { before: 200, after: 150 },
                    children: [new TextRun({ text: "1.1  系统功能说明", size: 24, bold: true, font: "黑体" })]
                }),
                createRedPara("给出完整的系统功能说明。"),
                createPara("本项目旨在将原有的Spring MVC + JSP + jQuery实验教学管理系统（Labex）重构为现代化的Vue 3 + Spring Boot 3前后端分离架构。系统支持教师和学生的全流程实验教学管理，包括班级管理、学生管理、实验管理、成绩管理等核心功能。重构过程中完全保留原有数据库结构，确保数据兼容性。", { fontSize: 21, indent: 480 }),

                new Paragraph({ children: [] }),
                new Paragraph({
                    spacing: { before: 200, after: 150 },
                    children: [new TextRun({ text: "1.2  系统实现情况", size: 24, bold: true, font: "黑体" })]
                }),
                createRedPara("先以文字形式说明系统的具体实现情况，然后以表格形式说明完成情况。"),
                createPara("系统采用Vue 3 + Spring Boot 3前后端分离架构，后端使用Spring Security + JWT实现认证授权。系统包含8个主要模块，各模块均已完成开发，详细情况见下表。", { fontSize: 21, indent: 480 }),

                new Paragraph({ children: [] }),
                // 系统功能表格
                new Table({
                    width: { size: CONTENT_WIDTH, type: WidthType.DXA },
                    columnWidths: [700, 1800, 3500, 1100, 1218],
                    rows: [
                        new TableRow({
                            children: [
                                createHeaderCell("序号", 700),
                                createHeaderCell("功能名称", 1800),
                                createHeaderCell("功能概述", 3500),
                                createHeaderCell("完成进度", 1100),
                                createHeaderCell("差异度", 1218)
                            ]
                        }),
                        new TableRow({
                            children: [
                                createCell("1", 700),
                                createContentCell("系统架构设计", 1800),
                                createContentCell("完成前后端分离架构设计，定义清晰的接口规范", 3500),
                                createCell("100%", 1100),
                                createCell("无", 1218)
                            ]
                        }),
                        new TableRow({
                            children: [
                                createCell("2", 700),
                                createContentCell("后端核心模块", 1800),
                                createContentCell("完成Spring Boot 3后端框架搭建及核心业务逻辑实现", 3500),
                                createCell("100%", 1100),
                                createCell("无", 1218)
                            ]
                        }),
                        new TableRow({
                            children: [
                                createCell("3", 700),
                                createContentCell("教师管理模块", 1800),
                                createContentCell("完成班级管理、学生管理、实验管理等功能", 3500),
                                createCell("100%", 1100),
                                createCell("无", 1218)
                            ]
                        }),
                        new TableRow({
                            children: [
                                createCell("4", 700),
                                createContentCell("学生功能模块", 1800),
                                createContentCell("完成学生实验答题、讲义学习等功能", 3500),
                                createCell("100%", 1100),
                                createCell("无", 1218)
                            ]
                        }),
                        new TableRow({
                            children: [
                                createCell("5", 700),
                                createContentCell("成绩管理模块", 1800),
                                createContentCell("完成成绩录入、评分、导出等功能", 3500),
                                createCell("100%", 1100),
                                createCell("无", 1218)
                            ]
                        }),
                        new TableRow({
                            children: [
                                createCell("6", 700),
                                createContentCell("数据库优化", 1800),
                                createContentCell("完成数据库表结构优化及索引创建", 3500),
                                createCell("100%", 1100),
                                createCell("无", 1218)
                            ]
                        }),
                        new TableRow({
                            children: [
                                createCell("7", 700),
                                createContentCell("安全认证模块", 1800),
                                createContentCell("完成JWT认证、权限控制", 3500),
                                createCell("100%", 1100),
                                createCell("无", 1218)
                            ]
                        }),
                        new TableRow({
                            children: [
                                createCell("8", 700),
                                createContentCell("前端界面开发", 1800),
                                createContentCell("完成Vue 3前端页面及组件开发", 3500),
                                createCell("100%", 1100),
                                createCell("无", 1218)
                            ]
                        })
                    ]
                }),

                new Paragraph({ children: [new PageBreak()] }),

                // ========== 2 实施方案 ==========
                new Paragraph({
                    spacing: { before: 300, after: 200 },
                    children: [new TextRun({ text: "2  实施方案", size: 28, bold: true, font: "黑体" })]
                }),
                new Paragraph({
                    spacing: { before: 200, after: 150 },
                    children: [new TextRun({ text: "2.1  技术路线选择", size: 24, bold: true, font: "黑体" })]
                }),
                createRedPara("先以文字说明系统中原计划采用的框架、技术，然后以表格的形式说明实际情况与原计划之间的差异。"),
                createPara("系统原计划采用Spring MVC 4 + jQuery架构，实际采用Spring Boot 3 + Vue 3进行了完全重构，以获得更好的开发效率和可维护性。", { fontSize: 21, indent: 480 }),

                new Paragraph({ children: [] }),
                // 技术路线表格
                new Table({
                    width: { size: CONTENT_WIDTH, type: WidthType.DXA },
                    columnWidths: [600, 1400, 1400, 1400, 1518],
                    rows: [
                        new TableRow({
                            children: [
                                createHeaderCell("序号", 600),
                                createHeaderCell("项目", 1400),
                                createHeaderCell("原计划", 1400),
                                createHeaderCell("实际情况", 1400),
                                createHeaderCell("差异说明", 1518)
                            ]
                        }),
                        new TableRow({
                            children: [
                                createCell("1", 600),
                                createContentCell("后端框架", 1400),
                                createContentCell("Spring MVC 4", 1400),
                                createContentCell("Spring Boot 3", 1400),
                                createContentCell("架构升级，更简洁", 1518)
                            ]
                        }),
                        new TableRow({
                            children: [
                                createCell("2", 600),
                                createContentCell("前端框架", 1400),
                                createContentCell("jQuery + JSP", 1400),
                                createContentCell("Vue 3 + Vite", 1400),
                                createContentCell("完全重构", 1518)
                            ]
                        }),
                        new TableRow({
                            children: [
                                createCell("3", 600),
                                createContentCell("持久层", 1400),
                                createContentCell("MyBatis", 1400),
                                createContentCell("MyBatis-Plus", 1400),
                                createContentCell("自动CRUD更高效", 1518)
                            ]
                        }),
                        new TableRow({
                            children: [
                                createCell("4", 600),
                                createContentCell("安全框架", 1400),
                                createContentCell("Shiro", 1400),
                                createContentCell("Spring Security + JWT", 1400),
                                createContentCell("更完善的权限控制", 1518)
                            ]
                        }),
                        new TableRow({
                            children: [
                                createCell("5", 600),
                                createContentCell("数据库", 1400),
                                createContentCell("MySQL 5.x", 1400),
                                createContentCell("MySQL 8.x", 1400),
                                createContentCell("使用新版本特性", 1518)
                            ]
                        }),
                        new TableRow({
                            children: [
                                createCell("6", 600),
                                createContentCell("缓存", 1400),
                                createContentCell("无", 1400),
                                createContentCell("Redis 7.x", 1400),
                                createContentCell("新增缓存支持", 1518)
                            ]
                        })
                    ]
                }),

                new Paragraph({ children: [] }),
                new Paragraph({
                    spacing: { before: 200, after: 150 },
                    children: [new TextRun({ text: "2.2  技术路线选择及存在差异原因", size: 24, bold: true, font: "黑体" })]
                }),
                createRedPara("说明技术路线选择的具体差异，并分析产生差异的原因。"),
                createPara("1. Spring Boot 3相比Spring MVC 4：提供更简化的配置、自动装配机制，与Spring Security 6.x兼容性更好。", { fontSize: 21, indent: 480 }),
                createPara("2. Vue 3相比jQuery：组件化开发模式、响应式数据绑定、虚拟DOM，大幅提升开发效率。", { fontSize: 21, indent: 480 }),
                createPara("3. JWT Token：支持无状态认证，便于分布式部署和水平扩展。", { fontSize: 21, indent: 480 }),
                createPara("4. Redis缓存：提升热点数据访问性能，支持会话共享。", { fontSize: 21, indent: 480 }),

                new Paragraph({ children: [new PageBreak()] }),

                // ========== 3 数据库 ==========
                new Paragraph({
                    spacing: { before: 300, after: 200 },
                    children: [new TextRun({ text: "3  数据库", size: 28, bold: true, font: "黑体" })]
                }),
                new Paragraph({
                    spacing: { before: 200, after: 150 },
                    children: [new TextRun({ text: "3.1  数据表", size: 24, bold: true, font: "黑体" })]
                }),
                createRedPara("以表格的形式说明现有数据库与原先数据库之间的差异。"),
                createPara("系统共保留和优化了以下核心数据表，主要差异在于新增了部分字段和索引：", { fontSize: 21, indent: 480 }),

                new Paragraph({ children: [] }),
                // 数据表表格
                new Table({
                    width: { size: CONTENT_WIDTH, type: WidthType.DXA },
                    columnWidths: [500, 1500, 1500, 1500, 1318, 1000],
                    rows: [
                        new TableRow({
                            children: [
                                createHeaderCell("序号", 500),
                                createHeaderCell("数据表名", 1500),
                                createHeaderCell("说明", 1500),
                                createHeaderCell("原数据库", 1500),
                                createHeaderCell("新数据库", 1318),
                                createHeaderCell("备注", 1000)
                            ]
                        }),
                        new TableRow({
                            children: [
                                createCell("1", 500), createContentCell("t_teacher", 1500),
                                createContentCell("教师/管理员表", 1500), createCell("保留", 1500), createCell("保留", 1318), createCell("", 1000)
                            ]
                        }),
                        new TableRow({
                            children: [
                                createCell("2", 500), createContentCell("t_student", 1500),
                                createContentCell("学生表", 1500), createCell("保留", 1500), createCell("保留", 1318), createCell("", 1000)
                            ]
                        }),
                        new TableRow({
                            children: [
                                createCell("3", 500), createContentCell("t_clazz", 1500),
                                createContentCell("班级表", 1500), createCell("保留", 1500), createCell("增强", 1318), createCell("新增teacher_id", 1000)
                            ]
                        }),
                        new TableRow({
                            children: [
                                createCell("4", 500), createContentCell("t_experiment", 1500),
                                createContentCell("实验表", 1500), createCell("保留", 1500), createCell("保留", 1318), createCell("", 1000)
                            ]
                        }),
                        new TableRow({
                            children: [
                                createCell("5", 500), createContentCell("t_experiment_item", 1500),
                                createContentCell("实验题目表", 1500), createCell("保留", 1500), createCell("保留", 1318), createCell("", 1000)
                            ]
                        }),
                        new TableRow({
                            children: [
                                createCell("6", 500), createContentCell("t_score", 1500),
                                createContentCell("成绩表", 1500), createCell("保留", 1500), createCell("保留", 1318), createCell("", 1000)
                            ]
                        }),
                        new TableRow({
                            children: [
                                createCell("7", 500), createContentCell("t_lecture", 1500),
                                createContentCell("讲义表", 1500), createCell("保留", 1500), createCell("保留", 1318), createCell("", 1000)
                            ]
                        })
                    ]
                }),

                new Paragraph({ children: [] }),
                new Paragraph({
                    spacing: { before: 200, after: 150 },
                    children: [new TextRun({ text: "3.2  视图及存储过程", size: 24, bold: true, font: "黑体" })]
                }),
                createRedPara("以表格的形式说明现有数据库与原先数据库之间的差异。"),

                new Paragraph({ children: [] }),
                new Table({
                    width: { size: CONTENT_WIDTH, type: WidthType.DXA },
                    columnWidths: [500, 1800, 1800, 1800, 1418],
                    rows: [
                        new TableRow({
                            children: [
                                createHeaderCell("序号", 500), createHeaderCell("视图/存储过程", 1800),
                                createHeaderCell("说明", 1800), createHeaderCell("原数据库", 1800), createHeaderCell("新数据库", 1418)
                            ]
                        }),
                        new TableRow({
                            children: [
                                createCell("1", 500), createContentCell("无", 1800),
                                createContentCell("未使用视图", 1800), createCell("未使用", 1800), createCell("未使用", 1418)
                            ]
                        }),
                        new TableRow({
                            children: [
                                createCell("2", 500), createContentCell("无", 1800),
                                createContentCell("未使用存储过程", 1800), createCell("未使用", 1800), createCell("未使用", 1418)
                            ]
                        }),
                        new TableRow({
                            children: [
                                createCell("3", 500), createContentCell("索引优化", 1800),
                                createContentCell("新增12个索引优化查询性能", 1800), createCell("部分索引", 1800), createCell("新增12个索引", 1418)
                            ]
                        })
                    ]
                }),

                new Paragraph({ children: [] }),
                new Paragraph({
                    spacing: { before: 200, after: 150 },
                    children: [new TextRun({ text: "3.3  数据库差异及存在差异原因", size: 24, bold: true, font: "黑体" })]
                }),
                createRedPara("说明数据库的具体差异，并分析产生差异的原因。"),
                createPara("1. 新增字段：t_clazz表新增teacher_id字段，关联所属教师。", { fontSize: 21, indent: 480 }),
                createPara("2. 新增表：为支持新的考试功能，新增t_exam、t_paper等表。", { fontSize: 21, indent: 480 }),
                createPara("3. 索引优化：在关键查询字段上新增12个索引，提升查询性能。", { fontSize: 21, indent: 480 }),
                createPara("4. 密码加密：密码存储从MD5升级为BCrypt加密，更安全。", { fontSize: 21, indent: 480 }),

                new Paragraph({ children: [new PageBreak()] }),

                // ========== 4 业务系统结构及代码模式 ==========
                new Paragraph({
                    spacing: { before: 300, after: 200 },
                    children: [new TextRun({ text: "4  业务系统结构及代码模式", size: 28, bold: true, font: "黑体" })]
                }),
                new Paragraph({
                    spacing: { before: 200, after: 150 },
                    children: [new TextRun({ text: "4.1  业务系统结构", size: 24, bold: true, font: "黑体" })]
                }),
                createRedPara("以表格的形式说明软件体系结构的情况，然后以文字形式说明选择的差异。"),

                new Paragraph({ children: [] }),
                new Table({
                    width: { size: CONTENT_WIDTH, type: WidthType.DXA },
                    columnWidths: [500, 1500, 1800, 2000, 2518],
                    rows: [
                        new TableRow({
                            children: [
                                createHeaderCell("序号", 500), createHeaderCell("业务系统结构", 1500),
                                createHeaderCell("说明", 1800), createHeaderCell("原系统", 2000), createHeaderCell("新系统", 2518)
                            ]
                        }),
                        new TableRow({
                            children: [
                                createCell("1", 500), createContentCell("整体架构", 1500),
                                createContentCell("前后端分离", 1800), createContentCell("前后端耦合（JSP）", 2000), createContentCell("完全分离", 2518)
                            ]
                        }),
                        new TableRow({
                            children: [
                                createCell("2", 500), createContentCell("后端模块", 1500),
                                createContentCell("Controller-Service-Mapper", 1800), createContentCell("Service-Action-Model", 2000), createContentCell("标准三层架构", 2518)
                            ]
                        }),
                        new TableRow({
                            children: [
                                createCell("3", 500), createContentCell("前端模块", 1500),
                                createContentCell("Vue组件化", 1800), createContentCell("页面模板", 2000), createContentCell("组件化+状态管理", 2518)
                            ]
                        }),
                        new TableRow({
                            children: [
                                createCell("4", 500), createContentCell("认证方式", 1500),
                                createContentCell("JWT Token无状态认证", 1800), createContentCell("Session认证", 2000), createContentCell("无状态+RefreshToken", 2518)
                            ]
                        })
                    ]
                }),

                new Paragraph({ children: [] }),
                new Paragraph({
                    spacing: { before: 200, after: 150 },
                    children: [new TextRun({ text: "4.2  代码模式", size: 24, bold: true, font: "黑体" })]
                }),
                createRedPara("以表格的形式说明设计模式的情况，然后以文字形式说明选择的差异。"),

                new Paragraph({ children: [] }),
                new Table({
                    width: { size: CONTENT_WIDTH, type: WidthType.DXA },
                    columnWidths: [500, 1500, 1800, 2000, 2518],
                    rows: [
                        new TableRow({
                            children: [
                                createHeaderCell("序号", 500), createHeaderCell("代码模式", 1500),
                                createHeaderCell("说明", 1800), createHeaderCell("原系统", 2000), createHeaderCell("新系统", 2518)
                            ]
                        }),
                        new TableRow({
                            children: [
                                createCell("1", 500), createContentCell("后端分层", 1500),
                                createContentCell("Controller-Service-Mapper三层", 1800), createContentCell("Action-Service-Dao多层", 2000), createContentCell("标准三层更清晰", 2518)
                            ]
                        }),
                        new TableRow({
                            children: [
                                createCell("2", 500), createContentCell("ORM框架", 1500),
                                createContentCell("MyBatis-Plus增强", 1800), createContentCell("MyBatis", 2000), createContentCell("自动CRUD更高效", 2518)
                            ]
                        }),
                        new TableRow({
                            children: [
                                createCell("3", 500), createContentCell("前端组件", 1500),
                                createContentCell("Vue 3 Composition API", 1800), createContentCell("无组件化", 2000), createContentCell("完全组件化", 2518)
                            ]
                        }),
                        new TableRow({
                            children: [
                                createCell("4", 500), createContentCell("状态管理", 1500),
                                createContentCell("Pinia集中管理", 1800), createContentCell("无", 2000), createContentCell("集中式状态管理", 2518)
                            ]
                        })
                    ]
                }),

                new Paragraph({ children: [] }),
                createPara("【代码模式说明】本项目采用主流的代码模式：后端采用标准三层架构（Controller-Service-Mapper），使用MyBatis-Plus实现数据访问自动化；前端采用Vue 3 Composition API进行组件化开发，使用Pinia进行状态管理。", { fontSize: 21, indent: 0 }),

                new Paragraph({ children: [new PageBreak()] }),

                // ========== 5 详细业务功能描述 ==========
                new Paragraph({
                    spacing: { before: 300, after: 200 },
                    children: [new TextRun({ text: "5  详细业务功能描述", size: 28, bold: true, font: "黑体" })]
                }),
                new Paragraph({
                    spacing: { before: 200, after: 150 },
                    children: [new TextRun({ text: "5.1  实现业务功能", size: 24, bold: true, font: "黑体" })]
                }),
                createRedPara("给出完整的业务功能描述，包括原有业务功能以及改进的业务功能图表并进行说明，以及差异产生的原因（如果有图表请在附录给出）。"),
                createPara("【核心功能】班级管理（增删改查、启用/禁用）、学生管理（CRUD、批量导入、重置密码）、实验管理（创建/编辑实验、题目管理）、讲义管理（文件上传、列表浏览）、成绩管理（查看答案、在线评分、批量评分、导出Excel）。", { fontSize: 21, indent: 480 }),
                createPara("【学生端】实验列表浏览、进入答题、题目导航、在线答题、自动保存、提交答卷、讲义学习、个人中心。", { fontSize: 21, indent: 480 }),
                createPara("【负责人】周志文、余飞杨、杨宇润、于峰", { fontSize: 21, indent: 480 }),

                new Paragraph({ children: [] }),
                new Paragraph({
                    spacing: { before: 200, after: 150 },
                    children: [new TextRun({ text: "5.2  运维业务功能", size: 24, bold: true, font: "黑体" })]
                }),
                createRedPara("同上。"),
                createPara("【系统监控】操作日志记录（t_sys_log）、学生日志记录（t_student_log）、答题日志跟踪。", { fontSize: 21, indent: 480 }),
                createPara("【数据管理】数据备份支持、批量导入/导出（CSV格式）、Excel成绩导出。", { fontSize: 21, indent: 480 }),
                createPara("【负责人】周志文、余飞杨", { fontSize: 21, indent: 480 }),

                new Paragraph({ children: [] }),
                new Paragraph({
                    spacing: { before: 200, after: 150 },
                    children: [new TextRun({ text: "5.3  其他业务功能", size: 24, bold: true, font: "黑体" })]
                }),
                createRedPara("同上。"),
                createPara("【认证授权】用户登录（JWT Token）、退出登录、Token自动刷新、用户信息获取。", { fontSize: 21, indent: 480 }),
                createPara("【班级管理】班级启用/禁用、IP限制设置。", { fontSize: 21, indent: 480 }),
                createPara("【负责人】周志文、杨宇润", { fontSize: 21, indent: 480 }),

                new Paragraph({ children: [new PageBreak()] }),

                // ========== 6 改进建议 ==========
                new Paragraph({
                    spacing: { before: 300, after: 200 },
                    children: [new TextRun({ text: "6  改进建议", size: 28, bold: true, font: "黑体" })]
                }),
                new Paragraph({
                    spacing: { before: 200, after: 150 },
                    children: [new TextRun({ text: "6.1  实现改进建议", size: 24, bold: true, font: "黑体" })]
                }),
                createRedPara("先给出一张完整的网页导航图，然后再给出关键页面截图，并给出相关说明，要求能展现出关键的业务流程。"),
                createPara("1. 【代码生成】引入MyBatis-Plus Generator自动生成基础CRUD代码。", { fontSize: 21, indent: 480 }),
                createPara("2. 【接口文档】引入SpringDoc OpenAPI 3自动生成API文档。", { fontSize: 21, indent: 480 }),
                createPara("3. 【缓存优化】针对热点数据引入Redis二级缓存。", { fontSize: 21, indent: 480 }),
                createPara("4. 【异步处理】将非核心功能异步化。", { fontSize: 21, indent: 480 }),
                createPara("【负责人】周志文", { fontSize: 21, indent: 480 }),

                new Paragraph({ children: [] }),
                new Paragraph({
                    spacing: { before: 200, after: 150 },
                    children: [new TextRun({ text: "6.2  运维改进建议", size: 24, bold: true, font: "黑体" })]
                }),
                createRedPara("同上。"),
                createPara("1. 【监控告警】引入Spring Boot Actuator + Prometheus监控指标。", { fontSize: 21, indent: 480 }),
                createPara("2. 【日志规范】统一日志格式，引入ELK日志收集分析。", { fontSize: 21, indent: 480 }),
                createPara("3. 【配置中心】引入Apollo或Nacos实现配置中心化管理。", { fontSize: 21, indent: 480 }),
                createPara("【负责人】余飞杨", { fontSize: 21, indent: 480 }),

                new Paragraph({ children: [] }),
                new Paragraph({
                    spacing: { before: 200, after: 150 },
                    children: [new TextRun({ text: "6.3  测试建议", size: 24, bold: true, font: "黑体" })]
                }),
                createRedPara("同上。"),
                createPara("1. 【单元测试】为Service层编写单元测试，使用JUnit 5 + Mockito。", { fontSize: 21, indent: 480 }),
                createPara("2. 【集成测试】编写Controller层集成测试，验证接口功能。", { fontSize: 21, indent: 480 }),
                createPara("3. 【前端测试】引入Vitest进行前端单元测试，Playwright进行E2E测试。", { fontSize: 21, indent: 480 }),
                createPara("4. 【性能测试】使用JMeter进行接口性能测试，验证并发能力。", { fontSize: 21, indent: 480 }),
                createPara("【负责人】杨宇润、于峰", { fontSize: 21, indent: 480 }),
            ]
        }]
    });

    return doc;
}

// 生成文档
async function generateDocs() {
    const docsDir = 'D:/workfordasan/docs';

    console.log('正在生成总项目文档...');
    const masterDoc = createMasterDocument();
    const masterBuffer = await Packer.toBuffer(masterDoc);
    fs.writeFileSync(`${docsDir}/教学一体化平台升级改造中期自查报告_总项目文档.docx`, masterBuffer);
    console.log('总项目文档已生成: 教学一体化平台升级改造中期自查报告_总项目文档.docx');

    console.log('\n所有文档生成完成！');
    console.log('请查看 docs 目录下的文件。');
}

generateDocs().catch(console.error);