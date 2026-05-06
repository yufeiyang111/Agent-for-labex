package com.labex;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

/**
 * 密码加密工具 - 用于生成BCrypt加密密码
 * 运行 main 方法即可生成加密密码
 */
public class PasswordEncoderUtil {

    private static final BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

    public static void main(String[] args) {
        // 生成加密后的密码
        String[] passwords = {"root", "admin", "123456", "123", "teacher1", "student1"};
        
        System.out.println("===========================================");
        System.out.println("BCrypt加密后的密码（可直接存入数据库）");
        System.out.println("===========================================");
        
        for (String password : passwords) {
            String encoded = encoder.encode(password);
            System.out.println("原密码: " + password);
            System.out.println("加密后: " + encoded);
            System.out.println("-------------------------------------------");
        }
        
        System.out.println("\n验证示例:");
        String rawPassword = "root";
        String encodedPassword = encoder.encode(rawPassword);
        System.out.println("原密码: " + rawPassword);
        System.out.println("加密后: " + encodedPassword);
        System.out.println("验证结果: " + encoder.matches(rawPassword, encodedPassword));
    }
}
