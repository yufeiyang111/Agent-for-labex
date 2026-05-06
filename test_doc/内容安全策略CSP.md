# 内容安全策略CSP

## CSP作用

Content Security Policy是一种安全头部，用于防止XSS、点击劫持等攻击。

## 配置示例

### 基本配置
```http
Content-Security-Policy: default-src 'self'
```

### 允许特定源
```http
Content-Security-Policy:
    default-src 'self';
    script-src 'self' https://trusted-cdn.com;
    style-src 'self' 'unsafe-inline';
    img-src *;
```

### 禁止内联
```http
Content-Security-Policy: script-src 'self'
```

## 指令说明

| 指令 | 说明 |
|------|------|
| default-src | 默认来源 |
| script-src | JS来源 |
| style-src | CSS来源 |
| img-src | 图片来源 |
| connect-src | AJAX/WebSocket |
| frame-src | iframe来源 |

## 报告机制

```http
Content-Security-Policy-Report-URI: /csp-report
```

## 常见错误

1. **'unsafe-inline'**：允许内联脚本
2. **'*'**：允许任意来源
3. **data:**：允许data:URL'