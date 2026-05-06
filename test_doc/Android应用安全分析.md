# Android应用安全分析

## 反编译防护

### 混淆技术
```gradle
android {
    buildTypes.release {
        minifyEnabled true
        proguardFiles getDefaultProguardFile('proguard-android-optimize.txt')
    }
}
```

### 反调试检测
```java
boolean isDebuggable = (getApplicationInfo().flags & ApplicationInfo.FLAG_DEBUGGABLE) != 0;

// 检测Frida
public static boolean isFridaRunning() {
    File[] files = new File(\"/proc\").listFiles();
    for (File file : files) {
        if (file.isDirectory()) {
            if (new FileInputStream(file.getAbsolutePath() + \"/cmdline\").read().toString().contains(\"frida\")) {
                return true;
            }
        }
    }
    return false;
}
```

## 数据安全

### 安全存储
```java
MasterKey masterKey = new MasterKey.Builder(context)
    .setKeyScheme(MasterKey.KeyScheme.AES256_GCM)
    .build();

SharedPreferences prefs = EncryptedSharedPreferences.create(context, \"secure_prefs\", masterKey);
```'