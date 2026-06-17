package com.labex.common;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

/**
 * 统一响应封装测试
 * 测试人员：于峰
 * 测试内容：Result类、PageResult类
 */
public class ResultTest {

    // ==================== Result类测试 ====================

    /**
     * 测试成功响应 - 无数据
     */
    @Test
    public void testSuccessWithoutData() {
        Result<?> result = Result.success();

        assertNotNull(result);
        assertEquals(0, result.getCode());
        assertNull(result.getData());
        assertNotNull(result.getTimestamp());
    }

    /**
     * 测试成功响应 - 有数据
     */
    @Test
    public void testSuccessWithData() {
        String data = "测试数据";
        Result<String> result = Result.success(data);

        assertNotNull(result);
        assertEquals(0, result.getCode());
        assertEquals(data, result.getData());
        assertNotNull(result.getTimestamp());
    }

    /**
     * 测试成功响应 - 有消息和数据
     */
    @Test
    public void testSuccessWithMessageAndData() {
        String message = "操作成功";
        String data = "测试数据";
        Result<String> result = Result.success(message, data);

        assertNotNull(result);
        assertEquals(0, result.getCode());
        assertEquals(message, result.getMessage());
        assertEquals(data, result.getData());
        assertNotNull(result.getTimestamp());
    }

    /**
     * 测试错误响应 - 无消息
     */
    @Test
    public void testErrorWithoutMessage() {
        Result<?> result = Result.error();

        assertNotNull(result);
        assertEquals(-1, result.getCode());
        assertNull(result.getData());
        assertNotNull(result.getTimestamp());
    }

    /**
     * 测试错误响应 - 有消息
     */
    @Test
    public void testErrorWithMessage() {
        String message = "操作失败";
        Result<?> result = Result.error(message);

        assertNotNull(result);
        assertEquals(-1, result.getCode());
        assertEquals(message, result.getMessage());
        assertNull(result.getData());
        assertNotNull(result.getTimestamp());
    }

    /**
     * 测试错误响应 - 有代码和消息
     */
    @Test
    public void testErrorWithCodeAndMessage() {
        int code = 400;
        String message = "请求参数错误";
        Result<?> result = Result.error(code, message);

        assertNotNull(result);
        assertEquals(code, result.getCode());
        assertEquals(message, result.getMessage());
        assertNull(result.getData());
        assertNotNull(result.getTimestamp());
    }

    /**
     * 测试Result的链式调用
     */
    @Test
    public void testResultChaining() {
        Result<String> result = Result.success("数据")
                .setMessage("自定义消息");

        assertNotNull(result);
        assertEquals(0, result.getCode());
        assertEquals("数据", result.getData());
        assertEquals("自定义消息", result.getMessage());
    }

    /**
     * 测试Result的时间戳
     */
    @Test
    public void testResultTimestamp() {
        long before = System.currentTimeMillis();
        Result<?> result = Result.success();
        long after = System.currentTimeMillis();

        assertNotNull(result.getTimestamp());
        assertTrue(result.getTimestamp() >= before);
        assertTrue(result.getTimestamp() <= after);
    }

    /**
     * 测试Result的类型安全
     */
    @Test
    public void testResultTypeSafety() {
        Result<Integer> intResult = Result.success(123);
        Result<String> strResult = Result.success("字符串");
        Result<Boolean> boolResult = Result.success(true);

        assertEquals(123, intResult.getData());
        assertEquals("字符串", strResult.getData());
        assertEquals(true, boolResult.getData());
    }

    // ==================== PageResult类测试 ====================

    /**
     * 测试分页结果 - 基本构造
     */
    @Test
    public void testPageResultBasic() {
        java.util.List<String> records = java.util.Arrays.asList("记录1", "记录2", "记录3");
        long total = 100;
        long page = 1;
        long size = 10;

        PageResult<String> pageResult = new PageResult<>(records, total, page, size);

        assertNotNull(pageResult);
        assertEquals(records, pageResult.getRecords());
        assertEquals(total, pageResult.getTotal());
        assertEquals(page, pageResult.getPage());
        assertEquals(size, pageResult.getSize());
    }

    /**
     * 测试分页结果 - 空记录
     */
    @Test
    public void testPageResultEmptyRecords() {
        java.util.List<String> records = java.util.Collections.emptyList();
        long total = 0;
        long page = 1;
        long size = 10;

        PageResult<String> pageResult = new PageResult<>(records, total, page, size);

        assertNotNull(pageResult);
        assertTrue(pageResult.getRecords().isEmpty());
        assertEquals(0, pageResult.getTotal());
    }

    /**
     * 测试分页结果 - 计算总页数
     */
    @Test
    public void testPageResultTotalPages() {
        java.util.List<String> records = java.util.Arrays.asList("记录1", "记录2");
        long total = 25;
        long page = 1;
        long size = 10;

        PageResult<String> pageResult = new PageResult<>(records, total, page, size);

        // 总页数 = ceil(total / size) = ceil(25 / 10) = 3
        assertEquals(3, pageResult.getTotalPages());
    }

    /**
     * 测试分页结果 - 最后一页
     */
    @Test
    public void testPageResultLastPage() {
        java.util.List<String> records = java.util.Arrays.asList("记录1", "记录2", "记录3", "记录4", "记录5");
        long total = 25;
        long page = 3;
        long size = 10;

        PageResult<String> pageResult = new PageResult<>(records, total, page, size);

        assertEquals(5, pageResult.getRecords().size());
        assertEquals(25, pageResult.getTotal());
        assertEquals(3, pageResult.getPage());
    }

    /**
     * 测试分页结果 - 是否有下一页
     */
    @Test
    public void testPageResultHasNext() {
        java.util.List<String> records = java.util.Arrays.asList("记录1", "记录2");
        long total = 25;
        long size = 10;

        // 第一页，有下一页
        PageResult<String> page1 = new PageResult<>(records, total, 1, size);
        assertTrue(page1.hasNext());

        // 最后一页，没有下一页
        PageResult<String> page3 = new PageResult<>(records, total, 3, size);
        assertFalse(page3.hasNext());
    }

    /**
     * 测试分页结果 - 是否有上一页
     */
    @Test
    public void testPageResultHasPrevious() {
        java.util.List<String> records = java.util.Arrays.asList("记录1", "记录2");
        long total = 25;
        long size = 10;

        // 第一页，没有上一页
        PageResult<String> page1 = new PageResult<>(records, total, 1, size);
        assertFalse(page1.hasPrevious());

        // 第二页，有上一页
        PageResult<String> page2 = new PageResult<>(records, total, 2, size);
        assertTrue(page2.hasPrevious());
    }

    /**
     * 测试分页结果 - 边界值测试
     */
    @Test
    public void testPageResultBoundary() {
        java.util.List<String> records = java.util.Collections.emptyList();
        long total = 0;
        long page = 1;
        long size = 10;

        PageResult<String> pageResult = new PageResult<>(records, total, page, size);

        assertEquals(0, pageResult.getTotalPages());
        assertFalse(pageResult.hasNext());
        assertFalse(pageResult.hasPrevious());
    }

    /**
     * 测试分页结果 - 大数据量
     */
    @Test
    public void testPageResultLargeData() {
        java.util.List<String> records = java.util.Arrays.asList("记录1", "记录2");
        long total = 1000000;
        long page = 50000;
        long size = 20;

        PageResult<String> pageResult = new PageResult<>(records, total, page, size);

        assertEquals(50000, pageResult.getTotalPages());
        assertTrue(pageResult.hasNext());
        assertTrue(pageResult.hasPrevious());
    }

    /**
     * 测试分页结果 - 每页大小为1
     */
    @Test
    public void testPageResultSizeOne() {
        java.util.List<String> records = java.util.Arrays.asList("记录1");
        long total = 5;
        long page = 3;
        long size = 1;

        PageResult<String> pageResult = new PageResult<>(records, total, page, size);

        assertEquals(5, pageResult.getTotalPages());
        assertTrue(pageResult.hasNext());
        assertTrue(pageResult.hasPrevious());
    }

    /**
     * 测试分页结果 - 每页大小等于总数
     */
    @Test
    public void testPageResultSizeEqualsTotal() {
        java.util.List<String> records = java.util.Arrays.asList("记录1", "记录2", "记录3");
        long total = 3;
        long page = 1;
        long size = 3;

        PageResult<String> pageResult = new PageResult<>(records, total, page, size);

        assertEquals(1, pageResult.getTotalPages());
        assertFalse(pageResult.hasNext());
        assertFalse(pageResult.hasPrevious());
    }
}
