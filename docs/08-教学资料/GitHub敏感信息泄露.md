# GitHub敏感信息泄露

## 常见泄露类型

1. **API密钥**
   - AWS keys: AKIA...
   - Google API keys: AIza...
   - Stripe keys: sk_live...

2. **凭据**
   - 数据库连接字符串
   - SMTP认证信息
   - SSH密钥

3. **配置文件**
   - .env文件
   - config.py
   - settings.xml

## GitHub搜索语法

```bash
filename:.env DB_PASSWORD
extension:.pem private
\"aws_access_key\" language:YAML
```

## 检测工具

### truffleHog
```bash
trufflehog https://github.com/user/repo
```

### gitGraber
```bash
gitGraber -k wordlists/keywords.txt -q \"company_name\"
```

## 防护措施

1. **使用GitHub Secret Scanning**
2. **配置 .gitignore**
3. **员工安全培训**
4. **定期审计代码仓库**'