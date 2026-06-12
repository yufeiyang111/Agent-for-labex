# JSONP安全与CORS配置

## JSONP劫持

### 原理
JSONP通过<script>标签绕过同源策略获取数据，攻击者可构造恶意页面劫持数据。

### 攻击流程
1. 用户登录目标网站
2. 访问攻击者恶意页面
3. 页面通过JSONP获取用户敏感数据
4. 发送数据到攻击者服务器

## CORS（跨域资源共享）

### 敏感配置
```http
Access-Control-Allow-Origin: *
```
允许所有来源访问，非常危险！

### 安全配置
```http
Access-Control-Allow-Origin: https://trusted.com
Access-Control-Allow-Credentials: true
```

## 防御措施

1. **避免使用JSONP**
2. **严格配置CORS白名单**
3. **验证请求来源**
4. **使用Token验证**
5. **敏感操作使用POST而非GET**'