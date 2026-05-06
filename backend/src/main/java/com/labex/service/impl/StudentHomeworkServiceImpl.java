package com.labex.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.StudentHomework;
import com.labex.mapper.StudentHomeworkMapper;
import com.labex.service.StudentHomeworkService;
import org.springframework.stereotype.Service;
import java.util.List;

/**
 * 学生作业提交服务实现类
 */
@Service
public class StudentHomeworkServiceImpl extends ServiceImpl<StudentHomeworkMapper, StudentHomework> 
        implements StudentHomeworkService {

    @Override
    public List<StudentHomework> findByHomeworkId(Integer homeworkId) {
        return this.lambdaQuery()
                .eq(StudentHomework::getHomeworkId, homeworkId)
                .orderByDesc(StudentHomework::getSubmitTime)
                .list();
    }

    @Override
    public StudentHomework findByStudentAndHomework(Integer studentId, Integer homeworkId) {
        return this.lambdaQuery()
                .eq(StudentHomework::getStudentId, studentId)
                .eq(StudentHomework::getHomeworkId, homeworkId)
                .one();
    }

    @Override
    public List<StudentHomework> findByStudentId(Integer studentId) {
        return this.lambdaQuery()
                .eq(StudentHomework::getStudentId, studentId)
                .orderByDesc(StudentHomework::getSubmitTime)
                .list();
    }
}
