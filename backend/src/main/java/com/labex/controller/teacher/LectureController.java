package com.labex.controller.teacher;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.labex.common.Result;
import com.labex.common.PageResult;
import com.labex.entity.Lecture;
import com.labex.entity.Teacher;
import com.labex.rag.service.RagService;
import com.labex.service.LectureService;
import com.labex.service.TeacherService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * 教师-讲义管理控制器
 */
@RestController
@RequestMapping("/teacher/lecture")
@PreAuthorize("hasRole('TEACHER')")
@Slf4j
public class LectureController {

    @Autowired
    private LectureService lectureService;

    @Autowired
    private TeacherService teacherService;

    @Autowired
    private RagService ragService;

    @Value("${upload-path:uploads}")
    private String uploadDir;

    private String getUploadPath() {
        if (uploadDir != null && uploadDir.startsWith("/") || uploadDir != null && uploadDir.matches("^[a-zA-Z]:.*")) {
            return uploadDir.endsWith(File.separator) ? uploadDir : uploadDir + File.separator;
        }
        return System.getProperty("user.dir") + File.separator + uploadDir + File.separator;
    }

    private Integer getCurrentTeacherId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null) {
            Teacher teacher = teacherService.findByAccount(authentication.getName());
            if (teacher != null) {
                return teacher.getTeacherId();
            }
        }
        return null;
    }

    @GetMapping("/list")
    public Result<PageResult<Lecture>> list(
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "20") Integer pageSize,
            @RequestParam(required = false) Integer type,
            @RequestParam(required = false) String category) {
        Integer teacherId = getCurrentTeacherId();
        LambdaQueryWrapper<Lecture> wrapper = new LambdaQueryWrapper<>();
        if (teacherId != null) {
            wrapper.eq(Lecture::getTeacherId, teacherId);
        }
        if (type != null) {
            wrapper.eq(Lecture::getLectureType, type);
        }
        if (category != null && !category.isEmpty()) {
            wrapper.eq(Lecture::getCategory, category);
        }
        wrapper.orderByDesc(Lecture::getLectureId);
        Page<Lecture> p = lectureService.page(new Page<>(page, pageSize), wrapper);
        PageResult<Lecture> pageResult = new PageResult<>();
        pageResult.setPageNum(page);
        pageResult.setPageSize(pageSize);
        pageResult.setTotal(p.getTotal());
        pageResult.setList(p.getRecords());
        pageResult.setTotalPages((int) Math.ceil((double) p.getTotal() / pageSize));
        return Result.success(pageResult);
    }

    @GetMapping("/categories")
    public Result<List<String>> getCategories() {
        Integer teacherId = getCurrentTeacherId();
        LambdaQueryWrapper<Lecture> wrapper = new LambdaQueryWrapper<>();
        if (teacherId != null) {
            wrapper.eq(Lecture::getTeacherId, teacherId);
        }
        wrapper.isNotNull(Lecture::getCategory);
        wrapper.select(Lecture::getCategory);
        wrapper.groupBy(Lecture::getCategory);
        List<Lecture> lectures = lectureService.list(wrapper);
        List<String> categories = lectures.stream()
                .map(Lecture::getCategory)
                .filter(c -> c != null && !c.isEmpty())
                .collect(Collectors.toList());
        return Result.success(categories);
    }

    @GetMapping("/all")
    public Result<List<Lecture>> getAll() {
        Integer teacherId = getCurrentTeacherId();
        LambdaQueryWrapper<Lecture> wrapper = new LambdaQueryWrapper<>();
        if (teacherId != null) {
            wrapper.eq(Lecture::getTeacherId, teacherId);
        }
        return Result.success(lectureService.list(wrapper));
    }

    @GetMapping("/{id}")
    public Result<Lecture> getById(@PathVariable Integer id) {
        Lecture lecture = lectureService.getById(id);
        if (lecture != null) {
            return Result.success(lecture);
        }
        return Result.error("讲义不存在");
    }

    @PostMapping
    public Result<Void> add(@Valid @RequestBody Lecture lecture) {
        Integer teacherId = getCurrentTeacherId();
        if (teacherId != null) {
            lecture.setTeacherId(teacherId);
        }
        boolean success = lectureService.save(lecture);
        if (success) {
            log.info("新增讲义: {}, 教师ID: {}", lecture.getLectureName(), teacherId);
            return Result.success("添加成功", null);
        }
        return Result.error("添加失败");
    }

    @PutMapping("/{id}")
    public Result<Void> update(@PathVariable Integer id, @Valid @RequestBody Lecture lecture) {
        lecture.setLectureId(id);
        boolean success = lectureService.updateById(lecture);
        if (success) {
            log.info("更新讲义: {}", id);
            return Result.success("修改成功", null);
        }
        return Result.error("修改失败");
    }

    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Integer id) {
        Lecture lecture = lectureService.getById(id);
        if (lecture != null && lecture.getDocumentId() != null) {
            ragService.deleteLectureVector(lecture.getDocumentId());
        }
        boolean success = lectureService.removeById(id);
        if (success) {
            log.info("删除讲义: {}", id);
            return Result.success("删除成功", null);
        }
        return Result.error("删除失败");
    }

    @PostMapping("/upload")
    public Result<String> uploadFile(@RequestParam("file") MultipartFile file) {
        log.info("开始处理文件上传请求");
        log.info("文件信息: name={}, size={}", file.getOriginalFilename(), file.getSize());

        if (file.isEmpty()) {
            log.warn("文件为空");
            return Result.error("文件为空");
        }

        String uploadPath = getUploadPath();
        log.info("上传目录: {}", uploadPath);

        File dir = new File(uploadPath);
        if (!dir.exists()) {
            boolean created = dir.mkdirs();
            log.info("创建上传目录: {}, 结果: {}", uploadPath, created);
        }

        String originalFilename = file.getOriginalFilename();
        String suffix = originalFilename.substring(originalFilename.lastIndexOf('.'));
        String filename = UUID.randomUUID() + suffix;

        try {
            File dest = new File(uploadPath + filename);
            log.info("目标文件路径: {}", dest.getAbsolutePath());
            file.transferTo(dest);

            if (dest.exists()) {
                log.info("文件上传成功: {}, 大小: {} bytes", filename, dest.length());
                return Result.success("上传成功", filename);
            } else {
                log.error("文件上传后验证失败，文件不存在");
                return Result.error("上传失败：文件未成功保存");
            }
        } catch (IOException e) {
            log.error("文件上传失败", e);
            return Result.error("上传失败: " + e.getMessage());
        }
    }

    @PostMapping("/upload-with-vectorize")
    public Result<Map<String, Object>> uploadAndVectorize(@RequestParam("file") MultipartFile file) {
        Result<String> uploadResult = uploadFile(file);
        if (uploadResult.getCode() != 0) {
            return Result.error(uploadResult.getMessage());
        }

        String filename = uploadResult.getData();
        Integer teacherId = getCurrentTeacherId();
        Lecture lecture = new Lecture();
        lecture.setLectureName(file.getOriginalFilename().substring(0, file.getOriginalFilename().lastIndexOf('.')));
        lecture.setFilePath(filename);
        lecture.setTeacherId(teacherId);

        String suffix = filename.substring(filename.lastIndexOf('.'));
        lecture.setLectureFiletype(suffix.substring(1).toLowerCase());
        lecture.setFileSize(file.getSize());

        boolean saved = lectureService.save(lecture);
        if (!saved) {
            return Result.error("保存讲义记录失败");
        }

        try {
            ragService.vectorizeLectureAsync(lecture);
        } catch (Exception e) {
            log.warn("启动向量化失败: {}", e.getMessage());
        }

        Map<String, Object> result = new HashMap<>();
        result.put("lectureId", lecture.getLectureId());
        result.put("filename", filename);
        result.put("vectorizing", true);

        return Result.success(result);
    }

    @GetMapping("/preview/{id}")
    @PreAuthorize("hasAnyRole('TEACHER', 'STUDENT')")
    public void previewFile(@PathVariable Integer id, HttpServletResponse response) {
        Lecture lecture = lectureService.getById(id);
        if (lecture == null) {
            try {
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().write("{\"code\":500,\"msg\":\"讲义不存在\"}");
            } catch (IOException e) {
                log.error("写入响应失败", e);
            }
            return;
        }

        String filePath = lecture.getFilePath();
        if (filePath == null || filePath.isEmpty()) {
            try {
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().write("{\"code\":500,\"msg\":\"文件路径不存在\"}");
            } catch (IOException e) {
                log.error("写入响应失败", e);
            }
            return;
        }

        File file = new File(getUploadPath() + filePath);
        log.info("查找预览文件: {}, 绝对路径: {}", filePath, file.getAbsolutePath());
        if (!file.exists()) {
            try {
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().write("{\"code\":500,\"msg\":\"文件不存在: " + file.getAbsolutePath() + "\"}");
            } catch (IOException e) {
                log.error("写入响应失败", e);
            }
            return;
        }

        try {
            String fileType = lecture.getLectureFiletype() != null ? lecture.getLectureFiletype().toLowerCase() : "";
            String contentType = getContentType(fileType);
            String fileName = URLEncoder.encode(lecture.getLectureName() + "." + fileType, StandardCharsets.UTF_8);

            response.setContentType(contentType);
            response.setHeader("Content-Disposition", "inline; filename=\"" + fileName + "\"");
            response.setHeader("Content-Length", String.valueOf(file.length()));
            response.setHeader("X-Content-Type-Options", "nosniff");
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Expires", "0");
            response.setCharacterEncoding("UTF-8");
            response.setHeader("Access-Control-Allow-Origin", "*");

            try (BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));
                 OutputStream os = response.getOutputStream()) {
                byte[] buffer = new byte[8192];
                int bytesRead;
                while ((bytesRead = bis.read(buffer)) != -1) {
                    os.write(buffer, 0, bytesRead);
                }
                os.flush();
            }
            log.info("文件预览成功: {}", filePath);
        } catch (IOException e) {
            log.error("文件预览失败", e);
            try {
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().write("{\"code\":500,\"msg\":\"预览失败: " + e.getMessage() + "\"}");
            } catch (IOException ex) {
                log.error("写入响应失败", ex);
            }
        }
    }

    private String getContentType(String fileType) {
        return switch (fileType) {
            case "pdf" -> "application/pdf";
            case "doc", "docx" -> "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
            case "xls", "xlsx" -> "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            case "ppt", "pptx" -> "application/vnd.openxmlformats-officedocument.presentationml.presentation";
            case "jpg", "jpeg" -> "image/jpeg";
            case "png" -> "image/png";
            case "gif" -> "image/gif";
            case "webp" -> "image/webp";
            case "svg" -> "image/svg+xml";
            default -> "application/octet-stream";
        };
    }

    @GetMapping("/download/{id}")
    public void downloadFile(@PathVariable Integer id, HttpServletResponse response) {
        Lecture lecture = lectureService.getById(id);
        if (lecture == null) {
            try {
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().write("{\"code\":500,\"msg\":\"讲义不存在\"}");
            } catch (IOException e) {
                log.error("写入响应失败", e);
            }
            return;
        }

        String filePath = lecture.getFilePath();
        if (filePath == null || filePath.isEmpty()) {
            try {
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().write("{\"code\":500,\"msg\":\"文件路径不存在\"}");
            } catch (IOException e) {
                log.error("写入响应失败", e);
            }
            return;
        }

        File file = new File(getUploadPath() + filePath);
        log.info("查找下载文件: {}", file.getAbsolutePath());
        if (!file.exists()) {
            try {
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().write("{\"code\":500,\"msg\":\"文件不存在\"}");
            } catch (IOException e) {
                log.error("写入响应失败", e);
            }
            return;
        }

        try {
            String fileName = URLEncoder.encode(lecture.getLectureName() + "." + lecture.getLectureFiletype(), StandardCharsets.UTF_8);
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment;filename=" + fileName);
            response.setContentLengthLong(file.length());

            try (BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));
                 java.io.OutputStream out = response.getOutputStream()) {
                byte[] buffer = new byte[4096];
                int len;
                while ((len = bis.read(buffer)) != -1) {
                    out.write(buffer, 0, len);
                }
                out.flush();
            }
            log.info("文件下载成功: {}", filePath);
        } catch (IOException e) {
            log.error("文件下载失败", e);
            try {
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().write("{\"code\":500,\"msg\":\"下载失败\"}");
            } catch (IOException ex) {
                log.error("写入响应失败", ex);
            }
        }
    }
}