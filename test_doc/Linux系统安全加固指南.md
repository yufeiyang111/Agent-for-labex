# Linux系统安全加固指南

Linux系统安全加固是保护服务器安全的重要措施。

## 账户安全

### 1. 密码策略
- 设置强密码（包含大小写字母、数字、特殊字符）
- 定期更换密码
- 使用PAM模块强化密码策略

### 2. 账户管理
```bash
# 禁用不需要的系统账户
usermod -s /sbin/nologin apache
# 锁定账户
passwd -l guest
# 检查空密码账户
awk -F: '($2 == \"\") {print}' /etc/shadow
```

## 文件权限

### 1. 最小权限原则
```bash
chmod 640 /etc/shadow
chmod 755 /bin
```

### 2. SUID/SGID检查
```bash
find / -perm -4000 -o -perm -2000 2>/dev/null
```

## 服务安全

1. 禁用不必要的服务
2. 关闭危险的端口
3. 配置iptables/firewalld
4. 启用审计日志

## 补丁管理
定期更新系统和软件补丁'