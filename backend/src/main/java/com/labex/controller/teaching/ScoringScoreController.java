package com.labex.controller.teaching;

import com.labex.common.Result;
import com.labex.entity.Teacher;
import com.labex.entity.teaching.ScoringScore;
import com.labex.service.TeacherService;
import com.labex.service.teaching.ScoringScoreService;
import com.labex.vo.teaching.ScoreMatrixVO;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.math.BigDecimal;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;

/**
 * 评分项得分录入控制器（CTL-S4）
 */
@RestController
@RequestMapping("/teacher/scoring-score")
@PreAuthorize("hasRole('TEACHER') or hasRole('ADMIN')")
@Slf4j
public class ScoringScoreController {

    @Autowired private ScoringScoreService scoreService;
    @Autowired private TeacherService teacherService;

    private Integer currentTeacherId() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            Teacher t = teacherService.findByAccount(auth.getName());
            if (t != null) return t.getTeacherId();
        }
        return null;
    }

    @PostMapping
    public Result<ScoringScore> enter(@RequestBody EnterScoreRequest req) {
        return Result.success(scoreService.enterScore(req.getItemId(), req.getStudentId(), req.getScore(), currentTeacherId()));
    }

    @PostMapping("/batch")
    public Result<Integer> batch(@RequestParam Integer itemId, @RequestBody List<ScoringScore> scores) {
        return Result.success(scoreService.batchEnter(itemId, scores, currentTeacherId()));
    }

    @PostMapping("/matrix")
    public Result<Integer> saveMatrix(@RequestParam Integer offeringId, @RequestBody ScoreMatrixVO matrix) {
        return Result.success(scoreService.saveMatrix(offeringId, matrix, currentTeacherId()));
    }

    @GetMapping("/matrix")
    public Result<ScoreMatrixVO> getMatrix(@RequestParam Integer offeringId) {
        return Result.success(scoreService.getMatrix(offeringId));
    }

    @GetMapping("/list")
    public Result<List<ScoringScore>> listByItem(@RequestParam Integer itemId) {
        return Result.success(scoreService.listByItem(itemId));
    }

    @PostMapping("/import")
    public Result<Map<String, Object>> importExcel(@RequestParam Integer offeringId,
                                                    @RequestParam("file") MultipartFile file) {
        int n = scoreService.importFromExcel(offeringId, file, currentTeacherId());
        return Result.success("导入成功", Map.of("count", n));
    }

    @GetMapping("/template")
    public ResponseEntity<byte[]> template(@RequestParam Integer offeringId) {
        byte[] bytes = scoreService.exportTemplate(offeringId);
        String filename = URLEncoder.encode("成绩明细表模板.xlsx", StandardCharsets.UTF_8);
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION,
                        "attachment; filename=\"" + filename + "\"; filename*=UTF-8''" + filename)
                .contentType(MediaType.parseMediaType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"))
                .body(bytes);
    }

    @Data
    public static class EnterScoreRequest {
        private Integer itemId;
        private Integer studentId;
        private BigDecimal score;
    }
}
