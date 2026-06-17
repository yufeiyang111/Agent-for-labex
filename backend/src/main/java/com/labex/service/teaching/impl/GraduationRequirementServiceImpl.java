package com.labex.service.teaching.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.teaching.GraduationIndicator;
import com.labex.entity.teaching.GraduationRequirement;
import com.labex.mapper.teaching.GraduationIndicatorMapper;
import com.labex.mapper.teaching.GraduationRequirementMapper;
import com.labex.service.teaching.GraduationRequirementService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Slf4j
public class GraduationRequirementServiceImpl
        extends ServiceImpl<GraduationRequirementMapper, GraduationRequirement>
        implements GraduationRequirementService {

    @Autowired
    private GraduationIndicatorMapper indicatorMapper;

    @Override
    public List<GraduationRequirement> listAll() {
        return list(new LambdaQueryWrapper<GraduationRequirement>().orderByAsc(GraduationRequirement::getCode));
    }

    @Override
    public List<GraduationIndicator> listIndicators(Integer requirementId) {
        return indicatorMapper.selectList(new LambdaQueryWrapper<GraduationIndicator>()
                .eq(GraduationIndicator::getRequirementId, requirementId)
                .orderByAsc(GraduationIndicator::getCode));
    }

    @Override
    public List<GraduationIndicator> listAllIndicators() {
        return indicatorMapper.selectList(new LambdaQueryWrapper<GraduationIndicator>()
                .orderByAsc(GraduationIndicator::getCode));
    }

    @Override
    @Transactional
    public GraduationRequirement createWithIndicators(GraduationRequirement gr,
                                                       List<GraduationIndicator> indicators) {
        save(gr);
        if (indicators != null) {
            for (GraduationIndicator ind : indicators) {
                ind.setRequirementId(gr.getRequirementId());
                indicatorMapper.insert(ind);
            }
        }
        return gr;
    }

    @Override
    public GraduationIndicator addIndicator(Integer requirementId, GraduationIndicator indicator) {
        indicator.setRequirementId(requirementId);
        indicatorMapper.insert(indicator);
        return indicator;
    }

    @Override
    public GraduationIndicator updateIndicator(Integer indicatorId, GraduationIndicator indicator) {
        indicator.setIndicatorId(indicatorId);
        indicatorMapper.updateById(indicator);
        return indicator;
    }

    @Override
    @Transactional
    public void deleteRequirement(Integer requirementId) {
        indicatorMapper.delete(new LambdaQueryWrapper<GraduationIndicator>()
                .eq(GraduationIndicator::getRequirementId, requirementId));
        removeById(requirementId);
    }

    @Override
    public void deleteIndicator(Integer indicatorId) {
        indicatorMapper.deleteById(indicatorId);
    }
}
