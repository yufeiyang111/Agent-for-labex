-- 题目训练模块建表 SQL

DROP TABLE IF EXISTS t_student_training_question;
DROP TABLE IF EXISTS t_student_training;
DROP TABLE IF EXISTS t_training_set_question;
DROP TABLE IF EXISTS t_training_set;

-- 训练集表
CREATE TABLE t_training_set (
    training_set_id   INT          NOT NULL AUTO_INCREMENT COMMENT '训练集ID',
    name              VARCHAR(100) NOT NULL COMMENT '训练集名称',
    description       TEXT         DEFAULT NULL COMMENT '训练集描述',
    teacher_id        INT          NOT NULL COMMENT '创建教师ID',
    state             INT          DEFAULT 1 COMMENT '状态: 0-禁用, 1-启用',
    total_score       INT          DEFAULT 0 COMMENT '总分',
    create_time       DATETIME     DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (training_set_id),
    KEY idx_ts_teacher (teacher_id),
    KEY idx_ts_state (state)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='训练集表';

-- 训练集题目关联表
CREATE TABLE t_training_set_question (
    id              INT NOT NULL AUTO_INCREMENT COMMENT '记录ID',
    training_set_id INT NOT NULL COMMENT '训练集ID',
    question_id     INT NOT NULL COMMENT '题目ID',
    score           INT DEFAULT 10 COMMENT '分值',
    sort_index      INT DEFAULT 0 COMMENT '排序',
    PRIMARY KEY (id),
    KEY idx_tsq_training_set (training_set_id),
    KEY idx_tsq_question (question_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='训练集题目关联表';

-- 学生训练提交记录表
CREATE TABLE t_student_training (
    id              INT NOT NULL AUTO_INCREMENT COMMENT '记录ID',
    training_set_id INT NOT NULL COMMENT '训练集ID',
    student_id      INT NOT NULL COMMENT '学生ID',
    score           INT DEFAULT NULL COMMENT '本次得分',
    total_score     INT DEFAULT 0 COMMENT '总分',
    submit_time     DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '提交时间',
    attempt_count   INT DEFAULT 1 COMMENT '尝试次数',
    PRIMARY KEY (id),
    KEY idx_st_training_set (training_set_id),
    KEY idx_st_student (student_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='学生训练提交记录表';

-- 学生训练答题记录表
CREATE TABLE t_student_training_question (
    id              INT NOT NULL AUTO_INCREMENT COMMENT '记录ID',
    training_set_id INT NOT NULL COMMENT '训练集ID',
    student_id      INT NOT NULL COMMENT '学生ID',
    question_id     INT NOT NULL COMMENT '题目ID',
    my_answer       TEXT DEFAULT NULL COMMENT '学生答案',
    score           INT DEFAULT NULL COMMENT '得分',
    is_correct      INT DEFAULT 0 COMMENT '是否正确: 0-错误, 1-正确',
    submit_time     DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '答题时间',
    attempt_id      INT NOT NULL COMMENT '关联t_student_training的id',
    PRIMARY KEY (id),
    KEY idx_stq_training_student (training_set_id, student_id),
    KEY idx_stq_attempt (attempt_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='学生训练答题记录表';
