package com.labex.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.ExamMonitorEvent;
import com.labex.mapper.ExamMonitorEventMapper;
import com.labex.service.ExamMonitorEventService;
import org.springframework.stereotype.Service;

@Service
public class ExamMonitorEventServiceImpl extends ServiceImpl<ExamMonitorEventMapper, ExamMonitorEvent>
        implements ExamMonitorEventService {
}
