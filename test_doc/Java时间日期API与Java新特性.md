# Java时间日期API与Java新特性

## 一、传统日期API

### java.util.Date
```java
// Date（大部分方法已废弃）
Date now = new Date();                  // 当前时间
Date specific = new Date(1000000000L);  // 指定毫秒数
System.out.println(now.toString());     // 格式: Wed May 03 14:30:00 CST 2026
System.out.println(now.getTime());      // 毫秒时间戳
```

### java.util.Calendar
```java
Calendar cal = Calendar.getInstance();
cal.set(2026, Calendar.MAY, 3, 14, 30, 0);  // 设置时间
cal.add(Calendar.DAY_OF_MONTH, 7);           // 加7天
cal.set(Calendar.HOUR_OF_DAY, 0);            // 设置小时

int year = cal.get(Calendar.YEAR);
int month = cal.get(Calendar.MONTH) + 1;     // 注意：0-based
int day = cal.get(Calendar.DAY_OF_MONTH);
int hour = cal.get(Calendar.HOUR_OF_DAY);
int minute = cal.get(Calendar.MINUTE);
int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);

// Calendar遍历日期
Calendar c = Calendar.getInstance();
c.set(2026, Calendar.JANUARY, 1);
for (int i = 0; i < 12; i++) {
    System.out.println(c.get(Calendar.MONTH) + 1 + "月: " +
        c.getActualMaximum(Calendar.DAY_OF_MONTH) + "天");
    c.add(Calendar.MONTH, 1);
}
```

### SimpleDateFormat（线程不安全）
```java
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String formatted = sdf.format(new Date());          // 格式化
Date parsed = sdf.parse("2026-05-03 14:30:00");    // 解析

// 注意：SimpleDateFormat不是线程安全的！
// 多线程环境下需要使用ThreadLocal
ThreadLocal<DateFormat> safeFormat = ThreadLocal.withInitial(
    () -> new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"));
```

## 二、Java 8 时间日期API（java.time）

### LocalDate、LocalTime、LocalDateTime
```java
// 获取当前时间
LocalDate today = LocalDate.now();                          // 2026-05-03
LocalTime now = LocalTime.now();                            // 14:30:00.123
LocalDateTime dateTime = LocalDateTime.now();                // 2026-05-03T14:30:00.123

// 创建指定时间
LocalDate date = LocalDate.of(2026, 5, 3);
LocalTime time = LocalTime.of(14, 30, 0);
LocalDateTime dt = LocalDateTime.of(2026, 5, 3, 14, 30);

// 解析
LocalDate parsed = LocalDate.parse("2026-05-03");
LocalDateTime dtParsed = LocalDateTime.parse("2026-05-03T14:30:00");

// 操作
LocalDate tomorrow = today.plusDays(1);
LocalDate nextMonth = today.plusMonths(1);
LocalDate lastWeek = today.minusWeeks(1);
LocalDate nextYear = today.withYear(2027);  // 修改年份
LocalDate firstOfMonth = today.withDayOfMonth(1);  // 当月第一天

// 获取字段
int year = today.getYear();
int month = today.getMonthValue();    // 1-12
int day = today.getDayOfMonth();
DayOfWeek dow = today.getDayOfWeek(); // MONDAY~SUNDAY
int dom = today.getDayOfMonth();
int doy = today.getDayOfYear();
boolean leap = today.isLeapYear();    // 闰年
```

### Instant（时间戳）
```java
// 时间戳（UTC，精确到纳秒）
Instant now = Instant.now();
long epochSecond = now.getEpochSecond();   // 秒
int nano = now.getNano();                  // 纳秒

// Instant和Date互转
Instant inst = Instant.now();
Date date = Date.from(inst);
Instant back = date.toInstant();
```

### Duration与Period
```java
// Duration：时间差（时分秒纳秒）
Duration duration = Duration.between(start, end);
duration.toDays();       // 天数
duration.toHours();      // 小时数
duration.toMinutes();    // 分钟数
duration.toMillis();     // 毫秒数
Duration.ofHours(2);     // 2小时
Duration.ofMinutes(30);  // 30分钟

// Period：日期差（年月日）
Period period = Period.between(birthday, today);
period.getYears();       // 年数
period.getMonths();      // 月数
period.getDays();        // 日数
Period.ofDays(10);       // 10天
Period.ofMonths(3);      // 3个月
```

### DateTimeFormatter（线程安全）
```java
// 预定义格式
DateTimeFormatter isoDate = DateTimeFormatter.ISO_DATE;         // 2026-05-03
DateTimeFormatter isoDateTime = DateTimeFormatter.ISO_DATE_TIME; // 2026-05-03T14:30:00

// 自定义格式
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy年MM月dd日 HH:mm:ss");
String formatted = LocalDateTime.now().format(formatter);  // 2026年05月03日 14:30:00

// 解析
LocalDateTime parsed = LocalDateTime.parse(
    "2026-05-03 14:30:00",
    DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")
);

// 常用格式模式
// yyyy：年，MM：月，dd：日
// HH：24小时，hh：12小时，mm：分，ss：秒
// a：上午/下午，E：星期几
```

### 时区处理
```java
// ZonedDateTime：带时区的日期时间
ZonedDateTime zdt = ZonedDateTime.now();  // 当前时区
ZonedDateTime tokyo = ZonedDateTime.now(ZoneId.of("Asia/Tokyo"));

// 时区转换
ZonedDateTime shanghai = ZonedDateTime.now(ZoneId.of("Asia/Shanghai"));
ZonedDateTime newyork = shanghai.withZoneSameInstant(ZoneId.of("America/New_York"));

// 可用时区
Set<String> zoneIds = ZoneId.getAvailableZoneIds();

// OffsetDateTime：带偏移量的日期时间
OffsetDateTime odt = OffsetDateTime.now();
System.out.println(odt.getOffset());  // +08:00
```

## 三、Java 8+ 其他新特性

### 接口默认方法与静态方法
```java
public interface MyInterface {
    void abstractMethod();

    // 默认方法（子类可直接使用或重写）
    default void defaultMethod() {
        System.out.println("默认实现");
    }

    // 静态方法（直接通过接口调用）
    static void staticMethod() {
        System.out.println("接口静态方法");
    }
}
```

### 重复注解
```java
@Repeatable(Schedules.class)
public @interface Schedule {
    String dayOfWeek() default "MON";
}

public @interface Schedules {
    Schedule[] value();  // 容器注解
}

// 使用
@Schedule(dayOfWeek = "MON")
@Schedule(dayOfWeek = "WED")
@Schedule(dayOfWeek = "FRI")
public void scheduledMethod() {}
```

### CompletableFuture（异步编程）
```java
// 创建异步任务
CompletableFuture<String> future = CompletableFuture.supplyAsync(() -> {
    Thread.sleep(1000);
    return "任务结果";
});

// 回调
future.thenAccept(result -> System.out.println("结果: " + result));
future.exceptionally(ex -> {
    System.err.println("异常: " + ex.getMessage());
    return "默认值";
});

// 组合
CompletableFuture<String> future1 = CompletableFuture.supplyAsync(() -> "Hello");
CompletableFuture<String> future2 = CompletableFuture.supplyAsync(() -> "World");

// 合并两个结果
future1.thenCombine(future2, (s1, s2) -> s1 + ", " + s2)
       .thenAccept(System.out::println);  // Hello, World

// 等待所有完成
CompletableFuture.allOf(future1, future2).join();

// 并行执行
List<Integer> list = Arrays.asList(1, 2, 3, 4, 5);
List<CompletableFuture<Integer>> futures = list.stream()
    .map(n -> CompletableFuture.supplyAsync(() -> n * n))
    .collect(Collectors.toList());

List<Integer> results = futures.stream()
    .map(CompletableFuture::join)
    .collect(Collectors.toList());
```

### 其他JDK版本新特性
```java
// JDK 9：模块化系统（Module System）
// module-info.java
// module com.example {
//     requires java.sql;
//     exports com.example.api;
// }

// JDK 9：集合工厂方法
List<String> list = List.of("A", "B", "C");       // 不可变集合
Set<String> set = Set.of("A", "B", "C");
Map<String, Integer> map = Map.of("A", 1, "B", 2);

// JDK 10：局部变量类型推断（var）
var name = "Hello";           // String
var list = new ArrayList<>(); // ArrayList<Object>
var stream = list.stream();   // Stream<Object>

// JDK 11：字符串新方法
"   ".isBlank();                // true
"Hello
World".lines();        // Stream<String>
"Hello".repeat(3);             // "HelloHelloHello"
"  Hello  ".strip();           // "Hello"（去除前后空格）
"  Hello  ".stripTrailing();   // "  Hello"

// JDK 12-13：switch表达式（预览）
String result = switch (day) {
    case MONDAY, FRIDAY -> "Work";
    case SATURDAY, SUNDAY -> "Rest";
    default -> "Unknown";
};

// JDK 14：Records（数据类）
public record Point(int x, int y) {}
Point p = new Point(10, 20);
System.out.println(p.x());  // 自动生成getter

// JDK 14：instanceof模式匹配
if (obj instanceof String s) {
    System.out.println(s.length());  // 直接使用s
}

// JDK 15：密封类（Sealed Classes）
public sealed class Shape permits Circle, Rectangle {}
public final class Circle extends Shape {}
public final class Rectangle extends Shape {}

// JDK 16：Pattern Matching for instanceof (正式)
// JDK 17：密封类正式版 + 长期支持(LTS)
// JDK 21：Record Patterns、Virtual Threads（虚拟线程）
```

## 相关标签
Java日期, LocalDate, LocalDateTime, DateTimeFormatter, 时区, Java新特性, CompletableFuture
