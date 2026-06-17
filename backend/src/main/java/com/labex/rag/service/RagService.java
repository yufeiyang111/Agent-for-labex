package com.labex.rag.service;

import com.labex.entity.Lecture;
import com.labex.rag.chunker.HierarchicalChunker;
import com.labex.rag.parser.DocumentParser;
import com.labex.rag.parser.DocumentParserFactory;
import com.labex.rag.vector.Neo4jVectorStore;
import com.labex.service.LectureService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.FileInputStream;
import java.util.List;
import java.util.UUID;

/**
 * RAG服务 - 处理讲义向量化
 */
@Slf4j
@Service
public class RagService {

    @Autowired
    private LectureService lectureService;

    @Autowired
    private DocumentParserFactory parserFactory;

    @Autowired
    private HierarchicalChunker chunker;

    @Autowired
    private Neo4jVectorStore vectorStore;

    /**
     * 初始化所有未向量化处理的讲义
     */
    public int initializeAllUnvectorized() {
        List<Lecture> unvectorizedLectures = lectureService.findUnvectorized();
        log.info("发现 {} 个未向量化讲义", unvectorizedLectures.size());

        int successCount = 0;
        for (Lecture lecture : unvectorizedLectures) {
            try {
                vectorizeLecture(lecture);
                successCount++;
            } catch (Exception e) {
                log.error("向量化讲义失败: lectureId={}, error={}", lecture.getLectureId(), e.getMessage());
                lectureService.updateVectorizedStatus(lecture.getLectureId(), 2, null);
            }
        }

        return successCount;
    }

    /**
     * 向量化单个讲义
     */
    public void vectorizeLecture(Lecture lecture) {
        try {
            // 构建文件完整路径
            String uploadPath = lectureService.getUploadPath();
            File file = new File(uploadPath + lecture.getFilePath());

            if (!file.exists()) {
                log.warn("讲义文件不存在: {}", file.getAbsolutePath());
                lectureService.updateVectorizedStatus(lecture.getLectureId(), 2, null);
                return;
            }

            // 获取解析器
            DocumentParser parser = parserFactory.getParser(lecture.getFilePath());
            if (parser == null) {
                log.warn("不支持的文件类型: {}", lecture.getFilePath());
                lectureService.updateVectorizedStatus(lecture.getLectureId(), 2, null);
                return;
            }

            // 解析文档
            String content;
            try (FileInputStream fis = new FileInputStream(file)) {
                content = parser.parse(fis, lecture.getFilePath());
            }
            if (content == null || content.isBlank()) {
                log.warn("讲义内容为空: lectureId={}", lecture.getLectureId());
                lectureService.updateVectorizedStatus(lecture.getLectureId(), 2, null);
                return;
            }

            // 文本分割
            List<String> chunks = chunker.chunk(content);
            if (chunks.isEmpty()) {
                log.warn("分割后无有效内容: lectureId={}", lecture.getLectureId());
                lectureService.updateVectorizedStatus(lecture.getLectureId(), 2, null);
                return;
            }

            // 向量入库
            String documentId = UUID.randomUUID().toString().replace("-", "");
            int chunkCount = vectorStore.storeDocument(
                    documentId,
                    lecture.getLectureName(),
                    lecture.getLectureId(),
                    lecture.getLectureType(),
                    chunks
            );

            // 更新状态
            lectureService.updateVectorizedStatus(lecture.getLectureId(), 1, documentId);
            log.info("讲义向量化成功: lectureId={}, documentId={}, chunks={}",
                    lecture.getLectureId(), documentId, chunkCount);

        } catch (Exception e) {
            log.error("向量化讲义异常: lectureId={}", lecture.getLectureId(), e);
            lectureService.updateVectorizedStatus(lecture.getLectureId(), 2, null);
            throw new RuntimeException("向量化失败: " + e.getMessage(), e);
        }
    }

    /**
     * 异步向量化单个讲义
     */
    @Async
    public void vectorizeLectureAsync(Lecture lecture) {
        vectorizeLecture(lecture);
    }

    /**
     * 删除讲义的向量
     */
    public void deleteLectureVector(String documentId) {
        if (documentId != null && !documentId.isBlank()) {
            vectorStore.deleteDocument(documentId);
            log.info("删除讲义向量: documentId={}", documentId);
        }
    }
}