package com.labex.service;

public interface ExamAutoSubmitService {

    /**
     * Force-submit expired exams for students who already have saved answers.
     *
     * @return processed student-exam count
     */
    int forceSubmitExpiredExams();
}

