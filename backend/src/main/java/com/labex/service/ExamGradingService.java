package com.labex.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.labex.entity.ExamGrading;

public interface ExamGradingService extends IService<ExamGrading> {
    ExamGrading findByExamAndStudent(Integer examId, Integer studentId);
    ExamGrading getOrCreate(Integer examId, Integer studentId);
    void markAutoGraded(Integer examId, Integer studentId, Integer autoScore);
    void markManualGraded(Integer examId, Integer studentId, Integer score);
    boolean isAllGraded(Integer examId, Integer studentId);
    Integer getFinalScore(Integer examId, Integer studentId);
}