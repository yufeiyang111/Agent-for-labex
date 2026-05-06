-- Labex 数据库索引优化脚本
-- 在原数据库结构基础上添加必要索引以提升查询性能

-- 1. 学生表索引优化
-- 已存在：PRIMARY KEY (student_id), UNIQUE idx_student_no (student_no), KEY fk_clazz_no (clazz_no)
-- 新增：按班级查询学生时的索引
SET @index_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.STATISTICS 
                     WHERE TABLE_SCHEMA = 'labex' 
                     AND TABLE_NAME = 't_student' 
                     AND INDEX_NAME = 'idx_student_clazz_state');
SET @sql = IF(@index_exists = 0, 
              'CREATE INDEX idx_student_clazz_state ON t_student(clazz_no, state) COMMENT ''班级状态查询索引''',
              'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 2. 实验表索引优化
-- 已存在：PRIMARY KEY (experiment_id), KEY idx_experiment_no (experiment_no)
-- 新增：状态查询索引
SET @index_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.STATISTICS 
                     WHERE TABLE_SCHEMA = 'labex' 
                     AND TABLE_NAME = 't_experiment' 
                     AND INDEX_NAME = 'idx_experiment_state');
SET @sql = IF(@index_exists = 0, 
              'CREATE INDEX idx_experiment_state ON t_experiment(state) COMMENT ''实验状态查询索引''',
              'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 3. 实验题目表索引优化
-- 已存在：PRIMARY KEY (experiment_item_id), KEY fk_experiment_id (experiment_id), KEY idx_experiment_item_no (experiment_item_no)
-- 外键索引已经存在，无需重复创建

-- 4. 学生答题表索引优化
-- 已存在：PRIMARY KEY (student_item_id), UNIQUE idx_student_item (student_id, item_id), KEY fk_item_id (item_id)
-- 复合索引已存在，性能良好

-- 5. 成绩表索引优化
-- 已存在：PRIMARY KEY (score_id), KEY fk_score_student (student_id), KEY fk_score_experiment (experiment_id)
-- 新增：学生-实验复合查询
SET @index_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.STATISTICS 
                     WHERE TABLE_SCHEMA = 'labex' 
                     AND TABLE_NAME = 't_score' 
                     AND INDEX_NAME = 'idx_score_student_experiment');
SET @sql = IF(@index_exists = 0, 
              'CREATE INDEX idx_score_student_experiment ON t_score(student_id, experiment_id) COMMENT ''学生实验成绩查询索引''',
              'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 6. 学生练习表索引优化（旧系统兼容）
-- 已存在：PRIMARY KEY (id), KEY fk_excercise_item_id (item_id), KEY fk_student_excercise_id (student_id)
-- 新增：时间查询索引
SET @index_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.STATISTICS 
                     WHERE TABLE_SCHEMA = 'labex' 
                     AND TABLE_NAME = 't_student_excercise' 
                     AND INDEX_NAME = 'idx_excercise_fill_time');
SET @sql = IF(@index_exists = 0, 
              'CREATE INDEX idx_excercise_fill_time ON t_student_excercise(fill_time) COMMENT ''练习时间查询索引''',
              'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 7. 系统日志表索引优化
-- 已存在：PRIMARY KEY (id), KEY idx_time (time)
-- 新增：账号和时间复合查询
SET @index_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.STATISTICS 
                     WHERE TABLE_SCHEMA = 'labex' 
                     AND TABLE_NAME = 't_sys_log' 
                     AND INDEX_NAME = 'idx_sys_log_account_time');
SET @sql = IF(@index_exists = 0, 
              'CREATE INDEX idx_sys_log_account_time ON t_sys_log(account, time) COMMENT ''用户日志查询索引''',
              'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 8. 学生日志表索引优化
-- 已存在：PRIMARY KEY (id), KEY idx_time (time)
-- 新增：账号索引
SET @index_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.STATISTICS 
                     WHERE TABLE_SCHEMA = 'labex' 
                     AND TABLE_NAME = 't_student_log' 
                     AND INDEX_NAME = 'idx_student_log_account');
SET @sql = IF(@index_exists = 0, 
              'CREATE INDEX idx_student_log_account ON t_student_log(account) COMMENT ''学生账号日志索引''',
              'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 9. 讲义表索引优化（如果经常按类型查询）
-- 新增：类型索引
SET @index_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.STATISTICS 
                     WHERE TABLE_SCHEMA = 'labex' 
                     AND TABLE_NAME = 't_lecture' 
                     AND INDEX_NAME = 'idx_lecture_type');
SET @sql = IF(@index_exists = 0, 
              'CREATE INDEX idx_lecture_type ON t_lecture(lecture_type) COMMENT ''讲义类型查询索引''',
              'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 10. 学生答案表索引优化
-- 已存在：PRIMARY KEY (id), UNIQUE idx_answer_pk (item_id, fill_no, content_hash), KEY fk_answer_item_id (item_id)
-- 新增：学生ID索引（按学生查询答案）
SET @index_exists = (SELECT COUNT(*) FROM INFORMATION_SCHEMA.STATISTICS 
                     WHERE TABLE_SCHEMA = 'labex' 
                     AND TABLE_NAME = 't_student_answer' 
                     AND INDEX_NAME = 'idx_answer_student');
SET @sql = IF(@index_exists = 0, 
              'CREATE INDEX idx_answer_student ON t_student_answer(item_id, content_hash) COMMENT ''答案内容查询索引''',
              'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 11. 学生题目关联表（旧系统）
-- 已存在：PRIMARY KEY (id), UNIQUE idx_sq (student_id, question_id), KEY fk_question (question_id)
-- 无需新增

-- 12. 学生题目日志表
-- 已存在：PRIMARY KEY (log_id), KEY fk_student_item (student_item, fill_time)
-- 时间索引已存在

-- 索引统计信息
SELECT 
    TABLE_NAME,
    INDEX_NAME,
    COLUMN_NAME,
    SEQ_IN_INDEX,
    CARDINALITY
FROM INFORMATION_SCHEMA.STATISTICS 
WHERE TABLE_SCHEMA = 'labex' 
    AND TABLE_NAME IN (
        't_student', 't_experiment', 't_experiment_item', 
        't_student_item', 't_score', 't_sys_log', 't_student_log'
    )
ORDER BY TABLE_NAME, SEQ_IN_INDEX;
