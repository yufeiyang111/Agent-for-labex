# Java面向对象高级特性

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
