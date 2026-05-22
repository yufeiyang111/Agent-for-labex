package com.labex.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

@TableName(value="rag_session_summary")
public class RagSessionSummary {
    @TableId(value="id", type=IdType.AUTO)
    private Long id;
    @TableField(value="session_id")
    private String sessionId;
    @TableField(value="summary")
    private String summary;
    @TableField(value="message_range_start")
    private Integer messageRangeStart;
    @TableField(value="message_range_end")
    private Integer messageRangeEnd;
    @TableField(value="create_time")
    private Long createTime;

    public Long getId() {
        return this.id;
    }

    public String getSessionId() {
        return this.sessionId;
    }

    public String getSummary() {
        return this.summary;
    }

    public Integer getMessageRangeStart() {
        return this.messageRangeStart;
    }

    public Integer getMessageRangeEnd() {
        return this.messageRangeEnd;
    }

    public Long getCreateTime() {
        return this.createTime;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public void setMessageRangeStart(Integer messageRangeStart) {
        this.messageRangeStart = messageRangeStart;
    }

    public void setMessageRangeEnd(Integer messageRangeEnd) {
        this.messageRangeEnd = messageRangeEnd;
    }

    public void setCreateTime(Long createTime) {
        this.createTime = createTime;
    }

    public boolean equals(Object o) {
        if (o == this) {
            return true;
        }
        if (!(o instanceof RagSessionSummary)) {
            return false;
        }
        RagSessionSummary other = (RagSessionSummary)o;
        if (!other.canEqual(this)) {
            return false;
        }
        Long this$id = this.getId();
        Long other$id = other.getId();
        if (this$id == null ? other$id != null : !(this$id).equals(other$id)) {
            return false;
        }
        Integer this$messageRangeStart = this.getMessageRangeStart();
        Integer other$messageRangeStart = other.getMessageRangeStart();
        if (this$messageRangeStart == null ? other$messageRangeStart != null : !(this$messageRangeStart).equals(other$messageRangeStart)) {
            return false;
        }
        Integer this$messageRangeEnd = this.getMessageRangeEnd();
        Integer other$messageRangeEnd = other.getMessageRangeEnd();
        if (this$messageRangeEnd == null ? other$messageRangeEnd != null : !(this$messageRangeEnd).equals(other$messageRangeEnd)) {
            return false;
        }
        Long this$createTime = this.getCreateTime();
        Long other$createTime = other.getCreateTime();
        if (this$createTime == null ? other$createTime != null : !(this$createTime).equals(other$createTime)) {
            return false;
        }
        String this$sessionId = this.getSessionId();
        String other$sessionId = other.getSessionId();
        if (this$sessionId == null ? other$sessionId != null : !this$sessionId.equals(other$sessionId)) {
            return false;
        }
        String this$summary = this.getSummary();
        String other$summary = other.getSummary();
        return !(this$summary == null ? other$summary != null : !this$summary.equals(other$summary));
    }

    protected boolean canEqual(Object other) {
        return other instanceof RagSessionSummary;
    }

    public int hashCode() {
        int PRIME = 59;
        int result = 1;
        Long $id = this.getId();
        result = result * 59 + ($id == null ? 43 : ($id).hashCode());
        Integer $messageRangeStart = this.getMessageRangeStart();
        result = result * 59 + ($messageRangeStart == null ? 43 : ($messageRangeStart).hashCode());
        Integer $messageRangeEnd = this.getMessageRangeEnd();
        result = result * 59 + ($messageRangeEnd == null ? 43 : ($messageRangeEnd).hashCode());
        Long $createTime = this.getCreateTime();
        result = result * 59 + ($createTime == null ? 43 : ($createTime).hashCode());
        String $sessionId = this.getSessionId();
        result = result * 59 + ($sessionId == null ? 43 : $sessionId.hashCode());
        String $summary = this.getSummary();
        result = result * 59 + ($summary == null ? 43 : $summary.hashCode());
        return result;
    }

    public String toString() {
        return "RagSessionSummary(id=" + this.getId() + ", sessionId=" + this.getSessionId() + ", summary=" + this.getSummary() + ", messageRangeStart=" + this.getMessageRangeStart() + ", messageRangeEnd=" + this.getMessageRangeEnd() + ", createTime=" + this.getCreateTime() + ")";
    }
}

