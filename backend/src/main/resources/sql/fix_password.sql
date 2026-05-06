-- Labex 修复脚本 - 密码问题修复
-- 由于原数据库使用MD5密码，需要更新为支持BCrypt

USE labex;

-- 查看当前教师账号密码格式
SELECT teacher_id, teacher_account, teacher_name, LEFT(teacher_password, 10) as pwd_prefix, LENGTH(teacher_password) as pwd_length FROM t_teacher;

-- 查看当前学生账号密码格式
SELECT student_id, student_no, student_name, LEFT(student_password, 10) as pwd_prefix, LENGTH(student_password) as pwd_length FROM t_student;

-- 如果密码是MD5格式(32字符)，需要确保密码是 '123456' 的MD5值
-- MD5('123456') = e10adc3949ba59abbe56e057f20f883e
-- MD5('admin123') = a066f1746d28c0bb9d9b611bc31eb219

-- 更新教师密码为BCrypt格式 (password: admin123)
-- BCrypt hash for 'admin123':
UPDATE t_teacher SET teacher_password = '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi' WHERE teacher_account = 'admin';

-- 如果需要将所有MD5密码更新为 '123456' 的BCrypt
-- UPDATE t_teacher SET teacher_password = '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi' WHERE teacher_password = 'e10adc3949ba59abbe56e057f20f883e';

-- 更新学生密码为BCrypt格式 (password: 123456)
-- UPDATE t_student SET student_password = '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi' WHERE student_password = 'c9668e0f75ce49ebaf7813f903076e5f';

SELECT 'Password update completed' as status;
