# API安全

## REST API安全

### 1. 认证
- API Key
- JWT Token
- OAuth 2.0

### 2. 授权
```python
@app.route('/api/admin')
@require_admin
def admin_panel():
    pass
```

### 3. 输入验证
```python
from marshmallow import Schema, validate

class UserSchema(Schema):
    email = fields.Email(required=True)
    age = fields.Int(validate=Range(min=0, max=150))
```

## 常见漏洞

### 1. 越权访问
- 水平越权：同级用户互访
- 垂直越权：低权限访问高权限

### 2. 批量枚举
- 用户ID遍历
- 订单号遍历

### 3. 速率限制缺失
导致暴力破解或数据爬取。

## 防护措施

1. 实施速率限制
2. 强制身份认证
3. 资源级别授权
4. 输入输出验证
5. 敏感数据脱敏
6. API版本管理'