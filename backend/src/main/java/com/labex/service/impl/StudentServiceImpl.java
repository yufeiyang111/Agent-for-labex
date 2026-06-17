package com.labex.service.impl;

import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.Student;
import com.labex.entity.StudentClazz;
import com.labex.mapper.StudentMapper;
import com.labex.service.StudentClazzService;
import com.labex.service.StudentService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 学生服务实现类
 */
@Service
public class StudentServiceImpl extends ServiceImpl<StudentMapper, Student> implements StudentService {

    private static final Logger log = LoggerFactory.getLogger(StudentServiceImpl.class);

    @Autowired
    private StudentClazzService studentClazzService;

    @Override
    public Student findByStudentNo(String studentNo) {
        return this.baseMapper.selectByStudentNo(studentNo);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void batchImport(String clazzNo, List<Student> students) {
        if (CollUtil.isEmpty(students)) {
            return;
        }

        // 批量插入
        this.saveBatch(students, 1000);
        log.info("批量导入学生成功，班级：{}，数量：{}", clazzNo, students.size());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Student saveOrUpdateStudent(Student student, Integer teacherId, String clazzNo) {
        // 先查找是否已存在
        Student existing = findByStudentNo(student.getStudentNo());

        if (existing != null) {
            // 更新姓名等信息
            existing.setStudentName(student.getStudentName());
            existing.setMemo(student.getMemo());
            existing.setState(student.getState() != null ? student.getState() : 1);
            existing.setClazzNo(clazzNo);
            this.updateById(existing);

            // 检查是否已关联该班级，没有则添加关联
            if (!studentClazzService.existsByStudentIdAndClazzNo(existing.getStudentId(), clazzNo)) {
                StudentClazz sc = new StudentClazz();
                sc.setStudentId(existing.getStudentId());
                sc.setClazzNo(clazzNo);
                sc.setTeacherId(teacherId);
                studentClazzService.save(sc);
                log.info("学生 {} 关联到班级 {}", student.getStudentNo(), clazzNo);
            }

            return existing;
        } else {
            // 新增学生
            student.setClazzNo(clazzNo);
            student.setState(student.getState() != null ? student.getState() : 1);
            student.setStudentPassword(student.getStudentPassword() != null ?
                    student.getStudentPassword() : student.getStudentNo());
            this.save(student);

            // 创建关联
            StudentClazz sc = new StudentClazz();
            sc.setStudentId(student.getStudentId());
            sc.setClazzNo(clazzNo);
            sc.setTeacherId(teacherId);
            studentClazzService.save(sc);

            log.info("新增学生 {} 并关联到班级 {}", student.getStudentNo(), clazzNo);
            return student;
        }
    }

    @Override
    public List<Student> listByTeachingClazz(String clazzNo) {
        if (clazzNo == null || clazzNo.isBlank()) {
            return List.of();
        }

        Set<Integer> relatedStudentIds = studentClazzService.findByClazzNo(clazzNo).stream()
                .map(StudentClazz::getStudentId)
                .filter(java.util.Objects::nonNull)
                .collect(Collectors.toSet());

        LambdaQueryWrapper<Student> wrapper = new LambdaQueryWrapper<>();
        if (relatedStudentIds.isEmpty()) {
            wrapper.eq(Student::getClazzNo, clazzNo);
        } else {
            wrapper.and(w -> w.eq(Student::getClazzNo, clazzNo)
                    .or()
                    .in(Student::getStudentId, relatedStudentIds));
        }
        wrapper.orderByAsc(Student::getStudentNo);
        return list(wrapper);
    }
}
