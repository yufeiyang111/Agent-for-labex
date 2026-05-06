package com.labex.rag.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SessionDTO {
    private String sessionId;
    private String userId;
    private String title;
    private Long createTime;
    private Long lastActiveTime;
    private Integer messageCount;
}