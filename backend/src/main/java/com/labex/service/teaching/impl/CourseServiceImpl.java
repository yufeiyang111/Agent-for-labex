package com.labex.service.teaching.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.teaching.Course;
import com.labex.entity.teaching.Syllabus;
import com.labex.mapper.teaching.CourseMapper;
import com.labex.mapper.teaching.SyllabusMapper;
import com.labex.service.teaching.CourseService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Slf4j
public class CourseServiceImpl extends ServiceImpl<CourseMapper, Course> implements CourseService {

    @Autowired
    private SyllabusMapper syllabusMapper;

    @Override
    public List<Course> listByOwner(Integer ownerId) {
        LambdaQueryWrapper<Course> wrapper = new LambdaQueryWrapper<>();
        if (ownerId != null) {
            wrapper.eq(Course::getOwnerId, ownerId);
        }
        wrapper.orderByDesc(Course::getCreateTime);
        return list(wrapper);
    }

    @Override
    @Transactional
    public Course createCourse(Course course, Integer ownerId) {
        course.setOwnerId(ownerId);
        save(course);
        // 自动建空大纲
        Syllabus s = new Syllabus();
        s.setCourseId(course.getCourseId());
        s.setVersion(1);
        s.setAchievementFormula(
                "课程分目标达成度 = 达到课程分目标分值学生人数 / 学生总人数；" +
                        "课程总目标达成度 = 达到课程总目标分值学生人数 / 学生总人数");
        syllabusMapper.insert(s);
        log.info("Created course {} with empty syllabus, owner={}", course.getCourseId(), ownerId);
        return course;
    }
}
