package com.labex.kg.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class KnowledgePointDTO {
    private String id;
    private String name;
    private String description;
    private String source;
    private Double confidence;
    private Long createTime;
    private TopicDTO topic;
    private Double embeddingSimilarity;
}
