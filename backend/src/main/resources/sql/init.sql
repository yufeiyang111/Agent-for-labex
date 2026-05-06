-- Labex 数据库初始化脚本
-- 在原有数据库结构基础上创建

-- 使用数据库
USE labex;

-- 1. 修改教师表添加角色字段
ALTER TABLE t_teacher ADD COLUMN IF NOT EXISTS `role` VARCHAR(20) DEFAULT 'TEACHER' COMMENT '角色: TEACHER-教师, ADMIN-管理员';
ALTER TABLE t_teacher ADD COLUMN IF NOT EXISTS `state` INT DEFAULT 1 COMMENT '状态: 0-禁用, 1-启用';

-- 2. 创建管理员账号（密码：admin123）
INSERT INTO t_teacher (teacher_account, teacher_password, teacher_name, role)
VALUES ('admin', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EH', '系统管理员', 'ADMIN')
ON DUPLICATE KEY UPDATE teacher_name = '系统管理员', role = 'ADMIN';

-- 3. 添加系统配置
INSERT IGNORE INTO t_sys_config (param, value) VALUES
('system.name', 'Labex 实验教学管理系统'),
('system.version', '1.0.0'),
('upload.max.size', '104857600'),
('score.default', '0');

-- 4. 添加题目类型（如不存在）
INSERT IGNORE INTO t_question_type (type_id, type_name) VALUES
(1, '填空'),
(2, '单选'),
(3, '多选'),
(4, '判断'),
(5, '简答'),
(6, '编程'),
(7, '综合');

-- 5. 创建索引优化（如果不存在）
-- 学生表班级索引
SET @index_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.STATISTICS
                     WHERE TABLE_SCHEMA = DATABASE()
                     AND TABLE_NAME = 't_student'
                     AND INDEX_NAME = 'idx_student_clazz_state');
SET @sql = IF(@index_exists = 0,
              'CREATE INDEX idx_student_clazz_state ON t_student(clazz_no, state) COMMENT ''班级状态查询索引''',
              'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 实验状态索引
SET @index_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.STATISTICS
                     WHERE TABLE_SCHEMA = DATABASE()
                     AND TABLE_NAME = 't_experiment'
                     AND INDEX_NAME = 'idx_experiment_state');
SET @sql = IF(@index_exists = 0,
              'CREATE INDEX idx_experiment_state ON t_experiment(state) COMMENT ''实验状态查询索引''',
              'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 成绩复合索引
SET @index_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.STATISTICS
                     WHERE TABLE_SCHEMA = DATABASE()
                     AND TABLE_NAME = 't_score'
                     AND INDEX_NAME = 'idx_score_student_experiment');
SET @sql = IF(@index_exists = 0,
              'CREATE INDEX idx_score_student_experiment ON t_score(student_id, experiment_id) COMMENT ''学生实验成绩查询索引''',
              'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 练习时间索引
SET @index_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.STATISTICS
                     WHERE TABLE_SCHEMA = DATABASE()
                     AND TABLE_NAME = 't_student_excercise'
                     AND INDEX_NAME = 'idx_excercise_fill_time');
SET @sql = IF(@index_exists = 0,
              'CREATE INDEX idx_excercise_fill_time ON t_student_excercise(fill_time) COMMENT ''练习时间查询索引''',
              'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 日志账号时间索引
SET @index_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.STATISTICS
                     WHERE TABLE_SCHEMA = DATABASE()
                     AND TABLE_NAME = 't_sys_log'
                     AND INDEX_NAME = 'idx_sys_log_account_time');
SET @sql = IF(@index_exists = 0,
              'CREATE INDEX idx_sys_log_account_time ON t_sys_log(account, time) COMMENT ''用户日志查询索引''',
              'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 学生日志账号索引
SET @index_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.STATISTICS
                     WHERE TABLE_SCHEMA = DATABASE()
                     AND TABLE_NAME = 't_student_log'
                     AND INDEX_NAME = 'idx_student_log_account');
SET @sql = IF(@index_exists = 0,
              'CREATE INDEX idx_student_log_account ON t_student_log(account) COMMENT ''学生账号日志索引''',
              'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
