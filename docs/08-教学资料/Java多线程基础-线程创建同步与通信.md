# Java多线程基础

## 一、线程概述

线程是程序执行的最小单元。Java内置对多线程的支持。

### 进程 vs 线程
- **进程**：操作系统资源分配的基本单位，有独立的内存空间
- **线程**：CPU调度的基本单位，共享进程的内存空间

### 线程的状态
```
NEW（新建） → RUNNABLE（可运行） → BLOCKED（阻塞）
                                  → WAITING（等待）
                                  → TIMED_WAITING（超时等待）
                                  → TERMINATED（终止）
```

线程状态转换：
1. `new Thread()` → NEW
2. `thread.start()` → RUNNABLE
3. 获取到CPU时间片 → 实际运行
4. `synchronized`阻塞 → BLOCKED
5. `wait()` / `join()` → WAITING
6. `sleep(time)` / `wait(time)` → TIMED_WAITING
7. 运行结束 → TERMINATED

## 二、线程的创建方式

### 方式1：继承Thread类
```java
public class MyThread extends Thread {
    @Override
    public void run() {
        System.out.println("线程运行中: " + Thread.currentThread().getName());
    }
}

// 使用
MyThread t = new MyThread();
t.start();  // 启动线程（不能直接调用run()）
```

### 方式2：实现Runnable接口（推荐）
```java
public class MyTask implements Runnable {
    @Override
    public void run() {
        System.out.println("任务执行中: " + Thread.currentThread().getName());
    }
}

// 使用
Thread t = new Thread(new MyTask(), "工作线程1");
t.start();

// Lambda简化
Thread t = new Thread(() -> {
    System.out.println("Lambda线程");
}, "lambda线程");
t.start();
```

### 方式3：实现Callable接口（可返回结果）
```java
public class MyCallable implements Callable<Integer> {
    @Override
    public Integer call() throws Exception {
        int sum = 0;
        for (int i = 1; i <= 100; i++) sum += i;
        return sum;
    }
}

// 使用（需要FutureTask获取结果）
FutureTask<Integer> futureTask = new FutureTask<>(new MyCallable());
Thread t = new Thread(futureTask);
t.start();

Integer result = futureTask.get();  // 获取结果（阻塞）
System.out.println("计算结果: " + result);
```

### 方式4：使用线程池
```java
ExecutorService executor = Executors.newFixedThreadPool(4);
executor.submit(() -> System.out.println("线程池任务"));
executor.shutdown();
```

## 三、线程常用方法

```java
Thread t = new Thread(() -> {
    try {
        Thread.sleep(1000);  // 休眠1秒
    } catch (InterruptedException e) {
        // 线程被中断时抛出
    }
});

t.start();

t.join();              // 等待线程t执行完毕
t.join(500);           // 最多等待500ms
Thread.yield();        // 让出CPU（但不保证）
t.interrupt();         // 中断线程
t.setDaemon(true);     // 设为守护线程

// 线程优先级（1-10，默认5）
t.setPriority(Thread.MAX_PRIORITY);   // 10
t.setPriority(Thread.MIN_PRIORITY);   // 1
t.setPriority(Thread.NORM_PRIORITY);  // 5
```

### 守护线程
```java
// 守护线程为其他线程提供服务，所有用户线程结束则JVM退出
Thread daemon = new Thread(() -> {
    while (true) {
        // 后台服务
    }
});
daemon.setDaemon(true);  // 必须在start之前设置
daemon.start();
```

## 四、线程安全问题

### 问题产生原因
多个线程同时访问共享数据，且至少一个线程在写数据。

```java
// 线程不安全的计数器
public class Counter {
    private int count = 0;

    public void increment() {
        count++;  // 不是原子操作！分为：读取→加1→写入
    }

    public int getCount() {
        return count;
    }
}
```

## 五、synchronized关键字

### 同步方法
```java
public class SafeCounter {
    private int count = 0;

    // 同步实例方法（锁是this）
    public synchronized void increment() {
        count++;
    }

    // 同步静态方法（锁是类对象）
    public static synchronized void staticMethod() {
        // ...
    }
}
```

### 同步代码块
```java
public class SafeList {
    private final List<String> list = new ArrayList<>();

    public void add(String s) {
        // this是锁对象
        synchronized (this) {
            list.add(s);
        }
    }

    // 使用专门的锁对象
    private final Object lock = new Object();

    public void remove(String s) {
        synchronized (lock) {
            list.remove(s);
        }
    }
}
```

### synchronized原理
- 基于JVM的Monitor（监视器锁）
- 每个对象关联一个Monitor
- 方法级同步通过ACC_SYNCHRONIZED标志
- 代码块同步通过monitorenter/monitorexit指令
- JDK 6+ 优化：偏向锁 → 轻量级锁 → 重量级锁

## 六、线程间通信

### wait / notify / notifyAll
```java
public class MessageQueue {
    private final Queue<String> queue = new LinkedList<>();
    private final int capacity;

    public MessageQueue(int capacity) {
        this.capacity = capacity;
    }

    // 生产者
    public synchronized void put(String message) throws InterruptedException {
        while (queue.size() == capacity) {
            wait();   // 队列满时等待
        }
        queue.offer(message);
        notifyAll();  // 唤醒所有等待线程
    }

    // 消费者
    public synchronized String take() throws InterruptedException {
        while (queue.isEmpty()) {
            wait();   // 队列空时等待
        }
        String message = queue.poll();
        notifyAll();  // 唤醒所有等待线程
        return message;
    }
}
```

**wait和notify的规则**：
1. 必须在synchronized代码块/方法中调用
2. wait()释放锁并进入等待状态
3. notify()唤醒一个等待线程（不立即释放锁）
4. notifyAll()唤醒所有等待线程
5. 使用while而非if判断条件（防止虚假唤醒）

## 七、volatile关键字

```java
public class FlagHolder {
    private volatile boolean flag = true;

    // volatile保证：
    // 1. 可见性：一个线程修改flag，其他线程立即看到
    // 2. 禁止指令重排序
    // 不保证原子性！
}
```

### volatile vs synchronized
| 特性 | volatile | synchronized |
|------|----------|-------------|
| 可见性 | √ | √ |
| 原子性 | × | √ |
| 禁止重排序 | √ | √ |
| 阻塞 | 不阻塞 | 阻塞 |
| 性能 | 轻量 | 较重 |

## 八、死锁

### 死锁的四个条件
1. **互斥**：资源不能被共享
2. **持有并等待**：线程持有资源并等待其他资源
3. **不可剥夺**：资源不能强行从线程中移除
4. **循环等待**：线程间形成循环等待链

```java
// 典型的死锁示例
public class DeadlockExample {
    private final Object lock1 = new Object();
    private final Object lock2 = new Object();

    public void method1() {
        synchronized (lock1) {
            Thread.sleep(100);
            synchronized (lock2) {
                // 业务逻辑
            }
        }
    }

    public void method2() {
        synchronized (lock2) {
            Thread.sleep(100);
            synchronized (lock1) {
                // 业务逻辑
            }
        }
    }
}
```

### 避免死锁
1. **固定锁的顺序**：所有线程按相同的顺序获取锁
2. **使用tryLock超时**：lock.tryLock(timeout, TimeUnit.SECONDS)
3. **减少锁的粒度**：使用更细粒度的锁
4. **使用更高层的并发工具**：如ConcurrentHashMap、BlockingQueue

## 相关标签
Java多线程, Thread, Runnable, Callable, synchronized, volatile, 线程通信, 死锁
