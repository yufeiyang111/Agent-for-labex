-- 修复：迁移已有学生班级关联数据（过滤掉没有班级或没有教师的记录）
INSERT INTO t_student_clazz (student_id, clazz_no, teacher_id)
SELECT s.student_id, s.clazz_no, c.teacher_id
FROM t_student s
INNER JOIN t_clazz c ON s.clazz_no = c.no
WHERE s.clazz_no IS NOT NULL AND s.clazz_no != ''
AND c.teacher_id IS NOT NULL
AND NOT EXISTS (
    SELECT 1 FROM t_student_clazz sc
    WHERE sc.student_id = s.student_id AND sc.clazz_no = s.clazz_no
);
