package com.labex.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.StudentClazz;
import com.labex.mapper.StudentClazzMapper;
import com.labex.service.StudentClazzService;
import org.springframework.stereotype.Service;
import java.util.List;

/**
 * 学生班级关联服务实现类
 */
@Service
public class StudentClazzServiceImpl extends ServiceImpl<StudentClazzMapper, StudentClazz> 
        implements StudentClazzService {

    @Override
    public List<StudentClazz> findByClazzNo(String clazzNo) {
        return this.lambdaQuery()
                .eq(StudentClazz::getClazzNo, clazzNo)
                .list();
    }

    @Override
    public List<StudentClazz> findByTeacherId(Integer teacherId) {
        return this.lambdaQuery()
                .eq(StudentClazz::getTeacherId, teacherId)
                .list();
    }

    @Override
    public boolean existsByStudentIdAndClazzNo(Integer studentId, String clazzNo) {
        return this.lambdaQuery()
                .eq(StudentClazz::getStudentId, studentId)
                .eq(StudentClazz::getClazzNo, clazzNo)
                .count() > 0;
    }

    @Override
    public List<StudentClazz> findByStudentId(Integer studentId) {
        return this.lambdaQuery()
                .eq(StudentClazz::getStudentId, studentId)
                .list();
    }

    @Override
    public void deleteByStudentId(Integer studentId) {
        this.lambdaUpdate()
                .eq(StudentClazz::getStudentId, studentId)
                .remove();
    }
}
