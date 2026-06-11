package com.labex.service.ai;

import com.labex.dto.ai.GenerateBatchDTO;
import com.labex.dto.ai.GeneratedQuestionDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

/**
 * 题目生成Redis缓存服务
 * 暂存生成的题目，3天后自动释放
 */
@Slf4j
@Service
public class QuestionGenerationCacheService {

    private final RedisTemplate<String, Object> redisTemplate;

    private static final String PREFIX_BATCH = "ai:question:batch:";
    private static final String PREFIX_QUESTION = "ai:question:item:";
    private static final String PREFIX_TEACHER_BATCHES = "ai:question:teacher:";
    private static final long TTL_DAYS = 3;

    @Autowired
    public QuestionGenerationCacheService(RedisTemplate<String, Object> redisTemplate) {
        this.redisTemplate = redisTemplate;
    }

    /**
     * 保存生成批次
     */
    public void saveBatch(GenerateBatchDTO batch) {
        try {
            // 设置过期时间
            batch.setExpiresAt(LocalDateTime.now().plusDays(TTL_DAYS));

            // 检查批次是否已存在（用于判断是否首次创建）
            String batchKey = PREFIX_BATCH + batch.getBatchId();
            boolean isFirstSave = !Boolean.TRUE.equals(redisTemplate.hasKey(batchKey));

            // 保存批次
            redisTemplate.opsForValue().set(batchKey, batch, TTL_DAYS, TimeUnit.DAYS);
            log.info("批次已保存到Redis: key={}, status={}, questionCount={}, isFirstSave={}",
                    batchKey, batch.getStatus(), batch.getQuestions() != null ? batch.getQuestions().size() : 0, isFirstSave);

            // 保存每个题目
            if (batch.getQuestions() != null) {
                for (GeneratedQuestionDTO question : batch.getQuestions()) {
                    String questionKey = PREFIX_QUESTION + question.getTempId();
                    redisTemplate.opsForValue().set(questionKey, question, TTL_DAYS, TimeUnit.DAYS);
                }
            }

            // 只在首次创建时将批次ID推入教师列表（避免重复记录）
            if (isFirstSave) {
                String teacherKey = PREFIX_TEACHER_BATCHES + batch.getTeacherId();
                redisTemplate.opsForList().rightPush(teacherKey, batch.getBatchId());
                redisTemplate.expire(teacherKey, TTL_DAYS, TimeUnit.DAYS);
                log.info("批次首次创建，已加入教师列表: batchId={}, teacherId={}",
                        batch.getBatchId(), batch.getTeacherId());
            }

            log.info("保存生成批次完成: batchId={}, teacherId={}, status={}",
                    batch.getBatchId(), batch.getTeacherId(), batch.getStatus());
        } catch (Exception e) {
            log.error("保存生成批次失败: {}", e.getMessage(), e);
            throw new RuntimeException("保存生成批次失败: " + e.getMessage());
        }
    }

    /**
     * 获取生成批次
     */
    public GenerateBatchDTO getBatch(String batchId) {
        try {
            String batchKey = PREFIX_BATCH + batchId;
            log.debug("从Redis获取批次: key={}", batchKey);
            Object cached = redisTemplate.opsForValue().get(batchKey);
            if (cached instanceof GenerateBatchDTO) {
                GenerateBatchDTO batch = (GenerateBatchDTO) cached;
                log.debug("批次获取成功: batchId={}, status={}", batchId, batch.getStatus());
                return batch;
            }
            log.debug("批次不存在: batchId={}, cachedType={}", batchId, cached != null ? cached.getClass().getName() : "null");
            return null;
        } catch (Exception e) {
            log.error("获取生成批次失败: batchId={}, error={}", batchId, e.getMessage());
            return null;
        }
    }

    /**
     * 获取教师的所有批次
     */
    public List<GenerateBatchDTO> getTeacherBatches(Integer teacherId) {
        try {
            String teacherKey = PREFIX_TEACHER_BATCHES + teacherId;
            List<Object> batchIds = redisTemplate.opsForList().range(teacherKey, 0, -1);

            if (batchIds == null || batchIds.isEmpty()) {
                return Collections.emptyList();
            }

            // 对batchId去重，避免历史数据中存在重复记录
            Set<String> seen = new LinkedHashSet<>();
            for (Object id : batchIds) {
                seen.add(id.toString());
            }

            return seen.stream()
                    .map(id -> getBatch(id))
                    .filter(Objects::nonNull)
                    .sorted((a, b) -> b.getStartedAt().compareTo(a.getStartedAt()))
                    .collect(Collectors.toList());
        } catch (Exception e) {
            log.error("获取教师批次列表失败: teacherId={}, error={}", teacherId, e.getMessage());
            return Collections.emptyList();
        }
    }

    /**
     * 获取单个题目
     */
    public GeneratedQuestionDTO getQuestion(String tempId) {
        try {
            String questionKey = PREFIX_QUESTION + tempId;
            Object cached = redisTemplate.opsForValue().get(questionKey);
            if (cached instanceof GeneratedQuestionDTO) {
                return (GeneratedQuestionDTO) cached;
            }
            return null;
        } catch (Exception e) {
            log.error("获取题目失败: tempId={}, error={}", tempId, e.getMessage());
            return null;
        }
    }

    /**
     * 更新题目状态
     */
    public void updateQuestionStatus(String tempId, String status) {
        try {
            GeneratedQuestionDTO question = getQuestion(tempId);
            if (question != null) {
                question.setStatus(status);
                String questionKey = PREFIX_QUESTION + tempId;
                redisTemplate.opsForValue().set(questionKey, question, TTL_DAYS, TimeUnit.DAYS);
            }
        } catch (Exception e) {
            log.error("更新题目状态失败: tempId={}, error={}", tempId, e.getMessage());
        }
    }

    /**
     * 更新题目内容（教师微调）
     */
    public void updateQuestionContent(String tempId, String question, String answer, String analysis) {
        try {
            GeneratedQuestionDTO dto = getQuestion(tempId);
            if (dto != null) {
                dto.setModifiedQuestion(question);
                dto.setModifiedAnswer(answer);
                dto.setModifiedAnalysis(analysis);
                dto.setStatus("modified");

                String questionKey = PREFIX_QUESTION + tempId;
                redisTemplate.opsForValue().set(questionKey, dto, TTL_DAYS, TimeUnit.DAYS);

                // 更新批次统计
                GenerateBatchDTO batch = getBatch(dto.getBatchId());
                if (batch != null) {
                    updateBatchStatistics(batch);
                }
            }
        } catch (Exception e) {
            log.error("更新题目内容失败: tempId={}, error={}", tempId, e.getMessage());
        }
    }

    /**
     * 标记题目为已批准
     */
    public void approveQuestion(String tempId) {
        updateQuestionStatus(tempId, "approved");
    }

    /**
     * 标记题目为已拒绝
     */
    public void rejectQuestion(String tempId) {
        updateQuestionStatus(tempId, "rejected");
    }

    /**
     * 标记题目为已持久化
     */
    public void markPersisted(String tempId, Integer questionId) {
        try {
            GeneratedQuestionDTO question = getQuestion(tempId);
            if (question != null) {
                question.setPersisted(true);
                question.setQuestionId(questionId);
                question.setStatus("persisted");

                String questionKey = PREFIX_QUESTION + tempId;
                redisTemplate.opsForValue().set(questionKey, question, TTL_DAYS, TimeUnit.DAYS);

                // 更新批次统计
                GenerateBatchDTO batch = getBatch(question.getBatchId());
                if (batch != null) {
                    updateBatchStatistics(batch);
                }
            }
        } catch (Exception e) {
            log.error("标记题目持久化失败: tempId={}, error={}", tempId, e.getMessage());
        }
    }

    /**
     * 更新批次统计信息
     */
    private void updateBatchStatistics(GenerateBatchDTO batch) {
        int reviewed = 0, approved = 0, rejected = 0, persisted = 0;

        for (GeneratedQuestionDTO q : batch.getQuestions()) {
            if (!"pending".equals(q.getStatus())) {
                reviewed++;
            }
            if ("approved".equals(q.getStatus()) || "persisted".equals(q.getStatus())) {
                approved++;
            }
            if ("rejected".equals(q.getStatus())) {
                rejected++;
            }
            if (Boolean.TRUE.equals(q.getPersisted())) {
                persisted++;
            }
        }

        batch.setReviewedCount(reviewed);
        batch.setApprovedCount(approved);
        batch.setRejectedCount(rejected);
        batch.setPersistedCount(persisted);

        // 保存更新后的批次
        String batchKey = PREFIX_BATCH + batch.getBatchId();
        redisTemplate.opsForValue().set(batchKey, batch, TTL_DAYS, TimeUnit.DAYS);
    }

    /**
     * 删除批次
     */
    public void deleteBatch(String batchId) {
        try {
            GenerateBatchDTO batch = getBatch(batchId);
            if (batch != null) {
                // 删除所有题目
                for (GeneratedQuestionDTO question : batch.getQuestions()) {
                    String questionKey = PREFIX_QUESTION + question.getTempId();
                    redisTemplate.delete(questionKey);
                }

                // 删除批次
                String batchKey = PREFIX_BATCH + batchId;
                redisTemplate.delete(batchKey);

                // 从教师列表中移除
                String teacherKey = PREFIX_TEACHER_BATCHES + batch.getTeacherId();
                redisTemplate.opsForList().remove(teacherKey, 1, batchId);

                log.info("删除生成批次: batchId={}", batchId);
            }
        } catch (Exception e) {
            log.error("删除批次失败: batchId={}, error={}", batchId, e.getMessage());
        }
    }

    /**
     * 获取批次的所有题目
     */
    public List<GeneratedQuestionDTO> getBatchQuestions(String batchId) {
        try {
            GenerateBatchDTO batch = getBatch(batchId);
            if (batch != null) {
                return batch.getQuestions();
            }
            return Collections.emptyList();
        } catch (Exception e) {
            log.error("获取批次题目失败: batchId={}, error={}", batchId, e.getMessage());
            return Collections.emptyList();
        }
    }

    /**
     * 获取待审核的题目
     */
    public List<GeneratedQuestionDTO> getPendingQuestions(String batchId) {
        return getBatchQuestions(batchId).stream()
                .filter(q -> "pending".equals(q.getStatus()))
                .collect(Collectors.toList());
    }

    /**
     * 获取已批准的题目
     */
    public List<GeneratedQuestionDTO> getApprovedQuestions(String batchId) {
        return getBatchQuestions(batchId).stream()
                .filter(q -> "approved".equals(q.getStatus()) || "persisted".equals(q.getStatus()))
                .collect(Collectors.toList());
    }

    /**
     * 检查批次是否存在
     */
    public boolean batchExists(String batchId) {
        String batchKey = PREFIX_BATCH + batchId;
        return Boolean.TRUE.equals(redisTemplate.hasKey(batchKey));
    }

    /**
     * 获取批次剩余过期时间（秒）
     */
    public Long getBatchTTL(String batchId) {
        String batchKey = PREFIX_BATCH + batchId;
        return redisTemplate.getExpire(batchKey, TimeUnit.SECONDS);
    }
}
