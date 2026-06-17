package com.labex.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@TableName("t_training_set")
public class TrainingSet {

    @TableId(value = "training_set_id", type = IdType.AUTO)
    private Integer trainingSetId;

    @TableField("name")
    private String name;

    @TableField("description")
    private String description;

    @TableField("teacher_id")
    private Integer teacherId;

    @TableField("owner_student_id")
    private Integer ownerStudentId;

    @TableField("source")
    private String source;

    @TableField("state")
    private Integer state;

    @TableField("total_score")
    private Integer totalScore;

    @TableField("create_time")
    private LocalDateTime createTime;
}
