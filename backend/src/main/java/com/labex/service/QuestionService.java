package com.labex.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.labex.entity.Question;
import java.util.List;

/**
 * 题库服务接口
 */
public interface QuestionService extends IService<Question> {

    /**
     * 根据教师ID查询题目列表
     */
    List<Question> findByTeacherId(Integer teacherId);

    /**
     * 根据类型查询题目
     */
    List<Question> findByType(Integer type);
}
