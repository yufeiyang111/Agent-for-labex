package com.labex.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.labex.entity.HomeworkQuestion;
import java.util.List;

public interface HomeworkQuestionService extends IService<HomeworkQuestion> {

    List<HomeworkQuestion> findByHomeworkId(Integer homeworkId);

    boolean saveQuestions(Integer homeworkId, List<Integer> questionIds);

    boolean removeQuestions(Integer homeworkId);

    boolean removeQuestion(Integer homeworkId, Integer questionId);
}
