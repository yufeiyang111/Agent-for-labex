package com.labex.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.labex.entity.Student;
import com.labex.vo.UserInfoVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * 学生Mapper接口
 */
@Mapper
public interface StudentMapper extends BaseMapper<Student> {

    /**
     * 根据学号查询学生
     */
    Student selectByStudentNo(@Param("studentNo") String studentNo);

    /**
     * 根据学号查询学生信息（含班级名称）
     */
    UserInfoVO selectStudentWithClazzName(@Param("studentNo") String studentNo);
}
