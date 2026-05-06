package com.labex.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.labex.entity.Question;
import org.apache.ibatis.annotations.Mapper;

/**
 * 题库Mapper接口
 */
@Mapper
public interface QuestionMapper extends BaseMapper<Question> {
}
