# VPN技术与安全

## VPN原理

VPN（Virtual Private Network）通过公网建立加密隧道，实现安全通信。

## VPN类型

### 1. 远程访问VPN
个人用户连接企业网络
- SSL VPN（WebVPN）
- PPTP VPN
- L2TP/IPSec VPN

### 2. 站点到站点VPN
连接两个局域网
- IPSec VPN
- GRE隧道
- MPLS VPN

## 常用VPN协议

### IPSec
- 加密：ESP（Encapsulating Security Payload）
- 认证：AH（Authentication Header）
- 密钥交换：IKEv1/IKEv2

### SSL/TLS VPN
- 基于浏览器
- 适合远程办公
- 配置简单

## 安全建议

1. **强密码策略**：复杂的预共享密钥
2. **双因素认证**：结合证书+密码
3. **定期更新密钥**：避免长期使用同一密钥
4. **日志审计**：记录VPN访问行为
5. **流量加密**：使用强加密算法（AES-256）'