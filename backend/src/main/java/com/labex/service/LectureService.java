package com.labex.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.labex.entity.Lecture;

import java.util.List;

/**
 * 讲义服务接口
 */
public interface LectureService extends IService<Lecture> {

    /**
     * 根据类型查询讲义
     */
    List<Lecture> findByType(Integer type);

    /**
     * 获取未向量化处理的讲义列表
     */
    List<Lecture> findUnvectorized();

    /**
     * 更新讲义向量化状态
     */
    void updateVectorizedStatus(Integer lectureId, Integer status, String documentId);

    /**
     * 获取上传路径
     */
    String getUploadPath();
}
