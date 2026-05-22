package com.labex.rag.llm;

import com.labex.rag.config.RagConfig;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.*;

/**
 * MiniMax LLM Service
 */
@Slf4j
@Service
public class MiniMaxChat implements LLMChat {

    private final RagConfig ragConfig;
    private final RestTemplate restTemplate;

    public MiniMaxChat(RagConfig ragConfig) {
        this.ragConfig = ragConfig;
        SimpleClientHttpRequestFactory factory = new SimpleClientHttpRequestFactory();
        factory.setConnectTimeout(10000);
        factory.setReadTimeout(300000);
        this.restTemplate = new RestTemplate(factory);
    }

    /**
     * Send chat request to MiniMax API
     *
     * @param prompt     System prompt
     * @param context    Retrieved context
     * @param question  User question
     * @return Generated answer
     */
    public String chat(String prompt, String context, String question) {
        try {
            String apiKey = ragConfig.getMiniMaxApiKey();
            if (apiKey == null || apiKey.isBlank()) {
                return "LLM API key not configured. Please set rag.mini-max-api-key in application.yml";
            }

            String baseUrl = ragConfig.getMiniMaxBaseUrl().replaceAll("/$", "");
            String url = baseUrl + "/text/chatcompletion_v2";

            log.info("MiniMax API URL: {}", url);

            // Build messages in Anthropic format
            String fullSystemPrompt = prompt + "\n\nContext:\n" + context;

            List<Map<String, Object>> messages = new ArrayList<>();
            messages.add(Map.of("role", "user", "content", fullSystemPrompt + "\n\n用户问题: " + question));

            // Request body using Anthropic-style format
            Map<String, Object> requestBody = new HashMap<>();
            requestBody.put("model", ragConfig.getMiniMaxModel());
            requestBody.put("messages", messages);
            requestBody.put("max_tokens", 8192);
            requestBody.put("user_id", "labex-system");

            log.info("MiniMax Request body: {}", requestBody);

            // Send request with Authorization header
            org.springframework.http.HttpHeaders headers = new org.springframework.http.HttpHeaders();
            headers.setContentType(org.springframework.http.MediaType.APPLICATION_JSON);
            headers.set("Authorization", "Bearer " + apiKey);

            org.springframework.http.HttpEntity<Map<String, Object>> entity =
                    new org.springframework.http.HttpEntity<>(requestBody, headers);

            log.info("Sending request to MiniMax API...");
            org.springframework.http.ResponseEntity<Map> response =
                    restTemplate.postForEntity(url, entity, Map.class);

            log.info("MiniMax Response status: {}", response.getStatusCode());
            log.info("MiniMax Response body: {}", response.getBody());

            if (response.getStatusCode().value() == 200 && response.getBody() != null) {
                @SuppressWarnings("unchecked")
                Map<String, Object> body = response.getBody();

                log.info("MiniMax Response body keys: {}", body.keySet());

                // Check for content in response
                if (body.containsKey("choices")) {
                    @SuppressWarnings("unchecked")
                    List<Map<String, Object>> choices = (List<Map<String, Object>>) body.get("choices");
                    if (choices != null && !choices.isEmpty()) {
                        @SuppressWarnings("unchecked")
                        Map<String, Object> choice = choices.get(0);
                        @SuppressWarnings("unchecked")
                        Map<String, Object> message = (Map<String, Object>) choice.get("message");
                        if (message != null && message.get("content") != null) {
                            return message.get("content").toString();
                        }
                    }
                }

                // Check base_resp for errors
                if (body.containsKey("base_resp")) {
                    @SuppressWarnings("unchecked")
                    Map<String, Object> baseResp = (Map<String, Object>) body.get("base_resp");
                    if (baseResp != null) {
                        log.error("MiniMax API error: {}", baseResp);
                        return "LLM error: " + baseResp.get("status_msg");
                    }
                }

                // Fallback
                return body.getOrDefault("answer", "Failed to generate response").toString();
            }

            return "LLM request failed with status: " + response.getStatusCode();
        } catch (Exception e) {
            log.error("MiniMax chat error: {}", e.getMessage());
            log.error("MiniMax chat error type: {}", e.getClass().getName());
            if (e.getCause() != null) {
                log.error("Cause: {}", e.getCause().getMessage());
            }
            return "LLM error: " + e.getMessage();
        }
    }

    /**
     * Generate streaming response (simplified - non-streaming for now)
     */
    public String chatStream(String prompt, String context, String question) {
        // For simplicity, return non-streaming response
        // Streaming can be implemented with WebFlux or SSE
        return chat(prompt, context, question);
    }

    public Map<String, Object> chatWithTools(String sysPrompt, ArrayList<Map<String, Object>> msgs, List<Map<String, Object>> tools) {
        try {
            String apiKey = ragConfig.getMiniMaxApiKey();
            if (apiKey == null || apiKey.isBlank()) return Map.of("type", "final", "content", "API key not configured");
            String url = ragConfig.getMiniMaxBaseUrl().replaceAll("/$", "") + "/text/chatcompletion_v2";
            ArrayList<Map<String, Object>> messages = new ArrayList<>();
            messages.add(Map.of("role", "system", "content", sysPrompt));
            messages.addAll(msgs);
            Map<String, Object> body = new HashMap<>();
            body.put("model", ragConfig.getMiniMaxModel());
            body.put("messages", messages);
            body.put("max_tokens", 8192);
            if (tools != null && !tools.isEmpty()) { body.put("tools", tools); body.put("tool_choice", "auto"); }
            org.springframework.http.HttpHeaders h = new org.springframework.http.HttpHeaders();
            h.setContentType(org.springframework.http.MediaType.APPLICATION_JSON);
            h.set("Authorization", "Bearer " + apiKey);
            org.springframework.http.HttpEntity<Map<String, Object>> entity = new org.springframework.http.HttpEntity<>(body, h);
            org.springframework.http.ResponseEntity<Map> r = restTemplate.postForEntity(url, entity, Map.class);
            if (r.getStatusCode().value() == 200 && r.getBody() != null) {
                Map<String, Object> rb = r.getBody();
                if (rb.containsKey("choices")) {
                    List<Map<String, Object>> choices = (List<Map<String, Object>>) rb.get("choices");
                    if (choices != null && !choices.isEmpty()) {
                        Map<String, Object> msg = (Map<String, Object>) choices.get(0).get("message");
                        if (msg != null) {
                            String content = msg.get("content") != null ? msg.get("content").toString() : "";
                            if (msg.containsKey("tool_calls")) {
                                List<Map<String, Object>> tcs = (List<Map<String, Object>>) msg.get("tool_calls");
                                if (tcs != null && !tcs.isEmpty()) {
                                    Map<String, Object> fn = (Map<String, Object>) tcs.get(0).get("function");
                                    return Map.of("type", "tool_call", "tool", fn.get("name").toString(), "arguments", fn.get("arguments").toString(), "thinking", content);
                                }
                            }
                            return Map.of("type", "final", "content", content.isEmpty() ? "No response" : content);
                        }
                    }
                }
            }
            return Map.of("type", "final", "content", "API call failed");
        } catch (Exception e) { log.error("MiniMax tools: {}", e.getMessage()); return Map.of("type", "final", "content", "LLM error: " + e.getMessage()); }
    }
}
