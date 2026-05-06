package com.labex.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.labex.entity.PaperQuestion;
import java.util.List;

/**
 * 试卷题目关联服务接口
 */
public interface PaperQuestionService extends IService<PaperQuestion> {

    /**
     * 根据试卷ID查询所有题目
     */
    List<PaperQuestion> findByPaperId(Integer paperId);

    /**
     * 根据试卷ID删除所有题目关联
     */
    void deleteByPaperId(Integer paperId);
}
