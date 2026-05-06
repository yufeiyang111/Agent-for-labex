-- 修复所有表字段长度问题
-- 将存储长文本的 VARCHAR 字段改为 TEXT 类型

-- =============================================
-- 1. 题库表 (t_question) - 优先级：高
-- =============================================
-- 题目内容（可能很长，包含大量文字描述和代码）
ALTER TABLE t_question MODIFY COLUMN question TEXT NOT NULL COMMENT '题目内容';

-- 答案（可能包含大量代码示例）
ALTER TABLE t_question MODIFY COLUMN answer TEXT DEFAULT NULL COMMENT '答案';

-- 答案解析（可能很长）
ALTER TABLE t_question MODIFY COLUMN analysis TEXT DEFAULT NULL COMMENT '答案解析';

-- 选项内容（JSON格式，可能很长）
ALTER TABLE t_question MODIFY COLUMN options TEXT DEFAULT NULL COMMENT '选项内容（JSON格式）';


-- =============================================
-- 2. 实验表 (t_experiment) - 优先级：高
-- =============================================
-- 实验要求（可能很长）
ALTER TABLE t_experiment MODIFY COLUMN experiment_requirement TEXT DEFAULT NULL COMMENT '实验要求';

-- 实验内容（可能包含大量代码和说明）
ALTER TABLE t_experiment MODIFY COLUMN experiment_content TEXT DEFAULT NULL COMMENT '实验内容';


-- =============================================
-- 3. 讲义表 (t_lecture) - 优先级：高
-- =============================================
-- 讲义内容（可能很长）
ALTER TABLE t_lecture MODIFY COLUMN lecture_content TEXT DEFAULT NULL COMMENT '讲义内容';


-- =============================================
-- 4. 作业表 (t_homework) - 优先级：中
-- =============================================
-- 作业内容（可能很长）
ALTER TABLE t_homework MODIFY COLUMN content TEXT DEFAULT NULL COMMENT '作业内容';


-- =============================================
-- 5. 学生答案表 (t_student_answer) - 优先级：高
-- =============================================
-- 学生答案（可能包含大量代码）
ALTER TABLE t_student_answer MODIFY COLUMN content TEXT DEFAULT NULL COMMENT '学生答案内容';
