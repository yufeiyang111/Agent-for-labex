package com.labex.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.labex.entity.StudentQuestion;
import java.util.List;

/**
 * 学生答卷服务接口
 */
public interface StudentQuestionService extends IService<StudentQuestion> {

    /**
     * 根据学生ID和考试ID查询答卷
     */
    List<StudentQuestion> findByStudentAndExam(Integer studentId, Integer examId);

    /**
     * 根据学生ID查询所有答卷
     */
    List<StudentQuestion> findByStudentId(Integer studentId);
}
