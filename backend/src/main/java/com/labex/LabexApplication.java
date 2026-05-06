package com.labex;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * Labex 实验教学管理系统启动类
 *
 * @author Labex Team
 * @since 2026
 */
@SpringBootApplication
@MapperScan("com.labex.mapper")
@ComponentScan("com.labex")
@EnableScheduling
@EnableAsync
public class LabexApplication {

    public static void main(String[] args) {
        SpringApplication.run(LabexApplication.class, args);
    }

}