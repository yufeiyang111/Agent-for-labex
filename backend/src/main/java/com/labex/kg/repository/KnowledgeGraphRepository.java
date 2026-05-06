package com.labex.kg.repository;

import lombok.extern.slf4j.Slf4j;
import org.neo4j.driver.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.*;

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
        try (Session s = session()) {
            return s.executeRead(tx -> {
                Result r = tx.run(
                        "MATCH (st:Student {studentId: $sid})-[sw:STRUGGLES_WITH]->(kp:KnowledgePoint)<-[t:TESTS]-(q:QuestionRef) " +
                        "RETURN q {.questionId, .questionText, .type, .isProgramming} AS question, " +
                        "kp {.id, .name} AS knowledgePoint, sw.errorRate AS errorRate " +
                        "ORDER BY sw.errorRate DESC, t.weight DESC LIMIT $limit",
                        Values.value(Map.of("sid", studentId, "limit", limit)));
                List<Map<String, Object>> list = new ArrayList<>();
                while (r.hasNext()) {
                    org.neo4j.driver.Record rec = r.next();
                    Map<String, Object> item = new HashMap<>();
                    item.put("question", rec.get("question").asMap());
                    item.put("knowledgePoint", rec.get("knowledgePoint").asMap());
                    item.put("errorRate", rec.get("errorRate").asDouble());
                    list.add(item);
                }
                return list;
            });
        }
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
        try (Session s = session()) {
            s.executeWrite(tx -> {
                tx.run("MATCH (st:Student {studentId: $sid}) " +
                        "MATCH (kp:KnowledgePoint {id: $kpId}) " +
                        "MERGE (st)-[r:MASTERED]->(kp) " +
                        "SET r.score = $score, r.lastUpdated = timestamp()",
                        Values.value(Map.of("sid", studentId, "kpId", kpId, "score", score)));
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
                        "collect(DISTINCT {kp: kp {.id, .name}, score: m.score}) AS mastered, " +
                        "collect(DISTINCT {kp: wkp {.id, .name}, errorRate: sw.errorRate, attemptCount: sw.attemptCount}) AS weak",
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
