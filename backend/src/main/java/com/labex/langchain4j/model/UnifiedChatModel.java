package com.labex.langchain4j.model;

import com.labex.rag.llm.LLMChat;
import dev.langchain4j.data.message.AiMessage;
import dev.langchain4j.data.message.ChatMessage;
import dev.langchain4j.data.message.ChatMessageType;
import dev.langchain4j.model.chat.ChatLanguageModel;
import dev.langchain4j.model.output.Response;
import java.util.List;

public class UnifiedChatModel implements ChatLanguageModel {
    private final LLMChat llmChat;

    public UnifiedChatModel(LLMChat llmChat) { this.llmChat = llmChat; }

    public Response<AiMessage> generate(List<ChatMessage> messages) {
        StringBuilder context = new StringBuilder();
        String userQuestion = "";
        for (ChatMessage msg : messages) {
            String text = msg.text();
            ChatMessageType type = msg.type();
            if (type == ChatMessageType.SYSTEM) context.append(text).append("\n");
            else if (type == ChatMessageType.USER) userQuestion = text;
            else if (type == ChatMessageType.AI) context.append("Previous response: ").append(text).append("\n");
        }
        String answer = this.llmChat.chat("", context.toString(), userQuestion);
        return Response.from(AiMessage.from((String)answer));
    }
}