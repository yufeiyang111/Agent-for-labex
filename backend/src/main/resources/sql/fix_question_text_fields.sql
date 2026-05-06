-- 修复题库表字段长度问题
-- 原因：题目、答案、解析、选项等内容可能很长，需要使用TEXT类型

-- 1. 修改 question 字段为 TEXT（题目内容可能很长）
ALTER TABLE t_question MODIFY COLUMN question TEXT NOT NULL COMMENT '题目内容';

-- 2. 修改 answer 字段为 TEXT（答案可能包含大量代码）
ALTER TABLE t_question MODIFY COLUMN answer TEXT DEFAULT NULL COMMENT '答案';

-- 3. 修改 analysis 字段为 TEXT（解析可能很长）
ALTER TABLE t_question MODIFY COLUMN analysis TEXT DEFAULT NULL COMMENT '答案解析';

-- 4. 修改 options 字段为 TEXT（选项JSON可能很长）
ALTER TABLE t_question MODIFY COLUMN options TEXT DEFAULT NULL COMMENT '选项内容（JSON格式）';
