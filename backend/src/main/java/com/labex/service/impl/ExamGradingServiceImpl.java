package com.labex.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.ExamGrading;
import com.labex.entity.StudentQuestion;
import com.labex.mapper.ExamGradingMapper;
import com.labex.mapper.StudentQuestionMapper;
import com.labex.service.ExamGradingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;

@Service
public class ExamGradingServiceImpl extends ServiceImpl<ExamGradingMapper, ExamGrading>
        implements ExamGradingService {

    @Autowired
    private StudentQuestionMapper studentQuestionMapper;

    @Override
    public ExamGrading findByExamAndStudent(Integer examId, Integer studentId) {
        return this.lambdaQuery()
                .eq(ExamGrading::getExamId, examId)
                .eq(ExamGrading::getStudentId, studentId)
                .one();
    }

    @Override
    public ExamGrading getOrCreate(Integer examId, Integer studentId) {
        ExamGrading existing = findByExamAndStudent(examId, studentId);
        if (existing != null) return existing;

        ExamGrading newRecord = new ExamGrading();
        newRecord.setExamId(examId);
        newRecord.setStudentId(studentId);
        newRecord.setAutoGraded(false);
        newRecord.setManualGraded(false);
        save(newRecord);
        return newRecord;
    }

    @Override
    public void markAutoGraded(Integer examId, Integer studentId, Integer autoScore) {
        ExamGrading eg = getOrCreate(examId, studentId);
        eg.setAutoGraded(true);
        updateById(eg);
        checkAndCalculateFinalScore(eg);
    }

    @Override
    public void markManualGraded(Integer examId, Integer studentId, Integer score) {
        ExamGrading eg = getOrCreate(examId, studentId);
        eg.setManualGraded(true);
        eg.setGradedAt(LocalDateTime.now());
        updateById(eg);
        checkAndCalculateFinalScore(eg);
    }

    @Override
    public boolean isAllGraded(Integer examId, Integer studentId) {
        ExamGrading eg = findByExamAndStudent(examId, studentId);
        return eg != null && eg.getFinalScore() != null;
    }

    @Override
    public Integer getFinalScore(Integer examId, Integer studentId) {
        ExamGrading eg = findByExamAndStudent(examId, studentId);
        return eg != null ? eg.getFinalScore() : null;
    }

    private void checkAndCalculateFinalScore(ExamGrading eg) {
        if (!eg.getAutoGraded() || !eg.getManualGraded()) return;

        Integer totalScore = studentQuestionMapper.selectCount(null) > 0 ?
            studentQuestionMapper.selectList(
                new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<StudentQuestion>()
                    .eq(StudentQuestion::getExamId, eg.getExamId())
                    .eq(StudentQuestion::getStudentId, eg.getStudentId())
            ).stream()
            .filter(a -> a.getScore() != null)
            .mapToInt(StudentQuestion::getScore)
            .sum() : 0;

        eg.setFinalScore(totalScore);
        eg.setGradedAt(LocalDateTime.now());
        updateById(eg);
    }
}