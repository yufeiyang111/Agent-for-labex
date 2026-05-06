package com.labex.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.labex.entity.Lecture;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 讲义Mapper接口
 */
@Mapper
public interface LectureMapper extends BaseMapper<Lecture> {

    /**
     * 根据类型查询讲义列表
     */
    List<Lecture> selectByType(Integer type);

    /**
     * 获取未向量化处理的讲义列表
     */
    List<Lecture> selectUnvectorized();

    /**
     * 更新讲义向量化状态
     */
    void updateVectorized(@Param("lectureId") Integer lectureId,
                          @Param("status") Integer status,
                          @Param("documentId") String documentId);
}
