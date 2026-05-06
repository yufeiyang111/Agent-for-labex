package com.labex.service.impl;

import com.labex.entity.QuestionTestCase;
import com.labex.service.CodeExecutionService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Slf4j
public class CodeExecutionServiceImpl implements CodeExecutionService {

    private static final long TIMEOUT_MS = 10000;
    private static final long MAX_OUTPUT_SIZE = 1024 * 50;

    /**
     * Optional execution base dir (configured in application.yml).
     * On Windows with strict AppLocker/WDAC policy, TEMP may block running generated binaries.
     */
    @Value("${code-exec.base-path:}")
    private String codeExecBasePath;

    @Override
    public Map<String, Object> executeAndGrade(String code, String language, List<QuestionTestCase> testCases) {
        Map<String, Object> result = new HashMap<>();
        int totalWeight = 0;
        int passedWeight = 0;
        List<Map<String, Object>> details = new ArrayList<>();

        boolean compileFailed = false;
        String compileError = null;

        int index = 0;
        for (QuestionTestCase tc : testCases) {
            int weight = tc.getScoreWeight() != null ? tc.getScoreWeight() : 1;
            totalWeight += weight;

            Map<String, Object> tcResult = new HashMap<>();
            tcResult.put("testCaseId", tc.getId());
            tcResult.put("name", "test_" + (tc.getSortIndex() != null ? (tc.getSortIndex() + 1) : (index + 1)));
            tcResult.put("hint", "");
            tcResult.put("weight", weight);

            if (compileFailed) {
                tcResult.put("passed", false);
                tcResult.put("resultText", "编译错误");
                tcResult.put("timeMs", 0);
                tcResult.put("memoryKb", null);
                tcResult.put("actualOutput", "");
                tcResult.put("error", compileError);
                details.add(tcResult);
                index++;
                continue;
            }

            Map<String, Object> execResult = runCode(code, language, tc.getInput());
            String actualOutput = (String) execResult.getOrDefault("output", "");
            String expectedOutput = tc.getExpectedOutput() != null ? tc.getExpectedOutput().trim() : "";

            boolean passed = actualOutput.trim().equals(expectedOutput);
            tcResult.put("passed", passed);
            tcResult.put("actualOutput", actualOutput);
            tcResult.put("timeMs", execResult.getOrDefault("timeMs", 0));
            tcResult.put("memoryKb", execResult.getOrDefault("memoryKb", 0));
            if (execResult.containsKey("error")) {
                tcResult.put("error", execResult.get("error"));
                String err = String.valueOf(execResult.get("error"));
                if (err.startsWith("Compile error:")) {
                    compileFailed = true;
                    compileError = err;
                    tcResult.put("resultText", "编译错误");
                } else if (err.startsWith("Execution timeout")) {
                    tcResult.put("resultText", "超时");
                } else if (err.startsWith("Execution error:")) {
                    tcResult.put("resultText", "运行错误");
                }
            }
            if (!tcResult.containsKey("resultText")) {
                tcResult.put("resultText", passed ? "答案正确" : "答案错误");
            }
            if (passed) {
                passedWeight += weight;
            }

            details.add(tcResult);
            index++;
        }

        int score = totalWeight > 0 ? (passedWeight * 100 / totalWeight) : 0;
        result.put("score", score);
        result.put("totalWeight", totalWeight);
        result.put("passedWeight", passedWeight);
        result.put("details", details);
        if (compileFailed) {
            result.put("compileError", compileError);
        }
        return result;
    }

    @Override
    public Map<String, Object> runCode(String code, String language, String input) {
        return runCodeInternal(code, language, input, false);
    }

    private Map<String, Object> runCodeInternal(String code, String language, String input, boolean skipConfiguredBasePath) {
        Map<String, Object> result = new HashMap<>();
        String output = "";
        String error = null;
        Path workDir = null;
        boolean isWindows = System.getProperty("os.name").toLowerCase().contains("win");

        try {
            workDir = createWorkingDirectory(skipConfiguredBasePath);

            String fileName;
            if ("java".equals(language)) {
                fileName = "Main.java";
            } else if ("c".equals(language)) {
                fileName = "main.c";
            } else {
                result.put("error", "Unsupported language: " + language);
                return result;
            }

            Path codeFile = workDir.resolve(fileName);
            Files.writeString(codeFile, code, StandardCharsets.UTF_8);

            Path inputFile = null;
            if (input != null && !input.isEmpty()) {
                inputFile = workDir.resolve("input.txt");
                Files.writeString(inputFile, input, StandardCharsets.UTF_8);
            }

            Charset processCharset = getProcessCharset(language);

            ProcessBuilder compilePb;
            if ("java".equals(language)) {
                compilePb = new ProcessBuilder("javac", fileName);
            } else {
                // Keep Chinese string literals readable in Windows MinGW runtime output.
                if (isWindows) {
                    compilePb = new ProcessBuilder("gcc", fileName, "-finput-charset=UTF-8", "-fexec-charset=UTF-8", "-o", "main.exe");
                } else {
                    compilePb = new ProcessBuilder("gcc", fileName, "-o", "main");
                }
            }
            compilePb.directory(workDir.toFile());
            compilePb.redirectErrorStream(true);

            Process compileProcess = compilePb.start();
            String compileOutput = readStream(compileProcess.getInputStream(), processCharset);
            int compileExitCode = compileProcess.waitFor();

            if (compileExitCode != 0) {
                result.put("error", "Compile error:\n" + compileOutput);
                result.put("timeMs", 0);
                result.put("memoryKb", null);
                cleanup(workDir);
                return result;
            }

            List<String> cmd;
            if ("c".equals(language)) {
                Path executablePath = isWindows ? workDir.resolve("main.exe") : workDir.resolve("main");
                if (!Files.exists(executablePath)) {
                    result.put("error", "Execution error: compiled executable not found: " + executablePath);
                    result.put("timeMs", 0);
                    result.put("memoryKb", null);
                    cleanup(workDir);
                    return result;
                }
                cmd = List.of(executablePath.toString());
            } else {
                cmd = List.of("java", "Main");
            }

            ProcessBuilder runPb = new ProcessBuilder(cmd);
            runPb.directory(workDir.toFile());
            if (inputFile != null) {
                runPb.redirectInput(inputFile.toFile());
            }
            runPb.redirectErrorStream(true);

            long startNs = System.nanoTime();
            Process runProcess = runPb.start();
            long pid = runProcess.pid();

            StringBuilder outputBuilder = new StringBuilder();
            // Best-effort memory sampling. For very fast programs we may miss it,
            // so we sample while the process is alive and do a quick query at start/end.
            final long[] maxMemoryKb = new long[] { 0 };
            try {
                Long current = queryProcessMemoryKb(pid);
                if (current != null) {
                    maxMemoryKb[0] = Math.max(maxMemoryKb[0], current);
                }
            } catch (Exception ignored) {
            }

            Thread memoryThread = new Thread(() -> {
                long deadline = System.currentTimeMillis() + TIMEOUT_MS;
                while (System.currentTimeMillis() < deadline && runProcess.isAlive()) {
                    try {
                        Long current = queryProcessMemoryKb(pid);
                        if (current != null && current > maxMemoryKb[0]) {
                            maxMemoryKb[0] = current;
                        }
                        Thread.sleep(80);
                    } catch (InterruptedException ie) {
                        Thread.currentThread().interrupt();
                        return;
                    } catch (Exception ignored) {
                        // Best-effort.
                    }
                }
            });
            memoryThread.setDaemon(true);
            memoryThread.start();

            Thread readerThread = new Thread(() -> {
                try {
                    outputBuilder.append(readStream(runProcess.getInputStream(), processCharset));
                } catch (Exception e) {
                    log.error("Read process output failed", e);
                }
            });
            readerThread.start();
            readerThread.join(TIMEOUT_MS);

            if (readerThread.isAlive()) {
                runProcess.destroy();
                result.put("error", "Execution timeout (" + (TIMEOUT_MS / 1000) + "s)");
                cleanup(workDir);
                return result;
            }

            long elapsedMs = (System.nanoTime() - startNs) / 1_000_000;
            result.put("timeMs", elapsedMs);

            try {
                memoryThread.join(200);
            } catch (InterruptedException ie) {
                Thread.currentThread().interrupt();
            }
            try {
                Long current = queryProcessMemoryKb(pid);
                if (current != null && current > maxMemoryKb[0]) {
                    maxMemoryKb[0] = current;
                }
            } catch (Exception ignored) {
            }
            result.put("memoryKb", maxMemoryKb[0] > 0 ? maxMemoryKb[0] : null);

            output = outputBuilder.toString();
            if (output.length() > MAX_OUTPUT_SIZE) {
                output = output.substring(0, (int) MAX_OUTPUT_SIZE) + "\n... (output truncated)";
            }
        } catch (Exception e) {
            log.error("Code execution error", e);
            if (isWindows && !skipConfiguredBasePath && isExecutionPolicyBlocked(e)) {
                log.warn("Execution blocked under configured base path, retrying with fallback paths");
                if (workDir != null) {
                    cleanup(workDir);
                    workDir = null;
                }
                return runCodeInternal(code, language, input, true);
            }
            error = buildExecutionErrorMessage(e, workDir);
        }

        result.put("output", output);
        if (error != null) {
            result.put("error", error);
        }
        if (workDir != null) {
            cleanup(workDir);
        }
        return result;
    }

    private Path createWorkingDirectory(boolean skipConfiguredBasePath) throws IOException {
        List<Path> candidateBases = new ArrayList<>();

        if (!skipConfiguredBasePath && codeExecBasePath != null && !codeExecBasePath.trim().isEmpty()) {
            candidateBases.add(Path.of(codeExecBasePath.trim()));
        }

        boolean isWindows = System.getProperty("os.name").toLowerCase().contains("win");
        if (isWindows) {
            String localAppData = System.getenv("LOCALAPPDATA");
            if (skipConfiguredBasePath) {
                if (localAppData != null && !localAppData.isBlank()) {
                    candidateBases.add(Path.of(localAppData, "Labex", "code_exec"));
                }
            } else {
                // Prefer project-level directory on Windows to avoid Temp path execution policy block.
                Path userDir = Path.of(System.getProperty("user.dir", ".")).toAbsolutePath().normalize();
                candidateBases.add(userDir.resolve("../code_exec").normalize());

                if (localAppData != null && !localAppData.isBlank()) {
                    candidateBases.add(Path.of(localAppData, "Labex", "code_exec"));
                }
            }
        }

        candidateBases.add(Path.of(System.getProperty("java.io.tmpdir")));

        IOException lastError = null;
        for (Path base : candidateBases) {
            try {
                Files.createDirectories(base);
                Path dir = Files.createTempDirectory(base, "code_exec_");
                log.debug("Code execution working dir: {}", dir);
                return dir;
            } catch (IOException ex) {
                lastError = ex;
                log.warn("Cannot create code execution dir under {}: {}", base, ex.getMessage());
            }
        }

        if (lastError != null) {
            throw lastError;
        }
        return Files.createTempDirectory("code_exec_");
    }

    private boolean isExecutionPolicyBlocked(Exception e) {
        if (e == null || e.getMessage() == null) {
            return false;
        }
        return e.getMessage().contains("CreateProcess error=4551");
    }

    private String buildExecutionErrorMessage(Exception e, Path workDir) {
        String message = e.getMessage() != null ? e.getMessage() : e.toString();
        if (message.contains("CreateProcess error=4551")) {
            String dir = workDir != null ? workDir.toString() : "unknown";
            return "Execution error: 应用程序控制策略阻止执行编译产物。当前执行目录: " + dir
                    + "。请将 code-exec.base-path 配置到允许执行的目录，或放宽该目录执行策略。";
        }
        return "Execution error: " + message;
    }

    private Long queryProcessMemoryKb(long pid) {
        boolean isWindows = System.getProperty("os.name").toLowerCase().contains("win");
        try {
            if (isWindows) {
                // Prefer tasklist (lighter than powershell). Output contains "Mem Usage" like "12,345 K".
                Process p = new ProcessBuilder(
                        "tasklist",
                        "/FI",
                        "PID eq " + pid,
                        "/FO",
                        "CSV",
                        "/NH"
                ).redirectErrorStream(true).start();
                String out = readStream(p.getInputStream(), StandardCharsets.UTF_8).trim();
                p.waitFor();
                if (out.isEmpty() || out.startsWith("INFO:")) return null;
                // CSV columns: "Image Name","PID","Session Name","Session#","Mem Usage"
                // We'll extract the last quoted field.
                int lastQuote = out.lastIndexOf('"');
                if (lastQuote <= 0) return null;
                int prevQuote = out.lastIndexOf('"', lastQuote - 1);
                if (prevQuote < 0) return null;
                String memField = out.substring(prevQuote + 1, lastQuote);
                String digits = memField.replaceAll("[^0-9]", "");
                if (digits.isEmpty()) return null;
                long kb = Long.parseLong(digits);
                return kb;
            } else {
                // ps rss is KB on Linux/mac.
                Process p = new ProcessBuilder("ps", "-o", "rss=", "-p", String.valueOf(pid))
                        .redirectErrorStream(true)
                        .start();
                String out = readStream(p.getInputStream(), StandardCharsets.UTF_8).trim();
                p.waitFor();
                if (out.isEmpty()) return null;
                return Long.parseLong(out);
            }
        } catch (Exception e) {
            return null;
        }
    }

    private Charset getProcessCharset(String language) {
        // C compilation already forces UTF-8 text with -finput-charset/-fexec-charset.
        return StandardCharsets.UTF_8;
    }

    private String readStream(InputStream is, Charset charset) throws IOException {
        try (BufferedReader br = new BufferedReader(new InputStreamReader(is, charset))) {
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                sb.append(line).append("\n");
            }
            return sb.toString();
        }
    }

    private void cleanup(Path dir) {
        if (dir == null) return;
        try {
            Files.walk(dir)
                    .sorted(Comparator.reverseOrder())
                    .map(Path::toFile)
                    .forEach(File::delete);
        } catch (Exception e) {
            log.error("Cleanup temp files failed", e);
        }
    }
}
