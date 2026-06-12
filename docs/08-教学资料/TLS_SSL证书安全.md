# TLS/SSL证书安全

## TLS握手过程

1. 客户端发送支持的加密算法列表
2. 服务器选择算法并发送证书
3. 客户端验证证书有效性
4. 双方生成会话密钥
5. 加密通信开始

## TLS版本安全

| 版本 | 状态 |
|------|------|
| SSLv2 | 禁用（不安全） |
| SSLv3 | 禁用（POODLE攻击） |
| TLS1.0 | 禁用（脆弱） |
| TLS1.1 | 禁用 |
| TLS1.2 | 推奨 |
| TLS1.3 | 最新，最安全 |

## 证书配置检查

```bash
# 检查证书信息
openssl s_client -connect example.com:443

# 检查支持的密码套件
openssl s_client -connect example.com:443 -cipher '!NULL'
```

## 安全配置

### Nginx配置
```nginx
ssl_protocols TLSv1.2 TLSv1.3;
ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256;
ssl_prefer_server_ciphers on;
ssl_session_cache shared:SSL:10m;
```'