-- ============================================
-- 考试和作业功能数据库脚本
-- ============================================

USE labex;

-- ============================================
-- 1. 更新考试表 t_exam
-- ============================================
ALTER TABLE t_exam ADD COLUMN IF NOT EXISTS `exam_name` VARCHAR(100) DEFAULT NULL COMMENT '考试名称';
ALTER TABLE t_exam ADD COLUMN IF NOT EXISTS `paper_id` INT DEFAULT NULL COMMENT '关联试卷ID';
ALTER TABLE t_exam ADD COLUMN IF NOT EXISTS `total_score` INT DEFAULT NULL COMMENT '总分';
ALTER TABLE t_exam ADD COLUMN IF NOT EXISTS `state` INT DEFAULT 1 COMMENT '状态: 0-禁用, 1-启用';
ALTER TABLE t_exam ADD COLUMN IF NOT EXISTS `teacher_id` INT DEFAULT NULL COMMENT '所属教师ID';
ALTER TABLE t_exam ADD COLUMN IF NOT EXISTS `total_times` INT DEFAULT 1 COMMENT '允许考试次数';
ALTER TABLE t_exam ADD COLUMN IF NOT EXISTS `end_time` DATETIME DEFAULT NULL COMMENT '结束时间';

-- 添加索引
SET @index_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.STATISTICS
                     WHERE TABLE_SCHEMA = DATABASE()
                     AND TABLE_NAME = 't_exam'
                     AND INDEX_NAME = 'idx_exam_teacher');
SET @sql = IF(@index_exists = 0,
              'CREATE INDEX idx_exam_teacher ON t_exam(teacher_id) COMMENT ''考试教师查询索引''',
              'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @index_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.STATISTICS
                     WHERE TABLE_SCHEMA = DATABASE()
                     AND TABLE_NAME = 't_exam'
                     AND INDEX_NAME = 'idx_exam_state');
SET @sql = IF(@index_exists = 0,
              'CREATE INDEX idx_exam_state ON t_exam(state) COMMENT ''考试状态查询索引''',
              'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- ============================================
-- 2. 更新试卷表 t_paper
-- ============================================
ALTER TABLE t_paper ADD COLUMN IF NOT EXISTS `total_score` INT DEFAULT 100 COMMENT '总分';
ALTER TABLE t_paper ADD COLUMN IF NOT EXISTS `question_count` INT DEFAULT 0 COMMENT '题目数量';
ALTER TABLE t_paper ADD COLUMN IF NOT EXISTS `teacher_id` INT DEFAULT NULL COMMENT '所属教师ID';
ALTER TABLE t_paper ADD COLUMN IF NOT EXISTS `state` INT DEFAULT 1 COMMENT '状态: 0-禁用, 1-启用';

-- 添加索引
SET @index_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.STATISTICS
                     WHERE TABLE_SCHEMA = DATABASE()
                     AND TABLE_NAME = 't_paper'
                     AND INDEX_NAME = 'idx_paper_teacher');
SET @sql = IF(@index_exists = 0,
              'CREATE INDEX idx_paper_teacher ON t_paper(teacher_id) COMMENT ''试卷教师查询索引''',
              'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- ============================================
-- 3. 更新题库表 t_question
-- ============================================
ALTER TABLE t_question ADD COLUMN IF NOT EXISTS `score` INT DEFAULT 10 COMMENT '分值';
ALTER TABLE t_question ADD COLUMN IF NOT EXISTS `analysis` TEXT DEFAULT NULL COMMENT '答案解析';
ALTER TABLE t_question ADD COLUMN IF NOT EXISTS `options` TEXT DEFAULT NULL COMMENT '选项(JSON格式)';
ALTER TABLE t_question ADD COLUMN IF NOT EXISTS `teacher_id` INT DEFAULT NULL COMMENT '所属教师ID';
ALTER TABLE t_question ADD COLUMN IF NOT EXISTS `state` INT DEFAULT 1 COMMENT '状态: 0-禁用, 1-启用';

-- 添加索引
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

SET @index_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.STATISTICS
                     WHERE TABLE_SCHEMA = DATABASE()
                     AND TABLE_NAME = 't_question'
                     AND INDEX_NAME = 'idx_question_type');
SET @sql = IF(@index_exists = 0,
              'CREATE INDEX idx_question_type ON t_question(type) COMMENT ''题目类型查询索引''',
              'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- ============================================
-- 4. 创建试卷题目关联表 t_paper_question
-- ============================================
DROP TABLE IF EXISTS t_paper_question;
CREATE TABLE t_paper_question (
    `id` INT NOT NULL AUTO_INCREMENT COMMENT '关联ID',
    `paper_id` INT NOT NULL COMMENT '试卷ID',
    `question_id` INT NOT NULL COMMENT '题目ID',
    `sort` INT DEFAULT 1 COMMENT '排序',
    `score` INT DEFAULT 10 COMMENT '分值',
    PRIMARY KEY (`id`),
    KEY `idx_paper_question_paper` (`paper_id`),
    KEY `idx_paper_question_question` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='试卷题目关联表';

-- ============================================
-- 5. 创建学生答卷表 t_student_question
-- ============================================
DROP TABLE IF EXISTS t_student_question;
CREATE TABLE t_student_question (
    `id` INT NOT NULL AUTO_INCREMENT COMMENT '答卷ID',
    `student_id` INT NOT NULL COMMENT '学生ID',
    `exam_id` INT NOT NULL COMMENT '考试ID',
    `question_id` INT NOT NULL COMMENT '题目ID',
    `my_answer` TEXT DEFAULT NULL COMMENT '我的答案',
    `score` INT DEFAULT NULL COMMENT '得分',
    `is_correct` INT DEFAULT NULL COMMENT '是否正确: 0-错误, 1-正确',
    `fill_time` DATETIME DEFAULT NULL COMMENT '答题时间',
    PRIMARY KEY (`id`),
    KEY `idx_student_question_student` (`student_id`),
    KEY `idx_student_question_exam` (`exam_id`),
    UNIQUE KEY `uk_student_exam_question` (`student_id`, `exam_id`, `question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='学生答卷表';

-- ============================================
-- 6. 创建作业表 t_homework
-- ============================================
DROP TABLE IF EXISTS t_homework;
CREATE TABLE t_homework (
    `homework_id` INT NOT NULL AUTO_INCREMENT COMMENT '作业ID',
    `homework_name` VARCHAR(100) NOT NULL COMMENT '作业名称',
    `content` TEXT DEFAULT NULL COMMENT '作业内容(描述)',
    `deadline` DATETIME DEFAULT NULL COMMENT '截止时间',
    `teacher_id` INT DEFAULT NULL COMMENT '所属教师ID',
    `state` INT DEFAULT 1 COMMENT '状态: 0-禁用, 1-启用',
    `total_score` INT DEFAULT 100 COMMENT '总分',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `file_path` VARCHAR(255) DEFAULT NULL COMMENT '附件路径',
    `file_size` BIGINT DEFAULT NULL COMMENT '附件大小(字节)',
    PRIMARY KEY (`homework_id`),
    KEY `idx_homework_teacher` (`teacher_id`),
    KEY `idx_homework_state` (`state`),
    KEY `idx_homework_deadline` (`deadline`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='作业表';

-- ============================================
-- 7. 创建学生作业提交表 t_student_homework
-- ============================================
DROP TABLE IF EXISTS t_student_homework;
CREATE TABLE t_student_homework (
    `id` INT NOT NULL AUTO_INCREMENT COMMENT '提交ID',
    `homework_id` INT NOT NULL COMMENT '作业ID',
    `student_id` INT NOT NULL COMMENT '学生ID',
    `content` TEXT DEFAULT NULL COMMENT '文字说明',
    `file_path` VARCHAR(255) DEFAULT NULL COMMENT '附件路径',
    `file_size` BIGINT DEFAULT NULL COMMENT '附件大小(字节)',
    `submit_time` DATETIME DEFAULT NULL COMMENT '提交时间',
    `score` INT DEFAULT NULL COMMENT '得分',
    `remark` TEXT DEFAULT NULL COMMENT '教师评语',
    PRIMARY KEY (`id`),
    KEY `idx_student_homework_homework` (`homework_id`),
    KEY `idx_student_homework_student` (`student_id`),
    UNIQUE KEY `uk_student_homework` (`student_id`, `homework_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='学生作业提交表';

-- ============================================
-- 8. 确保题目类型表有数据
-- ============================================
INSERT IGNORE INTO t_question_type (type_id, type_name) VALUES
(1, '填空'),
(2, '单选'),
(3, '多选'),
(4, '判断'),
(5, '简答'),
(6, '编程'),
(7, '综合');

-- ============================================
-- 9. 添加索引用于学生答卷查询
-- ============================================
SET @index_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.STATISTICS
                     WHERE TABLE_SCHEMA = DATABASE()
                     AND TABLE_NAME = 't_student_question'
                     AND INDEX_NAME = 'idx_student_question_fill_time');
SET @sql = IF(@index_exists = 0,
              'CREATE INDEX idx_student_question_fill_time ON t_student_question(fill_time) COMMENT ''答卷时间查询索引''',
              'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- ============================================
-- 10. 添加索引用于学生作业提交查询
-- ============================================
SET @index_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.STATISTICS
                     WHERE TABLE_SCHEMA = DATABASE()
                     AND TABLE_NAME = 't_student_homework'
                     AND INDEX_NAME = 'idx_student_homework_submit_time');
SET @sql = IF(@index_exists = 0,
              'CREATE INDEX idx_student_homework_submit_time ON t_student_homework(submit_time) COMMENT ''作业提交时间查询索引''',
              'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SELECT '考试和作业数据库脚本执行完成！' AS message;
