package com.labex.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.labex.entity.Paper;
import org.apache.ibatis.annotations.Mapper;

/**
 * 试卷Mapper接口
 */
@Mapper
public interface PaperMapper extends BaseMapper<Paper> {
}
