package com.labex.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

/**
 * RAG 聊天消息实体
 */
@Data
@TableName("rag_message")
public class RagMessage {

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @TableField("session_id")
    private String sessionId;

    @TableField("role")
    private String role;

    @TableField("content")
    private String content;

    @TableField("sources")
    private String sources;

    @TableField("create_time")
    private Long createTime;
}