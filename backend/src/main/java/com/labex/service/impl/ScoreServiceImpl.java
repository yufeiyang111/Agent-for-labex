package com.labex.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.Score;
import com.labex.mapper.ScoreMapper;
import com.labex.service.ScoreService;
import org.springframework.stereotype.Service;

/**
 * 成绩服务实现类
 */
@Service
public class ScoreServiceImpl extends ServiceImpl<ScoreMapper, Score> implements ScoreService {
}