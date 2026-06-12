package com.labex.service.teaching;

import com.baomidou.mybatisplus.extension.service.IService;
import com.labex.entity.teaching.GraduationIndicator;
import com.labex.entity.teaching.GraduationRequirement;

import java.util.List;

/**
 * 毕业要求服务（CTL-S2）
 */
public interface GraduationRequirementService extends IService<GraduationRequirement> {

    /** 列出所有毕业要求 */
    List<GraduationRequirement> listAll();

    /** 列出某毕业要求下的指标点 */
    List<GraduationIndicator> listIndicators(Integer requirementId);

    /** 列出所有指标点 */
    List<GraduationIndicator> listAllIndicators();

    /** 创建毕业要求 + 批量指标点 */
    GraduationRequirement createWithIndicators(GraduationRequirement gr, List<GraduationIndicator> indicators);

    /** 新增指标点 */
    GraduationIndicator addIndicator(Integer requirementId, GraduationIndicator indicator);

    /** 删除毕业要求（含级联指标点） */
    void deleteRequirement(Integer requirementId);

    /** 删除指标点 */
    void deleteIndicator(Integer indicatorId);
}
