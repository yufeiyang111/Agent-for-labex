# Java泛型详解

## 一、泛型概述

泛型（Generics）是JDK 5引入的重要特性，允许在定义类、接口和方法时使用类型参数。

### 为什么需要泛型
```java
// 不使用泛型（不安全）
List list = new ArrayList();
list.add("Hello");
list.add(123);
String s = (String) list.get(0);  // 需要强制转换
String s2 = (String) list.get(1); // 运行时ClassCastException

// 使用泛型（类型安全）
List<String> list = new ArrayList<>();
list.add("Hello");
// list.add(123);  // 编译错误！
String s = list.get(0);  // 不需要转换
```

### 泛型的好处
- **类型安全**：编译时类型检查
- **消除类型转换**：无需强制转换
- **代码复用**：一套代码适配多种类型

## 二、泛型类

```java
// 定义泛型类
public class Box<T> {
    private T content;

    public void set(T content) {
        this.content = content;
    }

    public T get() {
        return content;
    }
}

// 使用
Box<String> stringBox = new Box<>();
stringBox.set("Hello");
String value = stringBox.get();

Box<Integer> intBox = new Box<>();
intBox.set(100);
Integer num = intBox.get();

// 多个类型参数
public class Pair<K, V> {
    private K key;
    private V value;

    public Pair(K key, V value) {
        this.key = key;
        this.value = value;
    }

    public K getKey() { return key; }
    public V getValue() { return value; }
}

Pair<String, Integer> pair = new Pair<>("age", 30);  // 菱形推断
```

## 三、泛型接口

```java
// 定义泛型接口
public interface Repository<T> {
    T findById(Long id);
    List<T> findAll();
    void save(T entity);
    void delete(Long id);
}

// 实现泛型接口
public class UserRepository implements Repository<User> {
    @Override
    public User findById(Long id) {
        // 实现
        return null;
    }

    @Override
    public List<User> findAll() {
        return new ArrayList<>();
    }

    @Override
    public void save(User user) {
        // 实现
    }

    @Override
    public void delete(Long id) {
        // 实现
    }
}
```

## 四、泛型方法

```java
// 泛型方法（类型参数在返回值前声明）
public class Utils {
    // 普通泛型方法
    public static <T> T getLast(List<T> list) {
        return list.get(list.size() - 1);
    }

    // 泛型方法 - 多个类型参数
    public static <K, V> V getOrDefault(Map<K, V> map, K key, V defaultValue) {
        return map.getOrDefault(key, defaultValue);
    }

    // 静态泛型方法
    public static <T> List<T> arrayToList(T[] array) {
        return Arrays.asList(array);
    }
}

// 使用
String last = Utils.getLast(Arrays.asList("A", "B", "C"));
List<Integer> list = Utils.arrayToList(new Integer[]{1, 2, 3});
```

### 泛型方法 vs 泛型类
```java
public class MyClass<T> {  // 类级别的T
    // 类级别的T在整个类中有效
    private T value;

    // 这是泛型方法（与类级别的T不同）
    public <T> void method(T param) {
        // 方法级别的T覆盖类级别的T
    }

    // 类级别的T
    public void set(T value) {
        this.value = value;
    }
}
```

## 五、类型通配符

### 无界通配符 ?
```java
// 可以接受任何类型的泛型
public static void printList(List<?> list) {
    for (Object obj : list) {
        System.out.println(obj);
    }
}

// 使用
printList(Arrays.asList(1, 2, 3));
printList(Arrays.asList("A", "B", "C"));
```

### 上界通配符 ? extends T
```java
// 可以接受T及其子类
public static double sumOfList(List<? extends Number> list) {
    double sum = 0;
    for (Number n : list) {
        sum += n.doubleValue();
    }
    return sum;
}

// 使用
List<Integer> ints = Arrays.asList(1, 2, 3);
List<Double> doubles = Arrays.asList(1.5, 2.5, 3.5);
sumOfList(ints);    // √
sumOfList(doubles); // √

// 注意：只能读取，不能写入（除了null）
List<? extends Number> list = new ArrayList<Integer>();
Number n = list.get(0);  // √ 读取
// list.add(123);         // × 不能写入（编译器不知道具体类型）
```

### 下界通配符 ? super T
```java
// 可以接受T及其父类
public static void addNumbers(List<? super Integer> list) {
    list.add(1);     // √ 可以写入
    list.add(2);     // √
    // list.add(3.14); // × double不是Integer
}

// 使用
List<Number> numbers = new ArrayList<>();
List<Object> objects = new ArrayList<>();
addNumbers(numbers);  // √
addNumbers(objects);  // √

// 注意：读取时只能读到Object
Object obj = list.get(0);  // 只能读到Object
```

### PECS原则（Producer Extends, Consumer Super）
```java
// 生产者用extends（读取）
// 消费者用super（写入）

public class Collections {
    // copy是典型的PECS示例
    public static <T> void copy(List<? super T> dest, List<? extends T> src) {
        for (int i = 0; i < src.size(); i++) {
            dest.set(i, src.get(i));
        }
    }
}
```

## 六、类型擦除

泛型信息只在编译期存在，运行期被擦除为原始类型。

```java
// 编译期
List<String> stringList = new ArrayList<>();
List<Integer> intList = new ArrayList<>();

// 运行期（类型擦除后）
// List<String> 和 List<Integer> 都是 List
System.out.println(stringList.getClass() == intList.getClass());  // true
```

### 擦除后的替换规则
- 无界类型参数 `<T>` → `Object`
- 有界类型参数 `<T extends SomeClass>` → `SomeClass`

```java
// 编译期：public class Box<T> { T content; }
// 擦除后：public class Box { Object content; }

// 编译期：public class NumberBox<T extends Number> { T value; }
// 擦除后：public class NumberBox { Number value; }
```

### 桥接方法
```java
// 泛型接口
public interface Comparable<T> {
    int compareTo(T o);
}

// 实现
public class Person implements Comparable<Person> {
    private int age;

    @Override
    public int compareTo(Person o) {
        return Integer.compare(this.age, o.age);
    }
}

// 编译后自动生成桥接方法（为了多态）
// public int compareTo(Object o) {
//     return compareTo((Person) o);
// }
```

## 七、泛型的限制

```java
// 1. 不能实例化类型参数
T obj = new T();  // 编译错误

// 2. 不能创建泛型数组
T[] array = new T[10];  // 编译错误
// 正确方式
T[] array = (T[]) new Object[10];

// 3. 静态成员不能使用类类型参数
public class Box<T> {
    private static T value;  // 编译错误
}

// 4. 不能instanceof泛型类型
if (obj instanceof List<String>) {  // 编译错误
}
if (obj instanceof List<?>) {  // √ 使用通配符
}

// 5. 不能使用基本类型作为类型参数
List<int> list = new ArrayList<>();  // 编译错误
List<Integer> list = new ArrayList<>();  // √ 使用包装类

// 6. 不能抛出或捕获泛型异常
class MyException<T> extends Exception { }  // 编译错误

// 7. 泛型不能用于枚举
public enum MyEnum<T> { }  // 编译错误
```

## 相关标签
Java泛型, 泛型类, 泛型方法, 类型通配符, 类型擦除, PECS
