# SSRF服务器端请求伪造

## 漏洞原理

SSRF（Server-Side Request Forgery）攻击者利用Web应用程序的服务器作为代理，向内部系统或外部系统发起请求，从而突破网络边界限制。

## 与CSRF的区别

| 维度 | CSRF | SSRF |
|------|------|------|
| 攻击目标 | 用户的操作 | 服务器的操作 |
| 受害者 | 用户浏览器 | 服务器 |
| 利用条件 | 用户已登录 | 服务器能访问 |

## 攻击场景

### 1. 访问内部系统
```
# 攻击者让服务器访问内部数据库
http://example.com/fetch?url=http://192.168.1.100/admin
```

### 2. 扫描内网端口
```
http://example.com/fetch?url=http://192.168.1.1:22
http://example.com/fetch?url=http://192.168.1.1:3306
```

### 3. 读取本地文件
```
http://example.com/fetch?url=file:///etc/passwd
```

### 4. 攻击云服务元数据
```
http://example.com/fetch?url=http://169.254.169.254/latest/meta-data/
```

### 5. 探测内部服务
利用服务器向内部服务发送探测请求，根据响应时间判断服务存在。

## 危害

1. 端口扫描内网主机
2. 读取本地敏感文件
3. 攻击内部Web服务
4. 访问云服务商元数据
5. 利用Gopher协议攻击Redis、Memcached

## 防御措施

### 1. URL验证
- 使用URL解析库验证URL
- 检查host是否为内网IP
- 禁止访问私有IP地址段

```python
from ipaddress import ip_address, ip_network

# 定义内网IP段
private_networks = [
    ip_network('10.0.0.0/8'),
    ip_network('172.16.0.0/12'),
    ip_network('192.168.0.0/16'),
    ip_network('127.0.0.0/8')
]

def is_private_ip(url):
    host = urlparse(url).hostname
    ip = ip_address(host)
    return any(ip in net for net in private_networks)
```

### 2. 协议限制
- 限制允许的协议（http/https）
- 禁止file://、dict://、gopher://等

### 3. 白名单
只允许访问预定义的URL列表。

### 4. 禁用不需要的协议
配置服务器禁止处理file://、dict://等协议。'