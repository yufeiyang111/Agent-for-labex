# Linux系统安全加固

## 用户与权限管理

### 1. 最小权限原则
- 创建专用服务账户
- 禁止root直接登录
- 使用sudo提权

### 2. SSH安全配置
```bash
# /etc/ssh/sshd_config
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
MaxAuthTries 3
```

## 文件系统安全

### 重要文件权限
```bash
chmod 600 /etc/shadow
chmod 644 /etc/passwd
chattr +i /etc/passwd
```

### 挂载选项
```bash
/dev/sda1 /boot ext4 defaults,nosuid,nodev,noexec 0 2
/dev/sda2 /tmp ext4 defaults,nosuid,nodev,noexec 0 2
```

## 服务与进程安全

### 禁用不必要的服务
```bash
systemctl disable telnet.socket
systemctl disable vsftpd
```

### 网络参数加固
```bash
# 防止IP欺骗
echo \"1\" > /proc/sys/net/ipv4/conf/all/rp_filter

# 开启SYN Cookie
echo \"1\" > /proc/sys/net/ipv4/tcp_syncookies
```

## 日志与审计

配置Auditd监控重要文件：
```bash
auditctl -w /etc/passwd -p wa -k identity
auditctl -w /etc/shadow -p wa -k identity
```'