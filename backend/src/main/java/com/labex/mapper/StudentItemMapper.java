package com.labex.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.labex.entity.StudentItem;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 学生答题Mapper接口
 */
@Mapper
public interface StudentItemMapper extends BaseMapper<StudentItem> {

    /**
     * 根据学生ID和题目ID查询
     */
    StudentItem selectByStudentAndItem(@Param("studentId") Integer studentId, @Param("itemId") Integer itemId);

    /**
     * 根据学生ID查询所有答题记录
     */
    List<StudentItem> selectByStudentId(@Param("studentId") Integer studentId);

    /**
     * 根据实验和学生查询答题记录
     */
    List<StudentItem> selectByExperimentAndStudent(
            @Param("experimentId") Integer experimentId,
            @Param("studentId") Integer studentId);
}
