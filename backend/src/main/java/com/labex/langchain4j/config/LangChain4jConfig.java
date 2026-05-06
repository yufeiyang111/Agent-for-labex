package com.labex.langchain4j.config;

import com.labex.langchain4j.embedding.CustomEmbeddingModel;
import com.labex.langchain4j.model.MiniMaxChatModel;
import com.labex.langchain4j.model.MiniMaxStreamingChatModel;
import com.labex.rag.llm.MiniMaxChat;
import com.labex.rag.vector.EmbeddingService;
import dev.langchain4j.model.chat.ChatLanguageModel;
import dev.langchain4j.model.chat.StreamingChatLanguageModel;
import dev.langchain4j.model.embedding.EmbeddingModel;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class LangChain4jConfig {

    @Bean
    public ChatLanguageModel chatLanguageModel(MiniMaxChat miniMaxChat) {
        return new MiniMaxChatModel(miniMaxChat);
    }

    @Bean
    public StreamingChatLanguageModel streamingChatLanguageModel(MiniMaxChat miniMaxChat) {
        return new MiniMaxStreamingChatModel(miniMaxChat);
    }

    @Bean
    public EmbeddingModel embeddingModel(EmbeddingService embeddingService) {
        return new CustomEmbeddingModel(embeddingService);
    }
}
