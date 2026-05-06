#!/usr/bin/env python3
"""
Generate comprehensive Java knowledge lecture MD files and insert into database.
Covers all major Java topics with detailed content and code examples.
"""
import uuid
import os
import subprocess

UPLOAD_DIR = "D:/workfordasan/uploads"
DB_USER = "root"
DB_PASS = "yu6670980506"
DB_NAME = "labex"
TEACHER_ID = 2
LECTURE_TYPE = 1  # 1=课件

lectures = []

def add_lecture(name, md_content):
    filename = str(uuid.uuid4()) + ".md"
    filepath = os.path.join(UPLOAD_DIR, filename)
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(md_content)
    size = os.path.getsize(filepath)
    lectures.append((name, filename, size, name))
    print(f"  Created: {name} ({filename}, {size} bytes)")

# ============================================================
# 1. Java基础 - 数据类型、运算符、流程控制
# ============================================================
add_lecture("Java基础 - 数据类型与运算符", """# Java基础 - 数据类型与运算符

## 一、Java语言概述

Java是一种面向对象的编程语言，由Sun Microsystems公司于1995年推出。Java具有跨平台、面向对象、安全性高、多线程等特点。

### Java程序结构
```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
```

## 二、基本数据类型

Java有8种基本数据类型（Primitive Types）：

| 类型 | 大小 | 范围 | 默认值 |
|------|------|------|--------|
| byte | 1字节 | -128 ~ 127 | 0 |
| short | 2字节 | -32768 ~ 32767 | 0 |
| int | 4字节 | -2^31 ~ 2^31-1 | 0 |
| long | 8字节 | -2^63 ~ 2^63-1 | 0L |
| float | 4字节 | ±3.4E-38 ~ ±3.4E+38 | 0.0f |
| double | 8字节 | ±1.7E-308 ~ ±1.7E+308 | 0.0d |
| char | 2字节 | 0 ~ 65535 | '\\u0000' |
| boolean | 未定义 | true / false | false |

### 数据类型的转换
```java
// 自动类型转换（隐式）：小范围→大范围
int i = 100;
long l = i;          // 自动转换
double d = i;        // 自动转换

// 强制类型转换（显式）：大范围→小范围
double pi = 3.14159;
int p = (int) pi;    // 强制转换，结果为3（精度丢失）

// 表达式中的自动提升
byte a = 10, b = 20;
int c = a + b;       // byte自动提升为int
```

## 三、运算符

### 算术运算符
```java
+ - * / %     // 加、减、乘、除、取余
++ --         // 自增、自减
int a = 10;
int b = a++;  // b=10, a=11（先赋值后自增）
int c = ++a;  // c=12, a=12（先自增后赋值）
```

### 关系运算符
```java
== != > < >= <=   // 返回boolean值
```
注意：比较两个对象的内容是否相等应使用 `equals()` 方法，而非 `==`。

### 逻辑运算符
```java
&&  ||  !         // 逻辑与、或、非（短路求值）
&   |   ^         // 逻辑与、或、异或（非短路）
```

### 位运算符
```java
&  |  ^  ~        // 按位与、或、异或、取反
<< >> >>>         // 左移、右移、无符号右移
```

### 三元运算符
```java
int max = (a > b) ? a : b;
```

## 四、流程控制

### 条件语句
```java
// if-else
if (score >= 90) {
    grade = 'A';
} else if (score >= 80) {
    grade = 'B';
} else {
    grade = 'C';
}

// switch（支持 int、String、enum）
switch (day) {
    case 1:  System.out.println("周一"); break;
    case 2:  System.out.println("周二"); break;
    default: System.out.println("未知");
}
```

### 循环语句
```java
// for循环
for (int i = 0; i < 10; i++) {
    System.out.println(i);
}

// 增强for循环（foreach）
int[] arr = {1, 2, 3};
for (int num : arr) {
    System.out.println(num);
}

// while循环
int i = 0;
while (i < 10) {
    System.out.println(i++);
}

// do-while循环
int j = 0;
do {
    System.out.println(j++);
} while (j < 10);
```

### break和continue
```java
// break：跳出当前循环
for (int i = 0; i < 10; i++) {
    if (i == 5) break;      // 跳出整个循环
}

// continue：跳过当前迭代
for (int i = 0; i < 10; i++) {
    if (i % 2 == 0) continue; // 跳过偶数
    System.out.println(i);
}

// 带标签的break
outer:
for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
        if (i == 1 && j == 1) break outer;
    }
}
```

## 五、数组

### 数组的声明和初始化
```java
// 声明
int[] arr1;
int arr2[];

// 静态初始化
int[] arr = {1, 2, 3, 4, 5};

// 动态初始化
int[] arr = new int[5];
arr[0] = 1;

// 二维数组
int[][] matrix = {
    {1, 2, 3},
    {4, 5, 6},
    {7, 8, 9}
};
```

### 数组常用操作
```java
// 数组长度
int len = arr.length;

// 数组拷贝
int[] copy = Arrays.copyOf(arr, arr.length);
int[] copyRange = Arrays.copyOfRange(arr, 1, 3);

// 数组排序
Arrays.sort(arr);

// 数组转字符串
String str = Arrays.toString(arr);

// 二分查找
int index = Arrays.binarySearch(arr, 5);
```

## 六、常用工具类

### Math类
```java
Math.abs(-10);       // 绝对值 → 10
Math.max(10, 20);    // 最大值 → 20
Math.min(10, 20);    // 最小值 → 10
Math.pow(2, 10);     // 幂运算 → 1024.0
Math.sqrt(16);       // 平方根 → 4.0
Math.random();       // [0.0, 1.0)随机数
Math.round(3.6);     // 四舍五入 → 4
Math.ceil(3.2);      // 向上取整 → 4.0
Math.floor(3.8);     // 向下取整 → 3.0
```

## 相关标签
Java基础, 数据类型, 运算符, 流程控制, 数组
""")

# ============================================================
# 2. Java面向对象编程 - 类、对象、封装、继承、多态
# ============================================================
add_lecture("Java面向对象编程基础", """# Java面向对象编程基础

## 一、面向对象概述

面向对象编程（OOP）是一种编程范式，将程序视为一组相互协作的对象。Java是一门强制面向对象的语言。

### 三大特性
- **封装**：隐藏内部实现，暴露安全接口
- **继承**：复用父类属性和方法，扩展新功能
- **多态**：同一方法在不同对象上有不同行为

## 二、类与对象

### 类的定义
```java
public class Student {
    // 成员变量（属性）
    private String name;
    private int age;
    private String studentId;

    // 构造方法
    public Student(String name, int age) {
        this.name = name;
        this.age = age;
    }

    // 成员方法
    public void study() {
        System.out.println(name + "正在学习");
    }

    // Getter/Setter
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
```

### 对象的创建和使用
```java
// 创建对象（实例化）
Student stu = new Student("张三", 20);
stu.study();                    // 调用方法
stu.setName("李四");            // 修改属性
String name = stu.getName();    // 获取属性
```

### 构造方法
```java
public class Person {
    private String name;
    private int age;

    // 无参构造（如果没写任何构造，编译器自动生成）
    public Person() {}

    // 有参构造
    public Person(String name) {
        this.name = name;
    }

    // 重载构造
    public Person(String name, int age) {
        this(name);        // 调用本类其他构造（必须第一行）
        this.age = age;
    }
}
```

### this关键字
```java
public class Teacher {
    private String name;

    public void setName(String name) {
        this.name = name;   // this区分成员变量和局部变量
    }

    public Teacher() {
        this("默认教师");   // this()调用本类其他构造
    }

    public Teacher(String name) {
        this.name = name;
    }

    public Teacher getInstance() {
        return this;        // 返回当前对象引用
    }
}
```

## 三、封装

### 封装的原则
```java
public class BankAccount {
    // 私有属性，外部不可直接访问
    private String accountNo;
    private double balance;

    // 公共方法提供安全访问
    public double getBalance() {
        return balance;
    }

    // 业务方法封装了逻辑
    public void deposit(double amount) {
        if (amount > 0) {
            balance += amount;
        }
    }

    public boolean withdraw(double amount) {
        if (amount > 0 && balance >= amount) {
            balance -= amount;
            return true;
        }
        return false;
    }
}
```
封装的目的是保护内部状态不被外部随意修改，通过方法提供受控的访问。

## 四、继承

### extends关键字
```java
// 父类
public class Animal {
    protected String name;

    public Animal(String name) {
        this.name = name;
    }

    public void eat() {
        System.out.println(name + "正在进食");
    }
}

// 子类继承父类
public class Dog extends Animal {
    public Dog(String name) {
        super(name);    // 调用父类构造方法
    }

    // 方法重写（Override）
    @Override
    public void eat() {
        System.out.println(name + "在吃狗粮");
    }

    // 子类特有方法
    public void bark() {
        System.out.println(name + "在叫：汪汪！");
    }
}
```

### 继承的特点
1. Java只支持**单继承**，一个类只能有一个直接父类
2. 子类继承父类所有非private的成员
3. 子类可以重写（Override）父类方法
4. 使用`super`调用父类构造和方法

### super关键字
```java
public class Cat extends Animal {
    public Cat(String name) {
        super(name);    // 调用父类构造（必须第一行）
    }

    @Override
    public void eat() {
        super.eat();    // 调用父类方法
        System.out.println("然后还喝了牛奶");
    }
}
```

### 继承中构造方法的执行顺序
```java
class A {
    public A() { System.out.println("A构造"); }
}

class B extends A {
    public B() { System.out.println("B构造"); }
}

class C extends B {
    public C() { System.out.println("C构造"); }
}

// new C() 输出：
// A构造
// B构造
// C构造
```

## 五、多态

### 多态的条件
1. 继承
2. 方法重写
3. 父类引用指向子类对象

```java
Animal animal = new Dog("旺财");
animal.eat();       // 调用的是Dog的eat方法（动态绑定）
// animal.bark();   // 编译错误！父类引用不能调用子类特有方法
```

### instanceof 运算符
```java
if (animal instanceof Dog) {
    Dog dog = (Dog) animal;   // 向下转型
    dog.bark();
}
```

### 多态的应用
```java
public class Zoo {
    // 多态参数：可以接收任何Animal子类
    public void feed(Animal animal) {
        animal.eat();
    }
}

// 使用
Zoo zoo = new Zoo();
zoo.feed(new Dog("旺财"));     // 自动调用Dog的eat()
zoo.feed(new Cat("咪咪"));     // 自动调用Cat的eat()
```

## 六、final关键字

```java
final class FinalClass {}     // 不可被继承
final double PI = 3.14159;    // 常量，不可修改
public final void method() {} // 不可被重写
```

## 七、static关键字

```java
public class Counter {
    private static int count = 0;  // 类变量（所有实例共享）

    private int id;

    public Counter() {
        count++;
        this.id = count;
    }

    public static int getCount() {  // 类方法
        return count;
    }

    public int getId() {
        return id;
    }
}

// 使用
Counter c1 = new Counter();
Counter c2 = new Counter();
System.out.println(Counter.getCount());  // 2（推荐通过类名调用）
```

## 相关标签
Java OOP, 类与对象, 封装, 继承, 多态, static, final
""")

# ============================================================
# 3. Java面向对象高级特性
# ============================================================
add_lecture("Java面向对象高级特性 - 抽象类、接口、内部类、枚举", """# Java面向对象高级特性

## 一、抽象类

### abstract关键字
抽象类是不能实例化的类，用于定义抽象层次的结构。

```java
public abstract class Shape {
    protected String color;

    public Shape(String color) {
        this.color = color;
    }

    // 抽象方法（没有方法体，子类必须实现）
    public abstract double getArea();

    // 具体方法
    public String getColor() {
        return color;
    }
}

public class Circle extends Shape {
    private double radius;

    public Circle(String color, double radius) {
        super(color);
        this.radius = radius;
    }

    @Override
    public double getArea() {
        return Math.PI * radius * radius;
    }
}
```

### 抽象类的特点
- 使用`abstract`关键字声明
- 不能通过`new`实例化
- 可以包含抽象方法和具体方法
- 抽象方法的子类必须实现所有抽象方法（除非子类也是抽象类）
- 可以有构造方法（供子类调用）

## 二、接口

### 接口的定义与实现
```java
// 定义接口
public interface Flyable {
    // 常量（隐式 public static final）
    int MAX_SPEED = 1000;

    // 抽象方法（隐式 public abstract）
    void fly();

    // 默认方法（JDK 8+）
    default void glide() {
        System.out.println("滑翔中...");
    }

    // 静态方法（JDK 8+）
    static boolean isBird(Flyable f) {
        return f instanceof Bird;
    }
}

// 实现接口
public class Bird implements Flyable {
    @Override
    public void fly() {
        System.out.println("鸟儿在飞翔");
    }

    // glide() 使用默认实现
}
```

### 接口的多实现
```java
public interface Swimmable {
    void swim();
}

// Java类可以实现多个接口（弥补单继承的不足）
public class Duck implements Flyable, Swimmable {
    @Override
    public void fly() {
        System.out.println("鸭子飞");
    }

    @Override
    public void swim() {
        System.out.println("鸭子游");
    }
}
```

### 接口继承
```java
public interface Walkable {
    void walk();
}

// 接口可以多继承
public interface Movable extends Flyable, Walkable {
    void move();
}
```

### 抽象类 vs 接口

| 特性 | 抽象类 | 接口 |
|------|--------|------|
| 实例化 | 不能 | 不能 |
| 构造方法 | 可以有 | 不能有 |
| 成员变量 | 任意类型 | public static final |
| 方法 | 抽象+具体 | 抽象+默认+静态 |
| 继承/实现 | 单继承 | 多实现 |
| 设计思想 | is-a 关系 | can-do 能力 |

## 三、内部类（Nested Classes）

### 成员内部类
```java
public class Outer {
    private int outerField = 10;

    // 成员内部类
    public class Inner {
        public void display() {
            System.out.println(outerField);  // 访问外部类成员
        }
    }
}

// 使用
Outer outer = new Outer();
Outer.Inner inner = outer.new Inner();
inner.display();
```

### 静态内部类
```java
public class Outer {
    private static int staticField = 100;
    private int instanceField = 10;

    // 静态内部类
    public static class StaticInner {
        public void display() {
            System.out.println(staticField);     // 只能访问外部静态成员
            // System.out.println(instanceField); // 编译错误！
        }
    }
}

// 使用
Outer.StaticInner inner = new Outer.StaticInner();
```

### 局部内部类
```java
public class Outer {
    public void method() {
        int localVar = 5;

        // 局部内部类（作用域在方法内）
        class LocalInner {
            public void print() {
                System.out.println(localVar);
            }
        }

        LocalInner inner = new LocalInner();
        inner.print();
    }
}
```

### 匿名内部类
```java
// 匿名内部类（常用于事件监听、回调）
Runnable task = new Runnable() {
    @Override
    public void run() {
        System.out.println("任务执行中");
    }
};

// Lambda简化（JDK 8+）
Runnable task2 = () -> System.out.println("任务执行中");
```

## 四、枚举（Enum）

### 枚举的定义
```java
public enum Day {
    MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY
}

// 使用
Day today = Day.MONDAY;
System.out.println(today);           // MONDAY
System.out.println(today.ordinal()); // 0（位置）
System.out.println(today.name());    // MONDAY
Day d = Day.valueOf("MONDAY");      // 字符串转枚举
Day[] days = Day.values();           // 所有枚举值
```

### 枚举的高级用法
```java
public enum OrderStatus {
    PENDING(0, "待支付"),
    PAID(1, "已支付"),
    SHIPPED(2, "已发货"),
    DELIVERED(3, "已送达"),
    CANCELLED(-1, "已取消");

    private final int code;
    private final String description;

    OrderStatus(int code, String description) {
        this.code = code;
        this.description = description;
    }

    public int getCode() { return code; }
    public String getDescription() { return description; }

    public boolean canCancel() {
        return this == PENDING || this == PAID;
    }

    public static OrderStatus fromCode(int code) {
        for (OrderStatus status : values()) {
            if (status.code == code) return status;
        }
        throw new IllegalArgumentException("无效状态码: " + code);
    }
}
```

## 五、包装类

| 基本类型 | 包装类 |
|---------|--------|
| byte | Byte |
| short | Short |
| int | Integer |
| long | Long |
| float | Float |
| double | Double |
| char | Character |
| boolean | Boolean |

### 自动装箱与拆箱
```java
// 自动装箱：int → Integer
Integer num = 100;    // 等价于 Integer.valueOf(100)

// 自动拆箱：Integer → int
int value = num;      // 等价于 num.intValue()

// 缓存范围
Integer a = 127;  // 使用缓存
Integer b = 127;  // 使用缓存
System.out.println(a == b);       // true（-128~127之间使用缓存）

Integer c = 128;  // 超出缓存范围
Integer d = 128;  // 超出缓存范围
System.out.println(c == d);       // false（不同对象）
System.out.println(c.equals(d));  // true（推荐使用equals）
```

## 相关标签
Java高级特性, 抽象类, 接口, 内部类, 枚举, 包装类
""")

# ============================================================
# 4. Java集合框架（上）- List, Set, Queue
# ============================================================
add_lecture("Java集合框架（上）- List、Set、Queue", """# Java集合框架（上）

## 一、集合框架概述

Java集合框架（Java Collections Framework）提供了一套统一的接口和实现类，用于存储和操作对象集合。

### 集合体系结构
```
Collection（接口）
  ├── List（有序可重复）
  │     ├── ArrayList（数组实现）
  │     ├── LinkedList（链表实现）
  │     └── Vector（线程安全，已过时）
  │           └── Stack
  ├── Set（无序不可重复）
  │     ├── HashSet（哈希表）
  │     │     └── LinkedHashSet（维护插入顺序）
  │     └── TreeSet（红黑树，排序）
  └── Queue（队列）
        ├── LinkedList（双端队列）
        ├── PriorityQueue（优先级队列）
        └── ArrayDeque（数组双端队列）

Map（接口，键值对）
  ├── HashMap（哈希表）
  │     └── LinkedHashMap（维护插入/访问顺序）
  ├── TreeMap（红黑树，键排序）
  └── Hashtable（线程安全，已过时）
```

## 二、List接口

### ArrayList（动态数组）
```java
// 创建
List<String> list = new ArrayList<>();

// 增
list.add("A");
list.add(1, "B");      // 指定位置插入
list.addAll(otherList); // 批量添加

// 删
list.remove("A");       // 删除指定元素
list.remove(0);         // 删除指定位置
list.clear();           // 清空全部

// 改
list.set(0, "X");       // 修改指定位置

// 查
String s = list.get(0); // 获取指定位置
int idx = list.indexOf("A"); // 查找位置
boolean b = list.contains("A");
boolean e = list.isEmpty();
int size = list.size();

// 遍历
for (int i = 0; i < list.size(); i++) {
    System.out.println(list.get(i));
}
for (String s : list) {
    System.out.println(s);
}
list.forEach(System.out::println);  // Lambda
Iterator<String> it = list.iterator();
while (it.hasNext()) {
    System.out.println(it.next());
}
```

**ArrayList特点**：
- 底层是Object[]数组
- 初始容量10，每次扩容1.5倍
- 随机访问快（O(1)），插入删除慢（O(n)）
- 线程不安全

### LinkedList（双向链表）
```java
List<String> list = new LinkedList<>();

// LinkedList特有方法（实现了Deque接口）
LinkedList<String> ll = new LinkedList<>();
ll.addFirst("A");       // 头部添加
ll.addLast("B");        // 尾部添加
ll.getFirst();          // 获取头部
ll.getLast();           // 获取尾部
ll.removeFirst();       // 删除头部
ll.removeLast();        // 删除尾部
```

**LinkedList特点**：
- 底层是双向链表
- 随机访问慢（O(n)），插入删除快（O(1)）
- 可作为List、Queue、Deque使用

### ArrayList vs LinkedList
| 对比维度 | ArrayList | LinkedList |
|---------|-----------|------------|
| 底层实现 | Object[]数组 | 双向链表 |
| 随机访问 | O(1) | O(n) |
| 头部插入 | O(n) | O(1) |
| 尾部插入 | O(1)*（可能扩容） | O(1) |
| 中间插入 | O(n) | O(n) |
| 内存占用 | 较少 | 较多（存储前后指针） |

*带星号表示在大多数情况下

## 三、Set接口

### HashSet
```java
Set<String> set = new HashSet<>();

set.add("Apple");
set.add("Banana");
set.add("Apple");     // 重复元素，不会添加
set.remove("Banana");

// 遍历
for (String s : set) {
    System.out.println(s);
}

// 其他方法
int size = set.size();
boolean b = set.contains("Apple");
boolean e = set.isEmpty();
set.clear();
```

**HashSet特点**：
- 底层是HashMap（存储到key，value固定为PRESENT）
- 元素**无序**
- 元素不可重复（基于hashCode和equals）
- 允许null元素
- 线程不安全

**HashSet去重原理**：
1. 先调用hashCode()计算哈希值
2. 如果哈希值不同，直接存到不同位置
3. 如果哈希值相同，调用equals()比较
4. equals()返回true则不添加

**正确重写hashCode和equals**：
```java
public class Student {
    private String id;
    private String name;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Student)) return false;
        Student s = (Student) o;
        return Objects.equals(id, s.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
```
**规则**：equals相等则hashCode必须相等，但hashCode相等不一定equals相等。

### LinkedHashSet
```java
Set<String> set = new LinkedHashSet<>();
```
**LinkedHashSet特点**：
- 继承自HashSet
- 内部使用LinkedHashMap
- **维护插入顺序**
- 性能略低于HashSet

### TreeSet
```java
Set<Integer> set = new TreeSet<>();
set.add(5); set.add(1); set.add(3); // 结果为 [1, 3, 5]（自然排序）

// 自定义排序
Set<Person> people = new TreeSet<>((p1, p2) -> p1.age - p2.age);

// 或实现Comparable接口
public class Person implements Comparable<Person> {
    private int age;

    @Override
    public int compareTo(Person other) {
        return Integer.compare(this.age, other.age);
    }
}
```

**TreeSet特点**：
- 底层是TreeMap（红黑树）
- 元素**有序**（自然顺序或比较器顺序）
- 性能：log(n) 时间复杂度
- 不能为null

## 四、Queue接口

### PriorityQueue（优先级队列）
```java
// 最小堆（默认）
Queue<Integer> pq = new PriorityQueue<>();
pq.offer(5); pq.offer(1); pq.offer(3);
System.out.println(pq.poll());  // 1（最小元素先出）
System.out.println(pq.peek());  // 3（查看队头）

// 最大堆
Queue<Integer> maxPq = new PriorityQueue<>((a, b) -> b - a);
```
**特点**：基于堆实现，元素按优先级排序，offer/poll/peek时间复杂度O(log n)。

### ArrayDeque（双端队列）
```java
Deque<String> deque = new ArrayDeque<>();
deque.addFirst("A");
deque.addLast("B");
deque.offerFirst("C");  // 推荐：失败返回false
deque.offerLast("D");

deque.removeFirst();
deque.removeLast();
deque.pollFirst();      // 推荐：失败返回null
deque.pollLast();

deque.getFirst();       // 查看
deque.getLast();
deque.peekFirst();      // 推荐：失败返回null
deque.peekLast();
```
**特点**：数组实现，比LinkedList更高效，可用于实现栈或队列。

## 五、迭代器

```java
List<String> list = Arrays.asList("A", "B", "C");
Iterator<String> it = list.iterator();

while (it.hasNext()) {
    String s = it.next();
    if ("B".equals(s)) {
        it.remove();      // 安全删除
    }
}

// ListIterator（List特有，可双向遍历）
ListIterator<String> li = list.listIterator();
li.hasNext(); li.next(); li.nextIndex();
li.hasPrevious(); li.previous(); li.previousIndex();
```

### 快速失败（fail-fast）机制
```java
List<String> list = new ArrayList<>();
list.add("A"); list.add("B");

// 遍历时修改会抛出ConcurrentModificationException
for (String s : list) {
    if ("A".equals(s)) {
        list.remove(s);  // 抛出异常！
    }
}

// 正确方式：使用迭代器的remove
Iterator<String> it = list.iterator();
while (it.hasNext()) {
    if ("A".equals(it.next())) {
        it.remove();      // 安全
    }
}
```

## 相关标签
Java集合框架, List, ArrayList, LinkedList, Set, HashSet, TreeSet, Queue, 迭代器
""")

# ============================================================
# 5. Java集合框架（下）- Map、工具类
# ============================================================
add_lecture("Java集合框架（下）- Map与Collections工具类", """# Java集合框架（下）

## 一、Map接口

Map存储键值对（Key-Value），键不可重复，每个键映射到一个值。

### HashMap
```java
// 创建
Map<String, Integer> map = new HashMap<>();

// 增/改
map.put("Apple", 10);
map.put("Banana", 20);
map.put("Apple", 15);     // 覆盖原值

// 删
map.remove("Banana");     // 删除指定键
map.clear();              // 清空全部

// 查
Integer val = map.get("Apple");       // 获取值，不存在返回null
Integer val2 = map.getOrDefault("Orange", 0); // 不存在返回默认值
boolean k = map.containsKey("Apple"); // 是否包含键
boolean v = map.containsValue(15);    // 是否包含值
int size = map.size();
boolean e = map.isEmpty();

// 遍历
// 方式1：遍历键值对
for (Map.Entry<String, Integer> entry : map.entrySet()) {
    String key = entry.getKey();
    Integer value = entry.getValue();
}

// 方式2：遍历键
for (String key : map.keySet()) {
    Integer value = map.get(key);
}

// 方式3：遍历值
for (Integer value : map.values()) {
    System.out.println(value);
}

// 方式4：Lambda遍历
map.forEach((key, value) -> System.out.println(key + "=" + value));
```

**HashMap特点**：
- 底层：数组 + 链表 + 红黑树（JDK 8+）
- 初始容量16，负载因子0.75
- 扩容：容量×2
- 允许null键和null值
- 线程不安全
- 默认无序

**HashMap工作原理**：
1. 计算key的hashCode()，经扰动函数处理
2. 计算数组索引位置：(n - 1) & hash
3. 如果该位置为空，直接放入
4. 如果冲突，用equals()比较key
5. 相同则覆盖，不同则链表/红黑树存储
6. 链表长度≥8且数组长度≥64时转为红黑树

### LinkedHashMap
```java
// 维护插入顺序
Map<String, Integer> map = new LinkedHashMap<>();
map.put("A", 1); map.put("B", 2); map.put("C", 3);
// 遍历顺序：A → B → C

// 维护访问顺序（可用于LRU缓存）
LinkedHashMap<String, Integer> lru = new LinkedHashMap<>(16, 0.75f, true) {
    @Override
    protected boolean removeEldestEntry(Map.Entry eldest) {
        return size() > 100;  // 容量超过100时删除最久未访问的
    }
};
```

### TreeMap
```java
// 默认按key自然顺序排序
Map<String, Integer> map = new TreeMap<>();
map.put("C", 3); map.put("A", 1); map.put("B", 2);
// 遍历顺序：A → B → C（按key排序）

// 自定义排序
Map<Integer, String> descMap = new TreeMap<>((a, b) -> b - a);

// TreeMap特有方法
TreeMap<String, Integer> tm = new TreeMap<>();
tm.firstKey();          // 最小键
tm.lastKey();           // 最大键
tm.lowerKey("C");       // 小于C的最大键
tm.higherKey("C");      // 大于C的最小键
tm.floorKey("C");       // ≤C的最大键
tm.ceilingKey("C");     // ≥C的最小键
tm.subMap("A", "D");    // [A, D)子映射
tm.headMap("C");        // <C的子映射
tm.tailMap("C");        // ≥C的子映射
```

### ConcurrentHashMap（线程安全）
```java
// 线程安全的HashMap
Map<String, Integer> map = new ConcurrentHashMap<>();

// JDK 7：分段锁（Segment数组，默认16段）
// JDK 8+：CAS + synchronized（只锁数组桶的头节点）
```
**推荐**：多线程环境下使用ConcurrentHashMap而非Hashtable。

### HashMap vs Hashtable vs ConcurrentHashMap
| 特性 | HashMap | Hashtable | ConcurrentHashMap |
|------|---------|-----------|-------------------|
| 线程安全 | 否 | 是 | 是 |
| 锁机制 | 无 | 方法级synchronized | 桶级锁/CAS |
| 性能 | 高 | 低 | 中 |
| null键 | 允许 | 不允许 | 不允许 |
| null值 | 允许 | 不允许 | 不允许 |

## 二、Collections工具类

```java
List<Integer> list = new ArrayList<>();
list.add(5); list.add(1); list.add(3); list.add(1);

// 排序
Collections.sort(list);                          // 升序
Collections.sort(list, Collections.reverseOrder()); // 降序

// 二分查找（必须先排序）
int idx = Collections.binarySearch(list, 3);

// 反转
Collections.reverse(list);

// 打乱
Collections.shuffle(list);

// 最大值/最小值
int max = Collections.max(list);
int min = Collections.min(list);

// 填充
Collections.fill(list, 0);   // 所有元素设为0

// 复制
List<Integer> dest = new ArrayList<>(Collections.nCopies(list.size(), 0));
Collections.copy(dest, list);

// 翻转
Collections.rotate(list, 2);  // 右移2位

// 频率
int freq = Collections.frequency(list, 1);  // 元素1出现次数

// 不可变集合
List<Integer> unmodifiable = Collections.unmodifiableList(list);
// unmodifiable.add(10); // 抛出UnsupportedOperationException

// 空集合
List<String> emptyList = Collections.emptyList();
Set<String> emptySet = Collections.emptySet();
Map<String, String> emptyMap = Collections.emptyMap();

// 单元素集合
List<String> single = Collections.singletonList("A");
Set<String> singleSet = Collections.singleton("A");
Map<String, String> singleMap = Collections.singletonMap("k", "v");

// 同步包装（不推荐，性能差）
List<String> syncList = Collections.synchronizedList(new ArrayList<>());
```

## 三、Arrays工具类

```java
int[] arr = {5, 1, 3, 2, 4};

// 排序
Arrays.sort(arr);                     // [1, 2, 3, 4, 5]
Arrays.sort(arr, 1, 4);               // 指定范围[1,4)排序
Arrays.parallelSort(arr);             // 并行排序（大数据量时更快）

// 二分查找（必须排序后）
int idx = Arrays.binarySearch(arr, 3);

// 填充
Arrays.fill(arr, 0);
Arrays.fill(arr, 1, 4, 0);           // 指定范围填充

// 拷贝
int[] copy = Arrays.copyOf(arr, 5);
int[] range = Arrays.copyOfRange(arr, 1, 4);

// 比较
boolean eq = Arrays.equals(arr1, arr2);
int cmp = Arrays.compare(arr1, arr2);  // 字典序比较

// 哈希码
int hash = Arrays.hashCode(arr);

// 转字符串
String str = Arrays.toString(arr);    // [1, 2, 3, 4, 5]
String deepStr = Arrays.deepToString(matrix); // 多维数组

// 转换为List
List<Integer> list = Arrays.asList(1, 2, 3);
// 注意：返回的List长度固定，不能add/remove
// 正确方式：
List<Integer> safeList = new ArrayList<>(Arrays.asList(1, 2, 3));
```

## 四、Comparable vs Comparator

### Comparable（内部比较器）
```java
public class Student implements Comparable<Student> {
    private String name;
    private int score;

    @Override
    public int compareTo(Student other) {
        // 返回负数：小于；0：等于；正数：大于
        return Integer.compare(this.score, other.score);
    }
}

// 使用
List<Student> students = new ArrayList<>();
Collections.sort(students);  // 按score排序
```

### Comparator（外部比较器）
```java
// 使用匿名内部类
Comparator<Student> byName = new Comparator<Student>() {
    @Override
    public int compare(Student s1, Student s2) {
        return s1.getName().compareTo(s2.getName());
    }
};

// Lambda
Comparator<Student> byScoreAsc = (s1, s2) -> Integer.compare(s1.getScore(), s2.getScore());
Comparator<Student> byScoreDesc = (s1, s2) -> Integer.compare(s2.getScore(), s1.getScore());

// 链式比较器
Comparator<Student> complex = Comparator
    .comparing(Student::getGrade)
    .thenComparing(Student::getScore, Comparator.reverseOrder())
    .thenComparing(Student::getName);

// 使用
Collections.sort(students, byName);
students.sort(byScoreAsc);
```

## 相关标签
Java集合, Map, HashMap, TreeMap, LinkedHashMap, ConcurrentHashMap, Collections, Arrays, Comparable, Comparator
""")

# ============================================================
# 6. Java异常处理
# ============================================================
add_lecture("Java异常处理机制", """# Java异常处理机制

## 一、异常概述

异常（Exception）是程序运行过程中出现的非正常情况。Java通过面向对象的方式处理异常。

### 异常体系结构
```
Throwable（根类）
  ├── Error（错误，不可处理）
  │     ├── OutOfMemoryError
  │     ├── StackOverflowError
  │     └── NoClassDefFoundError
  └── Exception（异常，可处理）
        ├── RuntimeException（运行时异常/非受检异常）
        │     ├── NullPointerException
        │     ├── ArrayIndexOutOfBoundsException
        │     ├── IllegalArgumentException
        │     ├── NumberFormatException
        │     └── ArithmeticException
        └── CheckedException（受检异常，必须处理）
              ├── IOException
              ├── SQLException
              ├── FileNotFoundException
              └── ClassNotFoundException
```

**Error**：JVM内部错误，程序无法处理，如OOM、StackOverflow。
**RuntimeException**：运行时异常，通常由程序逻辑错误导致，不强制处理。
**CheckedException**：编译时检查的异常，必须显式处理（try-catch或throws）。

## 二、异常处理方式

### try-catch-finally
```java
try {
    // 可能发生异常的代码
    int result = 10 / 0;
    System.out.println("这行不会执行");
} catch (ArithmeticException e) {
    // 捕获并处理异常
    System.out.println("除数不能为零: " + e.getMessage());
} catch (Exception e) {
    // 多个catch块（子类在前，父类在后）
    e.printStackTrace();
} finally {
    // 无论是否发生异常都会执行（通常用于释放资源）
    System.out.println("finally总是执行");
}
```

### try-with-resources（JDK 7+）
自动关闭实现了AutoCloseable的资源，代码更简洁。
```java
// 传统方式（需要手动关闭）
BufferedReader br = null;
try {
    br = new BufferedReader(new FileReader("test.txt"));
    System.out.println(br.readLine());
} catch (IOException e) {
    e.printStackTrace();
} finally {
    if (br != null) {
        try {
            br.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

// try-with-resources（自动关闭）
try (BufferedReader br = new BufferedReader(new FileReader("test.txt"))) {
    System.out.println(br.readLine());
} catch (IOException e) {
    e.printStackTrace();
}
```

### 多异常捕获（JDK 7+）
```java
try {
    // 可能抛出多种异常
} catch (IOException | SQLException e) {
    // 使用 | 分隔多个异常类型
    // 此时e是final的（不可重新赋值）
    System.out.println(e.getMessage());
}
```

## 三、throws和throw

### throws（声明异常）
```java
// 方法声明时告知调用者可能抛出的异常
public void readFile(String path) throws FileNotFoundException, IOException {
    // 如果文件不存在，FileNotFoundException被抛出
    // 由调用者处理
}

public void process() throws Exception {
    // 可以声明父类异常
}
```

### throw（抛出异常）
```java
public void setAge(int age) {
    if (age < 0 || age > 150) {
        throw new IllegalArgumentException("年龄不合法: " + age);
    }
    this.age = age;
}
```

## 四、自定义异常

### 继承Exception（受检异常）
```java
public class InsufficientBalanceException extends Exception {
    public InsufficientBalanceException(String message) {
        super(message);
    }

    public InsufficientBalanceException(String message, Throwable cause) {
        super(message, cause);
    }
}
```

### 继承RuntimeException（非受检异常）
```java
public class BusinessException extends RuntimeException {
    private int errorCode;

    public BusinessException(int errorCode, String message) {
        super(message);
        this.errorCode = errorCode;
    }

    public int getErrorCode() {
        return errorCode;
    }
}
```

### 自定义异常的使用
```java
public class BankAccount {
    private double balance;

    public void withdraw(double amount) throws InsufficientBalanceException {
        if (amount <= 0) {
            throw new IllegalArgumentException("金额必须为正数");
        }
        if (amount > balance) {
            throw new InsufficientBalanceException("余额不足");
        }
        balance -= amount;
    }
}
```

## 五、异常链

```java
try {
    // 数据库操作
} catch (SQLException e) {
    // 将原始异常包装为业务异常（保留异常链）
    throw new BusinessException(500, "数据库操作失败", e);
}
```

### 异常的最佳实践

1. **不要捕获Throwable或Error**：Error是JVM级别的严重错误
2. **不要忽略异常**：空的catch块是罪恶
3. **尽量使用特定异常**：不要总是catch Exception
4. **抛异常时提供详细信息**：包含上下文数据
5. **早抛出，晚捕获**：在合适的层次处理异常
6. **使用try-with-resources**：确保资源正确关闭
7. **不要用异常控制流程**：异常成本高

```java
// ❌ 错误：用异常控制流程
try {
    Integer.parseInt(str);
} catch (NumberFormatException e) {
    // 不是数字
}

// ✅ 正确：先判断
if (str != null && str.matches("\\\\d+")) {
    int num = Integer.parseInt(str);
}
```

## 六、异常性能

创建异常对象成本较高（需要填充堆栈），但try-catch本身几乎无开销。

```java
// 如果异常很可能发生，先检查再操作
// ❌ 异常触发频繁时性能差
try {
    return list.get(index);
} catch (IndexOutOfBoundsException e) {
    return null;
}

// ✅ 先检查
if (index >= 0 && index < list.size()) {
    return list.get(index);
}
return null;
```

## 七、常见异常及原因

| 异常 | 常见原因 |
|------|---------|
| NullPointerException | 调用null对象的方法或属性 |
| ArrayIndexOutOfBoundsException | 数组下标越界 |
| ArithmeticException | 算术异常，如除零 |
| ClassCastException | 类型转换失败 |
| NumberFormatException | 字符串转数字失败 |
| IllegalArgumentException | 方法参数不合法 |
| IllegalStateException | 对象状态不合法 |
| UnsupportedOperationException | 不支持的操作 |
| ConcurrentModificationException | 并发修改异常 |
| StackOverflowError | 递归太深，栈溢出 |
| OutOfMemoryError | JVM内存不足 |

## 相关标签
Java异常, Exception, RuntimeException, try-catch, throws, throw, 自定义异常
""")

# ============================================================
# 7. Java I/O流
# ============================================================
add_lecture("Java I/O流 - 字节流、字符流、NIO", """# Java I/O流

## 一、I/O流概述

Java I/O（Input/Output）通过流（Stream）来实现数据的读写操作。流是一组有序的数据序列。

### 流的分类
```
按流向分：
  - 输入流（InputStream/Reader）：读取数据
  - 输出流（OutputStream/Writer）：写入数据

按数据单位分：
  - 字节流（InputStream/OutputStream）：处理byte（8位）
  - 字符流（Reader/Writer）：处理char（16位）

按功能分：
  - 节点流：直接连接数据源
  - 处理流：包装节点流，提供额外功能
```

### 四大基类
| 类名 | 字节输入流 | 字节输出流 | 字符输入流 | 字符输出流 |
|------|-----------|-----------|-----------|-----------|
| 抽象基类 | InputStream | OutputStream | Reader | Writer |
| 文件流 | FileInputStream | FileOutputStream | FileReader | FileWriter |
| 缓冲流 | BufferedInputStream | BufferedOutputStream | BufferedReader | BufferedWriter |
| 转换流 | - | - | InputStreamReader | OutputStreamWriter |

## 二、字节流

### FileInputStream / FileOutputStream
```java
// 文件输入流 - 读取文件
try (FileInputStream fis = new FileInputStream("input.txt")) {
    // 方式1：逐个字节读取
    int data;
    while ((data = fis.read()) != -1) {
        System.out.print((char) data);
    }

    // 方式2：使用缓冲区
    byte[] buffer = new byte[1024];
    int bytesRead;
    while ((bytesRead = fis.read(buffer)) != -1) {
        System.out.println("读取了 " + bytesRead + " 字节");
    }
}

// 文件输出流 - 写入文件
try (FileOutputStream fos = new FileOutputStream("output.txt")) {
    fos.write("Hello, World!".getBytes());
    fos.write(65);  // 写入字节 'A'
}
```

### BufferedInputStream / BufferedOutputStream
```java
// 使用缓冲流提高性能（默认缓冲区8192字节）
try (BufferedInputStream bis = new BufferedInputStream(
        new FileInputStream("large.txt"));
     BufferedOutputStream bos = new BufferedOutputStream(
        new FileOutputStream("copy.txt"))) {

    byte[] buffer = new byte[4096];
    int len;
    while ((len = bis.read(buffer)) != -1) {
        bos.write(buffer, 0, len);
    }
    bos.flush();  // 刷新缓冲区
}
```

### DataInputStream / DataOutputStream
```java
// 读写基本数据类型
try (DataOutputStream dos = new DataOutputStream(
        new FileOutputStream("data.bin"))) {
    dos.writeInt(100);
    dos.writeDouble(3.14159);
    dos.writeUTF("Hello");  // 写入字符串
    dos.writeBoolean(true);
}

try (DataInputStream dis = new DataInputStream(
        new FileInputStream("data.bin"))) {
    int i = dis.readInt();
    double d = dis.readDouble();
    String s = dis.readUTF();
    boolean b = dis.readBoolean();
}
```

## 三、字符流

### FileReader / FileWriter
```java
try (FileReader fr = new FileReader("test.txt", StandardCharsets.UTF_8);
     FileWriter fw = new FileWriter("copy.txt", StandardCharsets.UTF_8)) {

    char[] buffer = new char[1024];
    int len;
    while ((len = fr.read(buffer)) != -1) {
        fw.write(buffer, 0, len);
    }
}
```

### BufferedReader / BufferedWriter
```java
// BufferedReader - 按行读取（最常用）
try (BufferedReader br = new BufferedReader(
        new FileReader("test.txt"))) {
    String line;
    while ((line = br.readLine()) != null) {
        System.out.println(line);
    }
}

// BufferedWriter - 写入文本
try (BufferedWriter bw = new BufferedWriter(
        new FileWriter("output.txt"))) {
    bw.write("第一行");
    bw.newLine();    // 换行（跨平台）
    bw.write("第二行");
    bw.flush();
}
```

### InputStreamReader / OutputStreamWriter（转换流）
```java
// 字节流→字符流转换
try (BufferedReader br = new BufferedReader(
        new InputStreamReader(
            new FileInputStream("test.txt"), StandardCharsets.UTF_8));
     BufferedWriter bw = new BufferedWriter(
        new OutputStreamWriter(
            new FileOutputStream("output.txt"), StandardCharsets.UTF_8))) {
    // 使用字符流操作
}
```

## 四、对象序列化

### Serializable接口
```java
// 标记接口（没有需要实现的方法）
public class Person implements Serializable {
    private static final long serialVersionUID = 1L;  // 版本号

    private String name;
    private int age;
    private transient String password;  // transient关键字：不序列化

    // getter/setter
}
```

### ObjectOutputStream / ObjectInputStream
```java
// 序列化：对象→字节
Person p = new Person("张三", 20, "123456");
try (ObjectOutputStream oos = new ObjectOutputStream(
        new FileOutputStream("person.dat"))) {
    oos.writeObject(p);
}

// 反序列化：字节→对象
try (ObjectInputStream ois = new ObjectInputStream(
        new FileInputStream("person.dat"))) {
    Person p2 = (Person) ois.readObject();
    System.out.println(p2.getName());  // 张三
    System.out.println(p2.getPassword());  // null（transient）
}
```

## 五、NIO（New I/O，JDK 1.4+）

### 核心概念
- **Channel**：通道，双向数据传输
- **Buffer**：缓冲区，数据读写都在Buffer中进行
- **Selector**：选择器，单线程管理多个Channel

### FileChannel
```java
// 文件复制（比传统IO更快）
try (FileInputStream fis = new FileInputStream("source.txt");
     FileOutputStream fos = new FileOutputStream("dest.txt");
     FileChannel inChannel = fis.getChannel();
     FileChannel outChannel = fos.getChannel()) {

    // 直接传输（零拷贝）
    inChannel.transferTo(0, inChannel.size(), outChannel);
    // 或
    // outChannel.transferFrom(inChannel, 0, inChannel.size());
}
```

### ByteBuffer
```java
// 创建缓冲区
ByteBuffer buffer = ByteBuffer.allocate(1024);  // 堆内
ByteBuffer directBuffer = ByteBuffer.allocateDirect(1024);  // 直接内存

// 写入数据
buffer.put("Hello".getBytes());

// 切换为读模式
buffer.flip();

// 读取数据
byte[] dest = new byte[buffer.remaining()];
buffer.get(dest);
System.out.println(new String(dest));

// 清空（重用）
buffer.clear();

// 核心属性
buffer.position();    // 当前位置
buffer.limit();       // 读写界限
buffer.capacity();    // 总容量
```

### Files工具类（JDK 7+）
```java
// 读取所有行
List<String> lines = Files.readAllLines(Paths.get("test.txt"), StandardCharsets.UTF_8);

// 写入所有行
Files.write(Paths.get("output.txt"), lines, StandardCharsets.UTF_8);

// 拷贝文件
Files.copy(Paths.get("source.txt"), Paths.get("dest.txt"),
    StandardCopyOption.REPLACE_EXISTING);

// 移动文件
Files.move(Paths.get("source.txt"), Paths.get("dest.txt"),
    StandardCopyOption.ATOMIC_MOVE);

// 删除文件
Files.delete(Paths.get("test.txt"));
Files.deleteIfExists(Paths.get("test.txt"));

// 创建目录
Files.createDirectories(Paths.get("a/b/c"));  // 创建不存在的中间目录

// 遍历目录
Files.walk(Paths.get("."))
     .filter(Files::isRegularFile)
     .forEach(System.out::println);
```

## 六、传统IO vs NIO

| 特性 | 传统IO | NIO |
|------|--------|-----|
| 方向 | 单向（输入/输出流） | 双向（Channel） |
| 数据存储 | 流中 | Buffer |
| 多路复用 | 不支持 | Selector |
| 非阻塞 | 阻塞 | 可配置非阻塞 |
| 性能 | 较低 | 高（零拷贝） |

## 相关标签
Java I/O, 字节流, 字符流, 序列化, NIO, FileChannel, Buffer, Files
""")

# ============================================================
# 8. Java多线程与并发（基础）
# ============================================================
add_lecture("Java多线程基础 - 线程创建、同步与通信", """# Java多线程基础

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
""")

# ============================================================
# 9. Java并发编程高级
# ============================================================
add_lecture("Java并发编程高级 - 锁、线程池、并发工具类", """# Java并发编程高级

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
""")

# ============================================================
# 10. Java泛型
# ============================================================
add_lecture("Java泛型详解", """# Java泛型详解

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
""")

# ============================================================
# 11. Java注解与反射
# ============================================================
add_lecture("Java注解与反射机制", """# Java注解与反射机制

## 一、注解（Annotation）

注解是Java 5引入的一种元数据机制，为代码提供额外的信息。

### 内置注解
```java
@Override          // 表示重写父类方法
@Deprecated        // 标记已过时
@SuppressWarnings  // 抑制警告
@FunctionalInterface // 函数式接口（JDK 8+）
```

### 元注解
```java
@Retention(RetentionPolicy.RUNTIME)  // 注解保留策略
// SOURCE：源码级（编译后丢弃）
// CLASS：字节码级（默认，运行时不保留）
// RUNTIME：运行期保留（可通过反射读取）

@Target(ElementType.TYPE)  // 注解作用目标
// TYPE, FIELD, METHOD, PARAMETER, CONSTRUCTOR, LOCAL_VARIABLE, ANNOTATION_TYPE, PACKAGE

@Documented     // 包含在JavaDoc中
@Inherited      // 子类可继承父类的注解
@Repeatable     // 可重复使用（JDK 8+）
```

### 自定义注解
```java
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
public @interface FieldInfo {
    String value() default "";      // 元素（方法形式定义）
    String description() default "";
    int order() default 0;
    boolean required() default false;
}

// 使用自定义注解
public class User {
    @FieldInfo(value = "用户ID", order = 1, required = true)
    private Long id;

    @FieldInfo(value = "用户名", order = 2, required = true)
    private String username;

    @FieldInfo(value = "密码", order = 3)
    private String password;
}
```

## 二、反射（Reflection）

反射机制允许程序在运行时获取类的内部信息并操作类的属性和方法。

### 获取Class对象
```java
// 方式1：Class.forName()
Class<?> clazz1 = Class.forName("com.example.User");

// 方式2：.class
Class<?> clazz2 = User.class;

// 方式3：getClass()
User user = new User();
Class<?> clazz3 = user.getClass();

// 三种方式获取的是同一个Class对象
System.out.println(clazz1 == clazz2);  // true
System.out.println(clazz2 == clazz3);  // true
```

### 获取类信息
```java
Class<?> clazz = User.class;

// 类名
String className = clazz.getName();       // com.example.User（全限定名）
String simpleName = clazz.getSimpleName(); // User

// 修饰符
int modifiers = clazz.getModifiers();
boolean isPublic = Modifier.isPublic(modifiers);

// 包
Package pkg = clazz.getPackage();

// 父类
Class<?> superClass = clazz.getSuperclass();

// 接口
Class<?>[] interfaces = clazz.getInterfaces();

// 注解
Annotation[] annotations = clazz.getAnnotations();
```

### 操作属性（Field）
```java
Class<?> clazz = User.class;
User user = new User();

// 获取所有公有属性
Field[] fields = clazz.getFields();

// 获取所有属性（包括私有）
Field[] declaredFields = clazz.getDeclaredFields();

// 获取指定属性
Field field = clazz.getDeclaredField("username");
field.setAccessible(true);  // 访问私有属性

// 读取属性值
Object value = field.get(user);
String username = (String) value;

// 设置属性值
field.set(user, "新用户名");
```

### 操作方法（Method）
```java
Class<?> clazz = User.class;
User user = new User();

// 获取所有公有方法
Method[] methods = clazz.getMethods();

// 获取所有方法（包括私有）
Method[] declaredMethods = clazz.getDeclaredMethods();

// 获取指定方法（参数类型匹配）
Method method = clazz.getDeclaredMethod("setUsername", String.class);
Method getName = clazz.getDeclaredMethod("getUsername");

// 调用方法
method.invoke(user, "张三");
String name = (String) getName.invoke(user);

// 调用私有方法
Method privateMethod = clazz.getDeclaredMethod("secretMethod");
privateMethod.setAccessible(true);
privateMethod.invoke(user);
```

### 操作构造方法（Constructor）
```java
Class<?> clazz = User.class;

// 获取构造方法
Constructor<?> constructor = clazz.getConstructor(String.class, String.class);

// 创建对象
User user = (User) constructor.newInstance("admin", "123456");

// 调用无参构造
User user2 = (User) clazz.getDeclaredConstructor().newInstance();
```

### 操作泛型信息
```java
// 获取方法返回值的泛型类型
Method method = MyClass.class.getMethod("getList");
Type returnType = method.getGenericReturnType();
if (returnType instanceof ParameterizedType) {
    ParameterizedType type = (ParameterizedType) returnType;
    Type[] typeArgs = type.getActualTypeArguments();
    for (Type typeArg : typeArgs) {
        System.out.println(typeArg);  // 如：class java.lang.String
    }
}
```

## 三、动态代理

### JDK动态代理
```java
// 接口
public interface UserService {
    void addUser(String username);
    void deleteUser(Long id);
}

// 目标类
public class UserServiceImpl implements UserService {
    @Override
    public void addUser(String username) {
        System.out.println("添加用户: " + username);
    }

    @Override
    public void deleteUser(Long id) {
        System.out.println("删除用户: " + id);
    }
}

// 动态代理处理器
public class LoggingHandler implements InvocationHandler {
    private final Object target;

    public LoggingHandler(Object target) {
        this.target = target;
    }

    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        System.out.println("[日志] 调用方法: " + method.getName());
        long start = System.currentTimeMillis();

        Object result = method.invoke(target, args);

        long duration = System.currentTimeMillis() - start;
        System.out.println("[日志] 方法执行耗时: " + duration + "ms");
        return result;
    }

    // 创建代理
    @SuppressWarnings("unchecked")
    public static <T> T createProxy(T target) {
        return (T) Proxy.newProxyInstance(
            target.getClass().getClassLoader(),
            target.getClass().getInterfaces(),
            new LoggingHandler(target)
        );
    }
}

// 使用
UserService service = new UserServiceImpl();
UserService proxy = LoggingHandler.createProxy(service);
proxy.addUser("张三");
```

## 四、注解与反射的结合应用

### 字段校验框架
```java
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
@interface NotNull {
    String message() default "字段不能为空";
}

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
@interface StringLength {
    int min() default 0;
    int max() default Integer.MAX_VALUE;
    String message() default "字符串长度不合法";
}

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
@interface Min {
    int value();
    String message() default "值太小";
}

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
@interface Max {
    int value();
    String message() default "值太大";
}

// 校验器
public class Validator {
    public static List<String> validate(Object obj) throws IllegalAccessException {
        List<String> errors = new ArrayList<>();
        Class<?> clazz = obj.getClass();

        for (Field field : clazz.getDeclaredFields()) {
            field.setAccessible(true);
            Object value = field.get(obj);

            // 校验@NotNull
            if (field.isAnnotationPresent(NotNull.class)) {
                if (value == null) {
                    errors.add(field.getAnnotation(NotNull.class).message());
                }
            }

            // 校验@StringLength
            if (field.isAnnotationPresent(StringLength.class) && value instanceof String) {
                String str = (String) value;
                StringLength annotation = field.getAnnotation(StringLength.class);
                if (str.length() < annotation.min() || str.length() > annotation.max()) {
                    errors.add(annotation.message());
                }
            }
        }
        return errors;
    }
}

// 使用
public class UserForm {
    @NotNull(message = "用户名不能为空")
    @StringLength(min = 2, max = 20, message = "用户名长度2-20")
    private String username;

    @Min(value = 1, message = "年龄至少1岁")
    @Max(value = 150, message = "年龄不能超过150")
    private int age;
}

// 验证
UserForm form = new UserForm();
form.setAge(200);
List<String> errors = Validator.validate(form);
// errors包含: ["用户名不能为空", "年龄不能超过150"]
```

## 相关标签
Java注解, Java反射, 动态代理, 元注解, Class对象, InvocationHandler
""")

# ============================================================
# 12. Java Lambda与Stream API
# ============================================================
add_lecture("Java Lambda表达式与Stream API", """# Java Lambda表达式与Stream API

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
""")

# ============================================================
# 13. Java网络编程
# ============================================================
add_lecture("Java网络编程", """# Java网络编程

## 一、网络基础

### 网络模型
```
OSI七层模型：物理层 → 数据链路层 → 网络层 → 传输层 → 会话层 → 表示层 → 应用层
TCP/IP四层模型：网络接口层 → 网际层 → 传输层 → 应用层
```

### IP地址与端口
- **IP地址**：标识网络中的主机
- **端口号**：标识主机上的进程（0-65535）
  - 0-1023：知名端口（HTTP: 80, HTTPS: 443, FTP: 21, SSH: 22）
  - 1024-49151：注册端口
  - 49152-65535：动态/私有端口

## 二、InetAddress

```java
// 获取本机IP
InetAddress localHost = InetAddress.getLocalHost();
System.out.println(localHost.getHostName());     // 主机名
System.out.println(localHost.getHostAddress());  // IP地址

// 根据域名获取IP
InetAddress baidu = InetAddress.getByName("www.baidu.com");
System.out.println(baidu.getHostAddress());

// 获取所有IP
InetAddress[] all = InetAddress.getAllByName("www.google.com");

// 可达性检查
boolean reachable = InetAddress.getByName("192.168.1.1").isReachable(3000);
```

## 三、TCP编程（Socket）

TCP是面向连接的、可靠的传输层协议。

### 客户端
```java
public class TcpClient {
    public static void main(String[] args) throws IOException {
        // 1. 创建Socket，连接服务器
        try (Socket socket = new Socket("localhost", 8080);
             // 2. 获取输出流，发送数据
             PrintWriter out = new PrintWriter(socket.getOutputStream(), true);
             // 3. 获取输入流，接收数据
             BufferedReader in = new BufferedReader(
                 new InputStreamReader(socket.getInputStream()));
             // 4. 键盘输入
             BufferedReader stdIn = new BufferedReader(
                 new InputStreamReader(System.in))) {

            String userInput;
            while ((userInput = stdIn.readLine()) != null) {
                out.println(userInput);              // 发送
                System.out.println("服务器回复: " + in.readLine()); // 接收
            }
        }
    }
}
```

### 服务器端
```java
public class TcpServer {
    public static void main(String[] args) throws IOException {
        // 1. 创建ServerSocket
        try (ServerSocket serverSocket = new ServerSocket(8080)) {
            System.out.println("服务器启动，等待连接...");

            while (true) {
                // 2. 接受客户端连接（阻塞）
                try (Socket clientSocket = serverSocket.accept();
                     BufferedReader in = new BufferedReader(
                         new InputStreamReader(clientSocket.getInputStream()));
                     PrintWriter out = new PrintWriter(
                         clientSocket.getOutputStream(), true)) {

                    System.out.println("客户端已连接: " +
                        clientSocket.getInetAddress().getHostAddress());

                    String input;
                    while ((input = in.readLine()) != null) {
                        System.out.println("收到: " + input);
                        out.println("已收到: " + input);  // 回复
                    }
                } catch (IOException e) {
                    System.out.println("客户端断开连接");
                }
            }
        }
    }
}
```

### 多线程服务器
```java
public class MultiThreadServer {
    public static void main(String[] args) throws IOException {
        ServerSocket serverSocket = new ServerSocket(8080);
        ExecutorService threadPool = Executors.newCachedThreadPool();

        while (true) {
            Socket socket = serverSocket.accept();
            threadPool.execute(new ClientHandler(socket));
        }
    }
}

class ClientHandler implements Runnable {
    private final Socket socket;

    public ClientHandler(Socket socket) {
        this.socket = socket;
    }

    @Override
    public void run() {
        try (BufferedReader in = new BufferedReader(
                 new InputStreamReader(socket.getInputStream()));
             PrintWriter out = new PrintWriter(
                 socket.getOutputStream(), true)) {

            String input;
            while ((input = in.readLine()) != null) {
                out.println("处理结果: " + input.toUpperCase());
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```

## 四、UDP编程

UDP是无连接的、不可靠的传输层协议，但效率高。

### UDP客户端
```java
public class UdpClient {
    public static void main(String[] args) throws IOException {
        try (DatagramSocket socket = new DatagramSocket()) {
            String message = "Hello, UDP Server!";
            byte[] buf = message.getBytes();

            InetAddress address = InetAddress.getByName("localhost");
            DatagramPacket packet = new DatagramPacket(
                buf, buf.length, address, 8888);

            socket.send(packet);

            // 接收回复
            byte[] recvBuf = new byte[1024];
            DatagramPacket recvPacket = new DatagramPacket(recvBuf, recvBuf.length);
            socket.receive(recvPacket);
            String response = new String(recvPacket.getData(), 0, recvPacket.getLength());
            System.out.println("服务器回复: " + response);
        }
    }
}
```

### UDP服务器
```java
public class UdpServer {
    public static void main(String[] args) throws IOException {
        try (DatagramSocket socket = new DatagramSocket(8888)) {
            System.out.println("UDP服务器启动，端口: 8888");

            byte[] buffer = new byte[1024];

            while (true) {
                // 接收数据包
                DatagramPacket packet = new DatagramPacket(buffer, buffer.length);
                socket.receive(packet);

                String message = new String(packet.getData(), 0, packet.getLength());
                System.out.println("收到: " + message + " 来自: " +
                    packet.getAddress().getHostAddress());

                // 回复
                String response = "已收到: " + message;
                byte[] responseBuf = response.getBytes();
                DatagramPacket responsePacket = new DatagramPacket(
                    responseBuf, responseBuf.length,
                    packet.getAddress(), packet.getPort());
                socket.send(responsePacket);
            }
        }
    }
}
```

### UDP vs TCP

| 特性 | TCP | UDP |
|------|-----|-----|
| 连接 | 面向连接 | 无连接 |
| 可靠性 | 可靠 | 不可靠 |
| 顺序 | 保证顺序 | 不保证 |
| 速度 | 较慢 | 快速 |
| 应用 | HTTP, FTP, SMTP | DNS, 视频流, 游戏 |

## 五、URL与URLConnection

```java
// 解析URL
URL url = new URL("https://example.com:8080/path/file?key=value#anchor");
url.getProtocol();    // https
url.getHost();        // example.com
url.getPort();        // 8080
url.getPath();        // /path/file
url.getQuery();       // key=value
url.getRef();         // anchor

// 发送HTTP请求
URL url = new URL("https://api.example.com/data");
HttpURLConnection conn = (HttpURLConnection) url.openConnection();

// 设置请求
conn.setRequestMethod("GET");
conn.setRequestProperty("User-Agent", "Mozilla/5.0");
conn.setConnectTimeout(5000);
conn.setReadTimeout(5000);

// 读取响应
int responseCode = conn.getResponseCode();
try (BufferedReader br = new BufferedReader(
        new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8))) {
    StringBuilder response = new StringBuilder();
    String line;
    while ((line = br.readLine()) != null) {
        response.append(line);
    }
    System.out.println(response.toString());
}

// POST请求
HttpURLConnection conn = (HttpURLConnection) new URL(url).openConnection();
conn.setRequestMethod("POST");
conn.setDoOutput(true);
conn.setRequestProperty("Content-Type", "application/json");

String json = "{\\\"key\\\":\\\"value\\\"}";
try (OutputStream os = conn.getOutputStream()) {
    os.write(json.getBytes(StandardCharsets.UTF_8));
    os.flush();
}
```

## 六、NIO网络编程

```java
// Selector实现非阻塞TCP服务器
public class NioServer {
    public static void main(String[] args) throws IOException {
        Selector selector = Selector.open();

        ServerSocketChannel serverChannel = ServerSocketChannel.open();
        serverChannel.configureBlocking(false);
        serverChannel.socket().bind(new InetSocketAddress(8080));
        serverChannel.register(selector, SelectionKey.OP_ACCEPT);

        while (true) {
            selector.select();  // 阻塞直到有事件发生

            Set<SelectionKey> selectedKeys = selector.selectedKeys();
            Iterator<SelectionKey> iter = selectedKeys.iterator();

            while (iter.hasNext()) {
                SelectionKey key = iter.next();

                if (key.isAcceptable()) {
                    // 接受连接
                    ServerSocketChannel server = (ServerSocketChannel) key.channel();
                    SocketChannel client = server.accept();
                    client.configureBlocking(false);
                    client.register(selector, SelectionKey.OP_READ);
                }

                if (key.isReadable()) {
                    // 读取数据
                    SocketChannel client = (SocketChannel) key.channel();
                    ByteBuffer buffer = ByteBuffer.allocate(1024);
                    int bytesRead = client.read(buffer);
                    if (bytesRead > 0) {
                        buffer.flip();
                        byte[] data = new byte[buffer.remaining()];
                        buffer.get(data);
                        String message = new String(data);
                        System.out.println("收到: " + message);

                        // 回复
                        ByteBuffer response = ByteBuffer.wrap(("已收到: " + message).getBytes());
                        client.write(response);
                    }
                }

                iter.remove();
            }
        }
    }
}
```

## 相关标签
Java网络编程, Socket, TCP, UDP, HttpURLConnection, NIO, Selector, InetAddress
""")

# ============================================================
# 14. JDBC与数据库编程
# ============================================================
add_lecture("JDBC与数据库编程", """# JDBC与数据库编程

## 一、JDBC概述

JDBC（Java Database Connectivity）是Java访问数据库的标准API。

### JDBC架构
```
Java应用 → JDBC API → JDBC驱动管理器 → JDBC驱动 → 数据库
```

### JDBC驱动类型
1. JDBC-ODBC桥接驱动（已淘汰）
2. 本地API驱动（部分Java实现）
3. 网络协议驱动（中间件）
4. **纯Java驱动**（最常用，如MySQL Connector/J）

## 二、JDBC核心API

### 连接数据库
```java
// 1. 加载驱动（JDBC 4+自动加载，可省略）
Class.forName("com.mysql.cj.jdbc.Driver");

// 2. 建立连接
String url = "jdbc:mysql://localhost:3306/labex?useUnicode=true&characterEncoding=utf8";
String username = "root";
String password = "password";

try (Connection conn = DriverManager.getConnection(url, username, password)) {
    System.out.println("数据库连接成功!");
}
```

### Statement（不推荐，有SQL注入风险）
```java
try (Statement stmt = conn.createStatement();
     ResultSet rs = stmt.executeQuery("SELECT * FROM t_user")) {

    while (rs.next()) {
        int id = rs.getInt("user_id");
        String name = rs.getString("user_name");
        System.out.println(id + ": " + name);
    }
}

// DML操作
String sql = "INSERT INTO t_user(user_name, age) VALUES('" + name + "', " + age + ")";
stmt.executeUpdate(sql);  // 返回影响行数
```

### PreparedStatement（推荐，防SQL注入）
```java
// 增
String insertSql = "INSERT INTO t_user(user_name, password, age) VALUES(?, ?, ?)";
try (PreparedStatement ps = conn.prepareStatement(insertSql,
        Statement.RETURN_GENERATED_KEYS)) {

    ps.setString(1, "张三");   // 设置参数（从1开始）
    ps.setString(2, "123456");
    ps.setInt(3, 20);

    int rows = ps.executeUpdate();
    System.out.println("影响了 " + rows + " 行");

    // 获取自增主键
    try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
        if (generatedKeys.next()) {
            long id = generatedKeys.getLong(1);
            System.out.println("新用户ID: " + id);
        }
    }
}

// 删
String deleteSql = "DELETE FROM t_user WHERE user_id = ?";
try (PreparedStatement ps = conn.prepareStatement(deleteSql)) {
    ps.setInt(1, 100);
    ps.executeUpdate();
}

// 改
String updateSql = "UPDATE t_user SET user_name = ? WHERE user_id = ?";
try (PreparedStatement ps = conn.prepareStatement(updateSql)) {
    ps.setString(1, "李四");
    ps.setInt(2, 1);
    ps.executeUpdate();
}

// 查
String querySql = "SELECT * FROM t_user WHERE age > ? ORDER BY age DESC";
try (PreparedStatement ps = conn.prepareStatement(querySql)) {
    ps.setInt(1, 18);

    try (ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            int id = rs.getInt("user_id");
            String name = rs.getString("user_name");
            String pwd = rs.getString("password");
            int age = rs.getInt("age");
            Date createTime = rs.getTimestamp("create_time");

            System.out.printf("id=%d, name=%s, age=%d%n", id, name, age);
        }
    }
}
```

### ResultSet常用方法
```java
// 获取各种类型
rs.getInt("column_name");
rs.getInt(1);              // 按列索引
rs.getString("name");
rs.getDouble("price");
rs.getBoolean("active");
rs.getDate("birthday");
rs.getTimestamp("create_time");
rs.getObject("any_column"); // 通用方法

// 列元数据
ResultSetMetaData meta = rs.getMetaData();
int columnCount = meta.getColumnCount();
String columnName = meta.getColumnName(1);
String columnType = meta.getColumnTypeName(1);

// 遍历
while (rs.next()) {
    // 处理每一行
}
```

## 三、事务管理

```java
// 关闭自动提交
conn.setAutoCommit(false);

try {
    // 转账操作
    String sql1 = "UPDATE t_account SET balance = balance - 100 WHERE id = 1";
    String sql2 = "UPDATE t_account SET balance = balance + 100 WHERE id = 2";

    try (PreparedStatement ps1 = conn.prepareStatement(sql1)) {
        ps1.executeUpdate();
    }

    try (PreparedStatement ps2 = conn.prepareStatement(sql2)) {
        ps2.executeUpdate();
    }

    // 提交事务
    conn.commit();
} catch (SQLException e) {
    // 回滚事务
    conn.rollback();
    e.printStackTrace();
} finally {
    conn.setAutoCommit(true);  // 恢复自动提交
}
```

### 事务隔离级别
```java
// 查看当前隔离级别
int level = conn.getTransactionIsolation();

// 设置隔离级别
conn.setTransactionIsolation(Connection.TRANSACTION_READ_COMMITTED);
```

| 隔离级别 | 脏读 | 不可重复读 | 幻读 |
|---------|------|-----------|------|
| READ_UNCOMMITTED | × | × | × |
| READ_COMMITTED | √ | × | × |
| REPEATABLE_READ | √ | √ | × |
| SERIALIZABLE | √ | √ | √ |

## 四、连接池

### HikariCP（目前最快）
```java
// HikariCP配置
HikariConfig config = new HikariConfig();
config.setJdbcUrl("jdbc:mysql://localhost:3306/labex");
config.setUsername("root");
config.setPassword("password");
config.setMaximumPoolSize(20);
config.setMinimumIdle(5);
config.setConnectionTimeout(30000);
config.setIdleTimeout(600000);
config.setMaxLifetime(1800000);

HikariDataSource dataSource = new HikariDataSource(config);

// 使用
try (Connection conn = dataSource.getConnection();
     PreparedStatement ps = conn.prepareStatement("SELECT 1")) {
    // ...
}
```

### 连接池的好处
- **复用连接**：减少创建/关闭连接的开销
- **控制并发**：限制最大连接数
- **管理生命周期**：检测和回收失效连接

## 五、批处理

```java
// 批量插入
String sql = "INSERT INTO t_user(user_name, password) VALUES(?, ?)";
try (PreparedStatement ps = conn.prepareStatement(sql)) {

    for (int i = 0; i < 10000; i++) {
        ps.setString(1, "user_" + i);
        ps.setString(2, "pwd_" + i);
        ps.addBatch();               // 添加到批处理

        if (i % 1000 == 0) {
            ps.executeBatch();       // 每1000条执行一次
            ps.clearBatch();
        }
    }
    ps.executeBatch();               // 执行剩余
}
```

## 六、MyBatis与ORM

### MyBatis的JDBC流程
```java
// MyBatis内部依然使用JDBC，但封装了：
// 1. 连接管理（连接池）
// 2. SQL映射（XML/注解）
// 3. 参数映射（#{} → PreparedStatement）
// 4. 结果映射（数据库字段 → Java对象）
// 5. 事务管理

// Mapper接口示例
@Mapper
public interface UserMapper {
    @Select("SELECT * FROM t_user WHERE user_id = #{id}")
    User findById(@Param("id") Integer id);

    @Insert("INSERT INTO t_user(user_name, password) VALUES(#{userName}, #{password})")
    @Options(useGeneratedKeys = true, keyProperty = "userId")
    int insert(User user);

    @Update("UPDATE t_user SET user_name = #{userName} WHERE user_id = #{userId}")
    int update(User user);

    @Delete("DELETE FROM t_user WHERE user_id = #{id}")
    int deleteById(Integer id);
}
```

## 七、JDBC最佳实践

```java
// 1. 使用try-with-resources自动关闭资源
try (Connection conn = dataSource.getConnection();
     PreparedStatement ps = conn.prepareStatement(sql);
     ResultSet rs = ps.executeQuery()) {
    // ...
}

// 2. 使用PreparedStatement防止SQL注入
// ❌ 不推荐
Statement stmt = conn.createStatement();
stmt.executeQuery("SELECT * FROM t_user WHERE name = '" + name + "'");

// ✅ 推荐
PreparedStatement ps = conn.prepareStatement("SELECT * FROM t_user WHERE name = ?");
ps.setString(1, name);

// 3. 批量操作使用批处理
// 4. 使用连接池管理连接
// 5. 合理设置事务隔离级别
// 6. 使用ORM框架（MyBatis/Spring Data JPA）
```

## 相关标签
JDBC, MySQL, PreparedStatement, 事务, 连接池, HikariCP, MyBatis, 批处理
""")

# ============================================================
# 15. Java内存管理与JVM
# ============================================================
add_lecture("Java内存管理与JVM", """# Java内存管理与JVM

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
java -Xms1g -Xmx1g -XX:+HeapDumpOnOutOfMemoryError \
     -XX:HeapDumpPath=/tmp/heap.hprof
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
""")

# ============================================================
# 16. Java时间日期API与新特性
# ============================================================
add_lecture("Java时间日期API与Java新特性", """# Java时间日期API与Java新特性

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
"Hello\nWorld".lines();        // Stream<String>
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
""")

# ============================================================
# 17. Java设计模式
# ============================================================
add_lecture("Java设计模式", """# Java设计模式

## 一、设计模式概述

设计模式（Design Patterns）是解决特定问题的可复用方案。GoF（Gang of Four）将23种设计模式分为三类：

### 分类
```
创建型（5种）：工厂方法、抽象工厂、单例、建造者、原型
结构型（7种）：适配器、装饰器、代理、外观、桥接、组合、享元
行为型（11种）：策略、观察者、模板方法、责任链、命令、迭代器、中介者、备忘录、状态、访问者、解释器
```

### 设计原则（SOLID）
```
S - 单一职责原则：一个类只负责一个职责
O - 开闭原则：对扩展开放，对修改关闭
L - 里氏替换原则：子类必须能替换父类
I - 接口隔离原则：接口尽量细化
D - 依赖倒置原则：依赖抽象而非具体实现
```

## 二、单例模式（Singleton）

```java
// 1. 饿汉式（线程安全，类加载时创建）
public class SingletonHungry {
    private static final SingletonHungry INSTANCE = new SingletonHungry();

    private SingletonHungry() {}  // 私有构造

    public static SingletonHungry getInstance() {
        return INSTANCE;
    }
}

// 2. 懒汉式（双重检查锁定，推荐）
public class SingletonLazy {
    // volatile防止指令重排序
    private static volatile SingletonLazy instance;

    private SingletonLazy() {}

    public static SingletonLazy getInstance() {
        if (instance == null) {           // 第一次检查
            synchronized (SingletonLazy.class) {
                if (instance == null) {   // 第二次检查
                    instance = new SingletonLazy();
                }
            }
        }
        return instance;
    }
}

// 3. 静态内部类（推荐，懒加载 + 线程安全）
public class SingletonHolder {
    private SingletonHolder() {}

    private static class Holder {
        private static final SingletonHolder INSTANCE = new SingletonHolder();
    }

    public static SingletonHolder getInstance() {
        return Holder.INSTANCE;
    }
}

// 4. 枚举实现（最安全，防止反射攻击和序列化破坏）
public enum SingletonEnum {
    INSTANCE;  // 单个枚举值即单例

    public void doSomething() {
        System.out.println("单例方法");
    }
}
// 使用：SingletonEnum.INSTANCE.doSomething();
```

## 三、工厂模式

### 简单工厂
```java
// 简单工厂（不是GoF模式，但广泛使用）
public class PaymentFactory {
    public static Payment create(String type) {
        return switch (type) {
            case "alipay" -> new Alipay();
            case "wechat" -> new WechatPay();
            case "unionpay" -> new UnionPay();
            default -> throw new IllegalArgumentException("未知支付类型");
        };
    }
}
```

### 工厂方法
```java
// 抽象工厂
public interface PaymentFactory {
    Payment createPayment();
}

// 具体工厂
public class AlipayFactory implements PaymentFactory {
    @Override
    public Payment createPayment() {
        return new Alipay();
    }
}

public class WechatPayFactory implements PaymentFactory {
    @Override
    public Payment createPayment() {
        return new WechatPay();
    }
}

// 使用
PaymentFactory factory = new AlipayFactory();
Payment payment = factory.createPayment();
payment.pay(100);
```

### 抽象工厂
```java
// 产品族
public interface GUIFactory {
    Button createButton();
    Checkbox createCheckbox();
}

public class WindowsFactory implements GUIFactory {
    @Override
    public Button createButton() { return new WindowsButton(); }

    @Override
    public Checkbox createCheckbox() { return new WindowsCheckbox(); }
}

public class MacFactory implements GUIFactory {
    @Override
    public Button createButton() { return new MacButton(); }

    @Override
    public Checkbox createCheckbox() { return new MacCheckbox(); }
}
```

## 四、建造者模式（Builder）

```java
// 链式调用，创建复杂对象
public class User {
    private final String name;       // 必填
    private final int age;           // 必填
    private final String email;      // 可选
    private final String phone;      // 可选
    private final String address;    // 可选

    private User(Builder builder) {
        this.name = builder.name;
        this.age = builder.age;
        this.email = builder.email;
        this.phone = builder.phone;
        this.address = builder.address;
    }

    public static class Builder {
        private final String name;    // 必填
        private final int age;        // 必填
        private String email;
        private String phone;
        private String address;

        public Builder(String name, int age) {
            this.name = name;
            this.age = age;
        }

        public Builder email(String email) { this.email = email; return this; }
        public Builder phone(String phone) { this.phone = phone; return this; }
        public Builder address(String address) { this.address = address; return this; }

        public User build() {
            return new User(this);
        }
    }
}

// 使用
User user = new User.Builder("张三", 25)
    .email("zhangsan@example.com")
    .phone("13800138000")
    .address("北京市海淀区")
    .build();
```

## 五、代理模式（Proxy）

### 静态代理
```java
public interface Image {
    void display();
}

// 真实对象
public class RealImage implements Image {
    private String filename;

    public RealImage(String filename) {
        this.filename = filename;
        loadFromDisk();  // 耗时操作
    }

    private void loadFromDisk() {
        System.out.println("加载图片: " + filename);
    }

    @Override
    public void display() {
        System.out.println("显示图片: " + filename);
    }
}

// 代理
public class ImageProxy implements Image {
    private RealImage realImage;
    private final String filename;

    public ImageProxy(String filename) {
        this.filename = filename;
    }

    @Override
    public void display() {
        if (realImage == null) {
            realImage = new RealImage(filename);  // 延迟加载
        }
        realImage.display();
    }
}
```

### JDK动态代理
```java
// 运行时生成代理类（详见第11章反射部分）
```

## 六、策略模式（Strategy）

```java
// 策略接口
public interface DiscountStrategy {
    double applyDiscount(double originalPrice);
}

// 具体策略
public class NoDiscount implements DiscountStrategy {
    @Override
    public double applyDiscount(double price) { return price; }
}

public class PercentageDiscount implements DiscountStrategy {
    private final double percentage;  // 0.0 ~ 1.0

    public PercentageDiscount(double percentage) {
        this.percentage = percentage;
    }

    @Override
    public double applyDiscount(double price) {
        return price * (1 - percentage);
    }
}

public class FixedDiscount implements DiscountStrategy {
    private final double amount;

    public FixedDiscount(double amount) {
        this.amount = amount;
    }

    @Override
    public double applyDiscount(double price) {
        return Math.max(0, price - amount);
    }
}

// 上下文
public class Order {
    private double price;
    private DiscountStrategy discountStrategy;

    public Order(double price, DiscountStrategy discountStrategy) {
        this.price = price;
        this.discountStrategy = discountStrategy;
    }

    public double getFinalPrice() {
        return discountStrategy.applyDiscount(price);
    }
}

// 使用
Order order1 = new Order(100, new NoDiscount());              // 100
Order order2 = new Order(100, new PercentageDiscount(0.2));   // 80
Order order3 = new Order(100, new FixedDiscount(30));         // 70
```

## 七、观察者模式（Observer）

```java
// 观察者接口
public interface Observer {
    void update(String message);
}

// 主题
public class Subject {
    private final List<Observer> observers = new ArrayList<>();
    private String state;

    public void attach(Observer observer) {
        observers.add(observer);
    }

    public void detach(Observer observer) {
        observers.remove(observer);
    }

    public void notifyObservers() {
        for (Observer observer : observers) {
            observer.update(state);
        }
    }

    public void setState(String state) {
        this.state = state;
        notifyObservers();
    }
}

// 具体观察者
public class EmailObserver implements Observer {
    private final String email;

    public EmailObserver(String email) {
        this.email = email;
    }

    @Override
    public void update(String message) {
        System.out.println("发送邮件到 " + email + ": " + message);
    }
}

public class SmsObserver implements Observer {
    private final String phone;

    public SmsObserver(String phone) {
        this.phone = phone;
    }

    @Override
    public void update(String message) {
        System.out.println("发送短信到 " + phone + ": " + message);
    }
}

// 使用
Subject subject = new Subject();
subject.attach(new EmailObserver("user@example.com"));
subject.attach(new SmsObserver("13800138000"));
subject.setState("订单已发货！");
```

## 八、装饰器模式（Decorator）

```java
// 组件接口
public interface Coffee {
    double cost();
    String description();
}

// 具体组件
public class SimpleCoffee implements Coffee {
    @Override
    public double cost() { return 10; }

    @Override
    public String description() { return "咖啡"; }
}

// 装饰器基类
public abstract class CoffeeDecorator implements Coffee {
    protected final Coffee decorated;

    public CoffeeDecorator(Coffee coffee) {
        this.decorated = coffee;
    }

    @Override
    public double cost() { return decorated.cost(); }

    @Override
    public String description() { return decorated.description(); }
}

// 具体装饰器
public class MilkDecorator extends CoffeeDecorator {
    public MilkDecorator(Coffee coffee) { super(coffee); }

    @Override
    public double cost() { return super.cost() + 3; }

    @Override
    public String description() { return super.description() + " + 牛奶"; }
}

public class SugarDecorator extends CoffeeDecorator {
    public SugarDecorator(Coffee coffee) { super(coffee); }

    @Override
    public double cost() { return super.cost() + 1; }

    @Override
    public String description() { return super.description() + " + 糖"; }
}

// 使用（灵活组合）
Coffee coffee = new SimpleCoffee();                    // 咖啡: 10元
coffee = new MilkDecorator(coffee);                   // 咖啡 + 牛奶: 13元
coffee = new SugarDecorator(coffee);                  // 咖啡 + 牛奶 + 糖: 14元
System.out.println(coffee.description() + " = " + coffee.cost() + "元");
```

## 九、模板方法模式（Template Method）

```java
// 抽象模板
public abstract class DataProcessor {
    // 模板方法（定义算法骨架）
    public final void process() {
        loadData();
        validateData();
        processData();
        saveResult();
        cleanup();
    }

    protected abstract void loadData();
    protected abstract void processData();

    // 钩子方法（可选重写）
    protected void validateData() {}  // 默认不做校验
    protected void cleanup() {}       // 默认不做清理

    private void saveResult() {
        System.out.println("保存结果到数据库");
    }
}

// 具体实现
public class CsvProcessor extends DataProcessor {
    @Override
    protected void loadData() {
        System.out.println("加载CSV文件");
    }

    @Override
    protected void processData() {
        System.out.println("处理CSV数据");
    }

    @Override
    protected void validateData() {
        System.out.println("校验CSV数据格式");
    }
}

// 使用
DataProcessor processor = new CsvProcessor();
processor.process();  // 执行整个流程
```

## 十、责任链模式（Chain of Responsibility）

```java
// 处理器抽象
public abstract class Handler {
    private Handler next;

    public Handler setNext(Handler next) {
        this.next = next;
        return next;
    }

    public void handle(String request) {
        if (canHandle(request)) {
            doHandle(request);
        } else if (next != null) {
            next.handle(request);
        } else {
            System.out.println("没人能处理: " + request);
        }
    }

    protected abstract boolean canHandle(String request);
    protected abstract void doHandle(String request);
}

// 具体处理器
public class AuthHandler extends Handler {
    @Override
    protected boolean canHandle(String request) {
        return request.contains("auth");
    }

    @Override
    protected void doHandle(String request) {
        System.out.println("认证处理器处理: " + request);
    }
}

public class LogHandler extends Handler {
    @Override
    protected boolean canHandle(String request) {
        return request.contains("log");
    }

    @Override
    protected void doHandle(String request) {
        System.out.println("日志处理器处理: " + request);
    }
}

// 构建链
Handler chain = new AuthHandler();
chain.setNext(new LogHandler());

chain.handle("auth");     // 认证处理器
chain.handle("log");      // 日志处理器
chain.handle("unknown");  // 没人能处理
```

## 相关标签
Java设计模式, 单例模式, 工厂模式, 建造者模式, 策略模式, 观察者模式, 装饰器模式, 代理模式, SOLID
""")

print(f"All lectures created: {len(lectures)} total")

# ============================================================
# Insert all lectures into database
# ============================================================
print("Inserting lectures into database...")
insert_count = 0
for (name, filename, size, _) in lectures:
    cmd = [
        "mysql", "-u", DB_USER, f"-p{DB_PASS}", DB_NAME,
        "-e", f"""INSERT INTO t_lecture (lecture_name, lecture_type, lecture_filetype, file_path, file_size, teacher_id, vectorized) VALUES ('{name}', {LECTURE_TYPE}, 'md', '{filename}', {size}, {TEACHER_ID}, 0);"""
    ]
    result = subprocess.run(cmd, capture_output=True, text=True)
    if result.returncode == 0:
        insert_count += 1
        print(f"  Inserted: {name}")
    else:
        error_msg = result.stderr.strip()
        # Handle special characters in names
        if "ERROR" in error_msg:
            # Try with Python mysql connector approach
            print(f"  Failed: {name} - {error_msg}")

print(f"Successfully inserted {insert_count}/{len(lectures)} lectures into database")

