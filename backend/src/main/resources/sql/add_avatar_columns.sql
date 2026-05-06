-- 添加头像字段到教师表和学生表
-- 执行时间: 2026-04-23

-- 1. 给教师表添加头像字段
ALTER TABLE t_teacher ADD COLUMN avatar VARCHAR(500) DEFAULT NULL COMMENT '头像URL' AFTER teacher_password;

-- 2. 给学生表添加头像字段
ALTER TABLE t_student ADD COLUMN avatar VARCHAR(500) DEFAULT NULL COMMENT '头像URL' AFTER ip;
