package com.labex.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.TrainingSet;
import com.labex.mapper.TrainingSetMapper;
import com.labex.service.TrainingSetService;
import org.springframework.stereotype.Service;

@Service
public class TrainingSetServiceImpl extends ServiceImpl<TrainingSetMapper, TrainingSet>
        implements TrainingSetService {
}
