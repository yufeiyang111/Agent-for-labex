package com.labex.kg.controller;

import com.labex.common.Result;
import com.labex.entity.Question;
import com.labex.kg.dto.GraphDataDTO;
import com.labex.kg.dto.KnowledgePointDTO;
import com.labex.kg.dto.TopicDTO;
import com.labex.kg.service.KnowledgeExtractionService;
import com.labex.kg.service.KnowledgeGraphService;
import com.labex.kg.service.ProductionQuestionLinkingService;
import com.labex.kg.service.QuestionLinkingService;
import com.labex.mapper.QuestionMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.*;

/**
 * Teacher API for knowledge graph management.
 */
@Slf4j
@RestController
@RequestMapping("/kg")
public class KnowledgeGraphController {

    @Autowired
    private KnowledgeGraphService kgService;

    @Autowired
    private KnowledgeExtractionService extractionService;

    @Autowired
    private QuestionLinkingService linkingService;

    @Autowired
    private ProductionQuestionLinkingService productionLinkingService;

    @Autowired
    private QuestionMapper questionMapper;

    /** Extract knowledge points from lectures */
    @PostMapping("/extract")
    public Result<Map<String, Object>> extract(@RequestBody Map<String, Object> request) {
        @SuppressWarnings("unchecked")
        List<Integer> lectureIds = (List<Integer>) request.get("lectureIds");
        String topicId = (String) request.get("topicId");

        if (lectureIds == null || lectureIds.isEmpty()) {
            return Result.error("Please provide lectureIds");
        }

        extractionService.extractFromLectures(lectureIds, topicId);

        Map<String, Object> result = new HashMap<>();
        result.put("message", "Knowledge extraction started asynchronously");
        result.put("lectureCount", lectureIds.size());
        return Result.success(result);
    }

    /** List knowledge points */
    @GetMapping("/points")
    public Result<Map<String, Object>> listPoints(
            @RequestParam(required = false) String topicId,
            @RequestParam(required = false) String keyword,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {
        return Result.success(kgService.listKnowledgePoints(topicId, keyword, page, size));
    }

    /** Get knowledge point detail */
    @GetMapping("/points/{id}")
    public Result<KnowledgePointDTO> getPoint(@PathVariable String id) {
        KnowledgePointDTO dto = kgService.getKnowledgePoint(id);
        return dto != null ? Result.success(dto) : Result.error("Knowledge point not found");
    }

    /** Create knowledge point manually */
    @PostMapping("/points")
    public Result<KnowledgePointDTO> createPoint(@RequestBody Map<String, Object> body) {
        String name = (String) body.get("name");
        String description = (String) body.get("description");
        String topicId = (String) body.get("topicId");

        if (name == null || name.isBlank()) {
            return Result.error("Name is required");
        }

        KnowledgePointDTO dto = kgService.createKnowledgePoint(name,
                description != null ? description : "", topicId, new ArrayList<>());
        return Result.success(dto);
    }

    /** Update knowledge point */
    @PutMapping("/points/{id}")
    public Result<KnowledgePointDTO> updatePoint(@PathVariable String id, @RequestBody Map<String, Object> body) {
        String name = (String) body.get("name");
        String description = (String) body.get("description");
        String topicId = (String) body.get("topicId");

        if (name == null || name.isBlank()) {
            return Result.error("Name is required");
        }

        KnowledgePointDTO dto = kgService.updateKnowledgePoint(id, name,
                description != null ? description : "", topicId);
        return Result.success(dto);
    }

    /** Delete knowledge point */
    @DeleteMapping("/points/{id}")
    public Result<Void> deletePoint(@PathVariable String id) {
        kgService.deleteKnowledgePoint(id);
        return Result.success(null);
    }

    /** Batch link questions to knowledge points (LLM - slow) */
    @PostMapping("/link-questions")
    public Result<Map<String, Object>> linkQuestions(@RequestBody Map<String, Object> body) {
        boolean forceReprocess = (Boolean) body.getOrDefault("forceReprocess", false);
        List<Question> allQuestions = questionMapper.selectList(null);

        linkingService.linkQuestions(allQuestions, forceReprocess);

        Map<String, Object> result = new HashMap<>();
        result.put("message", "Question linking started asynchronously (LLM mode)");
        result.put("totalQuestions", allQuestions.size());
        return Result.success(result);
    }

    /** Fast link questions using embedding similarity (Production) */
    @PostMapping("/link-questions-fast")
    public Result<Map<String, Object>> linkQuestionsFast(@RequestBody Map<String, Object> body) {
        boolean forceReprocess = (Boolean) body.getOrDefault("forceReprocess", false);
        List<Question> allQuestions = questionMapper.selectList(null);

        productionLinkingService.linkQuestionsFast(allQuestions, forceReprocess);

        Map<String, Object> result = new HashMap<>();
        result.put("message", "Fast question linking started (Embedding mode)");
        result.put("totalQuestions", allQuestions.size());
        result.put("mode", "embedding_similarity");
        return Result.success(result);
    }

    /** Topic list */
    @GetMapping("/topics")
    public Result<List<TopicDTO>> listTopics() {
        return Result.success(kgService.listTopics());
    }

    /** Create topic */
    @PostMapping("/topics")
    public Result<TopicDTO> createTopic(@RequestBody Map<String, Object> body) {
        String name = (String) body.get("name");
        String description = (String) body.get("description");
        return Result.success(kgService.createTopic(name, description));
    }

    /** Update topic */
    @PutMapping("/topics/{id}")
    public Result<TopicDTO> updateTopic(@PathVariable String id, @RequestBody Map<String, Object> body) {
        String name = (String) body.get("name");
        String description = (String) body.get("description");
        if (name == null || name.isBlank()) {
            return Result.error("Name is required");
        }
        return Result.success(kgService.updateTopic(id, name, description));
    }

    /** Delete topic */
    @DeleteMapping("/topics/{id}")
    public Result<Void> deleteTopic(@PathVariable String id) {
        kgService.deleteTopic(id);
        return Result.success(null);
    }

    /** KG statistics */
    @GetMapping("/stats")
    public Result<Map<String, Object>> stats() {
        return Result.success(kgService.getStats());
    }

    // ==================== Graph Visualization ====================

    /** 获取图谱统计信息 */
    @GetMapping("/graph-stats")
    public Result<Map<String, Object>> getGraphStats() {
        return Result.success(kgService.getGraphStats());
    }

    /** 获取知识图谱可视化数据 */
    @GetMapping("/graph-data")
    public Result<GraphDataDTO> getGraphData(
            @RequestParam(required = false) String topicId,
            @RequestParam(required = false) List<String> nodeTypes,
            @RequestParam(defaultValue = "50") int maxNodes,
            @RequestParam(required = false) String centerNodeId) {
        return Result.success(kgService.getGraphData(topicId, nodeTypes, maxNodes, centerNodeId));
    }

    /** 获取节点详情 */
    @GetMapping("/node-detail/{type}/{id}")
    public Result<Map<String, Object>> getNodeDetail(
            @PathVariable String type,
            @PathVariable String id) {
        Map<String, Object> detail = switch (type) {
            case "KnowledgePoint" -> kgService.getKnowledgePointFullDetail(id);
            case "QuestionRef" -> kgService.getQuestionFullDetail(Integer.parseInt(id));
            case "Document" -> kgService.getDocumentFullDetail(id);
            case "Topic" -> kgService.getTopicFullDetail(id);
            default -> null;
        };
        return detail != null ? Result.success(detail) : Result.error("节点不存在");
    }
}
