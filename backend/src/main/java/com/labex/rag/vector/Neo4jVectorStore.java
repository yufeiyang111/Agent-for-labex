package com.labex.rag.vector;

import lombok.extern.slf4j.Slf4j;
import org.neo4j.driver.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

/**
 * Neo4j Vector Store for RAG chunks
 */
@Slf4j
@Service
public class Neo4jVectorStore {

    private final Driver driver;
    private final EmbeddingService embeddingService;

    public Neo4jVectorStore(
            @Autowired(required = false) Driver driver,
            EmbeddingService embeddingService) {
        this.driver = driver;
        this.embeddingService = embeddingService;
        if (driver != null) {
            initializeSchema();
        }
    }

    private void initializeSchema() {
        if (driver == null) return;

        try (Session session = driver.session()) {
            // Create constraints and indexes
            session.executeWrite(tx -> {
                tx.run("CREATE CONSTRAINT document_id IF NOT EXISTS FOR (d:Document) REQUIRE d.id IS UNIQUE");
                tx.run("CREATE CONSTRAINT chunk_id IF NOT EXISTS FOR (c:Chunk) REQUIRE c.id IS UNIQUE");
                return null;
            });
            // Create vector index for embedding similarity search
            try {
                session.executeWrite(tx -> {
                    tx.run("CREATE VECTOR INDEX chunk_embeddings IF NOT EXISTS " +
                            "FOR (c:Chunk) ON (c.embedding) " +
                            "OPTIONS {indexConfig: {`vector.dimensions`: 1024, `vector.similarity_function`: 'cosine'}}");
                    return null;
                });
                log.info("Neo4j vector index 'chunk_embeddings' created");
            } catch (Exception e) {
                log.warn("Vector index creation skipped (may already exist): {}", e.getMessage());
            }
            try {
                session.executeWrite(tx -> {
                    tx.run("CREATE FULLTEXT INDEX chunk_text_fulltext IF NOT EXISTS FOR (c:Chunk) ON EACH [c.text]");
                    return null;
                });
                log.info("Neo4j fulltext index 'chunk_text_fulltext' created");
            } catch (Exception e) {
                log.warn("Fulltext index creation skipped (may already exist or unsupported): {}", e.getMessage());
            }
            log.info("Neo4j vector store schema initialized");
        } catch (Exception e) {
            log.warn("Schema initialization skipped: {}", e.getMessage());
        }
    }

    /**
     * Store document with chunks
     *
     * @param documentId Document ID
     * @param fileName   Original filename (lecture name)
     * @param lectureId  Lecture ID
     * @param lectureType Lecture type
     * @param chunks    List of text chunks
     * @return Number of chunks stored
     */
    public int storeDocument(String documentId, String fileName, Integer lectureId, Integer lectureType, List<String> chunks) {
        if (driver == null) {
            log.warn("Neo4j driver not configured, skipping vector storage");
            return 0;
        }

        try {
            // Generate embeddings
            List<List<Double>> embeddings = embeddingService.embed(chunks);

            try (Session session = driver.session()) {
                session.executeWrite(tx -> {
                    // Create document node with lecture metadata
                    tx.run("MERGE (d:Document {id: $docId}) " +
                                    "SET d.fileName = $fileName, d.lectureId = $lectureId, d.lectureType = $lectureType, d.createTime = timestamp()",
                            Values.value(Map.of(
                                    "docId", documentId,
                                    "fileName", fileName,
                                    "lectureId", lectureId,
                                    "lectureType", lectureType
                            )));

                    // Create chunk nodes with embeddings
                    for (int i = 0; i < chunks.size(); i++) {
                        String chunkId = documentId + "_chunk_" + i;
                        String chunkText = chunks.get(i);
                        List<Double> embedding = embeddings.get(i);

                        // Store chunk with embedding
                        tx.run("MERGE (c:Chunk {id: $chunkId}) " +
                                        "SET c.text = $text, c.index = $index, c.documentId = $docId, c.embedding = $embedding",
                                Values.value(Map.of(
                                        "chunkId", chunkId,
                                        "text", chunkText,
                                        "index", i,
                                        "docId", documentId,
                                        "embedding", embedding
                                )));

                        // Link to document
                        tx.run("MATCH (d:Document {id: $docId}) " +
                                        "MATCH (c:Chunk {id: $chunkId}) " +
                                        "MERGE (d)-[:CONTAINS]->(c)",
                                Values.value(Map.of("docId", documentId, "chunkId", chunkId)));
                    }
                    return null;
                });
            }

            log.info("Stored document {} with {} chunks", documentId, chunks.size());
            return chunks.size();
        } catch (Exception e) {
            log.error("Failed to store document: {}", e.getMessage());
            throw new RuntimeException("Failed to store document: " + e.getMessage(), e);
        }
    }

    /**
     * Store document with chunks (legacy method for backward compatibility)
     */
    public int storeDocument(String documentId, String fileName, List<String> chunks) {
        return storeDocument(documentId, fileName, null, null, chunks);
    }

    /**
     * Search chunks by vector similarity
     *
     * @param queryText    Query text
     * @param topK         Number of results
     * @return List of chunk data with lecture info
     */
    public List<Map<String, Object>> searchByVector(String queryText, int topK) {
        if (driver == null) {
            log.warn("Neo4j driver not configured");
            return new ArrayList<>();
        }

        try {
            // Get query embedding
            List<List<Double>> queryEmbedding = embeddingService.embed(List.of(queryText));
            List<Double> queryVec = queryEmbedding.get(0);

            try (Session session = driver.session()) {
                return session.executeRead(tx -> {
                    List<Map<String, Object>> chunks = new ArrayList<>();

                    // Use vector index for similarity search
                    try {
                        Result result = tx.run(
                                "CALL db.index.vector.queryNodes('chunk_embeddings', $topK, $queryVector) " +
                                "YIELD node AS c, score " +
                                "MATCH (d:Document)-[:CONTAINS]->(c) " +
                                "RETURN c.id AS id, c.text AS text, c.documentId AS documentId, " +
                                "d.lectureId AS lectureId, d.lectureType AS lectureType, d.fileName AS lectureName, " +
                                "c.index AS `index`, score",
                                Values.value(Map.of("topK", topK, "queryVector", queryVec))
                        );

                        while (result.hasNext()) {
                            org.neo4j.driver.Record record = result.next();
                            Map<String, Object> chunk = new HashMap<>();
                            chunk.put("id", record.get("id").asString());
                            chunk.put("text", record.get("text").asString());
                            chunk.put("documentId", record.get("documentId").asString());
                            if (!record.get("lectureId").isNull()) {
                                chunk.put("lectureId", record.get("lectureId").asInt());
                            }
                            if (!record.get("lectureType").isNull()) {
                                chunk.put("lectureType", record.get("lectureType").asInt());
                            }
                            if (!record.get("lectureName").isNull()) {
                                chunk.put("lectureName", record.get("lectureName").asString());
                            }
                            chunk.put("index", record.get("index").asInt());
                            chunk.put("score", record.get("score").asDouble());
                            chunks.add(chunk);
                        }

                        log.debug("Vector search returned {} results for query: {}", chunks.size(), queryText);
                    } catch (Exception e) {
                        log.warn("Vector index search failed, falling back to full scan: {}", e.getMessage());
                        // Fallback: get all chunks with embedding and compute similarity in Java
                        Result result = tx.run("MATCH (d:Document)-[:CONTAINS]->(c:Chunk) " +
                                "WHERE c.text IS NOT NULL AND c.embedding IS NOT NULL " +
                                "RETURN c.id AS id, c.text AS text, c.documentId AS documentId, " +
                                "d.lectureId AS lectureId, d.lectureType AS lectureType, d.fileName AS lectureName, " +
                                "c.index AS `index`, c.embedding AS embedding " +
                                "LIMIT 200");

                        while (result.hasNext()) {
                            org.neo4j.driver.Record record = result.next();
                            Map<String, Object> chunk = new HashMap<>();
                            chunk.put("id", record.get("id").asString());
                            chunk.put("text", record.get("text").asString());
                            chunk.put("documentId", record.get("documentId").asString());
                            if (!record.get("lectureId").isNull()) {
                                chunk.put("lectureId", record.get("lectureId").asInt());
                            }
                            if (!record.get("lectureType").isNull()) {
                                chunk.put("lectureType", record.get("lectureType").asInt());
                            }
                            if (!record.get("lectureName").isNull()) {
                                chunk.put("lectureName", record.get("lectureName").asString());
                            }
                            chunk.put("index", record.get("index").asInt());

                            // Compute cosine similarity in Java
                            @SuppressWarnings("unchecked")
                            List<Object> rawEmbedding = (List<Object>) record.get("embedding").asList();
                            List<Double> chunkEmbedding = new ArrayList<>();
                            for (Object v : rawEmbedding) {
                                chunkEmbedding.add(((Number) v).doubleValue());
                            }
                            double similarity = cosineSimilarity(queryVec, chunkEmbedding);
                            chunk.put("score", similarity);
                            chunks.add(chunk);
                        }

                        // Sort by score
                        chunks.sort((a, b) -> Double.compare((double) b.get("score"), (double) a.get("score")));
                        if (chunks.size() > topK) {
                            chunks = chunks.subList(0, topK);
                        }
                    }

                    return chunks;
                });
            }
        } catch (Exception e) {
            log.error("Vector search failed: {}", e.getMessage());
            return new ArrayList<>();
        }
    }

    /**
     * Search chunks by lexical keyword overlap. This gives the RAG pipeline a
     * true text-search leg to combine with vector recall.
     */
    public List<Map<String, Object>> searchByKeyword(String queryText, int topK) {
        if (driver == null || queryText == null || queryText.isBlank() || topK <= 0) {
            return new ArrayList<>();
        }

        List<String> terms = extractTerms(queryText);
        if (terms.isEmpty()) {
            return new ArrayList<>();
        }

        List<Map<String, Object>> fullTextResults = searchByFullTextIndex(queryText, terms, topK);
        if (!fullTextResults.isEmpty()) {
            return fullTextResults;
        }

        try (Session session = driver.session()) {
            return session.executeRead(tx -> {
                Result result = tx.run(
                        "MATCH (d:Document)-[:CONTAINS]->(c:Chunk) " +
                        "WHERE c.text IS NOT NULL " +
                        "RETURN c.id AS id, c.text AS text, c.documentId AS documentId, " +
                        "d.lectureId AS lectureId, d.lectureType AS lectureType, d.fileName AS lectureName, " +
                        "c.index AS `index` LIMIT 3000");

                List<Map<String, Object>> chunks = new ArrayList<>();
                while (result.hasNext()) {
                    org.neo4j.driver.Record record = result.next();
                    String text = record.get("text").asString("");
                    String title = record.get("lectureName").isNull() ? "" : record.get("lectureName").asString();
                    KeywordScore score = keywordScore(queryText, terms, title, text);
                    if (score.score() <= 0) {
                        continue;
                    }

                    Map<String, Object> chunk = new HashMap<>();
                    chunk.put("id", record.get("id").asString());
                    chunk.put("text", text);
                    chunk.put("documentId", record.get("documentId").asString(""));
                    if (!record.get("lectureId").isNull()) {
                        chunk.put("lectureId", record.get("lectureId").asInt());
                    }
                    if (!record.get("lectureType").isNull()) {
                        chunk.put("lectureType", record.get("lectureType").asInt());
                    }
                    if (!title.isBlank()) {
                        chunk.put("lectureName", title);
                    }
                    if (!record.get("index").isNull()) {
                        chunk.put("index", record.get("index").asInt());
                    }
                    chunk.put("keywordScore", score.score());
                    chunk.put("coverageScore", score.coverage());
                    chunk.put("titleScore", score.titleScore());
                    chunk.put("matchTerms", score.matchTerms());
                    chunks.add(chunk);
                }

                chunks.sort((a, b) -> Double.compare(
                        ((Number) b.getOrDefault("keywordScore", 0.0)).doubleValue(),
                        ((Number) a.getOrDefault("keywordScore", 0.0)).doubleValue()));
                if (chunks.size() > topK) {
                    return new ArrayList<>(chunks.subList(0, topK));
                }
                return chunks;
            });
        } catch (Exception e) {
            log.warn("Keyword search failed: {}", e.getMessage());
            return new ArrayList<>();
        }
    }

    private List<Map<String, Object>> searchByFullTextIndex(String queryText, List<String> terms, int topK) {
        String fullTextQuery = buildFullTextQuery(terms);
        if (fullTextQuery.isBlank()) {
            return new ArrayList<>();
        }
        try (Session session = driver.session()) {
            return session.executeRead(tx -> {
                Result result = tx.run(
                        "CALL db.index.fulltext.queryNodes('chunk_text_fulltext', $query) YIELD node AS c, score " +
                        "MATCH (d:Document)-[:CONTAINS]->(c) " +
                        "RETURN c.id AS id, c.text AS text, c.documentId AS documentId, " +
                        "d.lectureId AS lectureId, d.lectureType AS lectureType, d.fileName AS lectureName, " +
                        "c.index AS `index`, score ORDER BY score DESC LIMIT $topK",
                        Values.value(Map.of("query", fullTextQuery, "topK", Math.max(topK * 2, topK))));

                List<Map<String, Object>> chunks = new ArrayList<>();
                double maxRawScore = 0.0;
                while (result.hasNext()) {
                    org.neo4j.driver.Record record = result.next();
                    String text = record.get("text").asString("");
                    String title = record.get("lectureName").isNull() ? "" : record.get("lectureName").asString();
                    double rawScore = record.get("score").asDouble(0.0);
                    maxRawScore = Math.max(maxRawScore, rawScore);
                    KeywordScore lexical = keywordScore(queryText, terms, title, text);

                    Map<String, Object> chunk = new HashMap<>();
                    chunk.put("id", record.get("id").asString());
                    chunk.put("text", text);
                    chunk.put("documentId", record.get("documentId").asString(""));
                    if (!record.get("lectureId").isNull()) {
                        chunk.put("lectureId", record.get("lectureId").asInt());
                    }
                    if (!record.get("lectureType").isNull()) {
                        chunk.put("lectureType", record.get("lectureType").asInt());
                    }
                    if (!title.isBlank()) {
                        chunk.put("lectureName", title);
                    }
                    if (!record.get("index").isNull()) {
                        chunk.put("index", record.get("index").asInt());
                    }
                    chunk.put("keywordRawScore", rawScore);
                    chunk.put("keywordScore", lexical.score());
                    chunk.put("coverageScore", lexical.coverage());
                    chunk.put("titleScore", lexical.titleScore());
                    chunk.put("matchTerms", lexical.matchTerms());
                    chunks.add(chunk);
                }

                double normalizer = maxRawScore <= 0.0 ? 1.0 : maxRawScore;
                for (Map<String, Object> chunk : chunks) {
                    double raw = ((Number) chunk.getOrDefault("keywordRawScore", 0.0)).doubleValue();
                    double lexical = ((Number) chunk.getOrDefault("keywordScore", 0.0)).doubleValue();
                    chunk.put("keywordScore", Math.min(1.0, 0.62 * (raw / normalizer) + 0.38 * lexical));
                }
                chunks.sort((a, b) -> Double.compare(
                        ((Number) b.getOrDefault("keywordScore", 0.0)).doubleValue(),
                        ((Number) a.getOrDefault("keywordScore", 0.0)).doubleValue()));
                return chunks.size() > topK ? new ArrayList<>(chunks.subList(0, topK)) : chunks;
            });
        } catch (Exception e) {
            log.debug("Neo4j fulltext search unavailable, falling back to Java keyword scoring: {}", e.getMessage());
            return new ArrayList<>();
        }
    }

    private String buildFullTextQuery(List<String> terms) {
        return terms.stream()
                .filter(term -> term != null && !term.isBlank())
                .map(term -> term.replaceAll("[+\\-!(){}\\[\\]^\"~*?:\\\\/]", " ").trim())
                .filter(term -> !term.isBlank())
                .limit(12)
                .map(term -> "\"" + term + "\"")
                .reduce((a, b) -> a + " OR " + b)
                .orElse("");
    }

    /**
     * Compute cosine similarity between two vectors
     */
    private double cosineSimilarity(List<Double> a, List<Double> b) {
        if (a == null || b == null || a.size() != b.size() || a.isEmpty()) {
            return 0.0;
        }
        double dotProduct = 0.0, normA = 0.0, normB = 0.0;
        for (int i = 0; i < a.size(); i++) {
            dotProduct += a.get(i) * b.get(i);
            normA += a.get(i) * a.get(i);
            normB += b.get(i) * b.get(i);
        }
        double denom = Math.sqrt(normA) * Math.sqrt(normB);
        return denom == 0 ? 0.0 : dotProduct / denom;
    }

    private List<String> extractTerms(String query) {
        String normalized = query.toLowerCase(Locale.ROOT)
                .replaceAll("[\\p{Cntrl}]+", " ")
                .replaceAll("[\\p{Punct}\\p{P}]+", " ")
                .replaceAll("\\s+", " ")
                .trim();
        Set<String> terms = new LinkedHashSet<>();
        Set<String> stopWords = Set.of(
                "the", "and", "for", "with", "from", "this", "that", "what", "how", "why", "are", "is",
                "请", "帮我", "解释", "说明", "这个", "一个", "可以", "如何", "怎么", "什么", "哪些",
                "根据", "回答", "分析", "总结", "相关", "内容", "问题", "知识点", "资料"
        );

        java.util.regex.Matcher latinMatcher = java.util.regex.Pattern
                .compile("\\b[a-z][a-z0-9+#./-]{1,32}\\b")
                .matcher(normalized);
        while (latinMatcher.find() && terms.size() < 20) {
            String term = latinMatcher.group();
            if (!stopWords.contains(term)) {
                terms.add(term);
            }
        }

        java.util.regex.Matcher chineseMatcher = java.util.regex.Pattern
                .compile("[\\u4e00-\\u9fa5]{2,24}")
                .matcher(normalized);
        while (chineseMatcher.find() && terms.size() < 32) {
            String phrase = chineseMatcher.group();
            if (!stopWords.contains(phrase)) {
                terms.add(phrase);
            }
            if (phrase.length() > 4) {
                for (int size = 4; size >= 2 && terms.size() < 32; size--) {
                    for (int i = 0; i + size <= phrase.length() && terms.size() < 32; i++) {
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

    private KeywordScore keywordScore(String query, List<String> terms, String title, String text) {
        String haystack = (title + "\n" + text).toLowerCase(Locale.ROOT);
        String titleText = title.toLowerCase(Locale.ROOT);
        int hits = 0;
        int titleHits = 0;
        double score = 0.0;
        Set<String> matchedTerms = new LinkedHashSet<>();
        for (String term : terms) {
            String lower = term.toLowerCase(Locale.ROOT);
            int freq = countOccurrences(haystack, lower);
            if (freq <= 0) {
                continue;
            }
            hits++;
            matchedTerms.add(term);
            double termScore = Math.min(1.0, Math.log1p(freq) / 2.4);
            if (titleText.contains(lower)) {
                titleHits++;
                termScore += 0.22;
            }
            score += termScore;
        }
        double termCount = Math.max(1, terms.size());
        double coverage = Math.min(1.0, hits / termCount);
        double titleScore = Math.min(1.0, titleHits / termCount);
        double exactQueryBoost = !query.isBlank() && haystack.contains(query.toLowerCase(Locale.ROOT)) ? 0.18 : 0.0;
        double normalized = Math.min(1.0, (score / Math.max(2.0, termCount)) * 0.72 + coverage * 0.22 + titleScore * 0.12 + exactQueryBoost);
        return new KeywordScore(normalized, coverage, titleScore, new ArrayList<>(matchedTerms));
    }

    private int countOccurrences(String text, String term) {
        if (text == null || term == null || term.isBlank()) {
            return 0;
        }
        int count = 0;
        int index = 0;
        while ((index = text.indexOf(term, index)) >= 0) {
            count++;
            index += term.length();
        }
        return count;
    }

    private record KeywordScore(double score, double coverage, double titleScore, List<String> matchTerms) {
    }

    /**
     * Delete document and its chunks
     *
     * @param documentId Document ID
     */
    public void deleteDocument(String documentId) {
        if (driver == null) return;

        try (Session session = driver.session()) {
            session.executeWrite(tx -> {
                // Delete all chunks for this document
                tx.run("MATCH (c:Chunk {documentId: $docId}) DETACH DELETE c");
                // Delete document node
                tx.run("MATCH (d:Document {id: $docId}) DETACH DELETE d", Values.value(Map.of("docId", documentId)));
                return null;
            });
            log.info("Deleted document: {}", documentId);
        } catch (Exception e) {
            log.error("Failed to delete document: {}", e.getMessage());
        }
    }

    /**
     * Get all documents
     *
     * @return List of document info
     */
    public List<Map<String, Object>> getAllDocuments() {
        if (driver == null) return new ArrayList<>();

        try (Session session = driver.session()) {
            return session.executeRead(tx -> {
                List<Map<String, Object>> docs = new ArrayList<>();
                Result result = tx.run("MATCH (d:Document) " +
                        "OPTIONAL MATCH (d)-[:CONTAINS]->(c:Chunk) " +
                        "RETURN d.id AS id, d.fileName AS fileName, count(c) AS chunkCount, d.createTime AS createTime");

                while (result.hasNext()) {
                    org.neo4j.driver.Record record = result.next();
                    Map<String, Object> doc = new HashMap<>();
                    doc.put("id", record.get("id").asString());
                    doc.put("fileName", record.get("fileName").asString());
                    doc.put("chunkCount", record.get("chunkCount").asInt());
                    doc.put("createTime", record.get("createTime").asLong());
                    docs.add(doc);
                }
                return docs;
            });
        } catch (Exception e) {
            log.error("Failed to get documents: {}", e.getMessage());
            return new ArrayList<>();
        }
    }
}
