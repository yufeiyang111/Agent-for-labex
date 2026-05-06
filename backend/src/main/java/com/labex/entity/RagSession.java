package com.labex.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.util.Date;

/**
 * RAG 会话实体
 */
@Data
@TableName("rag_session")
public class RagSession {

    @TableId(value = "id", type = IdType.INPUT)
    private String id;

    @TableField("user_id")
    private String userId;

    @TableField("title")
    private String title;

    @TableField("create_time")
    private Long createTime;

    @TableField("last_active_time")
    private Long lastActiveTime;

    @TableField("message_count")
    private Integer messageCount;
}