package com.labex.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.labex.entity.ExperimentItem;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 实验题目Mapper接口
 */
@Mapper
public interface ExperimentItemMapper extends BaseMapper<ExperimentItem> {

    /**
     * 根据实验ID查询题目列表
     */
    List<ExperimentItem> selectByExperimentId(@Param("experimentId") Integer experimentId);
}
