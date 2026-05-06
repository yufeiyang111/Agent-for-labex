# Android应用安全测试方法

Android应用安全测试是移动安全的重要组成部分。

## 测试环境搭建

### 工具准备
- Android Studio
- Jadx（反编译）
- Frida（动态插桩）
- Burp Suite（抓包代理）

### root检测与绕过
```javascript
// Frida绕过root检测
Java.perform(function() {
    var RootPackages = [\"com.topjohnwu.magisk\"];
    var PackageManager = Java.use(\"android.content.pm.PackageManager\");
    // 检测逻辑绕过
});
```

## 静态分析

### 反编译APK
```bash
# 使用apktool
apktool d app.apk -o output
# 使用jadx
jadx -d output app.apk
```

### 检查项
1. 硬编码密钥/密码
2. 不安全的存储（SharedPreferences）
3. 调试标志未关闭
4. 混淆不足

## 动态分析

### 网络流量抓包
1. 配置Burp Suite代理
2. 安装CA证书到设备
3. 抓取HTTP/HTTPS流量

### 运行时分析
```bash
# 使用Frida连接进程
frida -U -f com.example.app -l script.js
```

## 常见漏洞
- 不安全的数据存储
- 不安全的通信
- 弱加密
- 客户端注入
- 业务逻辑漏洞'