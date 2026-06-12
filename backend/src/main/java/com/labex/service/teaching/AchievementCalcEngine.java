package com.labex.service.teaching;

import com.labex.entity.teaching.AchievementSnapshot;
import com.labex.vo.teaching.OfferingAchievementVO;
import com.labex.vo.teaching.StudentAchievementVO;

import java.util.List;

/**
 * 达成度计算引擎（CTL-S5 ★ 核心算法）
 *
 * 公式：
 *   学生个体： Ach(s, o) = Σ(score(s,i) × weight(i)) / Σ(max(i) × weight(i))，i ∈ items_of_o
 *   班级聚合： ClassAch(o) = COUNT(s: Ach(s,o) ≥ passing/max) / COUNT(s)
 *   课程总目标： Total(s) = Σ(score(s,i) × weight(i)) / Σ(max(i) × weight(i))，i ∈ all items
 *   总达成： Overall = COUNT(s: Total(s) ≥ 0.6) / COUNT(s)
 */
public interface AchievementCalcEngine {

    /** 计算单个学生在所有目标上的达成度 */
    StudentAchievementVO calcForStudent(Integer offeringId, Integer studentId);

    /** 计算开课级班级聚合 + 所有学生明细 */
    OfferingAchievementVO calcForOffering(Integer offeringId);

    /** 触发快照保存（写 t_achievement_snapshot） */
    void snapshot(Integer offeringId, String reason);

    /** 历史快照 */
    List<AchievementSnapshot> getSnapshots(Integer offeringId);
}
