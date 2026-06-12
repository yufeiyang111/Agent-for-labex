package com.labex.service.teaching.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.labex.entity.teaching.QualityEvaluation;
import com.labex.mapper.teaching.QualityEvaluationMapper;
import com.labex.service.teaching.AchievementCalcEngine;
import com.labex.service.teaching.QualityEvaluationService;
import com.labex.vo.teaching.OfferingAchievementVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Slf4j
public class QualityEvaluationServiceImpl extends ServiceImpl<QualityEvaluationMapper, QualityEvaluation>
        implements QualityEvaluationService {

    private static final ObjectMapper JSON = new ObjectMapper();

    @Autowired
    private AchievementCalcEngine achievementEngine;

    @Override
    public List<QualityEvaluation> listByOffering(Integer offeringId) {
        return list(new LambdaQueryWrapper<QualityEvaluation>()
                .eq(QualityEvaluation::getOfferingId, offeringId)
                .orderByDesc(QualityEvaluation::getCreateTime));
    }

    @Override
    public QualityEvaluation getLatest(Integer offeringId) {
        return getOne(new LambdaQueryWrapper<QualityEvaluation>()
                .eq(QualityEvaluation::getOfferingId, offeringId)
                .orderByDesc(QualityEvaluation::getCreateTime)
                .last("LIMIT 1"));
    }

    @Override
    @Transactional
    public QualityEvaluation createDraft(Integer offeringId, Integer evaluatorId, String evalRound) {
        // 检查同 round 是否已存在
        QualityEvaluation existing = getOne(new LambdaQueryWrapper<QualityEvaluation>()
                .eq(QualityEvaluation::getOfferingId, offeringId)
                .eq(QualityEvaluation::getEvalRound, evalRound));
        if (existing != null) {
            return existing;
        }
        QualityEvaluation eval = new QualityEvaluation();
        eval.setOfferingId(offeringId);
        eval.setEvaluatorId(evaluatorId);
        eval.setEvalRound(evalRound);
        eval.setStatus("draft");
        // 自动填充达成值
        try {
            OfferingAchievementVO ach = achievementEngine.calcForOffering(offeringId);
            Map<String, Object> achMap = new HashMap<>();
            ach.getByObjective().values().forEach(s -> achMap.put(s.getCode(), s.getValue()));
            achMap.put("__overall__", ach.getOverallReachedRatio());
            eval.setAchievementValues(JSON.writeValueAsString(achMap));
        } catch (JsonProcessingException e) {
            log.warn("自动填充达成值失败", e);
        }
        save(eval);
        return eval;
    }

    @Override
    public QualityEvaluation saveEvaluation(Integer id, QualityEvaluation dto) {
        dto.setEvaluationId(id);
        updateById(dto);
        return getById(id);
    }

    @Override
    @Transactional
    public QualityEvaluation finalize(Integer id) {
        QualityEvaluation eval = getById(id);
        if (eval == null) {
            throw new RuntimeException("评价不存在");
        }
        eval.setStatus("finalized");
        updateById(eval);
        // 终稿时创建快照
        achievementEngine.snapshot(eval.getOfferingId(), "finalize evaluation " + id);
        return eval;
    }
}
