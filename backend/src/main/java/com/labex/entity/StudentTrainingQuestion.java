package com.labex.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@TableName("t_student_training_question")
public class StudentTrainingQuestion {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField("training_set_id")
    private Integer trainingSetId;

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

    @TableField("submit_time")
    private LocalDateTime submitTime;

    @TableField("judge_result")
    private String judgeResult;

    @TableField("attempt_id")
    private Integer attemptId;

    @TableField(exist = false)
    private String questionContent;

    @TableField(exist = false)
    private Integer questionType;

    @TableField(exist = false)
    private String correctAnswer;
}
