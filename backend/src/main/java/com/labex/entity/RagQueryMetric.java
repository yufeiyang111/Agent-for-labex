package com.labex.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("rag_query_metric")
public class RagQueryMetric {

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @TableField("session_id")
    private String sessionId;

    @TableField("user_id")
    private String userId;

    @TableField("retrieval_mode")
    private String retrievalMode;

    @TableField("deep_thinking")
    private Integer deepThinking;

    @TableField("question_preview")
    private String questionPreview;

    @TableField("search_query")
    private String searchQuery;

    @TableField("source_count")
    private Integer sourceCount;

    @TableField("knowledge_source_count")
    private Integer knowledgeSourceCount;

    @TableField("web_source_count")
    private Integer webSourceCount;

    @TableField("image_source_count")
    private Integer imageSourceCount;

    @TableField("web_fetched_count")
    private Integer webFetchedCount;

    @TableField("exact_web_count")
    private Integer exactWebCount;

    @TableField("no_sources")
    private Integer noSources;

    @TableField("latency_ms")
    private Long latencyMs;

    @TableField("created_at")
    private Long createdAt;
}
