package com.labex.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.labex.entity.Clazz;

import java.util.List;

/**
 * 班级服务接口
 */
public interface ClazzService extends IService<Clazz> {

    /**
     * 根据班级编号查询
     */
    Clazz findByNo(String no);

    /**
     * 根据班级编号删除
     */
    boolean removeByNo(String no);

    /**
     * 根据班级编号更新
     */
    boolean updateByNo(String no, Clazz clazz);

    /**
     * 根据教师ID获取该教师的所有班级编号
     */
    List<String> getClazzNosByTeacherId(Integer teacherId);
}
