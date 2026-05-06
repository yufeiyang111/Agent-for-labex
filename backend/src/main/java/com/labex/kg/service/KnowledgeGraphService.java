package com.labex.kg.service;

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
