package com.labex.config;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

/**
 * Backward-compatible schema patcher for legacy databases.
 * It keeps old deployments runnable even when some columns are missing.
 */
@Component
@RequiredArgsConstructor
@Slf4j
public class SchemaCompatibilityInitializer implements ApplicationRunner {

    private final JdbcTemplate jdbcTemplate;

    @Override
    public void run(ApplicationArguments args) {
        ensurePaperSchema();
        ensurePaperQuestionSchema();
        ensureExamMonitorSchema();
        ensureRagSessionSchema();
        ensureRagMessageSchema();
        ensureRagQueryMetricSchema();
        ensureTeacherClassLinkSchema();
        ensureTrainingQuestionJudgeResult();
        ensureTrainingSetRecommendationSchema();
        ensurePermissionSchema();
        ensureAgentConversationSchema();
        ensureAgentFileChangeSchema();
        ensureAgentTokenUsageSchema();
        // ===== 课程教学闭环（CTL）模块 =====
        ensureCourseTeachingLoopSchema();
    }

    /**
     * 课程教学闭环模块表创建
     * 涵盖：课程大纲(S1) + 课程目标(S2) + 评分项(S3) + 成绩录入(S4) + 达成度(S5) + 课程质量评价(S6)
     * 完整 12 张表，遵循项目惯例：INT 主键、create_time/update_time 命名、Integer 逻辑删除
     */
    private void ensureCourseTeachingLoopSchema() {
        // ---------- S1 课程大纲拟定 ----------
        if (!tableExists("t_course")) {
            executeIgnore("""
                CREATE TABLE t_course (
                    course_id INT NOT NULL AUTO_INCREMENT COMMENT '课程ID',
                    code VARCHAR(32) NOT NULL COMMENT '课程编号',
                    name_cn VARCHAR(128) NOT NULL COMMENT '中文名',
                    name_en VARCHAR(255) DEFAULT NULL COMMENT '英文名',
                    credit DECIMAL(3,1) DEFAULT NULL COMMENT '学分',
                    hours INT DEFAULT NULL COMMENT '总学时',
                    theory_hours INT DEFAULT NULL COMMENT '理论学时',
                    lab_hours INT DEFAULT NULL COMMENT '实验学时',
                    major VARCHAR(64) DEFAULT NULL COMMENT '适用专业',
                    prerequisite VARCHAR(255) DEFAULT NULL COMMENT '先修课程',
                    department VARCHAR(64) DEFAULT NULL COMMENT '开课系',
                    intro TEXT COMMENT '课程简介',
                    owner_id INT DEFAULT NULL COMMENT '课程负责人(teacher_id)',
                    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                    deleted TINYINT DEFAULT 0 COMMENT '逻辑删除',
                    PRIMARY KEY (course_id),
                    UNIQUE KEY uq_course_code (code),
                    INDEX idx_owner (owner_id)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='课程模板（CTL-S1）'
                """);
            log.info("Created t_course table");
        }

        if (!tableExists("t_course_offering")) {
            executeIgnore("""
                CREATE TABLE t_course_offering (
                    offering_id INT NOT NULL AUTO_INCREMENT COMMENT '开课ID',
                    course_id INT NOT NULL COMMENT '所属课程',
                    clazz_no VARCHAR(64) NOT NULL COMMENT '班级编号(t_clazz.no)',
                    teacher_id INT NOT NULL COMMENT '任课教师',
                    semester VARCHAR(16) NOT NULL COMMENT '学期(2022-2023-1)',
                    student_count INT DEFAULT 0 COMMENT '学生人数缓存',
                    status VARCHAR(16) DEFAULT 'draft' COMMENT '状态(draft/active/finished/archived)',
                    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                    deleted TINYINT DEFAULT 0 COMMENT '逻辑删除',
                    PRIMARY KEY (offering_id),
                    UNIQUE KEY uq_course_clazz_semester (course_id, clazz_no, semester),
                    INDEX idx_teacher (teacher_id),
                    INDEX idx_clazz (clazz_no)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='开课实例（CTL-S1）'
                """);
            log.info("Created t_course_offering table");
        }
        addColumnIfMissing("t_course_offering", "clazz_no",
                "ALTER TABLE t_course_offering ADD COLUMN `clazz_no` VARCHAR(64) NOT NULL COMMENT 'class number' AFTER `course_id`");
        addColumnIfMissing("t_course_offering", "teacher_id",
                "ALTER TABLE t_course_offering ADD COLUMN `teacher_id` INT NOT NULL DEFAULT 0 COMMENT 'teacher id' AFTER `clazz_no`");
        addColumnIfMissing("t_course_offering", "student_count",
                "ALTER TABLE t_course_offering ADD COLUMN `student_count` INT DEFAULT 0 COMMENT 'student count' AFTER `semester`");
        addColumnIfMissing("t_course_offering", "status",
                "ALTER TABLE t_course_offering ADD COLUMN `status` VARCHAR(16) DEFAULT 'active' COMMENT 'draft/active/finished/archived' AFTER `student_count`");

        if (!tableExists("t_syllabus")) {
            executeIgnore("""
                CREATE TABLE t_syllabus (
                    syllabus_id INT NOT NULL AUTO_INCREMENT COMMENT '大纲ID',
                    course_id INT NOT NULL COMMENT '所属课程',
                    course_intro TEXT COMMENT '课程简介',
                    main_task TEXT COMMENT '主要任务',
                    knowledge_goals TEXT COMMENT '知识目标(JSON)',
                    ability_goals TEXT COMMENT '能力目标(JSON)',
                    quality_goals TEXT COMMENT '素质目标(JSON)',
                    teaching_methods TEXT COMMENT '教学方法',
                    exercise_requirements TEXT COMMENT '习题要求',
                    assessment_methods TEXT COMMENT '考核方式总述',
                    achievement_formula TEXT COMMENT '达成度计算公式说明',
                    textbooks TEXT COMMENT '推荐教材(JSON)',
                    references_list TEXT COMMENT '参考书(JSON)',
                    version INT DEFAULT 1 COMMENT '版本号',
                    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                    deleted TINYINT DEFAULT 0 COMMENT '逻辑删除',
                    PRIMARY KEY (syllabus_id),
                    UNIQUE KEY uq_syllabus_course (course_id)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='课程大纲（CTL-S1）'
                """);
            log.info("Created t_syllabus table");
        }

        if (!tableExists("t_syllabus_chapter")) {
            executeIgnore("""
                CREATE TABLE t_syllabus_chapter (
                    chapter_id INT NOT NULL AUTO_INCREMENT COMMENT '章节ID',
                    syllabus_id INT NOT NULL COMMENT '所属大纲',
                    chapter_no VARCHAR(16) DEFAULT NULL COMMENT '章节号',
                    topic VARCHAR(255) DEFAULT NULL COMMENT '教学内容主题',
                    knowledge_requirements TEXT COMMENT '知识/能力教学要求',
                    ideological_elements TEXT COMMENT '思政元素',
                    recommended_hours INT DEFAULT NULL COMMENT '推荐学时',
                    teaching_method VARCHAR(32) DEFAULT NULL COMMENT '教学方式',
                    objective_ref VARCHAR(64) DEFAULT NULL COMMENT '对应课程目标(逗号分隔)',
                    sort_order INT DEFAULT 0 COMMENT '排序',
                    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                    deleted TINYINT DEFAULT 0 COMMENT '逻辑删除',
                    PRIMARY KEY (chapter_id),
                    INDEX idx_syllabus (syllabus_id)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='大纲章节（CTL-S1）'
                """);
            log.info("Created t_syllabus_chapter table");
        }

        // ---------- S2 课程目标设定 ----------
        if (!tableExists("t_graduation_requirement")) {
            executeIgnore("""
                CREATE TABLE t_graduation_requirement (
                    requirement_id INT NOT NULL AUTO_INCREMENT COMMENT '毕业要求ID',
                    code VARCHAR(16) NOT NULL COMMENT '编号(5)',
                    title VARCHAR(255) NOT NULL COMMENT '名称(使用现代工具)',
                    description TEXT COMMENT '详细描述',
                    major VARCHAR(64) DEFAULT NULL COMMENT '适用专业',
                    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                    deleted TINYINT DEFAULT 0 COMMENT '逻辑删除',
                    PRIMARY KEY (requirement_id),
                    UNIQUE KEY uq_gr_code (code, major)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='毕业要求（CTL-S2）'
                """);
            log.info("Created t_graduation_requirement table");
        }

        if (!tableExists("t_graduation_indicator")) {
            executeIgnore("""
                CREATE TABLE t_graduation_indicator (
                    indicator_id INT NOT NULL AUTO_INCREMENT COMMENT '指标点ID',
                    requirement_id INT NOT NULL COMMENT '所属毕业要求',
                    code VARCHAR(16) NOT NULL COMMENT '编号(5.1)',
                    description TEXT NOT NULL COMMENT '描述',
                    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                    deleted TINYINT DEFAULT 0 COMMENT '逻辑删除',
                    PRIMARY KEY (indicator_id),
                    INDEX idx_indicator_req (requirement_id)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='毕业要求指标点（CTL-S2）'
                """);
            log.info("Created t_graduation_indicator table");
        }

        if (!tableExists("t_course_objective")) {
            executeIgnore("""
                CREATE TABLE t_course_objective (
                    objective_id INT NOT NULL AUTO_INCREMENT COMMENT '课程目标ID',
                    course_id INT NOT NULL COMMENT '所属课程',
                    code VARCHAR(16) NOT NULL COMMENT '编号(课程目标1)',
                    category VARCHAR(16) DEFAULT NULL COMMENT '类别(knowledge/ability/quality)',
                    description TEXT NOT NULL COMMENT '描述',
                    sort_order INT DEFAULT 0 COMMENT '排序',
                    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                    deleted TINYINT DEFAULT 0 COMMENT '逻辑删除',
                    PRIMARY KEY (objective_id),
                    UNIQUE KEY uq_obj_course_code (course_id, code)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='课程目标（CTL-S2）'
                """);
            log.info("Created t_course_objective table");
        }

        if (!tableExists("t_objective_support")) {
            executeIgnore("""
                CREATE TABLE t_objective_support (
                    support_id INT NOT NULL AUTO_INCREMENT COMMENT '支撑关系ID',
                    objective_id INT NOT NULL COMMENT '课程目标',
                    indicator_id INT NOT NULL COMMENT '毕业要求指标点',
                    support_strength TINYINT DEFAULT 1 COMMENT '支撑强度(H=3/M=2/L=1)',
                    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                    deleted TINYINT DEFAULT 0 COMMENT '逻辑删除',
                    PRIMARY KEY (support_id),
                    UNIQUE KEY uq_obj_indicator (objective_id, indicator_id)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='课程目标支撑指标点（CTL-S2）'
                """);
            log.info("Created t_objective_support table");
        }

        // ---------- S3 评分项设定 ----------
        if (!tableExists("t_scoring_item")) {
            executeIgnore("""
                CREATE TABLE t_scoring_item (
                    item_id INT NOT NULL AUTO_INCREMENT COMMENT '评分项ID',
                    offering_id INT NOT NULL COMMENT '所属开课',
                    name VARCHAR(64) NOT NULL COMMENT '名称(作业1/实验1/期末)',
                    type VARCHAR(16) NOT NULL COMMENT '类型(homework/experiment/exam/project/other)',
                    source_table VARCHAR(32) DEFAULT NULL COMMENT '引用表名',
                    source_id INT DEFAULT NULL COMMENT '引用ID',
                    max_score INT DEFAULT 100 COMMENT '满分',
                    passing_score INT DEFAULT 70 COMMENT '期望及格分',
                    weight DECIMAL(6,4) NOT NULL COMMENT '权重(0.0500)',
                    sort_order INT DEFAULT 0 COMMENT '排序',
                    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                    deleted TINYINT DEFAULT 0 COMMENT '逻辑删除',
                    PRIMARY KEY (item_id),
                    INDEX idx_item_offering (offering_id),
                    INDEX idx_item_source (source_table, source_id)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='评分项（CTL-S3）'
                """);
            log.info("Created t_scoring_item table");
        }

        if (!tableExists("t_scoring_item_objective")) {
            executeIgnore("""
                CREATE TABLE t_scoring_item_objective (
                    link_id INT NOT NULL AUTO_INCREMENT COMMENT '关联ID',
                    item_id INT NOT NULL COMMENT '评分项',
                    objective_id INT NOT NULL COMMENT '课程目标',
                    weight_in_objective DECIMAL(6,4) DEFAULT 1.0000 COMMENT '该评分项在目标内的权重',
                    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                    deleted TINYINT DEFAULT 0 COMMENT '逻辑删除',
                    PRIMARY KEY (link_id),
                    UNIQUE KEY uq_item_obj (item_id, objective_id),
                    INDEX idx_link_obj (objective_id)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='评分项↔课程目标（CTL-S3）'
                """);
            log.info("Created t_scoring_item_objective table");
        }

        // ---------- S4 成绩录入 ----------
        if (!tableExists("t_scoring_score")) {
            executeIgnore("""
                CREATE TABLE t_scoring_score (
                    score_id INT NOT NULL AUTO_INCREMENT COMMENT '成绩ID',
                    item_id INT NOT NULL COMMENT '评分项',
                    student_id INT NOT NULL COMMENT '学生',
                    score DECIMAL(6,2) DEFAULT NULL COMMENT '得分(NULL=缺考)',
                    source VARCHAR(16) DEFAULT 'manual' COMMENT '来源(manual/imported/calculated)',
                    graded_by INT DEFAULT NULL COMMENT '录入教师',
                    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                    deleted TINYINT DEFAULT 0 COMMENT '逻辑删除',
                    PRIMARY KEY (score_id),
                    UNIQUE KEY uq_item_student (item_id, student_id),
                    INDEX idx_score_student (student_id)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='评分项得分（CTL-S4）'
                """);
            log.info("Created t_scoring_score table");
        }

        // ---------- S5 达成度计算 ----------
        if (!tableExists("t_achievement_snapshot")) {
            executeIgnore("""
                CREATE TABLE t_achievement_snapshot (
                    snapshot_id INT NOT NULL AUTO_INCREMENT COMMENT '快照ID',
                    offering_id INT NOT NULL COMMENT '开课',
                    student_id INT DEFAULT NULL COMMENT 'NULL=班级聚合',
                    objective_id INT DEFAULT NULL COMMENT 'NULL=课程总目标',
                    achievement_value DECIMAL(7,4) DEFAULT NULL COMMENT '达成度值',
                    weighted_score DECIMAL(8,2) DEFAULT NULL COMMENT '加权得分',
                    weighted_max DECIMAL(8,2) DEFAULT NULL COMMENT '加权满分',
                    reached_count INT DEFAULT NULL COMMENT '达到学生人数(班级级)',
                    total_count INT DEFAULT NULL COMMENT '参与学生总数(班级级)',
                    calc_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '计算时间',
                    version INT DEFAULT 1 COMMENT '版本号',
                    PRIMARY KEY (snapshot_id),
                    UNIQUE KEY uq_snap_offering_stu_obj_ver (offering_id, student_id, objective_id, version),
                    INDEX idx_snap_offering (offering_id),
                    INDEX idx_snap_student (student_id)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='达成度快照（CTL-S5）'
                """);
            log.info("Created t_achievement_snapshot table");
        }

        // ---------- S6 课程质量评价 ----------
        if (!tableExists("t_quality_evaluation")) {
            executeIgnore("""
                CREATE TABLE t_quality_evaluation (
                    evaluation_id INT NOT NULL AUTO_INCREMENT COMMENT '评价ID',
                    offering_id INT NOT NULL COMMENT '开课',
                    evaluator_id INT NOT NULL COMMENT '评价人(任课教师)',
                    eval_round VARCHAR(32) NOT NULL COMMENT '评价轮次',
                    course_responsible VARCHAR(64) DEFAULT NULL COMMENT '课程负责人',
                    course_members TEXT COMMENT '课程组成员(JSON)',
                    eval_group_members TEXT COMMENT '评价小组成员(JSON)',
                    objective_indicator_rationality VARCHAR(16) DEFAULT NULL COMMENT '目标↔指标合理性',
                    objective_contains_kaq VARCHAR(16) DEFAULT NULL COMMENT '目标是否含KAQ',
                    achievement_values TEXT COMMENT '各目标达成值JSON',
                    expected_rationality VARCHAR(16) DEFAULT NULL COMMENT '期望值合理性',
                    analysis_rationality VARCHAR(16) DEFAULT NULL COMMENT '分析合理性',
                    improvement_rationality VARCHAR(16) DEFAULT NULL COMMENT '改进措施合理性',
                    existing_issues TEXT COMMENT '存在的问题',
                    evaluation_validity TEXT COMMENT '达成评价有效性',
                    last_round_improvements TEXT COMMENT '上一轮问题改进情况',
                    conclusion_and_suggestions TEXT COMMENT '结论及改进意见',
                    status VARCHAR(16) DEFAULT 'draft' COMMENT '状态(draft/finalized)',
                    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                    deleted TINYINT DEFAULT 0 COMMENT '逻辑删除',
                    PRIMARY KEY (evaluation_id),
                    UNIQUE KEY uq_eval_offering_round (offering_id, eval_round),
                    INDEX idx_eval_offering (offering_id)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='课程质量评价（CTL-S6）'
                """);
            log.info("Created t_quality_evaluation table");
        }

        // ---------- 学生课程评价表 ----------
        if (!tableExists("t_student_course_evaluation")) {
            executeIgnore("""
                CREATE TABLE t_student_course_evaluation (
                    id INT NOT NULL AUTO_INCREMENT COMMENT '评价ID',
                    offering_id INT NOT NULL COMMENT '开课ID',
                    student_id INT NOT NULL COMMENT '学生ID',
                    teaching_quality TINYINT DEFAULT NULL COMMENT '教学质量(1-5)',
                    course_content TINYINT DEFAULT NULL COMMENT '课程内容(1-5)',
                    learning_resources TINYINT DEFAULT NULL COMMENT '学习资源(1-5)',
                    assessment_method TINYINT DEFAULT NULL COMMENT '考核方式(1-5)',
                    learning_effect TINYINT DEFAULT NULL COMMENT '学习效果(1-5)',
                    overall_satisfaction TINYINT DEFAULT NULL COMMENT '总体满意度(1-5)',
                    comment TEXT COMMENT '文字评价',
                    suggestion TEXT COMMENT '改进建议',
                    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                    deleted TINYINT DEFAULT 0 COMMENT '逻辑删除',
                    PRIMARY KEY (id),
                    UNIQUE KEY uq_eval_offering_student (offering_id, student_id),
                    INDEX idx_eval_offering (offering_id),
                    INDEX idx_eval_student (student_id)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生课程评价'
                """);
            log.info("Created t_student_course_evaluation table");
        }

        log.info("CTL schema initialization completed - 13 tables ready");
    }

    private void ensurePaperSchema() {
        if (!tableExists("t_paper")) {
            return;
        }

        // Keep old schemas compatible with current entity fields.
        addColumnIfMissing("t_paper", "no", "ALTER TABLE t_paper ADD COLUMN `no` INT DEFAULT NULL COMMENT '试卷编号'");
        addColumnIfMissing("t_paper", "teacher_id", "ALTER TABLE t_paper ADD COLUMN `teacher_id` INT DEFAULT NULL COMMENT '所属教师ID'");
        addColumnIfMissing("t_paper", "state", "ALTER TABLE t_paper ADD COLUMN `state` INT DEFAULT 1 COMMENT '状态'");
        addColumnIfMissing("t_paper", "total_score", "ALTER TABLE t_paper ADD COLUMN `total_score` INT DEFAULT 0 COMMENT '总分'");
        addColumnIfMissing("t_paper", "question_count", "ALTER TABLE t_paper ADD COLUMN `question_count` INT DEFAULT 0 COMMENT '题目数量'");

        // Fill legacy nulls to avoid "Field 'no' doesn't have a default value" on insert/update.
        executeIgnore("UPDATE t_paper SET `no` = id WHERE `no` IS NULL OR `no` = 0");
        executeIgnore("UPDATE t_paper SET `state` = 1 WHERE `state` IS NULL");
        executeIgnore("UPDATE t_paper SET `total_score` = 0 WHERE `total_score` IS NULL");
        executeIgnore("UPDATE t_paper SET `question_count` = 0 WHERE `question_count` IS NULL");
    }

    private void ensurePaperQuestionSchema() {
        if (!tableExists("t_paper_question")) {
            return;
        }

        // New code reads/writes sort column; old schema may miss it.
        addColumnIfMissing("t_paper_question", "sort", "ALTER TABLE t_paper_question ADD COLUMN `sort` INT DEFAULT 1 COMMENT '排序'");
        executeIgnore("UPDATE t_paper_question SET `sort` = id WHERE `sort` IS NULL OR `sort` = 0");
        executeIgnore("UPDATE t_paper_question SET `score` = 10 WHERE `score` IS NULL");

        if (!indexExists("t_paper_question", "idx_paper_question_paper_sort")) {
            executeIgnore("CREATE INDEX idx_paper_question_paper_sort ON t_paper_question(paper_id, sort)");
        }
    }

    private void ensureExamMonitorSchema() {
        if (!tableExists("t_exam_monitor_event")) {
            executeIgnore("""
                    CREATE TABLE t_exam_monitor_event (
                        id INT NOT NULL AUTO_INCREMENT,
                        exam_id INT NOT NULL COMMENT '考试ID',
                        student_id INT NOT NULL COMMENT '学生ID',
                        event_type VARCHAR(32) NOT NULL COMMENT '事件类型',
                        event_desc VARCHAR(500) DEFAULT NULL COMMENT '事件描述',
                        page_url VARCHAR(255) DEFAULT NULL COMMENT '发生页面',
                        ip VARCHAR(64) DEFAULT NULL COMMENT '学生IP',
                        occurred_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间',
                        PRIMARY KEY (id)
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='考试监考异常事件表'
                    """);
        }

        if (!tableExists("t_exam_monitor_event")) {
            return;
        }

        addColumnIfMissing("t_exam_monitor_event", "event_desc",
                "ALTER TABLE t_exam_monitor_event ADD COLUMN `event_desc` VARCHAR(500) DEFAULT NULL COMMENT '事件描述'");
        addColumnIfMissing("t_exam_monitor_event", "page_url",
                "ALTER TABLE t_exam_monitor_event ADD COLUMN `page_url` VARCHAR(255) DEFAULT NULL COMMENT '发生页面'");
        addColumnIfMissing("t_exam_monitor_event", "ip",
                "ALTER TABLE t_exam_monitor_event ADD COLUMN `ip` VARCHAR(64) DEFAULT NULL COMMENT '学生IP'");
        addColumnIfMissing("t_exam_monitor_event", "occurred_at",
                "ALTER TABLE t_exam_monitor_event ADD COLUMN `occurred_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发生时间'");

        if (!indexExists("t_exam_monitor_event", "idx_exam_monitor_exam_student_time")) {
            executeIgnore("CREATE INDEX idx_exam_monitor_exam_student_time ON t_exam_monitor_event(exam_id, student_id, occurred_at)");
        }
        if (!indexExists("t_exam_monitor_event", "idx_exam_monitor_exam_time")) {
            executeIgnore("CREATE INDEX idx_exam_monitor_exam_time ON t_exam_monitor_event(exam_id, occurred_at)");
        }
    }

    /**
     * Ensure rag_session table exists for RAG chat sessions
     */
    private void ensureRagSessionSchema() {
        if (!tableExists("rag_session")) {
            executeIgnore("""
                    CREATE TABLE rag_session (
                        id VARCHAR(64) NOT NULL COMMENT '会话ID(UUID)',
                        user_id VARCHAR(100) NOT NULL COMMENT '用户ID',
                        title VARCHAR(200) DEFAULT '新会话' COMMENT '会话标题',
                        create_time BIGINT NOT NULL COMMENT '创建时间戳',
                        last_active_time BIGINT NOT NULL COMMENT '最后活跃时间戳',
                        message_count INT DEFAULT 0 COMMENT '消息数量',
                        PRIMARY KEY (id),
                        KEY idx_rag_session_user (user_id),
                        KEY idx_rag_session_last_active (last_active_time)
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='RAG知识问答会话表'
                    """);
            log.info("Created rag_session table");
        }
    }

    /**
     * Ensure rag_message table exists for RAG chat messages
     */
    private void ensureRagMessageSchema() {
        if (!tableExists("rag_message")) {
            executeIgnore("""
                    CREATE TABLE rag_message (
                        id BIGINT NOT NULL AUTO_INCREMENT COMMENT '消息ID',
                        session_id VARCHAR(64) NOT NULL COMMENT '会话ID',
                        role VARCHAR(20) NOT NULL COMMENT '角色: user/assistant',
                        content TEXT NOT NULL COMMENT '消息内容',
                        sources TEXT DEFAULT NULL COMMENT '参考来源(JSON)',
                        create_time BIGINT NOT NULL COMMENT '创建时间戳',
                        PRIMARY KEY (id),
                        KEY idx_rag_message_session (session_id),
                        KEY idx_rag_message_create_time (create_time)
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='RAG知识问答消息表'
            """);
            log.info("Created rag_message table");
        }

        if (!tableExists("rag_message")) {
            return;
        }

        addColumnIfMissing("rag_message", "retrieval_mode",
                "ALTER TABLE rag_message ADD COLUMN `retrieval_mode` VARCHAR(32) DEFAULT NULL COMMENT 'retrieval mode' AFTER `sources`");
        addColumnIfMissing("rag_message", "search_keywords",
                "ALTER TABLE rag_message ADD COLUMN `search_keywords` TEXT DEFAULT NULL COMMENT 'search keywords json' AFTER `retrieval_mode`");
        addColumnIfMissing("rag_message", "thinking_trace",
                "ALTER TABLE rag_message ADD COLUMN `thinking_trace` MEDIUMTEXT DEFAULT NULL COMMENT 'visible reasoning summary' AFTER `search_keywords`");
        addColumnIfMissing("rag_message", "attachments",
                "ALTER TABLE rag_message ADD COLUMN `attachments` MEDIUMTEXT DEFAULT NULL COMMENT 'message attachments json' AFTER `thinking_trace`");

        executeIgnore("ALTER TABLE rag_message MODIFY COLUMN `content` MEDIUMTEXT NOT NULL COMMENT 'message content'");
        executeIgnore("ALTER TABLE rag_message MODIFY COLUMN `sources` MEDIUMTEXT DEFAULT NULL COMMENT 'reference sources json'");
    }

    private void ensureRagQueryMetricSchema() {
        if (!tableExists("rag_query_metric")) {
            executeIgnore("""
                    CREATE TABLE rag_query_metric (
                        id BIGINT NOT NULL AUTO_INCREMENT COMMENT 'metric id',
                        session_id VARCHAR(64) DEFAULT NULL COMMENT 'RAG session id',
                        user_id VARCHAR(100) DEFAULT NULL COMMENT 'request user id',
                        retrieval_mode VARCHAR(32) DEFAULT NULL COMMENT 'knowledge/web/hybrid',
                        deep_thinking TINYINT DEFAULT 0 COMMENT 'deep thinking enabled',
                        question_preview VARCHAR(500) DEFAULT NULL COMMENT 'truncated user question',
                        search_query VARCHAR(500) DEFAULT NULL COMMENT 'planned retrieval query',
                        source_count INT DEFAULT 0 COMMENT 'total source count',
                        knowledge_source_count INT DEFAULT 0 COMMENT 'knowledge source count',
                        web_source_count INT DEFAULT 0 COMMENT 'web source count',
                        image_source_count INT DEFAULT 0 COMMENT 'image source count',
                        web_fetched_count INT DEFAULT 0 COMMENT 'fetched web page bodies',
                        exact_web_count INT DEFAULT 0 COMMENT 'exact entity web matches',
                        no_sources TINYINT DEFAULT 0 COMMENT 'no source returned',
                        latency_ms BIGINT DEFAULT 0 COMMENT 'end-to-end request latency',
                        created_at BIGINT NOT NULL COMMENT 'epoch millis',
                        PRIMARY KEY (id),
                        KEY idx_rag_metric_session (session_id),
                        KEY idx_rag_metric_user_time (user_id, created_at),
                        KEY idx_rag_metric_mode_time (retrieval_mode, created_at)
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='RAG retrieval quality metrics'
                    """);
            log.info("Created rag_query_metric table");
        }
    }

    private boolean tableExists(String tableName) {
        String sql = """
                SELECT COUNT(*)
                FROM information_schema.tables
                WHERE table_schema = DATABASE()
                  AND table_name = ?
                """;
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, tableName);
        return count != null && count > 0;
    }

    private boolean columnExists(String tableName, String columnName) {
        String sql = """
                SELECT COUNT(*)
                FROM information_schema.columns
                WHERE table_schema = DATABASE()
                  AND table_name = ?
                  AND column_name = ?
                """;
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, tableName, columnName);
        return count != null && count > 0;
    }

    private boolean indexExists(String tableName, String indexName) {
        String sql = """
                SELECT COUNT(*)
                FROM information_schema.statistics
                WHERE table_schema = DATABASE()
                  AND table_name = ?
                  AND index_name = ?
                """;
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, tableName, indexName);
        return count != null && count > 0;
    }

    private void addColumnIfMissing(String tableName, String columnName, String alterSql) {
        if (!columnExists(tableName, columnName)) {
            executeIgnore(alterSql);
        }
    }

    private void ensureTeacherClassLinkSchema() {
        if (!tableExists("t_clazz")) {
            executeIgnore("""
                    CREATE TABLE t_clazz (
                        no VARCHAR(64) NOT NULL COMMENT 'class number',
                        memo VARCHAR(255) DEFAULT NULL COMMENT 'class description',
                        state INT DEFAULT 1 COMMENT 'state: 1 enabled, 0 disabled',
                        teacher_id INT DEFAULT NULL COMMENT 'owner teacher id',
                        PRIMARY KEY (no),
                        KEY idx_clazz_teacher (teacher_id)
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='teaching class'
                    """);
            log.info("Created t_clazz table");
        } else {
            addColumnIfMissing("t_clazz", "teacher_id",
                    "ALTER TABLE t_clazz ADD COLUMN `teacher_id` INT DEFAULT NULL COMMENT 'owner teacher id'");
            addColumnIfMissing("t_clazz", "state",
                    "ALTER TABLE t_clazz ADD COLUMN `state` INT DEFAULT 1 COMMENT 'state'");
        }

        if (!tableExists("t_student_clazz")) {
            executeIgnore("""
                    CREATE TABLE t_student_clazz (
                        id INT NOT NULL AUTO_INCREMENT,
                        student_id INT NOT NULL COMMENT 'student id',
                        clazz_no VARCHAR(64) NOT NULL COMMENT 'class number',
                        teacher_id INT DEFAULT NULL COMMENT 'owner teacher id',
                        PRIMARY KEY (id),
                        UNIQUE KEY uq_student_clazz (student_id, clazz_no),
                        KEY idx_student_clazz_no (clazz_no),
                        KEY idx_student_clazz_teacher (teacher_id)
                    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='student class relation'
                    """);
            log.info("Created t_student_clazz table");
        } else {
            addColumnIfMissing("t_student_clazz", "teacher_id",
                    "ALTER TABLE t_student_clazz ADD COLUMN `teacher_id` INT DEFAULT NULL COMMENT 'owner teacher id'");
        }
    }

    /**
     * Ensure t_student_training_question has judge_result column
     */
    private void ensureTrainingQuestionJudgeResult() {
        if (!tableExists("t_student_training_question")) {
            return;
        }
        addColumnIfMissing("t_student_training_question", "judge_result",
                "ALTER TABLE t_student_training_question ADD COLUMN `judge_result` TEXT DEFAULT NULL COMMENT '判题结果JSON' AFTER `submit_time`");
    }

    private void ensureTrainingSetRecommendationSchema() {
        if (!tableExists("t_training_set")) {
            return;
        }
        addColumnIfMissing("t_training_set", "owner_student_id",
                "ALTER TABLE t_training_set ADD COLUMN `owner_student_id` INT DEFAULT NULL COMMENT 'personal owner student id' AFTER `teacher_id`");
        addColumnIfMissing("t_training_set", "source",
                "ALTER TABLE t_training_set ADD COLUMN `source` VARCHAR(32) DEFAULT 'teacher' COMMENT 'teacher/kg_recommendation' AFTER `owner_student_id`");
        if (!indexExists("t_training_set", "idx_training_owner_source")) {
            executeIgnore("CREATE INDEX idx_training_owner_source ON t_training_set(owner_student_id, source)");
        }
    }

    private void ensurePermissionSchema() {
        if (!tableExists("t_agent_permission_rule")) {
            executeIgnore("""
                CREATE TABLE t_agent_permission_rule (
                    id BIGINT AUTO_INCREMENT PRIMARY KEY,
                    project_id VARCHAR(64) NOT NULL,
                    agent VARCHAR(64) NOT NULL DEFAULT 'build',
                    permission VARCHAR(64) NOT NULL,
                    pattern VARCHAR(255) NOT NULL DEFAULT '*',
                    action VARCHAR(16) NOT NULL,
                    session_id VARCHAR(64) DEFAULT NULL,
                    created_at BIGINT NOT NULL,
                    INDEX idx_project_agent (project_id, agent)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Agent permission rules'
            """);
            log.info("Created t_agent_permission_rule table");
        }

        if (!tableExists("t_agent_permission_approval")) {
            executeIgnore("""
                CREATE TABLE t_agent_permission_approval (
                    id BIGINT AUTO_INCREMENT PRIMARY KEY,
                    project_id VARCHAR(64) NOT NULL,
                    permission VARCHAR(64) NOT NULL,
                    pattern VARCHAR(255) NOT NULL,
                    created_at BIGINT NOT NULL,
                    INDEX idx_project (project_id)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Agent permission approvals'
            """);
            log.info("Created t_agent_permission_approval table");
        }
    }

    private void ensureAgentConversationSchema() {
        if (!tableExists("t_agent_conversation")) {
            return;
        }
        addColumnIfMissing("t_agent_conversation", "parent_conversation_id",
                "ALTER TABLE t_agent_conversation ADD COLUMN `parent_conversation_id` VARCHAR(64) DEFAULT NULL COMMENT 'parent conversation id' AFTER `summary`");
        addColumnIfMissing("t_agent_conversation", "forked_from_message_id",
                "ALTER TABLE t_agent_conversation ADD COLUMN `forked_from_message_id` BIGINT DEFAULT NULL COMMENT 'source message id for fork' AFTER `parent_conversation_id`");
        addColumnIfMissing("t_agent_conversation", "compacted_at",
                "ALTER TABLE t_agent_conversation ADD COLUMN `compacted_at` DATETIME DEFAULT NULL COMMENT 'last compacted time' AFTER `forked_from_message_id`");
        if (!indexExists("t_agent_conversation", "idx_agent_conversation_parent")) {
            executeIgnore("CREATE INDEX idx_agent_conversation_parent ON t_agent_conversation(parent_conversation_id)");
        }
    }

    private void ensureAgentFileChangeSchema() {
        if (!tableExists("t_agent_file_change")) {
            return;
        }
        addColumnIfMissing("t_agent_file_change", "snapshot_before_ref",
                "ALTER TABLE t_agent_file_change ADD COLUMN `snapshot_before_ref` VARCHAR(64) DEFAULT NULL COMMENT 'workspace snapshot before change' AFTER `diff_text`");
        addColumnIfMissing("t_agent_file_change", "snapshot_after_ref",
                "ALTER TABLE t_agent_file_change ADD COLUMN `snapshot_after_ref` VARCHAR(64) DEFAULT NULL COMMENT 'workspace snapshot after change' AFTER `snapshot_before_ref`");
        addColumnIfMissing("t_agent_file_change", "snapshot_paths",
                "ALTER TABLE t_agent_file_change ADD COLUMN `snapshot_paths` MEDIUMTEXT DEFAULT NULL COMMENT 'snapshot restore paths' AFTER `snapshot_after_ref`");
        addColumnIfMissing("t_agent_file_change", "snapshot_status",
                "ALTER TABLE t_agent_file_change ADD COLUMN `snapshot_status` VARCHAR(32) DEFAULT NULL COMMENT 'snapshot status' AFTER `snapshot_paths`");
    }

    private void ensureAgentTokenUsageSchema() {
        if (!tableExists("t_agent_token_usage")) {
            return;
        }
        addColumnIfMissing("t_agent_token_usage", "cached_tokens",
                "ALTER TABLE t_agent_token_usage ADD COLUMN `cached_tokens` INT DEFAULT 0 COMMENT 'prompt cache read tokens' AFTER `total_tokens`");
        addColumnIfMissing("t_agent_token_usage", "cache_write_tokens",
                "ALTER TABLE t_agent_token_usage ADD COLUMN `cache_write_tokens` INT DEFAULT 0 COMMENT 'prompt cache write tokens' AFTER `cached_tokens`");
    }

    private void executeIgnore(String sql) {
        try {
            jdbcTemplate.execute(sql);
        } catch (Exception e) {
            log.warn("Schema compatibility SQL failed: {}, reason: {}", sql, e.getMessage());
        }
    }
}
