package com.labex.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@TableName("t_student_training")
public class StudentTraining {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField("training_set_id")
    private Integer trainingSetId;

    @TableField("student_id")
    private Integer studentId;

    @TableField("score")
    private Integer score;

    @TableField("total_score")
    private Integer totalScore;

    @TableField("submit_time")
    private LocalDateTime submitTime;

    @TableField("attempt_count")
    private Integer attemptCount;
}
