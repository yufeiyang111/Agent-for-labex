# Windows系统安全加固

## 账户安全

### 管理员账户策略
- 重命名Administrator账户
- 设置强密码
- 创建陷阱管理员账户

### 密码策略
```
本地安全策略 → 账户策略 → 密码策略
- 密码长度最小值: 12
- 密码必须符合复杂性: 启用
- 密码最长使用时间: 90天
```

### 账户锁定策略
```
账户锁定阈值: 5次
账户锁定时间: 30分钟
```

## 服务安全

### 禁用不必要的服务
```powershell
sc config RemoteRegistry start= disabled
sc config TlntSvr start= disabled
```

## 网络安全

### 防火墙配置
```powershell
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True
```

### SMB安全
```powershell
Set-SmbServerConfiguration -EnableSMB1Protocol $false
```'