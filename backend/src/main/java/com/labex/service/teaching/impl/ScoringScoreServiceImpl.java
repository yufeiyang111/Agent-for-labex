package com.labex.service.teaching.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.Student;
import com.labex.entity.teaching.CourseOffering;
import com.labex.entity.teaching.ScoringItem;
import com.labex.entity.teaching.ScoringItemObjective;
import com.labex.entity.teaching.ScoringScore;
import com.labex.mapper.teaching.CourseOfferingMapper;
import com.labex.mapper.teaching.ScoringItemMapper;
import com.labex.mapper.teaching.ScoringItemObjectiveMapper;
import com.labex.mapper.teaching.ScoringScoreMapper;
import com.labex.service.StudentService;
import com.labex.service.teaching.ScoringScoreService;
import com.labex.vo.teaching.ScoreMatrixVO;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

@Service
@Slf4j
public class ScoringScoreServiceImpl extends ServiceImpl<ScoringScoreMapper, ScoringScore>
        implements ScoringScoreService {

    @Autowired
    private ScoringItemMapper itemMapper;

    @Autowired
    private ScoringItemObjectiveMapper linkMapper;

    @Autowired
    private CourseOfferingMapper offeringMapper;

    @Autowired
    private StudentService studentService;

    @Override
    @Transactional
    public ScoringScore enterScore(Integer itemId, Integer studentId, BigDecimal score, Integer teacherId) {
        ScoringScore existing = getOne(new LambdaQueryWrapper<ScoringScore>()
                .eq(ScoringScore::getItemId, itemId)
                .eq(ScoringScore::getStudentId, studentId));
        if (existing != null) {
            existing.setScore(score);
            existing.setSource("manual");
            existing.setGradedBy(teacherId);
            updateById(existing);
            return existing;
        }
        ScoringScore ss = new ScoringScore();
        ss.setItemId(itemId);
        ss.setStudentId(studentId);
        ss.setScore(score);
        ss.setSource("manual");
        ss.setGradedBy(teacherId);
        save(ss);
        return ss;
    }

    @Override
    @Transactional
    public int batchEnter(Integer itemId, List<ScoringScore> scores, Integer teacherId) {
        int n = 0;
        for (ScoringScore s : scores) {
            s.setItemId(itemId);
            s.setGradedBy(teacherId);
            if (s.getSource() == null) {
                s.setSource("manual");
            }
            enterScore(itemId, s.getStudentId(), s.getScore(), teacherId);
            n++;
        }
        return n;
    }

    @Override
    @Transactional
    public int saveMatrix(Integer offeringId, ScoreMatrixVO matrix, Integer teacherId) {
        int total = 0;
        if (matrix == null || matrix.getStudents() == null) {
            return 0;
        }
        for (ScoreMatrixVO.StudentRow row : matrix.getStudents()) {
            if (row.getScores() == null) continue;
            for (Map.Entry<Integer, BigDecimal> e : row.getScores().entrySet()) {
                enterScore(e.getKey(), row.getStudentId(), e.getValue(), teacherId);
                total++;
            }
        }
        return total;
    }

    @Override
    public ScoreMatrixVO getMatrix(Integer offeringId) {
        ScoreMatrixVO matrix = new ScoreMatrixVO();

        // 1. 取所有评分项
        List<ScoringItem> items = itemMapper.selectList(new LambdaQueryWrapper<ScoringItem>()
                .eq(ScoringItem::getOfferingId, offeringId)
                .orderByAsc(ScoringItem::getSortOrder)
                .orderByAsc(ScoringItem::getItemId));

        // 1.1 评分项 → 目标
        Map<Integer, List<Integer>> itemObjs = new HashMap<>();
        if (!items.isEmpty()) {
            List<Integer> itemIds = items.stream().map(ScoringItem::getItemId).collect(Collectors.toList());
            List<ScoringItemObjective> links = linkMapper.selectList(
                    new LambdaQueryWrapper<ScoringItemObjective>().in(ScoringItemObjective::getItemId, itemIds));
            for (ScoringItemObjective l : links) {
                itemObjs.computeIfAbsent(l.getItemId(), k -> new ArrayList<>()).add(l.getObjectiveId());
            }
        }

        matrix.setItems(items.stream().map(i -> {
            ScoreMatrixVO.ItemHeader h = new ScoreMatrixVO.ItemHeader();
            h.setItemId(i.getItemId());
            h.setName(i.getName());
            h.setType(i.getType());
            h.setMaxScore(i.getMaxScore());
            h.setPassingScore(i.getPassingScore());
            h.setWeight(i.getWeight());
            h.setSortOrder(i.getSortOrder());
            h.setObjectiveIds(itemObjs.getOrDefault(i.getItemId(), Collections.emptyList()));
            return h;
        }).collect(Collectors.toList()));

        // 2. 取该 offering 所属班级的学生
        CourseOffering offering = offeringMapper.selectById(offeringId);
        List<Student> students;
        if (offering != null && offering.getClazzNo() != null) {
            students = studentService.list(new LambdaQueryWrapper<Student>()
                    .eq(Student::getClazzNo, offering.getClazzNo())
                    .orderByAsc(Student::getStudentNo));
        } else {
            students = Collections.emptyList();
        }

        // 3. 取所有成绩
        Map<Integer, Map<Integer, BigDecimal>> scoreMap = new HashMap<>();
        if (!items.isEmpty() && !students.isEmpty()) {
            List<Integer> itemIds = items.stream().map(ScoringItem::getItemId).collect(Collectors.toList());
            List<Integer> stuIds = students.stream().map(Student::getStudentId).collect(Collectors.toList());
            List<ScoringScore> scores = list(new LambdaQueryWrapper<ScoringScore>()
                    .in(ScoringScore::getItemId, itemIds)
                    .in(ScoringScore::getStudentId, stuIds));
            for (ScoringScore s : scores) {
                scoreMap.computeIfAbsent(s.getStudentId(), k -> new HashMap<>())
                        .put(s.getItemId(), s.getScore());
            }
        }

        matrix.setStudents(students.stream().map(stu -> {
            ScoreMatrixVO.StudentRow row = new ScoreMatrixVO.StudentRow();
            row.setStudentId(stu.getStudentId());
            row.setStudentNo(stu.getStudentNo());
            row.setStudentName(stu.getStudentName());
            row.setScores(scoreMap.getOrDefault(stu.getStudentId(), new HashMap<>()));
            return row;
        }).collect(Collectors.toList()));

        return matrix;
    }

    @Override
    public byte[] exportTemplate(Integer offeringId) {
        ScoreMatrixVO matrix = getMatrix(offeringId);
        try (Workbook wb = new XSSFWorkbook(); ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            Sheet sheet = wb.createSheet("成绩明细表");
            CellStyle headerStyle = wb.createCellStyle();
            Font headerFont = wb.createFont();
            headerFont.setBold(true);
            headerStyle.setFont(headerFont);
            headerStyle.setAlignment(HorizontalAlignment.CENTER);

            // Row 0: 表头
            Row header = sheet.createRow(0);
            String[] fixed = {"序号", "学号", "姓名"};
            for (int i = 0; i < fixed.length; i++) {
                Cell c = header.createCell(i);
                c.setCellValue(fixed[i]);
                c.setCellStyle(headerStyle);
            }
            for (int i = 0; i < matrix.getItems().size(); i++) {
                Cell c = header.createCell(fixed.length + i);
                ScoreMatrixVO.ItemHeader h = matrix.getItems().get(i);
                c.setCellValue(h.getName() + "(满分" + h.getMaxScore() + ",权重" + h.getWeight() + ")");
                c.setCellStyle(headerStyle);
            }

            // Row 1: 满分（元信息）
            Row maxRow = sheet.createRow(1);
            maxRow.createCell(0).setCellValue("满分");
            for (int i = 0; i < matrix.getItems().size(); i++) {
                maxRow.createCell(fixed.length + i).setCellValue(matrix.getItems().get(i).getMaxScore());
            }

            // Row 2: 期望及格分
            Row passRow = sheet.createRow(2);
            passRow.createCell(0).setCellValue("达成期望分");
            for (int i = 0; i < matrix.getItems().size(); i++) {
                passRow.createCell(fixed.length + i).setCellValue(matrix.getItems().get(i).getPassingScore());
            }

            // Row 3: 权重
            Row weightRow = sheet.createRow(3);
            weightRow.createCell(0).setCellValue("权重");
            for (int i = 0; i < matrix.getItems().size(); i++) {
                BigDecimal w = matrix.getItems().get(i).getWeight();
                weightRow.createCell(fixed.length + i).setCellValue(w == null ? 0 : w.doubleValue());
            }

            // Row 4+: 学生行
            int rowNum = 4;
            int idx = 1;
            for (ScoreMatrixVO.StudentRow stu : matrix.getStudents()) {
                Row r = sheet.createRow(rowNum++);
                r.createCell(0).setCellValue(idx++);
                r.createCell(1).setCellValue(stu.getStudentNo());
                r.createCell(2).setCellValue(stu.getStudentName());
                for (int i = 0; i < matrix.getItems().size(); i++) {
                    BigDecimal score = stu.getScores().get(matrix.getItems().get(i).getItemId());
                    if (score != null) {
                        r.createCell(fixed.length + i).setCellValue(score.doubleValue());
                    } else {
                        r.createCell(fixed.length + i);
                    }
                }
            }

            for (int i = 0; i < fixed.length + matrix.getItems().size(); i++) {
                sheet.autoSizeColumn(i);
            }

            wb.write(out);
            return out.toByteArray();
        } catch (IOException e) {
            log.error("Excel 模板生成失败", e);
            throw new RuntimeException("Excel 模板生成失败: " + e.getMessage(), e);
        }
    }

    @Override
    @Transactional
    public int importFromExcel(Integer offeringId, MultipartFile file, Integer teacherId) {
        List<ScoringItem> items = itemMapper.selectList(new LambdaQueryWrapper<ScoringItem>()
                .eq(ScoringItem::getOfferingId, offeringId)
                .orderByAsc(ScoringItem::getSortOrder)
                .orderByAsc(ScoringItem::getItemId));
        if (items.isEmpty()) {
            throw new RuntimeException("该开课无评分项，请先配置评分项");
        }

        CourseOffering offering = offeringMapper.selectById(offeringId);
        if (offering == null) {
            throw new RuntimeException("开课不存在");
        }
        List<Student> students = studentService.list(new LambdaQueryWrapper<Student>()
                .eq(Student::getClazzNo, offering.getClazzNo()));
        Map<String, Integer> noToId = students.stream()
                .collect(Collectors.toMap(Student::getStudentNo, Student::getStudentId, (a, b) -> a));

        int count = 0;
        try (InputStream is = file.getInputStream(); Workbook wb = WorkbookFactory.create(is)) {
            Sheet sheet = wb.getSheetAt(0);
            // 默认从第 5 行（index=4）开始读，模板有 4 行元信息
            int startRow = 4;
            int fixedCols = 3;  // 序号、学号、姓名
            // 列对应评分项（按 sortOrder 顺序）
            for (int rowIdx = startRow; rowIdx <= sheet.getLastRowNum(); rowIdx++) {
                Row row = sheet.getRow(rowIdx);
                if (row == null) continue;
                Cell noCell = row.getCell(1);
                if (noCell == null) continue;
                String studentNo = getCellStringValue(noCell);
                if (studentNo == null || studentNo.isBlank()) continue;
                Integer stuId = noToId.get(studentNo);
                if (stuId == null) {
                    log.warn("Excel 导入：学号 {} 不在班级 {}, 跳过", studentNo, offering.getClazzNo());
                    continue;
                }
                for (int i = 0; i < items.size(); i++) {
                    Cell scoreCell = row.getCell(fixedCols + i);
                    if (scoreCell == null) continue;
                    Double v = getCellNumericValue(scoreCell);
                    if (v == null) continue;
                    enterScore(items.get(i).getItemId(), stuId, BigDecimal.valueOf(v), teacherId);
                    count++;
                }
            }
            log.info("Excel 导入：offering={}, total scores={}", offeringId, count);
            return count;
        } catch (IOException e) {
            log.error("Excel 导入失败", e);
            throw new RuntimeException("Excel 导入失败: " + e.getMessage(), e);
        }
    }

    @Override
    public List<ScoringScore> listByItem(Integer itemId) {
        return list(new LambdaQueryWrapper<ScoringScore>().eq(ScoringScore::getItemId, itemId));
    }

    private String getCellStringValue(Cell cell) {
        if (cell == null) return null;
        return switch (cell.getCellType()) {
            case STRING -> cell.getStringCellValue().trim();
            case NUMERIC -> String.valueOf((long) cell.getNumericCellValue());
            case FORMULA -> {
                try {
                    yield cell.getStringCellValue().trim();
                } catch (Exception e) {
                    yield String.valueOf(cell.getNumericCellValue());
                }
            }
            default -> null;
        };
    }

    private Double getCellNumericValue(Cell cell) {
        if (cell == null) return null;
        return switch (cell.getCellType()) {
            case NUMERIC -> cell.getNumericCellValue();
            case STRING -> {
                try {
                    yield Double.parseDouble(cell.getStringCellValue().trim());
                } catch (NumberFormatException e) {
                    yield null;
                }
            }
            case FORMULA -> {
                try {
                    yield cell.getNumericCellValue();
                } catch (Exception e) {
                    yield null;
                }
            }
            default -> null;
        };
    }
}
