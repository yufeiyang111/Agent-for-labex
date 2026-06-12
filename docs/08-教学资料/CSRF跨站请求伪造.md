# CSRF跨站请求伪造

## 漏洞原理

CSRF（Cross-Site Request Forgery）攻击者利用用户已登录的身份，诱导用户访问恶意页面，在用户不知情的情况下以用户身份执行非自愿的操作。

## 攻击原理

### 攻击条件
1. 用户已登录目标网站
2. 攻击者知道请求格式和参数
3. 用户访问恶意页面

### 攻击流程
1. 用户登录网站A，获取有效Session
2. 用户访问攻击者构造的恶意页面B
3. 页面B自动向网站A发送请求（图片、表单、AJAX）
4. 浏览器自动携带Cookie发送请求
5. 网站A认为是合法请求，执行相应操作

## 攻击示例

### 图片请求
```html
<img src=\"http://bank.com/transfer?to=attacker&amount=10000\">
```

### 表单请求
```html
<form action=\"http://bank.com/transfer\" method=\"POST\">
  <input type=\"hidden\" name=\"to\" value=\"attacker\">
  <input type=\"hidden\" name=\"amount\" value=\"10000\">
</form>
<script>document.forms[0].submit();</script>
```

## 防御措施

### 1. CSRF Token（最佳方案）
服务器生成随机Token，在表单和Session中各存储一份，提交时验证一致性。

```html
<form action=\"/transfer\" method=\"POST\">
  <input type=\"hidden\" name=\"csrf_token\" value=\"随机Token值\">
</form>
```

### 2. 验证请求来源（Referer/Origin）
检查HTTP头中的Referer或Origin字段。

```python
if request.headers.get('Referer') != 'https://trusted.com':
    return403
```

### 3. 双重提交Cookie
将Token同时放在Cookie和请求参数中，服务器验证两者是否匹配。

### 4. 敏感操作验证
对重要操作要求重新验证（如密码、验证码）。

### 5. SameSite Cookie
设置Cookie的SameSite属性。
```http
Set-Cookie: session=xxx; SameSite=Strict
```

## 最佳实践
- 优先使用CSRF Token
- 敏感操作使用验证码
- 设置合理的Cookie属性
- 限制GET请求的操作'