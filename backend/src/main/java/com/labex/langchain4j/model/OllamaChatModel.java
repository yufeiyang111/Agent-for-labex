package com.labex.langchain4j.model;

import com.labex.rag.llm.OllamaChat;
import dev.langchain4j.agent.tool.ToolSpecification;
import dev.langchain4j.data.message.AiMessage;
import dev.langchain4j.data.message.ChatMessage;
import dev.langchain4j.data.message.ChatMessageType;
import dev.langchain4j.model.chat.ChatLanguageModel;
import dev.langchain4j.model.output.Response;
import java.util.List;

public class OllamaChatModel implements ChatLanguageModel {
    private final OllamaChat ollamaChat;

    public OllamaChatModel(OllamaChat ollamaChat) {
        this.ollamaChat = ollamaChat;
    }

    public Response<AiMessage> generate(List<ChatMessage> messages) {
        StringBuilder context = new StringBuilder();
        String userQuestion = "";
        for (ChatMessage msg : messages) {
            String text = msg.text();
            ChatMessageType type = msg.type();
            if (type == ChatMessageType.SYSTEM) {
                context.append(text).append("\n");
            } else if (type == ChatMessageType.USER) {
                userQuestion = text;
            } else if (type == ChatMessageType.AI) {
                context.append("Previous response: ").append(text).append("\n");
            }
        }
        String appPrompt = context.toString();
        String answer = this.ollamaChat.chat(appPrompt, "", userQuestion);
        return Response.from(AiMessage.from((String)answer));
    }

    public Response<AiMessage> generate(List<ChatMessage> messages, List<ToolSpecification> toolSpecifications) {
        return this.generate(messages);
    }
}