package com.labex.kg.dto;

import lombok.Data;
import java.util.List;
import java.util.Map;

/**
 * 知识图谱可视化数据传输对象
 */
@Data
public class GraphDataDTO {

    /** 节点列表 */
    private List<GraphNode> nodes;

    /** 边列表 */
    private List<GraphEdge> edges;

    @Data
    public static class GraphNode {
        /** 节点唯一标识 */
        private String id;
        /** 节点类型: KnowledgePoint, QuestionRef, Document, Topic */
        private String type;
        /** 显示标签 */
        private String label;
        /** 节点属性 */
        private Map<String, Object> properties;
    }

    @Data
    public static class GraphEdge {
        /** 起始节点ID */
        private String source;
        /** 目标节点ID */
        private String target;
        /** 关系类型: BELONGS_TO, TESTS, COVERS, PREREQUISITE_FOR */
        private String type;
        /** 关系属性 */
        private Map<String, Object> properties;
    }
}
