package com.labex.service.teaching.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.teaching.CourseOffering;
import com.labex.mapper.teaching.CourseOfferingMapper;
import com.labex.service.teaching.CourseOfferingService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class CourseOfferingServiceImpl extends ServiceImpl<CourseOfferingMapper, CourseOffering>
        implements CourseOfferingService {

    @Override
    public List<CourseOffering> listByCourse(Integer courseId) {
        return list(new LambdaQueryWrapper<CourseOffering>()
                .eq(CourseOffering::getCourseId, courseId)
                .ne(CourseOffering::getStatus, "archived")
                .orderByDesc(CourseOffering::getSemester));
    }

    @Override
    public List<CourseOffering> listByTeacher(Integer teacherId) {
        return list(new LambdaQueryWrapper<CourseOffering>()
                .eq(CourseOffering::getTeacherId, teacherId)
                .ne(CourseOffering::getStatus, "archived")
                .orderByDesc(CourseOffering::getSemester));
    }

    @Override
    public CourseOffering createOffering(Integer courseId, String clazzNo, Integer teacherId, String semester) {
        // 幂等：相同 (course, clazz, semester) 已存在则直接返回，不再重建
        CourseOffering existing = getOne(new LambdaQueryWrapper<CourseOffering>()
                .eq(CourseOffering::getCourseId, courseId)
                .eq(CourseOffering::getClazzNo, clazzNo)
                .eq(CourseOffering::getSemester, semester));
        if (existing != null) {
            log.info("Offering already exists, returning existing: id={}", existing.getOfferingId());
            return existing;
        }
        CourseOffering o = new CourseOffering();
        o.setCourseId(courseId);
        o.setClazzNo(clazzNo);
        o.setTeacherId(teacherId);
        o.setSemester(semester);
        o.setStatus("active");
        o.setStudentCount(0);
        save(o);
        log.info("Created offering courseId={}, clazzNo={}, semester={}", courseId, clazzNo, semester);
        return o;
    }
}
