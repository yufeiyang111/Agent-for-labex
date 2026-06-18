# Labex 项目配置指南

## 快速开始

### 1. 克隆项目
```bash
git clone https://github.com/your-username/labex.git
cd labex
```

### 2. 配置环境变量

#### 方式一：使用环境变量（推荐）

复制环境变量示例文件：
```bash
cp .env.example .env
```

编辑 `.env` 文件，填入真实的配置值：
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

#### 方式二：直接修改配置文件

复制配置文件示例：
```bash
cp backend/src/main/resources/application-example.yml backend/src/main/resources/application.yml
```

编辑 `application.yml`，将 `${VARIABLE_NAME:default}` 格式的配置替换为实际值。

### 3. 启动服务

#### 使用 Docker（推荐）
```bash
docker-compose up -d
```

#### 手动启动

**启动基础设施：**
```bash
# 启动 MySQL（确保已安装）
# 启动 Redis
redis-server

# 启动 Neo4j（确保已安装）
```

**启动后端：**
```bash
cd backend
mvn clean spring-boot:run
```

**启动前端：**
```bash
cd frontend
npm install
npm run dev
```

**启动 AI 服务：**
```bash
cd embedding_service
pip install -r requirements.txt
python app.py
```

### 4. 访问应用

- 前端：http://localhost:3000
- 后端 API：http://localhost:8080/api
- 嵌入服务：http://localhost:5000

## 配置说明

### 数据库配置

| 配置项 | 说明 | 默认值 |
|--------|------|--------|
| MYSQL_HOST | MySQL 主机地址 | localhost |
| MYSQL_PORT | MySQL 端口 | 3306 |
| MYSQL_DATABASE | 数据库名称 | labex |
| MYSQL_USERNAME | 数据库用户名 | root |
| MYSQL_PASSWORD | 数据库密码 | - |

### Redis 配置

| 配置项 | 说明 | 默认值 |
|--------|------|--------|
| REDIS_HOST | Redis 主机地址 | localhost |
| REDIS_PORT | Redis 端口 | 6379 |
| REDIS_PASSWORD | Redis 密码 | - |

### Neo4j 配置

| 配置项 | 说明 | 默认值 |
|--------|------|--------|
| NEO4J_URI | Neo4j 连接地址 | bolt://localhost:7687 |
| NEO4J_USERNAME | Neo4j 用户名 | neo4j |
| NEO4J_PASSWORD | Neo4j 密码 | - |

### AI 服务配置

| 配置项 | 说明 | 默认值 |
|--------|------|--------|
| MINIMAX_API_KEY | MiniMax API 密钥 | - |
| MINIMAX_BASE_URL | MiniMax API 基础地址 | https://api.minimaxi.com/v1 |
| MINIMAX_MODEL | MiniMax 模型名称 | MiniMax-M2.7-highspeed |
| EMBEDDING_SERVICE_URL | 嵌入服务地址 | http://localhost:5000 |

### 安全配置

| 配置项 | 说明 | 默认值 |
|--------|------|--------|
| JWT_SECRET | JWT 签名密钥（至少 64 字节） | - |

## 常见问题

### Q: 如何获取 MiniMax API Key？

访问 [MiniMax 开放平台](https://platform.minimaxi.com/) 注册并获取 API Key。

### Q: 如何配置 Neo4j？

1. 下载并安装 [Neo4j Community Edition](https://neo4j.com/download/)
2. 启动 Neo4j 服务
3. 默认用户名：`neo4j`，首次登录需要设置密码

### Q: 如何配置 Redis？

**Windows：**
- 下载 [Redis for Windows](https://github.com/microsoftarchive/redis/releases)

**Mac/Linux：**
```bash
# Mac
brew install redis

# Linux (Ubuntu)
sudo apt-get install redis-server
```

### Q: 数据库初始化

项目使用 `SchemaCompatibilityInitializer` 自动创建表结构，无需手动执行 SQL。

## 开发指南

### 项目结构

```
labex/
├── backend/          # Spring Boot 后端
├── frontend/         # Vue 3 前端
├── embedding_service/ # Python AI 服务
├── docker-compose.yml # Docker 配置
└── .env.example      # 环境变量示例
```

### 代码规范

- 后端：遵循 Java 编码规范
- 前端：遵循 Vue 3 + ESLint 规范
- 提交信息：使用语义化提交格式

### 测试

```bash
# 后端测试
cd backend
mvn test

# 前端测试
cd frontend
npm run test
```

## 部署

### 生产环境配置

1. 复制配置文件：
```bash
cp backend/src/main/resources/application-example.yml backend/src/main/resources/application.yml
```

2. 修改配置：
- 设置强密码
- 配置生产环境数据库
- 设置安全的 JWT 密钥
- 配置正确的文件上传路径

3. 构建并部署：
```bash
# 构建后端
cd backend
mvn clean package

# 构建前端
cd frontend
npm run build

# 启动服务
java -jar backend/target/labex-backend.jar
```

## 安全建议

1. **不要提交敏感信息**：所有敏感配置都应使用环境变量
2. **定期更换密钥**：JWT 密钥、API Key 应定期更换
3. **使用强密码**：数据库密码至少 12 位，包含大小写字母、数字和特殊字符
4. **限制访问**：生产环境应配置防火墙，限制数据库端口访问

## 许可证

[添加许可证信息]
