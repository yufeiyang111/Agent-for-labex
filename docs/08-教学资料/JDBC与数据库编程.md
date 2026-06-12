# JDBC与数据库编程

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
