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
        ensureTrainingQuestionJudgeResult();
        ensurePermissionSchema();
        ensureAgentConversationSchema();
        ensureAgentFileChangeSchema();
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

    private void executeIgnore(String sql) {
        try {
            jdbcTemplate.execute(sql);
        } catch (Exception e) {
            log.warn("Schema compatibility SQL failed: {}, reason: {}", sql, e.getMessage());
        }
    }
}
