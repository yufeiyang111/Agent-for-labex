package com.labex.labexagent.service;

import com.google.gson.Gson;
import com.labex.entity.AgentConversation;
import com.labex.entity.StudentProject;
import com.labex.labexagent.service.AgentCommandService;
import com.labex.labexagent.service.AgentConversationService;
import com.labex.labexagent.service.ProjectIndexService;
import com.labex.rag.config.RagConfig;
import com.labex.rag.llm.MiniMaxChat;
import com.labex.rag.llm.OllamaChat;
import com.labex.service.StudentProjectService;
import java.nio.file.FileVisitOption;
import java.nio.file.Files;
import java.nio.file.LinkOption;
import java.nio.file.Path;
import java.time.LocalDate;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.stream.Stream;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

@Service
public class AgentCommandService {
    private static final Gson GSON = new Gson();
    private static final String RULES_FILE = "Labex.md";
    private final StudentProjectService studentProjectService;
    private final AgentConversationService conversationService;
    private final ProjectIndexService projectIndexService;
    private final RagConfig ragConfig;
    private final MiniMaxChat miniMaxChat;
    private final OllamaChat ollamaChat;

    public AgentCommandService(StudentProjectService studentProjectService, AgentConversationService conversationService, ProjectIndexService projectIndexService, RagConfig ragConfig, @Lazy MiniMaxChat miniMaxChat, @Lazy OllamaChat ollamaChat) {
        this.studentProjectService = studentProjectService;
        this.conversationService = conversationService;
        this.projectIndexService = projectIndexService;
        this.ragConfig = ragConfig;
        this.miniMaxChat = miniMaxChat;
        this.ollamaChat = ollamaChat;
    }

    public Map<String, Object> runCommand(Integer studentId, Integer projectId, Map<String, String> request) {
        StudentProject project = this.requireProject(studentId, projectId);
        String message = this.value(request, "message");
        String command = this.parseCommand(this.value(request, "command"), message);
        String mode = this.value(request, "mode").isBlank() ? "agent" : this.value(request, "mode");
        AgentConversation conversation = this.conversationService.ensureConversation(studentId, project, this.value(request, "conversationId"), mode, (String)(message.isBlank() ? "/" + command : message));
        this.conversationService.saveUserMessage(conversation, (String)(message.isBlank() ? "/" + command : message));
        CommandResult commandResult = switch (command) {
            case "init" -> this.handleInit(studentId, projectId, project);
            case "index" -> this.handleIndex(studentId, projectId, project);
            case "compact" -> this.handleCompact(studentId, projectId, conversation);
            case "doctor" -> this.handleDoctor(studentId, projectId, project);
            case "context" -> this.handleContext(studentId, projectId, project, conversation);
            case "rules" -> this.handleRules(studentId, projectId, project);
            case "help", "commands" -> this.handleHelp();
            default -> throw new IllegalArgumentException("\u672a\u77e5\u6307\u4ee4 /" + command + "\u3002\u8f93\u5165 /help \u67e5\u770b\u5f53\u524d\u652f\u6301\u7684\u6307\u4ee4\u3002");
        };
        this.conversationService.saveEvent(conversation, "FINAL", Map.of("content", commandResult.content(), "summary", "\u6267\u884c /" + command + " \u6307\u4ee4"));
        return Map.of("conversationId", conversation.getConversationId(), "command", command, "path", commandResult.path(), "content", commandResult.content());
    }

    private CommandResult handleInit(Integer studentId, Integer projectId, StudentProject project) {
        String content = this.buildLabexRules(project);
        this.writeProjectFile(studentId, projectId, RULES_FILE, content);
        return new CommandResult(RULES_FILE, "\u5df2\u6839\u636e\u5f53\u524d\u9879\u76ee\u751f\u6210 `Labex.md`\u3002\u540e\u7eed\u540c\u4e00\u4f1a\u8bdd\u4f1a\u8bfb\u53d6\u8fd9\u4e2a\u89c4\u5219\u6587\u6863\uff0c\u5e76\u7ed3\u5408\u4f1a\u8bdd\u5386\u53f2\u6458\u8981\u7ee7\u7eed\u5de5\u4f5c\u3002");
    }

    private CommandResult handleIndex(Integer studentId, Integer projectId, StudentProject project) {
        String path = ".labex/project-index.md";
        String digest = this.projectIndexService.buildProjectDigest(project, "architecture entrypoints routes controllers package scripts tests").trim();
        String content = "# Project Index\n\nGenerated on " + String.valueOf(LocalDate.now()) + ".\n\nThis file is a compact project index for LabexAgent. Refresh it with `/index` when the project shape changes.\n\n" + digest + "\n";
        this.writeProjectFile(studentId, projectId, path, content);
        return new CommandResult(path, "\u5df2\u751f\u6210 `.labex/project-index.md`\u3002\u540e\u7eed\u4efb\u52a1\u4f1a\u4f18\u5148\u4f7f\u7528\u7d22\u5f15\u548c\u6309\u9700\u8bfb\u53d6\uff0c\u51cf\u5c11\u4e00\u6b21\u6027\u585e\u5165\u5927\u4e0a\u4e0b\u6587\u3002");
    }

    private CommandResult handleCompact(Integer studentId, Integer projectId, AgentConversation conversation) {
        String summary = this.conversationService.compactConversation(studentId, projectId, conversation.getConversationId());
        return new CommandResult("", "\u5df2\u538b\u7f29\u5f53\u524d\u4f1a\u8bdd\u4e0a\u4e0b\u6587\u3002\u4e4b\u540e\u540c\u4e00\u4f1a\u8bdd\u4f1a\u4f18\u5148\u8bfb\u53d6\u7cbe\u7b80\u6458\u8981\u548c\u6700\u8fd1\u5173\u952e\u4e8b\u4ef6\uff0c\u51cf\u5c11 token \u6d88\u8017\u3002\n\n\u6458\u8981\u957f\u5ea6\uff1a" + summary.length() + " \u5b57\u7b26\u3002");
    }

    private CommandResult handleDoctor(Integer studentId, Integer projectId, StudentProject project) {
        ProjectScan scan = this.scanProject(project);
        String path = ".labex/doctor.md";
        String content = "# Project Doctor\n\nGenerated on " + String.valueOf(LocalDate.now()) + ".\n\n## Detected Stack\n\n" + scan.detected() + "\n\n## Build Commands\n\n```bash\n" + this.buildCommands(scan) + "\n```\n\n## Run Commands\n\n```bash\n" + this.runCommands(scan) + "\n```\n\n## Top Level Structure\n\n```text\n" + scan.structure() + "\n```\n";
        this.writeProjectFile(studentId, projectId, path, content);
        return new CommandResult(path, "\u5df2\u751f\u6210 `.labex/doctor.md`\uff0c\u5305\u542b\u5f53\u524d\u9879\u76ee\u6280\u672f\u6808\u3001\u8fd0\u884c/\u6784\u5efa\u547d\u4ee4\u548c\u9876\u5c42\u7ed3\u6784\u3002");
    }

    private CommandResult handleContext(Integer studentId, Integer projectId, StudentProject project, AgentConversation conversation) {
        String memory = this.conversationService.buildMemoryContext(studentId, projectId, conversation.getConversationId());
        AgentConversationService.MemoryStats stats = this.conversationService.getMemoryStats(studentId, projectId, conversation.getConversationId());
        String rules = this.readFileOrEmpty(studentId, projectId, RULES_FILE);
        String index = this.readFileOrEmpty(studentId, projectId, ".labex/project-index.md");
        String checkpoint = this.readFileOrEmpty(studentId, projectId, ".labex/agent-checkpoint.md");
        String content = "\u5f53\u524d\u4f1a\u8bdd\u4e0a\u4e0b\u6587\u72b6\u6001\uff1a\n- \u4f1a\u8bdd\u8bb0\u5fc6\u7ea6 " + memory.length() + " \u5b57\u7b26\n- \u957f\u671f\u6458\u8981\u7ea6 " + stats.getEstimatedTokens() + " \u5b57\u7b26\uff0c\u6d88\u606f\u6570 " + stats.getMessageCount() + "\uff0c\u538b\u7f29\u72b6\u6001\uff1a" + (stats.isNeedsCompact() ? "\u5df2 compact" : "\u672a\u89e6\u53d1 compact") + "\n- \u5f53\u524d\u4e0a\u4e0b\u6587\u9884\u7b97\u7ea6 " + stats.getMaxTokens() + " \u5b57\u7b26\uff0c\u8d85\u8fc7\u9884\u7b97\u4f1a\u81ea\u52a8\u538b\u7f29\u65e7\u4e8b\u4ef6\u5e76\u4fdd\u7559\u6700\u8fd1\u5173\u952e\u5c3e\u90e8\n- Labex.md " + (String)(rules.isBlank() ? "\u672a\u751f\u6210" : "\u5df2\u751f\u6210\uff0c\u7ea6 " + rules.length() + " \u5b57\u7b26") + "\n- .labex/project-index.md " + (String)(index.isBlank() ? "\u672a\u751f\u6210\uff0c\u53ef\u8f93\u5165 /index \u751f\u6210" : "\u5df2\u751f\u6210\uff0c\u7ea6 " + index.length() + " \u5b57\u7b26") + "\n- .labex/agent-checkpoint.md " + (String)(checkpoint.isBlank() ? "\u672a\u751f\u6210\uff0c\u4e0b\u4e00\u6b21 Agent \u8fd0\u884c\u540e\u4f1a\u81ea\u52a8\u751f\u6210" : "\u5df2\u751f\u6210\uff0c\u7ea6 " + checkpoint.length() + " \u5b57\u7b26") + "\n- \u5f53\u524d\u7b56\u7565\uff1a\u53ea\u628a\u89c4\u5219\u6587\u4ef6\u3001\u4f1a\u8bdd\u6458\u8981\u3001\u6700\u8fd1\u5173\u952e\u4e8b\u4ef6\u3001\u6301\u4e45\u9879\u76ee\u7d22\u5f15\u548c\u5f53\u524d\u6587\u4ef6\u7247\u6bb5\u9001\u5165\u6a21\u578b\u3002\n- OpenCode \u98ce\u683c\u4f18\u5316\uff1a\u7d22\u5f15\u5df2\u5b58\u5728\u65f6\u4f18\u5148\u590d\u7528 `.labex/project-index.md`\uff0c\u907f\u514d\u6bcf\u8f6e\u91cd\u590d\u626b\u63cf\u9879\u76ee\uff1b\u65e7\u4e8b\u4ef6\u53ea\u4fdd\u7559\u6458\u8981\u548c\u6700\u8fd1\u5173\u952e\u7ed3\u679c\uff0c\u5b8c\u6574\u6587\u4ef6\u4ecd\u6309\u9700\u8bfb\u53d6\uff1b\u4e2d\u65ad\u540e\u4f18\u5148\u53c2\u8003 checkpoint \u7eed\u8dd1\u3002";
        return new CommandResult("", content);
    }

    private CommandResult handleRules(Integer studentId, Integer projectId, StudentProject project) {
        String rules = this.readFileOrEmpty(studentId, projectId, RULES_FILE);
        if (rules.isBlank()) {
            return new CommandResult("", "\u5f53\u524d\u9879\u76ee\u8fd8\u6ca1\u6709 `Labex.md`\u3002\u8f93\u5165 `/init` \u53ef\u4ee5\u6839\u636e\u9879\u76ee\u751f\u6210\u89c4\u5219\u6587\u6863\u3002");
        }
        return new CommandResult(RULES_FILE, "`Labex.md` \u5df2\u5b58\u5728\uff0c\u540e\u7eed Agent \u4f1a\u628a\u5b83\u4f5c\u4e3a\u9879\u76ee\u7ea7\u89c4\u5219\u8bfb\u53d6\u3002\u6587\u4ef6\u957f\u5ea6\uff1a" + rules.length() + " \u5b57\u7b26\u3002");
    }

    private CommandResult handleHelp() {
        return new CommandResult("", "\u5f53\u524d\u652f\u6301\u7684\u6307\u4ee4\uff1a\n\n- `/init`\uff1a\u751f\u6210\u6216\u66f4\u65b0 `Labex.md` \u9879\u76ee\u89c4\u5219\u6587\u6863\u3002\n- `/index`\uff1a\u751f\u6210 `.labex/project-index.md`\uff0c\u7ed9\u5927\u9879\u76ee\u5efa\u7acb\u7d27\u51d1\u7d22\u5f15\u3002\n- `/compact`\uff1a\u624b\u52a8\u538b\u7f29\u5f53\u524d\u4f1a\u8bdd\u4e0a\u4e0b\u6587\uff0c\u51cf\u5c11\u540e\u7eed token \u6d88\u8017\u3002\n- `/doctor`\uff1a\u751f\u6210 `.labex/doctor.md`\uff0c\u8bb0\u5f55\u9879\u76ee\u6808\u3001\u8fd0\u884c\u547d\u4ee4\u548c\u9876\u5c42\u7ed3\u6784\u3002\n- `/context`\uff1a\u67e5\u770b\u5f53\u524d\u4f1a\u8bdd\u8bb0\u5fc6\u3001\u89c4\u5219\u6587\u6863\u548c\u7d22\u5f15\u72b6\u6001\u3002\n- `/rules`\uff1a\u67e5\u770b\u9879\u76ee\u89c4\u5219\u6587\u6863\u662f\u5426\u5df2\u542f\u7528\u3002\n- `/help`\uff1a\u663e\u793a\u8fd9\u4efd\u6307\u4ee4\u8bf4\u660e\u3002\n\n\u5f00\u53d1\u5de5\u4f5c\u6d41\u6307\u4ee4\u5982 `/fix`\u3001`/test`\u3001`/review` \u4f1a\u5728\u524d\u7aef\u5c55\u5f00\u6210\u66f4\u6e05\u6670\u7684 Agent \u4efb\u52a1\u3002\n");
    }

    public Map<String, String> optimizePrompt(Integer studentId, Integer projectId, Map<String, String> request) {
        StudentProject project = this.requireProject(studentId, projectId);
        String original = this.value(request, "message");
        if (original.isBlank()) {
            throw new IllegalArgumentException("\u8bf7\u8f93\u5165\u8981\u4f18\u5316\u7684\u63d0\u793a\u8bcd");
        }
        String activePath = this.value(request, "activePath");
        String context = "\u9879\u76ee\u540d\u79f0: " + project.getProjectName() + "\n\u5f53\u524d\u6253\u5f00\u6587\u4ef6: " + (activePath.isBlank() ? "\u672a\u6307\u5b9a" : activePath) + "\n\u4f60\u7684\u4efb\u52a1\u662f: \u5206\u6790\u7528\u6237\u7684\u7f16\u7801\u610f\u56fe\uff08\u65b0\u5efa\u529f\u80fd/\u4fee\u590dBug/\u91cd\u6784/\u4ee3\u7801\u5ba1\u67e5/\u914d\u7f6e/\u5176\u4ed6\uff09\uff0c\u5c06\u539f\u59cb\u63d0\u793a\u8bcd\u91cd\u6784\u4e3a\u7ed3\u6784\u5316\u7684\u4efb\u52a1\u63cf\u8ff0\uff0c\u5305\u542b\u660e\u786e\u7684\u76ee\u6807\u3001\u53ef\u6267\u884c\u6b65\u9aa4\u3001\u7ea6\u675f\u6761\u4ef6\u548c\u9884\u671f\u7ed3\u679c\u3002";
        String system = "\u4f60\u662f LabexAgent \u7f16\u7801\u52a9\u624b\u7684\u63d0\u793a\u8bcd\u4f18\u5316\u4e13\u5bb6\u3002\n\u4f60\u7684\u4efb\u52a1\u662f\u5c06\u7528\u6237\u539f\u59cb\u63d0\u793a\u8bcd\u91cd\u6784\u4e3a\u7ed3\u6784\u5316\u3001\u53ef\u6267\u884c\u7684\u4efb\u52a1\u63cf\u8ff0\uff0c\u8ba9\u7f16\u7a0b Agent \u80fd\u51c6\u786e\u7406\u89e3\u5e76\u9ad8\u6548\u5b8c\u6210\u3002\n\n## \u4f18\u5316\u6d41\u7a0b\n1. \u610f\u56fe\u5206\u6790: \u5224\u65ad\u7528\u6237\u60f3\u505a\u4ec0\u4e48\uff08\u65b0\u5efa\u529f\u80fd / \u4fee\u590dBug / \u91cd\u6784\u4ee3\u7801 / \u4ee3\u7801\u5ba1\u67e5 / \u9879\u76ee\u914d\u7f6e / \u8c03\u8bd5 / \u5176\u4ed6\uff09\n2. \u76ee\u6807\u63d0\u70bc: \u7528\u4e00\u53e5\u8bdd\u6982\u62ec\u6838\u5fc3\u76ee\u6807\uff0c\u53bb\u9664\u5197\u4f59\u8868\u8ff0\n3. \u4efb\u52a1\u62c6\u89e3: \u5c06\u76ee\u6807\u62c6\u6210 2-5 \u4e2a\u5177\u4f53\u7684\u3001\u53ef\u9a8c\u8bc1\u7684\u5b50\u4efb\u52a1\uff0c\u6309\u6267\u884c\u987a\u5e8f\u6392\u5217\n4. \u8fb9\u754c\u5b9a\u4e49: \u660e\u786e\u54ea\u4e9b\u6587\u4ef6/\u6a21\u5757\u9700\u8981\u4fee\u6539\uff0c\u54ea\u4e9b\u4e0d\u9700\u8981\u52a8\n5. \u9a8c\u6536\u6807\u51c6: \u8bf4\u660e\u5b8c\u6210\u540e\u5e94\u8be5\u770b\u5230\u4ec0\u4e48\u7ed3\u679c\n\n## \u8f93\u51fa\u683c\u5f0f\uff08\u4e25\u683c\u9075\u5b88\uff09\n**\u76ee\u6807**: [\u4e00\u53e5\u8bdd\u6838\u5fc3\u76ee\u6807]\n**\u6d89\u53ca\u8303\u56f4**: [\u9700\u8981\u4fee\u6539\u7684\u6587\u4ef6/\u6a21\u5757\uff0c\u6839\u636e\u9879\u76ee\u540d\u548c\u5f53\u524d\u6587\u4ef6\u63a8\u65ad]\n**\u4efb\u52a1**:\n1. [\u5177\u4f53\u53ef\u6267\u884c\u6b65\u9aa4]\n2. [\u5177\u4f53\u53ef\u6267\u884c\u6b65\u9aa4]\n**\u7ea6\u675f**:\n- [\u6280\u672f\u7ea6\u675f\u5982\u6846\u67b6\u3001\u8bed\u8a00\u3001\u4e0d\u53ef\u4fee\u6539\u7684\u6587\u4ef6]\n- [\u98ce\u683c/\u6a21\u5f0f\u7ea6\u675f]\n**\u9884\u671f\u7ed3\u679c**: [\u5b8c\u6210\u540e\u7684\u5177\u4f53\u8868\u73b0\u6216\u9a8c\u8bc1\u65b9\u5f0f]\n\n## \u6838\u5fc3\u539f\u5219\n- \u7edd\u4e0d\u6dfb\u52a0\u7528\u6237\u672a\u63d0\u53ca\u7684\u529f\u80fd\u9700\u6c42\n- \u4e0d\u6539\u53d8\u7528\u6237\u6307\u5b9a\u7684\u6280\u672f\u6808\u3001\u6587\u4ef6\u8def\u5f84\u6216\u547d\u540d\u7ea6\u5b9a\n- \u4fdd\u6301\u7528\u6237\u539f\u59cb\u8bed\u8a00\uff08\u4e2d\u82f1\u6587\u4e0e\u539f\u6587\u4e00\u81f4\uff09\n- \u5373\u4f7f\u539f\u59cb\u63d0\u793a\u8bcd\u5df2\u7ecf\u5f88\u6e05\u6670\uff0c\u4e5f\u8981\u6309\u4e0a\u8ff0\u683c\u5f0f\u7ed3\u6784\u5316\u8f93\u51fa\n- \u4ec5\u8f93\u51fa\u4f18\u5316\u540e\u7684\u63d0\u793a\u8bcd\u6b63\u6587\uff0c\u4e0d\u8981\u89e3\u91ca\u3001\u4e0d\u8981\u52a0 \"\u4f18\u5316\u540e:\" \u7b49\u524d\u7f00\u3001\u4e0d\u8981\u52a0\u5f15\u53f7\u5305\u88f9\n";
        String optimized = "ollama".equalsIgnoreCase(this.ragConfig.getLlmProvider()) ? this.ollamaChat.chat(system, context, original) : this.miniMaxChat.chat(system, context, original);
        optimized = this.cleanOptimizedPrompt(optimized, original);
        return Map.of("optimizedPrompt", optimized);
    }

    private StudentProject requireProject(Integer studentId, Integer projectId) {
        StudentProject project = this.studentProjectService.getOwnedProject(studentId, projectId);
        if (project == null) {
            throw new IllegalArgumentException("Project not found");
        }
        return project;
    }

    private String buildLabexRules(StudentProject project) {
        ProjectScan scan = this.scanProject(project);
        String digest = this.projectIndexService.buildProjectDigest(project, "project rules commands architecture").trim();
        return "# Labex - Agent Instructions\n\nGenerated on %s for project `%s`.\n\n## Quick Reference\n\n**Build & Deploy**\n```bash\n%s\n```\n\n**Run Locally**\n```bash\n%s\n```\n\n## Architecture\n\n%s\n\n## Project Structure\n\n```text\n%s\n```\n\n## Agent Workflow\n\n- Treat this file as the project-level rules document for LabexAgent.\n- Use paths relative to the workspace root. Do not prefix paths with `workspace/`.\n- Read existing files before editing unless their current content is already visible in context.\n- Prefer focused edits and verify with the smallest relevant command.\n- AI-generated file changes are applied automatically; keep changes reversible through the Changes panel.\n- Keep each conversation isolated: use only this session's history plus durable project files such as `Labex.md`.\n\n## Context And Token Rules\n\n- Start from this rules file, the active file, recent conversation summary, and the generated project index.\n- Use search/list/read tools to pull only the files needed for the current task.\n- Ignore heavy generated folders such as `node_modules`, `dist`, `build`, `target`, `.git`, and caches.\n- When the project is large, build or refresh a compact index before reading many full files.\n\n## Detected Files\n\n%s\n\n## Project Index\n\n%s\n".formatted(LocalDate.now(), project.getProjectName(), this.buildCommands(scan), this.runCommands(scan), this.architecture(scan), scan.structure(), scan.detected(), this.limit(digest, 12000));
    }

    private void writeRulesFile(Integer studentId, Integer projectId, String content) {
        this.writeProjectFile(studentId, projectId, RULES_FILE, content);
    }

    private void writeProjectFile(Integer studentId, Integer projectId, String relativePath, String content) {
        String normalized = relativePath.replace('\\', '/');
        int slash = normalized.lastIndexOf(47);
        if (slash > 0) {
            String folder = normalized.substring(0, slash);
            this.ensureFolder(studentId, projectId, folder);
        }
        try {
            this.studentProjectService.readProjectFile(studentId, projectId, normalized);
        }
        catch (Exception missing) {
            String parent = slash > 0 ? normalized.substring(0, slash) : "";
            String name = slash > 0 ? normalized.substring(slash + 1) : normalized;
            this.studentProjectService.createProjectItem(studentId, projectId, parent, name, "file");
        }
        this.studentProjectService.saveProjectFile(studentId, projectId, normalized, content);
    }

    private void ensureFolder(Integer studentId, Integer projectId, String folder) {
        String[] parts = folder.split("/");
        String current = "";
        for (String part : parts) {
            if (part == null || part.isBlank()) continue;
            String next = current.isBlank() ? part : current + "/" + part;
            try {
                this.studentProjectService.createProjectItem(studentId, projectId, current, part, "directory");
            }
            catch (Exception exception) {
                // empty catch block
            }
            current = next;
        }
    }

    private String readFileOrEmpty(Integer studentId, Integer projectId, String relativePath) {
        try {
            return this.studentProjectService.readProjectFile(studentId, projectId, relativePath);
        }
        catch (Exception ignored) {
            return "";
        }
    }

    private ProjectScan scanProject(StudentProject project) {
        Path root = Path.of(project.getWorkspacePath(), new String[0]).toAbsolutePath().normalize();
        boolean hasPom = this.exists(root, "pom.xml");
        boolean hasPackage = this.exists(root, "package.json");
        boolean hasVite = this.exists(root, "vite.config.js") || this.exists(root, "vite.config.ts");
        boolean hasDockerCompose = this.exists(root, "docker-compose.yml") || this.exists(root, "docker-compose.yaml") || this.exists(root, "compose.yml");
        boolean hasRequirements = this.exists(root, "requirements.txt") || this.exists(root, "pyproject.toml");
        boolean hasSpring = this.containsFile(root, "application.yml") || this.containsFile(root, "application.properties");
        boolean hasVue = this.containsTextFile(root, "package.json", "vue");
        boolean hasReact = this.containsTextFile(root, "package.json", "react");
        boolean hasFlask = this.containsTextFile(root, "requirements.txt", "flask") || this.containsTextFile(root, "pyproject.toml", "flask");
        String structure = this.summarizeTopLevel(root);
        String detected = "- Java/Maven: " + this.yesNo(hasPom) + "\n- Spring Boot: " + this.yesNo(hasSpring) + "\n- Node package: " + this.yesNo(hasPackage) + "\n- Vite: " + this.yesNo(hasVite) + "\n- Vue: " + this.yesNo(hasVue) + "\n- React: " + this.yesNo(hasReact) + "\n- Python/Flask: " + this.yesNo(hasRequirements || hasFlask) + "\n- Docker Compose: " + this.yesNo(hasDockerCompose);
        return new ProjectScan(hasPom, hasPackage, hasVite, hasDockerCompose, hasRequirements, hasSpring, hasVue, hasReact, hasFlask, structure, detected);
    }

    private String buildCommands(ProjectScan scan) {
        StringBuilder builder = new StringBuilder();
        if (scan.hasPom()) {
            builder.append("cd backend 2>nul || cd .\nmvn clean package -DskipTests\n\n");
        }
        if (scan.hasPackage()) {
            builder.append("cd frontend 2>nul || cd .\nnpm install\nnpm run build\n\n");
        }
        if (scan.hasDockerCompose()) {
            builder.append("docker compose up -d --build\ndocker compose down\n");
        }
        if (builder.isEmpty()) {
            builder.append("# Add project-specific build commands here after inspection.\n");
        }
        return builder.toString().trim();
    }

    private String runCommands(ProjectScan scan) {
        StringBuilder builder = new StringBuilder();
        if (scan.hasPom() || scan.hasSpring()) {
            builder.append("cd backend 2>nul || cd .\nmvn spring-boot:run\n\n");
        }
        if (scan.hasPackage()) {
            builder.append("cd frontend 2>nul || cd .\nnpm run dev\n\n");
        }
        if (scan.hasFlask()) {
            builder.append("python -m flask run\n\n");
        }
        if (scan.hasDockerCompose()) {
            builder.append("docker compose up -d\n");
        }
        if (builder.isEmpty()) {
            builder.append("# Add project-specific run commands here after inspection.\n");
        }
        return builder.toString().trim();
    }

    private String architecture(ProjectScan scan) {
        String frontend = "";
        String frontendType = scan.hasVue() ? "Vue" : (scan.hasReact() ? "React" : (frontend = scan.hasPackage() ? "Node frontend" : ""));
        String backend = scan.hasSpring() ? "Spring Boot" : (scan.hasPom() ? "Java/Maven" : (scan.hasFlask() ? "Python Flask" : ""));
        StringBuilder builder = new StringBuilder();
        if (!backend.isBlank()) {
            builder.append("- Backend: ").append(backend).append('\n');
        }
        if (!frontend.isBlank()) {
            builder.append("- Frontend: ").append(frontend).append(scan.hasVite() ? " + Vite" : "").append('\n');
        }
        if (scan.hasDockerCompose()) {
            builder.append("- Deployment: Docker Compose\n");
        }
        if (builder.isEmpty()) {
            builder.append("- Inspect the project index and source tree before deciding architecture.\n");
        }
        return builder.toString().trim();
    }

    private boolean exists(Path root, String relative) {
        return Files.exists(root.resolve(relative), new LinkOption[0]);
    }

    private boolean containsFile(Path root, String fileName) {
        try {
            return Files.walk(root, 5).anyMatch(path -> Files.isRegularFile(path) && path.getFileName().toString().equalsIgnoreCase(fileName));
        } catch (Exception e) {
            return false;
        }
    }
    private boolean containsTextFile(Path root, String fileName, String needle) {
        try (Stream<Path> stream = Files.walk(root, 5, new FileVisitOption[0]);){
            Path file;
            String text;
            List<Path> files = stream.filter(path -> Files.isRegularFile(path, new LinkOption[0]) && path.getFileName().toString().equalsIgnoreCase(fileName)).limit(4L).toList();
            Iterator<Path> iterator = files.iterator();
            do {
                if (!iterator.hasNext()) return false;
            } while (!(text = Files.readString(file = iterator.next()).toLowerCase(Locale.ROOT)).contains(needle.toLowerCase(Locale.ROOT)));
            boolean bl = true;
            return bl;
        }
        catch (Exception exception) {
            // empty catch block
        }
        return false;
    }

    private String summarizeTopLevel(Path root) {
        StringBuilder builder = new StringBuilder();
        try (Stream<Path> stream = Files.list(root);){
            stream.sorted().limit(80L).forEach(path -> {
                String name = path.getFileName().toString();
                builder.append(Files.isDirectory(path, new LinkOption[0]) ? "[dir] " : "[file] ").append(name).append('\n');
            });
        }
        catch (Exception e) {
            return "(unable to read project structure)";
        }
        return builder.toString().trim();
    }

    private String parseCommand(String explicit, String message) {
        int space;
        String raw;
        String string = raw = explicit != null && !explicit.isBlank() ? explicit : message;
        if (raw == null) {
            return "";
        }
        if ((raw = raw.trim()).startsWith("/")) {
            raw = raw.substring(1);
        }
        if ((space = raw.indexOf(32)) >= 0) {
            raw = raw.substring(0, space);
        }
        return raw.toLowerCase(Locale.ROOT);
    }

    private String cleanOptimizedPrompt(String optimized, String fallback) {
        if (optimized == null || optimized.isBlank() || optimized.startsWith("LLM error:")) {
            return fallback.trim();
        }
        String text = optimized.trim();
        text = text.replaceAll("(?s)<think>.*?</think>", "").trim();
        if ((text = text.replaceAll("^```[a-zA-Z]*\\s*", "").replaceAll("\\s*```$", "").trim()).startsWith("\"") && text.endsWith("\"") || text.startsWith("'") && text.endsWith("'")) {
            text = text.substring(1, text.length() - 1).trim();
        }
        return text.isBlank() ? fallback.trim() : text;
    }

    private String value(Map<String, String> request, String key) {
        if (request == null) {
            return "";
        }
        String value = request.get(key);
        return value == null ? "" : value.trim();
    }

    private String yesNo(boolean value) {
        return value ? "yes" : "no";
    }

    private String limit(String text, int max) {
        if (text == null || text.length() <= max) {
            return text == null ? "" : text;
        }
        return text.substring(0, max) + "\n...truncated...";
    }

    public static class CommandResult {
        private final String path;
        private final String content;
        public CommandResult(String path, String content) { this.path = path; this.content = content; }
        public String path() { return path; }
        public String content() { return content; }
    }
    public static class ProjectScan {
        private final boolean hasPom;
        private final boolean hasPackage;
        private final boolean hasVite;
        private final boolean hasDockerCompose;
        private final boolean hasRequirements;
        private final boolean hasSpring;
        private final boolean hasVue;
        private final boolean hasReact;
        private final boolean hasFlask;
        private final String structure;
        private final String detected;
        public ProjectScan(boolean hasPom, boolean hasPackage, boolean hasVite, boolean hasDockerCompose, boolean hasRequirements, boolean hasSpring, boolean hasVue, boolean hasReact, boolean hasFlask, String structure, String detected) {
            this.hasPom = hasPom; this.hasPackage = hasPackage; this.hasVite = hasVite; this.hasDockerCompose = hasDockerCompose; this.hasRequirements = hasRequirements; this.hasSpring = hasSpring; this.hasVue = hasVue; this.hasReact = hasReact; this.hasFlask = hasFlask; this.structure = structure; this.detected = detected;
        }
        public boolean hasPom() { return hasPom; }
        public boolean hasPackage() { return hasPackage; }
        public boolean hasVite() { return hasVite; }
        public boolean hasDockerCompose() { return hasDockerCompose; }
        public boolean hasRequirements() { return hasRequirements; }
        public boolean hasSpring() { return hasSpring; }
        public boolean hasVue() { return hasVue; }
        public boolean hasReact() { return hasReact; }
        public boolean hasFlask() { return hasFlask; }
        public String structure() { return structure; }
        public String detected() { return detected; }
    }
}