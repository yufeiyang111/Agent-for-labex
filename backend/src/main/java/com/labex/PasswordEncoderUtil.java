package com.labex;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

/**
 * 密码加密工具 - 用于生成BCrypt加密密码
 * 运行 main 方法即可生成加密密码
 * 用法: java -cp labex.jar com.labex.PasswordEncoderUtil <password1> [password2] ...
 */
public class PasswordEncoderUtil {

    private static final BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

    public static void main(String[] args) {
        if (args.length == 0) {
            System.out.println("用法: PasswordEncoderUtil <password1> [password2] ...");
            System.out.println("示例: PasswordEncoderUtil mypassword admin123");
            System.exit(1);
        }

        System.out.println("===========================================");
        System.out.println("BCrypt加密后的密码（可直接存入数据库）");
        System.out.println("===========================================");

        for (String password : args) {
            String encoded = encoder.encode(password);
            System.out.println("原密码: " + password);
            System.out.println("加密后: " + encoded);
            System.out.println("-------------------------------------------");
        }
    }

    /**
     * 加密密码
     */
    public static String encode(String rawPassword) {
        return encoder.encode(rawPassword);
    }

    /**
     * 验证密码
     */
    public static boolean matches(String rawPassword, String encodedPassword) {
        return encoder.matches(rawPassword, encodedPassword);
    }
}
