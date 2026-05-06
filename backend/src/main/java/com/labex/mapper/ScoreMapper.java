package com.labex.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.labex.entity.Score;
import org.apache.ibatis.annotations.Mapper;

/**
 * 成绩Mapper接口
 */
@Mapper
public interface ScoreMapper extends BaseMapper<Score> {
}