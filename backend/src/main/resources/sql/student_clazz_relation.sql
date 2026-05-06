-- ============================================
-- 学生班级多对多关联表
-- ============================================

USE labex;

-- 创建学生班级关联表
DROP TABLE IF EXISTS t_student_clazz;
CREATE TABLE t_student_clazz (
    `id` INT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `student_id` INT NOT NULL COMMENT '学生ID',
    `clazz_no` VARCHAR(50) NOT NULL COMMENT '班级编号',
    `teacher_id` INT NOT NULL COMMENT '教师ID（便于查询）',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_student_clazz` (`student_id`, `clazz_no`),
    KEY `idx_student_clazz_clazz` (`clazz_no`),
    KEY `idx_student_clazz_teacher` (`teacher_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='学生班级关联表';

-- 初始化数据：将已有的学生班级关系迁移到新表
INSERT INTO t_student_clazz (student_id, clazz_no, teacher_id)
SELECT s.student_id, s.clazz_no, c.teacher_id
FROM t_student s
INNER JOIN t_clazz c ON s.clazz_no = c.no
WHERE s.clazz_no IS NOT NULL AND s.clazz_no != ''
AND NOT EXISTS (
    SELECT 1 FROM t_student_clazz sc 
    WHERE sc.student_id = s.student_id AND sc.clazz_no = s.clazz_no
);

SELECT '学生班级关联表创建完成，已迁移' AS message, 
       (SELECT COUNT(*) FROM t_student_clazz) AS '关联记录数';
