package com.labex.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.StudentQuestion;
import com.labex.mapper.StudentQuestionMapper;
import com.labex.service.StudentQuestionService;
import org.springframework.stereotype.Service;
import java.util.List;

/**
 * 学生答卷服务实现类
 */
@Service
public class StudentQuestionServiceImpl extends ServiceImpl<StudentQuestionMapper, StudentQuestion> 
        implements StudentQuestionService {

    @Override
    public List<StudentQuestion> findByStudentAndExam(Integer studentId, Integer examId) {
        return this.lambdaQuery()
                .eq(StudentQuestion::getStudentId, studentId)
                .eq(StudentQuestion::getExamId, examId)
                .list();
    }

    @Override
    public List<StudentQuestion> findByStudentId(Integer studentId) {
        return this.lambdaQuery()
                .eq(StudentQuestion::getStudentId, studentId)
                .orderByDesc(StudentQuestion::getFillTime)
                .list();
    }
}
