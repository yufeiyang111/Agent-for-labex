package com.labex.service.teaching;

import com.baomidou.mybatisplus.extension.service.IService;
import com.labex.entity.teaching.Course;

import java.util.List;

/**
 * 课程服务（CTL-S1）
 */
public interface CourseService extends IService<Course> {

    /** 列出某教师拥有的课程（owner_id 匹配） */
    List<Course> listByOwner(Integer ownerId);

    /** 创建课程并自动初始化空大纲 */
    Course createCourse(Course course, Integer ownerId);
}
