package com.labex.controller.teaching;

import com.labex.common.Result;
import com.labex.service.teaching.QualityReportGenerator;
import com.labex.service.teaching.QualityReportGenerator.ReportType;
import com.labex.vo.teaching.AttainmentReportVO;
import com.labex.vo.teaching.ConsistencyReportVO;
import com.labex.vo.teaching.GradeStatReportVO;
import com.labex.vo.teaching.QualityReportVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

/**
 * 4 张评价报告控制器（CTL-S6）
 */
@RestController
@RequestMapping("/teacher/quality-report")
@PreAuthorize("hasRole('TEACHER') or hasRole('ADMIN')")
@Slf4j
public class QualityReportController {

    @Autowired private QualityReportGenerator generator;

    @GetMapping("/grade-stat")
    public Result<GradeStatReportVO> gradeStat(@RequestParam Integer offeringId) {
        return Result.success(generator.gradeStat(offeringId));
    }

    @GetMapping("/consistency")
    public Result<ConsistencyReportVO> consistency(@RequestParam Integer offeringId) {
        return Result.success(generator.consistency(offeringId));
    }

    @GetMapping("/attainment")
    public Result<AttainmentReportVO> attainment(@RequestParam Integer offeringId,
                                                  @RequestParam(required = false) Integer evaluationId) {
        return Result.success(generator.attainment(offeringId, evaluationId));
    }

    @GetMapping("/quality")
    public Result<QualityReportVO> quality(@RequestParam Integer evaluationId) {
        return Result.success(generator.quality(evaluationId));
    }

    @GetMapping("/export")
    public ResponseEntity<byte[]> export(@RequestParam Integer offeringId,
                                          @RequestParam ReportType type,
                                          @RequestParam(required = false) Integer evaluationId,
                                          @RequestParam(defaultValue = "excel") String format) {
        byte[] bytes;
        String contentType;
        String ext;
        if ("pdf".equalsIgnoreCase(format)) {
            bytes = generator.exportPdf(offeringId, type, evaluationId);
            contentType = "application/pdf";
            ext = "pdf";
        } else {
            bytes = generator.exportExcel(offeringId, type, evaluationId);
            contentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            ext = "xlsx";
        }
        String filename = URLEncoder.encode(reportName(type) + "." + ext, StandardCharsets.UTF_8);
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION,
                        "attachment; filename=\"" + filename + "\"; filename*=UTF-8''" + filename)
                .contentType(MediaType.parseMediaType(contentType))
                .body(bytes);
    }

    private String reportName(ReportType type) {
        return switch (type) {
            case GRADE_STAT -> "成绩统计表";
            case CONSISTENCY -> "考核合理性审核表";
            case ATTAINMENT -> "课程目标达成情况评价报告";
            case QUALITY -> "课程质量评价表";
        };
    }
}
