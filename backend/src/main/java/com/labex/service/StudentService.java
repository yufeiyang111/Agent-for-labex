package com.labex.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.labex.entity.Student;

/**
 * 学生服务接口
 */
public interface StudentService extends IService<Student> {

    /**
     * 根据学号查询学生
     */
    Student findByStudentNo(String studentNo);

    /**
     * 批量导入学生
     */
    void batchImport(String clazzNo, java.util.List<Student> students);

    /**
     * 保存或更新学生，同时维护学生班级关联
     * @param student 学生信息
     * @param teacherId 教师ID
     * @param clazzNo 班级编号
     * @return 保存的学生（含ID）
     */
    Student saveOrUpdateStudent(Student student, Integer teacherId, String clazzNo);
}
