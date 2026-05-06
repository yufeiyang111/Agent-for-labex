package com.labex.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

/**
 * 学生作业答题记录表
 */
@Data
@TableName("t_student_homework_question")
public class StudentHomeworkQuestion {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField("homework_id")
    private Integer homeworkId;

    @TableField("student_id")
    private Integer studentId;

    @TableField("question_id")
    private Integer questionId;

    @TableField("my_answer")
    private String myAnswer;

    @TableField("score")
    private Integer score;

    @TableField("is_correct")
    private Integer isCorrect;

    @TableField("graded")
    private Boolean graded;

    @TableField("fill_time")
    private LocalDateTime fillTime;
}