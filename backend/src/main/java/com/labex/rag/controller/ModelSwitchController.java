package com.labex.rag.controller;

import com.labex.common.Result;
import com.labex.rag.config.RagConfig;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
@RequestMapping(value={"/llm"})
public class ModelSwitchController {
    private static final Logger log = LoggerFactory.getLogger(ModelSwitchController.class);
    @Autowired
    private RagConfig ragConfig;
    private final RestTemplate restTemplate = new RestTemplate();

    @GetMapping(value={"/config"})
    public Result<Object> getConfig() {
        String provider = this.ragConfig.getLlmProvider();
        String model = "ollama".equalsIgnoreCase(provider) ? this.ragConfig.getOllamaModel() : this.ragConfig.getMiniMaxModel();
        Object baseUrl = "ollama".equalsIgnoreCase(provider) ? this.ragConfig.getOllamaBaseUrl() + "/v1" : this.ragConfig.getMiniMaxBaseUrl();
        return Result.success(Map.of("provider", provider, "model", model, "baseUrl", baseUrl));
    }

    @PostMapping(value={"/switch"})
    public Result<String> switchModel(@RequestBody Map<String, String> request) {
        String provider = request.get("provider");
        String model = request.get("model");
        if (provider == null || provider.isBlank()) {
            return Result.error("Provider is required");
        }
        if (model == null || model.isBlank()) {
            return Result.error("Model is required");
        }
        log.info("Switching LLM - provider: {}, model: {}", provider, model);
        this.ragConfig.setLlmProvider(provider);
        if ("ollama".equalsIgnoreCase(provider)) {
            this.ragConfig.setOllamaModel(model);
        } else if ("minimax".equalsIgnoreCase(provider)) {
            this.ragConfig.setMiniMaxModel(model);
            this.ragConfig.setMiniMaxBaseUrl("https://api.minimaxi.com/v1");
        }
        return Result.success("Model switched successfully");
    }

    /*
     * Enabled force condition propagation
     * Lifted jumps to return sites
     */
    @GetMapping(value={"/models"})
    public Result<List<Map<String, Object>>> listModels(@RequestParam String provider) {
        ArrayList<Map<String, Object>> models = new ArrayList<>();
        if ("ollama".equalsIgnoreCase(provider)) {
            try {
                List<Map<String, Object>> ollamaModels;
                String url = this.ragConfig.getOllamaBaseUrl() + "/api/tags";
                HttpHeaders headers = new HttpHeaders();
                HttpEntity entity = new HttpEntity((MultiValueMap)headers);
                ResponseEntity<Map<String, Object>> response = this.restTemplate.exchange(url, HttpMethod.GET, entity, new ParameterizedTypeReference<Map<String, Object>>(){});
                if (response.getStatusCode() != HttpStatus.OK || response.getBody() == null || (ollamaModels = (List)(response.getBody()).get("models")) == null) return Result.success(models);
                for (Map<String, Object> m : ollamaModels) {
                    String name = (String)m.get("name");
                    String displayName = name;
                    if (name.startsWith("qwen2.5")) {
                        displayName = "Qwen2.5 " + name.substring(name.indexOf(58));
                    } else if (name.startsWith("qwen2")) {
                        displayName = "Qwen2 " + name.substring(name.indexOf(58));
                    } else if (name.startsWith("phi")) {
                        displayName = "Phi-" + name.substring(3);
                    } else if (name.startsWith("tinyllama")) {
                        displayName = "TinyLlama";
                    } else if (name.startsWith("deepseek")) {
                        displayName = "DeepSeek " + name.substring(name.indexOf(58));
                    }
                    models.add(Map.of("id", name, "name", displayName));
                }
                return Result.success(models);
            }
            catch (Exception e) {
                log.error("Failed to get Ollama models: {}", e.getMessage());
                models.add(Map.of("id", "qwen2.5:3b", "name", "Qwen2.5 3B"));
                return Result.success(models);
            }
        } else {
            if (!"minimax".equalsIgnoreCase(provider)) return Result.success(models);
            models.add(Map.of("id", "MiniMax-M2.7", "name", "MiniMax-M2.7 (\u4e91\u7aef)"));
        }
        return Result.success(models);
    }
}

