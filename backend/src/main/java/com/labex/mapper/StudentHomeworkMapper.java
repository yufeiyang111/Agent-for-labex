package com.labex.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.labex.entity.StudentHomework;
import org.apache.ibatis.annotations.Mapper;

/**
 * 学生作业提交Mapper接口
 */
@Mapper
public interface StudentHomeworkMapper extends BaseMapper<StudentHomework> {
}
