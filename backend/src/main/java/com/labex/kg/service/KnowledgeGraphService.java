package com.labex.kg.service;

import com.labex.kg.dto.GraphDataDTO;
import com.labex.kg.dto.GraphDataDTO.GraphEdge;
import com.labex.kg.dto.GraphDataDTO.GraphNode;
import com.labex.kg.dto.KnowledgePointDTO;
import com.labex.kg.dto.TopicDTO;
import com.labex.kg.repository.KnowledgeGraphRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@Service
public class KnowledgeGraphService {

    @Autowired
    private KnowledgeGraphRepository repository;

    // ==================== KnowledgePoint CRUD ====================

    public KnowledgePointDTO createKnowledgePoint(String name, String description, String topicId,
                                                   List<Double> embedding) {
        String id = UUID.randomUUID().toString();
        Map<String, Object> node = repository.createKnowledgePoint(id, name, description, embedding, "MANUAL", 1.0);
        if (topicId != null && !topicId.isBlank()) {
            repository.linkKnowledgePointToTopic(id, topicId);
        }
        return toKPDTO(node);
    }

    public Map<String, Object> listKnowledgePoints(String topicId, String keyword, int page, int size) {
        int skip = (page - 1) * size;
        List<Map<String, Object>> list = repository.findAllKnowledgePoints(topicId, keyword, skip, size);
        long total = repository.countKnowledgePoints(topicId, keyword);
        Map<String, Object> result = new HashMap<>();
        result.put("total", total);
        result.put("list", list.stream().map(this::toKPDTO).collect(Collectors.toList()));
        return result;
    }

    public KnowledgePointDTO getKnowledgePoint(String id) {
        Map<String, Object> node = repository.getKnowledgePointDetail(id);
        return node != null ? toKPDTO(node) : null;
    }

    public void deleteKnowledgePoint(String id) {
        repository.deleteKnowledgePoint(id);
    }

    // ==================== Topic CRUD ====================

    public TopicDTO createTopic(String name, String description) {
        String id = UUID.randomUUID().toString();
        Map<String, Object> node = repository.createTopic(id, name, description);
        return toTopicDTO(node);
    }

    public TopicDTO updateTopic(String id, String name, String description) {
        repository.updateTopic(id, name, description);
        Map<String, Object> node = new HashMap<>();
        node.put("id", id);
        node.put("name", name);
        node.put("description", description);
        node.put("kpCount", 0L);
        return toTopicDTO(node);
    }

    public void deleteTopic(String id) {
        repository.deleteTopic(id);
    }

    public List<TopicDTO> listTopics() {
        return repository.findAllTopics().stream().map(this::toTopicDTO).collect(Collectors.toList());
    }

    public Map<String, Object> getStats() {
        return repository.getStats();
    }

    // ==================== Graph Visualization ====================

    /**
     * 获取图谱节点统计信息
     */
    public Map<String, Object> getGraphStats() {
        return repository.getGraphStats();
    }

    /**
     * 获取知识图谱可视化数据
     * @param topicId 可选，按主题筛选
     * @param nodeTypes 要显示的节点类型
     * @param maxNodes 每种类型最大节点数
     * @param centerNodeId 中心节点ID（用于单节点展开）
     * @return 图谱数据（节点和边）
     */
    public GraphDataDTO getGraphData(String topicId, List<String> nodeTypes, int maxNodes, String centerNodeId) {
        Map<String, Object> rawData = repository.getGraphData(topicId, nodeTypes, maxNodes, centerNodeId);
        GraphDataDTO dto = new GraphDataDTO();

        // 转换节点
        @SuppressWarnings("unchecked")
        List<Map<String, Object>> rawNodes = (List<Map<String, Object>>) rawData.getOrDefault("nodes", new ArrayList<>());
        List<GraphNode> nodes = new ArrayList<>();
        for (Map<String, Object> rawNode : rawNodes) {
            GraphNode node = new GraphNode();
            node.setId(Objects.toString(rawNode.get("id"), null));
            node.setType(Objects.toString(rawNode.get("type"), null));
            node.setLabel(Objects.toString(rawNode.get("label"), "未知"));
            @SuppressWarnings("unchecked")
            Map<String, Object> props = (Map<String, Object>) rawNode.get("properties");
            node.setProperties(props != null ? props : new HashMap<>());
            nodes.add(node);
        }
        dto.setNodes(nodes);

        // 转换边
        @SuppressWarnings("unchecked")
        List<Map<String, Object>> rawEdges = (List<Map<String, Object>>) rawData.getOrDefault("edges", new ArrayList<>());
        List<GraphEdge> edges = new ArrayList<>();
        for (Map<String, Object> rawEdge : rawEdges) {
            GraphEdge edge = new GraphEdge();
            edge.setSource(Objects.toString(rawEdge.get("source"), null));
            edge.setTarget(Objects.toString(rawEdge.get("target"), null));
            edge.setType(Objects.toString(rawEdge.get("type"), null));
            @SuppressWarnings("unchecked")
            Map<String, Object> props = (Map<String, Object>) rawEdge.get("properties");
            edge.setProperties(props != null ? props : new HashMap<>());
            edges.add(edge);
        }
        dto.setEdges(edges);

        return dto;
    }

    /** 获取知识点完整详情（含关联信息） */
    public Map<String, Object> getKnowledgePointFullDetail(String kpId) {
        return repository.getKnowledgePointFullDetail(kpId);
    }

    /** 获取题目完整详情（含关联知识点） */
    public Map<String, Object> getQuestionFullDetail(Integer questionId) {
        return repository.getQuestionFullDetail(questionId);
    }

    /** 获取讲义完整详情（含关联知识点） */
    public Map<String, Object> getDocumentFullDetail(String lectureId) {
        return repository.getDocumentFullDetail(lectureId);
    }

    /** 获取主题完整详情（含知识点列表） */
    public Map<String, Object> getTopicFullDetail(String topicId) {
        return repository.getTopicFullDetail(topicId);
    }

    // ==================== DTO Mapping ====================

    private KnowledgePointDTO toKPDTO(Map<String, Object> node) {
        KnowledgePointDTO dto = new KnowledgePointDTO();
        dto.setId(Objects.toString(node.get("id"), null));
        dto.setName(Objects.toString(node.get("name"), null));
        dto.setDescription(Objects.toString(node.get("description"), null));
        dto.setSource(Objects.toString(node.get("source"), null));
        Object conf = node.get("confidence");
        dto.setConfidence(conf instanceof Number ? ((Number) conf).doubleValue() : null);
        Object ct = node.get("createTime");
        dto.setCreateTime(ct instanceof Number ? ((Number) ct).longValue() : null);
        Object topic = node.get("topic");
        if (topic instanceof Map) {
            dto.setTopic(toTopicDTO((Map<String, Object>) topic));
        }
        return dto;
    }

    private TopicDTO toTopicDTO(Map<String, Object> node) {
        TopicDTO dto = new TopicDTO();
        dto.setId(Objects.toString(node.get("id"), null));
        dto.setName(Objects.toString(node.get("name"), null));
        dto.setDescription(Objects.toString(node.get("description"), null));
        Object cnt = node.get("kpCount");
        dto.setKpCount(cnt instanceof Number ? ((Number) cnt).longValue() : null);
        return dto;
    }
}
