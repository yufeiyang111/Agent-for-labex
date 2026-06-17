package com.labex.kg.repository;

import lombok.extern.slf4j.Slf4j;
import org.neo4j.driver.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.*;
import java.util.stream.Collectors;
import java.util.Set;
import java.util.HashSet;

/**
 * Raw Cypher CRUD for knowledge graph entities: Topic, KnowledgePoint, QuestionRef, Student and their relationships.
 */
@Slf4j
@Repository
public class KnowledgeGraphRepository {

    @Autowired(required = false)
    private Driver driver;

    private Session session() {
        if (driver == null) throw new IllegalStateException("Neo4j driver not configured");
        return driver.session();
    }

    // ==================== KnowledgePoint ====================

    public Map<String, Object> createKnowledgePoint(String id, String name, String description,
                                                     List<Double> embedding, String source, double confidence) {
        try (Session s = session()) {
            return s.executeWrite(tx -> {
                Result r = tx.run("CREATE (kp:KnowledgePoint {id: $id, name: $name, description: $description, " +
                                "embedding: $embedding, source: $source, confidence: $confidence, createTime: timestamp()}) " +
                                "RETURN kp {.id, .name, .description, .source, .confidence} AS kp",
                        Values.value(Map.of("id", id, "name", name, "description", description,
                                "embedding", embedding, "source", source, "confidence", confidence)));
                return r.hasNext() ? r.single().get("kp").asMap() : null;
            });
        }
    }

    public List<Map<String, Object>> findAllKnowledgePoints(String topicId, String keyword, int skip, int limit) {
        try (Session s = session()) {
            return s.executeRead(tx -> {
                StringBuilder cypher = new StringBuilder("MATCH (kp:KnowledgePoint)");
                Map<String, Object> params = new HashMap<>();

                List<String> conditions = new ArrayList<>();
                if (topicId != null && !topicId.isBlank()) {
                    conditions.add("(kp)-[:BELONGS_TO]->(:Topic {id: $topicId})");
                    params.put("topicId", topicId);
                }
                if (keyword != null && !keyword.isBlank()) {
                    conditions.add("kp.name CONTAINS $keyword");
                    params.put("keyword", keyword);
                }
                if (!conditions.isEmpty()) {
                    cypher.append(" WHERE ").append(String.join(" AND ", conditions));
                }
                cypher.append(" RETURN kp {.id, .name, .description, .source, .confidence, .createTime} AS kp " +
                        "ORDER BY kp.createTime DESC SKIP $skip LIMIT $limit");
                params.put("skip", skip);
                params.put("limit", limit);

                Result r = tx.run(cypher.toString(), Values.value(params));
                List<Map<String, Object>> list = new ArrayList<>();
                while (r.hasNext()) list.add(r.next().get("kp").asMap());
                return list;
            });
        }
    }

    public long countKnowledgePoints(String topicId, String keyword) {
        try (Session s = session()) {
            return s.executeRead(tx -> {
                StringBuilder cypher = new StringBuilder("MATCH (kp:KnowledgePoint)");
                Map<String, Object> params = new HashMap<>();
                List<String> conditions = new ArrayList<>();
                if (topicId != null && !topicId.isBlank()) {
                    conditions.add("(kp)-[:BELONGS_TO]->(:Topic {id: $topicId})");
                    params.put("topicId", topicId);
                }
                if (keyword != null && !keyword.isBlank()) {
                    conditions.add("kp.name CONTAINS $keyword");
                    params.put("keyword", keyword);
                }
                if (!conditions.isEmpty()) {
                    cypher.append(" WHERE ").append(String.join(" AND ", conditions));
                }
                cypher.append(" RETURN count(kp) AS cnt");
                Result r = tx.run(cypher.toString(), Values.value(params));
                return r.hasNext() ? r.single().get("cnt").asLong() : 0;
            });
        }
    }

    public Map<String, Object> getKnowledgePointDetail(String id) {
        try (Session s = session()) {
            return s.executeRead(tx -> {
                Result r = tx.run("MATCH (kp:KnowledgePoint {id: $id}) " +
                        "OPTIONAL MATCH (kp)-[:BELONGS_TO]->(t:Topic) " +
                        "RETURN kp {.id, .name, .description, .source, .confidence, .createTime, " +
                        "topic: t {.id, .name}} AS kp", Values.value(Map.of("id", id)));
                return r.hasNext() ? r.single().get("kp").asMap() : null;
            });
        }
    }

    public void updateKnowledgePoint(String id, String name, String description, String topicId) {
        try (Session s = session()) {
            s.executeWrite(tx -> {
                // 更新知识点基本信息
                tx.run("MATCH (kp:KnowledgePoint {id: $id}) " +
                                "SET kp.name = $name, kp.description = $description",
                        Values.value(Map.of("id", id, "name", name, "description", description)));

                // 更新主题关联
                if (topicId != null && !topicId.isBlank()) {
                    // 删除旧的主题关联
                    tx.run("MATCH (kp:KnowledgePoint {id: $id})-[r:BELONGS_TO]->(:Topic) DELETE r",
                            Values.value(Map.of("id", id)));
                    // 创建新的主题关联
                    tx.run("MATCH (kp:KnowledgePoint {id: $id}), (t:Topic {id: $topicId}) " +
                                    "CREATE (kp)-[:BELONGS_TO]->(t)",
                            Values.value(Map.of("id", id, "topicId", topicId)));
                }
                return null;
            });
        }
    }

    public void deleteKnowledgePoint(String id) {
        try (Session s = session()) {
            s.executeWrite(tx -> {
                tx.run("MATCH (kp:KnowledgePoint {id: $id}) DETACH DELETE kp", Values.value(Map.of("id", id)));
                return null;
            });
        }
    }

    // ==================== Topic ====================

    public Map<String, Object> createTopic(String id, String name, String description) {
        try (Session s = session()) {
            return s.executeWrite(tx -> {
                Result r = tx.run("CREATE (t:Topic {id: $id, name: $name, description: $description, createTime: timestamp()}) " +
                        "RETURN t {.id, .name, .description} AS t", Values.value(Map.of("id", id, "name", name, "description", description)));
                return r.hasNext() ? r.single().get("t").asMap() : null;
            });
        }
    }

    public List<Map<String, Object>> findAllTopics() {
        try (Session s = session()) {
            return s.executeRead(tx -> {
                Result r = tx.run("MATCH (t:Topic) " +
                        "RETURN t {.id, .name, .description, " +
                        "kpCount: COUNT { (kp:KnowledgePoint)-[:BELONGS_TO]->(t) }} AS t " +
                        "ORDER BY t.name");
                List<Map<String, Object>> list = new ArrayList<>();
                while (r.hasNext()) list.add(r.next().get("t").asMap());
                return list;
            });
        }
    }

    public void updateTopic(String id, String name, String description) {
        try (Session s = session()) {
            s.executeWrite(tx -> {
                tx.run("MATCH (t:Topic {id: $id}) " +
                        "SET t.name = $name, t.description = $description",
                        Values.value(Map.of("id", id, "name", name, "description", description)));
                return null;
            });
        }
    }

    public void deleteTopic(String id) {
        try (Session s = session()) {
            s.executeWrite(tx -> {
                tx.run("MATCH (t:Topic {id: $id}) DETACH DELETE t",
                        Values.value(Map.of("id", id)));
                return null;
            });
        }
    }

    // ==================== Relationships ====================

    public void linkLectureToKnowledgePoint(Integer lectureId, String kpId, double weight) {
        try (Session s = session()) {
            s.executeWrite(tx -> {
                tx.run("MATCH (d:Document {lectureId: $lectureId}) " +
                        "MATCH (kp:KnowledgePoint {id: $kpId}) " +
                        "MERGE (d)-[:COVERS {weight: $weight}]->(kp)",
                        Values.value(Map.of("lectureId", lectureId, "kpId", kpId, "weight", weight)));
                return null;
            });
        }
    }

    public void linkChunkToKnowledgePoint(String chunkId, String kpId, double weight) {
        try (Session s = session()) {
            s.executeWrite(tx -> {
                tx.run("MATCH (c:Chunk {id: $chunkId}) " +
                        "MATCH (kp:KnowledgePoint {id: $kpId}) " +
                        "MERGE (c)-[:ABOUT {weight: $weight}]->(kp)",
                        Values.value(Map.of("chunkId", chunkId, "kpId", kpId, "weight", weight)));
                return null;
            });
        }
    }

    public void linkKnowledgePointToTopic(String kpId, String topicId) {
        try (Session s = session()) {
            s.executeWrite(tx -> {
                tx.run("MATCH (kp:KnowledgePoint {id: $kpId}) " +
                        "MATCH (t:Topic {id: $topicId}) " +
                        "MERGE (kp)-[:BELONGS_TO]->(t)",
                        Values.value(Map.of("kpId", kpId, "topicId", topicId)));
                return null;
            });
        }
    }

    public void linkPrerequisite(String kpId, String prerequisiteKpId, double strength) {
        try (Session s = session()) {
            s.executeWrite(tx -> {
                tx.run("MATCH (a:KnowledgePoint {id: $kpId}) " +
                        "MATCH (b:KnowledgePoint {id: $prereqId}) " +
                        "MERGE (b)-[:PREREQUISITE_FOR {strength: $strength}]->(a)",
                        Values.value(Map.of("kpId", kpId, "prereqId", prerequisiteKpId, "strength", strength)));
                return null;
            });
        }
    }

    // ==================== QuestionRef ====================

    public void upsertQuestionRef(Integer questionId, String questionText, int type, boolean isProgramming) {
        try (Session s = session()) {
            s.executeWrite(tx -> {
                tx.run("MERGE (q:QuestionRef {questionId: $qid}) " +
                        "SET q.questionText = $text, q.type = $type, q.isProgramming = $isProg",
                        Values.value(Map.of("qid", questionId, "text", questionText, "type", type, "isProg", isProgramming)));
                return null;
            });
        }
    }

    public void linkQuestionToKnowledgePoint(Integer questionId, String kpId, double weight, boolean isPrimary) {
        try (Session s = session()) {
            s.executeWrite(tx -> {
                tx.run("MATCH (q:QuestionRef {questionId: $qid}) " +
                        "MATCH (kp:KnowledgePoint {id: $kpId}) " +
                        "MERGE (q)-[:TESTS {weight: $weight, isPrimary: $isPrimary}]->(kp)",
                        Values.value(Map.of("qid", questionId, "kpId", kpId, "weight", weight, "isPrimary", isPrimary)));
                return null;
            });
        }
    }

    // ==================== Recommendation Queries ====================

    /** Find exercises testing KPs that a student struggles with */
    public List<Map<String, Object>> recommendByWeakness(int studentId, int limit) {
        return recommendByWeakness(studentId, limit, Collections.emptySet());
    }

    /** Find exercises testing KPs that a student struggles with, excluding already answered questions. */
    public List<Map<String, Object>> recommendByWeakness(int studentId, int limit, Collection<Integer> excludedQuestionIds) {
        try (Session s = session()) {
            return s.executeRead(tx -> {
                Result r = tx.run(
                        "MATCH (st:Student {studentId: $sid})-[sw:STRUGGLES_WITH]->(kp:KnowledgePoint)<-[t:TESTS]-(q:QuestionRef) " +
                        "WHERE NOT q.questionId IN $excluded " +
                        "WITH q, kp, sw, t, " +
                        "     (coalesce(sw.errorRate, 0.0) * 0.65 + coalesce(t.weight, 1.0) * 0.25 + CASE WHEN coalesce(t.isPrimary, false) THEN 0.10 ELSE 0.0 END) AS priority " +
                        "RETURN q {.questionId, .questionText, .type, .isProgramming} AS question, " +
                        "kp {.id, .name} AS knowledgePoint, sw.errorRate AS errorRate, sw.attemptCount AS attemptCount, " +
                        "coalesce(t.weight, 1.0) AS weight, priority AS priority " +
                        "ORDER BY priority DESC LIMIT $limit",
                        Values.value(Map.of("sid", studentId, "limit", limit, "excluded", new ArrayList<>(excludedQuestionIds))));
                List<Map<String, Object>> list = new ArrayList<>();
                while (r.hasNext()) {
                    org.neo4j.driver.Record rec = r.next();
                    Map<String, Object> item = new HashMap<>();
                    item.put("question", rec.get("question").asMap());
                    item.put("knowledgePoint", rec.get("knowledgePoint").asMap());
                    item.put("errorRate", rec.get("errorRate").asDouble());
                    item.put("attemptCount", rec.get("attemptCount").isNull() ? 0 : rec.get("attemptCount").asInt());
                    item.put("weight", rec.get("weight").asDouble());
                    item.put("priority", rec.get("priority").asDouble());
                    list.add(item);
                }
                return list;
            });
        }
    }

    /** Recommend exercises for low-mastery KPs even if they are not below the struggle threshold. */
    public List<Map<String, Object>> recommendByLowMastery(int studentId, int limit, Collection<Integer> excludedQuestionIds) {
        try (Session s = session()) {
            return s.executeRead(tx -> {
                Result r = tx.run(
                        "MATCH (st:Student {studentId: $sid})-[m:MASTERED]->(kp:KnowledgePoint)<-[t:TESTS]-(q:QuestionRef) " +
                        "WHERE coalesce(m.score, 0.0) < 0.80 AND NOT q.questionId IN $excluded " +
                        "WITH q, kp, m, t, " +
                        "     ((1.0 - coalesce(m.score, 0.0)) * 0.65 + coalesce(t.weight, 1.0) * 0.25 + CASE WHEN coalesce(t.isPrimary, false) THEN 0.10 ELSE 0.0 END) AS priority " +
                        "RETURN q {.questionId, .questionText, .type, .isProgramming} AS question, " +
                        "kp {.id, .name} AS knowledgePoint, (1.0 - coalesce(m.score, 0.0)) AS errorRate, " +
                        "m.attemptCount AS attemptCount, coalesce(t.weight, 1.0) AS weight, priority AS priority " +
                        "ORDER BY priority DESC LIMIT $limit",
                        Values.value(Map.of("sid", studentId, "limit", limit, "excluded", new ArrayList<>(excludedQuestionIds))));
                return recommendationRows(r);
            });
        }
    }

    /** Fallback KG recommendations when the student has no mastery profile yet. */
    public List<Map<String, Object>> recommendGeneral(int limit, Collection<Integer> excludedQuestionIds) {
        try (Session s = session()) {
            return s.executeRead(tx -> {
                Result r = tx.run(
                        "MATCH (kp:KnowledgePoint)<-[t:TESTS]-(q:QuestionRef) " +
                        "WHERE NOT q.questionId IN $excluded " +
                        "WITH q, kp, t, (coalesce(kp.confidence, 0.5) * 0.35 + coalesce(t.weight, 1.0) * 0.55 + CASE WHEN coalesce(t.isPrimary, false) THEN 0.10 ELSE 0.0 END) AS priority " +
                        "RETURN q {.questionId, .questionText, .type, .isProgramming} AS question, " +
                        "kp {.id, .name} AS knowledgePoint, 0.50 AS errorRate, 0 AS attemptCount, coalesce(t.weight, 1.0) AS weight, priority AS priority " +
                        "ORDER BY priority DESC LIMIT $limit",
                        Values.value(Map.of("limit", limit, "excluded", new ArrayList<>(excludedQuestionIds))));
                return recommendationRows(r);
            });
        }
    }

    private List<Map<String, Object>> recommendationRows(Result r) {
        List<Map<String, Object>> list = new ArrayList<>();
        while (r.hasNext()) {
            org.neo4j.driver.Record rec = r.next();
            Map<String, Object> item = new HashMap<>();
            item.put("question", rec.get("question").asMap());
            item.put("knowledgePoint", rec.get("knowledgePoint").asMap());
            item.put("errorRate", rec.get("errorRate").isNull() ? 0.0 : rec.get("errorRate").asDouble());
            item.put("attemptCount", rec.get("attemptCount").isNull() ? 0 : rec.get("attemptCount").asInt());
            item.put("weight", rec.get("weight").isNull() ? 1.0 : rec.get("weight").asDouble());
            item.put("priority", rec.get("priority").isNull() ? 0.0 : rec.get("priority").asDouble());
            list.add(item);
        }
        return list;
    }

    /** Find exercises testing a specific knowledge point */
    public List<Map<String, Object>> recommendByKnowledgePoint(String kpId, int limit) {
        try (Session s = session()) {
            return s.executeRead(tx -> {
                Result r = tx.run(
                        "MATCH (kp:KnowledgePoint {id: $kpId})<-[t:TESTS]-(q:QuestionRef) " +
                        "RETURN q {.questionId, .questionText, .type, .isProgramming} AS question " +
                        "ORDER BY t.weight DESC LIMIT $limit",
                        Values.value(Map.of("kpId", kpId, "limit", limit)));
                List<Map<String, Object>> list = new ArrayList<>();
                while (r.hasNext()) list.add(r.next().get("question").asMap());
                return list;
            });
        }
    }

    /** Find similar exercises testing the same knowledge points */
    public List<Map<String, Object>> recommendSimilar(int questionId, int limit) {
        try (Session s = session()) {
            return s.executeRead(tx -> {
                Result r = tx.run(
                        "MATCH (q:QuestionRef {questionId: $qid})-[:TESTS]->(kp:KnowledgePoint)<-[:TESTS]-(similar:QuestionRef) " +
                        "WHERE similar.questionId <> $qid " +
                        "RETURN similar {.questionId, .questionText, .type, .isProgramming} AS question, " +
                        "count(kp) AS overlap " +
                        "ORDER BY overlap DESC LIMIT $limit",
                        Values.value(Map.of("qid", questionId, "limit", limit)));
                List<Map<String, Object>> list = new ArrayList<>();
                while (r.hasNext()) list.add(r.next().get("question").asMap());
                return list;
            });
        }
    }

    /** Reverse map question IDs to tested knowledge points. */
    public Map<Integer, List<Map<String, Object>>> findKnowledgePointsByQuestionIds(Collection<Integer> questionIds) {
        if (questionIds == null || questionIds.isEmpty()) {
            return Collections.emptyMap();
        }
        try (Session s = session()) {
            return s.executeRead(tx -> {
                Result r = tx.run(
                        "MATCH (q:QuestionRef)-[t:TESTS]->(kp:KnowledgePoint) " +
                        "WHERE q.questionId IN $questionIds " +
                        "RETURN q.questionId AS questionId, " +
                        "collect({kp: kp {.id, .name}, weight: coalesce(t.weight, 1.0), isPrimary: coalesce(t.isPrimary, false)}) AS kps",
                        Values.value(Map.of("questionIds", new ArrayList<>(questionIds))));
                Map<Integer, List<Map<String, Object>>> result = new HashMap<>();
                while (r.hasNext()) {
                    org.neo4j.driver.Record rec = r.next();
                    int questionId = rec.get("questionId").asInt();
                    result.put(questionId, rec.get("kps").asList(v -> v.asMap()));
                }
                return result;
            });
        }
    }

    // ==================== Student Mastery ====================

    public void upsertStudent(int studentId, String studentName) {
        try (Session s = session()) {
            s.executeWrite(tx -> {
                tx.run("MERGE (st:Student {studentId: $sid}) SET st.studentName = $name",
                        Values.value(Map.of("sid", studentId, "name", studentName)));
                return null;
            });
        }
    }

    public void setMastery(int studentId, String kpId, double score) {
        setMastery(studentId, kpId, score, 0);
    }

    public void setMastery(int studentId, String kpId, double score, int attemptCount) {
        try (Session s = session()) {
            s.executeWrite(tx -> {
                tx.run("MATCH (st:Student {studentId: $sid}) " +
                        "MATCH (kp:KnowledgePoint {id: $kpId}) " +
                        "MERGE (st)-[r:MASTERED]->(kp) " +
                        "SET r.score = $score, r.attemptCount = $attemptCount, r.lastUpdated = timestamp()",
                        Values.value(Map.of("sid", studentId, "kpId", kpId, "score", score, "attemptCount", attemptCount)));
                return null;
            });
        }
    }

    public void setStrugglesWith(int studentId, String kpId, double errorRate, int attemptCount) {
        try (Session s = session()) {
            s.executeWrite(tx -> {
                tx.run("MATCH (st:Student {studentId: $sid}) " +
                        "MATCH (kp:KnowledgePoint {id: $kpId}) " +
                        "MERGE (st)-[r:STRUGGLES_WITH]->(kp) " +
                        "SET r.errorRate = $errorRate, r.attemptCount = $attemptCount, r.lastUpdated = timestamp()",
                        Values.value(Map.of("sid", studentId, "kpId", kpId, "errorRate", errorRate, "attemptCount", attemptCount)));
                return null;
            });
        }
    }

    public void removeMasteryEdges(int studentId) {
        try (Session s = session()) {
            s.executeWrite(tx -> {
                tx.run("MATCH (st:Student {studentId: $sid})-[r:MASTERED|STRUGGLES_WITH]->() DELETE r",
                        Values.value(Map.of("sid", studentId)));
                return null;
            });
        }
    }

    public Map<String, Object> getStudentMastery(int studentId) {
        try (Session s = session()) {
            return s.executeRead(tx -> {
                Result r = tx.run("MATCH (st:Student {studentId: $sid}) " +
                        "OPTIONAL MATCH (st)-[m:MASTERED]->(kp:KnowledgePoint) " +
                        "OPTIONAL MATCH (st)-[sw:STRUGGLES_WITH]->(wkp:KnowledgePoint) " +
                        "RETURN st {.studentId, .studentName} AS student, " +
                        "collect(DISTINCT {kp: kp {.id, .name}, score: m.score, attemptCount: m.attemptCount, lastUpdated: m.lastUpdated}) AS mastered, " +
                        "collect(DISTINCT {kp: wkp {.id, .name}, errorRate: sw.errorRate, attemptCount: sw.attemptCount, lastUpdated: sw.lastUpdated}) AS weak",
                        Values.value(Map.of("sid", studentId)));
                if (!r.hasNext()) return null;
                org.neo4j.driver.Record rec = r.single();
                Map<String, Object> result = new HashMap<>();
                result.put("student", rec.get("student").asMap());
                result.put("mastered", rec.get("mastered").asList());
                result.put("weak", rec.get("weak").asList());
                return result;
            });
        }
    }

    // ==================== Graph Visualization ====================

    /**
     * 获取图谱节点统计信息
     */
    public Map<String, Object> getGraphStats() {
        try (Session s = session()) {
            return s.executeRead(tx -> {
                // 分开查询每种类型的节点数量
                long kpCount = tx.run("MATCH (n:KnowledgePoint) RETURN count(n) AS cnt")
                        .single().get("cnt").asLong();
                long questionCount = tx.run("MATCH (n:QuestionRef) RETURN count(n) AS cnt")
                        .single().get("cnt").asLong();
                long docCount = tx.run("MATCH (n:Document) RETURN count(n) AS cnt")
                        .single().get("cnt").asLong();
                long topicCount = tx.run("MATCH (n:Topic) RETURN count(n) AS cnt")
                        .single().get("cnt").asLong();

                Map<String, Object> stats = new HashMap<>();
                stats.put("knowledgePoints", kpCount);
                stats.put("questions", questionCount);
                stats.put("documents", docCount);
                stats.put("topics", topicCount);
                return stats;
            });
        }
    }

    /**
     * 获取知识图谱可视化数据（支持分层加载和节点数量限制）
     * @param topicId 可选，按主题筛选
     * @param nodeTypes 要显示的节点类型
     * @param maxNodes 每种类型的最大节点数
     * @param centerNodeId 中心节点ID（用于单节点展开）
     * @return 包含nodes和edges的Map
     */
    public Map<String, Object> getGraphData(String topicId, List<String> nodeTypes, int maxNodes, String centerNodeId) {
        try (Session s = session()) {
            return s.executeRead(tx -> {
                List<Map<String, Object>> nodes = new ArrayList<>();
                List<Map<String, Object>> edges = new ArrayList<>();

                // 如果指定了中心节点，只获取该节点及其关联
                if (centerNodeId != null && !centerNodeId.isBlank()) {
                    return getCenteredGraph(tx, centerNodeId, maxNodes);
                }

                // 按主题筛选
                if (topicId != null && !topicId.isBlank()) {
                    return getTopicGraph(tx, topicId, nodeTypes, maxNodes);
                }

                // 全量查询（带限制）
                return getFullGraph(tx, nodeTypes, maxNodes);
            });
        }
    }

    /** 以某个节点为中心获取关联图 */
    private Map<String, Object> getCenteredGraph(org.neo4j.driver.TransactionContext tx, String centerNodeId, int limit) {
        // 获取中心节点
        Result centerResult = tx.run(
            "MATCH (center) WHERE " +
            "(center:KnowledgePoint AND center.id = $id) OR " +
            "(center:QuestionRef AND toString(center.questionId) = $id) OR " +
            "(center:Document AND toString(center.lectureId) = $id) OR " +
            "(center:Topic AND center.id = $id) " +
            "RETURN center LIMIT 1",
            Values.value(Map.of("id", centerNodeId)));

        if (!centerResult.hasNext()) {
            return Map.of("nodes", new ArrayList<>(), "edges", new ArrayList<>());
        }

        org.neo4j.driver.types.Node centerNode = centerResult.single().get("center").asNode();
        String centerLabel = centerNode.labels().iterator().next();

        // 获取直接关联的节点和边
        Result r = tx.run(
            "MATCH (center)-[r]-(connected) WHERE " +
            "(center:KnowledgePoint AND center.id = $id) OR " +
            "(center:QuestionRef AND toString(center.questionId) = $id) OR " +
            "(center:Document AND toString(center.lectureId) = $id) OR " +
            "(center:Topic AND center.id = $id) " +
            "WITH center, r, connected " +
            "WHERE (connected:KnowledgePoint OR connected:QuestionRef OR connected:Document OR connected:Topic) " +
            "RETURN " +
            "  labels(center)[0] AS centerType, " +
            "  CASE " +
            "    WHEN 'KnowledgePoint' IN labels(center) THEN center.id " +
            "    WHEN 'QuestionRef' IN labels(center) THEN toString(center.questionId) " +
            "    WHEN 'Document' IN labels(center) THEN toString(center.lectureId) " +
            "    WHEN 'Topic' IN labels(center) THEN center.id " +
            "  END AS centerId, " +
            "  CASE " +
            "    WHEN 'KnowledgePoint' IN labels(center) THEN center.name " +
            "    WHEN 'QuestionRef' IN labels(center) THEN substring(center.questionText, 0, 30) " +
            "    WHEN 'Document' IN labels(center) THEN COALESCE(center.title, center.name, '讲义-' + toString(center.lectureId)) " +
            "    WHEN 'Topic' IN labels(center) THEN center.name " +
            "  END AS centerLabel, " +
            "  properties(center) AS centerProps, " +
            "  labels(connected)[0] AS connType, " +
            "  CASE " +
            "    WHEN 'KnowledgePoint' IN labels(connected) THEN connected.id " +
            "    WHEN 'QuestionRef' IN labels(connected) THEN toString(connected.questionId) " +
            "    WHEN 'Document' IN labels(connected) THEN toString(connected.lectureId) " +
            "    WHEN 'Topic' IN labels(connected) THEN connected.id " +
            "  END AS connId, " +
            "  CASE " +
            "    WHEN 'KnowledgePoint' IN labels(connected) THEN connected.name " +
            "    WHEN 'QuestionRef' IN labels(connected) THEN substring(connected.questionText, 0, 30) " +
            "    WHEN 'Document' IN labels(connected) THEN COALESCE(connected.title, connected.name, '讲义-' + toString(connected.lectureId)) " +
            "    WHEN 'Topic' IN labels(connected) THEN connected.name " +
            "  END AS connLabel, " +
            "  properties(connected) AS connProps, " +
            "  type(r) AS relType",
            Values.value(Map.of("id", centerNodeId)));

        List<Map<String, Object>> nodes = new ArrayList<>();
        List<Map<String, Object>> edges = new ArrayList<>();
        Set<String> addedNodeIds = new HashSet<>();

        // 添加中心节点
        Map<String, Object> centerNodeMap = new HashMap<>();
        String centerId = getNodeProperty(centerNode, "id", "questionId", "lectureId");
        centerNodeMap.put("id", centerId);
        centerNodeMap.put("type", centerLabel);
        centerNodeMap.put("label", getNodeLabel(centerNode));
        centerNodeMap.put("properties", centerNode.asMap());
        centerNodeMap.put("isCenter", true);
        nodes.add(centerNodeMap);
        addedNodeIds.add(centerId);

        // 添加关联节点和边
        while (r.hasNext()) {
            org.neo4j.driver.Record rec = r.next();
            String connId = rec.get("connId").asString();

            if (!addedNodeIds.contains(connId)) {
                Map<String, Object> connNode = new HashMap<>();
                connNode.put("id", connId);
                connNode.put("type", rec.get("connType").asString());
                connNode.put("label", rec.get("connLabel").asString());
                connNode.put("properties", rec.get("connProps").asMap());
                connNode.put("isCenter", false);
                nodes.add(connNode);
                addedNodeIds.add(connId);
            }

            // 添加边
            Map<String, Object> edge = new HashMap<>();
            edge.put("source", rec.get("centerId").asString());
            edge.put("target", connId);
            edge.put("type", rec.get("relType").asString());
            edges.add(edge);
        }

        Map<String, Object> result = new HashMap<>();
        result.put("nodes", nodes);
        result.put("edges", edges);
        return result;
    }

    /** 获取节点ID */
    private String getNodeProperty(org.neo4j.driver.types.Node node, String... props) {
        for (String prop : props) {
            if (node.containsKey(prop)) {
                Object val = node.get(prop);
                return val instanceof Number ? String.valueOf(val) : val.toString();
            }
        }
        return node.id() + "";
    }

    /** 获取节点显示标签 */
    private String getNodeLabel(org.neo4j.driver.types.Node node) {
        String label = node.labels().iterator().next();
        switch (label) {
            case "KnowledgePoint":
                return node.containsKey("name") ? node.get("name").asString() : "知识点";
            case "QuestionRef":
                return node.containsKey("questionText") ?
                    node.get("questionText").asString().substring(0, Math.min(30, node.get("questionText").asString().length())) : "题目";
            case "Document":
                if (node.containsKey("title")) return node.get("title").asString();
                if (node.containsKey("name")) return node.get("name").asString();
                return "讲义-" + (node.containsKey("lectureId") ? node.get("lectureId") : "");
            case "Topic":
                return node.containsKey("name") ? node.get("name").asString() : "主题";
            default:
                return label;
        }
    }

    /** 获取指定主题下的图谱 */
    private Map<String, Object> getTopicGraph(org.neo4j.driver.TransactionContext tx, String topicId, List<String> nodeTypes, int limit) {
        StringBuilder cypher = new StringBuilder();
        Map<String, Object> params = new HashMap<>();
        params.put("topicId", topicId);
        params.put("limit", limit);

        cypher.append("MATCH (t:Topic {id: $topicId})<-[:BELONGS_TO]-(kp:KnowledgePoint) ");

        // 根据要显示的节点类型构建查询
        boolean showQuestions = nodeTypes == null || nodeTypes.contains("QuestionRef");
        boolean showDocs = nodeTypes == null || nodeTypes.contains("Document");

        if (showQuestions) {
            cypher.append("OPTIONAL MATCH (kp)<-[:TESTS]-(q:QuestionRef) ");
        }
        if (showDocs) {
            cypher.append("OPTIONAL MATCH (doc:Document)-[:COVERS]->(kp) ");
        }

        cypher.append("WITH t, kp, ");
        if (showQuestions) cypher.append("collect(DISTINCT q) AS questions, ");
        if (showDocs) cypher.append("collect(DISTINCT doc) AS docs, ");
        cypher.append("collect(DISTINCT kp) AS kps ");

        cypher.append("RETURN ");
        cypher.append("  collect(DISTINCT {id: t.id, type: 'Topic', label: t.name, properties: properties(t)}) + ");
        cypher.append("  [kp IN kps | {id: kp.id, type: 'KnowledgePoint', label: kp.name, properties: properties(kp)}] ");

        if (showQuestions) {
            cypher.append("+ [q IN questions[0..$limit] | {id: toString(q.questionId), type: 'QuestionRef', label: substring(q.questionText, 0, 30), properties: properties(q)}] ");
        }
        if (showDocs) {
            cypher.append("+ [d IN docs[0..$limit] | {id: toString(d.lectureId), type: 'Document', label: COALESCE(d.title, d.name, '讲义-' + toString(d.lectureId)), properties: properties(d)}] ");
        }

        cypher.append(" AS nodes");

        Result r = tx.run(cypher.toString(), Values.value(params));
        List<Map<String, Object>> nodes = r.hasNext() ?
                r.single().get("nodes").asList(v -> v.asMap()) : new ArrayList<>();

        // 查询关系
        StringBuilder edgeCypher = new StringBuilder();
        Map<String, Object> edgeParams = new HashMap<>();
        edgeParams.put("topicId", topicId);

        edgeCypher.append("MATCH (t:Topic {id: $topicId})<-[:BELONGS_TO]-(kp:KnowledgePoint) ");
        edgeCypher.append("OPTIONAL MATCH (kp)<-[r1:TESTS]-(q:QuestionRef) ");
        edgeCypher.append("OPTIONAL MATCH (doc:Document)-[r2:COVERS]->(kp) ");
        edgeCypher.append("OPTIONAL MATCH (kp)-[r3:BELONGS_TO]->(t) ");
        edgeCypher.append("RETURN ");
        edgeCypher.append("  CASE WHEN q IS NOT NULL THEN [{id: toString(q.questionId), type: 'QuestionRef'}, {id: kp.id, type: 'KnowledgePoint'}, 'TESTS'] END AS e1, ");
        edgeCypher.append("  CASE WHEN doc IS NOT NULL THEN [{id: toString(doc.lectureId), type: 'Document'}, {id: kp.id, type: 'KnowledgePoint'}, 'COVERS'] END AS e2, ");
        edgeCypher.append("  CASE WHEN kp IS NOT NULL THEN [{id: kp.id, type: 'KnowledgePoint'}, {id: t.id, type: 'Topic'}, 'BELONGS_TO'] END AS e3");

        Result edgeResult = tx.run(edgeCypher.toString(), Values.value(edgeParams));
        List<Map<String, Object>> edges = new ArrayList<>();

        while (edgeResult.hasNext()) {
            org.neo4j.driver.Record rec = edgeResult.next();
            for (String key : new String[]{"e1", "e2", "e3"}) {
                Value val = rec.get(key);
                if (!val.isNull() && val.asList().size() >= 3) {
                    List<Object> edgeData = val.asList(Value::asObject);
                    Map<String, Object> edge = new HashMap<>();
                    @SuppressWarnings("unchecked")
                    Map<String, Object> source = (Map<String, Object>) edgeData.get(0);
                    @SuppressWarnings("unchecked")
                    Map<String, Object> target = (Map<String, Object>) edgeData.get(1);
                    edge.put("source", source.get("id"));
                    edge.put("target", target.get("id"));
                    edge.put("type", edgeData.get(2));
                    edges.add(edge);
                }
            }
        }

        Map<String, Object> result = new HashMap<>();
        result.put("nodes", nodes);
        result.put("edges", edges);
        return result;
    }

    /** 全量图谱查询（带限制） */
    private Map<String, Object> getFullGraph(org.neo4j.driver.TransactionContext tx, List<String> nodeTypes, int limit) {
        boolean showKP = nodeTypes == null || nodeTypes.contains("KnowledgePoint");
        boolean showQuestion = nodeTypes == null || nodeTypes.contains("QuestionRef");
        boolean showDoc = nodeTypes == null || nodeTypes.contains("Document");
        boolean showTopic = nodeTypes == null || nodeTypes.contains("Topic");

        StringBuilder cypher = new StringBuilder("MATCH (n) WHERE ");
        List<String> labels = new ArrayList<>();
        if (showKP) labels.add("n:KnowledgePoint");
        if (showQuestion) labels.add("n:QuestionRef");
        if (showDoc) labels.add("n:Document");
        if (showTopic) labels.add("n:Topic");

        if (labels.isEmpty()) {
            return Map.of("nodes", new ArrayList<>(), "edges", new ArrayList<>());
        }

        cypher.append(String.join(" OR ", labels));
        cypher.append(" WITH n, head(labels(n)) AS label ");
        cypher.append("ORDER BY n.createTime DESC ");
        cypher.append("WITH label, collect(n)[0..$limit] AS nodesOfLabel ");
        cypher.append("UNWIND nodesOfLabel AS node ");
        cypher.append("RETURN collect(DISTINCT { ");
        cypher.append("  id: CASE ");
        cypher.append("    WHEN 'KnowledgePoint' IN labels(node) THEN node.id ");
        cypher.append("    WHEN 'QuestionRef' IN labels(node) THEN toString(node.questionId) ");
        cypher.append("    WHEN 'Document' IN labels(node) THEN toString(node.lectureId) ");
        cypher.append("    WHEN 'Topic' IN labels(node) THEN node.id ");
        cypher.append("  END, ");
        cypher.append("  type: head(labels(node)), ");
        cypher.append("  label: CASE ");
        cypher.append("    WHEN 'KnowledgePoint' IN labels(node) THEN node.name ");
        cypher.append("    WHEN 'QuestionRef' IN labels(node) THEN substring(node.questionText, 0, 30) ");
        cypher.append("    WHEN 'Document' IN labels(node) THEN COALESCE(node.title, node.name, '讲义-' + toString(node.lectureId)) ");
        cypher.append("    WHEN 'Topic' IN labels(node) THEN node.name ");
        cypher.append("  END, ");
        cypher.append("  properties: properties(node) ");
        cypher.append("}) AS nodes");

        Map<String, Object> params = new HashMap<>();
        params.put("limit", limit);

        Result r = tx.run(cypher.toString(), Values.value(params));
        List<Map<String, Object>> nodes = r.hasNext() ?
                r.single().get("nodes").asList(v -> v.asMap()) : new ArrayList<>();

        // 获取这些节点之间的关系
        List<String> nodeIds = nodes.stream()
                .map(n -> Objects.toString(n.get("id"), ""))
                .filter(id -> !id.isEmpty())
                .collect(Collectors.toList());

        if (nodeIds.isEmpty()) {
            return Map.of("nodes", nodes, "edges", new ArrayList<>());
        }

        Result edgeResult = tx.run(
            "MATCH (a)-[r]->(b) WHERE " +
            "(a.id IN $ids OR toString(a.questionId) IN $ids OR toString(a.lectureId) IN $ids) AND " +
            "(b.id IN $ids OR toString(b.questionId) IN $ids OR toString(b.lectureId) IN $ids) AND " +
            "type(r) IN ['BELONGS_TO', 'TESTS', 'COVERS', 'PREREQUISITE_FOR'] " +
            "RETURN collect(DISTINCT { " +
            "  source: CASE " +
            "    WHEN 'KnowledgePoint' IN labels(a) THEN a.id " +
            "    WHEN 'QuestionRef' IN labels(a) THEN toString(a.questionId) " +
            "    WHEN 'Document' IN labels(a) THEN toString(a.lectureId) " +
            "    WHEN 'Topic' IN labels(a) THEN a.id " +
            "  END, " +
            "  target: CASE " +
            "    WHEN 'KnowledgePoint' IN labels(b) THEN b.id " +
            "    WHEN 'QuestionRef' IN labels(b) THEN toString(b.questionId) " +
            "    WHEN 'Document' IN labels(b) THEN toString(b.lectureId) " +
            "    WHEN 'Topic' IN labels(b) THEN b.id " +
            "  END, " +
            "  type: type(r) " +
            "}) AS edges",
            Values.value(Map.of("ids", nodeIds)));

        List<Map<String, Object>> edges = edgeResult.hasNext() ?
                edgeResult.single().get("edges").asList(v -> v.asMap()) : new ArrayList<>();

        Map<String, Object> result = new HashMap<>();
        result.put("nodes", nodes);
        result.put("edges", edges);
        return result;
    }

    /**
     * @deprecated 使用重载版本
     */
    public Map<String, Object> getGraphData(String topicId, int depth) {
        return getGraphData(topicId, null, 50, null);
    }

    /** 获取知识点详情（包含关联信息） */
    public Map<String, Object> getKnowledgePointFullDetail(String kpId) {
        try (Session s = session()) {
            return s.executeRead(tx -> {
                Result r = tx.run(
                    "MATCH (kp:KnowledgePoint {id: $kpId}) " +
                    "OPTIONAL MATCH (kp)-[:BELONGS_TO]->(t:Topic) " +
                    "OPTIONAL MATCH (q:QuestionRef)-[:TESTS]->(kp) " +
                    "OPTIONAL MATCH (doc:Document)-[:COVERS]->(kp) " +
                    "OPTIONAL MATCH (pre:KnowledgePoint)-[:PREREQUISITE_FOR]->(kp) " +
                    "OPTIONAL MATCH (kp)-[:PREREQUISITE_FOR]->(post:KnowledgePoint) " +
                    "RETURN kp {.id, .name, .description, .source, .confidence, .createTime} AS kp, " +
                    "t {.id, .name} AS topic, " +
                    "collect(DISTINCT q {.questionId, .questionText, .type, .isProgramming}) AS questions, " +
                    "collect(DISTINCT doc {.lectureId, .title}) AS documents, " +
                    "collect(DISTINCT pre {.id, .name}) AS prerequisites, " +
                    "collect(DISTINCT post {.id, .name}) AS postrequisites",
                    Values.value(Map.of("kpId", kpId)));
                if (!r.hasNext()) return null;
                org.neo4j.driver.Record rec = r.single();
                Map<String, Object> result = new HashMap<>();
                result.put("knowledgePoint", rec.get("kp").asMap());
                result.put("topic", rec.get("topic").isNull() ? null : rec.get("topic").asMap());
                result.put("questions", rec.get("questions").asList(v -> v.asMap()));
                result.put("documents", rec.get("documents").asList(v -> v.asMap()));
                result.put("prerequisites", rec.get("prerequisites").asList(v -> v.asMap()));
                result.put("postrequisites", rec.get("postrequisites").asList(v -> v.asMap()));
                return result;
            });
        }
    }

    /** 获取题目详情（包含关联知识点） */
    public Map<String, Object> getQuestionFullDetail(Integer questionId) {
        try (Session s = session()) {
            return s.executeRead(tx -> {
                Result r = tx.run(
                    "MATCH (q:QuestionRef) WHERE toString(q.questionId) = toString($qid) " +
                    "OPTIONAL MATCH (q)-[:TESTS]->(kp:KnowledgePoint) " +
                    "RETURN q {.questionId, .questionText, .type, .isProgramming} AS question, " +
                    "collect(DISTINCT kp {.id, .name}) AS knowledgePoints",
                    Values.value(Map.of("qid", questionId)));
                if (!r.hasNext()) return null;
                org.neo4j.driver.Record rec = r.single();
                Map<String, Object> result = new HashMap<>();
                result.put("question", rec.get("question").asMap());
                result.put("knowledgePoints", rec.get("knowledgePoints").asList(v -> v.asMap()));
                return result;
            });
        }
    }

    /** 获取讲义详情（包含关联知识点） */
    public Map<String, Object> getDocumentFullDetail(String lectureId) {
        try (Session s = session()) {
            return s.executeRead(tx -> {
                // lectureId 可能是整数，尝试转换
                Result r = tx.run(
                    "MATCH (doc:Document) WHERE toString(doc.lectureId) = $lectureId " +
                    "OPTIONAL MATCH (doc)-[:COVERS]->(kp:KnowledgePoint) " +
                    "RETURN doc {.lectureId, .title, .name} AS document, " +
                    "collect(DISTINCT kp {.id, .name}) AS knowledgePoints",
                    Values.value(Map.of("lectureId", lectureId)));
                if (!r.hasNext()) return null;
                org.neo4j.driver.Record rec = r.single();
                Map<String, Object> result = new HashMap<>();
                result.put("document", rec.get("document").asMap());
                result.put("knowledgePoints", rec.get("knowledgePoints").asList(v -> v.asMap()));
                return result;
            });
        }
    }

    /** 获取主题详情（包含知识点列表） */
    public Map<String, Object> getTopicFullDetail(String topicId) {
        try (Session s = session()) {
            return s.executeRead(tx -> {
                Result r = tx.run(
                    "MATCH (t:Topic {id: $topicId}) " +
                    "OPTIONAL MATCH (kp:KnowledgePoint)-[:BELONGS_TO]->(t) " +
                    "RETURN t {.id, .name, .description} AS topic, " +
                    "collect(DISTINCT kp {.id, .name}) AS knowledgePoints",
                    Values.value(Map.of("topicId", topicId)));
                if (!r.hasNext()) return null;
                org.neo4j.driver.Record rec = r.single();
                Map<String, Object> result = new HashMap<>();
                result.put("topic", rec.get("topic").asMap());
                result.put("knowledgePoints", rec.get("knowledgePoints").asList(v -> v.asMap()));
                return result;
            });
        }
    }

    // ==================== Stats ====================

    public Map<String, Object> getStats() {
        try (Session s = session()) {
            return s.executeRead(tx -> {
                Result r = tx.run("MATCH (kp:KnowledgePoint) " +
                        "OPTIONAL MATCH (q:QuestionRef)-[:TESTS]->(kp) " +
                        "RETURN count(DISTINCT kp) AS totalKPs, count(DISTINCT q) AS linkedQuestions");
                if (!r.hasNext()) {
                    Map<String, Object> empty = new HashMap<>();
                    empty.put("totalKPs", 0L);
                    empty.put("linkedQuestions", 0L);
                    return empty;
                }
                org.neo4j.driver.Record rec = r.single();
                Map<String, Object> stats = new HashMap<>();
                stats.put("totalKPs", rec.get("totalKPs").asLong());
                stats.put("linkedQuestions", rec.get("linkedQuestions").asLong());
                return stats;
            });
        }
    }
}
