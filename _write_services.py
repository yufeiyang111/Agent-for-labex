
import os

base = 'D:/workfordasan/backend/src/main/java/com/labex/labexagent/service'
os.makedirs(base, exist_ok=True)

# ========== AgentConversationService.java ==========
file1 = os.path.join(base, 'AgentConversationService.java')
with open(file1, 'w', encoding='utf-8') as f:
    f.write(package com.labex.labexagent.service;

import com.labex.entity.AgentConversation;
import com.labex.entity.AgentMessage;
import com.labex.entity.StudentProject;
import com.labex.mapper.AgentConversationMapper;
import com.labex.mapper.AgentMessageMapper;
import com.labex.rag.config.RagConfig;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;
)
print('File 1 started')
