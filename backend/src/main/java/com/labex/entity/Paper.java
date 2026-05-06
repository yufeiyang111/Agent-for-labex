package com.labex.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

/**
 * 试卷实体类
 */
@Data
@TableName("t_paper")
public class Paper {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField("no")
    private Integer no;

    @TableField("name")
    private String name;

    @TableField("description")
    private String description;

    @TableField("total_score")
    private Integer totalScore;

    @TableField("question_count")
    private Integer questionCount;

    @TableField("time")
    private LocalDateTime time;

    @TableField("teacher_id")
    private Integer teacherId;

    @TableField("state")
    private Integer state;
}
