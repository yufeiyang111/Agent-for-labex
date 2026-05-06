-- 修复 t_student_homework 表缺少 file_size 字段的问题
-- Error: Unknown column 'file_size' in 'field list'

-- 步骤1: 检查表结构，确认缺失的字段
-- DESC t_student_homework;

-- 步骤2: 添加缺失的 file_size 字段
ALTER TABLE t_student_homework
ADD COLUMN `file_size` BIGINT DEFAULT NULL COMMENT '附件大小(字节)' AFTER `file_path`;

-- 步骤3: 验证字段已添加
-- DESC t_student_homework;
