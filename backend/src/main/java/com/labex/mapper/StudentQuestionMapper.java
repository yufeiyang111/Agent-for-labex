package com.labex.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.labex.entity.StudentQuestion;
import org.apache.ibatis.annotations.Mapper;

/**
 * 学生答卷Mapper接口
 */
@Mapper
public interface StudentQuestionMapper extends BaseMapper<StudentQuestion> {
}
