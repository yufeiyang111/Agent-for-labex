package com.labex.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.Clazz;
import com.labex.mapper.ClazzMapper;
import com.labex.service.ClazzService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 * 班级服务实现类
 */
@Service
public class ClazzServiceImpl extends ServiceImpl<ClazzMapper, Clazz> implements ClazzService {

    @Override
    public Clazz findByNo(String no) {
        return this.getOne(new LambdaQueryWrapper<Clazz>().eq(Clazz::getNo, no));
    }

    @Override
    public boolean removeByNo(String no) {
        return this.remove(new LambdaQueryWrapper<Clazz>().eq(Clazz::getNo, no));
    }

    @Override
    public boolean updateByNo(String no, Clazz clazz) {
        return this.update(clazz, new LambdaQueryWrapper<Clazz>().eq(Clazz::getNo, no));
    }

    @Override
    public List<String> getClazzNosByTeacherId(Integer teacherId) {
        List<Clazz> clazzList = this.list(new LambdaQueryWrapper<Clazz>().eq(Clazz::getTeacherId, teacherId));
        return clazzList.stream().map(Clazz::getNo).collect(Collectors.toList());
    }
}
