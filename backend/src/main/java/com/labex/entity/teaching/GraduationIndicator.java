package com.labex.entity.teaching;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 毕业要求指标点（CTL-S2）
 */
@Data
@TableName("t_graduation_indicator")
public class GraduationIndicator {

    @TableId(value = "indicator_id", type = IdType.AUTO)
    private Integer indicatorId;

    @TableField("requirement_id")
    private Integer requirementId;

    @TableField("code")
    private String code;

    @TableField("description")
    private String description;

    @TableField("create_time")
    private LocalDateTime createTime;

    @TableField("update_time")
    private LocalDateTime updateTime;

    @TableLogic
    @TableField("deleted")
    private Integer deleted;
}
