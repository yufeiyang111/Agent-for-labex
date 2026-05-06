# ARP协议与ARP欺骗攻击

## ARP协议原理

ARP（Address Resolution Protocol）用于将IP地址解析为MAC地址。

### ARP工作流程
1. 主机查询目标IP的MAC地址
2. 广播ARP请求包
3. 目标主机响应ARP reply
4. 主机缓存IP-MAC对应关系

## ARP欺骗攻击

### 攻击原理
攻击者发送伪造的ARP响应包，将自己的MAC地址绑定到受害者的IP地址。

### 中间人攻击
攻击者同时欺骗网关和目标主机，使得双向流量都经过攻击者。

### 攻击工具
- **arpwatch**：监控ARP变化
- **ettercap**：ARP欺骗工具
- **dsniff**：网络嗅探工具包

## 防御措施

1. **静态ARP表**：手动绑定关键IP-MAC
2. **ARP防火墙**：检测和阻止异常ARP包
3. **交换机的Dynamic ARP Inspection**：验证ARP包
4. **802.1X认证**：端口接入控制
5. **加密通信**：使用VPN或TLS'