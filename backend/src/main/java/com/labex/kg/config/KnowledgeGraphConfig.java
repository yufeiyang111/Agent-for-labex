package com.labex.kg.config;

import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;
import org.neo4j.driver.Driver;
import org.neo4j.driver.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;

/**
 * Initializes Neo4j knowledge graph schema: constraints, vector indexes, and node/relationship types.
 */
@Slf4j
@Configuration
public class KnowledgeGraphConfig {

    @Autowired(required = false)
    private Driver driver;

    @PostConstruct
    public void initializeSchema() {
        if (driver == null) {
            log.warn("Neo4j driver not available, skipping knowledge graph schema init");
            return;
        }

        try (Session session = driver.session()) {
            session.executeWrite(tx -> {
                // --- Constraints ---
                tx.run("CREATE CONSTRAINT topic_id IF NOT EXISTS FOR (t:Topic) REQUIRE t.id IS UNIQUE");
                tx.run("CREATE CONSTRAINT kp_id IF NOT EXISTS FOR (kp:KnowledgePoint) REQUIRE kp.id IS UNIQUE");
                tx.run("CREATE CONSTRAINT qref_id IF NOT EXISTS FOR (q:QuestionRef) REQUIRE q.questionId IS UNIQUE");
                tx.run("CREATE CONSTRAINT student_node_id IF NOT EXISTS FOR (s:Student) REQUIRE s.studentId IS UNIQUE");
                return null;
            });

            // Vector index for KnowledgePoint embeddings (cosine similarity, 1024-dim from bge-m3)
            try {
                session.executeWrite(tx -> {
                    tx.run("CREATE VECTOR INDEX knowledge_point_embeddings IF NOT EXISTS " +
                            "FOR (kp:KnowledgePoint) ON (kp.embedding) " +
                            "OPTIONS {indexConfig: {`vector.dimensions`: 1024, `vector.similarity_function`: 'COSINE'}}");
                    return null;
                });
                log.info("KnowledgeGraph vector index created for KnowledgePoint embeddings");
            } catch (Exception e) {
                log.warn("Vector index creation skipped (Neo4j version may not support vector indexes): {}", e.getMessage());
            }

            log.info("Knowledge graph schema initialized successfully");
        } catch (Exception e) {
            log.warn("Knowledge graph schema initialization partially failed: {}", e.getMessage());
        }
    }
}
