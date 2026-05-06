# Java注解与反射机制

## 一、注解（Annotation）

注解是Java 5引入的一种元数据机制，为代码提供额外的信息。

### 内置注解
```java
@Override          // 表示重写父类方法
@Deprecated        // 标记已过时
@SuppressWarnings  // 抑制警告
@FunctionalInterface // 函数式接口（JDK 8+）
```

### 元注解
```java
@Retention(RetentionPolicy.RUNTIME)  // 注解保留策略
// SOURCE：源码级（编译后丢弃）
// CLASS：字节码级（默认，运行时不保留）
// RUNTIME：运行期保留（可通过反射读取）

@Target(ElementType.TYPE)  // 注解作用目标
// TYPE, FIELD, METHOD, PARAMETER, CONSTRUCTOR, LOCAL_VARIABLE, ANNOTATION_TYPE, PACKAGE

@Documented     // 包含在JavaDoc中
@Inherited      // 子类可继承父类的注解
@Repeatable     // 可重复使用（JDK 8+）
```

### 自定义注解
```java
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
public @interface FieldInfo {
    String value() default "";      // 元素（方法形式定义）
    String description() default "";
    int order() default 0;
    boolean required() default false;
}

// 使用自定义注解
public class User {
    @FieldInfo(value = "用户ID", order = 1, required = true)
    private Long id;

    @FieldInfo(value = "用户名", order = 2, required = true)
    private String username;

    @FieldInfo(value = "密码", order = 3)
    private String password;
}
```

## 二、反射（Reflection）

反射机制允许程序在运行时获取类的内部信息并操作类的属性和方法。

### 获取Class对象
```java
// 方式1：Class.forName()
Class<?> clazz1 = Class.forName("com.example.User");

// 方式2：.class
Class<?> clazz2 = User.class;

// 方式3：getClass()
User user = new User();
Class<?> clazz3 = user.getClass();

// 三种方式获取的是同一个Class对象
System.out.println(clazz1 == clazz2);  // true
System.out.println(clazz2 == clazz3);  // true
```

### 获取类信息
```java
Class<?> clazz = User.class;

// 类名
String className = clazz.getName();       // com.example.User（全限定名）
String simpleName = clazz.getSimpleName(); // User

// 修饰符
int modifiers = clazz.getModifiers();
boolean isPublic = Modifier.isPublic(modifiers);

// 包
Package pkg = clazz.getPackage();

// 父类
Class<?> superClass = clazz.getSuperclass();

// 接口
Class<?>[] interfaces = clazz.getInterfaces();

// 注解
Annotation[] annotations = clazz.getAnnotations();
```

### 操作属性（Field）
```java
Class<?> clazz = User.class;
User user = new User();

// 获取所有公有属性
Field[] fields = clazz.getFields();

// 获取所有属性（包括私有）
Field[] declaredFields = clazz.getDeclaredFields();

// 获取指定属性
Field field = clazz.getDeclaredField("username");
field.setAccessible(true);  // 访问私有属性

// 读取属性值
Object value = field.get(user);
String username = (String) value;

// 设置属性值
field.set(user, "新用户名");
```

### 操作方法（Method）
```java
Class<?> clazz = User.class;
User user = new User();

// 获取所有公有方法
Method[] methods = clazz.getMethods();

// 获取所有方法（包括私有）
Method[] declaredMethods = clazz.getDeclaredMethods();

// 获取指定方法（参数类型匹配）
Method method = clazz.getDeclaredMethod("setUsername", String.class);
Method getName = clazz.getDeclaredMethod("getUsername");

// 调用方法
method.invoke(user, "张三");
String name = (String) getName.invoke(user);

// 调用私有方法
Method privateMethod = clazz.getDeclaredMethod("secretMethod");
privateMethod.setAccessible(true);
privateMethod.invoke(user);
```

### 操作构造方法（Constructor）
```java
Class<?> clazz = User.class;

// 获取构造方法
Constructor<?> constructor = clazz.getConstructor(String.class, String.class);

// 创建对象
User user = (User) constructor.newInstance("admin", "123456");

// 调用无参构造
User user2 = (User) clazz.getDeclaredConstructor().newInstance();
```

### 操作泛型信息
```java
// 获取方法返回值的泛型类型
Method method = MyClass.class.getMethod("getList");
Type returnType = method.getGenericReturnType();
if (returnType instanceof ParameterizedType) {
    ParameterizedType type = (ParameterizedType) returnType;
    Type[] typeArgs = type.getActualTypeArguments();
    for (Type typeArg : typeArgs) {
        System.out.println(typeArg);  // 如：class java.lang.String
    }
}
```

## 三、动态代理

### JDK动态代理
```java
// 接口
public interface UserService {
    void addUser(String username);
    void deleteUser(Long id);
}

// 目标类
public class UserServiceImpl implements UserService {
    @Override
    public void addUser(String username) {
        System.out.println("添加用户: " + username);
    }

    @Override
    public void deleteUser(Long id) {
        System.out.println("删除用户: " + id);
    }
}

// 动态代理处理器
public class LoggingHandler implements InvocationHandler {
    private final Object target;

    public LoggingHandler(Object target) {
        this.target = target;
    }

    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        System.out.println("[日志] 调用方法: " + method.getName());
        long start = System.currentTimeMillis();

        Object result = method.invoke(target, args);

        long duration = System.currentTimeMillis() - start;
        System.out.println("[日志] 方法执行耗时: " + duration + "ms");
        return result;
    }

    // 创建代理
    @SuppressWarnings("unchecked")
    public static <T> T createProxy(T target) {
        return (T) Proxy.newProxyInstance(
            target.getClass().getClassLoader(),
            target.getClass().getInterfaces(),
            new LoggingHandler(target)
        );
    }
}

// 使用
UserService service = new UserServiceImpl();
UserService proxy = LoggingHandler.createProxy(service);
proxy.addUser("张三");
```

## 四、注解与反射的结合应用

### 字段校验框架
```java
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
@interface NotNull {
    String message() default "字段不能为空";
}

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
@interface StringLength {
    int min() default 0;
    int max() default Integer.MAX_VALUE;
    String message() default "字符串长度不合法";
}

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
@interface Min {
    int value();
    String message() default "值太小";
}

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
@interface Max {
    int value();
    String message() default "值太大";
}

// 校验器
public class Validator {
    public static List<String> validate(Object obj) throws IllegalAccessException {
        List<String> errors = new ArrayList<>();
        Class<?> clazz = obj.getClass();

        for (Field field : clazz.getDeclaredFields()) {
            field.setAccessible(true);
            Object value = field.get(obj);

            // 校验@NotNull
            if (field.isAnnotationPresent(NotNull.class)) {
                if (value == null) {
                    errors.add(field.getAnnotation(NotNull.class).message());
                }
            }

            // 校验@StringLength
            if (field.isAnnotationPresent(StringLength.class) && value instanceof String) {
                String str = (String) value;
                StringLength annotation = field.getAnnotation(StringLength.class);
                if (str.length() < annotation.min() || str.length() > annotation.max()) {
                    errors.add(annotation.message());
                }
            }
        }
        return errors;
    }
}

// 使用
public class UserForm {
    @NotNull(message = "用户名不能为空")
    @StringLength(min = 2, max = 20, message = "用户名长度2-20")
    private String username;

    @Min(value = 1, message = "年龄至少1岁")
    @Max(value = 150, message = "年龄不能超过150")
    private int age;
}

// 验证
UserForm form = new UserForm();
form.setAge(200);
List<String> errors = Validator.validate(form);
// errors包含: ["用户名不能为空", "年龄不能超过150"]
```

## 相关标签
Java注解, Java反射, 动态代理, 元注解, Class对象, InvocationHandler
