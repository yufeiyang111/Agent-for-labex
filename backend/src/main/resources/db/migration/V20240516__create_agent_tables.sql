-- Agent Conversation table
CREATE TABLE IF NOT EXISTS t_agent_conversation (
    conversation_id VARCHAR(64) NOT NULL PRIMARY KEY,
    student_id INT NOT NULL,
    project_id INT NOT NULL,
    title VARCHAR(500) DEFAULT NULL,
    mode VARCHAR(32) DEFAULT 'agent',
    provider VARCHAR(64) DEFAULT NULL,
    model VARCHAR(128) DEFAULT NULL,
    summary TEXT DEFAULT NULL,
    status INT DEFAULT 1,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_conv_student (student_id),
    INDEX idx_conv_project (project_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Agent Task table
CREATE TABLE IF NOT EXISTS t_agent_task (
    task_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    conversation_id VARCHAR(64) NOT NULL,
    session_id VARCHAR(128) DEFAULT NULL,
    student_id INT NOT NULL,
    project_id INT NOT NULL,
    title VARCHAR(500) DEFAULT NULL,
    mode VARCHAR(32) DEFAULT 'agent',
    status VARCHAR(32) DEFAULT 'pending',
    current_step VARCHAR(500) DEFAULT NULL,
    summary TEXT DEFAULT NULL,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_task_conv (conversation_id),
    INDEX idx_task_student (student_id),
    INDEX idx_task_project (project_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Agent Message table
CREATE TABLE IF NOT EXISTS t_agent_message (
    message_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    conversation_id VARCHAR(64) NOT NULL,
    student_id INT NOT NULL,
    project_id INT NOT NULL,
    event_type VARCHAR(32) DEFAULT NULL,
    role VARCHAR(32) DEFAULT NULL,
    content LONGTEXT DEFAULT NULL,
    event_data LONGTEXT DEFAULT NULL,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_msg_conv (conversation_id),
    INDEX idx_msg_student (student_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Agent ChangeSet table
CREATE TABLE IF NOT EXISTS t_agent_change_set (
    change_set_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    task_id BIGINT NOT NULL,
    conversation_id VARCHAR(64) NOT NULL,
    student_id INT NOT NULL,
    project_id INT NOT NULL,
    status VARCHAR(32) DEFAULT 'pending',
    change_count INT DEFAULT 0,
    summary TEXT DEFAULT NULL,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_cs_task (task_id),
    INDEX idx_cs_conv (conversation_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Agent FileChange table
CREATE TABLE IF NOT EXISTS t_agent_file_change (
    change_id VARCHAR(64) NOT NULL PRIMARY KEY,
    change_set_id BIGINT NOT NULL,
    task_id BIGINT NOT NULL,
    conversation_id VARCHAR(64) NOT NULL,
    student_id INT NOT NULL,
    project_id INT NOT NULL,
    relative_path VARCHAR(1000) NOT NULL,
    change_type VARCHAR(32) DEFAULT 'modify',
    before_hash VARCHAR(128) DEFAULT NULL,
    before_content LONGTEXT DEFAULT NULL,
    after_content LONGTEXT DEFAULT NULL,
    diff_text LONGTEXT DEFAULT NULL,
    status VARCHAR(32) DEFAULT 'pending',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    applied_time DATETIME DEFAULT NULL,
    rejected_time DATETIME DEFAULT NULL,
    undone_time DATETIME DEFAULT NULL,
    INDEX idx_fc_cs (change_set_id),
    INDEX idx_fc_task (task_id),
    INDEX idx_fc_conv (conversation_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Agent Verification table
CREATE TABLE IF NOT EXISTS t_agent_verification (
    verification_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    task_id BIGINT NOT NULL,
    change_set_id BIGINT NOT NULL,
    student_id INT NOT NULL,
    project_id INT NOT NULL,
    command VARCHAR(2000) DEFAULT NULL,
    status VARCHAR(32) DEFAULT 'pending',
    exit_code INT DEFAULT NULL,
    output LONGTEXT DEFAULT NULL,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_ver_task (task_id),
    INDEX idx_ver_cs (change_set_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
