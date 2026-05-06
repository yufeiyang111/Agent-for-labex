package com.labex.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.labex.entity.PaperQuestion;
import org.apache.ibatis.annotations.Mapper;

/**
 * 试卷题目关联Mapper接口
 */
@Mapper
public interface PaperQuestionMapper extends BaseMapper<PaperQuestion> {
}
