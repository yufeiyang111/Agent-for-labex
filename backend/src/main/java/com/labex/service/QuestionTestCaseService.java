package com.labex.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.labex.entity.QuestionTestCase;
import java.util.List;

public interface QuestionTestCaseService extends IService<QuestionTestCase> {
    List<QuestionTestCase> findByQuestionId(Integer questionId);
    boolean deleteByQuestionId(Integer questionId);
    boolean saveBatchForQuestion(Integer questionId, List<QuestionTestCase> testCases);
}