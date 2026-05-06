-- ============================================
-- Labex 数据库结构更新脚本
-- 修复题库管理、学生多对多关联问题
-- ============================================

USE labex;

-- ============================================
-- 1. 为题库表添加 teacher_id 字段（如果不存在）
-- ============================================
SET @column_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
                      WHERE TABLE_SCHEMA = DATABASE()
                      AND TABLE_NAME = 't_question'
                      AND COLUMN_NAME = 'teacher_id');
SET @sql = IF(@column_exists = 0,
              'ALTER TABLE t_question ADD COLUMN teacher_id INT DEFAULT NULL COMMENT ''所属教师ID'' AFTER `type`',
              'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 添加题库教师索引（如果不存在）
SET @index_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.STATISTICS
                     WHERE TABLE_SCHEMA = DATABASE()
                     AND TABLE_NAME = 't_question'
                     AND INDEX_NAME = 'idx_question_teacher');
SET @sql = IF(@index_exists = 0,
              'CREATE INDEX idx_question_teacher ON t_question(teacher_id) COMMENT ''题库教师查询索引''',
              'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- ============================================
-- 2. 创建学生班级关联表
-- ============================================
DROP TABLE IF EXISTS t_student_clazz;
CREATE TABLE t_student_clazz (
    `id` INT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `student_id` INT NOT NULL COMMENT '学生ID',
    `clazz_no` VARCHAR(50) NOT NULL COMMENT '班级编号',
    `teacher_id` INT NOT NULL COMMENT '教师ID（便于查询）',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_student_clazz` (`student_id`, `clazz_no`),
    KEY `idx_student_clazz_clazz` (`clazz_no`),
    KEY `idx_student_clazz_teacher` (`teacher_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='学生班级关联表';

-- ============================================
-- 3. 初始化学生班级关联数据（将已有的学生班级关系迁移过来）
-- ============================================
INSERT INTO t_student_clazz (student_id, clazz_no, teacher_id)
SELECT s.student_id, s.clazz_no, c.teacher_id
FROM t_student s
INNER JOIN t_clazz c ON s.clazz_no = c.no
WHERE s.clazz_no IS NOT NULL AND s.clazz_no != ''
AND NOT EXISTS (
    SELECT 1 FROM t_student_clazz sc
    WHERE sc.student_id = s.student_id AND sc.clazz_no = s.clazz_no
);

-- ============================================
-- 4. 为学生表添加创建时间字段
-- ============================================
SET @column_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
                      WHERE TABLE_SCHEMA = DATABASE()
                      AND TABLE_NAME = 't_student'
                      AND COLUMN_NAME = 'create_time');
SET @sql = IF(@column_exists = 0,
              'ALTER TABLE t_student ADD COLUMN create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT ''创建时间''',
              'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @column_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
                      WHERE TABLE_SCHEMA = DATABASE()
                      AND TABLE_NAME = 't_student'
                      AND COLUMN_NAME = 'update_time');
SET @sql = IF(@column_exists = 0,
              'ALTER TABLE t_student ADD COLUMN update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT ''更新时间''',
              'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- ============================================
-- 验证结果
-- ============================================
SELECT '题库表 teacher_id 列数' AS check_item, COUNT(*) AS count
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 't_question' AND COLUMN_NAME = 'teacher_id';

SELECT '学生班级关联表记录数' AS check_item, COUNT(*) AS count
FROM t_student_clazz;

SELECT '数据库更新完成！' AS message;
