package com.labex.rag.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/**
 * RAG Module Configuration
 */
@Data
@Configuration
@ConfigurationProperties(prefix = "rag")
public class RagConfig {

    private String embeddingServiceUrl = "http://localhost:5000";

    private String miniMaxApiKey;

    private String miniMaxBaseUrl = "https://api.minimax.chat";

    private String miniMaxModel = "abab6.5s-chat";

    private int maxContextChunks = 10;

    private int chunkSize = 500;

    private int chunkOverlap = 50;

    private String uploadPath = "D:/workfordasan/uploads";
}
