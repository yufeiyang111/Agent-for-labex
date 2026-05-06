package com.labex.rag.vector;

import com.labex.rag.config.RagConfig;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * Service for calling Python NLP service (SpaCy)
 */
@Slf4j
@Service
public class NlpService {

    private final RagConfig ragConfig;
    private final org.springframework.web.client.RestTemplate restTemplate;

    public NlpService(RagConfig ragConfig) {
        this.ragConfig = ragConfig;
        this.restTemplate = new org.springframework.web.client.RestTemplate();
    }

    /**
     * Split text into sentences using SpaCy
     *
     * @param text Input text
     * @param lang Language (zh/en), default zh
     * @return List of sentences
     */
    public List<String> splitSentences(String text, String lang) {
        try {
            String url = ragConfig.getEmbeddingServiceUrl() + "/nlp/sentences";

            Map<String, Object> requestBody = Map.of(
                    "text", text,
                    "lang", lang != null ? lang : "zh"
            );

            org.springframework.http.HttpEntity<Map<String, Object>> entity =
                    new org.springframework.http.HttpEntity<>(requestBody);

            org.springframework.http.ResponseEntity<Map> response =
                    restTemplate.postForEntity(url, entity, Map.class);

            if (response.getStatusCode().value() == 200 && response.getBody() != null) {
                Map<String, Object> body = response.getBody();
                if (body.containsKey("data")) {
                    @SuppressWarnings("unchecked")
                    Map<String, Object> data = (Map<String, Object>) body.get("data");
                    @SuppressWarnings("unchecked")
                    List<String> sentences = (List<String>) data.get("sentences");
                    return sentences;
                }
            }

            throw new RuntimeException("Failed to get sentences from NLP service");
        } catch (Exception e) {
            log.warn("NLP service error, falling back to regex split: {}", e.getMessage());
            return fallbackSplit(text);
        }
    }

    /**
     * Extract named entities
     *
     * @param text Input text
     * @param lang Language
     * @return List of [entity, label] pairs
     */
    public List<String[]> extractEntities(String text, String lang) {
        try {
            String url = ragConfig.getEmbeddingServiceUrl() + "/nlp/entities";

            Map<String, Object> requestBody = Map.of(
                    "text", text,
                    "lang", lang != null ? lang : "zh"
            );

            org.springframework.http.HttpEntity<Map<String, Object>> entity =
                    new org.springframework.http.HttpEntity<>(requestBody);

            org.springframework.http.ResponseEntity<Map> response =
                    restTemplate.postForEntity(url, entity, Map.class);

            if (response.getStatusCode().value() == 200 && response.getBody() != null) {
                Map<String, Object> body = response.getBody();
                if (body.containsKey("data")) {
                    @SuppressWarnings("unchecked")
                    Map<String, Object> data = (Map<String, Object>) body.get("data");
                    @SuppressWarnings("unchecked")
                    List<List<String>> entities = (List<List<String>>) data.get("entities");
                    return entities.stream()
                            .map(arr -> arr.toArray(new String[0]))
                            .toList();
                }
            }

            return new ArrayList<>();
        } catch (Exception e) {
            log.warn("Entity extraction failed: {}", e.getMessage());
            return new ArrayList<>();
        }
    }

    /**
     * Preprocess text (remove stopwords, lemmatize)
     *
     * @param text Input text
     * @param lang Language
     * @return Processed text
     */
    public String preprocess(String text, String lang) {
        try {
            String url = ragConfig.getEmbeddingServiceUrl() + "/nlp/preprocess";

            Map<String, Object> requestBody = Map.of(
                    "text", text,
                    "lang", lang != null ? lang : "zh"
            );

            org.springframework.http.HttpEntity<Map<String, Object>> entity =
                    new org.springframework.http.HttpEntity<>(requestBody);

            org.springframework.http.ResponseEntity<Map> response =
                    restTemplate.postForEntity(url, entity, Map.class);

            if (response.getStatusCode().value() == 200 && response.getBody() != null) {
                Map<String, Object> body = response.getBody();
                if (body.containsKey("data")) {
                    @SuppressWarnings("unchecked")
                    Map<String, Object> data = (Map<String, Object>) body.get("data");
                    return (String) data.get("processed");
                }
            }

            return text;
        } catch (Exception e) {
            log.warn("Preprocessing failed, returning original: {}", e.getMessage());
            return text;
        }
    }

    private List<String> fallbackSplit(String text) {
        // Simple fallback regex split
        List<String> sentences = new ArrayList<>();
        String[] parts = text.split("[。！？.!?]+");
        for (String part : parts) {
            String trimmed = part.trim();
            if (!trimmed.isEmpty()) {
                sentences.add(trimmed);
            }
        }
        return sentences;
    }
}