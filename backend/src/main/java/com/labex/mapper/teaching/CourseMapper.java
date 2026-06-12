package com.labex.mapper.teaching;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.labex.entity.teaching.Course;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CourseMapper extends BaseMapper<Course> {}
