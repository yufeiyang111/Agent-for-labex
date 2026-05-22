-- Agent Model Configuration Table
-- Allows students to configure their own LLM provider, model, and API key

CREATE TABLE IF NOT EXISTS `t_agent_model_config` (
    `config_id` INT AUTO_INCREMENT PRIMARY KEY,
    `student_id` INT NOT NULL,
    `config_name` VARCHAR(100) NOT NULL DEFAULT 'Default',
    `provider` VARCHAR(50) NOT NULL DEFAULT 'openai_compatible',
    `model_name` VARCHAR(100) NOT NULL DEFAULT 'gpt-4o-mini',
    `api_key` VARCHAR(500) NOT NULL,
    `base_url` VARCHAR(300) DEFAULT 'https://api.openai.com',
    `max_tokens` INT DEFAULT 8192,
    `temperature` DOUBLE DEFAULT NULL,
    `is_default` TINYINT DEFAULT 0,
    `status` TINYINT DEFAULT 1,
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_student_id` (`student_id`),
    INDEX `idx_student_default` (`student_id`, `is_default`, `status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Supported providers:
-- openai_compatible: OpenAI, DeepSeek, MiniMax, Moonshot, Qwen, etc.
-- anthropic: Claude
-- google: Gemini
