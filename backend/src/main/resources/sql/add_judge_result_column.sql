-- 为训练系统添加判题结果存储字段
ALTER TABLE t_student_training_question
    ADD COLUMN judge_result TEXT DEFAULT NULL COMMENT '判题结果JSON' AFTER submit_time;
