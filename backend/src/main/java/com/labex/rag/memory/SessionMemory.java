package com.labex.rag.memory;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.labex.entity.RagMessage;
import com.labex.entity.RagSession;
import com.labex.mapper.RagMessageMapper;
import com.labex.mapper.RagSessionMapper;
import com.labex.rag.dto.SessionDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

/**
 * Session Memory using MySQL
 * Persists chat sessions and messages to database
 */
@Slf4j
@Service
public class SessionMemory {

    private final RagSessionMapper sessionMapper;
    private final RagMessageMapper messageMapper;

    @Autowired
    public SessionMemory(RagSessionMapper sessionMapper, RagMessageMapper messageMapper) {
        this.sessionMapper = sessionMapper;
        this.messageMapper = messageMapper;
    }

    /**
     * Create a new session for user
     */
    @Transactional
    public SessionDTO createSession(String userId, String title) {
        try {
            String sessionId = UUID.randomUUID().toString().replace("-", "");
            long now = System.currentTimeMillis();

            RagSession session = new RagSession();
            session.setId(sessionId);
            session.setUserId(userId);
            session.setTitle(title != null ? title : "新会话");
            session.setCreateTime(now);
            session.setLastActiveTime(now);
            session.setMessageCount(0);

            sessionMapper.insert(session);

            log.info("Created new session: {} for user: {}", sessionId, userId);
            return toDTO(session);
        } catch (Exception e) {
            log.error("Failed to create session: {}", e.getMessage());
            return null;
        }
    }

    /**
     * Add message to session history
     */
    @Transactional
    public void addMessage(String sessionId, String role, String content) {
        try {
            RagMessage message = new RagMessage();
            message.setSessionId(sessionId);
            message.setRole(role);
            message.setContent(content);
            message.setCreateTime(System.currentTimeMillis());

            messageMapper.insert(message);

            // Update session last active time and message count
            updateSessionActivity(sessionId);
        } catch (Exception e) {
            log.error("Failed to add message: {}", e.getMessage());
        }
    }

    /**
     * Add message with sources
     */
    @Transactional
    public void addMessage(String sessionId, String role, String content, String sources) {
        try {
            RagMessage message = new RagMessage();
            message.setSessionId(sessionId);
            message.setRole(role);
            message.setContent(content);
            message.setSources(sources);
            message.setCreateTime(System.currentTimeMillis());

            messageMapper.insert(message);

            updateSessionActivity(sessionId);
        } catch (Exception e) {
            log.error("Failed to add message: {}", e.getMessage());
        }
    }

    /**
     * Get session history
     */
    public List<Map<String, Object>> getHistory(String sessionId, int limit) {
        try {
            List<RagMessage> messages = messageMapper.selectBySessionId(sessionId);

            return messages.stream()
                    .limit(limit)
                    .map(msg -> {
                        Map<String, Object> message = new HashMap<>();
                        message.put("role", msg.getRole());
                        message.put("content", msg.getContent());
                        message.put("timestamp", msg.getCreateTime());
                        message.put("sources", msg.getSources());
                        return message;
                    })
                    .collect(Collectors.toList());
        } catch (Exception e) {
            log.error("Failed to get history for session {}: {}", sessionId, e.getMessage(), e);
            return new ArrayList<>();
        }
    }

    /**
     * Get all sessions for a user
     */
    public List<SessionDTO> getUserSessions(String userId) {
        try {
            List<RagSession> sessions = sessionMapper.selectByUserIdOrderByLastActive(userId);
            return sessions.stream().map(this::toDTO).collect(Collectors.toList());
        } catch (Exception e) {
            log.error("Failed to get user sessions: {}", e.getMessage());
            return new ArrayList<>();
        }
    }

    /**
     * Get single session
     */
    public SessionDTO getSession(String sessionId) {
        try {
            RagSession session = sessionMapper.selectById(sessionId);
            return session != null ? toDTO(session) : null;
        } catch (Exception e) {
            log.error("Failed to get session: {}", e.getMessage());
            return null;
        }
    }

    /**
     * Delete session and its messages
     */
    @Transactional
    public void deleteSession(String sessionId, String userId) {
        try {
            // Verify ownership
            RagSession session = sessionMapper.selectById(sessionId);
            if (session != null && !session.getUserId().equals(userId)) {
                log.warn("User {} attempted to delete session {} owned by another user", userId, sessionId);
                return;
            }

            // Delete messages first
            messageMapper.deleteBySessionId(sessionId);

            // Delete session
            sessionMapper.deleteById(sessionId);

            log.info("Deleted session: {}", sessionId);
        } catch (Exception e) {
            log.error("Failed to delete session: {}", e.getMessage());
        }
    }

    /**
     * Clear session history (messages only)
     */
    @Transactional
    public void clearSession(String sessionId) {
        try {
            messageMapper.deleteBySessionId(sessionId);

            // Reset message count
            RagSession session = sessionMapper.selectById(sessionId);
            if (session != null) {
                session.setMessageCount(0);
                sessionMapper.updateById(session);
            }
        } catch (Exception e) {
            log.error("Failed to clear session: {}", e.getMessage());
        }
    }

    /**
     * Update session title
     */
    public void updateSessionTitle(String sessionId, String title) {
        try {
            RagSession session = sessionMapper.selectById(sessionId);
            if (session != null) {
                session.setTitle(title);
                sessionMapper.updateById(session);
            }
        } catch (Exception e) {
            log.error("Failed to update session title: {}", e.getMessage());
        }
    }

    private void updateSessionActivity(String sessionId) {
        try {
            RagSession session = sessionMapper.selectById(sessionId);
            if (session != null) {
                session.setLastActiveTime(System.currentTimeMillis());
                session.setMessageCount(session.getMessageCount() + 1);
                sessionMapper.updateById(session);
            }
        } catch (Exception e) {
            log.error("Failed to update session activity: {}", e.getMessage());
        }
    }

    private SessionDTO toDTO(RagSession session) {
        SessionDTO dto = new SessionDTO();
        dto.setSessionId(session.getId());
        dto.setUserId(session.getUserId());
        dto.setTitle(session.getTitle());
        dto.setCreateTime(session.getCreateTime());
        dto.setLastActiveTime(session.getLastActiveTime());
        dto.setMessageCount(session.getMessageCount());
        return dto;
    }

    public String generateSessionId() {
        return UUID.randomUUID().toString().replace("-", "");
    }
}