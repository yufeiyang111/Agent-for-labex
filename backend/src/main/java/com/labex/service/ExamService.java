package com.labex.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.labex.entity.Exam;
import java.util.List;

/**
 * 考试服务接口
 */
public interface ExamService extends IService<Exam> {

    /**
     * 根据教师ID查询考试列表
     */
    List<Exam> findByTeacherId(Integer teacherId);

    /**
     * 查询所有可用的考试（学生用）
     */
    List<Exam> findAvailableExams();
}
