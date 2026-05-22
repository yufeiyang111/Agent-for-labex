package com.labex.service;

public class ParsedProgramAnswer {
    public final String language;
    public final String code;
    public ParsedProgramAnswer(String language, String code) {
        this.language = language; this.code = code;
    }
}