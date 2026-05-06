package com.labex.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.labex.entity.Teacher;

/**
 * 教师服务接口
 */
public interface TeacherService extends IService<Teacher> {

    /**
     * 根据账号查询教师
     */
    Teacher findByAccount(String account);

    /**
     * 根据账号获取教师ID
     */
    Integer getIdByAccount(String account);
}
