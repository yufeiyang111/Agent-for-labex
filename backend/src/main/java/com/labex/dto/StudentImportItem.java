package com.labex.dto;

import lombok.Data;

/**
 * 学生导入项
 */
@Data
public class StudentImportItem {

    /**
     * 学号
     */
    private String studentNo;

    /**
     * 学生姓名
     */
    private String studentName;
}
