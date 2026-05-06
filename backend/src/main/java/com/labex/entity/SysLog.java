package com.labex.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

/**
 * 系统日志实体类
 */
@Data
@TableName("t_sys_log")
public class SysLog {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField("account")
    private String account;

    @TableField("type")
    private Integer type;

    @TableField("info")
    private String info;

    @TableField("time")
    private LocalDateTime time;

    @TableField("ip")
    private String ip;
}
