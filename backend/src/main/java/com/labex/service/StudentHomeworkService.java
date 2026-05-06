package com.labex.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.labex.entity.StudentHomework;
import java.util.List;

/**
 * 学生作业提交服务接口
 */
public interface StudentHomeworkService extends IService<StudentHomework> {

    /**
     * 根据作业ID查询所有提交
     */
    List<StudentHomework> findByHomeworkId(Integer homeworkId);

    /**
     * 根据学生ID和作业ID查询提交记录
     */
    StudentHomework findByStudentAndHomework(Integer studentId, Integer homeworkId);

    /**
     * 根据学生ID查询所有提交
     */
    List<StudentHomework> findByStudentId(Integer studentId);
}
