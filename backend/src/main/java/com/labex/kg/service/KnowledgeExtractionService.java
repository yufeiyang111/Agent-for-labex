package com.labex.kg.service;

import com.labex.entity.Lecture;
import com.labex.kg.dto.ExtractionResult;
import com.labex.kg.repository.KnowledgeGraphRepository;
import com.labex.langchain4j.agent.KnowledgeExtractionAgent;
import com.labex.rag.parser.DocumentParserFactory;
import com.labex.rag.parser.DocumentParser;
import com.labex.rag.vector.EmbeddingService;
import com.labex.service.LectureService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.FileInputStream;
import java.util.*;

@Slf4j
@Service
public class KnowledgeExtractionService {

    @Autowired
    private LectureService lectureService;

    @Autowired
    private KnowledgeExtractionAgent extractionAgent;

    @Autowired
    private KnowledgeGraphRepository repository;

    @Autowired
    private EmbeddingService embeddingService;

    @Autowired
    private DocumentParserFactory parserFactory;

    /**
     * Extract knowledge points from specified lectures and store in Neo4j.
     * Runs asynchronously.
     */
    @Async
    public void extractFromLectures(List<Integer> lectureIds, String topicId) {
        List<Lecture> lectures = lectureService.listByIds(lectureIds);
        int totalExtracted = 0;

        for (Lecture lecture : lectures) {
            try {
                String content = readLectureContent(lecture);
                if (content == null || content.isBlank()) {
                    log.warn("Empty content for lecture: {}", lecture.getLectureName());
                    continue;
                }

                // Call LLM to extract knowledge points
                log.info("Extracting KPs from lecture: {}", lecture.getLectureName());
                List<ExtractionResult.ExtractedKnowledgePoint> kps =
                        extractionAgent.extract(content, lecture.getLectureName());

                if (kps.isEmpty()) {
                    log.info("No knowledge points extracted from: {}", lecture.getLectureName());
                    continue;
                }

                // Process each extracted knowledge point
                for (ExtractionResult.ExtractedKnowledgePoint kp : kps) {
                    try {
                        String kpId = storeKnowledgePoint(kp, lecture, topicId);
                        if (kpId != null) {
                            totalExtracted++;
                        }
                    } catch (Exception e) {
                        log.error("Failed to store KP '{}': {}", kp.getName(), e.getMessage());
                    }
                }
            } catch (Exception e) {
                log.error("Failed to extract KPs from lecture {}: {}", lecture.getLectureName(), e.getMessage());
            }
        }

        log.info("Knowledge extraction complete. Total KPs stored: {}", totalExtracted);
    }

    private String storeKnowledgePoint(ExtractionResult.ExtractedKnowledgePoint kp, Lecture lecture, String topicId) {
        // Deduplicate by name similarity
        List<Map<String, Object>> existing = repository.findAllKnowledgePoints(null, kp.getName(), 0, 1);
        if (!existing.isEmpty()) {
            // Update existing KP weight with this lecture
            String existingId = (String) existing.get(0).get("id");
            repository.linkLectureToKnowledgePoint(lecture.getLectureId(), existingId, 1.0);
            if (topicId != null) repository.linkKnowledgePointToTopic(existingId, topicId);
            return existingId;
        }

        // Generate embedding for the knowledge point name+description
        List<Double> embedding = new ArrayList<>();
        try {
            String textForEmbedding = kp.getName() + ": " + kp.getDescription();
            List<List<Double>> embeddings = embeddingService.embed(List.of(textForEmbedding));
            if (embeddings != null && !embeddings.isEmpty()) {
                embedding = embeddings.get(0);
            }
        } catch (Exception e) {
            log.warn("Failed to generate embedding for KP '{}', storing without embedding: {}", kp.getName(), e.getMessage());
        }

        // Create new knowledge point node
        String id = UUID.randomUUID().toString();
        repository.createKnowledgePoint(id, kp.getName(), kp.getDescription(), embedding, "LLM_EXTRACTED", 0.85);

        // Link to lecture
        repository.linkLectureToKnowledgePoint(lecture.getLectureId(), id, 1.0);

        // Link to topic
        if (topicId != null && !topicId.isBlank()) {
            repository.linkKnowledgePointToTopic(id, topicId);
        }

        // Handle prerequisites (by name matching later)
        for (String prereqName : kp.getPrerequisites()) {
            List<Map<String, Object>> prereqCandidates = repository.findAllKnowledgePoints(null, prereqName, 0, 1);
            if (!prereqCandidates.isEmpty()) {
                String prereqId = (String) prereqCandidates.get(0).get("id");
                repository.linkPrerequisite(id, prereqId, 0.8);
            }
        }

        return id;
    }

    private String readLectureContent(Lecture lecture) {
        try {
            String uploadPath = lectureService.getUploadPath();
            File file = new File(uploadPath + lecture.getFilePath());
            if (!file.exists()) {
                log.warn("Lecture file not found: {} (path: {})", lecture.getLectureName(), file.getAbsolutePath());
                return null;
            }
            DocumentParser parser = parserFactory.getParser(lecture.getFilePath());
            if (parser == null) {
                log.warn("No parser for file: {}", lecture.getFilePath());
                return null;
            }
            try (FileInputStream fis = new FileInputStream(file)) {
                return parser.parse(fis, lecture.getFilePath());
            }
        } catch (Exception e) {
            log.error("Failed to read lecture content for {}: {}", lecture.getLectureName(), e.getMessage());
            return null;
        }
    }
}
