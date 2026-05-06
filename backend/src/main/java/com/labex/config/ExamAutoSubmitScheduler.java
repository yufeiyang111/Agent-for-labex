package com.labex.config;

import com.labex.service.ExamAutoSubmitService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
@Slf4j
public class ExamAutoSubmitScheduler {

    @Autowired
    private ExamAutoSubmitService examAutoSubmitService;

    /**
     * Force-submit expired exams every minute.
     */
    @Scheduled(cron = "0 * * * * ?")
    public void forceSubmitExpiredExams() {
        int processed = examAutoSubmitService.forceSubmitExpiredExams();
        if (processed > 0) {
            log.info("Exam auto-submit scheduler processed {} student submissions", processed);
        }
    }
}

