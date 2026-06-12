package com.labex.service.teaching;

import com.baomidou.mybatisplus.extension.service.IService;
import com.labex.entity.teaching.ScoringItem;
import com.labex.entity.teaching.ScoringItemObjective;

import java.util.List;

/**
 * 评分项服务（CTL-S3）
 */
public interface ScoringItemService extends IService<ScoringItem> {

    List<ScoringItem> listByOffering(Integer offeringId);

    /** 创建评分项 + 同时设置目标关联 */
    ScoringItem createItem(ScoringItem item, List<ScoringItemObjective> objectiveLinks);

    /** 更新评分项 + 同时覆盖目标关联 */
    void updateItem(Integer itemId, ScoringItem item, List<ScoringItemObjective> objectiveLinks);

    /** 删除评分项（含目标关联级联） */
    void deleteItem(Integer itemId);

    /** 校验某开课的所有评分项权重和 = 1.0000（±0.0001） */
    boolean validateWeightSum(Integer offeringId);

    /** 查询评分项的目标关联 */
    List<ScoringItemObjective> listObjectiveLinks(Integer itemId);

    /**
     * 自动从已有作业/实验/考试建议评分项
     * 不会自动持久化，仅返回建议列表
     */
    List<ScoringItem> suggestFromExistingTasks(Integer offeringId);
}
