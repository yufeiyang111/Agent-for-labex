package com.labex.service.teaching.export;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.labex.entity.Student;
import com.labex.entity.teaching.CourseOffering;
import com.labex.entity.teaching.ScoringItem;
import com.labex.entity.teaching.ScoringScore;
import com.labex.mapper.StudentMapper;
import com.labex.mapper.teaching.CourseMapper;
import com.labex.mapper.teaching.CourseOfferingMapper;
import com.labex.mapper.teaching.ScoringItemMapper;
import com.labex.mapper.teaching.ScoringScoreMapper;
import com.labex.service.TeacherService;
import com.labex.service.teaching.AchievementCalcEngine;
import com.labex.vo.teaching.GradeDetailMatrixVO;
import com.labex.vo.teaching.OfferingAchievementVO;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 成绩明细表 Excel 生成器（严格按 Class-docs/课程分组及成绩明细表.xlsx 模板）
 * 模板有 2 个 Sheet：
 *  - Sheet 0 "分组信息"：学生选题表 + 9 个组
 *  - Sheet 1 "成绩明细表"：南昌航空大学学生课程目标达成度计算表
 */
@Service
@Slf4j
public class GradeDetailExcelGenerator {

    @Autowired private CourseOfferingMapper offeringMapper;
    @Autowired private CourseMapper courseMapper;
    @Autowired private TeacherService teacherService;
    @Autowired private ScoringItemMapper itemMapper;
    @Autowired private ScoringScoreMapper scoreMapper;
    @Autowired private StudentMapper studentMapper;
    @Autowired private AchievementCalcEngine achievementEngine;
    @Autowired private ClassDocTemplateService templateService;

    // ============ 公开方法 ============

    /** 返回二进制 xlsx */
    public byte[] generate(Integer offeringId) {
        try (XSSFWorkbook wb = templateService.openXlsxTemplate("课程分组及成绩明细表.xlsx");
             ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            Data data = loadData(offeringId);
            fillTemplateWorkbook(wb, data);
            wb.write(out);
            return out.toByteArray();
        } catch (Exception e) {
            log.error("生成成绩明细表失败", e);
            throw new RuntimeException("生成成绩明细表失败: " + e.getMessage(), e);
        }
    }

    /** 返回 JSON 预览结构（前端 el-table 用） */
    public GradeDetailMatrixVO buildMatrix(Integer offeringId) {
        Data data = loadData(offeringId);
        // 学生数据
        List<GradeDetailMatrixVO.StudentRow> rows = new ArrayList<>();
        int idx = 0;
        for (Student s : data.students) {
            int rowIdx = ++idx;
            Map<Integer, java.math.BigDecimal> scoreMap = new LinkedHashMap<>();
            Map<Integer, java.math.BigDecimal> objAchMap = new LinkedHashMap<>();
            for (ScoringItem it : data.items) {
                ScoringScore sc = data.scoreMap.get(s.getStudentId() + "_" + it.getItemId());
                if (sc != null && sc.getScore() != null) {
                    scoreMap.put(it.getItemId(), sc.getScore());
                }
            }
            // 学生的目标达成度
            if (data.achievementByStudent.get(s.getStudentId()) != null) {
                for (var e : data.achievementByStudent.get(s.getStudentId()).entrySet()) {
                    objAchMap.put(e.getKey(), java.math.BigDecimal.valueOf(e.getValue() == null ? 0 : e.getValue()));
                }
            }
            GradeDetailMatrixVO.StudentRow r = new GradeDetailMatrixVO.StudentRow();
            r.setRowIndex(rowIdx);
            r.setStudentId(s.getStudentId());
            r.setStudentNo(s.getStudentNo());
            r.setStudentName(s.getStudentName());
            r.setScores(scoreMap);
            r.setObjectiveAchievements(objAchMap);
            rows.add(r);
        }
        // 目标分组 + 列头
        List<GradeDetailMatrixVO.ObjectiveGroup> groups = new ArrayList<>();
        int total = data.items.size();
        int mid = total / 2;
        if (mid > 0) {
            groups.add(buildGroup(data.items.subList(0, mid)));
            if (mid < total) groups.add(buildGroup(data.items.subList(mid, total)));
        }
        GradeDetailMatrixVO vo = new GradeDetailMatrixVO();
        vo.setTitle("南昌航空大学学生课程目标达成度计算表");
        vo.setSubtitle("开课学期：" + n(data.semester) + "   课程：" + n(data.courseName)
                + "  教师：" + n(data.teacherName) + "     班级：" + n(data.clazzNo));
        vo.setSemester(data.semester);
        vo.setCourseName(data.courseName);
        vo.setTeacherName(data.teacherName);
        vo.setClazzNo(data.clazzNo);
        vo.setObjectiveGroups(groups);
        vo.setStudents(rows);
        vo.setAggregateColumns(java.util.Arrays.asList("平时成绩（占总成绩的50%）", "期末成绩（占总成绩的50%）", "总成绩"));
        return vo;
    }

    private GradeDetailMatrixVO.ObjectiveGroup buildGroup(List<ScoringItem> items) {
        GradeDetailMatrixVO.ObjectiveGroup g = new GradeDetailMatrixVO.ObjectiveGroup();
        List<GradeDetailMatrixVO.ColumnHeader> cols = new ArrayList<>();
        for (ScoringItem it : items) {
            GradeDetailMatrixVO.ColumnHeader c = new GradeDetailMatrixVO.ColumnHeader();
            c.setItemId(it.getItemId());
            c.setName(it.getName());
            c.setMaxScore(it.getMaxScore() == null ? 100 : it.getMaxScore());
            c.setPassingScore(it.getPassingScore() == null ? 70 : it.getPassingScore());
            java.math.BigDecimal w = it.getWeight() == null ? java.math.BigDecimal.ZERO : new java.math.BigDecimal(it.getWeight().toString());
            c.setWeight(w);
            c.setWeightedValue(w.multiply(new java.math.BigDecimal(String.valueOf(c.getPassingScore()))));
            cols.add(c);
        }
        g.setColumns(cols);
        GradeDetailMatrixVO.ColumnHeader ach = new GradeDetailMatrixVO.ColumnHeader();
        ach.setName("达成度");
        g.setAchievementColumn(ach);
        return g;
    }

    private static String n(Object o) { return o == null ? "" : o.toString(); }

    // ============ Template fill ============

    private void fillTemplateWorkbook(XSSFWorkbook wb, Data d) {
        Sheet groupSheet = wb.getSheet("分组信息");
        Sheet detailSheet = wb.getSheet("成绩明细表");
        if (groupSheet == null || detailSheet == null) {
            throw new IllegalStateException("课程分组及成绩明细表.xlsx 模板必须包含「分组信息」和「成绩明细表」两个 Sheet");
        }
        fillGroupsTemplate(groupSheet, d);
        fillDetailTemplate(detailSheet, d);
        wb.setForceFormulaRecalculation(true);
    }

    private void fillGroupsTemplate(Sheet sh, Data d) {
        setString(sh, 0, 0, "学生选题表   班级：" + n(d.clazzNo) + " 班");

        List<CellRangeAddress> groupRanges = sh.getMergedRegions().stream()
                .filter(r -> r.getFirstColumn() == 0 && r.getLastColumn() == 0 && r.getFirstRow() >= 3)
                .sorted(Comparator.comparingInt(CellRangeAddress::getFirstRow))
                .collect(Collectors.toList());
        if (groupRanges.isEmpty()) {
            throw new IllegalStateException("分组信息模板缺少 A 列组别合并区域");
        }

        for (CellRangeAddress range : groupRanges) {
            for (int r = range.getFirstRow(); r <= range.getLastRow(); r++) {
                for (int c = 1; c <= 7; c++) clearCell(sh, r, c);
            }
        }

        List<List<Student>> groups = new ArrayList<>();
        for (int i = 0; i < groupRanges.size(); i++) groups.add(new ArrayList<>());
        int idx = 0;
        for (Student s : d.students) {
            groups.get(idx % groupRanges.size()).add(s);
            idx++;
        }

        for (int g = 0; g < groupRanges.size(); g++) {
            CellRangeAddress range = groupRanges.get(g);
            setString(sh, range.getFirstRow(), 0, (g + 1) + "组");
            List<Student> members = groups.get(g);
            int capacity = range.getLastRow() - range.getFirstRow() + 1;
            if (members.size() > capacity) {
                log.warn("第 {} 组学生数 {} 超出模板容量 {}，多余学生不会写入分组信息 Sheet", g + 1, members.size(), capacity);
            }
            for (int i = 0; i < Math.min(members.size(), capacity); i++) {
                Student s = members.get(i);
                int row = range.getFirstRow() + i;
                setString(sh, row, 2, n(s.getStudentName()));
                setString(sh, row, 3, "");
                setString(sh, row, 4, n(s.getStudentNo()));
                setString(sh, row, 5, n(d.clazzNo));
                setString(sh, row, 6, "");
                setString(sh, row, 7, "");
            }
        }
    }

    private void fillDetailTemplate(Sheet sh, Data d) {
        // 动态列分配：将评分项平均分成两组（目标1和目标2）
        int totalItems = d.items.size();
        if (totalItems == 0) {
            log.warn("没有评分项，无法生成成绩明细表");
            return;
        }

        int t1Count = (totalItems + 1) / 2;  // 目标1的评分项数量（向上取整）
        int t2Count = totalItems - t1Count;   // 目标2的评分项数量

        // 列位置计算：
        // Col 0: 序号, Col 1: 学号, Col 2: 姓名
        // Col 3 ~ 3+t1Count-1: 目标1的评分项
        // Col 3+t1Count: 目标1达成度
        // Col 3+t1Count+1 ~ 3+t1Count+t2Count: 目标2的评分项
        // Col 3+t1Count+t2Count+1: 目标2达成度
        // 最后3列: 平时成绩、期末成绩、总成绩
        int t1StartCol = 3;
        int ach1Col = t1StartCol + t1Count;
        int t2StartCol = ach1Col + 1;
        int ach2Col = t2StartCol + t2Count;
        int dailyScoreCol = ach2Col + 1;
        int finalScoreCol = dailyScoreCol + 1;
        int totalScoreCol = finalScoreCol + 1;

        // 清除整个模板内容区域（Row 1 到最后一行，Col 0-20）
        int lastRow = Math.max(sh.getLastRowNum(), 48);
        log.info("清除模板内容: lastRow={}", lastRow);
        for (int r = 0; r <= lastRow; r++) {
            Row row = sh.getRow(r);
            if (row != null) {
                for (int c = 0; c <= 20; c++) {
                    Cell cell = row.getCell(c);
                    if (cell != null) {
                        cell.setBlank();
                    }
                }
            }
        }

        // 删除所有已存在的合并单元格（避免冲突）
        int mergedCount = sh.getNumMergedRegions();
        log.info("删除合并单元格: 数量={}", mergedCount);
        for (int i = mergedCount - 1; i >= 0; i--) {
            sh.removeMergedRegion(i);
        }

        // Row 1: 标题（合并单元格）
        setString(sh, 0, 0, "南昌航空大学学生课程目标达成度计算表");
        sh.addMergedRegion(new CellRangeAddress(0, 0, 0, totalScoreCol));

        // Row 2: 元信息（合并单元格）
        setString(sh, 1, 0, "开课学期：" + n(d.semester)
                + "   课程：" + n(d.courseName)
                + "  教师：" + n(d.teacherName)
                + "     班级：" + n(d.clazzNo));
        sh.addMergedRegion(new CellRangeAddress(1, 1, 0, totalScoreCol));

        // Row 3-5: 表头（3行）
        // Row 3: 序号、学号、姓名、毕业要求、达成度、平时成绩、期末成绩、总成绩
        setString(sh, 2, 0, "序号");
        setString(sh, 2, 1, "学号");
        setString(sh, 2, 2, "姓名");
        setString(sh, 2, t1StartCol, "毕业要求" + n(d.gradReqCode));
        setString(sh, 2, ach1Col, "达成度");
        setString(sh, 2, ach2Col, "达成度");
        setString(sh, 2, dailyScoreCol, "平时成绩（占总成绩的50%）");
        setString(sh, 2, finalScoreCol, "期末成绩（占总成绩的50%）");
        setString(sh, 2, totalScoreCol, "总成绩");

        // 合并单元格：序号、学号、姓名跨3行
        sh.addMergedRegion(new CellRangeAddress(2, 4, 0, 0));  // 序号
        sh.addMergedRegion(new CellRangeAddress(2, 4, 1, 1));  // 学号
        sh.addMergedRegion(new CellRangeAddress(2, 4, 2, 2));  // 姓名
        // 毕业要求只跨目标1评分项列（不包含达成度列）
        if (t1Count > 1) {
            sh.addMergedRegion(new CellRangeAddress(2, 2, t1StartCol, ach1Col - 1));
        }
        // 达成度1跨Row 3-4
        sh.addMergedRegion(new CellRangeAddress(2, 3, ach1Col, ach1Col));
        // 达成度2跨Row 3-4
        sh.addMergedRegion(new CellRangeAddress(2, 3, ach2Col, ach2Col));
        // 平时成绩、期末成绩、总成绩各跨3行
        sh.addMergedRegion(new CellRangeAddress(2, 4, dailyScoreCol, dailyScoreCol));
        sh.addMergedRegion(new CellRangeAddress(2, 4, finalScoreCol, finalScoreCol));
        sh.addMergedRegion(new CellRangeAddress(2, 4, totalScoreCol, totalScoreCol));

        // Row 4: 课程目标1、课程目标2
        setString(sh, 3, t1StartCol, "课程目标1");
        setString(sh, 3, t2StartCol, "课程目标2");

        // 合并单元格：目标1跨评分项列（不包含达成度列）
        if (t1Count > 1) {
            sh.addMergedRegion(new CellRangeAddress(3, 3, t1StartCol, ach1Col - 1));
        }
        // 目标2跨评分项列（不包含达成度列）
        if (t2Count > 1) {
            sh.addMergedRegion(new CellRangeAddress(3, 3, t2StartCol, ach2Col - 1));
        }

        // Row 5: 各评分项名称
        for (int i = 0; i < t1Count; i++) {
            ScoringItem item = d.items.get(i);
            setString(sh, 4, t1StartCol + i, n(item.getName()));
        }
        for (int i = 0; i < t2Count; i++) {
            ScoringItem item = d.items.get(t1Count + i);
            setString(sh, 4, t2StartCol + i, n(item.getName()));
        }

        // Row 6: 满分分值
        setString(sh, 5, 0, "满分分值");
        for (int i = 0; i < t1Count; i++) {
            ScoringItem item = d.items.get(i);
            setNumber(sh, 5, t1StartCol + i, item.getMaxScore() == null ? 100D : item.getMaxScore().doubleValue());
        }
        setNumber(sh, 5, ach1Col, 1.0);
        for (int i = 0; i < t2Count; i++) {
            ScoringItem item = d.items.get(t1Count + i);
            setNumber(sh, 5, t2StartCol + i, item.getMaxScore() == null ? 100D : item.getMaxScore().doubleValue());
        }
        setNumber(sh, 5, ach2Col, 1.0);

        // Row 7: 达成及格的期望分值
        setString(sh, 6, 0, "达成及格的期望分值");
        for (int i = 0; i < t1Count; i++) {
            ScoringItem item = d.items.get(i);
            setNumber(sh, 6, t1StartCol + i, item.getPassingScore() == null ? 70D : item.getPassingScore().doubleValue());
        }
        setNumber(sh, 6, ach1Col, 0.7);
        for (int i = 0; i < t2Count; i++) {
            ScoringItem item = d.items.get(t1Count + i);
            setNumber(sh, 6, t2StartCol + i, item.getPassingScore() == null ? 70D : item.getPassingScore().doubleValue());
        }
        setNumber(sh, 6, ach2Col, 0.7);

        // Row 8: 权重
        setString(sh, 7, 0, "权重");
        for (int i = 0; i < t1Count; i++) {
            ScoringItem item = d.items.get(i);
            setNumber(sh, 7, t1StartCol + i, item.getWeight() == null ? 0D : item.getWeight().doubleValue());
        }
        // 目标1达成度权重 = SUM(目标1各评分项权重)
        String t1Range = excelCol(t1StartCol) + "8:" + excelCol(ach1Col - 1) + "8";
        setFormula(sh, 7, ach1Col, "SUM(" + t1Range + ")");

        for (int i = 0; i < t2Count; i++) {
            ScoringItem item = d.items.get(t1Count + i);
            setNumber(sh, 7, t2StartCol + i, item.getWeight() == null ? 0D : item.getWeight().doubleValue());
        }
        // 目标2达成度权重 = SUM(目标2各评分项权重)
        String t2Range = excelCol(t2StartCol) + "8:" + excelCol(ach2Col - 1) + "8";
        setFormula(sh, 7, ach2Col, "SUM(" + t2Range + ")");

        // 平时/期末/总成绩的权重（固定50%/50%/100%）
        setNumber(sh, 7, dailyScoreCol, 0.5);
        setNumber(sh, 7, finalScoreCol, 0.5);
        setNumber(sh, 7, totalScoreCol, 1.0);

        // Row 9: 加权分值 = 期望分 × 权重
        setString(sh, 8, 0, "加权分值");
        for (int i = 0; i < t1Count; i++) {
            int col = t1StartCol + i;
            setFormula(sh, 8, col, excelCol(col) + "7*" + excelCol(col) + "8");
        }
        setFormula(sh, 8, ach1Col, excelCol(ach1Col) + "7*" + excelCol(ach1Col) + "8");
        for (int i = 0; i < t2Count; i++) {
            int col = t2StartCol + i;
            setFormula(sh, 8, col, excelCol(col) + "7*" + excelCol(col) + "8");
        }
        setFormula(sh, 8, ach2Col, excelCol(ach2Col) + "7*" + excelCol(ach2Col) + "8");
        setNumber(sh, 8, dailyScoreCol, 50.0);
        setNumber(sh, 8, finalScoreCol, 50.0);
        setNumber(sh, 8, totalScoreCol, 100.0);

        // 学生数据从 Row 10 开始（索引 9），模板预留到 Row 49（索引 48）
        int dataStart = 9;
        int dataEnd = 48;
        int count = Math.min(d.students.size(), dataEnd - dataStart + 1);
        if (d.students.size() > count) {
            log.warn("学生数 {} 超出成绩明细模板容量 {}，多余学生不会写入成绩明细 Sheet", d.students.size(), count);
        }

        // 填充学生数据
        for (int sIdx = 0; sIdx < count; sIdx++) {
            Student stu = d.students.get(sIdx);
            int row = dataStart + sIdx;
            setNumber(sh, row, 0, sIdx + 1);  // 序号
            setString(sh, row, 1, n(stu.getStudentNo()));  // 学号
            setString(sh, row, 2, n(stu.getStudentName()));  // 姓名

            // 填充目标1各评分项成绩，并计算加权得分
            double t1WeightedScore = 0;
            for (int i = 0; i < t1Count; i++) {
                ScoringItem item = d.items.get(i);
                ScoringScore sc = d.scoreMap.get(stu.getStudentId() + "_" + item.getItemId());
                double score = (sc != null && sc.getScore() != null) ? sc.getScore().doubleValue() : 0;
                setNumber(sh, row, t1StartCol + i, score);
                double weight = item.getWeight() == null ? 0 : item.getWeight().doubleValue();
                t1WeightedScore += score * weight;
            }

            // 填充目标2各评分项成绩，并计算加权得分
            double t2WeightedScore = 0;
            for (int i = 0; i < t2Count; i++) {
                ScoringItem item = d.items.get(t1Count + i);
                ScoringScore sc = d.scoreMap.get(stu.getStudentId() + "_" + item.getItemId());
                double score = (sc != null && sc.getScore() != null) ? sc.getScore().doubleValue() : 0;
                setNumber(sh, row, t2StartCol + i, score);
                double weight = item.getWeight() == null ? 0 : item.getWeight().doubleValue();
                t2WeightedScore += score * weight;
            }

            // 目标1达成度 = 加权得分 / 加权满分
            double t1WeightedMax = 0;
            for (int i = 0; i < t1Count; i++) {
                ScoringItem item = d.items.get(i);
                double maxScore = item.getMaxScore() == null ? 100 : item.getMaxScore().doubleValue();
                double weight = item.getWeight() == null ? 0 : item.getWeight().doubleValue();
                t1WeightedMax += maxScore * weight;
            }
            double ach1 = t1WeightedMax > 0 ? t1WeightedScore / t1WeightedMax : 0;
            setNumber(sh, row, ach1Col, ach1);

            // 目标2达成度 = 加权得分 / 加权满分
            double t2WeightedMax = 0;
            for (int i = 0; i < t2Count; i++) {
                ScoringItem item = d.items.get(t1Count + i);
                double maxScore = item.getMaxScore() == null ? 100 : item.getMaxScore().doubleValue();
                double weight = item.getWeight() == null ? 0 : item.getWeight().doubleValue();
                t2WeightedMax += maxScore * weight;
            }
            double ach2 = t2WeightedMax > 0 ? t2WeightedScore / t2WeightedMax : 0;
            setNumber(sh, row, ach2Col, ach2);

            // 平时成绩 = 目标1达成度 × 50
            // 期末成绩 = 目标2达成度 × 50
            // 总成绩 = 平时 + 期末
            double dailyScore = ach1 * 50;
            double finalScore = ach2 * 50;
            double totalScore = dailyScore + finalScore;
            setNumber(sh, row, dailyScoreCol, dailyScore);
            setNumber(sh, row, finalScoreCol, finalScore);
            setNumber(sh, row, totalScoreCol, totalScore);
        }
    }

    private static Row row(Sheet sh, int rowIndex) {
        Row row = sh.getRow(rowIndex);
        return row == null ? sh.createRow(rowIndex) : row;
    }

    private static Cell cell(Sheet sh, int rowIndex, int colIndex) {
        Row row = row(sh, rowIndex);
        Cell cell = row.getCell(colIndex);
        return cell == null ? row.createCell(colIndex) : cell;
    }

    private static void setString(Sheet sh, int row, int col, String value) {
        Cell c = cell(sh, row, col);
        CellStyle originalStyle = c.getCellStyle();
        c.setCellValue(value == null ? "" : value);
        // 保留原始样式
        if (originalStyle != null && originalStyle.getIndex() != 0) {
            c.setCellStyle(originalStyle);
        }
    }

    private static void setNumber(Sheet sh, int row, int col, double value) {
        Cell c = cell(sh, row, col);
        CellStyle originalStyle = c.getCellStyle();
        c.setCellValue(value);
        // 保留原始样式
        if (originalStyle != null && originalStyle.getIndex() != 0) {
            c.setCellStyle(originalStyle);
        }
    }

    private static void setFormula(Sheet sh, int row, int col, String formula) {
        Cell c = cell(sh, row, col);
        CellStyle originalStyle = c.getCellStyle();
        c.setCellFormula(formula);
        // 保留原始样式
        if (originalStyle != null && originalStyle.getIndex() != 0) {
            c.setCellStyle(originalStyle);
        }
    }

    private static void clearCell(Sheet sh, int row, int col) {
        Cell c = cell(sh, row, col);
        // 保存原始样式
        CellStyle originalStyle = c.getCellStyle();
        // 清除值但保留样式
        c.setBlank();
        if (originalStyle != null && originalStyle.getIndex() != 0) {
            c.setCellStyle(originalStyle);
        }
    }

    // ============ 内部数据加载 ============

    private Data loadData(Integer offeringId) {
        Data d = new Data();
        CourseOffering offering = offeringMapper.selectById(offeringId);
        if (offering == null) throw new RuntimeException("开课实例不存在: " + offeringId);
        d.clazzNo = offering.getClazzNo();
        d.semester = offering.getSemester();
        // 从 course + teacher 取名
        var course = courseMapper.selectById(offering.getCourseId());
        d.courseName = course == null ? "" : course.getNameCn();
        if (offering.getTeacherId() != null) {
            var t = teacherService.getById(offering.getTeacherId());
            d.teacherName = t == null ? "" : t.getTeacherName();
        }
        d.gradReqCode = "5.1";

        d.items = itemMapper.selectList(new LambdaQueryWrapper<ScoringItem>()
                .eq(ScoringItem::getOfferingId, offeringId)
                .orderByAsc(ScoringItem::getSortOrder));

        // 学生：优先从班级取，班级无学生则从已同步成绩中反查（与 ScoringScoreServiceImpl 逻辑一致）
        d.students = resolveStudents(offeringId, d.items, offering);
        log.info("加载数据: offeringId={}, 评分项={}, 学生={}", offeringId, d.items.size(), d.students.size());

        // 分数（ScoringScore 没有 offeringId 字段，通过 itemId 过滤）
        List<ScoringScore> scores;
        if (d.items.isEmpty() || d.students.isEmpty()) {
            scores = Collections.emptyList();
        } else {
            List<Integer> itemIds = d.items.stream().map(ScoringItem::getItemId).collect(Collectors.toList());
            List<Integer> stuIds = d.students.stream().map(Student::getStudentId).collect(Collectors.toList());
            scores = scoreMapper.selectList(new LambdaQueryWrapper<ScoringScore>()
                    .in(ScoringScore::getItemId, itemIds)
                    .in(ScoringScore::getStudentId, stuIds));
        }
        d.scoreMap = new HashMap<>();
        for (ScoringScore s : scores) {
            d.scoreMap.put(s.getStudentId() + "_" + s.getItemId(), s);
        }
        log.info("成绩Map大小: {}", d.scoreMap.size());

        // 达成度结果（用于填充"达成度"列）
        OfferingAchievementVO ach = achievementEngine.calcForOffering(offeringId);
        d.achievementByStudent = new HashMap<>();
        if (ach.getStudents() != null) {
            for (var sa : ach.getStudents()) {
                Map<Integer, Double> m = new HashMap<>();
                if (sa.getObjectiveAchievements() != null) {
                    for (var e : sa.getObjectiveAchievements().entrySet()) {
                        m.put(e.getKey(), e.getValue() == null ? 0.0 : e.getValue().doubleValue());
                    }
                }
                d.achievementByStudent.put(sa.getStudentId(), m);
            }
        }
        return d;
    }

    /**
     * 获取学生列表：优先从班级取，班级无学生则从已同步成绩中反查
     * 与 ScoringScoreServiceImpl.resolveStudents 逻辑一致
     */
    private List<Student> resolveStudents(Integer offeringId, List<ScoringItem> items, CourseOffering offering) {
        // 优先从班级取
        if (offering != null && offering.getClazzNo() != null) {
            List<Student> students = studentMapper.selectList(new LambdaQueryWrapper<Student>()
                    .eq(Student::getClazzNo, offering.getClazzNo())
                    .orderByAsc(Student::getStudentNo));
            if (students != null && !students.isEmpty()) {
                return students;
            }
        }
        // 班级无学生，从已同步成绩中反查
        if (items.isEmpty()) {
            return Collections.emptyList();
        }
        List<Integer> itemIds = items.stream().map(ScoringItem::getItemId).collect(Collectors.toList());
        List<ScoringScore> scores = scoreMapper.selectList(new LambdaQueryWrapper<ScoringScore>()
                .in(ScoringScore::getItemId, itemIds));
        if (scores.isEmpty()) {
            return Collections.emptyList();
        }
        Set<Integer> studentIds = scores.stream()
                .map(ScoringScore::getStudentId)
                .filter(Objects::nonNull)
                .collect(Collectors.toSet());
        if (studentIds.isEmpty()) {
            return Collections.emptyList();
        }
        return studentMapper.selectBatchIds(studentIds).stream()
                .sorted(Comparator.comparing(Student::getStudentNo))
                .collect(Collectors.toList());
    }

    private static class Data {
        String courseName, clazzNo, semester, teacherName, gradReqCode;
        List<ScoringItem> items = Collections.emptyList();
        List<Student> students = Collections.emptyList();
        Map<String, ScoringScore> scoreMap = Collections.emptyMap();
        Map<Integer, Map<Integer, Double>> achievementByStudent = Collections.emptyMap();
    }

    // ============ Sheet 0: 分组信息 ============
    private void buildGroupsSheet(XSSFWorkbook wb, Data d) {
        Sheet sh = wb.createSheet("分组信息");
        // 标题
        Row r0 = sh.createRow(0);
        r0.setHeightInPoints(30);
        Cell t0 = r0.createCell(0);
        t0.setCellValue("学生选题表   班级：" + (d.clazzNo == null ? "" : d.clazzNo) + " 班");
        t0.setCellStyle(titleStyle(wb, 16, true));
        sh.addMergedRegion(new CellRangeAddress(0, 0, 0, 7));

        // 表头
        Row r1 = sh.createRow(1);
        r1.setHeightInPoints(20);
        String[] headers = {"组别", "负责人（组长）", "姓名", "性别", "学号", "专业班级", "项目名称", "评分"};
        for (int c = 0; c < headers.length; c++) {
            Cell cell = r1.createCell(c);
            cell.setCellValue(headers[c]);
            cell.setCellStyle(headerStyle(wb, true));
        }
        // 合并表头 A1:A2
        sh.addMergedRegion(new CellRangeAddress(1, 2, 0, 0));

        // 分组：把学生按学生号 hash 分到 9 组（与模板保持 9 组一致）
        int groupCount = 9;
        List<List<Student>> groups = new ArrayList<>();
        for (int i = 0; i < groupCount; i++) groups.add(new ArrayList<>());
        int idx = 0;
        for (Student s : d.students) {
            groups.get(idx % groupCount).add(s);
            idx++;
        }
        int rowIdx = 3;
        for (int g = 0; g < groupCount; g++) {
            List<Student> mems = groups.get(g);
            int firstRow = rowIdx;
            Cell groupCell = sh.createRow(rowIdx).createCell(0);
            groupCell.setCellValue((g + 1) + "组");
            groupCell.setCellStyle(groupHeaderStyle(wb));
            for (int k = 0; k < 7; k++) {
                Cell c = sh.getRow(rowIdx).createCell(k + 1);
                c.setCellStyle(bodyStyle(wb, false));
            }
            if (mems.isEmpty()) {
                rowIdx += 4; // 空组也保留 4 行高度
                continue;
            }
            for (int k = 0; k < mems.size(); k++) {
                Student s = mems.get(k);
                if (k > 0) {
                    Row rk = sh.createRow(rowIdx);
                    rk.setHeightInPoints(20);
                    for (int cc = 0; cc < 8; cc++) {
                        rk.createCell(cc).setCellStyle(bodyStyle(wb, k == mems.size() - 1));
                    }
                }
                Row row = sh.getRow(rowIdx);
                if (k == 0) row.getCell(1).setCellValue("");  // 负责人签名行
                row.getCell(2).setCellValue(s.getStudentName() == null ? "" : s.getStudentName());
                row.getCell(3).setCellValue("");
                row.getCell(4).setCellValue(s.getStudentNo() == null ? "" : s.getStudentNo());
                row.getCell(5).setCellValue(d.clazzNo == null ? "" : d.clazzNo);
                row.getCell(6).setCellValue("");  // 项目名称留空
                row.getCell(7).setCellValue("");  // 评分留空
                rowIdx++;
            }
            // 合并 A 列（组名）跨 N 行
            sh.addMergedRegion(new CellRangeAddress(firstRow, rowIdx - 1, 0, 0));
            // 合并 B 列（负责人）跨 N 行
            sh.addMergedRegion(new CellRangeAddress(firstRow, rowIdx - 1, 1, 1));
        }

        // 设置列宽
        int[] widths = {8, 16, 12, 8, 14, 14, 28, 10};
        for (int i = 0; i < widths.length; i++) sh.setColumnWidth(i, widths[i] * 256);
    }

    // ============ Sheet 1: 成绩明细表 ============
    private void buildDetailSheet(XSSFWorkbook wb, Data d) {
        Sheet sh = wb.createSheet("成绩明细表");

        // 模板：1 个目标 = 8 项 + 达成度；2 个目标 = 4 + 4 + 2达成度
        // 简化：把 items 强制分到 2 个目标（前半=目标1，后半=目标2），不足补"作业"占位
        int total = 8;
        int t1Count = 4, t2Count = 4;
        int t1Start = 0;            // items 索引起点
        int t1End = Math.min(t1Count, d.items.size());   // 目标1 包含的 item 数
        int t2Start = t1End;
        int t2End = Math.min(t2Start + t2Count, d.items.size());

        // 大标题
        Row r0 = sh.createRow(0);
        r0.setHeightInPoints(30);
        Cell t0 = r0.createCell(0);
        t0.setCellValue("南昌航空大学学生课程目标达成度计算表");
        t0.setCellStyle(titleStyle(wb, 18, true));
        // 合并 A0:U0 (21 列：A=序号到 U=总成绩)
        sh.addMergedRegion(new CellRangeAddress(0, 0, 0, 20));

        // 元信息行
        Row r1 = sh.createRow(1);
        r1.setHeightInPoints(20);
        Cell t1 = r1.createCell(0);
        t1.setCellValue("开课学期：" + (d.semester == null ? "" : d.semester)
                + "   课程：" + (d.courseName == null ? "" : d.courseName)
                + "  教师：" + (d.teacherName == null ? "" : d.teacherName)
                + "     班级：" + (d.clazzNo == null ? "" : d.clazzNo));
        t1.setCellStyle(metaStyle(wb));
        sh.addMergedRegion(new CellRangeAddress(1, 1, 0, 20));

        // ============ 3 行表头（Row 2/3/4）============
        // 目标 1 列范围: D..K (4列在 Row 4 实际 8 列：作业1-5 + 实验1-3 = 8 项)
        // 目标 2 列范围: M..Q
        // 达成度: L (目标1), R (目标2)
        // 平时成绩 S、期末成绩 T、总成绩 U
        // 序号 A、学号 B、姓名 C

        // 4 列标题行（根据模板，行2-4 都是表头）
        // 行 2: 序号 | 学号 | 姓名 | 毕业要求N.M(跨D2:R2) | 平时成绩(50%)(跨S2:U2含T2? 看模板)
        // 实际模板: Row2 平时成绩(s2)、期末成绩(t2)、总成绩(u2)
        // Row 2 实际列: A=序号, B=学号, C=姓名, D=毕业要求5.1(合并D2:R2), S=平时成绩(50%), T=期末成绩(50%), U=总成绩
        // Row 3: D3=课程目标1(合并D3:K3), M3=课程目标2(合并M3:Q3), L3=达成度（属于目标1?）, R3 留空
        // Row 4: 作业1-5(D-H), 实验1-3(I-K), L=达成度, 实验4(M), 大作业1-4(N-Q), R=达成度

        Row r2 = sh.createRow(2);
        r2.setHeightInPoints(20);
        Row r3 = sh.createRow(3);
        r3.setHeightInPoints(20);
        Row r4 = sh.createRow(4);
        r4.setHeightInPoints(20);

        // 行 2
        cell(r2, 0, "序号", headerStyle(wb, true));
        cell(r2, 1, "学号", headerStyle(wb, true));
        cell(r2, 2, "姓名", headerStyle(wb, true));
        // 毕业要求 N.M 跨 D2:R2
        cell(r2, 3, "毕业要求" + (d.gradReqCode == null ? "" : d.gradReqCode), headerStyle(wb, true));
        cell(r2, 18, "平时成绩（占总成绩的50%）", headerStyle(wb, true));
        cell(r2, 19, "期末成绩（占总成绩的50%）", headerStyle(wb, true));
        cell(r2, 20, "总成绩", headerStyle(wb, true));
        // 合并
        sh.addMergedRegion(new CellRangeAddress(2, 2, 3, 17));   // 毕业要求 跨 D2:R2
        sh.addMergedRegion(new CellRangeAddress(1, 1, 0, 20));   // meta 行
        sh.addMergedRegion(new CellRangeAddress(2, 4, 0, 0));    // 序号 跨 3 行
        sh.addMergedRegion(new CellRangeAddress(2, 4, 1, 1));    // 学号 跨 3 行
        sh.addMergedRegion(new CellRangeAddress(2, 4, 2, 2));    // 姓名 跨 3 行

        // 行 3
        cell(r3, 3, "课程目标1", headerStyle(wb, true));
        cell(r3, 12, "课程目标2", headerStyle(wb, true));
        cell(r3, 11, "达成度", headerStyle(wb, true));
        cell(r3, 17, "达成度", headerStyle(wb, true));
        sh.addMergedRegion(new CellRangeAddress(3, 3, 3, 10));   // 课程目标1 跨 D3:K3
        sh.addMergedRegion(new CellRangeAddress(3, 3, 12, 16));  // 课程目标2 跨 M3:Q3
        sh.addMergedRegion(new CellRangeAddress(2, 3, 11, 11));  // 达成度(目标1) 跨 D2-L3
        sh.addMergedRegion(new CellRangeAddress(2, 3, 17, 17));  // 达成度(目标2) 跨 M2-R3

        // 行 4: 评分项名
        // 目标1 占 D-K = 8 项，4 项是作业，3 项是实验，最后 1 列是达成度
        // 目标2 占 M-Q = 5 项，1 项是实验，4 项是大作业，最后 1 列是达成度
        // 由于我们的 items 数量不一定为 8 + 5，这里用通用列名
        int t1ColStart = 3;   // D
        int t1ColEnd = 10;    // K (8 个评分项)
        int ach1Col = 11;     // L
        int t2ColStart = 12;  // M
        int t2ColEnd = 16;    // Q (5 个评分项)
        int ach2Col = 17;     // R
        // 实际 D-K 共 8 列，从 D=3 到 K=10
        for (int i = 0; i < 8; i++) {
            int idx1 = t1Start + i;
            String name = idx1 < d.items.size() ? d.items.get(idx1).getName() : ("项" + (i + 1));
            cell(r4, t1ColStart + i, name, headerStyle(wb, true));
        }
        cell(r4, ach1Col, "达成度", headerStyle(wb, true));
        for (int i = 0; i < 5; i++) {
            int idx2 = t2Start + i;
            String name = idx2 < d.items.size() ? d.items.get(idx2).getName() : ("项" + (i + 1));
            cell(r4, t2ColStart + i, name, headerStyle(wb, true));
        }
        cell(r4, ach2Col, "达成度", headerStyle(wb, true));

        // ============ 满分分值行 (Row 5) ============
        Row r5 = sh.createRow(5);
        r5.setHeightInPoints(20);
        cell(r5, 0, "满分分值", labelStyle(wb, true));
        for (int c = t1ColStart; c <= ach1Col; c++) {
            // 达成度列满分 = 1.0
            double v = (c == ach1Col || c == ach2Col) ? 1.0 : 100.0;
            cell(r5, c, v, numStyle(wb));
        }
        for (int c = t2ColStart; c <= ach2Col; c++) {
            double v = (c == ach2Col) ? 1.0 : 100.0;
            cell(r5, c, v, numStyle(wb));
        }
        cell(r5, 18, 100.0, numStyle(wb));
        cell(r5, 19, 100.0, numStyle(wb));
        cell(r5, 20, 100.0, numStyle(wb));

        // ============ 达成及格的期望分值行 (Row 6) ============
        Row r6 = sh.createRow(6);
        r6.setHeightInPoints(20);
        cell(r6, 0, "达成及格的期望分值", labelStyle(wb, true));
        for (int c = t1ColStart; c <= ach1Col; c++) {
            // 达成度列期望 = 期望达成度（默认 0.7）
            double v = (c == ach1Col || c == ach2Col) ? 0.7 : 70.0;
            cell(r6, c, v, numStyle(wb));
        }
        for (int c = t2ColStart; c <= ach2Col; c++) {
            double v = (c == ach2Col) ? 0.7 : 70.0;
            cell(r6, c, v, numStyle(wb));
        }
        cell(r6, 18, 60.0, numStyle(wb));
        cell(r6, 19, 60.0, numStyle(wb));
        cell(r6, 20, 60.0, numStyle(wb));

        // ============ 权重行 (Row 7) — 含 SUM 公式 ============
        Row r7 = sh.createRow(7);
        r7.setHeightInPoints(20);
        cell(r7, 0, "权重", labelStyle(wb, true));
        // 前 8 项按 item.weight，没有则均分；达成度列=SUM
        double t1WeightSum = 0, t2WeightSum = 0;
        for (int i = 0; i < 8; i++) {
            int idx1 = t1Start + i;
            double w = (idx1 < d.items.size() && d.items.get(idx1).getWeight() != null)
                    ? d.items.get(idx1).getWeight().doubleValue() : 0.125;
            t1WeightSum += w;
            cell(r7, t1ColStart + i, w, numStyle(wb));
        }
        // 达成度 1: =SUM(D8:K8) — 注意 POI 行号是 1-based，模板 0-based 8 = 1-based 8（POI 7 = 模板 Row 7）
        // 我们这里的 r7 相当于模板 Row 7，所以公式应该是 =SUM(D7:K7)
        String fAch1 = "SUM(D" + (7 + 1) + ":K" + (7 + 1) + ")";
        cell(r7, ach1Col, fAch1, formulaStyle(wb));
        for (int i = 0; i < 5; i++) {
            int idx2 = t2Start + i;
            double w = (idx2 < d.items.size() && d.items.get(idx2).getWeight() != null)
                    ? d.items.get(idx2).getWeight().doubleValue() : 0.1;
            t2WeightSum += w;
            cell(r7, t2ColStart + i, w, numStyle(wb));
        }
        String fAch2 = "SUM(M" + (7 + 1) + ":Q" + (7 + 1) + ")";
        cell(r7, ach2Col, fAch2, formulaStyle(wb));
        // 平时 0.5, 期末 0.5, 总 = 1
        cell(r7, 18, 0.5, numStyle(wb));
        cell(r7, 19, 0.5, numStyle(wb));
        cell(r7, 20, 1.0, numStyle(wb));

        // ============ 加权分值行 (Row 8) — 含 item 公式 ============
        Row r8 = sh.createRow(8);
        r8.setHeightInPoints(20);
        cell(r8, 0, "加权分值", labelStyle(wb, true));
        for (int c = t1ColStart; c <= t1ColEnd; c++) {
            String col = excelCol(c);
            // = 满分(c-1) * 权重(c-1)  // 0-based
            String f = col + (6 + 1) + "*" + col + (7 + 1);
            cell(r8, c, f, formulaStyle(wb));
        }
        // 达成度 1: 满分L * 权重L
        cell(r8, ach1Col, "L" + (6 + 1) + "*L" + (7 + 1), formulaStyle(wb));
        for (int c = t2ColStart; c <= t2ColEnd; c++) {
            String col = excelCol(c);
            String f = col + (6 + 1) + "*" + col + (7 + 1);
            cell(r8, c, f, formulaStyle(wb));
        }
        cell(r8, ach2Col, "R" + (6 + 1) + "*R" + (7 + 1), formulaStyle(wb));
        cell(r8, 18, 50.0, numStyle(wb));
        cell(r8, 19, 50.0, numStyle(wb));
        cell(r8, 20, 100.0, numStyle(wb));

        // ============ 学生数据行 (Row 9..) ============
        int dataStart = 9;
        for (int s = 0; s < d.students.size(); s++) {
            Student stu = d.students.get(s);
            Row row = sh.createRow(dataStart + s);
            row.setHeightInPoints(20);
            cell(row, 0, (double) (s + 1), numStyle(wb));
            cell(row, 1, stu.getStudentNo() == null ? "" : stu.getStudentNo(), bodyStyle(wb, false));
            cell(row, 2, stu.getStudentName() == null ? "" : stu.getStudentName(), bodyStyle(wb, false));
            // 目标 1 的 8 项分数
            for (int i = 0; i < 8; i++) {
                int idx1 = t1Start + i;
                int col = t1ColStart + i;
                if (idx1 < d.items.size()) {
                    ScoringScore sc = d.scoreMap.get(stu.getStudentId() + "_" + d.items.get(idx1).getItemId());
                    java.math.BigDecimal v = sc == null ? null : sc.getScore();
                    if (v == null) cell(row, col, "", bodyStyle(wb, false));
                    else cell(row, col, v.doubleValue(), numStyle(wb));
                } else {
                    cell(row, col, "", bodyStyle(wb, false));
                }
            }
            // 达成度 1：从 achievementByStudent 取第 1 个目标的达成度
            double ach1 = 0.0;
            Map<Integer, Double> sMap1 = d.achievementByStudent.get(stu.getStudentId());
            if (sMap1 != null && !sMap1.isEmpty()) {
                ach1 = sMap1.values().iterator().next();
            }
            cell(row, ach1Col, ach1, numStyle(wb));

            for (int i = 0; i < 5; i++) {
                int idx2 = t2Start + i;
                int col = t2ColStart + i;
                if (idx2 < d.items.size()) {
                    ScoringScore sc = d.scoreMap.get(stu.getStudentId() + "_" + d.items.get(idx2).getItemId());
                    java.math.BigDecimal v = sc == null ? null : sc.getScore();
                    if (v == null) cell(row, col, "", bodyStyle(wb, false));
                    else cell(row, col, v.doubleValue(), numStyle(wb));
                } else {
                    cell(row, col, "", bodyStyle(wb, false));
                }
            }
            // 达成度 2：从 achievementByStudent 取第 2 个目标的达成度
            double ach2 = 0.0;
            Map<Integer, Double> sMap2 = d.achievementByStudent.get(stu.getStudentId());
            if (sMap2 != null && sMap2.size() > 1) {
                ach2 = new ArrayList<>(sMap2.values()).get(1);
            } else if (sMap2 != null && !sMap2.isEmpty()) {
                ach2 = sMap2.values().iterator().next();
            }
            cell(row, ach2Col, ach2, numStyle(wb));

            // 平时/期末/总成绩：当前项目暂未提供，置空
            cell(row, 18, "", bodyStyle(wb, false));
            cell(row, 19, "", bodyStyle(wb, false));
            cell(row, 20, "", bodyStyle(wb, false));
        }

        // 列宽
        int[] widths = {6, 12, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 14, 14, 10};
        for (int i = 0; i < widths.length; i++) sh.setColumnWidth(i, widths[i] * 256);
        sh.setDefaultRowHeightInPoints(20);
    }

    // ============ 样式 ============

    private static CellStyle titleStyle(XSSFWorkbook wb, int size, boolean bold) {
        CellStyle s = wb.createCellStyle();
        s.setAlignment(HorizontalAlignment.CENTER);
        s.setVerticalAlignment(VerticalAlignment.CENTER);
        Font f = wb.createFont();
        f.setFontName("SimSun");
        f.setFontHeightInPoints((short) size);
        f.setBold(bold);
        s.setFont(f);
        return s;
    }
    private static CellStyle metaStyle(XSSFWorkbook wb) {
        CellStyle s = wb.createCellStyle();
        s.setAlignment(HorizontalAlignment.LEFT);
        s.setVerticalAlignment(VerticalAlignment.CENTER);
        Font f = wb.createFont();
        f.setFontName("SimSun");
        f.setFontHeightInPoints((short) 11);
        s.setFont(f);
        return s;
    }
    private static CellStyle headerStyle(XSSFWorkbook wb, boolean bold) {
        CellStyle s = wb.createCellStyle();
        s.setAlignment(HorizontalAlignment.CENTER);
        s.setVerticalAlignment(VerticalAlignment.CENTER);
        s.setWrapText(true);
        s.setBorderTop(BorderStyle.THIN);
        s.setBorderBottom(BorderStyle.THIN);
        s.setBorderLeft(BorderStyle.THIN);
        s.setBorderRight(BorderStyle.THIN);
        s.setFillForegroundColor(IndexedColors.LIGHT_CORNFLOWER_BLUE.getIndex());
        s.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        Font f = wb.createFont();
        f.setFontName("SimSun");
        f.setFontHeightInPoints((short) 11);
        f.setBold(bold);
        s.setFont(f);
        return s;
    }
    private static CellStyle labelStyle(XSSFWorkbook wb, boolean bold) {
        CellStyle s = wb.createCellStyle();
        s.setAlignment(HorizontalAlignment.CENTER);
        s.setVerticalAlignment(VerticalAlignment.CENTER);
        s.setBorderTop(BorderStyle.THIN);
        s.setBorderBottom(BorderStyle.THIN);
        s.setBorderLeft(BorderStyle.THIN);
        s.setBorderRight(BorderStyle.THIN);
        s.setFillForegroundColor(IndexedColors.PALE_BLUE.getIndex());
        s.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        Font f = wb.createFont();
        f.setFontName("SimSun");
        f.setFontHeightInPoints((short) 11);
        f.setBold(bold);
        s.setFont(f);
        return s;
    }
    private static CellStyle groupHeaderStyle(XSSFWorkbook wb) {
        CellStyle s = wb.createCellStyle();
        s.setAlignment(HorizontalAlignment.CENTER);
        s.setVerticalAlignment(VerticalAlignment.CENTER);
        s.setBorderTop(BorderStyle.THIN);
        s.setBorderBottom(BorderStyle.THIN);
        s.setBorderLeft(BorderStyle.THIN);
        s.setBorderRight(BorderStyle.THIN);
        s.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.getIndex());
        s.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        Font f = wb.createFont();
        f.setFontName("SimSun");
        f.setFontHeightInPoints((short) 11);
        f.setBold(true);
        s.setFont(f);
        return s;
    }
    private static CellStyle bodyStyle(XSSFWorkbook wb, boolean bottomBorder) {
        CellStyle s = wb.createCellStyle();
        s.setAlignment(HorizontalAlignment.CENTER);
        s.setVerticalAlignment(VerticalAlignment.CENTER);
        s.setBorderTop(BorderStyle.THIN);
        s.setBorderBottom(bottomBorder ? BorderStyle.THIN : BorderStyle.NONE);
        s.setBorderLeft(BorderStyle.THIN);
        s.setBorderRight(BorderStyle.THIN);
        Font f = wb.createFont();
        f.setFontName("SimSun");
        f.setFontHeightInPoints((short) 11);
        s.setFont(f);
        return s;
    }
    private static CellStyle numStyle(XSSFWorkbook wb) {
        CellStyle s = bodyStyle(wb, true);
        s.setDataFormat(wb.createDataFormat().getFormat("0.0000"));
        return s;
    }
    private static CellStyle formulaStyle(XSSFWorkbook wb) {
        CellStyle s = bodyStyle(wb, true);
        s.setDataFormat(wb.createDataFormat().getFormat("0.0000"));
        return s;
    }

    // ============ Helpers ============

    private static void cell(Row row, int col, String v, CellStyle style) {
        Cell c = row.createCell(col);
        c.setCellValue(v == null ? "" : v);
        c.setCellStyle(style);
    }
    private static void cell(Row row, int col, double v, CellStyle style) {
        Cell c = row.createCell(col);
        c.setCellValue(v);
        c.setCellStyle(style);
    }
    private static void cell(Row row, int col, String formula, boolean isFormula, CellStyle style) {
        Cell c = row.createCell(col);
        if (isFormula) c.setCellFormula(formula);
        else c.setCellValue(formula);
        c.setCellStyle(style);
    }
    private static String excelCol(int c) {
        StringBuilder s = new StringBuilder();
        c++;
        while (c > 0) {
            c--;
            s.insert(0, (char) ('A' + c % 26));
            c /= 26;
        }
        return s.toString();
    }
}
