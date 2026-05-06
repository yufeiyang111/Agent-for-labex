-- 为题库表添加分数字段
ALTER TABLE t_question ADD COLUMN score INT DEFAULT 10 COMMENT '题目分值' AFTER `type`;
