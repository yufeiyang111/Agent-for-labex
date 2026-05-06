package com.labex.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.Teacher;
import com.labex.mapper.TeacherMapper;
import com.labex.service.TeacherService;
import org.springframework.stereotype.Service;

import java.util.Optional;

/**
 * 教师服务实现类
 */
@Service
public class TeacherServiceImpl extends ServiceImpl<TeacherMapper, Teacher> implements TeacherService {

    @Override
    public Teacher findByAccount(String account) {
        return this.baseMapper.selectByAccount(account);
    }

    @Override
    public Integer getIdByAccount(String account) {
        Teacher teacher = findByAccount(account);
        return teacher != null ? teacher.getTeacherId() : null;
    }
}
