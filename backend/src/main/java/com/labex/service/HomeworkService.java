package com.labex.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.labex.entity.Homework;
import java.util.List;

/**
 * 作业服务接口
 */
public interface HomeworkService extends IService<Homework> {

    /**
     * 根据教师ID查询作业列表
     */
    List<Homework> findByTeacherId(Integer teacherId);

    /**
     * 查询所有可用的作业（学生用）
     */
    List<Homework> findAvailableHomeworks();
}
