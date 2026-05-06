# WebSocket安全

## WebSocket简介

WebSocket提供双向持久连接通信，常用于实时应用。

## 安全问题

### 1. 缺乏认证
WebSocket握手时不进行身份验证。

### 2. 同源策略绕过
WebSocket不受同源策略限制。

### 3. 跨站WebSocket劫持（CSWSH）
攻击者利用用户身份发起WebSocket连接。

## 防护措施

### 1. 验证Origin头
```javascript
const origin = request.headers.origin;
if (!allowedOrigins.includes(origin)) {
  reject();
}
```

### 2. 使用WSS（WebSocket Secure）
```javascript
const ws = new WebSocket('wss://secure.example.com');
```

### 3. 身份Token验证
在WebSocket消息中携带认证Token。

### 4. 消息级认证
每条消息包含签名或Token。

### 5. 输入验证
对所有接收的消息进行严格验证。'