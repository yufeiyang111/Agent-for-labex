# Java Lambda表达式与Stream API

## 一、Lambda表达式

Lambda表达式是JDK 8引入的函数式编程特性，可以简洁地表示函数。

### 语法
```java
// 基本语法：(参数) -> { 方法体 }

// 无参数
Runnable r = () -> System.out.println("Hello");

// 一个参数
Consumer<String> c = s -> System.out.println(s);

// 多个参数
Comparator<Integer> comp = (a, b) -> a - b;

// 多行方法体（需要大括号和return）
Comparator<Integer> comp = (a, b) -> {
    System.out.println("比较: " + a + ", " + b);
    return Integer.compare(a, b);
};
```

### 函数式接口
```java
// 函数式接口：只有一个抽象方法的接口
@FunctionalInterface
public interface MyFunction {
    int apply(int x, int y);
}

// 内置四大函数式接口
// 1. Predicate<T> - 断言
Predicate<String> isEmpty = s -> s.isEmpty();
boolean result = isEmpty.test("");  // true
predicate.and(other).test(x);       // 与
predicate.or(other).test(x);        // 或
predicate.negate().test(x);         // 非

// 2. Function<T, R> - 转换
Function<String, Integer> toInt = s -> Integer.parseInt(s);
int num = toInt.apply("123");

// 3. Consumer<T> - 消费
Consumer<String> printer = s -> System.out.println(s);
printer.accept("Hello");

// 4. Supplier<T> - 供给
Supplier<Double> random = () -> Math.random();
double value = random.get();

// 特殊形式
UnaryOperator<T>     // Function<T, T> 一元操作
BinaryOperator<T>    // BiFunction<T,T,T> 二元操作
BiFunction<T, U, R>  // 两个参数一个返回值
BiConsumer<T, U>     // 两个参数的消费型
```

### 方法引用
```java
// 静态方法引用：ClassName::staticMethod
Function<String, Integer> f1 = Integer::parseInt;
// 等价于 s -> Integer.parseInt(s)

// 实例方法引用：instance::method
Consumer<String> f2 = System.out::println;
// 等价于 s -> System.out.println(s)

// 特定类型实例方法：ClassName::method
Comparator<String> f3 = String::compareTo;
// 等价于 (a, b) -> a.compareTo(b)

// 构造方法引用：ClassName::new
Supplier<List<String>> f4 = ArrayList::new;
// 等价于 () -> new ArrayList<>()

// 数组构造引用
Function<Integer, String[]> f5 = String[]::new;
```

## 二、Stream API

Stream用于对集合进行函数式风格的操作，支持链式调用。

### 创建Stream
```java
// 从集合创建
List<String> list = Arrays.asList("a", "b", "c");
Stream<String> stream = list.stream();           // 顺序流
Stream<String> parallelStream = list.parallelStream(); // 并行流

// 从数组创建
Stream<String> arrayStream = Arrays.stream(new String[]{"a", "b", "c"});

// 从值创建
Stream<Integer> valueStream = Stream.of(1, 2, 3);

// 无限流
Stream<Integer> iterate = Stream.iterate(0, n -> n + 2);    // 0,2,4,6,...
Stream<Double> generate = Stream.generate(Math::random);    // 随机数

// 文件行
Stream<String> lines = Files.lines(Paths.get("test.txt"));
```

### 中间操作（Intermediate Operations）

#### 筛选与切片
```java
// filter：条件过滤
Stream.of(1, 2, 3, 4, 5)
    .filter(n -> n % 2 == 0)        // [2, 4]
    .forEach(System.out::println);

// distinct：去重（基于equals）
Stream.of(1, 2, 2, 3, 3, 3)
    .distinct()                     // [1, 2, 3]

// limit：限制个数
Stream.of(1, 2, 3, 4, 5)
    .limit(3)                       // [1, 2, 3]

// skip：跳过前n个
Stream.of(1, 2, 3, 4, 5)
    .skip(2)                        // [3, 4, 5]

// takeWhile（JDK 9+）：获取满足条件的元素直到第一个不满足
Stream.of(1, 2, 3, 4, 1, 2)
    .takeWhile(n -> n < 4)          // [1, 2, 3]

// dropWhile（JDK 9+）：丢弃满足条件的元素直到第一个不满足
Stream.of(1, 2, 3, 4, 1, 2)
    .dropWhile(n -> n < 4)          // [4, 1, 2]
```

#### 映射
```java
// map：元素转换
List<String> names = users.stream()
    .map(User::getName)              // User → String
    .collect(Collectors.toList());

// mapToInt/mapToLong/mapToDouble：转为原始类型流
int totalAge = users.stream()
    .mapToInt(User::getAge)
    .sum();

// flatMap：扁平化（将多个流合并）
List<List<Integer>> nested = Arrays.asList(
    Arrays.asList(1, 2),
    Arrays.asList(3, 4, 5),
    Arrays.asList(6)
);
List<Integer> flat = nested.stream()
    .flatMap(List::stream)           // [[1,2],[3,4,5],[6]] → [1,2,3,4,5,6]
    .collect(Collectors.toList());

// 示例：单词拆分
List<String> words = Arrays.asList("Hello World", "Java Stream");
List<String> result = words.stream()
    .flatMap(s -> Arrays.stream(s.split(" "))) // 拆分句子为单词
    .collect(Collectors.toList());
// ["Hello", "World", "Java", "Stream"]
```

#### 排序
```java
// 自然排序
list.stream()
    .sorted()
    .collect(Collectors.toList());

// 自定义排序
list.stream()
    .sorted(Comparator.comparing(User::getAge).reversed())
    .collect(Collectors.toList());

// 多级排序
list.stream()
    .sorted(Comparator
        .comparing(User::getGrade)
        .thenComparing(User::getScore, Comparator.reverseOrder())
    )
    .collect(Collectors.toList());
```

#### 调试
```java
// peek：查看中间结果（调试用）
List<Integer> result = Stream.of(1, 2, 3, 4, 5)
    .filter(n -> n > 2)
    .peek(System.out::println)       // 输出: 3, 4, 5
    .map(n -> n * 2)
    .peek(System.out::println)       // 输出: 6, 8, 10
    .collect(Collectors.toList());   // [6, 8, 10]
```

### 终端操作（Terminal Operations）

#### 匹配
```java
// allMatch：全部匹配
boolean allAdult = users.stream().allMatch(u -> u.getAge() >= 18);

// anyMatch：任意匹配
boolean hasAdult = users.stream().anyMatch(u -> u.getAge() >= 18);

// noneMatch：没有匹配
boolean allKids = users.stream().noneMatch(u -> u.getAge() >= 18);
```

#### 查找
```java
// findFirst：第一个
User first = users.stream()
    .filter(u -> u.getAge() > 20)
    .findFirst()
    .orElse(null);

// findAny：任意一个（并行流时更高效）
User any = users.parallelStream()
    .filter(u -> u.getAge() > 20)
    .findAny()
    .orElse(null);
```

#### 归约
```java
// reduce：归约操作
// 求和
int sum = Stream.of(1, 2, 3, 4, 5)
    .reduce(0, Integer::sum);         // 15

// 拼接字符串
String concat = Stream.of("A", "B", "C")
    .reduce("", (a, b) -> a + b);     // "ABC"

// 求最大值
Optional<Integer> max = Stream.of(5, 2, 8, 1)
    .reduce(Integer::max);            // Optional[8]
```

#### 收集
```java
// 收集到List
List<String> list = stream.collect(Collectors.toList());

// 收集到Set
Set<String> set = stream.collect(Collectors.toSet());

// 收集到指定集合
ArrayList<String> arrayList = stream.collect(Collectors.toCollection(ArrayList::new));

// 收集到Map
Map<Integer, String> map = users.stream()
    .collect(Collectors.toMap(
        User::getId,          // key
        User::getName,        // value
        (v1, v2) -> v1        // 冲突解决：保留第一个
    ));

// 分组
Map<Integer, List<User>> byAge = users.stream()
    .collect(Collectors.groupingBy(User::getAge));

// 多级分组
Map<String, Map<Integer, List<User>>> byDeptAndAge = users.stream()
    .collect(Collectors.groupingBy(
        User::getDepartment,
        Collectors.groupingBy(User::getAge)
    ));

// 分区（true/false两组）
Map<Boolean, List<User>> adults = users.stream()
    .collect(Collectors.partitioningBy(u -> u.getAge() >= 18));

// 汇总统计
IntSummaryStatistics stats = users.stream()
    .collect(Collectors.summarizingInt(User::getAge));
stats.getSum();
stats.getAverage();
stats.getMin();
stats.getMax();
stats.getCount();

// 连接字符串
String joined = users.stream()
    .map(User::getName)
    .collect(Collectors.joining(", ", "[", "]"));  // [张三, 李四, 王五]

// 聚合操作
Map<String, Optional<User>> oldestInDept = users.stream()
    .collect(Collectors.groupingBy(
        User::getDepartment,
        Collectors.maxBy(Comparator.comparing(User::getAge))
    ));
```

### Stream完整示例
```java
// 传统方式
List<User> adults = new ArrayList<>();
for (User user : users) {
    if (user.getAge() >= 18) {
        adults.add(user);
    }
}
Collections.sort(adults, (a, b) -> a.getAge() - b.getAge());
List<String> names = new ArrayList<>();
for (User user : adults) {
    names.add(user.getName());
}

// Stream方式
List<String> names = users.stream()
    .filter(u -> u.getAge() >= 18)
    .sorted(Comparator.comparing(User::getAge))
    .map(User::getName)
    .collect(Collectors.toList());
```

## 三、Optional类

```java
// 创建Optional
Optional<String> empty = Optional.empty();
Optional<String> opt = Optional.of("value");    // 非null值
Optional<String> nullable = Optional.ofNullable(nullValue);

// 安全取值
String s = opt.get();                     // 获取值（可能抛NoSuchElementException）
String s2 = opt.orElse("default");        // 值为null返回默认值
String s3 = opt.orElseThrow(() -> new RuntimeException("值不存在"));
String s4 = opt.orElseGet(() -> computeDefault()); // 惰性求值

// 条件操作
opt.ifPresent(v -> System.out.println(v)); // 存在时消费
opt.ifPresentOrElse(v -> {}, () -> {});    // 存在或不存在（JDK 9+）

// 转换
Optional<String> upper = opt.map(String::toUpperCase);
Optional<Integer> length = opt.flatMap(s -> Optional.of(s.length()));

// 过滤
Optional<String> filtered = opt.filter(s -> s.startsWith("A"));

// 链式使用
String result = Optional.ofNullable(user)
    .map(User::getAddress)
    .map(Address::getCity)
    .orElse("未知城市");
```

## 相关标签
Java Lambda, 函数式接口, Stream API, Optional, 方法引用, Collectors
