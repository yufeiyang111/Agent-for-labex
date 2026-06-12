package com.labex.service.teaching;

import com.labex.vo.teaching.AttainmentReportVO;
import com.labex.vo.teaching.ConsistencyReportVO;
import com.labex.vo.teaching.GradeStatReportVO;
import com.labex.vo.teaching.QualityReportVO;

/**
 * 4 张评价报告生成器（CTL-S6）
 */
public interface QualityReportGenerator {

    /** 报告 1：成绩统计表 */
    GradeStatReportVO gradeStat(Integer offeringId);

    /** 报告 2：考核合理性审核表 */
    ConsistencyReportVO consistency(Integer offeringId);

    /** 报告 3：课程目标达成情况评价报告 */
    AttainmentReportVO attainment(Integer offeringId, Integer evaluationId);

    /** 报告 4：课程质量评价表 */
    QualityReportVO quality(Integer evaluationId);

    /** Excel 导出 */
    byte[] exportExcel(Integer offeringId, ReportType type, Integer evaluationId);

    /** PDF 导出 */
    byte[] exportPdf(Integer offeringId, ReportType type, Integer evaluationId);

    enum ReportType {
        GRADE_STAT, CONSISTENCY, ATTAINMENT, QUALITY
    }
}
