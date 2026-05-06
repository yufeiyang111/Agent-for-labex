# 无线网络WiFi安全

## WiFi加密协议

### WEP（Wired Equivalent Privacy）
- 已被完全破解
- RC4加密，40/104位密钥
- 不应再使用

### WPA（WiFi Protected Access）
- 过渡性协议
- TKIP加密
- 仍有安全漏洞

### WPA2
- 当前主流
- AES-CCMP加密
- 2017年被KRACK攻击破解

### WPA3
- 最新标准
- SAE握手协议
- 防暴力破解

## 常见WiFi攻击

### 1. WEP破解
- FMS攻击、 chopchop攻击
- 利用IV（初始向量）弱点

### 2. WPA/WPA2破解
- 字典攻击PSK
- 离线破解握手包

### 3. 恶意热点（Evil Twin）
- 创建同名伪造热点
- 中间人监听流量

### 4. KRACK攻击
- 密钥重装攻击
- 攻击WPA2四次握手

## 安全建议

1. **使用WPA3或强WPA2**
2. **设置复杂WiFi密码**
3. **隐藏SSID广播**
4. **MAC地址过滤**
5. **企业级802.1X认证**
6. **定期更换密码**
7. **分离访客网络**'