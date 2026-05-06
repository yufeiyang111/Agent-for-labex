package com.labex.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.labex.entity.Exam;
import org.apache.ibatis.annotations.Mapper;

/**
 * 考试Mapper接口
 */
@Mapper
public interface ExamMapper extends BaseMapper<Exam> {
}
