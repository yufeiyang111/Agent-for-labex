# Kubernetes安全

## Pod安全

### 1. 安全上下文
```yaml
securityContext:
  runAsNonRoot: true
  runAsUser: 1000
  readOnlyRootFilesystem: true
```

### 2. 资源限制
```yaml
resources:
  limits:
    memory: \"128Mi\"
    cpu: \"500m\"
  requests:
    memory: \"64Mi\"
    cpu: \"250m\"
```

## 网络策略

###  默认拒绝
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny
spec:
  podSelector: {}
```

## RBAC权限控制

### 最小权限原则
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: app-reader
rules:
- apiGroups: [\"\"]
  resources: [\"pods\"]
  verbs: [\"get\", \"list\"]
```

## 敏感信息保护

### 使用Secrets
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: db-credentials
type: Opaque
stringData:
  password: password123
```

### 外部密钥管理
集成Vault、AWS Secrets Manager等外部密钥管理系统。

## 镜像安全

1. 定期扫描镜像漏洞
2. 使用私有镜像仓库
3. 签名镜像内容'