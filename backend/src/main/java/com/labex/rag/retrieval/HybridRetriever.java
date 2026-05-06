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
        // Get results from vector store
        List<Map<String, Object>> vectorResults = vectorStore.searchByVector(query, topK * 2);

        // Apply simple BM25-like scoring
        List<Map<String, Object>> bm25Scored = bm25Score(query, vectorResults);

        // Combine scores (simple weighted average)
        for (Map<String, Object> result : bm25Scored) {
            double vectorScore = result.containsKey("score") ? (double) result.get("score") : 0.0;
            double bm25Score = result.containsKey("bm25Score") ? (double) result.get("bm25Score") : 0.0;
            result.put("finalScore", 0.6 * vectorScore + 0.4 * bm25Score);
        }

        // Sort by final score and return top K
        return bm25Scored.stream()
                .sorted((a, b) -> Double.compare(
                        (double) b.getOrDefault("finalScore", 0.0),
                        (double) a.getOrDefault("finalScore", 0.0)))
                .limit(topK)
                .collect(Collectors.toList());
    }

    private List<Map<String, Object>> bm25Score(String query, List<Map<String, Object>> documents) {
        String[] queryTerms = query.toLowerCase().split("\\s+");
        double avgDocLen = documents.stream()
                .mapToInt(doc -> ((String) doc.getOrDefault("text", "")).length())
                .average()
                .orElse(100.0);

        for (Map<String, Object> doc : documents) {
            String text = ((String) doc.getOrDefault("text", "")).toLowerCase();
            int docLen = text.length();

            double score = 0.0;
            int termFreq;
            for (String term : queryTerms) {
                termFreq = countOccurrences(text, term);
                if (termFreq > 0) {
                    // Simplified BM25 formula
                    double tfComponent = (termFreq * (1.2 + 1)) / (termFreq + 1.2 * (1 - 0.75 + 0.75 * docLen / avgDocLen));
                    score += tfComponent;
                }
            }
            doc.put("bm25Score", score);
        }

        return documents;
    }

    private int countOccurrences(String text, String term) {
        int count = 0;
        int index = 0;
        while ((index = text.indexOf(term, index)) != -1) {
            count++;
            index += term.length();
        }
        return count;
    }
}
