package com.labex.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@TableName("t_exam_grading")
public class ExamGrading {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField("exam_id")
    private Integer examId;

    @TableField("student_id")
    private Integer studentId;

    @TableField("auto_graded")
    private Boolean autoGraded;

    @TableField("manual_graded")
    private Boolean manualGraded;

    @TableField("final_score")
    private Integer finalScore;

    @TableField("graded_at")
    private LocalDateTime gradedAt;

    @TableField("created_at")
    private LocalDateTime createdAt;
}