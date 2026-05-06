# Java异常处理机制

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
if (str != null && str.matches("\\d+")) {
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
