package com.labex.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.QuestionTestCase;
import com.labex.mapper.QuestionTestCaseMapper;
import com.labex.service.QuestionTestCaseService;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class QuestionTestCaseServiceImpl extends ServiceImpl<QuestionTestCaseMapper, QuestionTestCase>
        implements QuestionTestCaseService {

    @Override
    public List<QuestionTestCase> findByQuestionId(Integer questionId) {
        return this.lambdaQuery()
                .eq(QuestionTestCase::getQuestionId, questionId)
                .orderByAsc(QuestionTestCase::getSortIndex)
                .list();
    }

    @Override
    public boolean deleteByQuestionId(Integer questionId) {
        return this.lambdaUpdate()
                .eq(QuestionTestCase::getQuestionId, questionId)
                .remove();
    }

    @Override
    public boolean saveBatchForQuestion(Integer questionId, List<QuestionTestCase> testCases) {
        deleteByQuestionId(questionId);
        testCases.forEach(tc -> tc.setQuestionId(questionId));
        return saveBatch(testCases);
    }
}