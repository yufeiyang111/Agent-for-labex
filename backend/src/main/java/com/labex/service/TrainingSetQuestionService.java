package com.labex.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.labex.entity.TrainingSetQuestion;

public interface TrainingSetQuestionService extends IService<TrainingSetQuestion> {
    boolean saveQuestions(Integer trainingSetId, java.util.List<Integer> questionIds);
    boolean removeQuestions(Integer trainingSetId);
    boolean removeQuestion(Integer trainingSetId, Integer questionId);
    java.util.List<TrainingSetQuestion> findByTrainingSetId(Integer trainingSetId);
}
