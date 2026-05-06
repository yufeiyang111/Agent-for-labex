# CSRF跨站请求伪造

## 漏洞原理

CSRF（Cross-Site Request Forgery）攻击者利用用户已登录的身份，诱导用户访问恶意页面，在用户不知情的情况下以用户身份执行非自愿的操作。

## 攻击示例

```html
<img src=\"http://bank.com/transfer?to=attacker&amount=10000\">
```

## 防御措施

### 1. CSRF Token（最佳方案）
服务器生成随机Token，在表单和Session中各存储一份。

### 2. 验证请求来源
检查HTTP头中的Referer或Origin字段。

### 3. SameSite Cookie
```http
Set-Cookie: session=xxx; SameSite=Strict
```

### 4. 双重提交Cookie
将Token同时放在Cookie和请求参数中'