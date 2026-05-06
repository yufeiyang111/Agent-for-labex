package com.labex.rag.service;

import com.labex.controller.teacher.GenerateRequest;
import com.labex.controller.teacher.GenerateResponse;
import com.labex.entity.Lecture;
import com.labex.entity.Question;
import com.labex.langchain4j.agent.GeneratedQuestion;
import com.labex.langchain4j.agent.QuestionGenerationAgent;
import com.labex.service.LectureService;
import com.google.gson.Gson;
import com.labex.service.QuestionService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * Orchestrates the end-to-end question generation pipeline:
 * read lectures → chunk content → call LLM → deduplicate → save to DB.
 */
@Slf4j
@Service
public class QuestionGenerationService {

    private static final int CHUNK_MAX_CHARS = 3000;
    private static final Gson gson = new Gson();

    private final QuestionGenerationAgent generationAgent;
    private final LectureService lectureService;
    private final QuestionService questionService;

    public QuestionGenerationService(QuestionGenerationAgent generationAgent,
                                     LectureService lectureService,
                                     QuestionService questionService) {
        this.generationAgent = generationAgent;
        this.lectureService = lectureService;
        this.questionService = questionService;
    }

    /**
     * Generate questions from the specified lectures.
     */
    public GenerateResponse generate(GenerateRequest request, Integer teacherId) {
        GenerateResponse response = new GenerateResponse();
        List<GenerateResponse.LectureResult> lectureResults = new ArrayList<>();
        List<String> globalErrors = new ArrayList<>();

        int totalGenerated = 0;
        int totalDuplicates = 0;
        int totalErrors = 0;

        List<Lecture> lectures = getLectures(request.getLectureIds(), globalErrors);

        for (Lecture lecture : lectures) {
            try {
                GenerateResponse.LectureResult result = generateForLecture(lecture, teacherId);
                lectureResults.add(result);
                totalGenerated += result.getGenerated();
                totalDuplicates += result.getDuplicates();
            } catch (Exception e) {
                log.error("Failed to generate questions for lecture {}: {}", lecture.getLectureId(), e.getMessage());
                globalErrors.add("讲义[" + lecture.getLectureName() + "]: " + e.getMessage());
                totalErrors++;
            }
        }

        response.setTotalGenerated(totalGenerated);
        response.setTotalDuplicates(totalDuplicates);
        response.setTotalErrors(totalErrors);
        response.setLectureResults(lectureResults);
        response.setErrors(globalErrors);
        return response;
    }

    /**
     * Generate questions for a single lecture.
     */
    private GenerateResponse.LectureResult generateForLecture(Lecture lecture, Integer teacherId) {
        String content = lecture.getLectureContent();
        String lectureName = lecture.getLectureName();
        Integer lectureId = lecture.getLectureId();

        if (content == null || content.isBlank()) {
            log.warn("Lecture {} has no content, skipping", lectureId);
            GenerateResponse.LectureResult result = new GenerateResponse.LectureResult();
            result.setLectureId(lectureId);
            result.setLectureName(lectureName);
            result.setGenerated(0);
            result.setDuplicates(0);
            result.setTypeDistribution(new HashMap<>());
            return result;
        }

        // Chunk content
        List<String> chunks = chunkContent(content, CHUNK_MAX_CHARS);
        log.info("Lecture {} split into {} chunks", lectureId, chunks.size());

        // Collect all generated questions across chunks
        List<GeneratedQuestion> allGenerated = new ArrayList<>();
        for (String chunk : chunks) {
            List<GeneratedQuestion> questions = generationAgent.generate(chunk, lectureName);
            allGenerated.addAll(questions);
        }

        log.info("Lecture {}: {} raw questions before dedup", lectureId, allGenerated.size());

        // Deduplicate
        List<GeneratedQuestion> deduped = deduplicate(allGenerated);
        int duplicates = allGenerated.size() - deduped.size();
        log.info("Lecture {}: {} questions after dedup ({} duplicates removed)", lectureId, deduped.size(), duplicates);

        // Save to database
        int saved = 0;
        Map<String, Integer> typeDist = new HashMap<>();
        for (GeneratedQuestion gq : deduped) {
            try {
                Question question = toQuestion(gq, teacherId);
                questionService.save(question);
                saved++;
                String typeKey = String.valueOf(gq.getType());
                typeDist.merge(typeKey, 1, Integer::sum);
            } catch (Exception e) {
                log.warn("Failed to save generated question: {}", e.getMessage());
            }
        }

        GenerateResponse.LectureResult result = new GenerateResponse.LectureResult();
        result.setLectureId(lectureId);
        result.setLectureName(lectureName);
        result.setGenerated(saved);
        result.setDuplicates(duplicates);
        result.setTypeDistribution(typeDist);
        return result;
    }

    /**
     * Load lectures by IDs, or all lectures if IDs is empty.
     */
    private List<Lecture> getLectures(List<Integer> lectureIds, List<String> errors) {
        if (lectureIds != null && !lectureIds.isEmpty()) {
            List<Lecture> lectures = lectureService.listByIds(lectureIds);
            if (lectures.size() != lectureIds.size()) {
                errors.add("部分讲义未找到，请求 " + lectureIds.size() + " 个，找到 " + lectures.size() + " 个");
            }
            return lectures;
        }
        // If no IDs provided, get all lectures for all teachers
        return lectureService.list();
    }

    /**
     * Split content into chunks of approximately maxChars characters,
     * breaking at paragraph boundaries when possible.
     */
    List<String> chunkContent(String content, int maxChars) {
        List<String> chunks = new ArrayList<>();
        if (content == null || content.isEmpty()) {
            return chunks;
        }

        // Split by double newlines (paragraphs)
        String[] paragraphs = content.split("\\n\\s*\\n");
        StringBuilder currentChunk = new StringBuilder();

        for (String para : paragraphs) {
            String trimmed = para.trim();
            if (trimmed.isEmpty()) continue;

            // If adding this paragraph exceeds the limit, save current chunk and start new one
            if (currentChunk.length() + trimmed.length() + 1 > maxChars && currentChunk.length() > 0) {
                chunks.add(currentChunk.toString().trim());
                currentChunk = new StringBuilder();
            }

            if (trimmed.length() > maxChars) {
                // Single paragraph exceeds limit, force-split by sentences
                if (currentChunk.length() > 0) {
                    chunks.add(currentChunk.toString().trim());
                    currentChunk = new StringBuilder();
                }
                chunks.addAll(forceSplit(trimmed, maxChars));
            } else {
                if (currentChunk.length() > 0) {
                    currentChunk.append("\n\n");
                }
                currentChunk.append(trimmed);
            }
        }

        if (currentChunk.length() > 0) {
            chunks.add(currentChunk.toString().trim());
        }

        return chunks;
    }

    /**
     * Force-split a long paragraph by sentences.
     */
    private List<String> forceSplit(String text, int maxChars) {
        List<String> parts = new ArrayList<>();
        String[] sentences = text.split("(?<=[。！？.!?])");
        StringBuilder part = new StringBuilder();

        for (String sentence : sentences) {
            String trimmed = sentence.trim();
            if (trimmed.isEmpty()) continue;

            if (part.length() + trimmed.length() > maxChars && part.length() > 0) {
                parts.add(part.toString().trim());
                part = new StringBuilder();
            }
            part.append(trimmed);
        }

        if (part.length() > 0) {
            parts.add(part.toString().trim());
        }

        return parts;
    }

    /**
     * Deduplicate questions based on type and text similarity.
     */
    List<GeneratedQuestion> deduplicate(List<GeneratedQuestion> questions) {
        List<GeneratedQuestion> result = new ArrayList<>();
        for (GeneratedQuestion q : questions) {
            boolean isDuplicate = false;
            for (GeneratedQuestion existing : result) {
                if (isDuplicate(q, existing)) {
                    isDuplicate = true;
                    break;
                }
            }
            if (!isDuplicate) {
                result.add(q);
            }
        }
        return result;
    }

    /**
     * Two questions are considered duplicates if they have the same type
     * and their question text similarity exceeds the threshold.
     */
    private boolean isDuplicate(GeneratedQuestion q1, GeneratedQuestion q2) {
        if (q1.getType() != q2.getType()) return false;
        if (q1.getQuestion() == null || q2.getQuestion() == null) return false;
        double similarity = textSimilarity(q1.getQuestion(), q2.getQuestion());
        return similarity > 0.85;
    }

    /**
     * Compute simple character-level similarity based on common substring ratio.
     */
    private double textSimilarity(String s1, String s2) {
        String a = s1.replaceAll("\\s+", "");
        String b = s2.replaceAll("\\s+", "");
        if (a.isEmpty() && b.isEmpty()) return 1.0;
        if (a.isEmpty() || b.isEmpty()) return 0.0;

        // Use longest common subsequence ratio
        int lcs = longestCommonSubsequence(a, b);
        return 2.0 * lcs / (a.length() + b.length());
    }

    private int longestCommonSubsequence(String a, String b) {
        int m = a.length(), n = b.length();
        if (m == 0 || n == 0) return 0;
        // Use two-row DP to save memory
        int[] prev = new int[n + 1];
        int[] curr = new int[n + 1];
        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                if (a.charAt(i - 1) == b.charAt(j - 1)) {
                    curr[j] = prev[j - 1] + 1;
                } else {
                    curr[j] = Math.max(prev[j], curr[j - 1]);
                }
            }
            int[] tmp = prev;
            prev = curr;
            curr = tmp;
        }
        return prev[n];
    }

    /**
     * Map a GeneratedQuestion to a Question entity for DB persistence.
     */
    private Question toQuestion(GeneratedQuestion gq, Integer teacherId) {
        Question q = new Question();
        q.setQuestion(gq.getQuestion());
        q.setAnswer(gq.getAnswer());
        q.setType(gq.getType());
        q.setScore(gq.getScore() != null ? gq.getScore() : 10);
        q.setAnalysis(gq.getAnalysis());
        q.setOptions(convertOptions(gq.getOptions()));
        q.setTeacherId(teacherId);
        q.setState(1);
        // For programming questions
        if (gq.getType() == 6) {
            q.setIsProgramming(1);
        }
        return q;
    }

    /**
     * Convert options from LLM response (JSON object or string) to a JSON string for DB storage.
     */
    private String convertOptions(Object options) {
        if (options == null) return null;
        if (options instanceof String) return (String) options;
        // JSON object from LLM — serialize to string
        return gson.toJson(options);
    }
}
