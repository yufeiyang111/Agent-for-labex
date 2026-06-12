package com.labex.service.teaching;

import com.baomidou.mybatisplus.extension.service.IService;
import com.labex.entity.teaching.Syllabus;
import com.labex.entity.teaching.SyllabusChapter;

import java.util.List;

/**
 * 课程大纲服务（CTL-S1）
 */
public interface SyllabusService extends IService<Syllabus> {

    /** 取大纲（不存在则创建空大纲） */
    Syllabus getOrCreate(Integer courseId);

    /** 保存大纲全字段 */
    Syllabus save(Integer courseId, Syllabus dto);

    /** 列出章节 */
    List<SyllabusChapter> listChapters(Integer syllabusId);

    /** 新增/编辑/删除章节 */
    SyllabusChapter addChapter(Integer syllabusId, SyllabusChapter chapter);

    SyllabusChapter updateChapter(Integer chapterId, SyllabusChapter chapter);

    void deleteChapter(Integer chapterId);
}
