package com.labex.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.labex.entity.SysLog;

import java.util.List;

/**
 * 系统日志服务接口
 */
public interface SysLogService extends IService<SysLog> {

    /**
     * 记录日志
     */
    void log(String account, Integer type, String info, String ip);
}
