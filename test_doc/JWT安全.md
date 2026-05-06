# JWT安全

## JWT结构

JWT由三部分组成：Header.Payload.Signature

```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4ifQ._signature
```

## 安全问题

### 1. 算法None
攻击者将alg改为none，删除签名。

### 2. 密钥混淆（Key Confusion）
将算法从RS256改为HS256，使用公钥作为对称密钥验证。

### 3. 敏感信息泄露
在Payload中存储敏感信息（Base64可解密）。

## 安全最佳实践

### 1. 验证算法
```javascript
if (token.header.alg !== 'RS256') {
  return reject('Invalid algorithm');
}
```

### 2. 验证签名
使用服务器私钥验证签名。

### 3. 设置过期时间
```javascript
const token = jwt.sign(
  { userId: user.id },
  privateKey,
  { expiresIn: '1h' }
);
```

### 4. 存储安全
- HttpOnly Cookie存储
- 不要存储在LocalStorage
- 配合CSRF保护'