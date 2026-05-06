package com.labex.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.Paper;
import com.labex.mapper.PaperMapper;
import com.labex.service.PaperService;
import org.springframework.stereotype.Service;
import java.util.List;

/**
 * 试卷服务实现类
 */
@Service
public class PaperServiceImpl extends ServiceImpl<PaperMapper, Paper> implements PaperService {

    @Override
    public List<Paper> findByTeacherId(Integer teacherId) {
        return this.lambdaQuery()
                .eq(Paper::getTeacherId, teacherId)
                .orderByDesc(Paper::getTime)
                .list();
    }

    @Override
    public List<Paper> findAvailablePapers() {
        return this.lambdaQuery()
                .eq(Paper::getState, 1)
                .orderByDesc(Paper::getTime)
                .list();
    }
}
