package com.labex.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.HomeworkQuestion;
import com.labex.entity.Question;
import com.labex.mapper.HomeworkQuestionMapper;
import com.labex.service.HomeworkQuestionService;
import com.labex.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class HomeworkQuestionServiceImpl extends ServiceImpl<HomeworkQuestionMapper, HomeworkQuestion>
        implements HomeworkQuestionService {

    @Autowired
    private QuestionService questionService;

    @Override
    public List<HomeworkQuestion> findByHomeworkId(Integer homeworkId) {
        return this.lambdaQuery()
                .eq(HomeworkQuestion::getHomeworkId, homeworkId)
                .orderByAsc(HomeworkQuestion::getSortIndex)
                .list();
    }

    @Override
    public boolean saveQuestions(Integer homeworkId, List<Integer> questionIds) {
        List<HomeworkQuestion> existing = findByHomeworkId(homeworkId);
        java.util.Set<Integer> existingIds = existing.stream()
                .map(HomeworkQuestion::getQuestionId)
                .collect(java.util.stream.Collectors.toSet());
        int startSort = existing.stream()
                .map(HomeworkQuestion::getSortIndex)
                .filter(java.util.Objects::nonNull)
                .max(Integer::compareTo)
                .orElse(existing.size() - 1) + 1;

        int offset = 0;
        for (Integer questionId : questionIds) {
            if (questionId == null || existingIds.contains(questionId)) {
                continue;
            }
            HomeworkQuestion hq = new HomeworkQuestion();
            hq.setHomeworkId(homeworkId);
            hq.setQuestionId(questionId);
            hq.setSortIndex(startSort + offset);
            Question question = questionService.getById(questionId);
            hq.setScore(question != null && question.getScore() != null ? question.getScore() : 10);
            save(hq);
            offset++;
        }
        return true;
    }

    @Override
    public boolean removeQuestions(Integer homeworkId) {
        return this.lambdaUpdate()
                .eq(HomeworkQuestion::getHomeworkId, homeworkId)
                .remove();
    }

    @Override
    public boolean removeQuestion(Integer homeworkId, Integer questionId) {
        return this.lambdaUpdate()
                .eq(HomeworkQuestion::getHomeworkId, homeworkId)
                .eq(HomeworkQuestion::getQuestionId, questionId)
                .remove();
    }
}
