package com.labex.labexagent.llm;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URI;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Consumer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component
public class OpenAiCompatibleProvider implements LlmProvider {
    private static final Logger log = LoggerFactory.getLogger(OpenAiCompatibleProvider.class);
    private static final Gson GSON = new Gson();

    @Override
    public String getProviderId() { return "openai_compatible"; }

    @Override
    public String getProviderName() { return "OpenAI Compatible"; }

    @Override
    public boolean supportsStreaming() { return true; }

    @Override
    public boolean supportsToolCalling() { return true; }

    @Override
    public Map<String, Object> chatWithTools(String sysPrompt, List<Map<String, Object>> msgs,
                                              List<Map<String, Object>> tools, LlmConfig config) {
        try {
            String body = buildRequestBody(sysPrompt, msgs, tools, config, false);
            String url = normalizeUrl(config.baseUrl()) + "/v1/chat/completions";
            String response = httpPost(url, body, config.apiKey());
            return parseResponse(response);
        } catch (Exception e) {
            log.error("LLM chat error: {}", e.getMessage());
            return Map.of("type", "error", "message", "LLM error: " + e.getMessage(), "content", "");
        }
    }

    @Override
    public void chatStream(String sysPrompt, List<Map<String, Object>> msgs,
                            List<Map<String, Object>> tools, LlmConfig config,
                            Consumer<StreamChunk> onChunk) {
        HttpURLConnection conn = null;
        try {
            String body = buildRequestBody(sysPrompt, msgs, tools, config, true);
            String url = normalizeUrl(config.baseUrl()) + "/v1/chat/completions";

            java.net.URL uri = URI.create(url).toURL();
            conn = (HttpURLConnection) uri.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("Authorization", "Bearer " + config.apiKey());
            conn.setRequestProperty("Accept", "text/event-stream");
            conn.setDoOutput(true);
            conn.setConnectTimeout(15000);
            conn.setReadTimeout(300000);

            try (OutputStream os = conn.getOutputStream()) {
                os.write(body.getBytes(StandardCharsets.UTF_8));
            }

            int code = conn.getResponseCode();
            if (code != 200) {
                String errBody = readAll(conn.getErrorStream());
                onChunk.accept(new StreamChunk("error", "API error " + code + ": " + errBody, null, null, null, true));
                return;
            }

            StringBuilder contentBuf = new StringBuilder();
            StringBuilder thinkingBuf = new StringBuilder();
            String currentToolName = null;
            StringBuilder currentToolArgs = null;

            try (BufferedReader reader = new BufferedReader(
                    new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    if (line.isEmpty()) continue;
                    if (!line.startsWith("data: ")) continue;
                    String data = line.substring(6).trim();
                    if ("[DONE]".equals(data)) {
                        onChunk.accept(new StreamChunk("done", contentBuf.toString(), currentToolName,
                                currentToolArgs != null ? currentToolArgs.toString() : null,
                                thinkingBuf.toString(), true));
                        break;
                    }
                    try {
                        JsonObject chunk = JsonParser.parseString(data).getAsJsonObject();
                        var choices = chunk.getAsJsonArray("choices");
                        if (choices == null || choices.isEmpty()) continue;
                        var delta = choices.get(0).getAsJsonObject().getAsJsonObject("delta");
                        if (delta == null) continue;

                        if (delta.has("tool_calls")) {
                            var toolCalls = delta.getAsJsonArray("tool_calls");
                            for (var tc : toolCalls) {
                                var fn = tc.getAsJsonObject().getAsJsonObject("function");
                                if (fn != null) {
                                    if (fn.has("name") && !fn.get("name").isJsonNull()) {
                                        currentToolName = fn.get("name").getAsString();
                                        currentToolArgs = new StringBuilder();
                                    }
                                    if (fn.has("arguments") && !fn.get("arguments").isJsonNull()) {
                                        if (currentToolArgs == null) currentToolArgs = new StringBuilder();
                                        currentToolArgs.append(fn.get("arguments").getAsString());
                                        onChunk.accept(new StreamChunk("tool_args_delta", fn.get("arguments").getAsString(),
                                                currentToolName, currentToolArgs.toString(), null, false));
                                    }
                                }
                            }
                        }

                        if (delta.has("content") && !delta.get("content").isJsonNull()) {
                            String content = delta.get("content").getAsString();
                            contentBuf.append(content);
                            onChunk.accept(new StreamChunk("text_delta", content, null, null, null, false));
                        }

                        if (delta.has("reasoning_content") && !delta.get("reasoning_content").isJsonNull()) {
                            String thinking = delta.get("reasoning_content").getAsString();
                            thinkingBuf.append(thinking);
                            onChunk.accept(new StreamChunk("thinking_delta", thinking, null, null, thinkingBuf.toString(), false));
                        }
                    } catch (Exception parseEx) {
                        log.debug("SSE parse skip: {}", parseEx.getMessage());
                    }
                }
            }

            if (currentToolName != null && currentToolArgs != null) {
                onChunk.accept(new StreamChunk("tool_call", "", currentToolName, currentToolArgs.toString(),
                        thinkingBuf.toString(), true));
            }

        } catch (Exception e) {
            log.error("LLM stream error: {}", e.getMessage());
            try {
                onChunk.accept(new StreamChunk("error", "LLM stream error: " + e.getMessage(), null, null, null, true));
            } catch (Exception ignored) {}
        } finally {
            if (conn != null) conn.disconnect();
        }
    }

    private String buildRequestBody(String sysPrompt, List<Map<String, Object>> msgs,
                                     List<Map<String, Object>> tools, LlmConfig config, boolean stream) {
        Map<String, Object> body = new HashMap<>();
        body.put("model", config.modelName());

        List<Map<String, Object>> messages = new ArrayList<>();
        messages.add(Map.of("role", "system", "content", sysPrompt));
        messages.addAll(msgs);
        body.put("messages", messages);

        body.put("max_tokens", config.maxTokens() != null ? config.maxTokens() : 8192);
        if (config.temperature() != null) body.put("temperature", config.temperature());
        if (stream) body.put("stream", true);

        if (tools != null && !tools.isEmpty()) {
            body.put("tools", tools);
            body.put("tool_choice", "auto");
        }

        return GSON.toJson(body);
    }

    private Map<String, Object> parseResponse(String response) {
        try {
            JsonObject rb = JsonParser.parseString(response).getAsJsonObject();

            Map<String, Object> usage = extractUsage(rb);

            var choices = rb.getAsJsonArray("choices");
            if (choices != null && !choices.isEmpty()) {
                var msg = choices.get(0).getAsJsonObject().getAsJsonObject("message");
                if (msg != null) {
                    String content = msg.has("content") && !msg.get("content").isJsonNull()
                            ? msg.get("content").getAsString() : "";

                    String thinking = "";
                    if (msg.has("reasoning_content") && !msg.get("reasoning_content").isJsonNull()) {
                        thinking = msg.get("reasoning_content").getAsString();
                    }

                    if (msg.has("tool_calls") && !msg.get("tool_calls").isJsonNull()) {
                        var tcs = msg.getAsJsonArray("tool_calls");
                        if (tcs != null && !tcs.isEmpty()) {
                            var fn = tcs.get(0).getAsJsonObject().getAsJsonObject("function");
                            if (fn != null) {
                                Map<String, Object> result = new HashMap<>();
                                result.put("type", "tool_call");
                                result.put("tool", fn.get("name").getAsString());
                                result.put("arguments", fn.get("arguments").getAsString());
                                result.put("thinking", thinking.isEmpty() ? content : thinking);
                                if (usage != null) result.put("usage", usage);
                                return result;
                            }
                        }
                    }

                    if (!content.isEmpty()) {
                        Map<String, Object> result = new HashMap<>();
                        result.put("type", "text");
                        result.put("content", content);
                        result.put("thinking", thinking);
                        if (usage != null) result.put("usage", usage);
                        return result;
                    }
                    if (!thinking.isEmpty()) {
                        Map<String, Object> result = new HashMap<>();
                        result.put("type", "text");
                        result.put("content", thinking);
                        if (usage != null) result.put("usage", usage);
                        return result;
                    }
                }
            }
            Map<String, Object> result = new HashMap<>();
            result.put("type", "error");
            result.put("message", "Empty response from API");
            result.put("content", "");
            if (usage != null) result.put("usage", usage);
            return result;
        } catch (Exception e) {
            return Map.of("type", "error", "message", "Parse error: " + e.getMessage(), "content", "");
        }
    }

    private Map<String, Object> extractUsage(JsonObject rb) {
        try {
            if (!rb.has("usage") || rb.get("usage").isJsonNull()) return null;
            JsonObject usage = rb.getAsJsonObject("usage");
            Map<String, Object> result = new HashMap<>();
            result.put("prompt_tokens", usage.has("prompt_tokens") ? usage.get("prompt_tokens").getAsInt() : 0);
            result.put("completion_tokens", usage.has("completion_tokens") ? usage.get("completion_tokens").getAsInt() : 0);
            result.put("total_tokens", usage.has("total_tokens") ? usage.get("total_tokens").getAsInt() : 0);
            return result;
        } catch (Exception e) {
            return null;
        }
    }

    private String httpPost(String url, String body, String apiKey) throws Exception {
        java.net.URL uri = URI.create(url).toURL();
        HttpURLConnection conn = (HttpURLConnection) uri.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setRequestProperty("Authorization", "Bearer " + apiKey);
        conn.setDoOutput(true);
        conn.setConnectTimeout(15000);
        conn.setReadTimeout(300000);

        try (OutputStream os = conn.getOutputStream()) {
            os.write(body.getBytes(StandardCharsets.UTF_8));
        }

        int code = conn.getResponseCode();
        if (code != 200) {
            String err = readAll(conn.getErrorStream());
            conn.disconnect();
            throw new RuntimeException("API error " + code + ": " + err);
        }

        String resp = readAll(conn.getInputStream());
        conn.disconnect();
        return resp;
    }

    private String readAll(java.io.InputStream is) {
        if (is == null) return "";
        try (BufferedReader r = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = r.readLine()) != null) sb.append(line).append('\n');
            return sb.toString();
        } catch (Exception e) { return ""; }
    }

    private String normalizeUrl(String url) {
        if (url == null) return "https://api.openai.com";
        url = url.replaceAll("/+$", "");
        if (url.endsWith("/v1")) url = url.substring(0, url.length() - 3);
        return url;
    }
}
