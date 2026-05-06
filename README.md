# Labex 实验教学管理系统

> 基于 Vue 3 + Spring Boot 3 的现代化实验教学管理平台

## 项目简介

Labex 是一个功能完整的实验教学管理系统，支持教师和学生的全流程实验教学管理。系统从旧有的 Spring MVC + JSP 架构重构为现代化的前后端分离架构。

## 技术栈

### 后端
- Spring Boot 3.x
- MyBatis-Plus 3.5.x
- Spring Security 6.x + JWT
- MySQL 8.x
- Redis 7.x
- Maven

### 前端
- Vue 3.4.x
- Vite 5.x
- Element Plus 2.4.x
- Pinia 2.1.x
- Vue Router 4.x
- Axios 1.6.x

## 项目结构

```
labex/
├── backend/                    # Spring Boot 后端
│   ├── src/main/java/com/labex/
│   │   ├── config/            # 配置类（安全、MyBatis、跨域等）
│   │   ├── controller/        # 控制器层
│   │   │   ├── teacher/       # 教师模块接口
│   │   │   └── student/       # 学生模块接口
│   │   ├── service/           # 服务层
│   │   ├── mapper/            # 数据访问层
│   │   ├── entity/            # 实体类
│   │   ├── dto/               # 数据传输对象
│   │   ├── vo/                # 视图对象
│   │   ├── security/          # 安全相关（JWT、UserDetailsService）
│   │   ├── common/            # 通用组件（Result、PageResult）
│   │   ├── exception/         # 全局异常处理
│   │   └── filter/            # 过滤器（JWT认证）
│   └── src/main/resources/
│       ├── application.yml    # 配置文件
│       └── sql/               # SQL脚本
├── frontend/                   # Vue 3 前端
│   ├── src/
│   │   ├── api/               # API接口管理
│   │   ├── router/            # 路由配置
│   │   ├── stores/            # Pinia状态管理
│   │   ├── views/             # 页面组件
│   │   │   ├── teacher/       # 教师页面
│   │   │   └── student/       # 学生页面
│   │   ├── components/        # 公共组件
│   │   ├── utils/             # 工具函数
│   │   └── styles/            # 全局样式
│   ├── package.json
│   └── vite.config.js
├── docker/                     # Docker配置
│   ├── Dockerfile.backend
│   ├── Dockerfile.frontend
│   └── nginx.conf
├── docker-compose.yml          # 容器编排
└── README.md
```

## 核心功能

### 教师模块
1. **班级管理**：增删改查班级、启用/禁用、IP限制
2. **学生管理**：学生CRUD、批量导入（CSV）、重置密码/IP
3. **实验管理**：创建/编辑实验、题目管理、标准答案设置
4. **讲义管理**：文件上传、讲义列表
5. **成绩管理**：查看学生答案、在线评分、批量评分、导出Excel

### 学生模块
1. **实验列表**：查看可用实验、进入答题
2. **实验答题**：题目导航、在线答题、自动保存、提交答卷
3. **讲义学习**：浏览和下载讲义
4. **个人中心**：修改密码、查看成绩

### 系统功能
- JWT认证授权
- 角色权限控制
- 操作日志记录
- 数据导出导入

## 快速开始

### 环境要求
- JDK 17+
- Node.js 18+
- MySQL 8.0+
- Redis 7+

### 后端启动

```bash
cd backend

# 修改数据库配置：src/main/resources/application.yml
# 配置 MySQL 连接信息

# 编译运行
mvn clean compile spring-boot:run

# 或打包后运行
mvn clean package
java -jar target/labex-backend-1.0.0.jar
```

访问地址：http://localhost:8080/api

### 前端启动

```bash
cd frontend

# 安装依赖
npm install

# 开发模式
npm run dev

# 生产构建
npm run build
```

访问地址：http://localhost:3000

### Docker 部署（推荐）

```bash
# 一键启动所有服务
docker-compose up -d

# 停止服务
docker-compose down

# 查看日志
docker-compose logs -f
```

访问地址：http://localhost（前端）、http://localhost:8080/api（后端API）

## 数据库设计

系统基于原有数据库结构进行保留和优化，主要表包括：

- `t_teacher` - 教师表
- `t_student` - 学生表
- `t_clazz` - 班级表
- `t_experiment` - 实验表
- `t_experiment_item` - 实验题目表
- `t_student_item` - 学生答题表
- `t_score` - 成绩表
- `t_lecture` - 讲义表
- `t_sys_log` / `t_student_log` - 日志表

详细SQL见 `backend/src/main/resources/sql/` 目录。

## API 接口文档

### 认证接口
- `POST /api/auth/login` - 用户登录
- `POST /api/auth/logout` - 退出登录
- `GET /api/auth/userinfo` - 获取用户信息

### 教师接口（需角色：TEACHER）
- `GET /api/teacher/clazz/list` - 班级列表
- `POST /api/teacher/clazz` - 新增班级
- `PUT /api/teacher/clazz/{no}` - 更新班级
- `DELETE /api/teacher/clazz/{no}` - 删除班级

- `GET /api/teacher/student/list` - 学生列表
- `POST /api/teacher/student/import` - 批量导入学生

- `GET /api/teacher/experiment/list` - 实验列表
- `POST /api/teacher/experiment` - 新增实验

- `GET /api/teacher/lecture/list` - 讲义列表
- `POST /api/teacher/lecture/upload` - 上传讲义

### 学生接口（需角色：STUDENT）
- `GET /api/student/experiments` - 实验列表
- `GET /api/student/experiment/{id}/items` - 实验题目
- `POST /api/student/experiment/{id}/item/{itemId}/save` - 保存答案
- `POST /api/student/experiment/{id}/submit` - 提交实验

完整接口见 `frontend/src/api/index.js`

## 配置说明

### 后端配置（application.yml）

```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/labex
    username: root
    password: root

jwt:
  secret: your-secret-key
  expiration: 86400000
```

### 前端配置（vite.config.js）

```js
server: {
  proxy: {
    '/api': {
      target: 'http://localhost:8080',
      changeOrigin: true
    }
  }
}
```

## 主题样式

系统采用浅绿茶主题，主要配色：

- 主色：`#4caf50`
- 浅绿背景：`#e8f5e9`
- 深绿：`#388e3c`

所有卡片、按钮均添加柔和阴影效果，提供舒适的视觉体验。

## 测试账号

### 教师账号
- 账号：admin
- 密码：123456（原系统MD5密码）

### 学生账号
- 学号：23201335
- 密码：23201335（学号）

> 注意：首次登录时，系统会使用原数据库中的MD5密码。建议首次登录后修改密码。

## 常见问题

### 1. 数据库连接失败
检查MySQL是否启动，配置信息是否正确。

### 2. 前端无法访问后端
检查后端是否启动，跨域配置是否正确。

### 3. 图片/文件上传失败
确保 `backend/uploads/` 目录存在且有写权限。

## 贡献指南

欢迎提交 Issue 和 Pull Request！

## 许可证

MIT License

---

**Labex Team** · 2026
