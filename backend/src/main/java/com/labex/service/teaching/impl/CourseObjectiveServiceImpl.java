package com.labex.service.teaching.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.teaching.CourseObjective;
import com.labex.entity.teaching.GraduationIndicator;
import com.labex.entity.teaching.ObjectiveSupport;
import com.labex.mapper.teaching.CourseObjectiveMapper;
import com.labex.mapper.teaching.GraduationIndicatorMapper;
import com.labex.mapper.teaching.ObjectiveSupportMapper;
import com.labex.service.teaching.CourseObjectiveService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Slf4j
public class CourseObjectiveServiceImpl extends ServiceImpl<CourseObjectiveMapper, CourseObjective>
        implements CourseObjectiveService {

    @Autowired
    private ObjectiveSupportMapper supportMapper;

    @Autowired
    private GraduationIndicatorMapper indicatorMapper;

    @Override
    public List<CourseObjective> listByCourse(Integer courseId) {
        return list(new LambdaQueryWrapper<CourseObjective>()
                .eq(CourseObjective::getCourseId, courseId)
                .orderByAsc(CourseObjective::getSortOrder)
                .orderByAsc(CourseObjective::getCode));
    }

    @Override
    public CourseObjective createObjective(CourseObjective obj) {
        if (obj.getSortOrder() == null) {
            obj.setSortOrder(0);
        }
        save(obj);
        return obj;
    }

    @Override
    @Transactional
    public void setSupports(Integer objectiveId, List<ObjectiveSupport> supports) {
        // 全量覆盖：先删后插
        supportMapper.delete(new LambdaQueryWrapper<ObjectiveSupport>()
                .eq(ObjectiveSupport::getObjectiveId, objectiveId));
        if (supports != null) {
            for (ObjectiveSupport s : supports) {
                s.setObjectiveId(objectiveId);
                if (s.getSupportStrength() == null) {
                    s.setSupportStrength(1);
                }
                supportMapper.insert(s);
            }
        }
    }

    @Override
    public List<GraduationIndicator> getSupportedIndicators(Integer objectiveId) {
        List<ObjectiveSupport> supports = supportMapper.selectList(
                new LambdaQueryWrapper<ObjectiveSupport>()
                        .eq(ObjectiveSupport::getObjectiveId, objectiveId));
        if (supports.isEmpty()) {
            return Collections.emptyList();
        }
        List<Integer> ids = supports.stream().map(ObjectiveSupport::getIndicatorId).collect(Collectors.toList());
        return indicatorMapper.selectBatchIds(ids);
    }

    @Override
    public List<ObjectiveSupport> listSupportsByCourse(Integer courseId) {
        List<CourseObjective> objectives = listByCourse(courseId);
        if (objectives.isEmpty()) {
            return Collections.emptyList();
        }
        List<Integer> objIds = objectives.stream().map(CourseObjective::getObjectiveId).collect(Collectors.toList());
        return supportMapper.selectList(new LambdaQueryWrapper<ObjectiveSupport>()
                .in(ObjectiveSupport::getObjectiveId, objIds));
    }
}
