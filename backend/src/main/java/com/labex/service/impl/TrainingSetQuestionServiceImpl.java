package com.labex.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.Question;
import com.labex.entity.TrainingSetQuestion;
import com.labex.mapper.TrainingSetQuestionMapper;
import com.labex.service.QuestionService;
import com.labex.service.TrainingSetQuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class TrainingSetQuestionServiceImpl extends ServiceImpl<TrainingSetQuestionMapper, TrainingSetQuestion>
        implements TrainingSetQuestionService {

    @Autowired
    private QuestionService questionService;

    @Override
    public List<TrainingSetQuestion> findByTrainingSetId(Integer trainingSetId) {
        return this.lambdaQuery()
                .eq(TrainingSetQuestion::getTrainingSetId, trainingSetId)
                .orderByAsc(TrainingSetQuestion::getSortIndex)
                .list();
    }

    @Override
    public boolean saveQuestions(Integer trainingSetId, List<Integer> questionIds) {
        List<TrainingSetQuestion> existing = findByTrainingSetId(trainingSetId);
        Set<Integer> existingIds = existing.stream()
                .map(TrainingSetQuestion::getQuestionId)
                .collect(Collectors.toSet());
        int startSort = existing.stream()
                .map(TrainingSetQuestion::getSortIndex)
                .filter(java.util.Objects::nonNull)
                .max(Integer::compareTo)
                .orElse(existing.size() - 1) + 1;

        int offset = 0;
        for (Integer questionId : questionIds) {
            if (questionId == null || existingIds.contains(questionId)) continue;
            TrainingSetQuestion tsq = new TrainingSetQuestion();
            tsq.setTrainingSetId(trainingSetId);
            tsq.setQuestionId(questionId);
            tsq.setSortIndex(startSort + offset);
            Question question = questionService.getById(questionId);
            tsq.setScore(question != null && question.getScore() != null ? question.getScore() : 10);
            save(tsq);
            offset++;
        }
        return true;
    }

    @Override
    public boolean removeQuestions(Integer trainingSetId) {
        return this.lambdaUpdate()
                .eq(TrainingSetQuestion::getTrainingSetId, trainingSetId)
                .remove();
    }

    @Override
    public boolean removeQuestion(Integer trainingSetId, Integer questionId) {
        return this.lambdaUpdate()
                .eq(TrainingSetQuestion::getTrainingSetId, trainingSetId)
                .eq(TrainingSetQuestion::getQuestionId, questionId)
                .remove();
    }
}
