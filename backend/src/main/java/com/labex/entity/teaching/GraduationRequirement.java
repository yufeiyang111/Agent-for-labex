package com.labex.entity.teaching;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 毕业要求（CTL-S2）
 */
@Data
@TableName("t_graduation_requirement")
public class GraduationRequirement {

    @TableId(value = "requirement_id", type = IdType.AUTO)
    private Integer requirementId;

    @TableField("code")
    private String code;

    @TableField("title")
    private String title;

    @TableField("description")
    private String description;

    @TableField("major")
    private String major;

    @TableField("create_time")
    private LocalDateTime createTime;

    @TableField("update_time")
    private LocalDateTime updateTime;

    @TableLogic
    @TableField("deleted")
    private Integer deleted;
}
