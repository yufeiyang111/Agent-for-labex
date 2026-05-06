-- 修复作业表缺少的字段
-- 添加 total_score（总分）字段
ALTER TABLE t_homework ADD COLUMN total_score INT DEFAULT 100 COMMENT '作业总分' AFTER `state`;
