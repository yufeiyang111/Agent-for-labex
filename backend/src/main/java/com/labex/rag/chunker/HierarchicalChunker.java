package com.labex.rag.chunker;

import com.labex.rag.vector.NlpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * Hierarchical Semantic Chunker
 * Splits text into chunks of 500-800 tokens with 10% overlap
 * Uses SpaCy for intelligent sentence segmentation
 */
@Component
public class HierarchicalChunker {

    private static final int DEFAULT_CHUNK_SIZE = 500;
    private static final int DEFAULT_OVERLAP = 50;
    private static final int MAX_CHUNK_SIZE = 800;

    private final NlpService nlpService;

    @Autowired
    public HierarchicalChunker(NlpService nlpService) {
        this.nlpService = nlpService;
    }

    /**
     * Split text into semantic chunks
     *
     * @param text The full text to chunk
     * @return List of text chunks
     */
    public List<String> chunk(String text) {
        return chunk(text, DEFAULT_CHUNK_SIZE, DEFAULT_OVERLAP);
    }

    /**
     * Split text into semantic chunks with custom parameters
     *
     * @param text     The full text to chunk
     * @param chunkSize Target chunk size in tokens
     * @param overlap  Overlap between chunks
     * @return List of text chunks
     */
    public List<String> chunk(String text, int chunkSize, int overlap) {
        List<String> chunks = new ArrayList<>();

        if (text == null || text.isBlank()) {
            return chunks;
        }

        // Estimate tokens
        int estimatedTokens = estimateTokens(text);

        if (estimatedTokens <= chunkSize) {
            chunks.add(text);
            return chunks;
        }

        // Split by paragraphs first
        String[] paragraphs = text.split("\n+");

        StringBuilder currentChunk = new StringBuilder();
        int currentTokens = 0;

        for (String paragraph : paragraphs) {
            if (paragraph.isBlank()) continue;

            int paraTokens = estimateTokens(paragraph);

            // If single paragraph exceeds max, use SpaCy sentence split
            if (paraTokens > MAX_CHUNK_SIZE) {
                if (currentTokens > 0) {
                    chunks.add(currentChunk.toString().trim());
                    currentChunk = new StringBuilder();
                    currentTokens = 0;
                }
                // Use SpaCy for intelligent sentence splitting
                List<String> sentences = nlpService.splitSentences(paragraph, "zh");
                chunks.addAll(splitSentencesIntoChunks(sentences, chunkSize, overlap));
                continue;
            }

            // Check if adding this paragraph would exceed limit
            if (currentTokens + paraTokens > chunkSize) {
                if (currentTokens > 0) {
                    String chunkText = currentChunk.toString().trim();
                    if (!chunkText.isEmpty()) {
                        chunks.add(chunkText);
                    }

                    // Handle overlap
                    if (overlap > 0 && currentChunk.length() > overlap * 2) {
                        String overlapText = currentChunk.substring(
                                currentChunk.length() - overlap * 2);
                        currentChunk = new StringBuilder(overlapText);
                        currentTokens = estimateTokens(overlapText);
                    } else {
                        currentChunk = new StringBuilder();
                        currentTokens = 0;
                    }
                }
            }

            currentChunk.append(paragraph).append("\n");
            currentTokens += paraTokens;
        }

        // Add remaining content
        String remaining = currentChunk.toString().trim();
        if (!remaining.isEmpty() && (chunks.isEmpty() || !chunks.get(chunks.size() - 1).equals(remaining))) {
            chunks.add(remaining);
        }

        return chunks;
    }

    /**
     * Split sentences into chunks using SpaCy-splitted sentences
     */
    private List<String> splitSentencesIntoChunks(List<String> sentences, int chunkSize, int overlap) {
        List<String> chunks = new ArrayList<>();

        StringBuilder currentChunk = new StringBuilder();
        int currentTokens = 0;

        for (String sentence : sentences) {
            if (sentence.isBlank()) continue;

            int sentTokens = estimateTokens(sentence);

            if (currentTokens + sentTokens > chunkSize) {
                if (currentTokens > 0) {
                    String chunkText = currentChunk.toString().trim();
                    if (!chunkText.isEmpty()) {
                        chunks.add(chunkText);
                    }

                    // Keep overlap
                    if (overlap > 0 && currentChunk.length() > overlap * 2) {
                        String overlapText = currentChunk.substring(
                                currentChunk.length() - overlap * 2);
                        currentChunk = new StringBuilder(overlapText);
                        currentTokens = estimateTokens(overlapText);
                    } else {
                        currentChunk = new StringBuilder();
                        currentTokens = 0;
                    }
                }
            }

            currentChunk.append(sentence).append("。");
            currentTokens += sentTokens;
        }

        String remaining = currentChunk.toString().trim();
        if (!remaining.isEmpty()) {
            chunks.add(remaining);
        }

        return chunks;
    }

    private int estimateTokens(String text) {
        if (text == null) return 0;
        int chineseChars = 0;
        int englishChars = 0;

        for (char c : text.toCharArray()) {
            if (Character.UnicodeBlock.of(c) == Character.UnicodeBlock.CJK_UNIFIED_IDEOGRAPHS) {
                chineseChars++;
            } else if (Character.isLetter(c)) {
                englishChars++;
            }
        }

        return chineseChars + (int) Math.ceil(englishChars / 1.5);
    }
}