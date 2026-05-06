package com.labex.langchain4j.model;

import com.labex.rag.llm.MiniMaxChat;
import dev.langchain4j.data.message.AiMessage;
import dev.langchain4j.data.message.ChatMessage;
import dev.langchain4j.model.chat.ChatLanguageModel;
import dev.langchain4j.model.output.Response;

import java.util.List;

/**
 * LangChain4j ChatLanguageModel adapter wrapping existing MiniMaxChat.
 * Delegates to the existing {@link MiniMaxChat} service (Anthropic-style API on MiniMax v2).
 */
public class MiniMaxChatModel implements ChatLanguageModel {

    private final MiniMaxChat miniMaxChat;

    public MiniMaxChatModel(MiniMaxChat miniMaxChat) {
        this.miniMaxChat = miniMaxChat;
    }

    @Override
    public Response<AiMessage> generate(List<ChatMessage> messages) {
        // Extract system + user messages from LangChain4j message format
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

        String appPrompt = context.toString();
        // Delegate to underlying MiniMaxChat (prompt, context, question)
        // We send the system context as the prompt and scene-context as empty
        String answer = miniMaxChat.chat(appPrompt, "", userQuestion);
        return Response.from(AiMessage.from(answer));
    }
}
