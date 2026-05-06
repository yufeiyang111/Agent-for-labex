package com.labex.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.labex.entity.StudentHomeworkQuestion;
import java.util.List;

public interface StudentHomeworkQuestionService extends IService<StudentHomeworkQuestion> {

    List<StudentHomeworkQuestion> findByHomeworkAndStudent(Integer homeworkId, Integer studentId);

    StudentHomeworkQuestion findByHomeworkStudentQuestion(Integer homeworkId, Integer studentId, Integer questionId);

    boolean saveAnswer(Integer homeworkId, Integer studentId, Integer questionId, String answer);

    void gradeAnswer(Integer homeworkId, Integer studentId, Integer questionId, Integer score);
}