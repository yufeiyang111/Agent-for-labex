-- 讲义表添加缺失字段
ALTER TABLE t_lecture ADD COLUMN lecture_content TEXT DEFAULT NULL COMMENT '讲义内容(HTML)' AFTER lecture_type;
ALTER TABLE t_lecture ADD COLUMN file_path VARCHAR(255) DEFAULT NULL COMMENT '文件路径' AFTER lecture_filetype;
ALTER TABLE t_lecture ADD COLUMN file_size BIGINT DEFAULT NULL COMMENT '文件大小(字节)' AFTER file_path;
ALTER TABLE t_lecture ADD COLUMN teacher_id INT DEFAULT NULL COMMENT '所属教师ID' AFTER lecture_content;

-- 实验表添加教师ID字段
ALTER TABLE t_experiment ADD COLUMN teacher_id INT DEFAULT NULL COMMENT '所属教师ID' AFTER state;

-- 如果表不存在，创建带完整字段的讲义表
DROP TABLE IF EXISTS t_lecture;
CREATE TABLE t_lecture (
    lecture_id         INT          NOT NULL AUTO_INCREMENT COMMENT '讲义ID',
    lecture_name      VARCHAR(100) NOT NULL COMMENT '讲义名称',
    lecture_type      INT          DEFAULT NULL COMMENT '讲义类型: 1-课件, 2-教材, 3-参考资料, 4-默认',
    lecture_content    TEXT          DEFAULT NULL COMMENT '讲义内容(HTML)',
    lecture_filetype  VARCHAR(20)   DEFAULT NULL COMMENT '文件类型',
    file_path         VARCHAR(255)  DEFAULT NULL COMMENT '文件路径',
    file_size         BIGINT        DEFAULT NULL COMMENT '文件大小(字节)',
    teacher_id        INT           DEFAULT NULL COMMENT '所属教师ID',
    PRIMARY KEY (lecture_id),
    KEY idx_lecture_type (lecture_type),
    KEY idx_lecture_teacher (teacher_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='讲义表';

-- 如果表不存在，创建带教师ID的实验表
DROP TABLE IF EXISTS t_experiment;
CREATE TABLE t_experiment (
    experiment_id          INT          NOT NULL AUTO_INCREMENT COMMENT '实验ID',
    experiment_no         INT          NOT NULL COMMENT '实验编号',
    experiment_name       VARCHAR(100) NOT NULL COMMENT '实验名称',
    experiment_type       INT          DEFAULT NULL COMMENT '实验类型',
    instruction_type      VARCHAR(10)  DEFAULT NULL COMMENT '题型',
    experiment_requirement TEXT        DEFAULT NULL COMMENT '实验要求',
    experiment_content    TEXT          DEFAULT NULL COMMENT '实验内容',
    state                 INT          DEFAULT 1 COMMENT '状态: 0-禁用, 1-启用',
    teacher_id            INT           DEFAULT NULL COMMENT '所属教师ID',
    PRIMARY KEY (experiment_id),
    UNIQUE KEY uk_experiment_no (experiment_no),
    KEY idx_experiment_state (state),
    KEY idx_experiment_teacher (teacher_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='实验表';
