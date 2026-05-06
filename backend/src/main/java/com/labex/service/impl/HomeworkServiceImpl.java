package com.labex.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.Homework;
import com.labex.mapper.HomeworkMapper;
import com.labex.service.HomeworkService;
import org.springframework.stereotype.Service;
import java.util.List;

/**
 * 作业服务实现类
 */
@Service
public class HomeworkServiceImpl extends ServiceImpl<HomeworkMapper, Homework> implements HomeworkService {

    @Override
    public List<Homework> findByTeacherId(Integer teacherId) {
        return this.lambdaQuery()
                .eq(Homework::getTeacherId, teacherId)
                .orderByDesc(Homework::getCreateTime)
                .list();
    }

    @Override
    public List<Homework> findAvailableHomeworks() {
        return this.lambdaQuery()
                .eq(Homework::getState, 1)
                .orderByDesc(Homework::getCreateTime)
                .list();
    }
}
