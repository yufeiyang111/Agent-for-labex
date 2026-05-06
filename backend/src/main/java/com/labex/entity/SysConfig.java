package com.labex.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

/**
 * 系统配置实体类
 */
@Data
@TableName("t_sys_config")
public class SysConfig {

    @TableId(value = "param")
    private String param;

    @TableField("value")
    private String value;
}
