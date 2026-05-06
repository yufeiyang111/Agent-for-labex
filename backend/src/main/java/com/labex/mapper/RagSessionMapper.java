package com.labex.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.labex.entity.RagSession;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * RAG会话Mapper
 */
@Mapper
public interface RagSessionMapper extends BaseMapper<RagSession> {

    /**
     * 获取用户的所有会话，按最后活跃时间排序
     */
    List<RagSession> selectByUserIdOrderByLastActive(@Param("userId") String userId);

    /**
     * 删除用户的会话
     */
    void deleteByUserId(@Param("userId") String userId);
}