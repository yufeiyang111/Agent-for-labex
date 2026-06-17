package com.labex.rag.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.labex.entity.RagQueryMetric;
import com.labex.mapper.RagQueryMetricMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Objects;

@Slf4j
@Service
public class RagQueryMetricService {

    private final RagQueryMetricMapper mapper;

    public RagQueryMetricService(RagQueryMetricMapper mapper) {
        this.mapper = mapper;
    }

    public void record(
            String sessionId,
            String userId,
            String retrievalMode,
            boolean deepThinking,
            String question,
            String searchQuery,
            List<Map<String, Object>> sources,
            long latencyMs) {
        try {
            RagQueryMetric metric = new RagQueryMetric();
            metric.setSessionId(sessionId);
            metric.setUserId(userId);
            metric.setRetrievalMode(retrievalMode);
            metric.setDeepThinking(deepThinking ? 1 : 0);
            metric.setQuestionPreview(truncate(question, 500));
            metric.setSearchQuery(truncate(searchQuery, 500));
            metric.setSourceCount(sources == null ? 0 : sources.size());
            metric.setKnowledgeSourceCount(countType(sources, "knowledge"));
            metric.setWebSourceCount(countType(sources, "web"));
            metric.setImageSourceCount(countType(sources, "image"));
            metric.setWebFetchedCount(countWebFlag(sources, "contentFetched"));
            metric.setExactWebCount(countWebFlag(sources, "exactMatch"));
            metric.setNoSources(sources == null || sources.isEmpty() ? 1 : 0);
            metric.setLatencyMs(Math.max(0, latencyMs));
            metric.setCreatedAt(System.currentTimeMillis());
            mapper.insert(metric);
        } catch (Exception e) {
            log.debug("Failed to record RAG query metric: {}", e.getMessage());
        }
    }

    public Map<String, Object> summary(String userId, int limit) {
        int safeLimit = Math.max(10, Math.min(500, limit));
        List<RagQueryMetric> rows = mapper.selectList(new QueryWrapper<RagQueryMetric>()
                .eq(userId != null && !userId.isBlank(), "user_id", userId)
                .orderByDesc("created_at")
                .last("LIMIT " + safeLimit));

        Map<String, Object> summary = new LinkedHashMap<>();
        summary.put("sampleSize", rows.size());
        if (rows.isEmpty()) {
            summary.put("averageLatencyMs", 0);
            summary.put("noSourceRate", 0);
            summary.put("webFetchRate", 0);
            summary.put("exactWebRate", 0);
            summary.put("averageSources", 0);
            return summary;
        }

        long totalLatency = 0;
        int noSource = 0;
        int webSources = 0;
        int webFetched = 0;
        int exactWeb = 0;
        int totalSources = 0;
        Map<String, Integer> byMode = new LinkedHashMap<>();
        for (RagQueryMetric row : rows) {
            totalLatency += row.getLatencyMs() == null ? 0 : row.getLatencyMs();
            noSource += Integer.valueOf(1).equals(row.getNoSources()) ? 1 : 0;
            webSources += row.getWebSourceCount() == null ? 0 : row.getWebSourceCount();
            webFetched += row.getWebFetchedCount() == null ? 0 : row.getWebFetchedCount();
            exactWeb += row.getExactWebCount() == null ? 0 : row.getExactWebCount();
            totalSources += row.getSourceCount() == null ? 0 : row.getSourceCount();
            String mode = Objects.toString(row.getRetrievalMode(), "unknown");
            byMode.put(mode, byMode.getOrDefault(mode, 0) + 1);
        }

        summary.put("averageLatencyMs", totalLatency / rows.size());
        summary.put("noSourceRate", ratio(noSource, rows.size()));
        summary.put("webFetchRate", ratio(webFetched, webSources));
        summary.put("exactWebRate", ratio(exactWeb, webSources));
        summary.put("averageSources", ratio(totalSources, rows.size()));
        summary.put("byMode", byMode);
        return summary;
    }

    private int countType(List<Map<String, Object>> sources, String type) {
        if (sources == null || sources.isEmpty()) {
            return 0;
        }
        int count = 0;
        for (Map<String, Object> source : sources) {
            if (type.equals(Objects.toString(source.get("type"), ""))) {
                count++;
            }
        }
        return count;
    }

    private int countWebFlag(List<Map<String, Object>> sources, String flag) {
        if (sources == null || sources.isEmpty()) {
            return 0;
        }
        int count = 0;
        for (Map<String, Object> source : sources) {
            if ("web".equals(Objects.toString(source.get("type"), "")) && Boolean.TRUE.equals(source.get(flag))) {
                count++;
            }
        }
        return count;
    }

    private String truncate(String value, int maxLength) {
        if (value == null) {
            return "";
        }
        return value.length() <= maxLength ? value : value.substring(0, maxLength);
    }

    private double ratio(int numerator, int denominator) {
        if (denominator <= 0) {
            return 0.0;
        }
        return Math.round((numerator / (double) denominator) * 10000.0) / 10000.0;
    }
}
