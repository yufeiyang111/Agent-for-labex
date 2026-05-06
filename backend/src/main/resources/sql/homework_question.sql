-- 作业题目关联表 (支持多种题目类型混合在一个作业中)
CREATE TABLE IF NOT EXISTS t_homework_question (
    id          INT NOT NULL AUTO_INCREMENT COMMENT '记录ID',
    homework_id  INT NOT NULL COMMENT '作业ID',
    question_id  INT NOT NULL COMMENT '题目ID',
    score       INT DEFAULT 10 COMMENT '分值',
    sort_index  INT DEFAULT 0 COMMENT '排序',
    PRIMARY KEY (id),
    KEY idx_homework_question_homework (homework_id),
    KEY idx_homework_question_question (question_id),
    UNIQUE KEY uk_homework_question (homework_id, question_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='作业题目关联表';

-- 作业题目学生答案表
CREATE TABLE IF NOT EXISTS t_student_homework_question (
    id              INT NOT NULL AUTO_INCREMENT COMMENT '记录ID',
    homework_id      INT NOT NULL COMMENT '作业ID',
    student_id      INT NOT NULL COMMENT '学生ID',
    question_id     INT NOT NULL COMMENT '题目ID',
    my_answer       TEXT DEFAULT NULL COMMENT '学生答案',
    score           INT DEFAULT NULL COMMENT '得分',
    is_correct      INT DEFAULT NULL COMMENT '是否正确(1正确/0错误/null待批改)',
    graded          TINYINT(1) DEFAULT 0 COMMENT '是否已评分',
    fill_time       DATETIME DEFAULT NULL COMMENT '答题时间',
    PRIMARY KEY (id),
    KEY idx_shq_student (student_id),
    KEY idx_shq_homework (homework_id),
    UNIQUE KEY uk_shq (homework_id, student_id, question_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='学生作业答题记录';