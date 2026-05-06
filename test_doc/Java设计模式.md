# Java设计模式

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
