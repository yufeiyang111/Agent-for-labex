package com.labex.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.StudentTrainingQuestion;
import com.labex.mapper.StudentTrainingQuestionMapper;
import com.labex.service.StudentTrainingQuestionService;
import org.springframework.stereotype.Service;

@Service
public class StudentTrainingQuestionServiceImpl extends ServiceImpl<StudentTrainingQuestionMapper, StudentTrainingQuestion>
        implements StudentTrainingQuestionService {
}
