package com.labex.controller.teaching;

import com.labex.common.Result;
import com.labex.service.teaching.export.GradeDetailExcelGenerator;
import com.labex.service.teaching.export.QualityCompendiumPdfGeneratorV2;
import com.labex.service.teaching.export.SyllabusPdfGenerator;
import com.labex.vo.teaching.GradeDetailMatrixVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

/**
 * 文档导出（预览/下载）控制器（CTL-Export）
 * 预览 = inline 流；下载 = attachment 流
 */
@RestController
@RequestMapping("/teacher/export")
@PreAuthorize("hasRole('TEACHER') or hasRole('ADMIN')")
@Slf4j
public class DocumentExportController {

    @Autowired private SyllabusPdfGenerator syllabusGen;
    @Autowired private GradeDetailExcelGenerator gradeDetailGen;
    @Autowired private QualityCompendiumPdfGeneratorV2 compendiumGen;

    // ============ 课程大纲 PDF ============

    @GetMapping("/syllabus/preview")
    public ResponseEntity<byte[]> previewSyllabus(@RequestParam Integer courseId) {
        try {
            byte[] bytes = syllabusGen.generate(courseId);
            return pdfResponse(bytes, "课程大纲.pdf", true);
        } catch (Exception e) {
            log.error("生成课程大纲PDF失败: courseId={}", courseId, e);
            throw new RuntimeException("生成课程大纲PDF失败: " + e.getMessage(), e);
        }
    }

    @GetMapping("/syllabus/download")
    public ResponseEntity<byte[]> downloadSyllabus(@RequestParam Integer courseId) {
        byte[] bytes = syllabusGen.generate(courseId);
        return pdfResponse(bytes, "课程大纲.pdf", false);
    }

    // ============ 成绩明细 Excel ============

    /** JSON 预览（前端用 el-table 展示） */
    @GetMapping("/grade-detail/preview-json")
    public Result<GradeDetailMatrixVO> previewGradeDetailJson(@RequestParam Integer offeringId) {
        return Result.success(gradeDetailGen.buildMatrix(offeringId));
    }

    @GetMapping("/grade-detail/download")
    public ResponseEntity<byte[]> downloadGradeDetail(@RequestParam Integer offeringId) {
        byte[] bytes = gradeDetailGen.generate(offeringId);
        return xlsxResponse(bytes, "课程分组及成绩明细表.xlsx");
    }

    // ============ 质量评价资料汇编 PDF ============

    @GetMapping("/quality-compendium/preview")
    public ResponseEntity<byte[]> previewCompendium(@RequestParam Integer offeringId,
                                                     @RequestParam(required = false) Integer evaluationId) {
        try {
            log.info("开始生成质量评价汇编PDF: offeringId={}, evaluationId={}", offeringId, evaluationId);
            byte[] bytes = compendiumGen.generate(offeringId, evaluationId);
            log.info("质量评价汇编PDF生成成功: size={}bytes", bytes.length);
            return pdfResponse(bytes, "课程质量评价资料汇编.pdf", true);
        } catch (Exception e) {
            log.error("生成质量评价汇编PDF失败: offeringId={}, evaluationId={}, error={}", offeringId, evaluationId, e.getMessage(), e);
            throw new RuntimeException("生成质量评价汇编PDF失败: " + e.getMessage(), e);
        }
    }

    @GetMapping("/quality-compendium/download")
    public ResponseEntity<byte[]> downloadCompendium(@RequestParam Integer offeringId,
                                                      @RequestParam(required = false) Integer evaluationId) {
        byte[] bytes = compendiumGen.generate(offeringId, evaluationId);
        return pdfResponse(bytes, "课程质量评价资料汇编.pdf", false);
    }

    // ============ helpers ============

    private ResponseEntity<byte[]> pdfResponse(byte[] bytes, String filename, boolean inline) {
        String encoded = URLEncoder.encode(filename, StandardCharsets.UTF_8);
        String disposition = (inline ? "inline" : "attachment")
                + "; filename=\"" + encoded + "\"; filename*=UTF-8''" + encoded;
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, disposition)
                .contentType(MediaType.APPLICATION_PDF)
                .body(bytes);
    }

    private ResponseEntity<byte[]> xlsxResponse(byte[] bytes, String filename) {
        String encoded = URLEncoder.encode(filename, StandardCharsets.UTF_8);
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION,
                        "attachment; filename=\"" + encoded + "\"; filename*=UTF-8''" + encoded)
                .contentType(MediaType.parseMediaType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"))
                .body(bytes);
    }
}
