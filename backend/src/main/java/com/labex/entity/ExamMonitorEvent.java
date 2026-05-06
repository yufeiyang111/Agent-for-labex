package com.labex.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;

/**
 * 考试监考异常事件
 */
@Data
@TableName("t_exam_monitor_event")
public class ExamMonitorEvent {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField("exam_id")
    private Integer examId;

    @TableField("student_id")
    private Integer studentId;

    @TableField("event_type")
    private String eventType;

    @TableField("event_desc")
    private String eventDesc;

    @TableField("page_url")
    private String pageUrl;

    @TableField("ip")
    private String ip;

    @TableField("occurred_at")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Shanghai")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime occurredAt;
}
