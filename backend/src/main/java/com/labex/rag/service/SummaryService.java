package com.labex.rag.service;

import com.labex.entity.RagMessage;
import com.labex.entity.RagSessionSummary;
import com.labex.mapper.RagMessageMapper;
import com.labex.mapper.RagSessionSummaryMapper;
import com.labex.rag.config.RagConfig;
import com.labex.rag.llm.LLMChat;
import com.labex.rag.llm.MiniMaxChat;
import com.labex.rag.llm.OllamaChat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

@Service
public class SummaryService {
    private static final Logger log = LoggerFactory.getLogger(SummaryService.class);
    private final RagSessionSummaryMapper summaryMapper;
    private final RagMessageMapper messageMapper;
    private final MiniMaxChat miniMaxChat;
    private final OllamaChat ollamaChat;
    private final RagConfig ragConfig;
    private static final int ROUNDS_BEFORE_SUMMARY = 5;
    private static final int KEEP_RECENT_ROUNDS = 3;
    private static final String SUMMARY_PROMPT = "\u8bf7\u5c06\u4ee5\u4e0b\u5bf9\u8bdd\u5386\u53f2\u538b\u7f29\u6210\u7b80\u6d01\u7684\u6458\u8981\uff0c\u4fdd\u7559\u5173\u952e\u4fe1\u606f\u548c\u4e0a\u4e0b\u6587\u3002\u6458\u8981\u5e94\u8be5\u5305\u542b\uff1a1) \u7528\u6237\u7684\u4e3b\u8981\u95ee\u9898\u4e3b\u9898 2) \u8ba8\u8bba\u7684\u5173\u952e\u77e5\u8bc6\u70b9 3) \u91cd\u8981\u7684\u7ed3\u8bba\u6216\u51b3\u5b9a\u3002\u8bf7\u7528\u4e2d\u6587\u8f93\u51fa\uff0c\u63a7\u5236\u5728200\u5b57\u4ee5\u5185\u3002\n\n\u5bf9\u8bdd\u5386\u53f2\uff1a\n";

    @Autowired
    public SummaryService(RagSessionSummaryMapper summaryMapper, RagMessageMapper messageMapper, @Lazy MiniMaxChat miniMaxChat, @Lazy OllamaChat ollamaChat, RagConfig ragConfig) {
        this.summaryMapper = summaryMapper;
        this.messageMapper = messageMapper;
        this.miniMaxChat = miniMaxChat;
        this.ollamaChat = ollamaChat;
        this.ragConfig = ragConfig;
    }

    private LLMChat getLlmChat() {
        if ("ollama".equalsIgnoreCase(this.ragConfig.getLlmProvider())) {
            return this.ollamaChat;
        }
        return this.miniMaxChat;
    }

    public boolean checkAndSummarize(String sessionId) {
        try {
            List<RagMessage> messages = this.messageMapper.selectBySessionId(sessionId);
            if (messages == null || messages.isEmpty()) {
                return false;
            }
            RagSessionSummary latestSummary = this.summaryMapper.selectLatestBySessionId(sessionId);
            int lastSummarizedIndex = latestSummary != null ? latestSummary.getMessageRangeEnd() : 0;
            int unsummarizedCount = messages.size() - lastSummarizedIndex;
            int unsummarizedRounds = unsummarizedCount / 2;
            if (unsummarizedRounds < 5) {
                return false;
            }
            List<RagMessage> toSummarize = messages.subList(lastSummarizedIndex, messages.size());
            int keepCount = 6;
            if (toSummarize.size() <= keepCount) {
                return false;
            }
            List<RagMessage> forSummary = toSummarize.subList(0, toSummarize.size() - keepCount);
            String summaryText = this.generateSummary(forSummary);
            if (summaryText == null || summaryText.isBlank()) {
                log.warn("Failed to generate summary for session: {}", sessionId);
                return false;
            }
            RagSessionSummary summary = new RagSessionSummary();
            summary.setSessionId(sessionId);
            summary.setSummary(summaryText);
            summary.setMessageRangeStart(Integer.valueOf(lastSummarizedIndex));
            summary.setMessageRangeEnd(Integer.valueOf(lastSummarizedIndex + forSummary.size()));
            summary.setCreateTime(Long.valueOf(System.currentTimeMillis()));
            this.summaryMapper.insert(summary);
            log.info("Created summary for session: {}, messages {}-{}", new Object[]{sessionId, summary.getMessageRangeStart(), summary.getMessageRangeEnd()});
            return true;
        }
        catch (Exception e) {
            log.error("Failed to check and summarize session {}: {}", sessionId, e.getMessage());
            return false;
        }
    }

    private String generateSummary(List<RagMessage> messages) {
        try {
            StringBuilder historyText = new StringBuilder();
            for (RagMessage msg : messages) {
                String role = "user".equals(msg.getRole()) ? "\u7528\u6237" : "\u52a9\u624b";
                historyText.append(role).append(": ").append(msg.getContent()).append("\n");
            }
            String summary = this.getLlmChat().chat(SUMMARY_PROMPT, "", historyText.toString());
            return summary;
        }
        catch (Exception e) {
            log.error("Failed to generate summary: {}", e.getMessage());
            return null;
        }
    }

    public List<Map<String, Object>> getSessionContext(String sessionId) {
        ArrayList<Map<String, Object>> context = new ArrayList<>();
        try {
            RagSessionSummary latestSummary = this.summaryMapper.selectLatestBySessionId(sessionId);
            if (latestSummary != null && latestSummary.getSummary() != null) {
                HashMap<String, Object> summaryMsg = new HashMap<String, Object>();
                summaryMsg.put("role", "system");
                summaryMsg.put("content", "[\u5bf9\u8bdd\u5386\u53f2\u6458\u8981]\n" + latestSummary.getSummary());
                context.add(summaryMsg);
                List<RagMessage> messages = this.messageMapper.selectBySessionId(sessionId);
                if (messages != null && messages.size() > latestSummary.getMessageRangeEnd()) {
                    List<RagMessage> recentMessages = messages.subList(latestSummary.getMessageRangeEnd(), messages.size());
                    for (RagMessage msg : recentMessages) {
                        HashMap<String, Object> historyMsg = new HashMap<>();
                        historyMsg.put("role", msg.getRole());
                        historyMsg.put("content", msg.getContent());
                        context.add(historyMsg);
                    }
                }
            } else {
                List<RagMessage> messages = this.messageMapper.selectBySessionId(sessionId);
                if (messages != null) {
                    int start;
                    int keepCount = 6;
                    for (int i = start = Math.max(0, messages.size() - keepCount); i < messages.size(); ++i) {
                        RagMessage msg = (RagMessage)messages.get(i);
                        HashMap<String, Object> historyMsg = new HashMap<>();
                        historyMsg.put("role", msg.getRole());
                        historyMsg.put("content", msg.getContent());
                        context.add(historyMsg);
                    }
                }
            }
        }
        catch (Exception e) {
            log.error("Failed to get session context for {}: {}", sessionId, e.getMessage());
        }
        return context;
    }

    public void clearSummaries(String sessionId) {
        try {
            this.summaryMapper.deleteBySessionId(sessionId);
        }
        catch (Exception e) {
            log.error("Failed to clear summaries for session {}: {}", sessionId, e.getMessage());
        }
    }
}

