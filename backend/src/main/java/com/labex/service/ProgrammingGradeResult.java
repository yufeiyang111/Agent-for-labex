package com.labex.service;

public class ProgrammingGradeResult {
    public final int score;
    public final String status;
    public final int passedCount;
    public final int totalCount;
    public final String compileError;
    
    public ProgrammingGradeResult(int score, String status) {
        this(score, status, 0, 0, null);
    }
    public ProgrammingGradeResult(int score, String status, int passedCount, int totalCount, String compileError) {
        this.score = score; this.status = status; this.passedCount = passedCount; this.totalCount = totalCount; this.compileError = compileError;
    }
}