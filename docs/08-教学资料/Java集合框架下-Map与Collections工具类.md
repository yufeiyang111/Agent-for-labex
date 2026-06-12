# Java集合框架（下）

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
