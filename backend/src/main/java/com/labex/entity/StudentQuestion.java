package com.labex.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

/**
 * 学生答卷记录实体类
 */
@Data
@TableName("t_student_question")
public class StudentQuestion {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField("student_id")
    private Integer studentId;

    @TableField("exam_id")
    private Integer examId;

    @TableField("question_id")
    private Integer questionId;

    @TableField("my_answer")
    private String myAnswer;

    @TableField("score")
    private Integer score;

    @TableField("is_correct")
    private Integer isCorrect;

    @TableField("fill_time")
    private LocalDateTime fillTime;

    @TableField("graded")
    private Boolean graded;
}
