package com.labex.common;

import lombok.Data;

import java.io.Serial;
import java.io.Serializable;

/**
 * 分页响应类
 */
@Data
public class PageResult<T> implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 当前页码
     */
    private Integer pageNum;

    /**
     * 每页数量
     */
    private Integer pageSize;

    /**
     * 总记录数
     */
    private Long total;

    /**
     * 总页数
     */
    private Integer totalPages;

    /**
     * 数据列表
     */
    private java.util.List<T> list;

    public static <T> PageResult<T> success(java.util.List<T> list, Integer pageNum, Integer pageSize, Long total) {
        PageResult<T> result = new PageResult<>();
        result.setList(list);
        result.setPageNum(pageNum);
        result.setPageSize(pageSize);
        result.setTotal(total);
        result.setTotalPages((int) Math.ceil((double) total / pageSize));
        return result;
    }
}
