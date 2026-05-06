package com.labex.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.labex.entity.Paper;
import java.util.List;

/**
 * 试卷服务接口
 */
public interface PaperService extends IService<Paper> {

    /**
     * 根据教师ID查询试卷列表
     */
    List<Paper> findByTeacherId(Integer teacherId);

    /**
     * 查询所有可用的试卷
     */
    List<Paper> findAvailablePapers();
}
