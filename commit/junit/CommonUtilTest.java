package com.labex.common;

import org.junit.jupiter.api.Test;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import static org.junit.jupiter.api.Assertions.*;

/**
 * 通用工具类测试
 * 测试人员：于峰
 * 测试内容：日期处理、字符串处理、数字处理、集合处理
 */
public class CommonUtilTest {

    // ==================== 日期处理测试 ====================

    /**
     * 测试日期格式化
     */
    @Test
    public void testDateFormat() {
        LocalDateTime dateTime = LocalDateTime.of(2024, 10, 1, 9, 0, 0);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

        String formatted = dateTime.format(formatter);

        assertEquals("2024-10-01 09:00:00", formatted);
    }

    /**
     * 测试日期解析
     */
    @Test
    public void testDateParse() {
        String dateStr = "2024-10-01 09:00:00";
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

        LocalDateTime dateTime = LocalDateTime.parse(dateStr, formatter);

        assertNotNull(dateTime);
        assertEquals(2024, dateTime.getYear());
        assertEquals(10, dateTime.getMonthValue());
        assertEquals(1, dateTime.getDayOfMonth());
        assertEquals(9, dateTime.getHour());
        assertEquals(0, dateTime.getMinute());
        assertEquals(0, dateTime.getSecond());
    }

    /**
     * 测试日期比较
     */
    @Test
    public void testDateCompare() {
        LocalDateTime date1 = LocalDateTime.of(2024, 10, 1, 9, 0, 0);
        LocalDateTime date2 = LocalDateTime.of(2024, 10, 2, 9, 0, 0);

        assertTrue(date1.isBefore(date2));
        assertTrue(date2.isAfter(date1));
    }

    /**
     * 测试日期计算
     */
    @Test
    public void testDateCalculation() {
        LocalDateTime startDate = LocalDateTime.of(2024, 10, 1, 9, 0, 0);
        LocalDateTime endDate = LocalDateTime.of(2024, 10, 2, 9, 0, 0);

        long hours = java.time.Duration.between(startDate, endDate).toHours();

        assertEquals(24, hours);
    }

    // ==================== 字符串处理测试 ====================

    /**
     * 测试字符串判空
     */
    @Test
    public void testStringEmpty() {
        assertTrue(isEmpty(null));
        assertTrue(isEmpty(""));
        assertTrue(isEmpty("  "));
        assertFalse(isEmpty("hello"));
        assertFalse(isEmpty(" hello "));
    }

    /**
     * 测试字符串非空
     */
    @Test
    public void testStringNotEmpty() {
        assertFalse(isNotEmpty(null));
        assertFalse(isNotEmpty(""));
        assertFalse(isNotEmpty("  "));
        assertTrue(isNotEmpty("hello"));
        assertTrue(isNotEmpty(" hello "));
    }

    /**
     * 测试字符串去空格
     */
    @Test
    public void testStringTrim() {
        assertEquals("hello", trim("  hello  "));
        assertEquals("hello", trim("hello"));
        assertEquals("", trim("  "));
        assertNull(trim(null));
    }

    /**
     * 测试字符串截取
     */
    @Test
    public void testStringSubstring() {
        assertEquals("hello", substring("hello world", 0, 5));
        assertEquals("world", substring("hello world", 6, 11));
        assertEquals("", substring("hello", 5, 5));
        assertNull(substring(null, 0, 5));
    }

    /**
     * 测试字符串替换
     */
    @Test
    public void testStringReplace() {
        assertEquals("hello java", replace("hello world", "world", "java"));
        assertEquals("hello world", replace("hello world", "xyz", "java"));
        assertNull(replace(null, "world", "java"));
    }

    // ==================== 数字处理测试 ====================

    /**
     * 测试数字格式化
     */
    @Test
    public void testNumberFormat() {
        assertEquals("1,234,567", formatNumber(1234567));
        assertEquals("123", formatNumber(123));
        assertEquals("0", formatNumber(0));
    }

    /**
     * 测试百分比格式化
     */
    @Test
    public void testPercentageFormat() {
        assertEquals("75.00%", formatPercentage(0.75));
        assertEquals("100.00%", formatPercentage(1.0));
        assertEquals("0.00%", formatPercentage(0.0));
    }

    /**
     * 测试数字四舍五入
     */
    @Test
    public void testNumberRound() {
        assertEquals(3.14, round(3.14159, 2));
        assertEquals(3.1, round(3.14159, 1));
        assertEquals(3.0, round(3.14159, 0));
    }

    /**
     * 测试数字范围检查
     */
    @Test
    public void testNumberRange() {
        assertTrue(isInRange(5, 1, 10));
        assertTrue(isInRange(1, 1, 10));
        assertTrue(isInRange(10, 1, 10));
        assertFalse(isInRange(0, 1, 10));
        assertFalse(isInRange(11, 1, 10));
    }

    // ==================== 集合处理测试 ====================

    /**
     * 测试集合判空
     */
    @Test
    public void testCollectionEmpty() {
        assertTrue(isCollectionEmpty(null));
        assertTrue(isCollectionEmpty(java.util.Collections.emptyList()));
        assertFalse(isCollectionEmpty(java.util.Arrays.asList("item")));
    }

    /**
     * 测试集合非空
     */
    @Test
    public void testCollectionNotEmpty() {
        assertFalse(isCollectionNotEmpty(null));
        assertFalse(isCollectionNotEmpty(java.util.Collections.emptyList()));
        assertTrue(isCollectionNotEmpty(java.util.Arrays.asList("item")));
    }

    /**
     * 测试集合大小
     */
    @Test
    public void testCollectionSize() {
        assertEquals(0, getCollectionSize(null));
        assertEquals(0, getCollectionSize(java.util.Collections.emptyList()));
        assertEquals(3, getCollectionSize(java.util.Arrays.asList("a", "b", "c")));
    }

    /**
     * 测试集合转换
     */
    @Test
    public void testCollectionConvert() {
        java.util.List<String> list = java.util.Arrays.asList("1", "2", "3");
        java.util.List<Integer> result = convertList(list, Integer::parseInt);

        assertNotNull(result);
        assertEquals(3, result.size());
        assertEquals(1, result.get(0));
        assertEquals(2, result.get(1));
        assertEquals(3, result.get(2));
    }

    // ==================== 辅助方法 ====================

    private boolean isEmpty(String str) {
        return str == null || str.trim().isEmpty();
    }

    private boolean isNotEmpty(String str) {
        return !isEmpty(str);
    }

    private String trim(String str) {
        return str == null ? null : str.trim();
    }

    private String substring(String str, int start, int end) {
        if (str == null) return null;
        if (start < 0 || end > str.length() || start > end) return "";
        return str.substring(start, end);
    }

    private String replace(String str, String target, String replacement) {
        if (str == null) return null;
        return str.replace(target, replacement);
    }

    private String formatNumber(long number) {
        return java.text.NumberFormat.getInstance().format(number);
    }

    private String formatPercentage(double value) {
        return String.format("%.2f%%", value * 100);
    }

    private double round(double value, int places) {
        if (places < 0) throw new IllegalArgumentException();
        long factor = (long) Math.pow(10, places);
        value = value * factor;
        long tmp = Math.round(value);
        return (double) tmp / factor;
    }

    private boolean isInRange(int value, int min, int max) {
        return value >= min && value <= max;
    }

    private boolean isCollectionEmpty(java.util.Collection<?> collection) {
        return collection == null || collection.isEmpty();
    }

    private boolean isCollectionNotEmpty(java.util.Collection<?> collection) {
        return !isCollectionEmpty(collection);
    }

    private int getCollectionSize(java.util.Collection<?> collection) {
        return collection == null ? 0 : collection.size();
    }

    private <T, R> java.util.List<R> convertList(java.util.List<T> list, java.util.function.Function<T, R> converter) {
        java.util.List<R> result = new java.util.ArrayList<>();
        if (list != null) {
            for (T item : list) {
                result.add(converter.apply(item));
            }
        }
        return result;
    }
}
