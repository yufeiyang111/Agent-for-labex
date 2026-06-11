package com.labex.labexagent;

import com.google.gson.JsonObject;
import com.labex.entity.StudentProject;
import com.labex.labexagent.runtime.AgentContext;
import com.labex.labexagent.tool.ToolResult;
import com.labex.labexagent.tool.impl.CreatePlanTool;
import com.labex.labexagent.tool.impl.ReadFileTool;
import com.labex.service.StudentProjectService;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.io.TempDir;

import java.nio.file.Files;
import java.nio.file.Path;
import java.time.LocalDateTime;
import java.util.concurrent.*;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.IntStream;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@DisplayName("LabexAgent \u538B\u529B\u6D4B\u8BD5")
class AgentPressureTest {

    @TempDir
    Path tempDir;

    private StudentProject testProject;
    private AgentContext testContext;

    @BeforeEach
    void setUp() {
        testProject = new StudentProject();
        testProject.setProjectId(1);
        testProject.setStudentId(1);
        testProject.setProjectName("stress-test");
        testProject.setWorkspacePath(tempDir.resolve("workspace").toString());
        testProject.setStructureJson("{}");
        testProject.setFileCount(0);
        testProject.setTotalSize(0L);
        testProject.setStatus(1);
        testProject.setCreateTime(LocalDateTime.now());
        testProject.setUpdateTime(LocalDateTime.now());

        testContext = AgentContext.create(
                "session-main", 1, testProject, "conv-main", 100L
        );
    }

    // ========================================================================
    // PT-01: create_plan tool stress
    // ========================================================================
    @Nested
    @DisplayName("PT-01: create_plan \u538B\u529B\u6D4B\u8BD5")
    class CreatePlanStressTest {

        @Test
        @DisplayName("PT-01a: 30\u4efb\u52A1\u521B\u5EFA+\u5B8C\u6210")
        void createAndComplete30Tasks() throws Exception {
            CreatePlanTool tool = new CreatePlanTool();

            JsonObject createArgs = new JsonObject();
            createArgs.addProperty("action", "create");
            com.google.gson.JsonArray tasks = new com.google.gson.JsonArray();
            IntStream.range(0, 30).forEach(i -> {
                JsonObject t = new JsonObject();
                t.addProperty("title", "Task " + (i + 1));
                t.addProperty("description", "Step " + (i + 1));
                tasks.add(t);
            });
            createArgs.add("tasks", tasks);

            assertTrue(tool.execute(testContext, createArgs).isSuccess());
            assertEquals(30, testContext.getPlan().size());

            for (int i = 0; i < 30; i++) {
                JsonObject args = new JsonObject();
                args.addProperty("action", "complete");
                args.addProperty("task_index", i + 1);
                assertTrue(tool.execute(testContext, args).isSuccess(),
                        "Task " + (i + 1) + " should complete");
            }

            assertTrue(testContext.getPlan().stream()
                    .allMatch(AgentContext.PlanItem::isCompleted));
        }

        @Test
        @DisplayName("PT-01b: 100\u6B21\u91CD\u590D\u521B\u5EFA/\u91CD\u7F6E")
        void cycleCreate100Times() throws Exception {
            CreatePlanTool tool = new CreatePlanTool();
            for (int i = 0; i < 100; i++) {
                JsonObject args = new JsonObject();
                args.addProperty("action", "create");
                com.google.gson.JsonArray tasks = new com.google.gson.JsonArray();
                JsonObject t = new JsonObject();
                t.addProperty("title", "Cycle " + i);
                tasks.add(t);
                args.add("tasks", tasks);
                assertTrue(tool.execute(testContext, args).isSuccess());
            }
        }
    }

    // ========================================================================
    // PT-02: \u6587\u4EF6\u5199\u5165\u538B\u529B\u6D4B\u8BD5 (direct I/O)
    // ========================================================================
    @Nested
    @DisplayName("PT-02: \u6587\u4EF6\u5199\u5165\u538B\u529B\u6D4B\u8BD5")
    class FileWriteStressTest {

        @Test
        @DisplayName("PT-02a: 50\u5E76\u53D1\u5199\u6587\u4EF6")
        void concurrentWrite50Files() throws Exception {
            Path ws = Path.of(testProject.getWorkspacePath());
            Files.createDirectories(ws);

            int threadCount = 50;
            ExecutorService pool = Executors.newFixedThreadPool(16);
            AtomicInteger ok = new AtomicInteger(0);

            for (int i = 0; i < threadCount; i++) {
                final int idx = i;
                pool.submit(() -> {
                    try {
                        Files.writeString(ws.resolve("f-" + idx + ".txt"),
                                "data-" + idx);
                        ok.incrementAndGet();
                    } catch (Exception e) {
                        Thread.currentThread().getUncaughtExceptionHandler()
                                .uncaughtException(Thread.currentThread(), e);
                    }
                });
            }
            pool.shutdown();
            assertTrue(pool.awaitTermination(30, TimeUnit.SECONDS));
            assertEquals(threadCount, ok.get());

            try (var files = Files.list(ws)) {
                assertEquals(threadCount, files.count());
            }
        }

        @Test
        @DisplayName("PT-02b: 200\u6B21\u8FDE\u7EED\u5199")
        void sequentialWrite200Files() throws Exception {
            Path ws = Path.of(testProject.getWorkspacePath());
            Files.createDirectories(ws);

            long start = System.nanoTime();
            for (int i = 0; i < 200; i++) {
                Files.writeString(ws.resolve("seq-" + i + ".txt"),
                        "content-" + i);
            }
            long elapsed = System.nanoTime() - start;

            try (var files = Files.list(ws)) {
                assertEquals(200, files.count());
            }
            System.out.println("PT-02b: 200 files in "
                    + TimeUnit.NANOSECONDS.toMillis(elapsed) + "ms");
        }
    }

    // ========================================================================
    // PT-03: \u6587\u4EF6\u8BFB\u53D6\u538B\u529B\u6D4B\u8BD5 (ReadFileTool mocked)
    // ========================================================================
    @Nested
    @DisplayName("PT-03: read_file \u538B\u529B\u6D4B\u8BD5")
    class ReadFileStressTest {

        @Test
        @DisplayName("PT-03a: 100\u5E76\u53D1\u8BFB\u53D6")
        void concurrentRead100Files() throws Exception {
            Path ws = Path.of(testProject.getWorkspacePath());
            Files.createDirectories(ws);
            for (int i = 0; i < 100; i++)
                Files.writeString(ws.resolve("r-" + i + ".txt"), "content-" + i);

            StudentProjectService sps = mock(StudentProjectService.class);
            when(sps.readProjectFile(anyInt(), anyInt(), anyString()))
                    .thenAnswer(inv -> Files.readString(
                            ws.resolve((String) inv.getArgument(2))));

            ReadFileTool tool = new ReadFileTool(sps);
            ExecutorService pool = Executors.newFixedThreadPool(20);
            AtomicInteger ok = new AtomicInteger(0);

            for (int i = 0; i < 100; i++) {
                final int idx = i;
                pool.submit(() -> {
                    try {
                        JsonObject args = new JsonObject();
                        args.addProperty("file_path", "r-" + idx + ".txt");
                        ToolResult r = tool.execute(testContext, args);
                        if (r.isSuccess() && r.getContent().contains("content-" + idx))
                            ok.incrementAndGet();
                    } catch (Exception ignored) {}
                });
            }
            pool.shutdown();
            assertTrue(pool.awaitTermination(30, TimeUnit.SECONDS));
            assertEquals(100, ok.get());
        }
    }

    // ========================================================================
    // PT-04: \u5DE5\u5177\u94FE\u538B\u529B\u6D4B\u8BD5 (create_plan + direct I/O)
    // ========================================================================
    @Nested
    @DisplayName("PT-04: \u5DE5\u5177\u94FE\u538B\u529B\u6D4B\u8BD5")
    class ToolChainStressTest {

        @Test
        @DisplayName("PT-04a: \u6A21\u62DF\u5B8C\u6574\u9879\u76EE\u751F\u6210")
        void simulateProjectGeneration() throws Exception {
            Path ws = Path.of(testProject.getWorkspacePath());
            Files.createDirectories(ws);
            CreatePlanTool planTool = new CreatePlanTool();
            int totalFiles = 20;

            JsonObject plan = new JsonObject();
            plan.addProperty("action", "create");
            com.google.gson.JsonArray tasks = new com.google.gson.JsonArray();
            for (int i = 0; i < totalFiles; i++) {
                JsonObject t = new JsonObject();
                t.addProperty("title", "Create file " + i);
                tasks.add(t);
            }
            plan.add("tasks", tasks);
            assertTrue(planTool.execute(testContext, plan).isSuccess());

            long start = System.nanoTime();
            for (int i = 0; i < totalFiles; i++) {
                String name = "gen-" + i + ".html";
                Files.writeString(ws.resolve(name),
                        "<html><body><h1>Page " + i + "</h1></body></html>");

                JsonObject complete = new JsonObject();
                complete.addProperty("action", "complete");
                complete.addProperty("task_index", i + 1);
                assertTrue(planTool.execute(testContext, complete).isSuccess());
            }
            long elapsed = TimeUnit.NANOSECONDS.toMillis(System.nanoTime() - start);

            assertTrue(testContext.getPlan().stream()
                    .allMatch(AgentContext.PlanItem::isCompleted));
            try (var files = Files.list(ws)) {
                assertEquals(totalFiles, files.count());
            }
            assertTrue(elapsed < 30000,
                    "20 files in " + elapsed + "ms (limit 30s)");
            System.out.println("PT-04a: " + totalFiles + " files in "
                    + elapsed + "ms");
        }
    }

    // ========================================================================
    // PT-05: \u591A\u4F1A\u8BDD\u5E76\u884C\u538B\u529B\u6D4B\u8BD5
    // ========================================================================
    @Nested
    @DisplayName("PT-05: \u5E76\u884CAgent\u4F1A\u8BDD\u538B\u529B\u6D4B\u8BD5")
    class ConcurrentSessionStressTest {

        @Test
        @DisplayName("PT-05a: 10\u4F1A\u8BDD\u5E76\u884C create_plan + \u5199\u6587\u4EF6")
        void concurrentSessions10() throws Exception {
            Path base = tempDir.resolve("sessions");
            CreatePlanTool planTool = new CreatePlanTool();
            int sessions = 10;

            ExecutorService pool = Executors.newFixedThreadPool(sessions);
            AtomicInteger ok = new AtomicInteger(0);
            CountDownLatch latch = new CountDownLatch(sessions);

            for (int s = 0; s < sessions; s++) {
                final int sid = s;
                pool.submit(() -> {
                    try {
                        Path ws = Files.createDirectories(base.resolve("s" + sid));
                        StudentProject p = new StudentProject();
                        p.setProjectId(1000 + sid);
                        p.setStudentId(1);
                        p.setWorkspacePath(ws.toString());
                        p.setStructureJson("{}");
                        AgentContext ctx = AgentContext.create(
                                "sess-" + sid, 1, p, "conv-" + sid, 500L + sid);

                        JsonObject plan = new JsonObject();
                        plan.addProperty("action", "create");
                        com.google.gson.JsonArray tasks = new com.google.gson.JsonArray();
                        for (int t = 0; t < 5; t++) {
                            JsonObject task = new JsonObject();
                            task.addProperty("title",
                                    "Session-" + sid + " task-" + t);
                            tasks.add(task);
                        }
                        plan.add("tasks", tasks);
                        assertTrue(planTool.execute(ctx, plan).isSuccess());

                        for (int t = 0; t < 5; t++) {
                            Files.writeString(
                                    ws.resolve("f-" + sid + "-" + t + ".txt"),
                                    "Session-" + sid + " File-" + t);
                            JsonObject complete = new JsonObject();
                            complete.addProperty("action", "complete");
                            complete.addProperty("task_index", t + 1);
                            assertTrue(
                                    planTool.execute(ctx, complete).isSuccess());
                        }
                        ok.incrementAndGet();
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        latch.countDown();
                    }
                });
            }

            assertTrue(latch.await(60, TimeUnit.SECONDS));
            pool.shutdown();
            assertEquals(sessions, ok.get());

            for (int s = 0; s < sessions; s++) {
                Path ws = base.resolve("s" + s);
                try (var files = Files.list(ws)) {
                    assertEquals(5, files.count(),
                            "Session " + s + " should have 5 files");
                }
            }
        }
    }
}
