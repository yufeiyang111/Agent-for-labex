# Java网络编程

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

String json = "{\"key\":\"value\"}";
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
