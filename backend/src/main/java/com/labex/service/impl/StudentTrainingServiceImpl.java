package com.labex.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.StudentTraining;
import com.labex.mapper.StudentTrainingMapper;
import com.labex.service.StudentTrainingService;
import org.springframework.stereotype.Service;

@Service
public class StudentTrainingServiceImpl extends ServiceImpl<StudentTrainingMapper, StudentTraining>
        implements StudentTrainingService {
}
