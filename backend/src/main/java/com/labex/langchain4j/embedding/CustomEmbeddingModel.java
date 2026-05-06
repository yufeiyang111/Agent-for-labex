package com.labex.langchain4j.embedding;

import com.labex.rag.vector.EmbeddingService;
import dev.langchain4j.data.embedding.Embedding;
import dev.langchain4j.data.segment.TextSegment;
import dev.langchain4j.model.embedding.EmbeddingModel;
import dev.langchain4j.model.output.Response;

import java.util.ArrayList;
import java.util.List;

/**
 * LangChain4j EmbeddingModel adapter wrapping the Python bge-m3 embedding service.
 */
public class CustomEmbeddingModel implements EmbeddingModel {

    private final EmbeddingService embeddingService;

    public CustomEmbeddingModel(EmbeddingService embeddingService) {
        this.embeddingService = embeddingService;
    }

    @Override
    public Response<List<Embedding>> embedAll(List<TextSegment> segments) {
        List<String> texts = new ArrayList<>();
        for (TextSegment seg : segments) {
            texts.add(seg.text());
        }
        List<List<Double>> vecs = embeddingService.embed(texts);

        List<Embedding> embeddings = new ArrayList<>();
        for (List<Double> vec : vecs) {
            float[] floats = new float[vec.size()];
            for (int i = 0; i < vec.size(); i++) {
                floats[i] = vec.get(i).floatValue();
            }
            embeddings.add(Embedding.from(floats));
        }
        return Response.from(embeddings);
    }

    @Override
    public int dimension() {
        return embeddingService.getDimension();
    }
}
