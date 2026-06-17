package com.labex.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.StudentItem;
import com.labex.mapper.StudentItemMapper;
import com.labex.service.StudentItemService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 学生答题服务实现类
 */
@Service
public class StudentItemServiceImpl extends ServiceImpl<StudentItemMapper, StudentItem> implements StudentItemService {

    @Override
    public List<StudentItem> findByStudentId(Integer studentId) {
        return this.list(
                new LambdaQueryWrapper<StudentItem>()
                        .eq(StudentItem::getStudentId, studentId)
        );
    }

    @Override
    public List<StudentItem> findByExperimentAndStudent(Integer experimentId, Integer studentId) {
        return this.list(
                new LambdaQueryWrapper<StudentItem>()
                        .eq(StudentItem::getStudentId, studentId)
                        .apply("item_id IN (SELECT experiment_item_id FROM t_experiment_item WHERE experiment_id = {0})", experimentId)
        );
    }
}
