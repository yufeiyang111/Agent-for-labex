# Java内存管理与JVM

## 一、JVM内存区域

### 运行时数据区
```
┌─────────────────────────────────┐
│         方法区（Method Area）     │ ← 类信息、常量、静态变量
├─────────────────────────────────┤
│            堆（Heap）            │ ← 对象实例（GC主要区域）
├─────────────────────────────────┤
│         虚拟机栈（VM Stack）      │ ← 栈帧（局部变量表、操作数栈）
├─────────────────────────────────┤
│        本地方法栈（Native Stack） │ ← native方法调用
├─────────────────────────────────┤
│         程序计数器（PC Register）  │ ← 当前线程执行的行号
└─────────────────────────────────┘
```

### 堆（Heap）分代
```java
// 堆内存划分为：
// 新生代（Young Generation）1/3
//   ├── Eden区（8/10）
//   ├── Survivor 0区（1/10）
//   └── Survivor 1区（1/10）
// 老年代（Old Generation）2/3
//
// 对象分配流程：
// 1. 新对象 → Eden区
// 2. Minor GC → 存活对象移入Survivor
// 3. 年龄达到阈值（默认15）→ 移入老年代
```

### 栈（Stack）
```java
// 每个线程有独立的栈，栈中存储栈帧
// 每个方法调用对应一个栈帧

public int add(int a, int b) {
    int result = a + b;  // 局部变量在栈中
    return result;
}
// 栈帧包含：
// - 局部变量表
// - 操作数栈
// - 动态链接
// - 方法出口
```

### 方法区（Metaspace）
- JDK 7及以前：永久代（PermGen）
- JDK 8+：元空间（Metaspace，使用本地内存）

## 二、JVM参数

```bash
# 堆内存设置
-Xms512m              # 初始堆大小
-Xmx2048m             # 最大堆大小
-Xmn512m              # 新生代大小
-XX:SurvivorRatio=8   # Eden:Survivor=8:1
-XX:MaxTenuringThreshold=15  # 晋升老年代年龄阈值

# 元空间
-XX:MetaspaceSize=256m
-XX:MaxMetaspaceSize=512m

# GC日志
-XX:+PrintGCDetails
-XX:+PrintGCDateStamps
-Xloggc:gc.log

# 内存溢出处理
-XX:+HeapDumpOnOutOfMemoryError
-XX:HeapDumpPath=/path/to/dump

# 其他
-XX:+DisableExplicitGC     # 禁止System.gc()
-XX:+UseCompressedOops     # 压缩对象指针
```

## 三、垃圾回收（GC）

### 对象存活判定
```java
// 1. 引用计数法（不常用）
// 2. 可达性分析算法（常用）
// 从GC Roots开始遍历，可达对象存活

// GC Roots包括：
// - 栈帧中的局部变量引用
// - 静态变量引用
// - JNI引用
// - 活跃线程
```

### 引用类型
```java
// 1. 强引用（Strong Reference）
String s = new String("Hello");  // 只要可达就不回收

// 2. 软引用（SoftReference）
SoftReference<byte[]> cache = new SoftReference<>(new byte[1024 * 1024]);
byte[] data = cache.get();  // 内存不足时可能为null

// 3. 弱引用（WeakReference）
WeakReference<String> wr = new WeakReference<>(new String("Hello"));
System.out.println(wr.get());  // GC后为null

// 4. 虚引用（PhantomReference）
ReferenceQueue<String> queue = new ReferenceQueue<>();
PhantomReference<String> pr = new PhantomReference<>(new String(""), queue);
pr.get();  // 永远返回null（用于对象回收跟踪）
```

### 垃圾回收算法
```
1. 标记-清除（Mark-Sweep）
   - 标记存活对象 → 清除未标记对象
   - 缺点：产生内存碎片

2. 标记-复制（Mark-Copy）
   - 将存活对象复制到另一块区域
   - 用于新生代（Eden→Survivor）
   - 缺点：浪费空间

3. 标记-整理（Mark-Compact）
   - 标记存活对象 → 向一端移动
   - 用于老年代
   - 缺点：移动对象成本高
```

### 垃圾回收器（JDK 8常用）
```
- Serial GC：单线程，暂停所有用户线程（-XX:+UseSerialGC）
- Parallel GC：多线程，追求高吞吐（-XX:+UseParallelGC）← JDK 8默认
- CMS GC：低延迟，并发标记清除（-XX:+UseConcMarkSweepGC）
- G1 GC：区域化分代，大堆推荐（-XX:+UseG1GC）
```

G1 GC是JDK 9+的默认GC，将堆划分为多个Region。

## 四、内存泄漏

### 常见内存泄漏场景
```java
// 1. 静态集合类持有对象引用
public class MemoryLeak {
    private static final List<Object> cache = new ArrayList<>();

    public void add(Object obj) {
        cache.add(obj);  // 对象永远不会被回收
    }
}

// 2. 未关闭的资源
try (InputStream is = new FileInputStream("test.txt")) {
    // 使用try-with-resources确保关闭
}

// 3. 内部类持有外部类引用
public class Outer {
    private byte[] largeData = new byte[1024 * 1024];

    public class Inner {
        // Inner持有Outer.this引用
    }

    public Inner getInner() {
        return new Inner();  // 可能导致Outer无法回收
    }
}

// 4. equals()和hashCode()实现不当
public class BadKey {
    public String name;
    // 没有重写hashCode和equals
}

Map<BadKey, String> map = new HashMap<>();
BadKey key = new BadKey();
key.name = "test";
map.put(key, "value");
key.name = "changed";  // 改变后的对象无法在Map中找到
// 内存泄漏：无法删除entry
```

### 内存泄漏检测
```bash
# 使用jmap生成堆转储
jmap -dump:live,format=b,file=heap.hprof <pid>

# 使用jstat监控GC
jstat -gcutil <pid> 1000 10  # 每秒，共10次

# 使用jvisualvm可视化分析
```

## 五、类加载机制

### 类加载过程
```
加载（Loading）→ 验证（Verification）→ 准备（Preparation）
→ 解析（Resolution）→ 初始化（Initialization）
```

### 双亲委派模型
```java
// 自底向上检查类是否已加载，自顶向下尝试加载类

// 类加载器层级：
// Bootstrap ClassLoader（C++，加载rt.jar）
//   ↓
// Extension ClassLoader（加载jre/lib/ext）
//   ↓
// Application ClassLoader（加载classpath）
//   ↓
// 自定义ClassLoader

// 为什么需要双亲委派？
// - 避免重复加载
// - 核心类库安全（防止自定义String替换JDK的String）
```

## 六、性能调优

### 调优思路
1. **确定目标**：吞吐量优先？响应时间优先？
2. **监控现状**：jstat、jvisualvm、Arthas
3. **调整参数**：堆大小、GC选择、比例设置
4. **代码优化**：减少对象创建、使用池化技术

### 常用调优参数组合
```bash
# 高吞吐配置（后台批处理）
java -Xms2g -Xmx2g -XX:+UseParallelGC -XX:+UseParallelOldGC

# 低延迟配置（Web服务）
java -Xms2g -Xmx2g -XX:+UseG1GC -XX:MaxGCPauseMillis=100

# 堆转储配置
java -Xms1g -Xmx1g -XX:+HeapDumpOnOutOfMemoryError      -XX:HeapDumpPath=/tmp/heap.hprof
```

### 常见调优工具
| 工具 | 用途 |
|------|------|
| jps | 查看Java进程 |
| jstat | GC统计信息 |
| jmap | 堆转储和分析 |
| jstack | 线程堆栈分析 |
| jvisualvm | 可视化监控 |
| Arthas | 在线诊断工具 |
| MAT | 堆分析工具 |

## 相关标签
JVM, 内存模型, 垃圾回收, GC, 类加载, 性能调优, 堆内存
