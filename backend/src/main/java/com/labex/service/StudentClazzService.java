package com.labex.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.labex.entity.StudentClazz;

import java.util.List;

/**
 * 学生班级关联服务接口
 */
public interface StudentClazzService extends IService<StudentClazz> {

    /**
     * 根据班级编号查询所有学生
     */
    List<StudentClazz> findByClazzNo(String clazzNo);

    /**
     * 根据教师ID查询所有学生
     */
    List<StudentClazz> findByTeacherId(Integer teacherId);

    /**
     * 检查学生是否已关联到该班级
     */
    boolean existsByStudentIdAndClazzNo(Integer studentId, String clazzNo);

    /**
     * 根据学生ID查询所有班级关联
     */
    List<StudentClazz> findByStudentId(Integer studentId);

    /**
     * 删除学生的所有班级关联
     */
    void deleteByStudentId(Integer studentId);
}
