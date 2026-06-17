package com.labex.common;

import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.util.regex.Pattern;

import static org.junit.jupiter.api.Assertions.*;

/**
 * 数据验证测试
 * 测试人员：于峰
 * 测试内容：邮箱验证、手机号验证、密码验证、数字验证、日期验证
 */
public class ValidationTest {

    // ==================== 邮箱验证测试 ====================

    /**
     * 测试邮箱验证 - 有效邮箱
     */
    @Test
    public void testValidEmail() {
        assertTrue(isValidEmail("user@example.com"));
        assertTrue(isValidEmail("user.name@example.com"));
        assertTrue(isValidEmail("user+name@example.com"));
        assertTrue(isValidEmail("user@sub.example.com"));
        assertTrue(isValidEmail("user@example.co.jp"));
    }

    /**
     * 测试邮箱验证 - 无效邮箱
     */
    @Test
    public void testInvalidEmail() {
        assertFalse(isValidEmail(""));
        assertFalse(isValidEmail("user"));
        assertFalse(isValidEmail("user@"));
        assertFalse(isValidEmail("@example.com"));
        assertFalse(isValidEmail("user@.com"));
        assertFalse(isValidEmail("user@example."));
        assertFalse(isValidEmail("user @example.com"));
    }

    // ==================== 手机号验证测试 ====================

    /**
     * 测试手机号验证 - 有效手机号
     */
    @Test
    public void testValidPhone() {
        assertTrue(isValidPhone("13800138000"));
        assertTrue(isValidPhone("15912345678"));
        assertTrue(isValidPhone("18612345678"));
        assertTrue(isValidPhone("17612345678"));
    }

    /**
     * 测试手机号验证 - 无效手机号
     */
    @Test
    public void testInvalidPhone() {
        assertFalse(isValidPhone(""));
        assertFalse(isValidPhone("1234567890"));
        assertFalse(isValidPhone("12345678901"));
        assertFalse(isValidPhone("1380013800"));
        assertFalse(isValidPhone("138001380001"));
        assertFalse(isValidPhone("abc12345678"));
    }

    // ==================== 密码验证测试 ====================

    /**
     * 测试密码验证 - 有效密码
     */
    @Test
    public void testValidPassword() {
        assertTrue(isValidPassword("Password123"));
        assertTrue(isValidPassword("MyPass123!"));
        assertTrue(isValidPassword("Secure@123"));
        assertTrue(isValidPassword("Test1234"));
    }

    /**
     * 测试密码验证 - 无效密码
     */
    @Test
    public void testInvalidPassword() {
        assertFalse(isValidPassword(""));
        assertFalse(isValidPassword("123456"));
        assertFalse(isValidPassword("password"));
        assertFalse(isValidPassword("PASSWORD"));
        assertFalse(isValidPassword("Pass123"));
        assertFalse(isValidPassword("12345678"));
    }

    // ==================== 数字验证测试 ====================

    /**
     * 测试整数验证
     */
    @Test
    public void testIntegerValidation() {
        assertTrue(isInteger("123"));
        assertTrue(isInteger("-123"));
        assertTrue(isInteger("0"));
        assertFalse(isInteger(""));
        assertFalse(isInteger("12.3"));
        assertFalse(isInteger("abc"));
    }

    /**
     * 测试小数验证
     */
    @Test
    public void testDecimalValidation() {
        assertTrue(isDecimal("123.45"));
        assertTrue(isDecimal("-123.45"));
        assertTrue(isDecimal("0.45"));
        assertTrue(isDecimal("123"));
        assertFalse(isDecimal(""));
        assertFalse(isDecimal("abc"));
    }

    /**
     * 测试正数验证
     */
    @Test
    public void testPositiveNumberValidation() {
        assertTrue(isPositiveNumber("123"));
        assertTrue(isPositiveNumber("123.45"));
        assertTrue(isPositiveNumber("0.01"));
        assertFalse(isPositiveNumber("0"));
        assertFalse(isPositiveNumber("-123"));
        assertFalse(isPositiveNumber(""));
    }

    /**
     * 测试范围验证
     */
    @Test
    public void testRangeValidation() {
        assertTrue(isInRange(50, 0, 100));
        assertTrue(isInRange(0, 0, 100));
        assertTrue(isInRange(100, 0, 100));
        assertFalse(isInRange(-1, 0, 100));
        assertFalse(isInRange(101, 0, 100));
    }

    // ==================== 日期验证测试 ====================

    /**
     * 测试日期格式验证
     */
    @Test
    public void testDateFormatValidation() {
        assertTrue(isValidDateFormat("2024-10-01"));
        assertTrue(isValidDateFormat("2024-12-31"));
        assertTrue(isValidDateFormat("2000-01-01"));
        assertFalse(isValidDateFormat(""));
        assertFalse(isValidDateFormat("2024-13-01"));
        assertFalse(isValidDateFormat("2024-10-32"));
        assertFalse(isValidDateFormat("2024/10/01"));
    }

    /**
     * 测试日期时间格式验证
     */
    @Test
    public void testDateTimeFormatValidation() {
        assertTrue(isValidDateTimeFormat("2024-10-01 09:00:00"));
        assertTrue(isValidDateTimeFormat("2024-10-01 23:59:59"));
        assertFalse(isValidDateTimeFormat(""));
        assertFalse(isValidDateTimeFormat("2024-10-01"));
        assertFalse(isValidDateTimeFormat("2024-10-01 24:00:00"));
        assertFalse(isValidDateTimeFormat("2024-10-01 09:60:00"));
    }

    // ==================== 字符串长度验证测试 ====================

    /**
     * 测试字符串长度验证
     */
    @Test
    public void testStringLengthValidation() {
        assertTrue(isValidLength("hello", 1, 10));
        assertTrue(isValidLength("hello", 5, 5));
        assertTrue(isValidLength("", 0, 10));
        assertFalse(isValidLength("hello", 6, 10));
        assertFalse(isValidLength("hello world!", 1, 5));
    }

    /**
     * 测试用户名验证
     */
    @Test
    public void testUsernameValidation() {
        assertTrue(isValidUsername("user123"));
        assertTrue(isValidUsername("user_name"));
        assertTrue(isValidUsername("user-name"));
        assertTrue(isValidUsername("User123"));
        assertFalse(isValidUsername(""));
        assertFalse(isValidUsername("us"));
        assertFalse(isValidUsername("user@name"));
        assertFalse(isValidUsername("user name"));
    }

    // ==================== 特殊格式验证测试 ====================

    /**
     * 测试URL验证
     */
    @Test
    public void testUrlValidation() {
        assertTrue(isValidUrl("https://www.example.com"));
        assertTrue(isValidUrl("http://example.com"));
        assertTrue(isValidUrl("https://example.com/path"));
        assertTrue(isValidUrl("https://example.com/path?param=value"));
        assertFalse(isValidUrl(""));
        assertFalse(isValidUrl("example.com"));
        assertFalse(isValidUrl("ftp://example.com"));
    }

    /**
     * 测试IP地址验证
     */
    @Test
    public void testIpAddressValidation() {
        assertTrue(isValidIpAddress("192.168.1.1"));
        assertTrue(isValidIpAddress("10.0.0.1"));
        assertTrue(isValidIpAddress("255.255.255.255"));
        assertTrue(isValidIpAddress("0.0.0.0"));
        assertFalse(isValidIpAddress(""));
        assertFalse(isValidIpAddress("256.1.1.1"));
        assertFalse(isValidIpAddress("192.168.1"));
        assertFalse(isValidIpAddress("192.168.1.1.1"));
    }

    // ==================== 辅助方法 ====================

    private boolean isValidEmail(String email) {
        if (email == null || email.isEmpty()) return false;
        String regex = "^[A-Za-z0-9+_.-]+@(.+)$";
        return Pattern.matches(regex, email);
    }

    private boolean isValidPhone(String phone) {
        if (phone == null || phone.isEmpty()) return false;
        String regex = "^1[3-9]\\d{9}$";
        return Pattern.matches(regex, phone);
    }

    private boolean isValidPassword(String password) {
        if (password == null || password.length() < 8) return false;
        boolean hasUpper = false;
        boolean hasLower = false;
        boolean hasDigit = false;
        for (char c : password.toCharArray()) {
            if (Character.isUpperCase(c)) hasUpper = true;
            if (Character.isLowerCase(c)) hasLower = true;
            if (Character.isDigit(c)) hasDigit = true;
        }
        return hasUpper && hasLower && hasDigit;
    }

    private boolean isInteger(String str) {
        if (str == null || str.isEmpty()) return false;
        try {
            Integer.parseInt(str);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    private boolean isDecimal(String str) {
        if (str == null || str.isEmpty()) return false;
        try {
            new BigDecimal(str);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    private boolean isPositiveNumber(String str) {
        if (str == null || str.isEmpty()) return false;
        try {
            BigDecimal number = new BigDecimal(str);
            return number.compareTo(BigDecimal.ZERO) > 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    private boolean isInRange(int value, int min, int max) {
        return value >= min && value <= max;
    }

    private boolean isValidDateFormat(String date) {
        if (date == null || date.isEmpty()) return false;
        String regex = "^\\d{4}-\\d{2}-\\d{2}$";
        if (!Pattern.matches(regex, date)) return false;
        try {
            String[] parts = date.split("-");
            int year = Integer.parseInt(parts[0]);
            int month = Integer.parseInt(parts[1]);
            int day = Integer.parseInt(parts[2]);
            if (month < 1 || month > 12) return false;
            if (day < 1 || day > 31) return false;
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    private boolean isValidDateTimeFormat(String dateTime) {
        if (dateTime == null || dateTime.isEmpty()) return false;
        String regex = "^\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}$";
        if (!Pattern.matches(regex, dateTime)) return false;
        try {
            String[] parts = dateTime.split(" ");
            String[] dateParts = parts[0].split("-");
            String[] timeParts = parts[1].split(":");
            int month = Integer.parseInt(dateParts[1]);
            int day = Integer.parseInt(dateParts[2]);
            int hour = Integer.parseInt(timeParts[0]);
            int minute = Integer.parseInt(timeParts[1]);
            int second = Integer.parseInt(timeParts[2]);
            if (month < 1 || month > 12) return false;
            if (day < 1 || day > 31) return false;
            if (hour < 0 || hour > 23) return false;
            if (minute < 0 || minute > 59) return false;
            if (second < 0 || second > 59) return false;
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    private boolean isValidLength(String str, int min, int max) {
        if (str == null) return min == 0;
        int length = str.length();
        return length >= min && length <= max;
    }

    private boolean isValidUsername(String username) {
        if (username == null || username.isEmpty()) return false;
        if (username.length() < 3 || username.length() > 20) return false;
        String regex = "^[A-Za-z0-9_-]+$";
        return Pattern.matches(regex, username);
    }

    private boolean isValidUrl(String url) {
        if (url == null || url.isEmpty()) return false;
        String regex = "^https?://[^\\s]+$";
        return Pattern.matches(regex, url);
    }

    private boolean isValidIpAddress(String ip) {
        if (ip == null || ip.isEmpty()) return false;
        String regex = "^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$";
        return Pattern.matches(regex, ip);
    }
}
