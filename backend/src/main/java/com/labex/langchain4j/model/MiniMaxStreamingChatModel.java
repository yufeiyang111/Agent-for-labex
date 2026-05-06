package com.labex.langchain4j.model;

import com.labex.rag.llm.MiniMaxChat;
import dev.langchain4j.data.message.AiMessage;
import dev.langchain4j.data.message.ChatMessage;
import dev.langchain4j.model.StreamingResponseHandler;
import dev.langchain4j.model.chat.StreamingChatLanguageModel;
import dev.langchain4j.model.output.Response;

import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * Streaming variant — currently non-streaming under the hood,
 * but conforms to the StreamingChatLanguageModel contract for future SSE support.
 */
public class MiniMaxStreamingChatModel implements StreamingChatLanguageModel {

    private final MiniMaxChat miniMaxChat;
    private final ExecutorService executor = Executors.newCachedThreadPool();

    public MiniMaxStreamingChatModel(MiniMaxChat miniMaxChat) {
        this.miniMaxChat = miniMaxChat;
    }

    @Override
    public void generate(List<ChatMessage> messages, StreamingResponseHandler<AiMessage> handler) {
        executor.submit(() -> {
            try {
                StringBuilder context = new StringBuilder();
                String userQuestion = "";

                for (ChatMessage msg : messages) {
                    String text = msg.text();
                    switch (msg.type()) {
                        case SYSTEM:
                            context.append(text).append("\n");
                            break;
                        case USER:
                            userQuestion = text;
                            break;
                        case AI:
                            context.append("Previous response: ").append(text).append("\n");
                            break;
                    default:
                        break;
                    }
                }

                String answer = miniMaxChat.chat(context.toString(), "", userQuestion);
                AiMessage aiMessage = AiMessage.from(answer);
                handler.onNext(answer);
                handler.onComplete(Response.from(aiMessage));
            } catch (Exception e) {
                handler.onError(e);
            }
        });
    }
}
