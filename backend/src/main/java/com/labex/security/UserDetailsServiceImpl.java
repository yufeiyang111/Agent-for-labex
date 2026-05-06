package com.labex.security;

import com.baomidou.mybatisplus.core.toolkit.StringPool;
import com.labex.entity.Teacher;
import com.labex.entity.Student;
import com.labex.mapper.TeacherMapper;
import com.labex.mapper.StudentMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Collections;

/**
 * 用户详情服务
 */
@Service
@Slf4j
public class UserDetailsServiceImpl implements UserDetailsService {

    @Autowired
    private TeacherMapper teacherMapper;

    @Autowired
    private StudentMapper studentMapper;

    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // 先查询教师表
        Teacher teacher = teacherMapper.selectByAccount(username);
        if (teacher != null) {
            log.debug("找到教师用户: {}, role: {}", username, teacher.getRole());
            // 根据role决定权限
            String authority = "TEACHER".equalsIgnoreCase(teacher.getRole())
                    ? "ROLE_TEACHER"
                    : "ROLE_ADMIN";
            return User.withUsername(teacher.getTeacherAccount())
                    .password(teacher.getTeacherPassword())
                    .authorities(authority)
                    .accountExpired(false)
                    .accountLocked(false)
                    .credentialsExpired(false)
                    .disabled(false)
                    .build();
        }

        // 查询学生表
        Student student = studentMapper.selectByStudentNo(username);
        if (student != null) {
            log.debug("找到学生用户: {}", username);
            return User.withUsername(student.getStudentNo())
                    .password(student.getStudentPassword())
                    .authorities("ROLE_STUDENT")
                    .accountExpired(false)
                    .accountLocked(false)
                    .credentialsExpired(false)
                    .disabled(student.getState() != null && student.getState() == 1)
                    .build();
        }

        log.warn("用户不存在: {}", username);
        throw new UsernameNotFoundException("用户不存在");
    }

    /**
     * 验证密码 - 支持BCrypt和明文两种格式
     */
    public boolean passwordMatches(String rawPassword, String encodedPassword) {
        // 先尝试 BCrypt 匹配
        if (passwordEncoder.matches(rawPassword, encodedPassword)) {
            return true;
        }
        // 如果不是BCrypt格式，尝试直接比较（兼容明文密码开发环境）
        if (encodedPassword != null && encodedPassword.equals(rawPassword)) {
            log.info("使用明文密码验证（建议生产环境使用BCrypt加密）");
            return true;
        }
        return false;
    }
}
