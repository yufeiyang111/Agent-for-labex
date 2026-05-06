package com.labex.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.ExperimentItem;
import com.labex.mapper.ExperimentItemMapper;
import com.labex.service.ExperimentItemService;
import org.springframework.stereotype.Service;

/**
 * 实验题目服务实现类
 */
@Service
public class ExperimentItemServiceImpl extends ServiceImpl<ExperimentItemMapper, ExperimentItem> implements ExperimentItemService {
}
