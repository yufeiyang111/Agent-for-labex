package com.labex.dto;

import lombok.Data;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import java.util.List;

/**
 * 批量导入学生DTO
 */
@Data
public class StudentBatchImportRequest {

    @NotEmpty(message = "学生列表不能为空")
    private List<StudentImportItem> students;

    @NotNull(message = "班级编号不能为空")
    private String clazzNo;
}
