package com.labex.controller.teacher;

import lombok.Data;
import java.util.List;

/**
 * Request to generate questions from lectures.
 */
@Data
public class GenerateRequest {
    /** Lecture IDs to generate questions from */
    private List<Integer> lectureIds;
    /** Approximate number of questions to generate per lecture */
    private Integer questionsPerLecture = 30;
}
