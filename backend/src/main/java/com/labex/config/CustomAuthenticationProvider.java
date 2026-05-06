package com.labex.config;

import com.labex.entity.Student;
import com.labex.entity.Teacher;
import com.labex.mapper.StudentMapper;
import com.labex.mapper.TeacherMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.Collections;

/**
 * 自定义认证提供者 - 支持BCrypt和明文密码
 */
@Component
@Slf4j
public class CustomAuthenticationProvider implements AuthenticationProvider {

    @Autowired
    private TeacherMapper teacherMapper;

    @Autowired
    private StudentMapper studentMapper;

    private final PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        String username = authentication.getName();
        String rawPassword = authentication.getCredentials().toString();

        // 先查询教师表
        Teacher teacher = teacherMapper.selectByAccount(username);
        if (teacher != null) {
            if (verifyPassword(rawPassword, teacher.getTeacherPassword())) {
                log.info("教师登录成功: {}", username);
                return new UsernamePasswordAuthenticationToken(
                        username,
                        teacher.getTeacherPassword(),
                        Collections.singletonList(new SimpleGrantedAuthority("ROLE_TEACHER"))
                );
            } else {
                throw new BadCredentialsException("账号或密码错误");
            }
        }

        // 查询学生表
        Student student = studentMapper.selectByStudentNo(username);
        if (student != null) {
            if (verifyPassword(rawPassword, student.getStudentPassword())) {
                log.info("学生登录成功: {}", username);
                return new UsernamePasswordAuthenticationToken(
                        username,
                        student.getStudentPassword(),
                        Collections.singletonList(new SimpleGrantedAuthority("ROLE_STUDENT"))
                );
            } else {
                throw new BadCredentialsException("账号或密码错误");
            }
        }

        log.warn("用户不存在: {}", username);
        throw new BadCredentialsException("用户不存在");
    }

    /**
     * 验证密码 - 支持BCrypt和明文两种格式
     */
    private boolean verifyPassword(String rawPassword, String storedPassword) {
        // 先尝试 BCrypt 匹配
        if (storedPassword != null && storedPassword.startsWith("$2")) {
            return passwordEncoder.matches(rawPassword, storedPassword);
        }
        // 如果不是BCrypt格式，尝试直接比较（兼容明文密码开发环境）
        if (storedPassword != null && storedPassword.equals(rawPassword)) {
            log.debug("使用明文密码验证（建议生产环境使用BCrypt加密）");
            return true;
        }
        return false;
    }

    @Override
    public boolean supports(Class<?> authentication) {
        return UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication);
    }
}
