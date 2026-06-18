# 安全配置说明

## 已完成的安全措施

### 1. 敏感信息移除

已从 Git 仓库中移除以下敏感信息：

- **MySQL 密码**: `yu6670980506`
- **Neo4j 密码**: `yu6670980506`
- **JWT Secret**: `labex-secret-key-2026-very-long-and-secure-key...`
- **MiniMax API Key**: `sk-cp-RXPtq9jNm3nrU4uqccKuuu...`

### 2. 配置文件处理

#### 已移除的文件
- `backend/src/main/resources/application.yml`（已从 Git 追踪中移除）

#### 新增的模板文件
- `backend/src/main/resources/application-example.yml` - 配置文件模板
- `.env.example` - 环境变量模板
- `SETUP.md` - 详细配置指南

### 3. .gitignore 更新

已更新 `.gitignore` 文件，添加以下忽略规则：

```gitignore
# 敏感配置文件
backend/src/main/resources/application.yml
.env
.env.local
.env.*.local

# IDE 配置
.idea/
*.iml
.vscode/

# 系统文件
Thumbs.db
.DS_Store

# 日志文件
*.log
logs/

# 临时文件
*.tmp
*.temp
```

## 配置项目步骤

### 方式一：使用环境变量（推荐）

1. 复制环境变量模板：
```bash
cp .env.example .env
```

2. 编辑 `.env` 文件，填入真实的配置值：
```bash
# 数据库配置
MYSQL_HOST=localhost
MYSQL_PORT=3306
MYSQL_DATABASE=labex
MYSQL_USERNAME=root
MYSQL_PASSWORD=your_actual_password

# Neo4j 配置
NEO4J_URI=bolt://localhost:7687
NEO4J_USERNAME=neo4j
NEO4J_PASSWORD=your_actual_password

# JWT 密钥（至少 64 字节）
JWT_SECRET=your_actual_jwt_secret_key_at_least_64_bytes

# MiniMax API 配置
MINIMAX_API_KEY=your_actual_minimax_api_key
```

### 方式二：直接修改配置文件

1. 复制配置文件模板：
```bash
cp backend/src/main/resources/application-example.yml backend/src/main/resources/application.yml
```

2. 编辑 `application.yml`，将环境变量占位符替换为实际值。

## 安全建议

### 1. 密码安全

- **MySQL 密码**: 使用强密码，至少 12 位，包含大小写字母、数字和特殊字符
- **Neo4j 密码**: 使用强密码，定期更换
- **JWT Secret**: 至少 64 字节，使用随机生成的字符串

### 2. API Key 安全

- **MiniMax API Key**: 从 [MiniMax 开放平台](https://platform.minimaxi.com/) 获取
- **Tavily API Key**: 从 [Tavily](https://tavily.com/) 获取（可选）

### 3. 生产环境安全

- 使用环境变量管理敏感配置
- 定期更换密码和密钥
- 限制数据库端口访问
- 使用 HTTPS
- 配置防火墙规则

## 大文件警告

Git 推送时检测到以下大文件：

- `_container_app.jar` (78.08 MB) - 超过 GitHub 推荐的 50 MB 限制

### 解决方案

1. **使用 Git LFS（推荐）**：
```bash
# 安装 Git LFS
git lfs install

# 追踪大文件
git lfs track "*.jar"

# 添加 .gitattributes
git add .gitattributes

# 重新提交
git commit -m "chore: add Git LFS tracking for large files"
```

2. **移除大文件**：
```bash
# 从 Git 追踪中移除
git rm --cached _container_app.jar

# 添加到 .gitignore
echo "_container_app.jar" >> .gitignore

# 提交更改
git commit -m "chore: remove large jar file from tracking"
```

## 验证配置

### 1. 检查环境变量

```bash
# Windows
echo %MYSQL_PASSWORD%

# Linux/Mac
echo $MYSQL_PASSWORD
```

### 2. 测试数据库连接

```bash
# 启动后端
cd backend
mvn clean spring-boot:run
```

### 3. 测试 API 访问

```bash
# 测试健康检查
curl http://localhost:8080/api/health

# 测试登录
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"your_password"}'
```

## 常见问题

### Q: 如何生成安全的 JWT Secret？

```bash
# 使用 OpenSSL 生成随机字符串
openssl rand -base64 64

# 或使用 Python
python -c "import secrets; print(secrets.token_urlsafe(64))"
```

### Q: 如何获取 MiniMax API Key？

1. 访问 [MiniMax 开放平台](https://platform.minimaxi.com/)
2. 注册账号并登录
3. 在 API Keys 页面创建新的 API Key
4. 复制 API Key 到配置文件

### Q: 环境变量不生效怎么办？

1. 确保 `.env` 文件在项目根目录
2. 检查环境变量名称是否正确
3. 重启应用程序
4. 检查日志输出

## 更新日志

### 2026-06-17
- 移除 application.yml 中的敏感信息
- 添加配置文件模板
- 更新 .gitignore 规则
- 添加安全配置文档
