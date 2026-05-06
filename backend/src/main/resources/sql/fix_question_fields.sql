-- 为题库表添加缺少的字段
ALTER TABLE t_question ADD COLUMN analysis VARCHAR(500) DEFAULT NULL COMMENT '答案解析' AFTER `answer`;
ALTER TABLE t_question ADD COLUMN score INT DEFAULT 10 COMMENT '题目分值' AFTER `type`;
