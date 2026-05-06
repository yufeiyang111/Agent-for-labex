package com.labex.controller;

import com.labex.common.Result;
import com.labex.dto.LoginRequest;
import com.labex.dto.PasswordUpdateRequest;
import com.labex.entity.Student;
import com.labex.entity.Teacher;
import com.labex.mapper.StudentMapper;
import com.labex.mapper.TeacherMapper;
import com.labex.security.JwtUtil;
import com.labex.service.TeacherService;
import com.labex.service.StudentService;
import com.labex.vo.LoginResponse;
import com.labex.vo.UserInfoVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

/**
 * 认证控制器
 */
@RestController
@RequestMapping("/auth")
@Slf4j
public class AuthController {

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private TeacherService teacherService;

    @Autowired
    private StudentService studentService;

    @Autowired
    private TeacherMapper teacherMapper;

    @Autowired
    private StudentMapper studentMapper;

    @Value("${jwt.prefix}")
    private String tokenPrefix;

    @Value("${upload-path}")
    private String uploadPath;

    private final PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    /**
     * 用户登录
     */
    @PostMapping("/login")
    public ResponseEntity<Result<LoginResponse>> login(@Valid @RequestBody LoginRequest request) {
        try {
            String account = request.getAccount();
            String rawPassword = request.getPassword();
            String role = request.getRole();

            // 验证用户
            Integer userId = null;
            String userName = null;
            String storedPassword = null;
            String finalRole = role;

            // 教师和管理员都存储在教师表中
            if ("TEACHER".equalsIgnoreCase(role) || "ADMIN".equalsIgnoreCase(role)) {
                Teacher teacher = teacherMapper.selectByAccount(account);
                if (teacher != null) {
                    // 如果用户实际角色是管理员，使用ADMIN
                    if ("ADMIN".equalsIgnoreCase(teacher.getRole())) {
                        finalRole = "ADMIN";
                    } else if ("ADMIN".equalsIgnoreCase(role)) {
                        // 选择管理员但用户不是管理员，拒绝登录
                        log.warn("用户 {} 不是管理员", account);
                        return ResponseEntity.ok(Result.error("该账号不是管理员"));
                    }
                    userId = teacher.getTeacherId();
                    userName = teacher.getTeacherName();
                    storedPassword = teacher.getTeacherPassword();
                }
            } else if ("STUDENT".equalsIgnoreCase(role)) {
                Student student = studentMapper.selectByStudentNo(account);
                if (student != null) {
                    userId = student.getStudentId();
                    userName = student.getStudentName();
                    storedPassword = student.getStudentPassword();
                }
            }

            // 检查用户是否存在
            if (userId == null) {
                log.warn("登录失败: 用户不存在 - {}", account);
                return ResponseEntity.ok(Result.error("账号或密码错误"));
            }

            // 验证密码 - 支持BCrypt、明文和MD5
            boolean passwordMatch = verifyPassword(rawPassword, storedPassword);
            if (!passwordMatch) {
                log.warn("登录失败: 密码错误 - {}", account);
                return ResponseEntity.ok(Result.error("账号或密码错误"));
            }

            // 生成Token
            String token = jwtUtil.generateToken(userId, account, finalRole);

            // 构建响应
            LoginResponse response = new LoginResponse();
            response.setToken(token);
            response.setExpiresIn(86400000L);

            UserInfoVO userInfo = new UserInfoVO();
            userInfo.setId(userId);
            userInfo.setAccount(account);
            userInfo.setRole(finalRole);
            userInfo.setName(userName != null ? userName : account);
            userInfo.setCreateTime(LocalDateTime.now());

            // 查询头像
            if ("STUDENT".equalsIgnoreCase(finalRole)) {
                Student student = studentMapper.selectByStudentNo(account);
                if (student != null) {
                    userInfo.setAvatar(student.getAvatar());
                }
            } else if ("TEACHER".equalsIgnoreCase(finalRole) || "ADMIN".equalsIgnoreCase(finalRole)) {
                Teacher teacher = teacherMapper.selectByAccount(account);
                if (teacher != null) {
                    userInfo.setAvatar(teacher.getAvatar());
                }
            }

            response.setUserInfo(userInfo);

            log.info("用户登录成功: {}, role: {}", account, role);
            return ResponseEntity.ok(Result.success("登录成功", response));

        } catch (Exception e) {
            log.error("登录异常", e);
            return ResponseEntity.ok(Result.error("登录失败: " + e.getMessage()));
        }
    }

    /**
     * 验证密码 - 支持BCrypt、明文和MD5
     */
    private boolean verifyPassword(String rawPassword, String storedPassword) {
        if (storedPassword == null) {
            return false;
        }

        // BCrypt 匹配
        if (storedPassword.startsWith("$2")) {
            return passwordEncoder.matches(rawPassword, storedPassword);
        }

        // MD5 匹配（32位十六进制字符串）
        if (storedPassword.length() == 32 && storedPassword.matches("^[a-fA-F0-9]{32}$")) {
            String rawMd5 = md5(rawPassword);
            return storedPassword.equalsIgnoreCase(rawMd5);
        }

        // 明文密码比较
        return storedPassword.equals(rawPassword);
    }

    /**
     * 计算MD5哈希
     */
    private String md5(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] messageDigest = md.digest(input.getBytes(StandardCharsets.UTF_8));
            BigInteger number = new BigInteger(1, messageDigest);
            String hashText = number.toString(16);
            // 补齐32位
            while (hashText.length() < 32) {
                hashText = "0" + hashText;
            }
            return hashText;
        } catch (NoSuchAlgorithmException e) {
            log.error("MD5计算失败", e);
            return null;
        }
    }

    /**
     * 退出登录
     */
    @PostMapping("/logout")
    public ResponseEntity<Result<Void>> logout() {
        log.info("用户退出登录");
        return ResponseEntity.ok(Result.success("退出成功", null));
    }

    /**
     * 获取当前用户信息
     */
    @GetMapping("/userinfo")
    public ResponseEntity<Result<UserInfoVO>> getUserInfo(HttpServletRequest request) {
        try {
            String authHeader = request.getHeader("Authorization");
            if (authHeader == null || !authHeader.startsWith(tokenPrefix)) {
                return ResponseEntity.ok(Result.error("未登录"));
            }

            String token = authHeader.substring(tokenPrefix.length());
            if (!jwtUtil.validateToken(token)) {
                return ResponseEntity.ok(Result.error("Token无效或已过期"));
            }

            Integer userId = jwtUtil.getUserIdFromToken(token);
            String account = jwtUtil.getUsernameFromToken(token);
            String role = jwtUtil.getRoleFromToken(token);

            UserInfoVO userInfo = new UserInfoVO();
            userInfo.setId(userId);
            userInfo.setAccount(account);
            userInfo.setRole(role);

            if ("STUDENT".equalsIgnoreCase(role)) {
                // 查询学生详细信息（含班级名称）
                UserInfoVO studentInfo = studentMapper.selectStudentWithClazzName(account);
                if (studentInfo != null) {
                    userInfo.setName(studentInfo.getName());
                    userInfo.setStudentNo(studentInfo.getStudentNo());
                    userInfo.setClazzNo(studentInfo.getClazzNo());
                    userInfo.setClazzName(studentInfo.getClazzName());
                    userInfo.setState(studentInfo.getState());
                    userInfo.setErrorCount(studentInfo.getErrorCount());
                    userInfo.setIp(studentInfo.getIp());
                    userInfo.setCreateTime(studentInfo.getCreateTime());
                    userInfo.setAvatar(studentInfo.getAvatar());
                }
            } else if ("TEACHER".equalsIgnoreCase(role) || "ADMIN".equalsIgnoreCase(role)) {
                // 查询教师详细信息
                Teacher teacher = teacherMapper.selectByAccount(account);
                if (teacher != null) {
                    userInfo.setName(teacher.getTeacherName());
                    userInfo.setTeacherAccount(teacher.getTeacherAccount());
                    userInfo.setState(teacher.getState());
                    userInfo.setAvatar(teacher.getAvatar());
                }
            }

            return ResponseEntity.ok(Result.success("获取成功", userInfo));

        } catch (Exception e) {
            log.error("获取用户信息异常", e);
            return ResponseEntity.ok(Result.error("获取用户信息失败"));
        }
    }

    /**
     * 修改密码
     */
    @PutMapping("/update-password")
    public ResponseEntity<Result<Void>> updatePassword(
            HttpServletRequest request,
            @Valid @RequestBody PasswordUpdateRequest passwordRequest) {
        try {
            String authHeader = request.getHeader("Authorization");
            if (authHeader == null || !authHeader.startsWith(tokenPrefix)) {
                return ResponseEntity.ok(Result.error("未登录"));
            }

            String token = authHeader.substring(tokenPrefix.length());
            if (!jwtUtil.validateToken(token)) {
                return ResponseEntity.ok(Result.error("Token无效或已过期"));
            }

            String account = jwtUtil.getUsernameFromToken(token);
            String role = jwtUtil.getRoleFromToken(token);

            String encodedPassword = passwordEncoder.encode(passwordRequest.getNewPassword());

            if ("STUDENT".equalsIgnoreCase(role)) {
                // 更新学生密码
                Student student = studentMapper.selectByStudentNo(account);
                if (student == null) {
                    return ResponseEntity.ok(Result.error("用户不存在"));
                }

                // 验证原密码
                if (!verifyPassword(passwordRequest.getOldPassword(), student.getStudentPassword())) {
                    return ResponseEntity.ok(Result.error("原密码错误"));
                }

                student.setStudentPassword(encodedPassword);
                studentMapper.updateById(student);

            } else if ("TEACHER".equalsIgnoreCase(role) || "ADMIN".equalsIgnoreCase(role)) {
                // 更新教师密码
                Teacher teacher = teacherMapper.selectByAccount(account);
                if (teacher == null) {
                    return ResponseEntity.ok(Result.error("用户不存在"));
                }

                // 验证原密码
                if (!verifyPassword(passwordRequest.getOldPassword(), teacher.getTeacherPassword())) {
                    return ResponseEntity.ok(Result.error("原密码错误"));
                }

                teacher.setTeacherPassword(encodedPassword);
                teacherMapper.updateById(teacher);
            }

            log.info("用户 {} 修改密码成功", account);
            return ResponseEntity.ok(Result.success("密码修改成功", null));

        } catch (Exception e) {
            log.error("修改密码异常", e);
            return ResponseEntity.ok(Result.error("修改密码失败"));
        }
    }

    /**
     * 上传头像
     */
    @PostMapping("/avatar")
    public ResponseEntity<Result<String>> uploadAvatar(
            HttpServletRequest request,
            @RequestParam("file") MultipartFile file) {
        try {
            String authHeader = request.getHeader("Authorization");
            if (authHeader == null || !authHeader.startsWith(tokenPrefix)) {
                return ResponseEntity.ok(Result.error("未登录"));
            }

            String token = authHeader.substring(tokenPrefix.length());
            if (!jwtUtil.validateToken(token)) {
                return ResponseEntity.ok(Result.error("Token无效或已过期"));
            }

            String account = jwtUtil.getUsernameFromToken(token);
            String role = jwtUtil.getRoleFromToken(token);

            // 验证文件类型
            String contentType = file.getContentType();
            if (contentType == null || !contentType.startsWith("image/")) {
                return ResponseEntity.ok(Result.error("只能上传图片文件"));
            }

            // 验证文件大小（最大5MB）
            if (file.getSize() > 5 * 1024 * 1024) {
                return ResponseEntity.ok(Result.error("头像大小不能超过5MB"));
            }

            // 创建上传目录
            String avatarDir = uploadPath + "/avatar";
            File dir = new File(avatarDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            // 生成文件名
            String originalFilename = file.getOriginalFilename();
            String extension = "";
            if (originalFilename != null && originalFilename.contains(".")) {
                extension = originalFilename.substring(originalFilename.lastIndexOf("."));
            }
            String fileName = account + "_" + System.currentTimeMillis() + extension;

            // 保存文件
            File avatarFile = new File(avatarDir, fileName);
            file.transferTo(avatarFile);

            // 生成访问URL
            String avatarUrl = "/api/auth/avatar/" + fileName;

            // 更新数据库
            if ("STUDENT".equalsIgnoreCase(role)) {
                Student student = studentMapper.selectByStudentNo(account);
                if (student != null) {
                    student.setAvatar(avatarUrl);
                    studentMapper.updateById(student);
                }
            } else if ("TEACHER".equalsIgnoreCase(role) || "ADMIN".equalsIgnoreCase(role)) {
                Teacher teacher = teacherMapper.selectByAccount(account);
                if (teacher != null) {
                    teacher.setAvatar(avatarUrl);
                    teacherMapper.updateById(teacher);
                }
            }

            log.info("用户 {} 上传头像成功: {}", account, avatarUrl);
            return ResponseEntity.ok(Result.success("头像上传成功", avatarUrl));

        } catch (Exception e) {
            log.error("上传头像异常", e);
            return ResponseEntity.ok(Result.error("上传头像失败"));
        }
    }

    /**
     * 获取头像
     */
    @GetMapping("/avatar")
    public ResponseEntity<byte[]> getAvatar(HttpServletRequest request) {
        try {
            String authHeader = request.getHeader("Authorization");
            if (authHeader == null || !authHeader.startsWith(tokenPrefix)) {
                return ResponseEntity.notFound().build();
            }

            String token = authHeader.substring(tokenPrefix.length());
            if (!jwtUtil.validateToken(token)) {
                return ResponseEntity.notFound().build();
            }

            String account = jwtUtil.getUsernameFromToken(token);
            String role = jwtUtil.getRoleFromToken(token);

            String avatarUrl = null;

            // 获取头像URL
            if ("STUDENT".equalsIgnoreCase(role)) {
                Student student = studentMapper.selectByStudentNo(account);
                if (student != null) {
                    avatarUrl = student.getAvatar();
                }
            } else if ("TEACHER".equalsIgnoreCase(role) || "ADMIN".equalsIgnoreCase(role)) {
                Teacher teacher = teacherMapper.selectByAccount(account);
                if (teacher != null) {
                    avatarUrl = teacher.getAvatar();
                }
            }

            // 如果没有头像，返回默认图片或404
            if (avatarUrl == null || avatarUrl.isEmpty()) {
                return ResponseEntity.notFound().build();
            }

            // 读取头像文件
            String fileName = avatarUrl.substring(avatarUrl.lastIndexOf("/") + 1);
            File avatarFile = new File(uploadPath + "/avatar", fileName);

            if (!avatarFile.exists()) {
                return ResponseEntity.notFound().build();
            }

            byte[] imageBytes = Files.readAllBytes(avatarFile.toPath());

            // 根据文件扩展名确定Content-Type
            String contentType = "image/jpeg";
            if (fileName.toLowerCase().endsWith(".png")) {
                contentType = "image/png";
            } else if (fileName.toLowerCase().endsWith(".gif")) {
                contentType = "image/gif";
            } else if (fileName.toLowerCase().endsWith(".webp")) {
                contentType = "image/webp";
            }

            return ResponseEntity.ok()
                    .contentType(org.springframework.http.MediaType.parseMediaType(contentType))
                    .body(imageBytes);

        } catch (Exception e) {
            log.error("获取头像异常", e);
            return ResponseEntity.notFound().build();
        }
    }

    /**
     * 获取外部头像文件（通过URL路径访问）
     */
    @GetMapping("/avatar/{fileName}")
    public ResponseEntity<byte[]> getAvatarFile(@PathVariable String fileName) {
        try {
            File avatarFile = new File(uploadPath + "/avatar", fileName);

            if (!avatarFile.exists()) {
                return ResponseEntity.notFound().build();
            }

            byte[] imageBytes = Files.readAllBytes(avatarFile.toPath());

            String contentType = "image/jpeg";
            if (fileName.toLowerCase().endsWith(".png")) {
                contentType = "image/png";
            } else if (fileName.toLowerCase().endsWith(".gif")) {
                contentType = "image/gif";
            } else if (fileName.toLowerCase().endsWith(".webp")) {
                contentType = "image/webp";
            }

            return ResponseEntity.ok()
                    .contentType(org.springframework.http.MediaType.parseMediaType(contentType))
                    .body(imageBytes);

        } catch (Exception e) {
            log.error("获取头像文件异常", e);
            return ResponseEntity.notFound().build();
        }
    }
}
