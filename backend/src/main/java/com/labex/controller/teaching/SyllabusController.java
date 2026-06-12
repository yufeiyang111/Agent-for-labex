package com.labex.controller.teaching;

import com.labex.common.Result;
import com.labex.entity.teaching.Syllabus;
import com.labex.entity.teaching.SyllabusChapter;
import com.labex.service.teaching.SyllabusService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * 课程大纲控制器（CTL-S1）
 */
@RestController
@RequestMapping("/teacher/syllabus")
@PreAuthorize("hasRole('TEACHER') or hasRole('ADMIN')")
@Slf4j
public class SyllabusController {

    @Autowired private SyllabusService syllabusService;

    /**
     * 取大纲及章节列表
     */
    @GetMapping("/{courseId}")
    public Result<Map<String, Object>> get(@PathVariable Integer courseId) {
        Syllabus s = syllabusService.getOrCreate(courseId);
        Map<String, Object> data = new HashMap<>();
        data.put("syllabus", s);
        data.put("chapters", syllabusService.listChapters(s.getSyllabusId()));
        return Result.success(data);
    }

    @PutMapping("/{courseId}")
    public Result<Syllabus> save(@PathVariable Integer courseId, @RequestBody Syllabus dto) {
        return Result.success(syllabusService.save(courseId, dto));
    }

    @PostMapping("/{syllabusId}/chapter")
    public Result<SyllabusChapter> addChapter(@PathVariable Integer syllabusId,
                                              @RequestBody SyllabusChapter chapter) {
        return Result.success(syllabusService.addChapter(syllabusId, chapter));
    }

    @PutMapping("/chapter/{chapterId}")
    public Result<SyllabusChapter> updateChapter(@PathVariable Integer chapterId,
                                                  @RequestBody SyllabusChapter chapter) {
        return Result.success(syllabusService.updateChapter(chapterId, chapter));
    }

    @DeleteMapping("/chapter/{chapterId}")
    public Result<Void> deleteChapter(@PathVariable Integer chapterId) {
        syllabusService.deleteChapter(chapterId);
        return Result.success();
    }
}
