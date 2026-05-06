package com.labex;

import com.labex.controller.teacher.GenerateRequest;
import com.labex.controller.teacher.GenerateResponse;
import com.labex.entity.Lecture;
import com.labex.rag.service.QuestionGenerationService;
import com.labex.service.LectureService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Profile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.List;

/**
 * One-time runner to populate lecture_content from .md files, then generate questions.
 * Activated with profile "generate-questions".
 *
 * Usage: mvn spring-boot:run -Dspring-boot.run.profiles=generate-questions
 */
@Slf4j
@SpringBootApplication
@Profile("generate-questions")
public class QuestionGenerationRunner implements CommandLineRunner {

    private final QuestionGenerationService questionGenerationService;
    private final LectureService lectureService;

    @Value("${upload-path:uploads}")
    private String uploadPath;

    public QuestionGenerationRunner(QuestionGenerationService questionGenerationService,
                                    LectureService lectureService) {
        this.questionGenerationService = questionGenerationService;
        this.lectureService = lectureService;
    }

    @Override
    public void run(String... args) {
        log.info("=== Starting automated question generation ===");

        // Step 1: Populate lecture_content for .md lecture files
        log.info("Step 1: Populating lecture_content from .md files...");
        populateLectureContent();

        // Step 2: Generate questions from Java + Security lectures
        Integer[] javaLectureIds = {
                85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101
        };
        Integer[] securityLectureIds = {
                1, 2, 5, 14, 15, 16, 18, 19, 25, 38, 39, 42, 44, 54, 62, 63, 66, 74, 78
        };

        Integer[] allLectureIds = Arrays.copyOf(javaLectureIds, javaLectureIds.length + securityLectureIds.length);
        System.arraycopy(securityLectureIds, 0, allLectureIds, javaLectureIds.length, securityLectureIds.length);

        log.info("Step 2: Generating questions for {} lectures", allLectureIds.length);

        GenerateRequest request = new GenerateRequest();
        request.setLectureIds(Arrays.asList(allLectureIds));
        request.setQuestionsPerLecture(30);

        GenerateResponse response = questionGenerationService.generate(request, 1);

        log.info("=== Generation Complete ===");
        log.info("Total generated: {}", response.getTotalGenerated());
        log.info("Total duplicates removed: {}", response.getTotalDuplicates());
        log.info("Total errors: {}", response.getTotalErrors());

        if (response.getLectureResults() != null) {
            response.getLectureResults().forEach(r ->
                    log.info("  [{}] {}: {} questions, types: {}",
                            r.getLectureId(), r.getLectureName(), r.getGenerated(), r.getTypeDistribution())
            );
        }

        if (response.getErrors() != null && !response.getErrors().isEmpty()) {
            log.warn("Errors:");
            response.getErrors().forEach(e -> log.warn("  - {}", e));
        }

        log.info("=== Done ===");
        System.exit(0);
    }

    /**
     * Read .md lecture files from disk and populate the lecture_content field.
     */
    private void populateLectureContent() {
        List<Lecture> allLectures = lectureService.list();
        int updated = 0;

        for (Lecture lecture : allLectures) {
            // Only process if content is empty and it's a text-based file (.md)
            if (lecture.getLectureContent() != null && !lecture.getLectureContent().isBlank()) continue;
            if (!"md".equalsIgnoreCase(lecture.getLectureFiletype())) continue;

            String filePath = lecture.getFilePath();
            if (filePath == null || filePath.isBlank()) continue;

            try {
                Path fullPath = Paths.get(uploadPath, filePath);
                if (Files.exists(fullPath)) {
                    String content = Files.readString(fullPath);
                    if (content != null && !content.isBlank()) {
                        lecture.setLectureContent(content);
                        lectureService.updateById(lecture);
                        updated++;
                        log.info("  Populated content for lecture {}: {} ({} chars)",
                                lecture.getLectureId(), lecture.getLectureName(), content.length());
                    }
                } else {
                    log.warn("  File not found: {}", fullPath);
                }
            } catch (IOException e) {
                log.warn("  Failed to read file for lecture {}: {}", lecture.getLectureId(), e.getMessage());
            }
        }
        log.info("Populated lecture_content for {} .md lectures", updated);
    }

    public static void main(String[] args) {
        SpringApplication app = new SpringApplication(QuestionGenerationRunner.class);
        app.setAdditionalProfiles("generate-questions");
        app.run(args);
    }
}
