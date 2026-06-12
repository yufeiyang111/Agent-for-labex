package com.labex.service.teaching;

import com.baomidou.mybatisplus.extension.service.IService;
import com.labex.entity.teaching.CourseOffering;

import java.util.List;

/**
 * 开课服务（CTL-S1）
 */
public interface CourseOfferingService extends IService<CourseOffering> {

    List<CourseOffering> listByCourse(Integer courseId);

    List<CourseOffering> listByTeacher(Integer teacherId);

    CourseOffering createOffering(Integer courseId, String clazzNo, Integer teacherId, String semester);
}
