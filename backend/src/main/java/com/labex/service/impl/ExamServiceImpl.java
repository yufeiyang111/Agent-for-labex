package com.labex.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.Exam;
import com.labex.mapper.ExamMapper;
import com.labex.service.ExamService;
import org.springframework.stereotype.Service;
import java.util.List;

/**
 * 考试服务实现类
 */
@Service
public class ExamServiceImpl extends ServiceImpl<ExamMapper, Exam> implements ExamService {

    @Override
    public List<Exam> findByTeacherId(Integer teacherId) {
        return this.lambdaQuery()
                .eq(Exam::getTeacherId, teacherId)
                .orderByDesc(Exam::getTime)
                .list();
    }

    @Override
    public List<Exam> findAvailableExams() {
        return this.lambdaQuery()
                .eq(Exam::getState, 1)
                .orderByDesc(Exam::getTime)
                .list();
    }
}
