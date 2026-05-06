package com.labex.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.PaperQuestion;
import com.labex.mapper.PaperQuestionMapper;
import com.labex.service.PaperQuestionService;
import org.springframework.stereotype.Service;
import java.util.List;

/**
 * 试卷题目关联服务实现类
 */
@Service
public class PaperQuestionServiceImpl extends ServiceImpl<PaperQuestionMapper, PaperQuestion> 
        implements PaperQuestionService {

    @Override
    public List<PaperQuestion> findByPaperId(Integer paperId) {
        return this.lambdaQuery()
                .eq(PaperQuestion::getPaperId, paperId)
                .orderByAsc(PaperQuestion::getSort)
                .list();
    }

    @Override
    public void deleteByPaperId(Integer paperId) {
        this.lambdaUpdate()
                .eq(PaperQuestion::getPaperId, paperId)
                .remove();
    }
}
