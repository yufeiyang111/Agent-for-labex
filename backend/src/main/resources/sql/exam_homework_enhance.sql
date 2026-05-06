-- 编程题测试用例表
CREATE TABLE IF NOT EXISTS t_question_test_case (
    id INT AUTO_INCREMENT PRIMARY KEY,
    question_id INT NOT NULL,
    input TEXT COMMENT '测试输入',
    expected_output TEXT COMMENT '期望输出',
    score_weight INT DEFAULT 1 COMMENT '权重',
    sort_index INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (question_id) REFERENCES t_question(id) ON DELETE CASCADE
);

-- 考试评分状态表
CREATE TABLE IF NOT EXISTS t_exam_grading (
    id INT AUTO_INCREMENT PRIMARY KEY,
    exam_id INT NOT NULL,
    student_id INT NOT NULL,
    auto_graded TINYINT(1) DEFAULT 0 COMMENT '自动评分完成',
    manual_graded TINYINT(1) DEFAULT 0 COMMENT '人工评分完成',
    final_score INT COMMENT '最终得分',
    graded_at DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uk_exam_student (exam_id, student_id),
    FOREIGN KEY (exam_id) REFERENCES t_exam(id)
);

-- 学生答题表增加评分状态字段
ALTER TABLE t_student_question ADD COLUMN graded TINYINT(1) DEFAULT 0 COMMENT '是否已评分';