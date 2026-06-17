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

    /**
     * 复制开课到新班级，包含评分项配置
     * @param sourceOfferingId 源开课ID
     * @param clazzNo 新班级编号
     * @return 新创建的开课实例
     */
    CourseOffering cloneOffering(Integer sourceOfferingId, String clazzNo);

    CourseOffering refreshStudentCount(Integer offeringId);

    CourseOffering updateStatus(Integer offeringId, Integer teacherId, String status);
}
