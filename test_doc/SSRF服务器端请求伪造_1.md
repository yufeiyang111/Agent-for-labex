# SSRF服务器端请求伪造

## 漏洞原理

SSRF（Server-Side Request Forgery）攻击者利用Web应用程序的服务器作为代理，向内部系统或外部系统发起请求，从而突破网络边界限制。

## 攻击场景

### 1. 访问内部系统
```
http://example.com/fetch?url=http://192.168.1.100/admin
```

### 2. 读取本地文件
```
http://example.com/fetch?url=file:///etc/passwd
```

### 3. 攻击云服务元数据
```
http://example.com/fetch?url=http://169.254.169.254/latest/meta-data/
```

## 防御措施

### 1. URL验证
- 检查host是否为内网IP
- 禁止访问私有IP地址段

### 2. 协议限制
- 限制允许的协议（http/https）
- 禁止file://、dict://、gopher://等

### 3. 白名单
只允许访问预定义的URL列表'