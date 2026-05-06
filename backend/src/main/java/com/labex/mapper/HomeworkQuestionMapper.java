package com.labex.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.labex.entity.HomeworkQuestion;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface HomeworkQuestionMapper extends BaseMapper<HomeworkQuestion> {

    List<HomeworkQuestion> findByHomeworkId(@Param("homeworkId") Integer homeworkId);

    int deleteByHomeworkId(@Param("homeworkId") Integer homeworkId);

    int deleteByHomeworkAndQuestion(@Param("homeworkId") Integer homeworkId, @Param("questionId") Integer questionId);
}