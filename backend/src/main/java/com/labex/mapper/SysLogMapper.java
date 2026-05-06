package com.labex.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.labex.entity.SysLog;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 系统日志Mapper接口
 */
@Mapper
public interface SysLogMapper extends BaseMapper<SysLog> {

    /**
     * 分页查询日志
     */
    List<SysLog> selectPageList(int offset, int limit);
}
