# Java I/O流

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
