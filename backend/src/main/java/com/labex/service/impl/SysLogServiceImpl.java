package com.labex.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.labex.entity.SysLog;
import com.labex.mapper.SysLogMapper;
import com.labex.service.SysLogService;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

/**
 * 系统日志服务实现类
 */
@Service
public class SysLogServiceImpl extends ServiceImpl<SysLogMapper, SysLog> implements SysLogService {

    @Override
    public void log(String account, Integer type, String info, String ip) {
        SysLog log = new SysLog();
        log.setAccount(account);
        log.setType(type);
        log.setInfo(info);
        log.setTime(LocalDateTime.now());
        log.setIp(ip);
        this.save(log);
    }
}
