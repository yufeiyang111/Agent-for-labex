package com.labex.service.teaching;

import com.baomidou.mybatisplus.extension.service.IService;
import com.labex.entity.teaching.ScoringScore;
import com.labex.vo.teaching.ScoreMatrixVO;
import org.springframework.web.multipart.MultipartFile;

import java.math.BigDecimal;
import java.util.List;

/**
 * 评分项得分服务（CTL-S4）
 */
public interface ScoringScoreService extends IService<ScoringScore> {

    /** 单条录入或更新 */
    ScoringScore enterScore(Integer itemId, Integer studentId, BigDecimal score, Integer teacherId);

    /** 批量录入（同一评分项的多学生得分） */
    int batchEnter(Integer itemId, List<ScoringScore> scores, Integer teacherId);

    /** 跨评分项保存矩阵（教师录入页面批量提交） */
    int saveMatrix(Integer offeringId, ScoreMatrixVO matrix, Integer teacherId);

    /** 查询学生×评分项矩阵 */
    ScoreMatrixVO getMatrix(Integer offeringId);

    /** Excel 导入（按成绩明细表模板） */
    int importFromExcel(Integer offeringId, MultipartFile file, Integer teacherId);

    /** Excel 模板下载 */
    byte[] exportTemplate(Integer offeringId);

    /** 列出某评分项的全部得分 */
    List<ScoringScore> listByItem(Integer itemId);
}
