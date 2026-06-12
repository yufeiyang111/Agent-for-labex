# Java集合框架（上）

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
