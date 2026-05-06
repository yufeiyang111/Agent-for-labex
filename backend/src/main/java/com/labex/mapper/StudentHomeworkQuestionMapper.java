package com.labex.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.labex.entity.StudentHomeworkQuestion;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface StudentHomeworkQuestionMapper extends BaseMapper<StudentHomeworkQuestion> {

    List<StudentHomeworkQuestion> findByHomeworkAndStudent(
            @Param("homeworkId") Integer homeworkId,
            @Param("studentId") Integer studentId);

    StudentHomeworkQuestion findByHomeworkStudentQuestion(
            @Param("homeworkId") Integer homeworkId,
            @Param("studentId") Integer studentId,
            @Param("questionId") Integer questionId);
}