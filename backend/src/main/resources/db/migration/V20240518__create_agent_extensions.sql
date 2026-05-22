CREATE TABLE IF NOT EXISTS t_agent_skill (
    skill_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    skill_key VARCHAR(80) NOT NULL,
    title VARCHAR(120) NOT NULL,
    description VARCHAR(500) DEFAULT NULL,
    content LONGTEXT NOT NULL,
    is_enabled TINYINT DEFAULT 1,
    status TINYINT DEFAULT 1,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uk_agent_skill_student_key (student_id, skill_key),
    INDEX idx_agent_skill_student (student_id, status, is_enabled)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS t_agent_mcp_server (
    server_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    server_key VARCHAR(80) NOT NULL,
    server_name VARCHAR(120) NOT NULL,
    transport VARCHAR(32) DEFAULT 'http',
    endpoint VARCHAR(500) NOT NULL,
    auth_header VARCHAR(600) DEFAULT NULL,
    tools_json LONGTEXT DEFAULT NULL,
    is_enabled TINYINT DEFAULT 1,
    status TINYINT DEFAULT 1,
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uk_agent_mcp_student_key (student_id, server_key),
    INDEX idx_agent_mcp_student (student_id, status, is_enabled)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
