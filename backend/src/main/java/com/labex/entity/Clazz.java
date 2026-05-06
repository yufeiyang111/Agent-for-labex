package com.labex.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

/**
 * 班级实体类
 */
@Data
@TableName("t_clazz")
public class Clazz {

    @TableId(value = "no", type = IdType.INPUT)
    private String no;

    @TableField("memo")
    private String memo;

    @TableField("state")
    private Integer state;

    @TableField("teacher_id")
    private Integer teacherId;
}
