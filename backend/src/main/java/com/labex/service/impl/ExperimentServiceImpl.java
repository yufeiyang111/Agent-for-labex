package com.labex.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.Experiment;
import com.labex.mapper.ExperimentMapper;
import com.labex.service.ExperimentService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 实验服务实现类
 */
@Service
public class ExperimentServiceImpl extends ServiceImpl<ExperimentMapper, Experiment> implements ExperimentService {

    @Override
    public List<Experiment> listEnabled() {
        return this.list(
                new LambdaQueryWrapper<Experiment>()
                        .eq(Experiment::getState, 1)
                        .orderByAsc(Experiment::getExperimentNo)
        );
    }
}
