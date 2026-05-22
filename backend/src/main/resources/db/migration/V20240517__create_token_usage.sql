CREATE TABLE IF NOT EXISTS t_agent_token_usage (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    conversation_id VARCHAR(64) NOT NULL,
    session_id VARCHAR(128) DEFAULT NULL,
    student_id INT NOT NULL,
    project_id INT NOT NULL,
    provider VARCHAR(64) DEFAULT NULL,
    model VARCHAR(128) DEFAULT NULL,
    prompt_tokens INT DEFAULT 0,
    completion_tokens INT DEFAULT 0,
    total_tokens INT DEFAULT 0,
    iteration INT DEFAULT 0,
    tool_name VARCHAR(64) DEFAULT NULL,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_token_conv (conversation_id),
    INDEX idx_token_student (student_id),
    INDEX idx_token_project (project_id),
    INDEX idx_token_session (session_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
