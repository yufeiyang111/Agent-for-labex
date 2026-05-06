package com.labex.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.Lecture;
import com.labex.mapper.LectureMapper;
import com.labex.service.LectureService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.File;
import java.util.List;

/**
 * 讲义服务实现类
 */
@Service
public class LectureServiceImpl extends ServiceImpl<LectureMapper, Lecture> implements LectureService {

    @Value("${upload-path:uploads}")
    private String uploadDir;

    @Override
    public List<Lecture> findByType(Integer type) {
        return this.baseMapper.selectByType(type);
    }

    @Override
    public List<Lecture> findUnvectorized() {
        return this.baseMapper.selectUnvectorized();
    }

    @Override
    public void updateVectorizedStatus(Integer lectureId, Integer status, String documentId) {
        this.baseMapper.updateVectorized(lectureId, status, documentId);
    }

    @Override
    public String getUploadPath() {
        if (uploadDir != null && uploadDir.startsWith("/") || uploadDir != null && uploadDir.matches("^[a-zA-Z]:.*")) {
            return uploadDir.endsWith(File.separator) ? uploadDir : uploadDir + File.separator;
        }
        return System.getProperty("user.dir") + File.separator + uploadDir + File.separator;
    }
}
