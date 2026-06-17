package com.labex.service.teaching;

import com.baomidou.mybatisplus.extension.service.IService;
import com.labex.entity.teaching.QualityEvaluation;

import java.util.List;
import java.util.Map;

/**
 * 课程质量评价服务（CTL-S6）
 */
public interface QualityEvaluationService extends IService<QualityEvaluation> {

    /** 查询某开课的所有评价（按 evalRound） */
    List<QualityEvaluation> listByOffering(Integer offeringId);

    /** 取最新（按 create_time desc） */
    QualityEvaluation getLatest(Integer offeringId);

    /** 创建评价草稿（含自动填充 achievementValues 字段） */
    QualityEvaluation createDraft(Integer offeringId, Integer evaluatorId, String evalRound);

    /** 保存评价 */
    QualityEvaluation saveEvaluation(Integer id, QualityEvaluation dto);

    /** 终稿（自动生成快照） */
    QualityEvaluation finalize(Integer id);

    /** 获取学生评价统计 */
    Map<String, Object> getEvaluationStats(Integer offeringId);

    /** 获取评价维度数据 */
    List<Map<String, Object>> getEvaluationDimensions(Integer offeringId);

    /** 获取学生文字评价 */
    List<Map<String, Object>> getStudentComments(Integer offeringId);
}
