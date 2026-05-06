package com.labex.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.labex.entity.Experiment;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 实验Mapper接口
 */
@Mapper
public interface ExperimentMapper extends BaseMapper<Experiment> {

    /**
     * 根据状态查询实验列表
     */
    List<Experiment> selectByState(@Param("state") Integer state);
}
