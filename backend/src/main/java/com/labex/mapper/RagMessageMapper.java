package com.labex.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.labex.entity.RagMessage;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * RAG消息Mapper
 */
@Mapper
public interface RagMessageMapper extends BaseMapper<RagMessage> {

    /**
     * 获取会话的所有消息
     */
    List<RagMessage> selectBySessionId(@Param("sessionId") String sessionId);

    /**
     * 删除会话的所有消息
     */
    void deleteBySessionId(@Param("sessionId") String sessionId);
}