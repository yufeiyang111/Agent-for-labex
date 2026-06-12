# Java并发编程高级

## 一、Lock接口

### ReentrantLock
```java
// 可重入锁（等价于synchronized但更灵活）
public class BankAccount {
    private double balance;
    private final Lock lock = new ReentrantLock();

    public void transfer(double amount) {
        lock.lock();  // 获取锁
        try {
            if (amount > 0 && balance >= amount) {
                balance -= amount;
            }
        } finally {
            lock.unlock();  // 必须在finally中释放
        }
    }

    // tryLock - 尝试获取锁（不阻塞或限时等待）
    public boolean tryTransfer(double amount) {
        if (lock.tryLock()) {  // 立即返回
            try {
                if (amount > 0 && balance >= amount) {
                    balance -= amount;
                    return true;
                }
            } finally {
                lock.unlock();
            }
        }
        return false;
    }

    public boolean tryTransferTimeout(double amount) {
        try {
            if (lock.tryLock(1, TimeUnit.SECONDS)) {
                try {
                    if (amount > 0 && balance >= amount) {
                        balance -= amount;
                        return true;
                    }
                } finally {
                    lock.unlock();
                }
            }
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
        return false;
    }
}
```

### ReadWriteLock
```java
// 读写分离：读读不互斥，读写/写写互斥
public class Cache<K, V> {
    private final Map<K, V> map = new HashMap<>();
    private final ReadWriteLock rwLock = new ReentrantReadWriteLock();
    private final Lock readLock = rwLock.readLock();
    private final Lock writeLock = rwLock.writeLock();

    public V get(K key) {
        readLock.lock();
        try {
            return map.get(key);
        } finally {
            readLock.unlock();
        }
    }

    public void put(K key, V value) {
        writeLock.lock();
        try {
            map.put(key, value);
        } finally {
            writeLock.unlock();
        }
    }
}
```

### StampedLock（JDK 8+）
```java
// 比ReadWriteLock更优，支持乐观读
public class Point {
    private double x, y;
    private final StampedLock sl = new StampedLock();

    // 写入
    public void move(double dx, double dy) {
        long stamp = sl.writeLock();
        try {
            x += dx;
            y += dy;
        } finally {
            sl.unlockWrite(stamp);
        }
    }

    // 乐观读（无锁）
    public double distanceFromOrigin() {
        long stamp = sl.tryOptimisticRead();
        double currentX = x, currentY = y;
        // 验证乐观读是否有效
        if (!sl.validate(stamp)) {
            stamp = sl.readLock();  // 升级为悲观读
            try {
                currentX = x;
                currentY = y;
            } finally {
                sl.unlockRead(stamp);
            }
        }
        return Math.sqrt(currentX * currentX + currentY * currentY);
    }
}
```

## 二、线程池

### 线程池的好处
1. **降低资源消耗**：复用线程，减少创建/销毁开销
2. **提高响应速度**：任务到达时无需等待线程创建
3. **提高可管理性**：统一管理线程，避免无节制造线程

### ThreadPoolExecutor（核心）
```java
// 七个参数
ThreadPoolExecutor executor = new ThreadPoolExecutor(
    2,              // corePoolSize：核心线程数
    4,              // maximumPoolSize：最大线程数
    60,             // keepAliveTime：空闲线程存活时间
    TimeUnit.SECONDS,  // 时间单位
    new LinkedBlockingQueue<>(100),  // 任务队列
    Executors.defaultThreadFactory(),  // 线程工厂
    new ThreadPoolExecutor.AbortPolicy()  // 拒绝策略
);
```

### 任务执行流程
1. 线程数 < corePoolSize → 创建新线程执行
2. 线程数 ≥ corePoolSize → 放入队列
3. 队列满 → 创建新线程（直到maximumPoolSize）
4. 线程数 = maximumPoolSize + 队列满 → 执行拒绝策略

### 4种拒绝策略
```java
ThreadPoolExecutor.AbortPolicy();      // 抛出RejectedExecutionException（默认）
ThreadPoolExecutor.CallerRunsPolicy(); // 调用者线程执行
ThreadPoolExecutor.DiscardPolicy();    // 丢弃任务，不抛异常
ThreadPoolExecutor.DiscardOldestPolicy(); // 丢弃队列最旧的任务
```

### Executors工厂类
```java
// 固定大小线程池
ExecutorService fixedPool = Executors.newFixedThreadPool(4);

// 单线程池（保证任务顺序执行）
ExecutorService singlePool = Executors.newSingleThreadExecutor();

// 缓存线程池（按需创建，空闲60秒回收）
ExecutorService cachedPool = Executors.newCachedThreadPool();

// 定时/周期性任务
ScheduledExecutorService scheduledPool = Executors.newScheduledThreadPool(2);
scheduledPool.schedule(task, 10, TimeUnit.SECONDS);       // 延迟执行
scheduledPool.scheduleAtFixedRate(task, 0, 5, TimeUnit.SECONDS);  // 固定频率
scheduledPool.scheduleWithFixedDelay(task, 0, 5, TimeUnit.SECONDS); // 固定延迟

// 注意：生产环境推荐使用ThreadPoolExecutor自定义参数
```

### 正确关闭线程池
```java
ExecutorService executor = Executors.newFixedThreadPool(4);

// 步骤1：拒绝新任务，等待已提交任务完成
executor.shutdown();

// 步骤2：等待终止（超时机制）
try {
    if (!executor.awaitTermination(60, TimeUnit.SECONDS)) {
        executor.shutdownNow();  // 强制停止
        if (!executor.awaitTermination(60, TimeUnit.SECONDS)) {
            System.err.println("线程池无法终止");
        }
    }
} catch (InterruptedException e) {
    executor.shutdownNow();
    Thread.currentThread().interrupt();
}
```

## 三、并发工具类

### CountDownLatch（倒计时门闩）
```java
// 等待所有线程完成后再继续
public class CountDownLatchDemo {

    public static void main(String[] args) throws InterruptedException {
        int workerCount = 5;
        CountDownLatch latch = new CountDownLatch(workerCount);

        for (int i = 0; i < workerCount; i++) {
            new Thread(() -> {
                System.out.println(Thread.currentThread().getName() + " 完成工作");
                latch.countDown();  // 减1
            }).start();
        }

        latch.await();  // 主线程等待所有工人完成
        System.out.println("所有工作完成，主线程继续");
    }
}
```

### CyclicBarrier（循环屏障）
```java
// 所有线程到达屏障后同时继续
public class CyclicBarrierDemo {
    private static final int PLAYER_COUNT = 5;

    public static void main(String[] args) {
        CyclicBarrier barrier = new CyclicBarrier(PLAYER_COUNT,
            () -> System.out.println("所有玩家已准备，游戏开始！"));

        for (int i = 0; i < PLAYER_COUNT; i++) {
            new Thread(() -> {
                System.out.println(Thread.currentThread().getName() + " 已准备");
                try {
                    barrier.await();  // 等待其他玩家
                } catch (Exception e) {
                    e.printStackTrace();
                }
                System.out.println(Thread.currentThread().getName() + " 进入游戏");
            }, "玩家" + i).start();
        }
    }
}
```

### Semaphore（信号量）
```java
// 控制同时访问的线程数
public class SemaphoreDemo {
    private static final Semaphore parkingLot = new Semaphore(3);

    public static void main(String[] args) {
        for (int i = 0; i < 10; i++) {
            new Thread(() -> {
                try {
                    parkingLot.acquire();  // 获取许可
                    System.out.println(Thread.currentThread().getName() + " 进入停车场");
                    Thread.sleep(2000);
                    System.out.println(Thread.currentThread().getName() + " 离开停车场");
                } catch (InterruptedException e) {
                    e.printStackTrace();
                } finally {
                    parkingLot.release();  // 释放许可
                }
            }, "车辆" + i).start();
        }
    }
}
```

### Exchanger（交换器）
```java
// 两个线程交换数据
Exchanger<String> exchanger = new Exchanger<>();

new Thread(() -> {
    String data = "来自线程A的数据";
    String received = exchanger.exchange(data);
    System.out.println("A收到: " + received);
}).start();

new Thread(() -> {
    String data = "来自线程B的数据";
    String received = exchanger.exchange(data);
    System.out.println("B收到: " + received);
}).start();
```

## 四、BlockingQueue

```java
// ArrayBlockingQueue（有界阻塞队列）
BlockingQueue<String> queue = new ArrayBlockingQueue<>(10);
queue.put("item");        // 队列满时阻塞
String item = queue.take(); // 队列空时阻塞

// LinkedBlockingQueue（可选有界，默认Integer.MAX_VALUE）
BlockingQueue<String> linkedQueue = new LinkedBlockingQueue<>();

// PriorityBlockingQueue（支持优先级）
BlockingQueue<Task> priorityQueue = new PriorityBlockingQueue<>();

// SynchronousQueue（容量为0，直接传递）
BlockingQueue<String> syncQueue = new SynchronousQueue<>();
// put必须等待对应的take

// DelayQueue（延迟队列）
BlockingQueue<Delayed> delayQueue = new DelayQueue<>();
// 元素只有延迟时间到了才能被取出
```

## 五、原子类

```java
// 基本类型
AtomicInteger count = new AtomicInteger(0);
count.incrementAndGet();     // 自增并返回值（++count）
count.getAndIncrement();     // 返回值并自增（count++）
count.addAndGet(5);          // +5并返回值
count.compareAndSet(6, 10);  // 如果当前值为6则设为10

// 数组
AtomicIntegerArray arr = new AtomicIntegerArray(10);
arr.incrementAndGet(0);

// 引用
AtomicReference<String> ref = new AtomicReference<>("initial");
ref.compareAndSet("initial", "updated");

// 字段更新器
AtomicIntegerFieldUpdater<Person> ageUpdater =
    AtomicIntegerFieldUpdater.newUpdater(Person.class, "age");
ageUpdater.incrementAndGet(person);
```

## 六、Fork/Join框架（JDK 7+）

```java
// 分治求和
public class ForkJoinSumCalculator extends RecursiveTask<Long> {
    private final long[] numbers;
    private final int start, end;
    private static final int THRESHOLD = 10_000;

    public ForkJoinSumCalculator(long[] numbers, int start, int end) {
        this.numbers = numbers;
        this.start = start;
        this.end = end;
    }

    @Override
    protected Long compute() {
        int length = end - start;
        if (length <= THRESHOLD) {
            // 直接计算
            long sum = 0;
            for (int i = start; i < end; i++) {
                sum += numbers[i];
            }
            return sum;
        }
        // 拆分
        int mid = start + length / 2;
        ForkJoinSumCalculator leftTask = new ForkJoinSumCalculator(numbers, start, mid);
        leftTask.fork();  // 异步执行
        ForkJoinSumCalculator rightTask = new ForkJoinSumCalculator(numbers, mid, end);
        Long rightResult = rightTask.compute();
        Long leftResult = leftTask.join();
        return leftResult + rightResult;
    }
}

// 使用
ForkJoinPool pool = new ForkJoinPool();
long result = pool.invoke(new ForkJoinSumCalculator(numbers, 0, numbers.length));
```

## 相关标签
Java并发, ReentrantLock, 线程池, ThreadPoolExecutor, CountDownLatch, CyclicBarrier, Semaphore, 原子类, ForkJoin
