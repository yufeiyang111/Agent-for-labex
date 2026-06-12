# DHCP协议与DHCP攻击

## DHCP工作原理

DHCP（Dynamic Host Configuration Protocol）动态分配IP地址。

### 四步获取过程（DORA）
1. **Discover**：客户端广播发现包
2. **Offer**：服务器提供IP地址
3. **Request**：客户端请求IP
4. **Ack**：服务器确认

## DHCP攻击

### 1. DHCP欺骗
攻击者部署恶意DHCP服务器，提供错误配置：
- 虚假网关 → 流量导向攻击者
- 虚假DNS服务器 → 钓鱼攻击

### 2. DHCP饥饿攻击
攻击者发送大量DHCP请求耗尽地址池。

## 防御措施

1. **DHCP Snooping**：交换机启用，信任端口白名单
2. **ARP检测**：配合动态ARP检测
3. **端口安全**：限制每个端口的MAC数
4. **监控**：部署DHCP监听服务器'