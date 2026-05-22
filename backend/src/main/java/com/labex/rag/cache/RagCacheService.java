package com.labex.rag.cache;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * RAG Redis Cache Service
 * Caches session history, sources, and lecture data in Redis
 */
@Slf4j
@Service
public class RagCacheService {

    private final RedisTemplate<String, Object> redisTemplate;

    private static final String PREFIX_HISTORY = "rag:history:";
    private static final String PREFIX_SOURCES = "rag:sources:";
    private static final String PREFIX_LECTURE = "rag:lecture:";
    private static final long HISTORY_TTL_HOURS = 24;
    private static final long SOURCES_TTL_HOURS = 24;
    private static final long LECTURE_TTL_MINUTES = 60;

    @Autowired
    public RagCacheService(RedisTemplate<String, Object> redisTemplate) {
        this.redisTemplate = redisTemplate;
    }

    /**
     * Cache session history (list of messages)
     */
    public void cacheHistory(String sessionId, List<Map<String, Object>> history) {
        try {
            String key = PREFIX_HISTORY + sessionId;
            redisTemplate.opsForValue().set(key, history, HISTORY_TTL_HOURS, TimeUnit.HOURS);
            log.debug("Cached history for session: {}, count: {}", sessionId, history.size());
        } catch (Exception e) {
            log.warn("Failed to cache history for session {}: {}", sessionId, e.getMessage());
        }
    }

    /**
     * Get cached session history
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> getCachedHistory(String sessionId) {
        try {
            String key = PREFIX_HISTORY + sessionId;
            Object cached = redisTemplate.opsForValue().get(key);
            if (cached instanceof List) {
                log.debug("Cache hit for history, session: {}", sessionId);
                return (List<Map<String, Object>>) cached;
            }
        } catch (Exception e) {
            log.warn("Failed to get cached history for session {}: {}", sessionId, e.getMessage());
        }
        return null;
    }

    /**
     * Invalidate session history cache
     */
    public void invalidateHistory(String sessionId) {
        try {
            String key = PREFIX_HISTORY + sessionId;
            redisTemplate.delete(key);
            log.debug("Invalidated history cache for session: {}", sessionId);
        } catch (Exception e) {
            log.warn("Failed to invalidate history cache for session {}: {}", sessionId, e.getMessage());
        }
    }

    /**
     * Cache sources for a specific message
     */
    public void cacheSources(String sessionId, int messageIndex, List<Map<String, Object>> sources) {
        try {
            String key = PREFIX_SOURCES + sessionId + ":" + messageIndex;
            redisTemplate.opsForValue().set(key, sources, SOURCES_TTL_HOURS, TimeUnit.HOURS);
            log.debug("Cached sources for session: {}, index: {}", sessionId, messageIndex);
        } catch (Exception e) {
            log.warn("Failed to cache sources: {}", e.getMessage());
        }
    }

    /**
     * Get cached sources for a specific message
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> getCachedSources(String sessionId, int messageIndex) {
        try {
            String key = PREFIX_SOURCES + sessionId + ":" + messageIndex;
            Object cached = redisTemplate.opsForValue().get(key);
            if (cached instanceof List) {
                return (List<Map<String, Object>>) cached;
            }
        } catch (Exception e) {
            log.warn("Failed to get cached sources: {}", e.getMessage());
        }
        return null;
    }

    /**
     * Cache lecture info
     */
    public void cacheLecture(Integer lectureId, Map<String, Object> lectureInfo) {
        try {
            String key = PREFIX_LECTURE + lectureId;
            redisTemplate.opsForValue().set(key, lectureInfo, LECTURE_TTL_MINUTES, TimeUnit.MINUTES);
        } catch (Exception e) {
            log.warn("Failed to cache lecture {}: {}", lectureId, e.getMessage());
        }
    }

    /**
     * Get cached lecture info
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> getCachedLecture(Integer lectureId) {
        try {
            String key = PREFIX_LECTURE + lectureId;
            Object cached = redisTemplate.opsForValue().get(key);
            if (cached instanceof Map) {
                return (Map<String, Object>) cached;
            }
        } catch (Exception e) {
            log.warn("Failed to get cached lecture {}: {}", lectureId, e.getMessage());
        }
        return null;
    }

    /**
     * Invalidate all caches for a session
     */
    public void invalidateSession(String sessionId) {
        try {
            invalidateHistory(sessionId);
            // Scan and delete source keys for this session
            var keys = redisTemplate.keys(PREFIX_SOURCES + sessionId + ":*");
            if (keys != null && !keys.isEmpty()) {
                redisTemplate.delete(keys);
            }
            log.debug("Invalidated all caches for session: {}", sessionId);
        } catch (Exception e) {
            log.warn("Failed to invalidate session cache {}: {}", sessionId, e.getMessage());
        }
    }
}
