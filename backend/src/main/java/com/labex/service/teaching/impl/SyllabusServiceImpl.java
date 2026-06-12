package com.labex.service.teaching.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.teaching.Syllabus;
import com.labex.entity.teaching.SyllabusChapter;
import com.labex.mapper.teaching.SyllabusChapterMapper;
import com.labex.mapper.teaching.SyllabusMapper;
import com.labex.service.teaching.SyllabusService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Slf4j
public class SyllabusServiceImpl extends ServiceImpl<SyllabusMapper, Syllabus> implements SyllabusService {

    @Autowired
    private SyllabusChapterMapper chapterMapper;

    @Override
    @Transactional
    public Syllabus getOrCreate(Integer courseId) {
        Syllabus s = getOne(new LambdaQueryWrapper<Syllabus>().eq(Syllabus::getCourseId, courseId));
        if (s == null) {
            s = new Syllabus();
            s.setCourseId(courseId);
            s.setVersion(1);
            save(s);
        }
        return s;
    }

    @Override
    @Transactional
    public Syllabus save(Integer courseId, Syllabus dto) {
        Syllabus existing = getOrCreate(courseId);
        // 复制字段（保留 id/courseId/version）
        existing.setCourseIntro(dto.getCourseIntro());
        existing.setMainTask(dto.getMainTask());
        existing.setKnowledgeGoals(dto.getKnowledgeGoals());
        existing.setAbilityGoals(dto.getAbilityGoals());
        existing.setQualityGoals(dto.getQualityGoals());
        existing.setTeachingMethods(dto.getTeachingMethods());
        existing.setExerciseRequirements(dto.getExerciseRequirements());
        existing.setAssessmentMethods(dto.getAssessmentMethods());
        if (dto.getAchievementFormula() != null) {
            existing.setAchievementFormula(dto.getAchievementFormula());
        }
        existing.setTextbooks(dto.getTextbooks());
        existing.setReferencesList(dto.getReferencesList());
        updateById(existing);
        return existing;
    }

    @Override
    public List<SyllabusChapter> listChapters(Integer syllabusId) {
        return chapterMapper.selectList(new LambdaQueryWrapper<SyllabusChapter>()
                .eq(SyllabusChapter::getSyllabusId, syllabusId)
                .orderByAsc(SyllabusChapter::getSortOrder)
                .orderByAsc(SyllabusChapter::getChapterId));
    }

    @Override
    public SyllabusChapter addChapter(Integer syllabusId, SyllabusChapter chapter) {
        chapter.setSyllabusId(syllabusId);
        if (chapter.getSortOrder() == null) {
            chapter.setSortOrder(0);
        }
        chapterMapper.insert(chapter);
        return chapter;
    }

    @Override
    public SyllabusChapter updateChapter(Integer chapterId, SyllabusChapter chapter) {
        chapter.setChapterId(chapterId);
        chapterMapper.updateById(chapter);
        return chapterMapper.selectById(chapterId);
    }

    @Override
    public void deleteChapter(Integer chapterId) {
        chapterMapper.deleteById(chapterId);
    }
}
