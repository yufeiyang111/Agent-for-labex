# Java面向对象编程基础

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
