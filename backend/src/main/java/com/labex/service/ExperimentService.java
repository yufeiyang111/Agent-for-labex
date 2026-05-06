package com.labex.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.labex.entity.Experiment;

import java.util.List;

/**
 * 实验服务接口
 */
public interface ExperimentService extends IService<Experiment> {

    /**
     * 查询启用的实验
     */
    List<Experiment> listEnabled();
}
