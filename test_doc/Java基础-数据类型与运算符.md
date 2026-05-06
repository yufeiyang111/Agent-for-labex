# Java基础 - 数据类型与运算符

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
| char | 2字节 | 0 ~ 65535 | '\u0000' |
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
