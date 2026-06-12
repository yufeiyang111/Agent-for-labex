# Web缓存安全

## 缓存机制

### 1. 浏览器缓存
- Cache-Control
- Expires
- ETag
- Last-Modified

### 2. CDN缓存
- 边缘节点缓存
- 私有缓存

### 3. 反向代理缓存
- Nginx缓存
- Varnish

## 安全问题

### 1. 敏感数据泄露
- 缓存敏感页面（账户信息）
- 缓存包含认证Token的响应

### 2. 缓存中毒
攻击者控制缓存内容。

### 3. 缓存穿透
攻击大量不存在的数据绕过缓存。

## 安全配置

### Cache-Control头
```http
# 不缓存
Cache-Control: no-store, no-cache, must-revalidate
Pragma: no-cache

# 私有缓存
Cache-Control: private

# 公共资源，可缓存
Cache-Control: public, max-age=3600
```

### 敏感数据处理
```http
Cache-Control: no-store
Set-Cookie: session=xxx; HttpOnly; Secure
```'