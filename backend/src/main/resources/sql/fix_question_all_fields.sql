-- 为题库表添加所有缺失的字段
-- 1. 添加 options 字段（选项）
ALTER TABLE t_question ADD COLUMN options TEXT DEFAULT NULL COMMENT '选项内容（JSON格式）' AFTER `analysis`;

-- 2. 添加 score 字段（分值）
ALTER TABLE t_question ADD COLUMN score INT DEFAULT 10 COMMENT '题目分值' AFTER `type`;

-- 3. 添加 analysis 字段（解析）
ALTER TABLE t_question ADD COLUMN analysis VARCHAR(500) DEFAULT NULL COMMENT '答案解析' AFTER `answer`;
