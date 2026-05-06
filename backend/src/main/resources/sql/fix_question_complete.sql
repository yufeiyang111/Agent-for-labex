-- 为题库表添加所有缺失的字段
-- 1. 添加 analysis 字段（答案解析）
ALTER TABLE t_question ADD COLUMN analysis VARCHAR(500) DEFAULT NULL COMMENT '答案解析' AFTER `answer`;

-- 2. 添加 score 字段（题目分值）
ALTER TABLE t_question ADD COLUMN score INT DEFAULT 10 COMMENT '题目分值' AFTER `type`;

-- 3. 添加 options 字段（选项内容，JSON格式）
ALTER TABLE t_question ADD COLUMN options TEXT DEFAULT NULL COMMENT '选项内容（JSON格式）' AFTER `analysis`;

-- 4. 添加 state 字段（状态：0-禁用 1-启用）
ALTER TABLE t_question ADD COLUMN state INT DEFAULT 1 COMMENT '状态：0-禁用，1-启用' AFTER `teacher_id`;
