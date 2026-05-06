package com.labex.rag.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class IngestRequest {

    private String fileName;

    private String fileType;

    private String content;

    private List<String> chunks;
}
