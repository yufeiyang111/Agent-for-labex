-- =====================================================
-- Labex 实验教学管理系统 - 数据库表结构
-- 版本: 1.0.0
-- 创建时间: 2026-04-15
-- =====================================================

-- 创建数据库（如果不存在）
CREATE DATABASE IF NOT EXISTS labex DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE labex;

-- =====================================================
-- 1. 教师/管理员表 (t_teacher)
-- 存储教师和管理员信息，role字段区分角色
-- =====================================================
DROP TABLE IF EXISTS t_teacher;
CREATE TABLE t_teacher (
    teacher_id     INT          NOT NULL AUTO_INCREMENT COMMENT '教师ID',
    teacher_account VARCHAR(20)  NOT NULL COMMENT '账号(唯一)',
    teacher_password VARCHAR(255) NOT NULL COMMENT '密码(BCrypt加密)',
    teacher_name   VARCHAR(20)  NOT NULL COMMENT '姓名',
    role           VARCHAR(20)  DEFAULT 'TEACHER' COMMENT '角色: TEACHER-教师, ADMIN-管理员',
    state          INT          DEFAULT 1 COMMENT '状态: 0-禁用, 1-启用',
    PRIMARY KEY (teacher_id),
    UNIQUE KEY uk_teacher_account (teacher_account)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='教师/管理员表';

-- =====================================================
-- 2. 班级表 (t_clazz)
-- =====================================================
DROP TABLE IF EXISTS t_clazz;
CREATE TABLE t_clazz (
    no   VARCHAR(20) NOT NULL COMMENT '班级编号',
    memo TEXT COMMENT '描述',
    state INT DEFAULT 1 COMMENT '状态: 0-禁用, 1-启用',
    teacher_id INT DEFAULT NULL COMMENT '所属教师ID',
    PRIMARY KEY (no),
    KEY idx_clazz_teacher (teacher_id),
    FOREIGN KEY (teacher_id) REFERENCES t_teacher(teacher_id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='班级表';

-- 如果表已存在，添加teacher_id字段（MySQL）
ALTER TABLE t_clazz ADD COLUMN teacher_id INT DEFAULT NULL COMMENT '所属教师ID' AFTER state;
ALTER TABLE t_clazz ADD INDEX idx_clazz_teacher (teacher_id);

-- =====================================================
-- 3. 学生表 (t_student)
-- =====================================================
DROP TABLE IF EXISTS t_student;
CREATE TABLE t_student (
    student_id        INT          NOT NULL AUTO_INCREMENT COMMENT '学生ID',
    student_no       VARCHAR(20)  NOT NULL COMMENT '学号(唯一)',
    student_name     VARCHAR(20)  NOT NULL COMMENT '姓名',
    student_password VARCHAR(255) NOT NULL COMMENT '密码(BCrypt加密)',
    clazz_no         VARCHAR(20)  DEFAULT NULL COMMENT '班级编号',
    memo             TEXT COMMENT '备注',
    state            INT          DEFAULT 1 COMMENT '状态: 0-禁用, 1-启用',
    error_count      INT          DEFAULT 0 COMMENT '密码错误次数',
    ip               VARCHAR(100) DEFAULT NULL COMMENT '绑定IP地址',
    PRIMARY KEY (student_id),
    UNIQUE KEY uk_student_no (student_no),
    KEY idx_student_clazz (clazz_no),
    KEY idx_student_state (state)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='学生表';

-- =====================================================
-- 4. 实验表 (t_experiment)
-- =====================================================
DROP TABLE IF EXISTS t_experiment;
CREATE TABLE t_experiment (
    experiment_id          INT          NOT NULL AUTO_INCREMENT COMMENT '实验ID',
    experiment_no         INT          NOT NULL COMMENT '实验编号',
    experiment_name       VARCHAR(100) NOT NULL COMMENT '实验名称',
    experiment_type       INT          DEFAULT NULL COMMENT '实验类型',
    instruction_type      VARCHAR(10)  DEFAULT NULL COMMENT '题型',
    experiment_requirement TEXT        DEFAULT NULL COMMENT '实验要求',
    experiment_content    TEXT          DEFAULT NULL COMMENT '实验内容',
    state                 INT          DEFAULT 1 COMMENT '状态: 0-禁用, 1-启用',
    PRIMARY KEY (experiment_id),
    UNIQUE KEY uk_experiment_no (experiment_no),
    KEY idx_experiment_state (state)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='实验表';

-- =====================================================
-- 5. 实验题目表 (t_experiment_item)
-- =====================================================
DROP TABLE IF EXISTS t_experiment_item;
CREATE TABLE t_experiment_item (
    experiment_item_id      INT          NOT NULL AUTO_INCREMENT COMMENT '题目ID',
    experiment_item_no      INT          NOT NULL COMMENT '题目编号',
    experiment_item_name    VARCHAR(100) NOT NULL COMMENT '题目名称',
    experiment_item_type    INT          NOT NULL COMMENT '题目类型(1-填空,2-单选,3-多选,4-判断,5-简答)',
    experiment_item_content TEXT          DEFAULT NULL COMMENT '题目内容',
    experiment_id           INT          NOT NULL COMMENT '所属实验ID',
    experiment_item_answer   VARCHAR(255) DEFAULT NULL COMMENT '答案',
    experiment_item_score   INT          DEFAULT 10 COMMENT '分值',
    state                   INT          DEFAULT 1 COMMENT '状态: 0-禁用, 1-启用',
    PRIMARY KEY (experiment_item_id),
    KEY idx_item_experiment (experiment_id),
    KEY idx_item_experiment_no (experiment_id, experiment_item_no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='实验题目表';

-- =====================================================
-- 6. 成绩表 (t_score)
-- =====================================================
DROP TABLE IF EXISTS t_score;
CREATE TABLE t_score (
    score_id      INT NOT NULL AUTO_INCREMENT COMMENT '成绩ID',
    student_id    INT  NOT NULL COMMENT '学生ID',
    experiment_id INT  NOT NULL COMMENT '实验ID',
    score         INT  DEFAULT 0 COMMENT '得分',
    PRIMARY KEY (score_id),
    UNIQUE KEY uk_score (student_id, experiment_id),
    KEY idx_score_experiment (experiment_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='成绩表';

-- =====================================================
-- 7. 讲义表 (t_lecture)
-- =====================================================
DROP TABLE IF EXISTS t_lecture;
CREATE TABLE t_lecture (
    lecture_id      INT          NOT NULL AUTO_INCREMENT COMMENT '讲义ID',
    lecture_name    VARCHAR(100) NOT NULL COMMENT '讲义名称',
    lecture_type    INT          DEFAULT NULL COMMENT '讲义类型',
    lecture_filetype VARCHAR(20)  DEFAULT NULL COMMENT '文件类型',
    PRIMARY KEY (lecture_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='讲义表';

-- =====================================================
-- 8. 题目类型表 (t_question_type)
-- =====================================================
DROP TABLE IF EXISTS t_question_type;
CREATE TABLE t_question_type (
    type_id   INT          NOT NULL COMMENT '类型ID',
    type_name VARCHAR(20)  NOT NULL COMMENT '类型名称',
    PRIMARY KEY (type_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='题目类型表';

-- =====================================================
-- 9. 系统配置表 (t_sys_config)
-- =====================================================
DROP TABLE IF EXISTS t_sys_config;
CREATE TABLE t_sys_config (
    param  VARCHAR(100) NOT NULL COMMENT '配置参数',
    value  VARCHAR(500)  DEFAULT NULL COMMENT '配置值',
    PRIMARY KEY (param)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统配置表';

-- =====================================================
-- 10. 系统日志表 (t_sys_log)
-- =====================================================
DROP TABLE IF EXISTS t_sys_log;
CREATE TABLE t_sys_log (
    id      INT          NOT NULL AUTO_INCREMENT COMMENT '日志ID',
    account VARCHAR(50)  DEFAULT NULL COMMENT '账号',
    type    INT          DEFAULT NULL COMMENT '日志类型: 1-登录成功, 2-登录失败, 3-其他',
    info    VARCHAR(500) DEFAULT NULL COMMENT '日志信息',
    time    DATETIME     DEFAULT NULL COMMENT '操作时间',
    ip      VARCHAR(100) DEFAULT NULL COMMENT 'IP地址',
    PRIMARY KEY (id),
    KEY idx_sys_log_account_time (account, time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统日志表';

-- =====================================================
-- 11. 学生答题表 (t_student_item)
-- =====================================================
DROP TABLE IF EXISTS t_student_item;
CREATE TABLE t_student_item (
    student_item_id INT       NOT NULL AUTO_INCREMENT COMMENT '答题记录ID',
    student_id      INT       NOT NULL COMMENT '学生ID',
    item_id         INT       NOT NULL COMMENT '题目ID',
    content         TEXT      DEFAULT NULL COMMENT '答题内容',
    score           INT       DEFAULT NULL COMMENT '得分(教师评分)',
    fill_time       DATETIME  DEFAULT NULL COMMENT '答题时间',
    score_flag      INT       DEFAULT 0 COMMENT '评分标记: 0-未评分, 1-已评分',
    PRIMARY KEY (student_item_id),
    UNIQUE KEY uk_student_item (student_id, item_id),
    KEY idx_student_item_fill_time (fill_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='学生答题表';

-- =====================================================
-- 12. 学生答案记录表 (t_student_answer)
-- =====================================================
DROP TABLE IF EXISTS t_student_answer;
CREATE TABLE t_student_answer (
    id           BIGINT     NOT NULL AUTO_INCREMENT COMMENT '记录ID',
    item_id      INT        NOT NULL COMMENT '题目ID',
    fill_no      INT        DEFAULT NULL COMMENT '填写序号',
    content      TEXT       DEFAULT NULL COMMENT '答案内容',
    content_hash VARCHAR(64) DEFAULT NULL COMMENT '内容哈希(去重)',
    count        INT        DEFAULT 1 COMMENT '填写次数',
    is_correct   TINYINT(1) DEFAULT NULL COMMENT '是否正确',
    PRIMARY KEY (id),
    KEY idx_answer_item (item_id),
    KEY idx_answer_content_hash (content_hash)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='学生答案记录表';

-- =====================================================
-- 13. 学生日志表 (t_student_log)
-- =====================================================
DROP TABLE IF EXISTS t_student_log;
CREATE TABLE t_student_log (
    id      INT          NOT NULL AUTO_INCREMENT COMMENT '日志ID',
    account VARCHAR(50)  DEFAULT NULL COMMENT '学号',
    type    INT          DEFAULT NULL COMMENT '日志类型',
    info    VARCHAR(500) DEFAULT NULL COMMENT '日志信息',
    time    DATETIME     DEFAULT NULL COMMENT '操作时间',
    ip      VARCHAR(100) DEFAULT NULL COMMENT 'IP地址',
    PRIMARY KEY (id),
    KEY idx_student_log_account (account)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='学生日志表';

-- =====================================================
-- 14. 学生答题日志表 (t_student_item_log)
-- =====================================================
DROP TABLE IF EXISTS t_student_item_log;
CREATE TABLE t_student_item_log (
    log_id       BIGINT   NOT NULL AUTO_INCREMENT COMMENT '日志ID',
    student_item INT      NOT NULL COMMENT '学生答题ID',
    content      TEXT     DEFAULT NULL COMMENT '答题内容',
    fill_time    DATETIME DEFAULT NULL COMMENT '答题时间',
    PRIMARY KEY (log_id),
    KEY idx_item_log_student_item (student_item)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='学生答题日志表';

-- =====================================================
-- 15. 学生练习表 (t_student_excercise)
-- =====================================================
DROP TABLE IF EXISTS t_student_excercise;
CREATE TABLE t_student_excercise (
    id        BIGINT   NOT NULL AUTO_INCREMENT COMMENT '记录ID',
    item_id   INT      NOT NULL COMMENT '题目ID',
    student_id INT      NOT NULL COMMENT '学生ID',
    answer    TEXT     DEFAULT NULL COMMENT '答案',
    content   TEXT     DEFAULT NULL COMMENT '内容',
    score     INT      DEFAULT NULL COMMENT '得分',
    fill_time DATETIME DEFAULT NULL COMMENT '答题时间',
    PRIMARY KEY (id),
    KEY idx_excercise_student (student_id),
    KEY idx_excercise_fill_time (fill_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='学生练习表';

-- =====================================================
-- 16. 题库表 (t_question)
-- =====================================================
DROP TABLE IF EXISTS t_question;
CREATE TABLE t_question (
    id       INT          NOT NULL AUTO_INCREMENT COMMENT '题目ID',
    question VARCHAR(500) NOT NULL COMMENT '题目内容',
    answer   VARCHAR(255) DEFAULT NULL COMMENT '答案',
    type     INT          DEFAULT NULL COMMENT '题目类型',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='题库表';

-- =====================================================
-- 17. 试卷表 (t_paper)
-- =====================================================
DROP TABLE IF EXISTS t_paper;
CREATE TABLE t_paper (
    id          INT       NOT NULL AUTO_INCREMENT COMMENT '试卷ID',
    no          INT       NOT NULL COMMENT '试卷编号',
    name        VARCHAR(100) DEFAULT NULL COMMENT '试卷名称',
    description VARCHAR(500) DEFAULT NULL COMMENT '试卷描述',
    time        DATETIME  DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='试卷表';

-- =====================================================
-- 18. 试卷题目关联表 (t_paper_question)
-- =====================================================
DROP TABLE IF EXISTS t_paper_question;
CREATE TABLE t_paper_question (
    id          INT NOT NULL AUTO_INCREMENT COMMENT '记录ID',
    paper_id    INT  NOT NULL COMMENT '试卷ID',
    question_id INT  NOT NULL COMMENT '题目ID',
    score       INT  DEFAULT NULL COMMENT '分值',
    PRIMARY KEY (id),
    KEY idx_paper_question_paper (paper_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='试卷题目关联表';

-- =====================================================
-- 19. 考试表 (t_exam)
-- =====================================================
DROP TABLE IF EXISTS t_exam;
CREATE TABLE t_exam (
    id          INT       NOT NULL AUTO_INCREMENT COMMENT '考试ID',
    description VARCHAR(100) NOT NULL COMMENT '考试描述',
    duration    INT       DEFAULT NULL COMMENT '时长(分钟)',
    time        DATETIME  DEFAULT NULL COMMENT '考试时间',
    flag        TINYINT(1) DEFAULT NULL COMMENT '开放标记',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='考试表';

-- =====================================================
-- 20. 学生问题关联表 (t_student_question)
-- =====================================================
DROP TABLE IF EXISTS t_student_question;
CREATE TABLE t_student_question (
    id          INT          NOT NULL AUTO_INCREMENT COMMENT '记录ID',
    student_id  INT          NOT NULL COMMENT '学生ID',
    question_id INT          NOT NULL COMMENT '题目ID',
    answer      VARCHAR(255) DEFAULT NULL COMMENT '答案',
    PRIMARY KEY (id),
    KEY idx_student_question_student (student_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='学生问题关联表';

-- =====================================================
-- 初始化数据
-- =====================================================

-- 插入管理员账号 (密码: admin123)
INSERT INTO t_teacher (teacher_account, teacher_password, teacher_name, role, state)
VALUES ('admin', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EH', '系统管理员', 'ADMIN', 1);

-- 插入题目类型
INSERT INTO t_question_type (type_id, type_name) VALUES
(1, '填空'),
(2, '单选'),
(3, '多选'),
(4, '判断'),
(5, '简答'),
(6, '编程'),
(7, '综合');

-- 插入系统配置
INSERT INTO t_sys_config (param, value) VALUES
('system.name', 'Labex 实验教学管理系统'),
('system.version', '1.0.0'),
('upload.max.size', '104857600'),
('score.default', '0');

-- 插入示例班级
INSERT INTO t_clazz (no, memo, state) VALUES
('182011', '胡老师班', 1),
('182012', '安老师班', 1),
('992011', '公共班级', 1);

-- =====================================================
-- 视图定义
-- =====================================================

-- 学生成绩视图
CREATE OR REPLACE VIEW v_student_score AS
SELECT
    s.student_id,
    s.student_no,
    s.student_name,
    s.clazz_no,
    sc.experiment_id,
    e.experiment_name,
    sc.score
FROM t_student s
LEFT JOIN t_score sc ON s.student_id = sc.student_id
LEFT JOIN t_experiment e ON sc.experiment_id = e.experiment_id;

-- 班级学生统计视图
CREATE OR REPLACE VIEW v_clazz_student_count AS
SELECT
    c.no AS clazz_no,
    c.memo AS clazz_name,
    COUNT(s.student_id) AS student_count
FROM t_clazz c
LEFT JOIN t_student s ON c.no = s.clazz_no
GROUP BY c.no, c.memo;