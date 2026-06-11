package com.labex.labexagent.runtime;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.labex.controller.student.ProjectCommandSafety;
import com.labex.entity.AgentConversation;
import com.labex.entity.AgentTask;
import com.labex.entity.StudentProject;
import com.labex.labexagent.diff.DiffService;
import com.labex.labexagent.diff.GitSnapshotService;
import com.labex.labexagent.diff.PendingChange;
import com.labex.labexagent.dto.AgentStreamRequest;
import com.labex.labexagent.prompt.LabexSystemPrompt;
import com.labex.labexagent.runtime.AgentCancellationRegistry;
import com.labex.labexagent.runtime.AgentContext;
import com.labex.labexagent.runtime.AgentContextManager;
import com.labex.labexagent.runtime.AgentSsePublisher;
import com.labex.labexagent.runtime.ToolCallExtractor;
import com.labex.labexagent.lsp.DiagnosticsService;
import com.labex.labexagent.permission.*;
import com.labex.labexagent.tool.ToolSupport;
import com.labex.labexagent.service.AgentConversationService;
import com.labex.labexagent.service.AgentTaskService;
import com.labex.labexagent.service.TokenTracker;
import com.labex.labexagent.tool.AgentTool;
import com.labex.labexagent.tool.ToolRegistry;
import com.labex.labexagent.tool.ToolResult;
import com.labex.labexagent.llm.LlmProvider;
import com.labex.labexagent.llm.LlmProviderFactory;
import com.labex.rag.config.RagConfig;
import com.labex.rag.llm.MiniMaxChat;
import com.labex.rag.llm.OllamaChat;
import com.labex.service.AgentModelConfigService;
import com.labex.service.AgentMcpServerService;
import com.labex.service.AgentSkillService;
import com.labex.service.StudentProjectService;
import com.labex.entity.AgentModelConfig;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.LinkOption;
import java.nio.file.Path;
import java.nio.file.StandardOpenOption;
import java.nio.file.attribute.FileAttribute;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

@Service
public class AgentLoopEngine {
    private static final Logger log = LoggerFactory.getLogger(AgentLoopEngine.class);
    private static final Gson GSON = new Gson();
    private static final int MAX_RECOVERABLE_MODEL_ERRORS = 10;
    private static final ThreadPoolExecutor AGENT_EXECUTOR = new ThreadPoolExecutor(
            4,
            16,
            60L,
            TimeUnit.SECONDS,
            new ArrayBlockingQueue<>(128),
            new AgentThreadFactory(),
            new ThreadPoolExecutor.AbortPolicy());
    private final StudentProjectService studentProjectService;
    private final ToolRegistry toolRegistry;
    private final AgentContextManager contextManager;
    private final AgentCancellationRegistry cancellationRegistry;
    private final MiniMaxChat miniMaxChat;
    private final OllamaChat ollamaChat;
    private final RagConfig ragConfig;
    private final AgentConversationService conversationService;
    private final AgentTaskService taskService;
    private final LlmProviderFactory providerFactory;
    private final AgentModelConfigService modelConfigService;
    private final TokenTracker tokenTracker;
    private final AgentSkillService skillService;
    private final AgentMcpServerService mcpServerService;
    private final PermissionService permissionService;
    private final DiagnosticsService diagnosticsService;
    private final GitSnapshotService gitSnapshotService;
    private final DiffService diffService;

    public AgentLoopEngine(StudentProjectService s, ToolRegistry t, AgentContextManager c, AgentCancellationRegistry cr, @Lazy MiniMaxChat mm, @Lazy OllamaChat oc, RagConfig r, AgentConversationService cs, AgentTaskService ts, LlmProviderFactory pf, AgentModelConfigService mcs, TokenTracker tt, AgentSkillService skillService, AgentMcpServerService mcpServerService, PermissionService permissionService, DiagnosticsService diagnosticsService, GitSnapshotService gitSnapshotService, DiffService diffService) {
        this.studentProjectService = s;
        this.toolRegistry = t;
        this.contextManager = c;
        this.cancellationRegistry = cr;
        this.miniMaxChat = mm;
        this.ollamaChat = oc;
        this.ragConfig = r;
        this.conversationService = cs;
        this.taskService = ts;
        this.providerFactory = pf;
        this.modelConfigService = mcs;
        this.tokenTracker = tt;
        this.skillService = skillService;
        this.mcpServerService = mcpServerService;
        this.permissionService = permissionService;
        this.diagnosticsService = diagnosticsService;
        this.gitSnapshotService = gitSnapshotService;
        this.diffService = diffService;
    }

    public SseEmitter start(Integer studentId, Integer projectId, AgentStreamRequest request) {
        SseEmitter emitter = new SseEmitter(Long.valueOf(0L));
        String sid = request.getSessionId() != null && !request.getSessionId().isBlank() ? request.getSessionId() : UUID.randomUUID().toString();
        request.setSessionId(sid);
        this.cancellationRegistry.reset(sid);
        try {
            AGENT_EXECUTOR.execute(() -> this.runLoop(studentId, projectId, request, emitter));
        } catch (Exception e) {
            try {
                new AgentSsePublisher(emitter).send("ERROR", Map.of("message", "Agent queue is busy. Please retry shortly."));
            } catch (Exception ignored) {
                // ignore send failure
            }
            emitter.complete();
        }
        return emitter;
    }

    private static class AgentThreadFactory implements ThreadFactory {
        private int index = 1;

        public synchronized Thread newThread(Runnable runnable) {
            Thread thread = new Thread(runnable, "labex-agent-" + index++);
            thread.setDaemon(true);
            return thread;
        }
    }

    /*
     * Enabled aggressive block sorting
     * Enabled unnecessary exception pruning
     * Enabled aggressive exception aggregation
     */
    private void runLoop(Integer studentId, Integer projectId, AgentStreamRequest request, SseEmitter emitter) {
        AgentSsePublisher sse = new AgentSsePublisher(emitter);
        AgentConversation conv = null;
        AgentTask task = null;
        AgentContext ctx = null;
        StudentProject project = null;
        Path runLog = null;
        LlmProvider llmProvider = null;
        LlmProvider.LlmConfig llmConfig = null;
        try {
            AgentModelConfig modelConfig = this.modelConfigService.resolveForStudent(studentId, request.getModelConfigId());
            llmProvider = this.providerFactory.resolveProvider(modelConfig);
            llmConfig = this.providerFactory.buildConfig(modelConfig);
            project = this.studentProjectService.getOwnedProject(studentId, projectId);
            if (project == null) {
                throw new IllegalArgumentException("Project not found");
            }
            runLog = this.createRunLog(project, request);
            this.appendRunLog(runLog, "# LabexAgent run log\n\n- Session: `" + this.safeLogText(request.getSessionId()) + "`\n- Project: `" + this.safeLogText(project.getProjectName()) + "`\n- Student: `" + studentId + "`\n- Start time: `" + String.valueOf(LocalDateTime.now()) + "`\n\n## User input\n\n" + this.safeLogText(request.getMessage()) + "\n");
            String mode = request.getMode() != null ? request.getMode() : "agent";
            conv = this.conversationService.ensureConversation(studentId, project, request.getConversationId(), mode, request.getMessage());
            request.setConversationId(conv.getConversationId());
            String memoryContext = this.conversationService.buildMemoryContext(studentId, projectId, conv.getConversationId());
            this.conversationService.saveUserMessage(conv, request.getMessage());
            task = this.taskService.createTask(studentId, project, conv.getConversationId(), request.getSessionId(), mode, request.getMessage());
            ctx = AgentContext.create((String)request.getSessionId(), (Integer)studentId, (StudentProject)project, (String)conv.getConversationId(), (Long)task.getTaskId());
            ctx.setMode(mode);
            this.appendRunLog(runLog, "\n## Runtime metadata\n\n- Conversation: `" + conv.getConversationId() + "`\n- Task: `" + task.getTaskId() + "`\n- Mode: `" + mode + "`\n- Iteration limit: `none`\n");
            String toolDefinitions = this.buildToolDefinitions();
            String sysPrompt = LabexSystemPrompt.buildSystemPrompt((StudentProject)project, (String)toolDefinitions);
            List<Map<String, Object>> tools = this.buildToolsList();
            ArrayList<Map<String, Object>> msgs = new ArrayList<Map<String, Object>>();
            String activeFileContent = this.readActiveFile(studentId, projectId, request.getActivePath());
            String projectRules = this.readProjectRules(studentId, projectId);
            String projectIndex = this.readProjectIndex(studentId, projectId);
            String sessionContext = this.contextManager.buildInitialContext(project, request.getActivePath(), activeFileContent, toolDefinitions, request.getMessage(), projectIndex, false);
            String recentRunLog = this.readLatestRunLog(project, runLog);
            String checkpoint = this.readAgentCheckpoint(project);
            String globalSkills = this.skillService.buildPromptContext(studentId);
            String mcpContext = this.mcpServerService.buildPromptContext(studentId);
            msgs.add(Map.of("role", "user", "content", this.buildModePolicy(mode) + "\n\n" + this.buildContextMessage(projectRules, memoryContext, sessionContext, recentRunLog, checkpoint, globalSkills, mcpContext)));
            msgs.add(Map.of("role", "user", "content", request.getMessage()));
            this.sendEvent(sse, conv, "SESSION", Map.of("sessionId", request.getSessionId(), "conversationId", conv.getConversationId(), "taskId", task.getTaskId(), "iterationLimit", "none", "logPath", this.workspaceRelativeLogPath(project, runLog)));
            this.writeAgentCheckpoint(project, request, task, ctx, "running", "Session started, preparing first model call.", "", "", runLog);
            int recoverableModelErrors = 0;
            int i = 1;
            int maxIterations = 30;
            java.util.List<String> recentToolCalls = new java.util.ArrayList<>();
            int sameToolCount = 0;
            String lastToolSignature = "";
            while (true) {
                block19: {
                    boolean executed;
                    String type;
                    Map lr;
                    block21: {
                        String ft;
                        block24: {
                            String cleaned;
                            String content;
                            block23: {
                                block22: {
                                    String planJson2;
                                    block20: {
                                        String planJson;
                                        this.appendRunLog(runLog, "\n## Iteration " + i + "\n");
                                        if (this.cancellationRegistry.isCancelled(request.getSessionId())) {
                                            this.taskService.updateTask(task.getTaskId(), "cancelled", "User cancelled", "User cancelled execution");
                                            this.appendRunLog(runLog, "\n- Stop reason: user cancelled.\n");
                                            this.sendEvent(sse, conv, "INTERRUPTED", Map.of("message", "User cancelled execution", "iteration", i));
                                            this.streamFinal(sse, conv, this.buildStopFinal("User cancelled", "User actively cancelled this run.", project, runLog));
                                            emitter.complete();
                                            return;
                                        }
                                        if (i > maxIterations) {
                                            this.appendRunLog(runLog, "\n- Warning: reached " + maxIterations + " iterations, still running\n");
                                            this.sendThought(sse, conv, i, "Long running task", "Reached " + maxIterations + " iterations. Continuing - user can stop if needed.", task.getTaskId());
                                        }
                                        this.taskService.updateTask(task.getTaskId(), "running", "Thinking", null);
                                        lr = this.chatStreaming(sse, conv, sysPrompt, msgs, tools, llmProvider, llmConfig, i, task.getTaskId());
                                        type = (String)lr.get("type");
                                        this.appendRunLog(runLog, "\n- Model response type: `" + this.safeLogText(type) + "`\n");
                                        log.info("Iteration {}, type: {}", i, type);

                                        // Token usage tracking
                                        if (lr.containsKey("usage")) {
                                            try {
                                                @SuppressWarnings("unchecked")
                                                Map<String, Object> usageMap = (Map<String, Object>) lr.get("usage");
                                                if (usageMap != null) {
                                                    this.tokenTracker.recordFromMap(conv.getConversationId(), request.getSessionId(),
                                                            studentId, projectId, llmProvider.getProviderId(), llmConfig.modelName(),
                                                            usageMap, i, null);
                                                    int totalTokens = usageMap.containsKey("total_tokens") ?
                                                            ((Number) usageMap.get("total_tokens")).intValue() : 0;
                                                    if (totalTokens > 0) {
                                                        log.info("Iteration {}: sending TOKEN_USAGE, totalTokens={}", i, totalTokens);
                                                        this.sendEvent(sse, conv, "TOKEN_USAGE", Map.of(
                                                                "iteration", i,
                                                                "promptTokens", usageMap.getOrDefault("prompt_tokens", 0),
                                                                "completionTokens", usageMap.getOrDefault("completion_tokens", 0),
                                                                "totalTokens", totalTokens,
                                                                "conversationTotal", this.tokenTracker.getTotalTokensByConversation(conv.getConversationId())
                                                        ));
                                                    }
                                                }
                                            } catch (Exception tokenEx) {
                                                log.warn("Token tracking error: {}", tokenEx.getMessage());
                                            }
                                        } else {
                                            // Estimate tokens when provider doesn't return usage
                                            try {
                                                int estimatedPrompt = sysPrompt.length() / 4 + msgs.stream().mapToInt(m -> {
                                                    Object c = m.get("content");
                                                    return c != null ? c.toString().length() / 4 : 0;
                                                }).sum();
                                                String responseContent = lr.get("content") != null ? lr.get("content").toString() : "";
                                                String responseThinking = lr.get("thinking") != null ? lr.get("thinking").toString() : "";
                                                int estimatedCompletion = (responseContent.length() + responseThinking.length()) / 4;
                                                int estimatedTotal = estimatedPrompt + estimatedCompletion;
                                                if (estimatedTotal > 0) {
                                                    log.info("Iteration {}: sending TOKEN_USAGE (estimated), totalTokens={}", i, estimatedTotal);
                                                    this.tokenTracker.record(conv.getConversationId(), request.getSessionId(),
                                                            studentId, projectId, llmProvider.getProviderId(), llmConfig.modelName(),
                                                            estimatedPrompt, estimatedCompletion, estimatedTotal, i, null);
                                                    this.sendEvent(sse, conv, "TOKEN_USAGE", Map.of(
                                                            "iteration", i,
                                                            "promptTokens", estimatedPrompt,
                                                            "completionTokens", estimatedCompletion,
                                                            "totalTokens", estimatedTotal,
                                                            "conversationTotal", this.tokenTracker.getTotalTokensByConversation(conv.getConversationId())
                                                    ));
                                                }
                                            } catch (Exception estEx) {
                                                log.debug("Token estimation error: {}", estEx.getMessage());
                                            }
                                        }
                                        executed = false;
                                        if (!"tool_call".equals(type)) break block20;
                                        String tn = (String)lr.get("tool");
                                        String as = (String)lr.get("arguments");
                                        String modelThinkingRaw = lr.get("thinking") != null ? lr.get("thinking").toString() : "";
                                        String modelThinking = this.cleanModelOutput(modelThinkingRaw);
                                        JsonObject ta = this.parseArgs(as);
                                        this.appendRunLog(runLog, "\n### Tool call\n\n- Tool: `" + this.safeLogText(tn) + "`\n- Args:\n\n```json\n" + GSON.toJson((JsonElement)ta) + "\n```\n");
                                        // Send local thinking only if model didn't provide reasoning (streaming already sent it)
                                        if (modelThinking.isBlank()) {
                                            this.sendThought(sse, conv, i, this.visibleActionSummary(tn, ta), this.buildToolThought(tn, ta, false), task.getTaskId());
                                        }
                                        this.sendEvent(sse, conv, "TOOL_CALL", Map.of("iteration", i, "tool", tn, "arguments", ta, "summary", this.visibleActionSummary(tn, ta), "content", this.visibleActionDetail(tn, ta), "taskId", task.getTaskId()));
                                        String toolSignature = tn + ":" + this.toolTarget(this.safeTool(tn), ta);
                                        recentToolCalls.add(toolSignature);
                                        if (recentToolCalls.size() > 5) recentToolCalls.remove(0);
                                        if (toolSignature.equals(lastToolSignature)) {
                                            sameToolCount++;
                                            if (sameToolCount >= 3) {
                                                this.appendRunLog(runLog, "\n- Loop detected: same tool called " + sameToolCount + " times\n");
                                                this.sendThought(sse, conv, i, "Loop detected", "Same tool called " + sameToolCount + " times in a row. Need to change approach or complete the task.", task.getTaskId());
                                            }
                                        } else {
                                            sameToolCount = 0;
                                            lastToolSignature = toolSignature;
                                        }
                                        ToolResult res = this.execTool(tn, ta, ctx, sse, conv);
                                        this.appendToolResult(runLog, res);
                                        this.writeAgentCheckpoint(project, request, task, ctx, res.isSuccess() ? "tool_success" : "tool_failed", "Tool `" + this.safeLogText(tn) + "` returned.", tn, this.compactToolResultForCheckpoint(tn, res), runLog);
                                        this.sendObserve(sse, conv, i, tn, res, task.getTaskId());
                                        if (("create_plan".equals(tn) || "plan".equals(tn) || "todo_write".equals(tn) || "todowrite".equals(tn)) && (planJson = ctx.getPlanJson()) != null && !planJson.isBlank()) {
                                            this.sendEvent(sse, conv, "PLAN_UPDATE", Map.of("plan", ctx.getPlan(), "summary", ctx.getPlanSummary(), "planJson", planJson));
                                        }
                                        this.sendThought(sse, conv, i, "Check result", this.buildResultThought(tn, ta, res), task.getTaskId());
                                        if (res.isApprovalRequired()) {
                                            this.taskService.updateTask(task.getTaskId(), "waiting_approval", "Awaiting approval", res.getApprovalCommand());
                                            this.appendRunLog(runLog, "\n- Awaiting approval command: `" + this.safeLogText(res.getApprovalCommand()) + "`\n");
                                            this.sendEvent(sse, conv, "COMMAND_APPROVAL_REQUIRED", Map.of("taskId", task.getTaskId(), "command", res.getApprovalCommand()));
                                            this.writeAgentCheckpoint(project, request, task, ctx, "waiting_approval", "Awaiting user approval for command `" + this.safeLogText(res.getApprovalCommand()) + "`.", tn, this.compactToolResultForCheckpoint(tn, res), runLog);
                                            this.streamFinal(sse, conv, this.buildStopFinal("Awaiting user approval", "Need to confirm execution of command: `" + res.getApprovalCommand() + "`.", project, runLog));
                                            this.sendEvent(sse, conv, "DONE", Map.of("message", "Awaiting approval", "iterations", i));
                                            emitter.complete();
                                            return;
                                        }
                                        String planStatus = ctx.getPlanSummary();
                                        Object planNote = planStatus.isEmpty() ? "" : "\nCurrent plan progress:\n" + planStatus;
                                        msgs.add(Map.of("role", "assistant", "content", ""));
                                        msgs.add(Map.of("role", "user", "content", "[Tool " + tn + " result]\n" + this.compactToolResultForModel(tn, res) + (String)planNote + "\nCall tools to continue. Do not output plain text. Only output final summary after all plan tasks are complete and verified."));
                                        executed = true;
                                        break block19;
                                    }
                                    if (!"text".equals(type)) break block21;
                                    content = lr.get("content") != null ? lr.get("content").toString() : "";
                                    String modelThinkingFromLr = lr.get("thinking") != null ? this.cleanModelOutput(lr.get("thinking").toString()) : "";
                                    String invTool = ToolCallExtractor.extractToolName((String)content);
                                    if (invTool == null || invTool.isEmpty()) break block22;
                                    executed = true;
                                    String invArgs = ToolCallExtractor.extractToolArgs((String)content, (String)invTool);
                                    log.info("Iteration {}: extracted tool={} args={}", new Object[]{i, invTool, invArgs});
                                    JsonObject parsedArgs = this.parseArgs(invArgs);
                                    this.appendRunLog(runLog, "\n### Recovered tool call from text\n\n- Tool: `" + this.safeLogText(invTool) + "`\n- Args:\n\n```json\n" + GSON.toJson((JsonElement)parsedArgs) + "\n```\n");
                                    // Send local thinking only if streaming didn't already cover it
                                    if (modelThinkingFromLr == null || modelThinkingFromLr.isBlank()) {
                                        this.sendThought(sse, conv, i, this.visibleActionSummary(invTool, parsedArgs), this.buildToolThought(invTool, parsedArgs, true), task.getTaskId());
                                    }
                                    this.sendEvent(sse, conv, "TOOL_CALL", Map.of("iteration", i, "tool", invTool, "arguments", parsedArgs, "summary", this.visibleActionSummary(invTool, parsedArgs), "content", this.visibleActionDetail(invTool, parsedArgs), "taskId", task.getTaskId()));
                                    ToolResult res = this.execTool(invTool, parsedArgs, ctx, sse, conv);
                                    this.appendToolResult(runLog, res);
                                    this.writeAgentCheckpoint(project, request, task, ctx, res.isSuccess() ? "tool_success" : "tool_failed", "Recovered and executed tool `" + this.safeLogText(invTool) + "`.", invTool, this.compactToolResultForCheckpoint(invTool, res), runLog);
                                    this.sendObserve(sse, conv, i, invTool, res, task.getTaskId());
                                    if (("create_plan".equals(invTool) || "plan".equals(invTool) || "todo_write".equals(invTool) || "todowrite".equals(invTool)) && (planJson2 = ctx.getPlanJson()) != null && !planJson2.isBlank()) {
                                        this.sendEvent(sse, conv, "PLAN_UPDATE", Map.of("plan", ctx.getPlan(), "summary", ctx.getPlanSummary(), "planJson", planJson2));
                                    }
                                    this.sendThought(sse, conv, i, "Check result", this.buildResultThought(invTool, parsedArgs, res), task.getTaskId());
                                    String planStatus2 = ctx.getPlanSummary();
                                    Object planNote2 = planStatus2.isEmpty() ? "" : "\nCurrent plan progress:\n" + planStatus2;
                                    msgs.add(Map.of("role", "assistant", "content", ""));
                                    msgs.add(Map.of("role", "user", "content", "[Tool " + invTool + " result]\n" + this.compactToolResultForModel(invTool, res) + (String)planNote2 + "\nCall tools to continue. Complete all plan tasks and verify before final summary."));
                                    break block19;
                                }
                                cleaned = this.cleanModelOutput(content);
                                log.info("Iteration {}: text ({} chars, cleaned={} chars): {}", new Object[]{i, content.length(), cleaned.length(), content.substring(0, Math.min(200, content.length()))});
                                if (!cleaned.isEmpty()) break block23;
                                log.info("Iteration {}: empty/marker-only response, nudging model", i);
                                this.appendRunLog(runLog, "\n- Model returned empty/marker-only response, requesting continuation.\n");
                                msgs.add(Map.of("role", "assistant", "content", content));
                                msgs.add(Map.of("role", "user", "content", "Task not done. Call tools to execute next step. Do not output plain text ending."));
                                executed = true;
                                break block19;
                            }
                            ft = this.extractThinking(content);
                            if (ft.isEmpty()) {
                                ft = cleaned;
                            }
                            if (!this.isPrematureFinal(ft, ctx)) break block24;
            this.appendRunLog(runLog, "\n- Model returned mid-placeholder text, rejecting as final, continuing: `" + this.safeLogText(ft) + "`\n");
            this.writeAgentCheckpoint(project, request, task, ctx, "continuing_after_premature_final", "Model returned mid-placeholder text, rejected as final.", "", ft, runLog);
                            msgs.add(Map.of("role", "assistant", "content", ft));
                            msgs.add(Map.of("role", "user", "content", this.buildContinuationInstruction(ctx)));
                            executed = true;
                            break block19;
                        }
                        if (this.hasOpenPlan(ctx)) {
                            this.appendRunLog(runLog, "\n- Plan has unfinished tasks, rejecting premature end. Remaining: " + ctx.getPlanSummary() + "\n");
                            this.writeAgentCheckpoint(project, request, task, ctx, "continuing_open_plan", "Plan has unfinished tasks, rejecting premature end.", "", ft, runLog);
                            msgs.add(Map.of("role", "assistant", "content", ft));
                            String planMsg = "Your plan has unfinished tasks. Cannot end yet. Continue execution:\n" + ctx.getPlanSummary() + "\nUse create_plan complete to mark done items, then continue next item.";
                            msgs.add(Map.of("role", "user", "content", planMsg));
                            executed = true;
                            break block19;
                        } else {
                            boolean noSubstance;
                            boolean tooShort = ft.length() < 200;
                            boolean noStructure = !ft.contains("##") && !ft.contains("**");
                            boolean bl = noSubstance = !ft.contains("edit") && !ft.contains("complete") && !ft.contains("file") && !ft.contains("verify") && !ft.contains("passed") && !ft.contains("result") && !ft.contains("modified") && !ft.contains("summary");
                            if (tooShort || noStructure && noSubstance) {
                                this.appendRunLog(runLog, "\n- Reply quality insufficient (length=" + ft.length() + ", noStructure=" + noStructure + ", noSubstance=" + noSubstance + "), rejecting as final.\n");
                                msgs.add(Map.of("role", "assistant", "content", ft));
                                msgs.add(Map.of("role", "user", "content", "Reply too short to be final. Output complete structured summary:\n## Summary\n**Completed**\n- What was modified\n**Verification**\n- How it was verified\n**Suggestions**\n- Next steps"));
                                executed = true;
                                break block19;
                            } else {
                                // Model's reasoning already streamed in real-time by chatStreaming
                                this.appendRunLog(runLog, "\n## Final response\n\n" + this.safeLogText(ft) + "\n");
                                log.info("Iteration {}: final response ({} chars)", i, ft.length());
                                this.streamFinal(sse, conv, ft);
                                this.taskService.updateTask(task.getTaskId(), "completed", "Completed", ft);
                                this.writeAgentCheckpoint(project, request, task, ctx, "completed", "Task completed with final response.", "", this.limitForContext(ft, 2000), runLog);
                                this.sendEvent(sse, conv, "DONE", Map.of("message", "Done", "iterations", i));
                                emitter.complete();
                                return;
                            }
                        }
                    }
                    if ("error".equals(type)) {
                        String errMsg = (String)lr.get("message");
                        log.warn("Iteration {} API error: {}", i, errMsg);
                        this.appendRunLog(runLog, "\n### Model error\n\n" + this.safeLogText(errMsg) + "\n");
                        if (this.isRecoverableModelError(errMsg) && recoverableModelErrors < 10) {
                            long delay = Math.min(15000L, 1000L * (1L << Math.min(++recoverableModelErrors, 4)));
                            String guidance = this.buildRecoverableErrorGuidance(errMsg, recoverableModelErrors, delay);
                            this.appendRunLog(runLog, "\n- Recoverable error, retry " + recoverableModelErrors + ", waiting " + delay + "ms\n- Guidance: " + this.safeLogText(guidance) + "\n");
                            this.writeAgentCheckpoint(project, request, task, ctx, "recoverable_model_error", "Recoverable model connection error, retry " + recoverableModelErrors + ".", "", errMsg, runLog);
                            this.sendThought(sse, conv, i, "Network retry", guidance, task.getTaskId());
                            Thread.sleep(delay);
                            msgs.add(Map.of("role", "user", "content", guidance));
                            executed = true;
                            break block19;
                        } else {
                            this.sendEvent(sse, conv, "ERROR", Map.of("message", "Model API failed: " + errMsg, "iteration", i));
                            this.streamFinal(sse, conv, this.buildStopFinal("Model API failed", "Model connection failed continuously. Task paused. Check API Key config or retry later.", project, runLog));
                            this.taskService.updateTask(task.getTaskId(), "failed", "Model API failed", errMsg);
                            this.writeAgentCheckpoint(project, request, task, ctx, "failed_model_error", "Model connection failed continuously. Task paused.", "", errMsg, runLog);
                            this.sendEvent(sse, conv, "DONE", Map.of("message", "Model API failed", "iterations", i));
                            emitter.complete();
                            return;
                        }
                    }
                    log.warn("Iteration {} unknown type: {}", i, type);
                    this.appendRunLog(runLog, "\n- Unknown response type: `" + this.safeLogText(type) + "`\n");
                    this.sendEvent(sse, conv, "ERROR", Map.of("message", "Unknown response type: " + type));
                    executed = true;
                }
                ++i;
            }
        }
        catch (Exception e) {
            log.error("Agent loop error", (Throwable)e);
            try {
                this.appendRunLog(runLog, "\n## Runtime exception\n\n```text\n" + this.safeLogText(e.toString()) + "\n```\n");
                if (e instanceof InterruptedException) {
                    this.sendEvent(sse, conv, "INTERRUPTED", Map.of("message", "Interrupted"));
                } else {
                    this.streamFinal(sse, conv, this.buildStopFinal("Runtime exception", "Agent encountered exception during execution: `" + e.getMessage() + "`.", project, runLog));
                    this.taskService.updateTask(task.getTaskId(), "failed", "Runtime exception", e.getMessage());
                    this.writeAgentCheckpoint(project, request, task, ctx, "failed_exception", "Agent encountered exception during execution.", "", e.toString(), runLog);
                    this.sendEvent(sse, conv, "DONE", Map.of("message", "Runtime exception"));
                }
            } catch (Exception ignored) {
                log.error("Error in exception handler", ignored);
            }
            emitter.complete();
            return;
        }
    }

    private JsonObject parseArgs(String s) {
        if (s == null || s.isEmpty()) {
            return new JsonObject();
        }
        try {
            return JsonParser.parseString((String)s).getAsJsonObject();
        }
        catch (Exception e) {
            return new JsonObject();
        }
    }

    private ToolResult execTool(String name, JsonObject args, AgentContext ctx, AgentSsePublisher sse, AgentConversation conv) {
        AgentTool t = this.toolRegistry.get(name);
        if (t == null) {
            return ToolResult.failed((String)("Unknown tool: " + name));
        }
        boolean explicitlyApproved = false;
        try {
            String mode = ctx.getMode();
            List<PermissionRule> defaultRules = DefaultPermissionRuleset.getRulesForAgent(mode);
            String inputStr = this.permissionInput(name, args);
            PermissionService.PermissionEvaluation eval = permissionService.evaluate(name, inputStr, defaultRules, ctx.getSessionId(), ctx.getProject().getProjectId());
            switch (eval.getAction()) {
                case DENY:
                    PermissionRule matched = eval.getMatchedRule();
                    String denyMsg = "Permission denied by " + mode + " agent rules: tool '" + name
                        + "' matching rule (" + (matched != null ? matched.getPermission() + "=" + matched.getAction() : "default deny")
                        + "). Switch to build mode for write operations.";
                    log.warn(denyMsg);
                    return ToolResult.failed(denyMsg);
                case ASK:
                    PermissionRule askRule = eval.getMatchedRule();
                    PermissionService.PermissionApprovalResult approvalResult = this.requestToolApproval(
                            ctx,
                            sse,
                            conv,
                            name,
                            inputStr,
                            this.visibleActionSummary(name, args),
                            askRule != null ? askRule.getPermission() : "*",
                            askRule != null ? askRule.getPattern() : "*"
                    );
                    if (!approvalResult.isGranted()) {
                        String feedback = approvalResult.getFeedback();
                        String rejectMessage = feedback == null || feedback.isBlank()
                                ? "Permission rejected by user."
                                : "Permission rejected by user: " + feedback;
                        return ToolResult.failed(rejectMessage);
                    }
                    explicitlyApproved = true;
                    break;
                case ALLOW:
                    PermissionRule allowRule = eval.getMatchedRule();
                    if (this.isShellTool(name)
                            && allowRule != null
                            && allowRule.getPermission() != null
                            && allowRule.getPermission().equals(name)
                            && allowRule.getPattern() != null
                            && !"*".equals(allowRule.getPattern())) {
                        explicitlyApproved = true;
                    }
                    break;
            }
            if (this.isShellTool(name)) {
                ProjectCommandSafety.SafetyCheck safety = ProjectCommandSafety.check(inputStr, explicitlyApproved);
                if (!safety.allowed()) {
                    if (!safety.approvalRequired()) {
                        return ToolResult.failed(safety.message());
                    }
                    PermissionService.PermissionApprovalResult approvalResult = this.requestToolApproval(
                            ctx,
                            sse,
                            conv,
                            name,
                            inputStr,
                            safety.message(),
                            name,
                            safety.matchedRule() == null || safety.matchedRule().isBlank() ? "*" : safety.matchedRule() + "*"
                    );
                    if (!approvalResult.isGranted()) {
                        String feedback = approvalResult.getFeedback();
                        return ToolResult.failed(feedback == null || feedback.isBlank()
                                ? "Permission rejected by user."
                                : "Permission rejected by user: " + feedback);
                    }
                    explicitlyApproved = true;
                }
                if (explicitlyApproved) {
                    args.addProperty("allow_dangerous", true);
                }
            }
        } catch (Exception e) {
            log.warn("Permission check failed: {}", e.getMessage());
            return ToolResult.failed("Permission check failed: " + e.getMessage());
        }
        try {
            GitSnapshotService.Snapshot beforeSnapshot = null;
            boolean snapshotCommand = this.shouldSnapshotCommandTool(name);
            if (snapshotCommand) {
                beforeSnapshot = this.gitSnapshotService.capture(ctx.getProject(), "before " + name + " task " + ctx.getTaskId());
            }
            ToolResult result = t.execute(ctx, args);
            if (snapshotCommand && result.isSuccess() && !result.isApprovalRequired()) {
                GitSnapshotService.Snapshot afterSnapshot = this.gitSnapshotService.capture(ctx.getProject(), "after " + name + " task " + ctx.getTaskId());
                List<PendingChange> changes = this.diffService.recordSnapshotDiff(ctx.getStudentId(), ctx.getProject(), ctx.getConversationId(), ctx.getTaskId(), name, beforeSnapshot, afterSnapshot);
                if (!changes.isEmpty()) {
                    this.attachSnapshotChanges(result, changes);
                }
            }
            // Auto-diagnostics after write operations
            if (result.isSuccess() && result.getDiff() != null && !result.getDiff().isBlank()
                && (name.equals("write_file") || name.equals("edit_file") || name.equals("apply_patch"))) {
                try {
                    String filePath = result.getDiff();
                    Path resolved = ToolSupport.resolve(ctx, filePath);
                    if (Files.isRegularFile(resolved)) {
                        String content = Files.readString(resolved);
                        List<DiagnosticsService.Diagnostic> diags = diagnosticsService.analyze(resolved, content);
                        if (!diags.isEmpty()) {
                            long errCount = diags.stream()
                                .filter(d -> d.getSeverity() == DiagnosticsService.DiagnosticSeverity.ERROR).count();
                            long warnCount = diags.stream()
                                .filter(d -> d.getSeverity() == DiagnosticsService.DiagnosticSeverity.WARNING).count();
                            StringBuilder diagMsg = new StringBuilder("\n\n[Auto-diagnostics] ");
                            diagMsg.append(errCount).append(" error(s), ").append(warnCount).append(" warning(s)");
                            for (DiagnosticsService.Diagnostic d : diags) {
                                diagMsg.append("\n- [").append(d.getSeverity()).append("] Line ").append(d.getLine()).append(": ").append(d.getMessage());
                            }
                            String existingContent = result.getContent();
                            result.setContent(existingContent + diagMsg.toString());
                        }
                    }
                } catch (Exception diagEx) {
                    log.debug("Auto-diagnostics failed: {}", diagEx.getMessage());
                }
            }
            return result;
        }
        catch (Exception e) {
            return ToolResult.failed((String)e.getMessage());
        }
    }

    private PermissionService.PermissionApprovalResult requestToolApproval(AgentContext ctx, AgentSsePublisher sse, AgentConversation conv, String toolName, String input, String summary, String permission, String pattern) throws Exception {
        PermissionApprovalRequest approval = permissionService.beginApproval(
                ctx.getProject().getProjectId(),
                ctx.getSessionId(),
                toolName,
                input,
                summary,
                permission,
                pattern
        );
        LinkedHashMap<String, Object> data = new LinkedHashMap<>();
        data.put("requestId", approval.getRequestId());
        data.put("sessionId", approval.getSessionId());
        data.put("toolName", approval.getToolName());
        data.put("input", approval.getInput());
        data.put("summary", approval.getSummary());
        data.put("matchedRulePermission", approval.getMatchedRulePermission());
        data.put("matchedRulePattern", approval.getMatchedRulePattern());
        data.put("createdAt", approval.getCreatedAt());
        this.sendEvent(sse, conv, "PERMISSION_ASK", data);
        return permissionService.awaitApproval(approval.getRequestId());
    }

    private boolean isShellTool(String name) {
        return "shell".equals(name) || "bash".equals(name);
    }

    private boolean shouldSnapshotCommandTool(String name) {
        return this.isShellTool(name);
    }

    private void attachSnapshotChanges(ToolResult result, List<PendingChange> changes) {
        StringBuilder diff = new StringBuilder();
        int shown = 0;
        for (PendingChange change : changes) {
            if (change.getDiff() != null && !change.getDiff().isBlank() && shown++ < 20) {
                diff.append(change.getDiff()).append('\n');
            }
        }
        if (result.getPendingChangeId() == null) {
            result.setPendingChangeId(changes.get(0).getId());
        }
        if (result.getDiff() == null || result.getDiff().isBlank()) {
            result.setDiff(this.limitForContext(diff.toString(), 60000));
        }
        String content = result.getContent() == null ? "" : result.getContent();
        result.setContent(content + "\n\n[Workspace snapshot] Recorded " + changes.size() + " file change(s). You can undo them in the Changes panel.");
    }

    private String permissionInput(String name, JsonObject args) {
        if (args == null) {
            return "";
        }
        String direct = this.firstString(args,
                "command", "cmd", "file_path", "path", "url", "query", "pattern", "name", "server");
        if (direct != null && !direct.isBlank()) {
            return direct.trim();
        }
        return args.toString();
    }

    private String firstString(JsonObject args, String... keys) {
        for (String key : keys) {
            if (args.has(key) && !args.get(key).isJsonNull()) {
                String value = args.get(key).getAsString();
                if (value != null && !value.isBlank()) {
                    return value;
                }
            }
        }
        return "";
    }

    private void sendObserve(AgentSsePublisher sse, AgentConversation conv, int i, String tn, ToolResult r, Long tid) throws Exception {
        LinkedHashMap<String, Object> o = new LinkedHashMap<String, Object>();
        if (r == null) {
            r = ToolResult.failed("Tool returned no result");
        }
        String content = this.contextManager.summarizeObservation(tn, r.getContent(), r.isSuccess());
        o.put("iteration", i);
        o.put("tool", tn);
        o.put("success", r.isSuccess());
        o.put("content", content);
        if ("create_plan".equals(tn) || "plan".equals(tn)) {
            o.put("plan", content);
        }
        if (r.getDiff() != null) {
            o.put("diff", r.getDiff());
        }
        if (r.getPendingChangeId() != null) {
            o.put("pendingChangeId", r.getPendingChangeId());
        }
        o.put("taskId", tid);
        o.put("summary", r.isSuccess() ? "Observed result from " + tn : "Tool failed: " + tn);
        this.sendEvent(sse, conv, "OBSERVE", o);
    }

    private String cleanModelOutput(String content) {
        if (content == null) {
            return "";
        }
        Object s = content;
        while (((String)s).contains("<think>")) {
            int start = ((String)s).indexOf("<think>");
            int end = ((String)s).indexOf("</think>", start);
            if (end >= 0) {
                s = ((String)s).substring(0, start) + ((String)s).substring(end + 8);
                continue;
            }
            s = ((String)s).substring(0, start);
        }
        s = ((String)s).replaceAll("</?end_turn\\s*/?>", "");
        s = ((String)s).replaceAll("(?s)<(?:minimax:)?invoke[^>]*>.*?</(?:minimax:)?invoke>", "");
        s = ((String)s).replaceAll("<(?:minimax:)?invoke[^>]*/?>", "");
        s = ((String)s).replaceAll("(?s)<(?:minimax:)?tool_call[^>]*>.*", "");
        return ((String)s).trim();
    }

    private boolean isRecoverableModelError(String message) {
        if (message == null) {
            return false;
        }
        String lower = message.toLowerCase(Locale.ROOT);
        return lower.contains("timed out") || lower.contains("timeout") || lower.contains("temporarily unavailable") || lower.contains("connection reset") || lower.contains("handshake") || lower.contains("remote host terminated") || lower.contains("connection aborted") || lower.contains("connection closed") || lower.contains("ssl") || lower.contains("tls") || lower.contains("eof") || lower.contains("503") || lower.contains("502") || lower.contains("504") || lower.contains("rate limit") || lower.contains("too many requests");
    }

    // Stream-based LLM call — sends thinking in real-time via SSE
    private Map<String, Object> chatStreaming(AgentSsePublisher sse, AgentConversation conv,
                                               String sysPrompt, List<Map<String, Object>> msgs,
                                               List<Map<String, Object>> tools, LlmProvider provider,
                                               LlmProvider.LlmConfig config,
                                               int iteration, Long taskId) throws Exception {
        StringBuilder contentBuf = new StringBuilder();
        StringBuilder thinkingBuf = new StringBuilder();
        String[] toolName = {null};
        StringBuilder[] toolArgs = {new StringBuilder()};
        String[] errorMsg = {null};
        boolean[] thinkingStarted = {false};
        String thinkMsgId = "think-" + iteration + "-" + UUID.randomUUID().toString();

        provider.chatStream(sysPrompt, msgs, tools, config, chunk -> {
            try {
                if ("thinking_delta".equals(chunk.type())) {
                    if (!thinkingStarted[0]) {
                        LinkedHashMap<String, Object> start = new LinkedHashMap<>();
                        start.put("messageId", thinkMsgId);
                        start.put("iteration", iteration);
                        start.put("summary", "Analyzing problem");
                        start.put("taskId", taskId);
                        sse.send("THINK_START", start);
                        thinkingStarted[0] = true;
                    }
                    thinkingBuf.append(chunk.content());
                    String deltaChunk = chunk.content() != null ? chunk.content() : "";
                    // Send deltas in sentence-sized chunks for smoother display
                    for (String delta : this.chunkThought(deltaChunk)) {
                        sse.send("THINK_DELTA", Map.of("messageId", thinkMsgId, "delta", delta));
                        Thread.sleep(28L);
                    }
                    sse.send("THINK_DELTA", Map.of("messageId", thinkMsgId, "delta", deltaChunk));
                } else if ("text_delta".equals(chunk.type())) {
                    contentBuf.append(chunk.content());
                } else if ("tool_args_delta".equals(chunk.type())) {
                    toolName[0] = chunk.toolName();
                    toolArgs[0].append(chunk.toolArgs() != null ? chunk.toolArgs() : "");
                } else if ("error".equals(chunk.type())) {
                    errorMsg[0] = chunk.content();
                } else if ("tool_call".equals(chunk.type())) {
                    toolName[0] = chunk.toolName();
                    if (chunk.toolArgs() != null) toolArgs[0] = new StringBuilder(chunk.toolArgs());
                }
            } catch (Exception e) {
                log.warn("chatStream callback error: {}", e.getMessage());
            }
        });

        // After stream completes, finalize THINK event if thinking was streaming
        if (thinkingStarted[0]) {
            LinkedHashMap<String, Object> done = new LinkedHashMap<>();
            done.put("messageId", thinkMsgId);
            done.put("iteration", iteration);
            done.put("summary", "Thinking complete");
            done.put("content", thinkingBuf.toString());
            done.put("streaming", false);
            done.put("taskId", taskId);
            this.sendEvent(sse, conv, "THINK", done);
        }

        if (errorMsg[0] != null) {
            return Map.of("type", "error", "message", errorMsg[0], "content", contentBuf.toString(),
                    "thinking", thinkingBuf.toString());
        }

        if (toolName[0] != null) {
            return Map.of("type", "tool_call", "tool", toolName[0],
                    "arguments", toolArgs[0].toString(),
                    "thinking", thinkingBuf.toString(),
                    "content", contentBuf.toString());
        }

        String fullContent = contentBuf.toString();
        if (!fullContent.isBlank()) {
            return Map.of("type", "text", "content", fullContent,
                    "thinking", thinkingBuf.toString());
        }

        return Map.of("type", "text", "content", thinkingBuf.toString(),
                "thinking", thinkingBuf.toString());
    }

    private String extractThinking(String c) {
        return this.cleanModelOutput(c);
    }

    private boolean isPrematureFinal(String text, AgentContext ctx) {
        if (text == null || text.isBlank()) {
            return true;
        }
        String normalized = text.trim().replaceAll("\\s+", "");
        if (normalized.matches("^(next step )?operation complete[.!?]*$")) { return true; }
        if (normalized.matches("^task complete[.!?]*$")) { return true; }
        if (normalized.matches("^done[.!?]*$")) { return true; }
        if (normalized.matches("^(ok|okay|OK|good|great|done|finished).*")) { return true; }
        if (normalized.length() < 50 && ctx != null && this.hasOpenPlan(ctx)) {
            return true;
        }
        if (ctx != null && this.hasOpenPlan(ctx)) {
            if (!(text.contains("##") || text.contains("complete") || text.contains("modified") || text.contains("file") || text.contains("Summary"))) {
                return true;
            }
            if (text.length() < 80 && !text.contains("## Summary")) {
                return true;
            }
        }
        return false;
    }

    private boolean hasOpenPlan(AgentContext ctx) {
        if (ctx.getPlan() == null || ctx.getPlan().isEmpty()) {
            return false;
        }
        return ctx.getPlan().stream().anyMatch(item -> !item.isCompleted());
    }

    private String buildContinuationInstruction(AgentContext ctx) {
        String plan;
        String string = plan = ctx == null ? "" : ctx.getPlanSummary();
        if (plan == null || plan.isBlank()) {
            return "Task not started! Do not output plain text ending. Create a plan with create_plan first, then execute step by step with tools.";
        }
        return "Task not done! Do not output plain text ending. Current plan:\n" + plan + "\nCall tools to execute next step. Only output final summary after all tasks complete and verified.";
    }

    private String buildRecoverableErrorGuidance(String errMsg, int retryCount, long delayMs) {
        return "Model connection recoverable error (attempt " + retryCount + "): " + this.limitForThought(errMsg, 180) + ". This usually means cloud handshake, proxy, TLS or temporary link interruption, not project code failure. Will wait " + delayMs + "ms then continue from existing conversation, task plan and this round's log. Will first confirm which tool steps succeeded, then resume from next unfinished action. If same step fails again, will narrow tool scope or re-read project state.";
    }

    private String buildToolDefinitions() {
        return this.toolRegistry.definitions().stream().map(d -> "- " + d.getName() + ": " + d.getDescription()).collect(Collectors.joining("\n"));
    }

    private String readActiveFile(Integer studentId, Integer projectId, String activePath) {
        if (activePath == null || activePath.isBlank()) {
            return "";
        }
        try {
            return this.studentProjectService.readProjectFile(studentId, projectId, activePath);
        }
        catch (Exception e) {
            return "Unable to read active file: " + e.getMessage();
        }
    }

    private void sendThought(AgentSsePublisher sse, AgentConversation conv, int iteration, String summary, String content, Long taskId) throws Exception {
        String messageId = "think-" + iteration + "-" + String.valueOf(UUID.randomUUID());
        LinkedHashMap<String, Object> start = new LinkedHashMap<String, Object>();
        start.put("messageId", messageId);
        start.put("iteration", iteration);
        start.put("summary", summary);
        start.put("taskId", taskId);
        sse.send("THINK_START", start);
        String safeContent = content == null ? "" : content.trim();
        for (String delta : this.chunkThought(safeContent)) {
            sse.send("THINK_DELTA", Map.of("messageId", messageId, "delta", delta));
            Thread.sleep(35L);
        }
        LinkedHashMap<String, Object> done = new LinkedHashMap<String, Object>(start);
        done.put("content", safeContent);
        done.put("streaming", false);
        this.sendEvent(sse, conv, "THINK", done);
    }

    private List<String> chunkThought(String content) {
        ArrayList<String> chunks = new ArrayList<String>();
        if (content == null || content.isEmpty()) {
            chunks.add("");
            return chunks;
        }
        int start = 0;
        while (start < content.length()) {
            int end = Math.min(content.length(), start + 96);
            int sentence = -1;
            for (int i = start + 36; i < end; ++i) {
                char ch = content.charAt(i);
                if (ch != '.' && ch != ',' && ch != '\n' && ch != ';' && ch != ':' && ch != '!' && ch != '?') continue;
                sentence = i + 1;
            }
            if (sentence > start) {
                end = sentence;
            }
            chunks.add(content.substring(start, end));
            start = end;
        }
        return chunks;
    }

    private String buildToolThought(String toolName, JsonObject args, boolean recoveredFromText) {
        String tool = this.safeTool(toolName);
        String target = this.toolTarget(tool, args);
        String readable = target.isBlank() ? tool : target;
        if (recoveredFromText) {
            return "Model didn't use standard tool format, but I detected tool intent from text. Executing: " + readable + ".";
        }
        if (this.isWriteAction(tool)) {
            String[] writeVariants = {
                "Need to modify " + readable + ". Will write the changes now.",
                "File " + readable + " needs updating. Writing changes...",
                "Applying changes to " + readable + ".",
                "Writing to " + readable + " with the required modifications."
            };
            return writeVariants[(int)(System.nanoTime() % writeVariants.length)];
        }
        if (this.isVerificationAction(tool)) {
            String[] verifyVariants = {
                "Running " + readable + " to verify the changes work correctly.",
                "Testing with " + readable + " to confirm the fix.",
                "Verification step: executing " + readable + ".",
                "Validating results by running " + readable + "."
            };
            return verifyVariants[(int)(System.nanoTime() % verifyVariants.length)];
        }
        return switch (tool) {
            case "list_files", "glob" -> "Checking project structure with " + readable + " to locate target files.";
            case "read_file", "read" -> "Reading " + readable + " to understand current content before editing.";
            case "search_code", "codesearch", "grep" -> "Searching for " + readable + " to find relevant code locations.";
            case "create_plan", "plan", "todo_write", "todowrite", "todo" -> "Breaking down the task into actionable steps with a plan.";
            default -> "Executing " + readable + " to proceed with the task.";
        };
    }

    private String buildResultThought(String toolName, JsonObject args, ToolResult result) {
        String tool = this.safeTool(toolName);
        String target = this.toolTarget(tool, args);
        String content = result == null ? "" : result.getContent();
        String compact = this.limitForThought(content, 180);
        if (result == null || !result.isSuccess()) {
            String err = compact.isBlank() ? "No output" : compact;
            String[] failVariants = {
                "Command failed" + this.withTarget(target) + ": " + err + ". Will adjust approach.",
                "Error on " + this.withTarget(target) + ": " + err + ". Trying alternative.",
                "Failed to execute " + this.withTarget(target) + ". Analyzing: " + err
            };
            return failVariants[(int)(System.nanoTime() % failVariants.length)];
        }
        if (result.getPendingChangeId() != null) {
            return "File modified" + this.withTarget(target) + ". Changes applied. Will verify next.";
        }
        if (this.isWriteAction(tool)) {
            String[] writeOkVariants = {
                "Written to " + this.withTarget(target) + ". Checking result...",
                "Write complete for " + this.withTarget(target) + ". Verifying content.",
                "Updated " + this.withTarget(target) + ". Will validate the changes."
            };
            return writeOkVariants[(int)(System.nanoTime() % writeOkVariants.length)];
        }
        if (this.isVerificationAction(tool)) {
            String lower = compact.toLowerCase();
            if (lower.contains("success") || lower.contains("passed") || lower.contains("ok")) {
                return "Verification passed" + this.withTarget(target) + ". Key output: " + compact + ". Moving to next step.";
            }
            return "Verification done" + this.withTarget(target) + ": " + compact + ". Will analyze and proceed.";
        }
        return switch (tool) {
            case "list_files", "glob" -> "Checked directory" + this.withTarget(target) + ". Project structure understood.";
            case "read_file", "read" -> "Read " + this.withTarget(target) + ". Content reviewed, ready to edit.";
            case "search_code", "codesearch", "grep" -> "Search done for " + this.withTarget(target) + ". Found relevant code, will read and modify.";
            case "create_plan", "plan", "todo_write", "todowrite", "todo" -> this.planResultSentence(compact);
            default -> "Done" + this.withTarget(target) + ". Result: " + compact + ".";
        };
    }

    private String visibleActionSummary(String toolName, JsonObject args) {
        String tool = this.safeTool(toolName);
        String target = this.toolTarget(tool, args);
        if (this.isWriteAction(tool)) {
            return "Editing " + this.shortTarget(target, "file");
        }
        if (this.isVerificationAction(tool)) {
            return "Running " + this.shortTarget(target, "command");
        }
        return switch (tool) {
            case "list_files", "glob" -> "List " + this.shortTarget(target, "directory");
            case "read_file", "read" -> "Read " + this.shortTarget(target, "file");
            case "search_code", "codesearch", "grep" -> "Search " + this.shortTarget(target, "code");
            case "retrieve_context" -> "Get context";
            case "create_plan", "plan", "todo_write", "todowrite", "todo" -> "Create plan";
            default -> "Execute " + (tool.isBlank() ? "next step" : tool);
        };
    }

    private String visibleActionDetail(String toolName, JsonObject args) {
        String t;
        String tool = this.safeTool(toolName);
        String target = this.toolTarget(tool, args);
        String string = t = target.isBlank() ? tool : target;
        if (this.isWriteAction(tool)) {
            return "Edit " + t;
        }
        if (this.isVerificationAction(tool)) {
            return "Run " + t;
        }
        return switch (tool) {
            case "list_files", "glob" -> "List " + t;
            case "read_file", "read" -> "Read " + t;
            case "search_code", "codesearch", "grep" -> "Search " + t;
            case "retrieve_context" -> "Get context";
            case "create_plan", "plan", "todo_write", "todowrite", "todo" -> this.planActionSentence(args);
            default -> "Execute " + t;
        };
    }

    private String toolTarget(String toolName, JsonObject args) {
        if (args == null) {
            return "";
        }
        for (String key : List.of("path", "file_path", "relativePath", "target_file", "directory", "dir", "cwd", "pattern", "query", "command", "cmd")) {
            String value;
            if (!args.has(key) || args.get(key).isJsonNull() || (value = args.get(key).isJsonPrimitive() ? args.get(key).getAsString() : args.get(key).toString()) == null || value.isBlank()) continue;
            return value.trim();
        }
        if (("create_plan".equals(toolName) || "plan".equals(toolName)) && args.has("action")) {
            return args.get("action").getAsString();
        }
        return "";
    }

    private String planActionSentence(JsonObject args) {
        String action;
        String string = action = args != null && args.has("action") ? args.get("action").getAsString() : "create";
        if ("complete".equalsIgnoreCase(action)) {
            String index = args != null && args.has("task_index") ? args.get("task_index").getAsString() : "";
            return "Marking task " + (index.isBlank() ? "current" : index) + " as complete in the plan. Tool results confirm this step is done.";
        }
        if ("update".equalsIgnoreCase(action)) {
            return "Updating the task plan because new findings changed the order or content of subsequent steps.";
        }
        int count = args != null && args.has("tasks") && args.get("tasks").isJsonArray() ? args.getAsJsonArray("tasks").size() : 0;
        return count > 0 ? "Breaking this work into " + count + " executable tasks as a plan. Each task will have a clear verification." : "Creating an action plan before editing files.";
    }

    private String planResultSentence(String compact) {
        if (compact.contains("all tasks complete")) {
            return "All plan tasks are complete. Ready to output final summary with verification results.";
        }
        if (compact.contains("next step")) {
            return "Plan updated. Next step identified, will continue execution.";
        }
        if (compact.contains("plan created")) {
            return "Plan created with task list. Will execute each step and mark progress.";
        }
        return "Plan state updated. Continuing with next task. Summary: " + compact;
    }

    private String verificationResultSentence(String target, String compact) {
        String lower = compact.toLowerCase(Locale.ROOT);
        if (lower.contains("build success") || lower.contains("success") || lower.contains("passed") || lower.contains("ok")) {
            return "Verification passed" + this.withTarget(target) + ". Changes passed this check. Key output: " + compact + ". Will assess if more checks needed or ready for final summary.";
        }
        if (lower.contains("error") || lower.contains("failed") || lower.contains("exception")) {
            return "Verification exposed issue" + this.withTarget(target) + ". Key output: " + compact + ". Will trace this error for recovery.";
        }
        return "Verification command returned" + this.withTarget(target) + ", but no clear success/failure marker in output. Summary: " + compact;
    }

    private String readableTarget(String target, String fallback) {
        return target == null || target.isBlank() ? fallback : " `" + this.limitForThought(target, 120) + "`";
    }

    private String withTarget(String target) {
        return target == null || target.isBlank() ? "" : " (`" + this.limitForThought(target, 120) + "`)";
    }

    private String shortTarget(String target, String fallback) {
        if (target == null || target.isBlank()) {
            return fallback;
        }
        String compact = target.trim().replaceAll("\\s+", " ");
        return compact.length() <= 28 ? compact : compact.substring(0, 28) + "...";
    }

    private boolean isWriteAction(String toolName) {
        String safe = this.safeTool(toolName);
        return "write_file".equals(safe) || "write".equals(safe) || "edit_file".equals(safe) || "edit".equals(safe) || "apply_patch".equals(safe) || "patch".equals(safe);
    }

    private boolean isVerificationAction(String toolName) {
        String safe = this.safeTool(toolName);
        return "run_tests".equals(safe) || "execute_code".equals(safe) || "shell".equals(safe) || "bash".equals(safe) || "run_command".equals(safe);
    }

    private String safeTool(String toolName) {
        return toolName == null ? "" : toolName.trim();
    }

    private Path createRunLog(StudentProject project, AgentStreamRequest request) {
        try {
            Path dir = Path.of(project.getWorkspacePath(), new String[0]).toAbsolutePath().normalize().resolve(".labex").resolve("agent-logs");
            Files.createDirectories(dir, new FileAttribute[0]);
            String stamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd-HHmmss"));
            String session = request.getSessionId() == null ? UUID.randomUUID().toString() : request.getSessionId();
            String safeSession = session.replaceAll("[^a-zA-Z0-9._-]", "_");
            return dir.resolve(stamp + "-" + safeSession + ".md");
        }
        catch (Exception e) {
            log.warn("Unable to create agent run log: {}", e.getMessage());
            return null;
        }
    }

    private void appendRunLog(Path path, String text) {
        if (path == null || text == null) {
            return;
        }
        try {
            Files.writeString(path, text, StandardCharsets.UTF_8, StandardOpenOption.CREATE, StandardOpenOption.APPEND);
        }
        catch (IOException e) {
            log.warn("Unable to append agent run log {}: {}", path, e.getMessage());
        }
    }

    private void appendToolResult(Path path, ToolResult result) {
        if (result == null) {
            this.appendRunLog(path, "\n### Tool result\n\n- Status: no result\n");
            return;
        }
        this.appendRunLog(path, "\n### Tool result\n\n- Status: `" + (result.isSuccess() ? "success" : "failed") + "`\n" + (String)(result.isApprovalRequired() ? "- Approval required: `" + this.safeLogText(result.getApprovalCommand()) + "`\n" : "") + (String)(result.getPendingChangeId() != null ? "- Change record: `" + this.safeLogText(result.getPendingChangeId()) + "`\n" : "") + "\n```text\n" + this.safeLogText(this.limitForContext(result.getContent(), 6000)) + "\n```\n");
    }

    private String workspaceRelativeLogPath(StudentProject project, Path logPath) {
        if (project == null || logPath == null) {
            return "";
        }
        try {
            return Path.of(project.getWorkspacePath(), new String[0]).toAbsolutePath().normalize().relativize(logPath.toAbsolutePath().normalize()).toString().replace("\\", "/");
        }
        catch (Exception e) {
            return logPath.toString();
        }
    }

    private String safeLogText(String text) {
        return text == null ? "" : text.replace("\r", "");
    }

    private String buildStopFinal(String status, String reason, StudentProject project, Path logPath) {
        String logRef = project == null ? (logPath == null ? "" : logPath.toString()) : this.workspaceRelativeLogPath(project, logPath);
        return "## Status\n" + status + "\n\n## Stop Reason\n" + reason + "\n\n## Debug Log\n" + (logRef.isBlank() ? "No log file written this run." : "Saved to `" + logRef + "`, contains full thinking process, tool calls, observations and errors.");
    }

    private String limitForThought(String text, int max) {
        if (text == null || text.isBlank()) {
            return "";
        }
        String compact = text.trim().replaceAll("\\s+", " ");
        return compact.length() <= max ? compact : compact.substring(0, max) + "...";
    }

    private List<Map<String, Object>> buildToolsList() {
        return this.toolRegistry.definitions().stream().map(d -> {
            LinkedHashMap<String, Object> tool = new LinkedHashMap<String, Object>();
            tool.put("type", "function");
            LinkedHashMap<String, Object> fn = new LinkedHashMap<String, Object>();
            fn.put("name", d.getName());
            fn.put("description", d.getDescription());
            fn.put("parameters", d.getInputSchema());
            tool.put("function", fn);
            return tool;
        }).collect(Collectors.toList());
    }

    private void sendEvent(AgentSsePublisher sse, AgentConversation conv, String type, Object data) throws Exception {
        sse.send(type, data);
        if (conv != null) {
            this.conversationService.saveEvent(conv, type, data);
        }
    }

    private void streamFinal(AgentSsePublisher sse, AgentConversation conv, String text) throws Exception {
        StringBuilder buf = new StringBuilder();
        for (int i = 0; i < text.length(); ++i) {
            buf.append(text.charAt(i));
            if (i % 8 != 0 && i != text.length() - 1) continue;
            sse.send("FINAL_DELTA", Map.of("delta", buf.toString()));
            buf.setLength(0);
            Thread.sleep(28L);
        }
        this.sendEvent(sse, conv, "FINAL", Map.of("content", text, "summary", "Generated final response"));
    }

    private void streamFinalFromProvider(AgentSsePublisher sse, AgentConversation conv,
                                          String sysPrompt, List<Map<String, Object>> msgs,
                                          LlmProvider provider, LlmProvider.LlmConfig config) throws Exception {
        StringBuilder contentBuf = new StringBuilder();
        provider.chatStream(sysPrompt, msgs, null, config, chunk -> {
            try {
                if ("text_delta".equals(chunk.type())) {
                    contentBuf.append(chunk.content());
                    sse.send("FINAL_DELTA", Map.of("delta", chunk.content()));
                } else if ("thinking_delta".equals(chunk.type())) {
                    sse.send("THINK_DELTA", Map.of("messageId", "final-think", "delta", chunk.content()));
                } else if ("error".equals(chunk.type())) {
                    sse.send("ERROR", Map.of("message", chunk.content()));
                }
            } catch (Exception e) {
                log.warn("Stream chunk send error: {}", e.getMessage());
            }
        });
        String finalContent = contentBuf.toString();
        this.sendEvent(sse, conv, "FINAL", Map.of("content", finalContent, "summary", "Generated final response"));
    }

    private String buildModePolicy(String mode) {
        if ("plan".equals(mode)) {
            return """
<agent_mode name="plan">
You are in planning mode. Do not edit files, write files, apply patches, or run shell commands.
Use read/search/project overview tools to understand the workspace, then produce a concrete implementation plan.
</agent_mode>""";
        }
        if ("explore".equals(mode)) {
            return """
<agent_mode name="explore">
You are in exploration mode. Prefer fast read, grep, glob, project overview, web search, and diagnostics tools.
Do not modify workspace files. Return findings, options, and exact file references.
</agent_mode>""";
        }
        return """
<agent_mode name="build">
You are in build mode. You may modify files when needed, but ask for approval when a permission prompt is raised.
Keep changes scoped, verify with available checks, and report remaining risk clearly.
</agent_mode>""";
    }

    private String buildContextMessage(String projectRules, String memoryContext, String sessionContext, String recentRunLog, String checkpoint, String globalSkills, String mcpContext) {
        StringBuilder builder = new StringBuilder();
        if (projectRules != null && !projectRules.isBlank()) {
            builder.append("<project_rules file=\"Labex.md\">\n").append(this.limitForContext(projectRules, 10000)).append("\n</project_rules>\n\n");
        }
        if (globalSkills != null && !globalSkills.isBlank()) {
            builder.append(this.limitForContext(globalSkills, 16000)).append("\n");
        }
        if (mcpContext != null && !mcpContext.isBlank()) {
            builder.append(this.limitForContext(mcpContext, 12000)).append("\n");
        }
        if (memoryContext != null && !memoryContext.isBlank()) {
            builder.append("<conversation_memory isolated=\"true\">\n").append(memoryContext).append("\n</conversation_memory>\n\n");
        }
        if (recentRunLog != null && !recentRunLog.isBlank()) {
            builder.append("<latest_agent_run_log purpose=\"resume_previous_work\">\n").append(recentRunLog).append("\n</latest_agent_run_log>\n\n");
        }
        if (checkpoint != null && !checkpoint.isBlank()) {
            builder.append("<agent_checkpoint purpose=\"resume_after_disconnect_or_failure\">\n").append(checkpoint).append("\n</agent_checkpoint>\n\n");
        }
        builder.append("<session_context>\n").append(sessionContext).append("\n</session_context>");
        return builder.toString();
    }

    private String readProjectRules(Integer studentId, Integer projectId) {
        try {
            return this.studentProjectService.readProjectFile(studentId, projectId, "Labex.md");
        }
        catch (Exception ignored) {
            return "";
        }
    }

    private String readProjectIndex(Integer studentId, Integer projectId) {
        try {
            return this.studentProjectService.readProjectFile(studentId, projectId, ".labex/project-index.md");
        }
        catch (Exception ignored) {
            return "";
        }
    }

    private String readAgentCheckpoint(StudentProject project) {
        if (project == null) {
            return "";
        }
        try {
            Path path = Path.of(project.getWorkspacePath(), new String[0]).toAbsolutePath().normalize().resolve(".labex").resolve("agent-checkpoint.md");
            if (!Files.isRegularFile(path, new LinkOption[0])) {
                return "";
            }
            return this.limitForContext(Files.readString(path, StandardCharsets.UTF_8), 8000);
        }
        catch (Exception e) {
            log.warn("Unable to read agent checkpoint: {}", e.getMessage());
            return "";
        }
    }

    private void writeAgentCheckpoint(StudentProject project, AgentStreamRequest request, AgentTask task, AgentContext ctx, String status, String note, String lastTool, String lastResult, Path runLog) {
        if (project == null || request == null) {
            return;
        }
        try {
            Path dir = Path.of(project.getWorkspacePath(), new String[0]).toAbsolutePath().normalize().resolve(".labex");
            Files.createDirectories(dir, new FileAttribute[0]);
            Path checkpoint = dir.resolve("agent-checkpoint.md");
            String logRef = this.workspaceRelativeLogPath(project, runLog);
            String plan = ctx == null ? "" : ctx.getPlanSummary();
            String content = "# LabexAgent Checkpoint\n\n- updated_at: `" + String.valueOf(LocalDateTime.now()) + "`\n- status: `" + this.safeLogText(status) + "`\n- session_id: `" + this.safeLogText(request.getSessionId()) + "`\n- conversation_id: `" + this.safeLogText(request.getConversationId()) + "`\n- task_id: `" + String.valueOf(task == null ? "" : task.getTaskId()) + "`\n- user_request: " + this.safeLogText(this.limitForContext(request.getMessage(), 1200)).replace("\n", " ") + "\n- last_tool: `" + this.safeLogText(lastTool) + "`\n- run_log: `" + this.safeLogText(logRef) + "`\n\n## Resume Note\n\n" + this.safeLogText(note) + "\n\n## Current Plan\n\n" + (plan == null || plan.isBlank() ? "(no active plan recorded)" : this.safeLogText(plan)) + "\n\n## Last Result\n\n```text\n" + this.safeLogText(this.limitForContext(lastResult, 3000)) + "\n```\n\n## Resume Instruction\n\nWhen continuing this workspace, inspect the current files if needed, trust already successful tool steps, avoid repeating completed writes, and proceed from the first unfinished plan item.\n";
            Files.writeString(checkpoint, content, StandardCharsets.UTF_8, StandardOpenOption.CREATE, StandardOpenOption.TRUNCATE_EXISTING);
        }
        catch (Exception e) {
            log.warn("Unable to write agent checkpoint: {}", e.getMessage());
        }
    }

    private String compactToolResultForCheckpoint(String toolName, ToolResult result) {
        if (result == null) {
            return "Tool returned no result.";
        }
        String content = result.getContent() == null ? "" : result.getContent();
        return "success=" + result.isSuccess() + (String)(result.getPendingChangeId() == null ? "" : "\npendingChangeId=" + result.getPendingChangeId()) + (String)(result.isApprovalRequired() ? "\napprovalCommand=" + result.getApprovalCommand() : "") + "\n" + this.contextManager.compactCheckpointResult(this.safeTool(toolName), content, result.isSuccess());
    }

    /*
     * Enabled aggressive block sorting
     * Enabled unnecessary exception pruning
     * Enabled aggressive exception aggregation
     */
    private String readLatestRunLog(StudentProject project, Path currentRunLog) {
        if (project == null) {
            return "";
        }
        try {
            Path dir = Path.of(project.getWorkspacePath(), new String[0]).toAbsolutePath().normalize().resolve(".labex").resolve("agent-logs");
            if (!Files.isDirectory(dir, new LinkOption[0])) {
                return "";
            }
            try (Stream<Path> stream = Files.list(dir);){
                Optional<Path> latest = stream.filter(path -> !path.equals(currentRunLog)).filter(path -> path.getFileName().toString().endsWith(".md")).max(Comparator.comparingLong(path -> {
                    try {
                        return Files.getLastModifiedTime(path, new LinkOption[0]).toMillis();
                    }
                    catch (IOException e) {
                        return 0L;
                    }
                }));
                if (latest.isEmpty()) {
                    String string2 = "";
                    return string2;
                }
                String string = this.limitForContext(Files.readString(latest.get(), StandardCharsets.UTF_8), 12000);
                return string;
            }
        }
        catch (Exception e) {
            log.warn("Unable to read latest agent run log: {}", e.getMessage());
            return "";
        }
    }

    private String limitForContext(String text, int max) {
        if (text == null || text.isBlank()) {
            return "";
        }
        return text.length() <= max ? text : text.substring(0, max) + "\n...context truncated...";
    }

    private String compactToolResultForModel(String toolName, ToolResult result) {
        if (result == null) {
            return "";
        }
        String content = result.getContent() == null ? "" : result.getContent();
        String compact = String.valueOf(this.contextManager.compactToolResult(this.safeTool(toolName), content, result.isSuccess()));
        if (result.getPendingChangeId() != null) {
            compact = compact + "\n\nFile changes applied automatically, can revert via Changes panel.";
        }
        return compact;
    }

    private String extractToolNameFromContent(String content) {
        if (content == null) {
            return null;
        }
        String s = "name=\"";
        int i = content.indexOf(s);
        if (i < 0) {
            return null;
        }
        int e = content.indexOf("\"", i += 6);
        return e > i ? content.substring(i, e) : null;
    }

    private String extractToolArgsFromContent(String content) {
        int ne;
        int ni;
        int ps;
        if (content == null) {
            return "{}";
        }
        StringBuilder sb = new StringBuilder("{");
        boolean first = true;
        int pos = 0;
        String endTag = "</parameter>";
        while ((ps = content.indexOf("<parameter", pos)) >= 0 && (ni = content.indexOf("name=\"", ps)) >= 0 && (ne = content.indexOf("\"", ni += 6)) >= 0) {
            String pn = content.substring(ni, ne);
            int gt = content.indexOf(">", ne);
            if (gt < 0) break;
            int vs = gt + 1;
            int ve = content.indexOf(endTag, vs);
            if (ve < 0) {
                ve = content.length();
            }
            String pv = content.substring(vs, ve).trim();
            if (!first) {
                sb.append(",");
            }
            sb.append("\"").append(this.escapeJson(pn)).append("\":\"").append(this.escapeJson(pv)).append("\"");
            first = false;
            pos = ve + endTag.length();
        }
        sb.append("}");
        return sb.toString();
    }

    private String escapeJson(String s) {
        if (s == null) {
            return "";
        }
        return s.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "");
    }
}
