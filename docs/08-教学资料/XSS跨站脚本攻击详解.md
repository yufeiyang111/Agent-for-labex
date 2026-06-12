# XSS跨站脚本攻击详解

## 漏洞原理

XSS（Cross-Site Scripting）攻击是指攻击者通过在网页中注入恶意JavaScript代码，当其他用户浏览该网页时，恶意代码会在用户浏览器中执行。

## XSS攻击类型

### 1. 反射型XSS
恶意脚本作为用户输入的一部分被服务器接收，然后未经转义地返回给用户。

**攻击流程**：
1. 攻击者构造恶意URL
2. 用户点击链接访问目标网站
3. 网站将恶意脚本反射回用户浏览器
4. 脚本在用户浏览器执行

**示例URL**：
```
http://example.com/search?q=<script>alert(document.cookie)</script>
```

### 2. 存储型XSS
恶意脚本被永久存储在目标服务器（如数据库、评论、论坛帖子），所有访问该数据的用户都会被攻击。

**常见注入点**：
- 评论区、留言板
- 用户资料
- 文章发布

### 3. DOM型XSS
不涉及服务器处理，纯客户端漏洞。恶意脚本通过操作DOM对象来执行。

**示例代码**：
```javascript
// 直接将用户输入插入HTML
document.getElementById(\"output\").innerHTML = location.hash;
```

## XSS攻击危害

1. **窃取Cookie/Session**：获取用户认证信息
2. **键盘记录**：监听用户键盘输入
3. **钓鱼攻击**：修改页面内容欺骗用户
4. **植入恶意软件**：下载并执行恶意程序
5. **蠕虫传播**：自动传播XSS攻击

## 防御措施

### 1. 输入验证
- 白名单验证
- 限制输入长度
- 过滤特殊字符

### 2. 输出编码
| 上下文 | 编码方式 |
|--------|----------|
| HTML内容 | `&lt;` `&gt;` `&amp;` |
| HTML属性 | 使用双引号包裹，编码特殊字符 |
| JavaScript | JSON编码或十六进制 |
| URL参数 | URL编码 |

### 3. 设置安全头部
```http
Content-Security-Policy: script-src 'self'
X-XSS-Protection: 1; mode=block
```

### 4. HttpOnly Cookie
设置Cookie的HttpOnly属性，防止JavaScript访问。
```http
Set-Cookie: session=xxx; HttpOnly
```

### 5. 使用现代框架
React、Vue等框架默认对输出进行转义。'