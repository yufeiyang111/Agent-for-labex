# Docker容器安全

## 镜像安全

### 1. 最小化镜像
- 使用Alpine等轻量镜像
- 多阶段构建
- 移除不必要的工具

### 2. 镜像扫描
```bash
docker scan image_name
trivy image image_name
```

## 容器运行安全

### 1. 非root运行
```dockerfile
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser
```

### 2. 资源限制
```bash
docker run --memory=\"256m\" --cpus=\"0.5\"
```

### 3. 安全选项
```bash
docker run --security-opt=no-new-privileges:true
docker run --read-only
```

## 网络安全

### 限制网络访问
```bash
docker network create --internal isolated_net
docker network connect isolated_net container
```

## 密钥管理

### 使用Docker Secrets
```bash
echo \"password\" | docker secret create db_password -
```

## 监控与审计

### 日志配置
```json
{
  \"log-driver\": \"json-file\",
  \"log-opts\": {
    \"max-size\": \"10m\",
    \"max-file\": \"3\"
  }
}
```'