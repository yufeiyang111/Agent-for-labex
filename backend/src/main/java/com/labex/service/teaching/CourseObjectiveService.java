package com.labex.service.teaching;

import com.baomidou.mybatisplus.extension.service.IService;
import com.labex.entity.teaching.CourseObjective;
import com.labex.entity.teaching.GraduationIndicator;
import com.labex.entity.teaching.ObjectiveSupport;

import java.util.List;

/**
 * 课程目标服务（CTL-S2）
 */
public interface CourseObjectiveService extends IService<CourseObjective> {

    List<CourseObjective> listByCourse(Integer courseId);

    CourseObjective createObjective(CourseObjective obj);

    /** 设置目标对指标点的支撑（全量覆盖） */
    void setSupports(Integer objectiveId, List<ObjectiveSupport> supports);

    /** 查询目标支撑的指标点 */
    List<GraduationIndicator> getSupportedIndicators(Integer objectiveId);

    /** 查询某课程的目标 + 支撑矩阵原始记录 */
    List<ObjectiveSupport> listSupportsByCourse(Integer courseId);
}
