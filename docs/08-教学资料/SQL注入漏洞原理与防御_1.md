# SQL注入漏洞原理与防御

## 漏洞原理

SQL注入（SQL Injection）是由于Web应用程序对用户输入未做充分验证和转义，导致攻击者可以在SQL语句中插入恶意代码。

## 攻击原理示例

### 正常查询
```sql
SELECT * FROM users WHERE username='admin' AND password='123456'
```

### 注入后
```sql
SELECT * FROM users WHERE username='admin'--' AND password='anything'
```
`'--` 将后面的密码验证注释掉，攻击者无需密码即可登录。

## SQL注入类型

### 1. 基于错误的注入
通过构造特殊输入引发数据库错误，从错误信息中获取数据库结构。

### 2. 联合查询注入
使用UNION语句合并恶意查询结果。
```sql
SELECT name,email FROM users UNION SELECT username,password FROM admin_users--
```

### 3. 布尔盲注
根据页面返回真假判断信息。

### 4. 时间盲注
利用数据库延时函数判断条件。

### 5. 堆叠查询
执行多条SQL语句。

## 防御措施

### 1. 参数化查询（最佳方案）
```python
cursor.execute(\"SELECT * FROM users WHERE id = ?\", (user_id,))
```

### 2. 输入验证
- 白名单验证
- 类型检查
- 长度限制

### 3. 转义处理
对特殊字符进行转义

### 4. 最小权限原则
数据库账户只授予必要的权限

### 5. 错误处理
生产环境关闭详细错误信息'