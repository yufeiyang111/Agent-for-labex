package com.labex.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.Question;
import com.labex.mapper.QuestionMapper;
import com.labex.service.QuestionService;
import org.springframework.stereotype.Service;
import java.util.List;

/**
 * 题库服务实现类
 */
@Service
public class QuestionServiceImpl extends ServiceImpl<QuestionMapper, Question> implements QuestionService {

    @Override
    public List<Question> findByTeacherId(Integer teacherId) {
        return this.lambdaQuery()
                .eq(Question::getTeacherId, teacherId)
                .orderByDesc(Question::getId)
                .list();
    }

    @Override
    public List<Question> findByType(Integer type) {
        return this.lambdaQuery()
                .eq(Question::getType, type)
                .eq(Question::getState, 1)
                .list();
    }
}
