package com.labex.entity.teaching;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 评分项得分（CTL-S4）
 * 学生×评分项是业务唯一对，使用物理删除避免重新录入时的 UNIQUE 冲突。
 */
@Data
@TableName("t_scoring_score")
public class ScoringScore {

    @TableId(value = "score_id", type = IdType.AUTO)
    private Integer scoreId;

    @TableField("item_id")
    private Integer itemId;

    @TableField("student_id")
    private Integer studentId;

    @TableField("score")
    private BigDecimal score;

    /** manual / imported / calculated */
    @TableField("source")
    private String source;

    @TableField("graded_by")
    private Integer gradedBy;

    @TableField("create_time")
    private LocalDateTime createTime;

    @TableField("update_time")
    private LocalDateTime updateTime;
}
