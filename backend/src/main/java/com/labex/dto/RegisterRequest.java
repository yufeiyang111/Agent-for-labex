package com.labex.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Data;

/**
 * 学生注册请求DTO
 */
@Data
public class RegisterRequest {

    @NotBlank(message = "学号不能为空")
    @Size(min = 4, max = 20, message = "学号长度需为4-20位")
    @Pattern(regexp = "^[A-Za-z0-9_-]+$", message = "学号只能包含字母、数字、下划线或短横线")
    private String studentNo;

    @NotBlank(message = "姓名不能为空")
    @Size(min = 2, max = 20, message = "姓名长度需为2-20位")
    private String studentName;

    @Size(max = 20, message = "班级编号不能超过20位")
    private String clazzNo;

    @NotBlank(message = "密码不能为空")
    @Size(min = 6, max = 64, message = "密码长度需为6-64位")
    private String password;
}
