package com.labex.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.labex.entity.StudentItem;

import java.util.List;

/**
 * 学生答题服务接口
 */
public interface StudentItemService extends IService<StudentItem> {

    /**
     * 根据学生ID查询
     */
    List<StudentItem> findByStudentId(Integer studentId);

    /**
     * 根据实验和学生查询
     */
    List<StudentItem> findByExperimentAndStudent(Integer experimentId, Integer studentId);
}
