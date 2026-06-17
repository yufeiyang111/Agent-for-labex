package com.labex.rag.retrieval;

import com.labex.rag.vector.Neo4jVectorStore;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

/**
 * Hybrid Retriever combining vector similarity and BM25
 */
@Slf4j
@Service
public class HybridRetriever {

    private final Neo4jVectorStore vectorStore;
    private static final double HIGH_CONFIDENCE_VECTOR_SCORE = 0.78;
    private static final int MAX_RESULTS_PER_DOCUMENT = 2;

    public HybridRetriever(Neo4jVectorStore vectorStore) {
        this.vectorStore = vectorStore;
    }

    /**
     * Search with hybrid approach (vector + BM25)
     *
     * @param query        Query text
     * @param topK         Number of results
     * @return List of search results with scores
     */
    public List<Map<String, Object>> search(String query, int topK) {
        if (query == null || query.isBlank() || topK <= 0) {
            return new ArrayList<>();
        }

        int candidateLimit = Math.max(topK * 6, 30);
        List<Map<String, Object>> vectorResults = vectorStore.searchByVector(query, candidateLimit);
        List<Map<String, Object>> keywordResults = vectorStore.searchByKeyword(query, candidateLimit);
        if (vectorResults.isEmpty() && keywordResults.isEmpty()) {
            return new ArrayList<>();
        }

        List<String> queryTerms = extractTerms(query);
        List<Map<String, Object>> candidates = mergeCandidates(vectorResults, keywordResults);

        List<Map<String, Object>> bm25Scored = bm25Score(queryTerms, candidates);

        for (Map<String, Object> result : bm25Scored) {
            double vectorScore = getDouble(result.get("score"));
            double keywordScore = getDouble(result.get("keywordScore"));
            double bm25Score = getDouble(result.get("bm25Score"));
            double coverageScore = getDouble(result.get("coverageScore"));
            double titleScore = getDouble(result.get("titleScore"));
            double rrfScore = getDouble(result.get("rrfScore"));
            result.put("vectorScore", vectorScore);
            result.put("finalScore",
                    0.40 * vectorScore
                            + 0.22 * keywordScore
                            + 0.16 * bm25Score
                            + 0.10 * coverageScore
                            + 0.05 * titleScore
                            + 0.07 * rrfScore);
        }

        List<Map<String, Object>> sorted = bm25Scored.stream()
                .sorted((a, b) -> Double.compare(
                        getDouble(b.getOrDefault("finalScore", 0.0)),
                        getDouble(a.getOrDefault("finalScore", 0.0))))
                .collect(Collectors.toList());

        List<Map<String, Object>> relevant = sorted.stream()
                .filter(result -> isRelevant(result, queryTerms))
                .collect(Collectors.toList());

        if (relevant.isEmpty() && !queryTerms.isEmpty()) {
            log.info("No relevant knowledge chunks after filtering for query: {}", query);
            return new ArrayList<>();
        }

        return diversify(relevant.isEmpty() ? sorted : relevant, topK);
    }

    private List<Map<String, Object>> mergeCandidates(
            List<Map<String, Object>> vectorResults,
            List<Map<String, Object>> keywordResults) {
        Map<String, Map<String, Object>> merged = new LinkedHashMap<>();

        for (int i = 0; i < vectorResults.size(); i++) {
            Map<String, Object> source = vectorResults.get(i);
            String id = resultId(source);
            Map<String, Object> target = merged.computeIfAbsent(id, ignored -> new HashMap<>(source));
            target.put("score", Math.max(getDouble(target.get("score")), getDouble(source.get("score"))));
            target.put("vectorRank", i + 1);
        }

        for (int i = 0; i < keywordResults.size(); i++) {
            Map<String, Object> source = keywordResults.get(i);
            String id = resultId(source);
            Map<String, Object> target = merged.computeIfAbsent(id, ignored -> new HashMap<>(source));
            for (Map.Entry<String, Object> entry : source.entrySet()) {
                target.putIfAbsent(entry.getKey(), entry.getValue());
            }
            target.put("keywordScore", Math.max(getDouble(target.get("keywordScore")), getDouble(source.get("keywordScore"))));
            target.put("keywordRank", i + 1);
            if (source.get("matchTerms") instanceof List<?> terms && !terms.isEmpty()) {
                target.put("matchTerms", terms);
            }
        }

        for (Map<String, Object> result : merged.values()) {
            int vectorRank = ((Number) result.getOrDefault("vectorRank", candidatePenalty(vectorResults.size()))).intValue();
            int keywordRank = ((Number) result.getOrDefault("keywordRank", candidatePenalty(keywordResults.size()))).intValue();
            double rrf = reciprocalRank(vectorRank) + reciprocalRank(keywordRank);
            result.put("rrfScore", Math.min(1.0, rrf * 30.0));
            Map<String, Object> signals = new LinkedHashMap<>();
            signals.put("vectorRank", result.get("vectorRank"));
            signals.put("keywordRank", result.get("keywordRank"));
            signals.put("rrfScore", result.get("rrfScore"));
            result.put("retrievalSignals", signals);
        }

        return new ArrayList<>(merged.values());
    }

    private String resultId(Map<String, Object> result) {
        return Objects.toString(result.getOrDefault("id", result.getOrDefault("documentId", UUID.randomUUID().toString())));
    }

    private int candidatePenalty(int size) {
        return Math.max(size + 20, 80);
    }

    private double reciprocalRank(int rank) {
        return 1.0 / (60.0 + Math.max(1, rank));
    }

    private List<Map<String, Object>> bm25Score(List<String> queryTerms, List<Map<String, Object>> documents) {
        double avgDocLen = documents.stream()
                .mapToInt(doc -> ((String) doc.getOrDefault("text", "")).length())
                .average()
                .orElse(100.0);

        for (Map<String, Object> doc : documents) {
            String text = (((String) doc.getOrDefault("text", "")) + " " +
                    Objects.toString(doc.get("lectureName"), "") + " " +
                    Objects.toString(doc.get("documentId"), "")).toLowerCase(Locale.ROOT);
            String title = Objects.toString(doc.get("lectureName"), "").toLowerCase(Locale.ROOT);
            int docLen = text.length();

            double score = 0.0;
            int lexicalHits = 0;
            int titleHits = 0;
            Set<String> matchedTerms = new LinkedHashSet<>();
            for (String term : queryTerms) {
                int termFreq = countOccurrences(text, term.toLowerCase(Locale.ROOT));
                if (termFreq > 0) {
                    lexicalHits++;
                    matchedTerms.add(term);
                    // Simplified BM25 formula
                    double tfComponent = (termFreq * (1.2 + 1)) / (termFreq + 1.2 * (1 - 0.75 + 0.75 * docLen / avgDocLen));
                    score += tfComponent;
                }
                if (title.contains(term.toLowerCase(Locale.ROOT))) {
                    titleHits++;
                }
            }
            double termCount = Math.max(queryTerms.size(), 1);
            double coverageScore = Math.min(1.0, lexicalHits / termCount);
            double normalizedBm25 = Math.min(1.0, score / Math.max(2.0, termCount));
            doc.put("bm25Score", normalizedBm25);
            doc.put("coverageScore", coverageScore);
            doc.put("titleScore", Math.min(1.0, titleHits / termCount));
            doc.put("lexicalHits", lexicalHits);
            doc.put("titleHits", titleHits);
            doc.put("matchTerms", new ArrayList<>(matchedTerms));
        }

        return documents;
    }

    private boolean isRelevant(Map<String, Object> result, List<String> queryTerms) {
        if (queryTerms.isEmpty()) {
            return true;
        }
        int lexicalHits = ((Number) result.getOrDefault("lexicalHits", 0)).intValue();
        int titleHits = ((Number) result.getOrDefault("titleHits", 0)).intValue();
        double vectorScore = getDouble(result.get("vectorScore"));
        double keywordScore = getDouble(result.get("keywordScore"));
        return lexicalHits > 0 || titleHits > 0 || vectorScore >= HIGH_CONFIDENCE_VECTOR_SCORE || keywordScore >= 0.35;
    }

    private List<Map<String, Object>> diversify(List<Map<String, Object>> sorted, int topK) {
        List<Map<String, Object>> selected = new ArrayList<>();
        Map<String, Integer> perDocument = new HashMap<>();
        for (Map<String, Object> result : sorted) {
            if (selected.size() >= topK) {
                break;
            }
            String documentKey = Objects.toString(result.getOrDefault("documentId", result.get("lectureId")), "unknown");
            int count = perDocument.getOrDefault(documentKey, 0);
            if (count >= MAX_RESULTS_PER_DOCUMENT) {
                continue;
            }
            selected.add(result);
            perDocument.put(documentKey, count + 1);
        }

        if (selected.size() < topK) {
            Set<Object> selectedIds = selected.stream()
                    .map(result -> result.getOrDefault("id", result.get("documentId")))
                    .collect(Collectors.toSet());
            for (Map<String, Object> result : sorted) {
                if (selected.size() >= topK) {
                    break;
                }
                Object id = result.getOrDefault("id", result.get("documentId"));
                if (selectedIds.add(id)) {
                    selected.add(result);
                }
            }
        }
        return selected;
    }

    private List<String> extractTerms(String query) {
        String normalized = query == null ? "" : query.toLowerCase(Locale.ROOT)
                .replaceAll("[\\p{Cntrl}]+", " ")
                .replaceAll("\\s+", " ")
                .trim();
        Set<String> terms = new LinkedHashSet<>();
        Set<String> stopWords = Set.of(
                "the", "and", "for", "with", "from", "this", "that", "image", "content",
                "about", "what", "how", "why", "when", "where", "which",
                "图片", "内容", "用户", "问题", "主要", "可见", "文字", "信息", "截图",
                "工具", "结果", "分析", "说明", "回答", "这个", "一个", "如果", "可以",
                "进行", "相关", "识别", "看看", "查看", "解释", "一下", "根据", "帮我"
        );

        java.util.regex.Matcher latinMatcher = java.util.regex.Pattern
                .compile("\\b[a-z][a-z0-9+#./-]{1,30}\\b")
                .matcher(normalized);
        while (latinMatcher.find() && terms.size() < 18) {
            String term = latinMatcher.group();
            if (!stopWords.contains(term)) {
                terms.add(term);
            }
        }

        java.util.regex.Matcher chineseMatcher = java.util.regex.Pattern
                .compile("[\\u4e00-\\u9fa5]{2,24}")
                .matcher(normalized);
        while (chineseMatcher.find() && terms.size() < 28) {
            String phrase = chineseMatcher.group();
            if (!stopWords.contains(phrase)) {
                terms.add(phrase);
            }
            if (phrase.length() > 4) {
                for (int size = 4; size >= 2 && terms.size() < 28; size--) {
                    for (int i = 0; i + size <= phrase.length() && terms.size() < 28; i++) {
                        String gram = phrase.substring(i, i + size);
                        if (!stopWords.contains(gram)) {
                            terms.add(gram);
                        }
                    }
                }
            }
        }
        return new ArrayList<>(terms);
    }

    private double getDouble(Object value) {
        return value instanceof Number number ? number.doubleValue() : 0.0;
    }

    private int countOccurrences(String text, String term) {
        if (text == null || term == null || term.isBlank()) {
            return 0;
        }
        int count = 0;
        int index = 0;
        while ((index = text.indexOf(term, index)) != -1) {
            count++;
            index += term.length();
        }
        return count;
    }
}
