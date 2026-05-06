package com.labex.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.StudentHomeworkQuestion;
import com.labex.mapper.StudentHomeworkQuestionMapper;
import com.labex.service.StudentHomeworkQuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class StudentHomeworkQuestionServiceImpl extends ServiceImpl<StudentHomeworkQuestionMapper, StudentHomeworkQuestion>
        implements StudentHomeworkQuestionService {

    // No QuestionService dependency needed for now

    @Override
    public List<StudentHomeworkQuestion> findByHomeworkAndStudent(Integer homeworkId, Integer studentId) {
        return this.lambdaQuery()
                .eq(StudentHomeworkQuestion::getHomeworkId, homeworkId)
                .eq(StudentHomeworkQuestion::getStudentId, studentId)
                .list();
    }

    @Override
    public StudentHomeworkQuestion findByHomeworkStudentQuestion(Integer homeworkId, Integer studentId, Integer questionId) {
        return this.lambdaQuery()
                .eq(StudentHomeworkQuestion::getHomeworkId, homeworkId)
                .eq(StudentHomeworkQuestion::getStudentId, studentId)
                .eq(StudentHomeworkQuestion::getQuestionId, questionId)
                .one();
    }

    @Override
    public boolean saveAnswer(Integer homeworkId, Integer studentId, Integer questionId, String answer) {
        StudentHomeworkQuestion existing = findByHomeworkStudentQuestion(homeworkId, studentId, questionId);

        if (existing != null) {
            existing.setMyAnswer(answer);
            existing.setFillTime(LocalDateTime.now());
            return updateById(existing);
        } else {
            StudentHomeworkQuestion shq = new StudentHomeworkQuestion();
            shq.setHomeworkId(homeworkId);
            shq.setStudentId(studentId);
            shq.setQuestionId(questionId);
            shq.setMyAnswer(answer);
            shq.setFillTime(LocalDateTime.now());
            shq.setGraded(false);
            return save(shq);
        }
    }

    @Override
    public void gradeAnswer(Integer homeworkId, Integer studentId, Integer questionId, Integer score) {
        StudentHomeworkQuestion shq = findByHomeworkStudentQuestion(homeworkId, studentId, questionId);
        if (shq != null) {
            shq.setScore(score);
            shq.setIsCorrect(score > 0 ? 1 : 0);
            shq.setGraded(true);
            updateById(shq);
        }
    }
}