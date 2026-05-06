package com.labex.rag.vector;

import com.labex.rag.config.RagConfig;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Service for calling Python embedding service
 */
@Slf4j
@Service
public class EmbeddingService {

    private final RagConfig ragConfig;
    private final org.springframework.web.client.RestTemplate restTemplate;

    public EmbeddingService(RagConfig ragConfig) {
        this.ragConfig = ragConfig;
        SimpleClientHttpRequestFactory factory = new SimpleClientHttpRequestFactory();
        factory.setConnectTimeout(10000);
        factory.setReadTimeout(30000);
        this.restTemplate = new org.springframework.web.client.RestTemplate(factory);
    }

    /**
     * Generate embeddings for texts
     *
     * @param texts List of text strings
     * @return List of embedding vectors
     */
    public List<List<Double>> embed(List<String> texts) {
        try {
            String url = ragConfig.getEmbeddingServiceUrl() + "/embed";

            // Prepare request body
            Map<String, Object> requestBody = Map.of(
                    "texts", texts,
                    "normalize", true
            );

            // Make HTTP POST request
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
                    List<List<Double>> embeddings = (List<List<Double>>) data.get("embeddings");
                    return embeddings;
                }
            }

            throw new RuntimeException("Failed to get embeddings from service");
        } catch (Exception e) {
            log.error("Embedding service error: {}", e.getMessage());
            throw new RuntimeException("Embedding service error: " + e.getMessage(), e);
        }
    }

    /**
     * Get embedding dimension
     *
     * @return Embedding vector dimension
     */
    public int getDimension() {
        try {
            String url = ragConfig.getEmbeddingServiceUrl() + "/embed/dimension";

            org.springframework.http.ResponseEntity<Map> response =
                    restTemplate.getForEntity(url, Map.class);

            if (response.getStatusCode().value() == 200 && response.getBody() != null) {
                @SuppressWarnings("unchecked")
                Map<String, Object> body = response.getBody();
                if (body.containsKey("data")) {
                    @SuppressWarnings("unchecked")
                    Map<String, Object> data = (Map<String, Object>) body.get("data");
                    return (int) data.get("dimension");
                }
            }

            // Default dimension for BGE-M3
            return 1024;
        } catch (Exception e) {
            log.warn("Could not get embedding dimension: {}, using default 1024", e.getMessage());
            return 1024;
        }
    }
}
