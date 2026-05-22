package com.labex.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.labex.entity.RagSessionSummary;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface RagSessionSummaryMapper
extends BaseMapper<RagSessionSummary> {
    public List<RagSessionSummary> selectBySessionId(@Param(value="sessionId") String var1);

    public RagSessionSummary selectLatestBySessionId(@Param(value="sessionId") String var1);

    public void deleteBySessionId(@Param(value="sessionId") String var1);
}

