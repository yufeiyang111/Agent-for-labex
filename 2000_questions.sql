USE labex;

INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，以下哪个不是基本数据类型？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'String是引用类型', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个修饰符表示方法可以被继承？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'protected成员可被继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是无限循环？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'for(;;)、while(true)、do{}while(true)都是', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个操作不会改变数组内容？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '增强for循环只是读取', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个方法不能继承？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '构造方法不能被继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是接口的默认方法特性？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Java 8起接口可以有default方法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个集合是有序的？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'TreeSet自然排序，LinkedHashSet保持插入顺序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是线程安全类？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'ArrayList不是线程安全', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个注解表示弃用？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '@Deprecated标记弃用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个关键字表示跳过本次循环？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'continue跳过本次循环', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('String类的trim()方法作用是？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '去除首尾空格', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个方法可以获取字符串长度？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'String用length()', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是重载的特征？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '方法名相同参数列表不同', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个关键字用于抛出异常？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'throw抛出异常', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是抽象类的特征？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不能实例化可以有抽象方法不能用final修饰', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Object类的hashCode()方法返回？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '返回对象的哈希码', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个修饰符的成员不能被继承？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'private成员不能被继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是HashMap的工作原理？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数组+链表/红黑树', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个操作会产生OOM？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '创建超大数组或递归深度过大', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，HashMap的默认初始容量是？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '16', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ArrayList的默认初始容量？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '10', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个方法用于线程同步？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'wait()、notify()、synchronized都用于线程同步', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Java的自动装箱类型？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Integer', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是Collection接口的方法？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'get()是List接口的方法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Vector和ArrayList的区别？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Vector线程安全', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个关键字用于定义常量？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'final', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个访问修饰符允许同包访问？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'default(package-private)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是静态内部类的特点？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '可以不依赖外部类实例创建', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是内部类的作用？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '访问外部类成员、实现多重继承、提高封装性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是方法重写的特征？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '方法名参数返回类型都要相同', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是this关键字的作用？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '引用当前对象、区分成员变量和局部变量、调用构造方法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是super关键字的作用？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '调用父类成员、调用父类构造方法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是final关键字的作用？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '修饰类不能被继承、修饰方法不能被重写、修饰变量不能改变', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是try-with-resources的特点？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '自动关闭资源', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Lambda表达式的特征？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '简洁语法、函数式接口、单参数可省略括号', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Stream API的特点？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '链式操作、惰性求值、中间操作和终端操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Optional的作用？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '避免空指针异常', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是CompletableFuture的特点？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '异步编程、链式调用、组合操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ReentrantLock的特点？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '可重入、tryLock、公平锁选择', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是CopyOnWriteArrayList的特点？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '读不加锁写加锁', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ConcurrentHashMap的并发级别？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分段锁', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是LongAdder的特点？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '高并发下性能优于AtomicLong', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ThreadLocal的作用？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '为每个线程提供独立变量副本', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是volatile的作用？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '保证可见性、防止指令重排序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是synchronized的作用？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '保证原子性、可见性、有序性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是CAS的作用？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '比较并交换', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是AQS的作用？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '队列同步器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Fork/Join框架的特点？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分而治之、工作窃取', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Java 10的新特性？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '局部变量类型推断', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Java 14的新特性？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Switch表达式', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Record的特点？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '简洁数据类定义', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Sealed Class的作用？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '限制类的继承层次', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Pattern类的matches方法？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '完全匹配', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Matcher的find方法？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '查找下一个匹配', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是NumberFormat的用途？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数字格式化', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是DecimalFormat的自定义模式？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '0和#的区别', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是LocalDate的of方法？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '创建指定日期', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Duration的between方法？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '计算时间间隔', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ZoneId的作用？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '时区标识', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Instant的特点？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '时间线上的点', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Path的toUri方法？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '转换为URI', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Files的lines方法？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '读取文件所有行', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Stream的reduce方法？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '归约操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Stream的collect方法？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '收集操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Optional的orElse方法？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '提供默认值', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Function的compose方法？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '组合函数', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Consumer的andThen方法？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '组合消费者', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Predicate的and方法？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '组合断言', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Supplier的get方法？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '获取结果', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是BiFunction的作用？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '接收两个参数返回结果', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是BiConsumer的作用？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '接收两个参数无返回值', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是UnaryOperator的作用？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '一元操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是BinaryOperator的作用？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '二元操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Map的computeIfAbsent方法？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '计算不存在时存入', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是List的replaceAll方法？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '替换所有元素', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Set的stream方法？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '转换为流', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Queue的offer方法？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '添加元素不抛异常', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Deque的push方法？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '栈操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Iterator的remove方法？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '安全删除', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ListIterator的特点？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '双向遍历', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Collections的sort方法？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '排序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Arrays的asList方法？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数组转列表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Objects的requireNonNull方法？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '检查非空', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是System的arraycopy方法？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数组复制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Math的round方法？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '四舍五入', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是StrictMath的作用？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '严格数学运算', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是BigDecimal的add方法？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '加法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是BigInteger的作用？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '大整数运算', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是EnumSet的of方法？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '创建枚举集合', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是EnumMap的构造方式？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '指定枚举类型', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Properties的setProperty方法？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '设置属性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Scanner的nextInt方法？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '读取整数', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Console的printf方法？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '格式化输出', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是StringBuilder的append方法？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '追加内容', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是StringBuffer的toString方法？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '转换为字符串', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是StringJoiner的作用？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '字符串拼接', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是StringTokenizer的hasMoreTokens方法？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '检查更多标记', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，以下哪个不是基本数据类型？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'String是引用类型', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个修饰符表示方法可以被继承？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'protected成员可被继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是无限循环？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'for(;;)、while(true)、do{}while(true)都是', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个操作不会改变数组内容？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '增强for循环只是读取', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个方法不能继承？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '构造方法不能被继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是接口的默认方法特性？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Java 8起接口可以有default方法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个集合是有序的？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'TreeSet自然排序，LinkedHashSet保持插入顺序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是线程安全类？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'ArrayList不是线程安全', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个注解表示弃用？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '@Deprecated标记弃用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个关键字表示跳过本次循环？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'continue跳过本次循环', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('String类的trim()方法作用是？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '去除首尾空格', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个方法可以获取字符串长度？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'String用length()', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是重载的特征？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '方法名相同参数列表不同', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个关键字用于抛出异常？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'throw抛出异常', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是抽象类的特征？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不能实例化可以有抽象方法不能用final修饰', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Object类的hashCode()方法返回？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '返回对象的哈希码', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个修饰符的成员不能被继承？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'private成员不能被继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是HashMap的工作原理？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数组+链表/红黑树', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个操作会产生OOM？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '创建超大数组或递归深度过大', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，HashMap的默认初始容量是？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '16', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ArrayList的默认初始容量？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '10', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个方法用于线程同步？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'wait()、notify()、synchronized都用于线程同步', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Java的自动装箱类型？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Integer', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是Collection接口的方法？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'get()是List接口的方法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Vector和ArrayList的区别？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Vector线程安全', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个关键字用于定义常量？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'final', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个访问修饰符允许同包访问？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'default(package-private)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是静态内部类的特点？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '可以不依赖外部类实例创建', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是内部类的作用？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '访问外部类成员、实现多重继承、提高封装性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是方法重写的特征？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '方法名参数返回类型都要相同', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是this关键字的作用？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '引用当前对象、区分成员变量和局部变量、调用构造方法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是super关键字的作用？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '调用父类成员、调用父类构造方法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是final关键字的作用？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '修饰类不能被继承、修饰方法不能被重写、修饰变量不能改变', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是try-with-resources的特点？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '自动关闭资源', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Lambda表达式的特征？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '简洁语法、函数式接口、单参数可省略括号', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Stream API的特点？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '链式操作、惰性求值、中间操作和终端操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Optional的作用？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '避免空指针异常', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是CompletableFuture的特点？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '异步编程、链式调用、组合操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ReentrantLock的特点？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '可重入、tryLock、公平锁选择', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是CopyOnWriteArrayList的特点？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '读不加锁写加锁', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ConcurrentHashMap的并发级别？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分段锁', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是LongAdder的特点？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '高并发下性能优于AtomicLong', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ThreadLocal的作用？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '为每个线程提供独立变量副本', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是volatile的作用？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '保证可见性、防止指令重排序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是synchronized的作用？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '保证原子性、可见性、有序性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是CAS的作用？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '比较并交换', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是AQS的作用？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '队列同步器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Fork/Join框架的特点？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分而治之、工作窃取', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Java 10的新特性？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '局部变量类型推断', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Java 14的新特性？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Switch表达式', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Record的特点？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '简洁数据类定义', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Sealed Class的作用？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '限制类的继承层次', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Pattern类的matches方法？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '完全匹配', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Matcher的find方法？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '查找下一个匹配', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是NumberFormat的用途？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数字格式化', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是DecimalFormat的自定义模式？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '0和#的区别', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是LocalDate的of方法？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '创建指定日期', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Duration的between方法？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '计算时间间隔', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ZoneId的作用？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '时区标识', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Instant的特点？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '时间线上的点', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Path的toUri方法？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '转换为URI', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Files的lines方法？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '读取文件所有行', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Stream的reduce方法？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '归约操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Stream的collect方法？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '收集操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Optional的orElse方法？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '提供默认值', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Function的compose方法？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '组合函数', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Consumer的andThen方法？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '组合消费者', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Predicate的and方法？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '组合断言', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Supplier的get方法？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '获取结果', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是BiFunction的作用？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '接收两个参数返回结果', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是BiConsumer的作用？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '接收两个参数无返回值', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是UnaryOperator的作用？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '一元操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是BinaryOperator的作用？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '二元操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Map的computeIfAbsent方法？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '计算不存在时存入', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是List的replaceAll方法？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '替换所有元素', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Set的stream方法？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '转换为流', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Queue的offer方法？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '添加元素不抛异常', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Deque的push方法？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '栈操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Iterator的remove方法？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '安全删除', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ListIterator的特点？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '双向遍历', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Collections的sort方法？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '排序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Arrays的asList方法？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数组转列表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Objects的requireNonNull方法？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '检查非空', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是System的arraycopy方法？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数组复制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Math的round方法？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '四舍五入', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是StrictMath的作用？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '严格数学运算', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是BigDecimal的add方法？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '加法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是BigInteger的作用？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '大整数运算', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是EnumSet的of方法？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '创建枚举集合', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是EnumMap的构造方式？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '指定枚举类型', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Properties的setProperty方法？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '设置属性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Scanner的nextInt方法？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '读取整数', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Console的printf方法？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '格式化输出', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是StringBuilder的append方法？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '追加内容', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是StringBuffer的toString方法？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '转换为字符串', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是StringJoiner的作用？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '字符串拼接', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是StringTokenizer的hasMoreTokens方法？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '检查更多标记', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，以下哪个不是基本数据类型？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'String是引用类型', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个修饰符表示方法可以被继承？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'protected成员可被继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是无限循环？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'for(;;)、while(true)、do{}while(true)都是', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个操作不会改变数组内容？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '增强for循环只是读取', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个方法不能继承？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '构造方法不能被继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是接口的默认方法特性？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Java 8起接口可以有default方法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个集合是有序的？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'TreeSet自然排序，LinkedHashSet保持插入顺序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是线程安全类？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'ArrayList不是线程安全', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个注解表示弃用？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '@Deprecated标记弃用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个关键字表示跳过本次循环？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'continue跳过本次循环', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('String类的trim()方法作用是？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '去除首尾空格', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个方法可以获取字符串长度？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'String用length()', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是重载的特征？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '方法名相同参数列表不同', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个关键字用于抛出异常？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'throw抛出异常', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是抽象类的特征？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不能实例化可以有抽象方法不能用final修饰', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Object类的hashCode()方法返回？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '返回对象的哈希码', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个修饰符的成员不能被继承？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'private成员不能被继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是HashMap的工作原理？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数组+链表/红黑树', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个操作会产生OOM？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '创建超大数组或递归深度过大', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，HashMap的默认初始容量是？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '16', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ArrayList的默认初始容量？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '10', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个方法用于线程同步？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'wait()、notify()、synchronized都用于线程同步', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Java的自动装箱类型？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Integer', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是Collection接口的方法？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'get()是List接口的方法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Vector和ArrayList的区别？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Vector线程安全', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个关键字用于定义常量？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'final', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个访问修饰符允许同包访问？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'default(package-private)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是静态内部类的特点？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '可以不依赖外部类实例创建', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是内部类的作用？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '访问外部类成员、实现多重继承、提高封装性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是方法重写的特征？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '方法名参数返回类型都要相同', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是this关键字的作用？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '引用当前对象、区分成员变量和局部变量、调用构造方法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是super关键字的作用？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '调用父类成员、调用父类构造方法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是final关键字的作用？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '修饰类不能被继承、修饰方法不能被重写、修饰变量不能改变', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是try-with-resources的特点？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '自动关闭资源', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Lambda表达式的特征？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '简洁语法、函数式接口、单参数可省略括号', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Stream API的特点？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '链式操作、惰性求值、中间操作和终端操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Optional的作用？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '避免空指针异常', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是CompletableFuture的特点？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '异步编程、链式调用、组合操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ReentrantLock的特点？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '可重入、tryLock、公平锁选择', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是CopyOnWriteArrayList的特点？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '读不加锁写加锁', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ConcurrentHashMap的并发级别？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分段锁', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是LongAdder的特点？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '高并发下性能优于AtomicLong', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ThreadLocal的作用？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '为每个线程提供独立变量副本', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是volatile的作用？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '保证可见性、防止指令重排序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是synchronized的作用？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '保证原子性、可见性、有序性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是CAS的作用？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '比较并交换', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是AQS的作用？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '队列同步器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Fork/Join框架的特点？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分而治之、工作窃取', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Java 10的新特性？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '局部变量类型推断', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Java 14的新特性？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Switch表达式', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Record的特点？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '简洁数据类定义', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Sealed Class的作用？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '限制类的继承层次', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Pattern类的matches方法？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '完全匹配', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Matcher的find方法？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '查找下一个匹配', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是NumberFormat的用途？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数字格式化', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是DecimalFormat的自定义模式？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '0和#的区别', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是LocalDate的of方法？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '创建指定日期', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Duration的between方法？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '计算时间间隔', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ZoneId的作用？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '时区标识', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Instant的特点？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '时间线上的点', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Path的toUri方法？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '转换为URI', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Files的lines方法？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '读取文件所有行', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Stream的reduce方法？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '归约操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Stream的collect方法？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '收集操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Optional的orElse方法？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '提供默认值', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Function的compose方法？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '组合函数', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Consumer的andThen方法？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '组合消费者', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Predicate的and方法？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '组合断言', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Supplier的get方法？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '获取结果', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是BiFunction的作用？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '接收两个参数返回结果', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是BiConsumer的作用？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '接收两个参数无返回值', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是UnaryOperator的作用？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '一元操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是BinaryOperator的作用？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '二元操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Map的computeIfAbsent方法？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '计算不存在时存入', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是List的replaceAll方法？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '替换所有元素', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Set的stream方法？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '转换为流', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Queue的offer方法？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '添加元素不抛异常', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Deque的push方法？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '栈操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Iterator的remove方法？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '安全删除', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ListIterator的特点？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '双向遍历', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Collections的sort方法？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '排序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Arrays的asList方法？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数组转列表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Objects的requireNonNull方法？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '检查非空', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是System的arraycopy方法？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数组复制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Math的round方法？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '四舍五入', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是StrictMath的作用？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '严格数学运算', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是BigDecimal的add方法？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '加法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是BigInteger的作用？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '大整数运算', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是EnumSet的of方法？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '创建枚举集合', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是EnumMap的构造方式？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '指定枚举类型', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Properties的setProperty方法？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '设置属性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Scanner的nextInt方法？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '读取整数', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Console的printf方法？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '格式化输出', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是StringBuilder的append方法？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '追加内容', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是StringBuffer的toString方法？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '转换为字符串', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是StringJoiner的作用？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '字符串拼接', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是StringTokenizer的hasMoreTokens方法？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '检查更多标记', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，以下哪个不是基本数据类型？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'String是引用类型', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个修饰符表示方法可以被继承？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'protected成员可被继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是无限循环？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'for(;;)、while(true)、do{}while(true)都是', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个操作不会改变数组内容？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '增强for循环只是读取', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个方法不能继承？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '构造方法不能被继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是接口的默认方法特性？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Java 8起接口可以有default方法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个集合是有序的？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'TreeSet自然排序，LinkedHashSet保持插入顺序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是线程安全类？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'ArrayList不是线程安全', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个注解表示弃用？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '@Deprecated标记弃用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个关键字表示跳过本次循环？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'continue跳过本次循环', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('String类的trim()方法作用是？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '去除首尾空格', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个方法可以获取字符串长度？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'String用length()', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是重载的特征？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '方法名相同参数列表不同', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个关键字用于抛出异常？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'throw抛出异常', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是抽象类的特征？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不能实例化可以有抽象方法不能用final修饰', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Object类的hashCode()方法返回？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '返回对象的哈希码', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个修饰符的成员不能被继承？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'private成员不能被继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是HashMap的工作原理？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数组+链表/红黑树', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个操作会产生OOM？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '创建超大数组或递归深度过大', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，HashMap的默认初始容量是？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '16', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ArrayList的默认初始容量？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '10', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个方法用于线程同步？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'wait()、notify()、synchronized都用于线程同步', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Java的自动装箱类型？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Integer', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是Collection接口的方法？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'get()是List接口的方法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Vector和ArrayList的区别？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Vector线程安全', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个关键字用于定义常量？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'final', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个访问修饰符允许同包访问？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'default(package-private)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是静态内部类的特点？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '可以不依赖外部类实例创建', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是内部类的作用？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '访问外部类成员、实现多重继承、提高封装性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是方法重写的特征？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '方法名参数返回类型都要相同', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是this关键字的作用？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '引用当前对象、区分成员变量和局部变量、调用构造方法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是super关键字的作用？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '调用父类成员、调用父类构造方法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是final关键字的作用？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '修饰类不能被继承、修饰方法不能被重写、修饰变量不能改变', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是try-with-resources的特点？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '自动关闭资源', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Lambda表达式的特征？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '简洁语法、函数式接口、单参数可省略括号', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Stream API的特点？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '链式操作、惰性求值、中间操作和终端操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Optional的作用？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '避免空指针异常', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是CompletableFuture的特点？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '异步编程、链式调用、组合操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ReentrantLock的特点？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '可重入、tryLock、公平锁选择', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是CopyOnWriteArrayList的特点？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '读不加锁写加锁', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ConcurrentHashMap的并发级别？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分段锁', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是LongAdder的特点？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '高并发下性能优于AtomicLong', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ThreadLocal的作用？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '为每个线程提供独立变量副本', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是volatile的作用？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '保证可见性、防止指令重排序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是synchronized的作用？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '保证原子性、可见性、有序性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是CAS的作用？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '比较并交换', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是AQS的作用？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '队列同步器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Fork/Join框架的特点？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分而治之、工作窃取', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Java 10的新特性？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '局部变量类型推断', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Java 14的新特性？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Switch表达式', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Record的特点？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '简洁数据类定义', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Sealed Class的作用？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '限制类的继承层次', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Pattern类的matches方法？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '完全匹配', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Matcher的find方法？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '查找下一个匹配', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是NumberFormat的用途？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数字格式化', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是DecimalFormat的自定义模式？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '0和#的区别', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是LocalDate的of方法？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '创建指定日期', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Duration的between方法？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '计算时间间隔', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ZoneId的作用？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '时区标识', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Instant的特点？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '时间线上的点', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Path的toUri方法？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '转换为URI', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Files的lines方法？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '读取文件所有行', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Stream的reduce方法？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '归约操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Stream的collect方法？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '收集操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Optional的orElse方法？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '提供默认值', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Function的compose方法？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '组合函数', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Consumer的andThen方法？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '组合消费者', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Predicate的and方法？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '组合断言', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Supplier的get方法？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '获取结果', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是BiFunction的作用？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '接收两个参数返回结果', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是BiConsumer的作用？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '接收两个参数无返回值', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是UnaryOperator的作用？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '一元操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是BinaryOperator的作用？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '二元操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Map的computeIfAbsent方法？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '计算不存在时存入', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是List的replaceAll方法？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '替换所有元素', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Set的stream方法？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '转换为流', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Queue的offer方法？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '添加元素不抛异常', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Deque的push方法？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '栈操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Iterator的remove方法？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '安全删除', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ListIterator的特点？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '双向遍历', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Collections的sort方法？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '排序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Arrays的asList方法？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数组转列表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Objects的requireNonNull方法？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '检查非空', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是System的arraycopy方法？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数组复制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Math的round方法？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '四舍五入', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是StrictMath的作用？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '严格数学运算', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是BigDecimal的add方法？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '加法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是BigInteger的作用？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '大整数运算', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是EnumSet的of方法？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '创建枚举集合', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是EnumMap的构造方式？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '指定枚举类型', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Properties的setProperty方法？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '设置属性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Scanner的nextInt方法？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '读取整数', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Console的printf方法？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '格式化输出', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是StringBuilder的append方法？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '追加内容', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是StringBuffer的toString方法？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '转换为字符串', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是StringJoiner的作用？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '字符串拼接', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是StringTokenizer的hasMoreTokens方法？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '检查更多标记', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，以下哪个不是基本数据类型？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'String是引用类型', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个修饰符表示方法可以被继承？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'protected成员可被继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是无限循环？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'for(;;)、while(true)、do{}while(true)都是', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个操作不会改变数组内容？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '增强for循环只是读取', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个方法不能继承？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '构造方法不能被继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是接口的默认方法特性？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Java 8起接口可以有default方法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个集合是有序的？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'TreeSet自然排序，LinkedHashSet保持插入顺序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是线程安全类？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'ArrayList不是线程安全', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个注解表示弃用？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '@Deprecated标记弃用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个关键字表示跳过本次循环？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'continue跳过本次循环', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('String类的trim()方法作用是？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '去除首尾空格', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个方法可以获取字符串长度？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'String用length()', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是重载的特征？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '方法名相同参数列表不同', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个关键字用于抛出异常？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'throw抛出异常', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是抽象类的特征？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不能实例化可以有抽象方法不能用final修饰', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Object类的hashCode()方法返回？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '返回对象的哈希码', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个修饰符的成员不能被继承？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'private成员不能被继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是HashMap的工作原理？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数组+链表/红黑树', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个操作会产生OOM？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '创建超大数组或递归深度过大', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，HashMap的默认初始容量是？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '16', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ArrayList的默认初始容量？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '10', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个方法用于线程同步？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'wait()、notify()、synchronized都用于线程同步', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Java的自动装箱类型？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Integer', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是Collection接口的方法？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'get()是List接口的方法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Vector和ArrayList的区别？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Vector线程安全', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个关键字用于定义常量？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'final', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个访问修饰符允许同包访问？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'default(package-private)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是静态内部类的特点？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '可以不依赖外部类实例创建', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是内部类的作用？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '访问外部类成员、实现多重继承、提高封装性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是方法重写的特征？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '方法名参数返回类型都要相同', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是this关键字的作用？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '引用当前对象、区分成员变量和局部变量、调用构造方法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是super关键字的作用？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '调用父类成员、调用父类构造方法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是final关键字的作用？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '修饰类不能被继承、修饰方法不能被重写、修饰变量不能改变', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是try-with-resources的特点？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '自动关闭资源', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Lambda表达式的特征？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '简洁语法、函数式接口、单参数可省略括号', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Stream API的特点？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '链式操作、惰性求值、中间操作和终端操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Optional的作用？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '避免空指针异常', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是CompletableFuture的特点？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '异步编程、链式调用、组合操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ReentrantLock的特点？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '可重入、tryLock、公平锁选择', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是CopyOnWriteArrayList的特点？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '读不加锁写加锁', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ConcurrentHashMap的并发级别？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分段锁', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是LongAdder的特点？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '高并发下性能优于AtomicLong', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ThreadLocal的作用？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '为每个线程提供独立变量副本', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是volatile的作用？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '保证可见性、防止指令重排序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是synchronized的作用？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '保证原子性、可见性、有序性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是CAS的作用？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '比较并交换', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是AQS的作用？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '队列同步器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Fork/Join框架的特点？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分而治之、工作窃取', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Java 10的新特性？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '局部变量类型推断', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Java 14的新特性？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Switch表达式', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Record的特点？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '简洁数据类定义', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Sealed Class的作用？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '限制类的继承层次', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Pattern类的matches方法？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '完全匹配', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Matcher的find方法？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '查找下一个匹配', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是NumberFormat的用途？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数字格式化', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是DecimalFormat的自定义模式？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '0和#的区别', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是LocalDate的of方法？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '创建指定日期', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Duration的between方法？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '计算时间间隔', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ZoneId的作用？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '时区标识', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Instant的特点？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '时间线上的点', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Path的toUri方法？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '转换为URI', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Files的lines方法？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '读取文件所有行', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Stream的reduce方法？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '归约操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Stream的collect方法？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '收集操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Optional的orElse方法？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '提供默认值', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Function的compose方法？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '组合函数', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Consumer的andThen方法？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '组合消费者', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Predicate的and方法？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '组合断言', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Supplier的get方法？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '获取结果', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是BiFunction的作用？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '接收两个参数返回结果', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是BiConsumer的作用？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '接收两个参数无返回值', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是UnaryOperator的作用？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '一元操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是BinaryOperator的作用？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '二元操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Map的computeIfAbsent方法？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '计算不存在时存入', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是List的replaceAll方法？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '替换所有元素', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Set的stream方法？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '转换为流', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Queue的offer方法？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '添加元素不抛异常', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Deque的push方法？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '栈操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Iterator的remove方法？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '安全删除', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ListIterator的特点？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '双向遍历', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Collections的sort方法？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '排序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Arrays的asList方法？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数组转列表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Objects的requireNonNull方法？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '检查非空', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是System的arraycopy方法？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数组复制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Math的round方法？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '四舍五入', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是StrictMath的作用？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '严格数学运算', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是BigDecimal的add方法？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '加法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是BigInteger的作用？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '大整数运算', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是EnumSet的of方法？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '创建枚举集合', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是EnumMap的构造方式？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '指定枚举类型', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Properties的setProperty方法？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '设置属性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Scanner的nextInt方法？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '读取整数', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Console的printf方法？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '格式化输出', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是StringBuilder的append方法？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '追加内容', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是StringBuffer的toString方法？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '转换为字符串', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是StringJoiner的作用？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '字符串拼接', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是StringTokenizer的hasMoreTokens方法？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '检查更多标记', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('一个类可以继承几个父类？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Java单继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个关键字用于实现继承？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'extends', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('构造方法能否被继承？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不能被继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个修饰符的成员不能被外部访问？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'private', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('抽象类能否实例化？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不能', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('接口中定义的变量默认是什么修饰符？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'public static final', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个关键字用于调用父类构造方法？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'super', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('方法重写时，返回类型可以不同吗？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '可以是父类返回类型的子类型', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是多重继承的实现方式？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '类和接口组合', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('内部类可以访问外部类的什么成员？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '所有成员包括私有', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('静态内部类和成员内部类的区别是？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不需要外部类实例', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('匿名内部类的特点是？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '没有名字、只能继承一个类或实现一个接口', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是封装的作用？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '隐藏实现细节', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是继承的作用？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '代码复用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是多态的作用？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '父类引用指向子类对象', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是里氏替换原则的要求？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '子类可以替换父类', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是开闭原则的要求？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '对扩展开放对修改关闭', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是单一职责原则的要求？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '一个类只负责一个职责', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是依赖倒置原则的要求？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '依赖抽象而非具体', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是接口隔离原则的要求？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '接口尽量细化', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('组合和继承的区别是？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '组合是has-a关系，继承是is-a关系', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是委托的作用？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '将任务交给其他类处理', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('策略模式和简单工厂的区别是？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '策略模式将算法封装', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('模板方法模式的组成是？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '抽象模板和具体实现', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('装饰器模式和继承的区别是？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '装饰器更灵活', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('代理模式的作用是？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '控制对对象的访问', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('观察者模式中Subject的作用是？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '维护观察者列表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('建造者模式的链式调用返回什么？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Builder本身', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('单例模式的线程安全要求是？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '实例只创建一个', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('工厂方法模式的抽象产品由谁创建？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '抽象工厂', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('抽象工厂模式的适用场景是？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '多个产品族', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('适配器模式的作用是？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '接口转换', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('桥接模式的作用是？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分离抽象和实现', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('组合模式的作用是？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '树形结构统一处理', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('享元模式的作用是？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '共享细粒度对象', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('责任链模式的组成是？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '处理器和next引用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('命令模式的作用是？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '请求封装为对象', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('迭代器模式的组成是？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Iterator和Collection', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('中介者模式的作用是？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '集中对象交互', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('备忘录模式的作用是？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '保存和恢复状态', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('状态模式的作用是？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '对象状态改变行为改变', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('访问者模式的作用是？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '操作和数据分离', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('解释器模式的作用是？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '定义语法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是GoF设计模式？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'MVC', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('设计模式的核心目的是？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '复用解决方案', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个原则要求面向接口编程？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '依赖倒置', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个原则要求少用继承多用组合？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '组合优于继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是反模式？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'God Object', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是代码重构的目标？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '提高可读性和可维护性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是DRY原则？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Don\'t Repeat Yourself', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('一个类可以继承几个父类？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Java单继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个关键字用于实现继承？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'extends', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('构造方法能否被继承？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不能被继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个修饰符的成员不能被外部访问？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'private', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('抽象类能否实例化？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不能', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('接口中定义的变量默认是什么修饰符？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'public static final', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个关键字用于调用父类构造方法？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'super', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('方法重写时，返回类型可以不同吗？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '可以是父类返回类型的子类型', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是多重继承的实现方式？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '类和接口组合', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('内部类可以访问外部类的什么成员？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '所有成员包括私有', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('静态内部类和成员内部类的区别是？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不需要外部类实例', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('匿名内部类的特点是？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '没有名字、只能继承一个类或实现一个接口', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是封装的作用？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '隐藏实现细节', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是继承的作用？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '代码复用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是多态的作用？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '父类引用指向子类对象', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是里氏替换原则的要求？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '子类可以替换父类', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是开闭原则的要求？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '对扩展开放对修改关闭', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是单一职责原则的要求？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '一个类只负责一个职责', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是依赖倒置原则的要求？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '依赖抽象而非具体', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是接口隔离原则的要求？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '接口尽量细化', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('组合和继承的区别是？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '组合是has-a关系，继承是is-a关系', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是委托的作用？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '将任务交给其他类处理', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('策略模式和简单工厂的区别是？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '策略模式将算法封装', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('模板方法模式的组成是？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '抽象模板和具体实现', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('装饰器模式和继承的区别是？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '装饰器更灵活', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('代理模式的作用是？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '控制对对象的访问', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('观察者模式中Subject的作用是？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '维护观察者列表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('建造者模式的链式调用返回什么？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Builder本身', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('单例模式的线程安全要求是？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '实例只创建一个', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('工厂方法模式的抽象产品由谁创建？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '抽象工厂', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('抽象工厂模式的适用场景是？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '多个产品族', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('适配器模式的作用是？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '接口转换', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('桥接模式的作用是？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分离抽象和实现', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('组合模式的作用是？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '树形结构统一处理', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('享元模式的作用是？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '共享细粒度对象', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('责任链模式的组成是？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '处理器和next引用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('命令模式的作用是？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '请求封装为对象', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('迭代器模式的组成是？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Iterator和Collection', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('中介者模式的作用是？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '集中对象交互', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('备忘录模式的作用是？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '保存和恢复状态', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('状态模式的作用是？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '对象状态改变行为改变', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('访问者模式的作用是？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '操作和数据分离', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('解释器模式的作用是？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '定义语法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是GoF设计模式？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'MVC', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('设计模式的核心目的是？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '复用解决方案', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个原则要求面向接口编程？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '依赖倒置', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个原则要求少用继承多用组合？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '组合优于继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是反模式？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'God Object', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是代码重构的目标？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '提高可读性和可维护性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是DRY原则？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Don\'t Repeat Yourself', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('一个类可以继承几个父类？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Java单继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个关键字用于实现继承？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'extends', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('构造方法能否被继承？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不能被继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个修饰符的成员不能被外部访问？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'private', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('抽象类能否实例化？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不能', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('接口中定义的变量默认是什么修饰符？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'public static final', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个关键字用于调用父类构造方法？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'super', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('方法重写时，返回类型可以不同吗？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '可以是父类返回类型的子类型', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是多重继承的实现方式？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '类和接口组合', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('内部类可以访问外部类的什么成员？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '所有成员包括私有', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('静态内部类和成员内部类的区别是？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不需要外部类实例', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('匿名内部类的特点是？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '没有名字、只能继承一个类或实现一个接口', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是封装的作用？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '隐藏实现细节', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是继承的作用？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '代码复用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是多态的作用？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '父类引用指向子类对象', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是里氏替换原则的要求？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '子类可以替换父类', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是开闭原则的要求？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '对扩展开放对修改关闭', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是单一职责原则的要求？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '一个类只负责一个职责', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是依赖倒置原则的要求？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '依赖抽象而非具体', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是接口隔离原则的要求？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '接口尽量细化', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('组合和继承的区别是？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '组合是has-a关系，继承是is-a关系', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是委托的作用？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '将任务交给其他类处理', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('策略模式和简单工厂的区别是？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '策略模式将算法封装', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('模板方法模式的组成是？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '抽象模板和具体实现', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('装饰器模式和继承的区别是？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '装饰器更灵活', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('代理模式的作用是？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '控制对对象的访问', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('观察者模式中Subject的作用是？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '维护观察者列表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('建造者模式的链式调用返回什么？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Builder本身', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('单例模式的线程安全要求是？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '实例只创建一个', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('工厂方法模式的抽象产品由谁创建？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '抽象工厂', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('抽象工厂模式的适用场景是？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '多个产品族', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('适配器模式的作用是？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '接口转换', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('桥接模式的作用是？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分离抽象和实现', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('组合模式的作用是？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '树形结构统一处理', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('享元模式的作用是？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '共享细粒度对象', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('责任链模式的组成是？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '处理器和next引用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('命令模式的作用是？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '请求封装为对象', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('迭代器模式的组成是？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Iterator和Collection', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('中介者模式的作用是？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '集中对象交互', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('备忘录模式的作用是？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '保存和恢复状态', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('状态模式的作用是？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '对象状态改变行为改变', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('访问者模式的作用是？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '操作和数据分离', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('解释器模式的作用是？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '定义语法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是GoF设计模式？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'MVC', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('设计模式的核心目的是？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '复用解决方案', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个原则要求面向接口编程？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '依赖倒置', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个原则要求少用继承多用组合？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '组合优于继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是反模式？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'God Object', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是代码重构的目标？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '提高可读性和可维护性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是DRY原则？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Don\'t Repeat Yourself', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('一个类可以继承几个父类？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Java单继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个关键字用于实现继承？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'extends', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('构造方法能否被继承？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不能被继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个修饰符的成员不能被外部访问？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'private', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('抽象类能否实例化？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不能', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('接口中定义的变量默认是什么修饰符？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'public static final', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个关键字用于调用父类构造方法？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'super', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('方法重写时，返回类型可以不同吗？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '可以是父类返回类型的子类型', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是多重继承的实现方式？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '类和接口组合', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('内部类可以访问外部类的什么成员？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '所有成员包括私有', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('静态内部类和成员内部类的区别是？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不需要外部类实例', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('匿名内部类的特点是？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '没有名字、只能继承一个类或实现一个接口', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是封装的作用？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '隐藏实现细节', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是继承的作用？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '代码复用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是多态的作用？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '父类引用指向子类对象', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是里氏替换原则的要求？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '子类可以替换父类', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是开闭原则的要求？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '对扩展开放对修改关闭', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是单一职责原则的要求？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '一个类只负责一个职责', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是依赖倒置原则的要求？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '依赖抽象而非具体', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是接口隔离原则的要求？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '接口尽量细化', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('组合和继承的区别是？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '组合是has-a关系，继承是is-a关系', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是委托的作用？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '将任务交给其他类处理', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('策略模式和简单工厂的区别是？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '策略模式将算法封装', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('模板方法模式的组成是？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '抽象模板和具体实现', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('装饰器模式和继承的区别是？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '装饰器更灵活', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('代理模式的作用是？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '控制对对象的访问', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('观察者模式中Subject的作用是？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '维护观察者列表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('建造者模式的链式调用返回什么？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Builder本身', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('单例模式的线程安全要求是？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '实例只创建一个', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('工厂方法模式的抽象产品由谁创建？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '抽象工厂', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('抽象工厂模式的适用场景是？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '多个产品族', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('适配器模式的作用是？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '接口转换', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('桥接模式的作用是？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分离抽象和实现', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('组合模式的作用是？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '树形结构统一处理', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('享元模式的作用是？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '共享细粒度对象', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('责任链模式的组成是？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '处理器和next引用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('命令模式的作用是？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '请求封装为对象', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('迭代器模式的组成是？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Iterator和Collection', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('中介者模式的作用是？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '集中对象交互', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('备忘录模式的作用是？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '保存和恢复状态', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('状态模式的作用是？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '对象状态改变行为改变', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('访问者模式的作用是？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '操作和数据分离', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('解释器模式的作用是？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '定义语法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是GoF设计模式？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'MVC', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('设计模式的核心目的是？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '复用解决方案', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个原则要求面向接口编程？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '依赖倒置', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个原则要求少用继承多用组合？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '组合优于继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是反模式？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'God Object', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是代码重构的目标？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '提高可读性和可维护性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是DRY原则？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Don\'t Repeat Yourself', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL注入属于什么类型的攻击？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '代码注入', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是防御SQL注入的最佳方式？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '参数化查询', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MyBatis中哪个符号可以防止SQL注入？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '#{}', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('联合查询注入利用SQL的哪个关键字？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'UNION', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('错误型SQL注入利用什么获取信息？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数据库错误信息', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('时间盲注中SLEEP()函数的作用是？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '延长查询时间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('堆叠查询注入使用什么字符分隔SQL语句？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分号', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('布尔盲注通过什么判断条件真假？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '页面返回内容', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('XSS的全称是？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Cross-Site Scripting', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个HTTP头可以防护XSS？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Content-Security-Policy', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HttpOnly Cookie的作用是？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '防止JavaScript访问', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DOM型XSS的特点是？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '完全在客户端执行', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSRF的全称是？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Cross-Site Request Forgery', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是CSRF的防护措施？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '使用HTTPS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSRF攻击利用的前提是？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '用户已登录', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Anti-CSRF Token的工作原理是？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '验证表单和Session中Token一致性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SSRF是指？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '服务器端请求伪造', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SSRF的主要危害包括？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '访问内网数据、扫描端口、攻击内部服务', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是安全的密码存储方式？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'MD5', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是安全的密码存储方式？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'BCrypt', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数字信封的组成是？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '对称加密数据+接收方公钥加密密钥', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('同源策略的三要素是？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '协议、域名、端口', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个HTTP头用于防止点击劫持？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'X-Frame-Options', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('文件上传漏洞的主要危害是？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '上传恶意脚本执行命令', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是安全的文件上传处理方式？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '直接保存原文件名', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MIME类型验证可以被什么绕过？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '修改Content-Type头和使用00截断', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('命令注入（Command Injection）是指？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '用户数据被当作系统命令执行', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('水平越权是指？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '同权限用户访问他人资源', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('垂直越权是指？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '低权限用户获得高权限操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('敏感信息泄露的途径包括？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '错误信息、代码仓库、日志文件', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('信息收集阶段可以获取哪些信息？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DNS记录、员工社交媒体、错误页面', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('防止SQL注入的参数化查询原理是？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'SQL结构和数据分离', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL注入中，\' OR \'1\'=\'1 的作用是？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '使条件永远为真', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('UNION注入要求两个SELECT的什么相同？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '列数', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ORDER BY注入通过什么确定列数？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '递增数字直到报错', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个函数常用于错误型注入？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'UPDATEXML()', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个函数常用于时间盲注？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'SLEEP()', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('BENCHMARK()函数的作用是？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '重复执行表达式消耗时间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是布尔盲注的特征？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '页面正常或异常两种状态', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('堆叠查询可以执行什么类型的SQL？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DDL、DML、DCL', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('参数化查询的PreparedStatement如何工作？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '预编译SQL结构后绑定参数', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('在Java中，哪个类用于参数化查询？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'PreparedStatement', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MyBatis中${}为什么不安全？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '直接字符串替换', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('使用参数化查询后还需要输入验证吗？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '需要业务层面校验', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ORM框架能完全防止SQL注入吗？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '使用原生SQL时仍有风险', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('输入验证中白名单和黑名单哪个更安全？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '白名单', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('仅仅过滤SQL关键字能防御注入吗？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不能，攻击者可使用编码绕过', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据库最小权限原则的作用是？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '限制攻击成功后的损害范围', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Web应用防火墙（WAF）的作用是？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '检测和阻止Web攻击', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('安全错误处理的原则是？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '对用户隐藏错误详情记录到日志', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('生产环境应该关闭什么以防止信息泄露？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '详细错误信息', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSP的default-src指令作用是？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '设置默认资源来源', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('X-XSS-Protection头的作用是？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '启用浏览器XSS过滤器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Referer头可以完全防止CSRF吗？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不能，Referer可被篡改或丢失', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Samesite Cookie可以防止什么攻击？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'CSRF', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CORS的origin头作用是？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '跨域请求授权', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('JSONP为什么存在安全风险？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '缺乏origin验证', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WebSocket的同源策略是怎样的？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '没有同源限制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('JSON劫持攻击的目标是？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '获取敏感JSON数据', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CORS的Access-Control-Allow-Origin能设为*吗？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不能含credentials时', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('预检请求使用什么HTTP方法？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'OPTIONS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是CSP的script-src指令作用？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '限制JavaScript来源', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('X-Content-Type-Options头的作用是？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '禁止MIME sniffing', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HSTS头的作用是？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '强制使用HTTPS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HPKP头的作用是？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '公钥固定防止中间人', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是安全的会话管理措施？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '在URL中传递SessionID', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Session fixation攻击是什么？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '预先设置SessionID然后劫持', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSRF Token应该存放在哪里？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Session和表单中都存', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是点击劫持的特征？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '透明iframe覆盖诱骗点击', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('UI redress攻击又称为？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '点击劫持', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('XSS Worm是什么？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '自我复制传播的XSS攻击', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('存储型XSS的注入点包括？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '评论区、用户资料、文章发布', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('反射型XSS的典型攻击向量是？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'URL参数', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DOM型XSS的注入点是什么？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'JavaScript代码', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('htmlspecialchars()函数能防护什么？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'XSS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是HTML编码的字符？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '<>&\"\'', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Unicode编码可用于绕过什么检测？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'WAF', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Null byte截断可用于绕过什么？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '文件类型检查', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('双URL编码可用于绕过什么？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '输入过滤', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('大小写混合可用于绕过什么？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '简单过滤', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL注入中注释符的作用是？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '绕过后续条件验证', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('16进制编码可用于绕过什么检测？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '字符串过滤', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('宽字节注入利用什么原理？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '编码转换', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的Secure属性作用是？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '仅在HTTPS发送', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的HttpOnly属性作用是？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '禁止JavaScript访问', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Session和Cookie的主要区别是？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '存储位置不同', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的SAVE命令用于？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '同步保存到磁盘', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的BGSAVE命令用于？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '异步保存到磁盘', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的AOF持久化方式是？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '追加命令到日志', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的RDB持久化方式是？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '定时快照', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的MULTI命令用于？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '开启事务', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的WATCH命令用于？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '监控键变化', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的SUBSCRIBE命令用于？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '订阅频道', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的PUBLISH命令用于？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '发布消息', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的EXPIRE命令用于？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '设置过期时间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的TTL命令用于？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '获取剩余生存时间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的KEYS命令用于？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '模式匹配查找键', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的SCAN命令用于？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '增量迭代键', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的INFO命令用于？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '获取服务器信息', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL注入属于什么类型的攻击？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '代码注入', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是防御SQL注入的最佳方式？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '参数化查询', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MyBatis中哪个符号可以防止SQL注入？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '#{}', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('联合查询注入利用SQL的哪个关键字？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'UNION', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('错误型SQL注入利用什么获取信息？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数据库错误信息', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('时间盲注中SLEEP()函数的作用是？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '延长查询时间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('堆叠查询注入使用什么字符分隔SQL语句？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分号', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('布尔盲注通过什么判断条件真假？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '页面返回内容', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('XSS的全称是？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Cross-Site Scripting', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个HTTP头可以防护XSS？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Content-Security-Policy', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HttpOnly Cookie的作用是？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '防止JavaScript访问', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DOM型XSS的特点是？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '完全在客户端执行', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSRF的全称是？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Cross-Site Request Forgery', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是CSRF的防护措施？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '使用HTTPS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSRF攻击利用的前提是？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '用户已登录', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Anti-CSRF Token的工作原理是？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '验证表单和Session中Token一致性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SSRF是指？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '服务器端请求伪造', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SSRF的主要危害包括？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '访问内网数据、扫描端口、攻击内部服务', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是安全的密码存储方式？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'MD5', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是安全的密码存储方式？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'BCrypt', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数字信封的组成是？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '对称加密数据+接收方公钥加密密钥', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('同源策略的三要素是？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '协议、域名、端口', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个HTTP头用于防止点击劫持？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'X-Frame-Options', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('文件上传漏洞的主要危害是？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '上传恶意脚本执行命令', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是安全的文件上传处理方式？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '直接保存原文件名', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MIME类型验证可以被什么绕过？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '修改Content-Type头和使用00截断', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('命令注入（Command Injection）是指？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '用户数据被当作系统命令执行', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('水平越权是指？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '同权限用户访问他人资源', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('垂直越权是指？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '低权限用户获得高权限操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('敏感信息泄露的途径包括？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '错误信息、代码仓库、日志文件', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('信息收集阶段可以获取哪些信息？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DNS记录、员工社交媒体、错误页面', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('防止SQL注入的参数化查询原理是？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'SQL结构和数据分离', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL注入中，\' OR \'1\'=\'1 的作用是？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '使条件永远为真', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('UNION注入要求两个SELECT的什么相同？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '列数', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ORDER BY注入通过什么确定列数？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '递增数字直到报错', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个函数常用于错误型注入？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'UPDATEXML()', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个函数常用于时间盲注？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'SLEEP()', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('BENCHMARK()函数的作用是？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '重复执行表达式消耗时间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是布尔盲注的特征？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '页面正常或异常两种状态', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('堆叠查询可以执行什么类型的SQL？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DDL、DML、DCL', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('参数化查询的PreparedStatement如何工作？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '预编译SQL结构后绑定参数', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('在Java中，哪个类用于参数化查询？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'PreparedStatement', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MyBatis中${}为什么不安全？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '直接字符串替换', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('使用参数化查询后还需要输入验证吗？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '需要业务层面校验', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ORM框架能完全防止SQL注入吗？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '使用原生SQL时仍有风险', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('输入验证中白名单和黑名单哪个更安全？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '白名单', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('仅仅过滤SQL关键字能防御注入吗？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不能，攻击者可使用编码绕过', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据库最小权限原则的作用是？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '限制攻击成功后的损害范围', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Web应用防火墙（WAF）的作用是？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '检测和阻止Web攻击', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('安全错误处理的原则是？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '对用户隐藏错误详情记录到日志', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('生产环境应该关闭什么以防止信息泄露？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '详细错误信息', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSP的default-src指令作用是？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '设置默认资源来源', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('X-XSS-Protection头的作用是？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '启用浏览器XSS过滤器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Referer头可以完全防止CSRF吗？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不能，Referer可被篡改或丢失', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Samesite Cookie可以防止什么攻击？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'CSRF', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CORS的origin头作用是？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '跨域请求授权', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('JSONP为什么存在安全风险？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '缺乏origin验证', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WebSocket的同源策略是怎样的？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '没有同源限制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('JSON劫持攻击的目标是？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '获取敏感JSON数据', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CORS的Access-Control-Allow-Origin能设为*吗？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不能含credentials时', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('预检请求使用什么HTTP方法？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'OPTIONS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是CSP的script-src指令作用？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '限制JavaScript来源', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('X-Content-Type-Options头的作用是？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '禁止MIME sniffing', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HSTS头的作用是？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '强制使用HTTPS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HPKP头的作用是？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '公钥固定防止中间人', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是安全的会话管理措施？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '在URL中传递SessionID', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Session fixation攻击是什么？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '预先设置SessionID然后劫持', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSRF Token应该存放在哪里？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Session和表单中都存', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是点击劫持的特征？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '透明iframe覆盖诱骗点击', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('UI redress攻击又称为？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '点击劫持', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('XSS Worm是什么？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '自我复制传播的XSS攻击', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('存储型XSS的注入点包括？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '评论区、用户资料、文章发布', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('反射型XSS的典型攻击向量是？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'URL参数', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DOM型XSS的注入点是什么？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'JavaScript代码', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('htmlspecialchars()函数能防护什么？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'XSS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是HTML编码的字符？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '<>&\"\'', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Unicode编码可用于绕过什么检测？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'WAF', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Null byte截断可用于绕过什么？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '文件类型检查', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('双URL编码可用于绕过什么？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '输入过滤', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('大小写混合可用于绕过什么？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '简单过滤', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL注入中注释符的作用是？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '绕过后续条件验证', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('16进制编码可用于绕过什么检测？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '字符串过滤', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('宽字节注入利用什么原理？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '编码转换', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的Secure属性作用是？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '仅在HTTPS发送', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的HttpOnly属性作用是？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '禁止JavaScript访问', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Session和Cookie的主要区别是？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '存储位置不同', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的SAVE命令用于？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '同步保存到磁盘', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的BGSAVE命令用于？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '异步保存到磁盘', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的AOF持久化方式是？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '追加命令到日志', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的RDB持久化方式是？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '定时快照', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的MULTI命令用于？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '开启事务', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的WATCH命令用于？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '监控键变化', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的SUBSCRIBE命令用于？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '订阅频道', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的PUBLISH命令用于？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '发布消息', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的EXPIRE命令用于？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '设置过期时间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的TTL命令用于？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '获取剩余生存时间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的KEYS命令用于？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '模式匹配查找键', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的SCAN命令用于？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '增量迭代键', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的INFO命令用于？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '获取服务器信息', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL注入属于什么类型的攻击？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '代码注入', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是防御SQL注入的最佳方式？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '参数化查询', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MyBatis中哪个符号可以防止SQL注入？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '#{}', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('联合查询注入利用SQL的哪个关键字？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'UNION', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('错误型SQL注入利用什么获取信息？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数据库错误信息', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('时间盲注中SLEEP()函数的作用是？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '延长查询时间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('堆叠查询注入使用什么字符分隔SQL语句？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分号', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('布尔盲注通过什么判断条件真假？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '页面返回内容', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('XSS的全称是？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Cross-Site Scripting', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个HTTP头可以防护XSS？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Content-Security-Policy', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HttpOnly Cookie的作用是？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '防止JavaScript访问', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DOM型XSS的特点是？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '完全在客户端执行', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSRF的全称是？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Cross-Site Request Forgery', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是CSRF的防护措施？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '使用HTTPS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSRF攻击利用的前提是？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '用户已登录', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Anti-CSRF Token的工作原理是？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '验证表单和Session中Token一致性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SSRF是指？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '服务器端请求伪造', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SSRF的主要危害包括？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '访问内网数据、扫描端口、攻击内部服务', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是安全的密码存储方式？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'MD5', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是安全的密码存储方式？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'BCrypt', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数字信封的组成是？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '对称加密数据+接收方公钥加密密钥', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('同源策略的三要素是？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '协议、域名、端口', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个HTTP头用于防止点击劫持？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'X-Frame-Options', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('文件上传漏洞的主要危害是？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '上传恶意脚本执行命令', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是安全的文件上传处理方式？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '直接保存原文件名', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MIME类型验证可以被什么绕过？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '修改Content-Type头和使用00截断', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('命令注入（Command Injection）是指？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '用户数据被当作系统命令执行', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('水平越权是指？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '同权限用户访问他人资源', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('垂直越权是指？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '低权限用户获得高权限操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('敏感信息泄露的途径包括？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '错误信息、代码仓库、日志文件', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('信息收集阶段可以获取哪些信息？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DNS记录、员工社交媒体、错误页面', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('防止SQL注入的参数化查询原理是？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'SQL结构和数据分离', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL注入中，\' OR \'1\'=\'1 的作用是？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '使条件永远为真', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('UNION注入要求两个SELECT的什么相同？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '列数', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ORDER BY注入通过什么确定列数？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '递增数字直到报错', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个函数常用于错误型注入？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'UPDATEXML()', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个函数常用于时间盲注？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'SLEEP()', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('BENCHMARK()函数的作用是？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '重复执行表达式消耗时间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是布尔盲注的特征？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '页面正常或异常两种状态', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('堆叠查询可以执行什么类型的SQL？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DDL、DML、DCL', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('参数化查询的PreparedStatement如何工作？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '预编译SQL结构后绑定参数', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('在Java中，哪个类用于参数化查询？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'PreparedStatement', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MyBatis中${}为什么不安全？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '直接字符串替换', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('使用参数化查询后还需要输入验证吗？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '需要业务层面校验', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ORM框架能完全防止SQL注入吗？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '使用原生SQL时仍有风险', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('输入验证中白名单和黑名单哪个更安全？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '白名单', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('仅仅过滤SQL关键字能防御注入吗？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不能，攻击者可使用编码绕过', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据库最小权限原则的作用是？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '限制攻击成功后的损害范围', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Web应用防火墙（WAF）的作用是？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '检测和阻止Web攻击', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('安全错误处理的原则是？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '对用户隐藏错误详情记录到日志', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('生产环境应该关闭什么以防止信息泄露？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '详细错误信息', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSP的default-src指令作用是？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '设置默认资源来源', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('X-XSS-Protection头的作用是？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '启用浏览器XSS过滤器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Referer头可以完全防止CSRF吗？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不能，Referer可被篡改或丢失', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Samesite Cookie可以防止什么攻击？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'CSRF', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CORS的origin头作用是？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '跨域请求授权', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('JSONP为什么存在安全风险？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '缺乏origin验证', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WebSocket的同源策略是怎样的？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '没有同源限制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('JSON劫持攻击的目标是？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '获取敏感JSON数据', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CORS的Access-Control-Allow-Origin能设为*吗？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不能含credentials时', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('预检请求使用什么HTTP方法？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'OPTIONS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是CSP的script-src指令作用？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '限制JavaScript来源', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('X-Content-Type-Options头的作用是？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '禁止MIME sniffing', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HSTS头的作用是？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '强制使用HTTPS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HPKP头的作用是？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '公钥固定防止中间人', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是安全的会话管理措施？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '在URL中传递SessionID', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Session fixation攻击是什么？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '预先设置SessionID然后劫持', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSRF Token应该存放在哪里？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Session和表单中都存', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是点击劫持的特征？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '透明iframe覆盖诱骗点击', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('UI redress攻击又称为？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '点击劫持', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('XSS Worm是什么？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '自我复制传播的XSS攻击', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('存储型XSS的注入点包括？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '评论区、用户资料、文章发布', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('反射型XSS的典型攻击向量是？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'URL参数', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DOM型XSS的注入点是什么？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'JavaScript代码', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('htmlspecialchars()函数能防护什么？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'XSS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是HTML编码的字符？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '<>&\"\'', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Unicode编码可用于绕过什么检测？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'WAF', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Null byte截断可用于绕过什么？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '文件类型检查', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('双URL编码可用于绕过什么？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '输入过滤', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('大小写混合可用于绕过什么？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '简单过滤', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL注入中注释符的作用是？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '绕过后续条件验证', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('16进制编码可用于绕过什么检测？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '字符串过滤', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('宽字节注入利用什么原理？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '编码转换', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的Secure属性作用是？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '仅在HTTPS发送', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的HttpOnly属性作用是？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '禁止JavaScript访问', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Session和Cookie的主要区别是？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '存储位置不同', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的SAVE命令用于？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '同步保存到磁盘', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的BGSAVE命令用于？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '异步保存到磁盘', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的AOF持久化方式是？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '追加命令到日志', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的RDB持久化方式是？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '定时快照', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的MULTI命令用于？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '开启事务', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的WATCH命令用于？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '监控键变化', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的SUBSCRIBE命令用于？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '订阅频道', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的PUBLISH命令用于？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '发布消息', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的EXPIRE命令用于？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '设置过期时间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的TTL命令用于？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '获取剩余生存时间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的KEYS命令用于？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '模式匹配查找键', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的SCAN命令用于？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '增量迭代键', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的INFO命令用于？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '获取服务器信息', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL注入属于什么类型的攻击？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '代码注入', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是防御SQL注入的最佳方式？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '参数化查询', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MyBatis中哪个符号可以防止SQL注入？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '#{}', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('联合查询注入利用SQL的哪个关键字？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'UNION', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('错误型SQL注入利用什么获取信息？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数据库错误信息', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('时间盲注中SLEEP()函数的作用是？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '延长查询时间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('堆叠查询注入使用什么字符分隔SQL语句？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分号', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('布尔盲注通过什么判断条件真假？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '页面返回内容', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('XSS的全称是？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Cross-Site Scripting', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个HTTP头可以防护XSS？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Content-Security-Policy', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HttpOnly Cookie的作用是？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '防止JavaScript访问', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DOM型XSS的特点是？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '完全在客户端执行', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSRF的全称是？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Cross-Site Request Forgery', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是CSRF的防护措施？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '使用HTTPS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSRF攻击利用的前提是？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '用户已登录', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Anti-CSRF Token的工作原理是？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '验证表单和Session中Token一致性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SSRF是指？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '服务器端请求伪造', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SSRF的主要危害包括？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '访问内网数据、扫描端口、攻击内部服务', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是安全的密码存储方式？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'MD5', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是安全的密码存储方式？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'BCrypt', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数字信封的组成是？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '对称加密数据+接收方公钥加密密钥', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('同源策略的三要素是？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '协议、域名、端口', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个HTTP头用于防止点击劫持？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'X-Frame-Options', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('文件上传漏洞的主要危害是？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '上传恶意脚本执行命令', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是安全的文件上传处理方式？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '直接保存原文件名', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MIME类型验证可以被什么绕过？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '修改Content-Type头和使用00截断', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('命令注入（Command Injection）是指？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '用户数据被当作系统命令执行', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('水平越权是指？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '同权限用户访问他人资源', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('垂直越权是指？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '低权限用户获得高权限操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('敏感信息泄露的途径包括？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '错误信息、代码仓库、日志文件', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('信息收集阶段可以获取哪些信息？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DNS记录、员工社交媒体、错误页面', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('防止SQL注入的参数化查询原理是？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'SQL结构和数据分离', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL注入中，\' OR \'1\'=\'1 的作用是？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '使条件永远为真', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('UNION注入要求两个SELECT的什么相同？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '列数', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ORDER BY注入通过什么确定列数？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '递增数字直到报错', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个函数常用于错误型注入？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'UPDATEXML()', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个函数常用于时间盲注？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'SLEEP()', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('BENCHMARK()函数的作用是？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '重复执行表达式消耗时间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是布尔盲注的特征？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '页面正常或异常两种状态', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('堆叠查询可以执行什么类型的SQL？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DDL、DML、DCL', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('参数化查询的PreparedStatement如何工作？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '预编译SQL结构后绑定参数', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('在Java中，哪个类用于参数化查询？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'PreparedStatement', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MyBatis中${}为什么不安全？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '直接字符串替换', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('使用参数化查询后还需要输入验证吗？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '需要业务层面校验', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ORM框架能完全防止SQL注入吗？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '使用原生SQL时仍有风险', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('输入验证中白名单和黑名单哪个更安全？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '白名单', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('仅仅过滤SQL关键字能防御注入吗？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不能，攻击者可使用编码绕过', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据库最小权限原则的作用是？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '限制攻击成功后的损害范围', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Web应用防火墙（WAF）的作用是？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '检测和阻止Web攻击', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('安全错误处理的原则是？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '对用户隐藏错误详情记录到日志', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('生产环境应该关闭什么以防止信息泄露？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '详细错误信息', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSP的default-src指令作用是？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '设置默认资源来源', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('X-XSS-Protection头的作用是？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '启用浏览器XSS过滤器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Referer头可以完全防止CSRF吗？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不能，Referer可被篡改或丢失', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Samesite Cookie可以防止什么攻击？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'CSRF', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CORS的origin头作用是？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '跨域请求授权', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('JSONP为什么存在安全风险？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '缺乏origin验证', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WebSocket的同源策略是怎样的？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '没有同源限制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('JSON劫持攻击的目标是？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '获取敏感JSON数据', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CORS的Access-Control-Allow-Origin能设为*吗？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不能含credentials时', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('预检请求使用什么HTTP方法？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'OPTIONS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是CSP的script-src指令作用？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '限制JavaScript来源', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('X-Content-Type-Options头的作用是？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '禁止MIME sniffing', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HSTS头的作用是？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '强制使用HTTPS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HPKP头的作用是？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '公钥固定防止中间人', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是安全的会话管理措施？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '在URL中传递SessionID', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Session fixation攻击是什么？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '预先设置SessionID然后劫持', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSRF Token应该存放在哪里？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Session和表单中都存', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是点击劫持的特征？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '透明iframe覆盖诱骗点击', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('UI redress攻击又称为？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '点击劫持', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('XSS Worm是什么？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '自我复制传播的XSS攻击', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('存储型XSS的注入点包括？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '评论区、用户资料、文章发布', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('反射型XSS的典型攻击向量是？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'URL参数', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DOM型XSS的注入点是什么？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'JavaScript代码', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('htmlspecialchars()函数能防护什么？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'XSS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是HTML编码的字符？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '<>&\"\'', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Unicode编码可用于绕过什么检测？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'WAF', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Null byte截断可用于绕过什么？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '文件类型检查', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('双URL编码可用于绕过什么？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '输入过滤', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('大小写混合可用于绕过什么？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '简单过滤', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL注入中注释符的作用是？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '绕过后续条件验证', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('16进制编码可用于绕过什么检测？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '字符串过滤', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('宽字节注入利用什么原理？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '编码转换', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的Secure属性作用是？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '仅在HTTPS发送', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的HttpOnly属性作用是？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '禁止JavaScript访问', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Session和Cookie的主要区别是？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '存储位置不同', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的SAVE命令用于？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '同步保存到磁盘', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的BGSAVE命令用于？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '异步保存到磁盘', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的AOF持久化方式是？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '追加命令到日志', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的RDB持久化方式是？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '定时快照', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的MULTI命令用于？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '开启事务', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的WATCH命令用于？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '监控键变化', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的SUBSCRIBE命令用于？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '订阅频道', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的PUBLISH命令用于？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '发布消息', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的EXPIRE命令用于？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '设置过期时间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的TTL命令用于？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '获取剩余生存时间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的KEYS命令用于？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '模式匹配查找键', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的SCAN命令用于？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '增量迭代键', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的INFO命令用于？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '获取服务器信息', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL中，InnoDB和MyISAM的主要区别是？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '事务支持、外键支持、锁粒度', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是索引的作用？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '加快查询、节省存储、保证唯一', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('事务的ACID中，D代表什么？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '持久性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个SQL语句用于授权？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'GRANT', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的ZSet适用于什么场景？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '排行榜', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的GROUP BY用于？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分组聚合计算', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个隔离级别可以防止脏读？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'READ COMMITTED', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据库连接池的作用是？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '减少连接创建开销、提高并发、管理生命周期', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是SQL的聚合函数？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'CONCAT', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的JOIN类型中，LEFT JOIN返回？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '左表全部记录', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是主键和唯一索引的区别？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '主键不允许NULL', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是复合索引的遵循原则？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最左前缀', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是数据库规范化的目的？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '消除冗余和数据依赖', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('第一范式（1NF）要求？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '属性不可再分', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('第二范式（2NF）要求？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '消除部分依赖', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('第三范式（3NF）要求？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '消除传递依赖', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('BC范式（BCNF）要求？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '消除主属性对候选键的依赖', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是反规范化的目的？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '提高查询性能', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('物化视图的作用是？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '预计算并存储查询结果', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('分区表的目的是？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '提高查询和管理效率', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL的存储引擎包括？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'InnoDB、MyISAM、MEMORY、CSV', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('InnoDB的行级锁基于？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '索引', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MyISAM的锁级别是？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '表级锁', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是乐观锁的实现方式？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '版本号', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是悲观锁的实现方式？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '排他锁', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('死锁的必要条件包括？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '互斥、占有并等待、不可抢占、循环等待', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是预防死锁的方法？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '统一加锁顺序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是解决死锁的方法？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '回滚并重试', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('索引覆盖是指？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '查询只需访问索引无需回表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('最左前缀匹配是指？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '从索引最左开始匹配', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('索引下推是指？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '将过滤条件下推存储引擎层', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MRR是指？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Multi-Range Read优化', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('BKA是指？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Batch Key Access优化', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('EXPLAIN的type列显示什么？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '访问类型', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('EXPLAIN的Extra列显示什么？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '额外信息', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('慢查询日志的作用是？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '记录执行时间长的SQL', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('profile命令用于？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分析SQL执行各个阶段耗时', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Optimizer Trace用于？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '查看优化器决策过程', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是SQL优化方向？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '增加表数量', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('分库分表的目的？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '解决单表数据量过大和并发压力', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('读写分离的目的是？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '提高并发和降低主库压力', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据同步方式包括？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '基于日志和基于触发器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ShardingSphere的功能？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数据分片', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是MyCat的作用？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数据库中间件', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TiDB的特点是？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分布式NewSQL', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的数据类型包括？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'String、List、Set、ZSet、Hash', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的String最大容量是？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '512MB', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Hash适用场景是？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '存储对象', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Set适用场景是？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '去重和集合操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的List适用场景是？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '消息队列和栈', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的ZSet适用场景是？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '排行榜和有序集合', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的HyperLogLog用于？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '基数统计', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Geo用于？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '地理位置', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Pipeline用于？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '批量执行命令', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Transaction支持？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'MULTI和EXEC', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Pub/Sub用于？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '发布订阅', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Lua脚本作用是？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '原子执行多个命令', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL中，InnoDB和MyISAM的主要区别是？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '事务支持、外键支持、锁粒度', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是索引的作用？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '加快查询、节省存储、保证唯一', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('事务的ACID中，D代表什么？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '持久性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个SQL语句用于授权？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'GRANT', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的ZSet适用于什么场景？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '排行榜', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的GROUP BY用于？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分组聚合计算', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个隔离级别可以防止脏读？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'READ COMMITTED', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据库连接池的作用是？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '减少连接创建开销、提高并发、管理生命周期', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是SQL的聚合函数？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'CONCAT', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的JOIN类型中，LEFT JOIN返回？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '左表全部记录', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是主键和唯一索引的区别？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '主键不允许NULL', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是复合索引的遵循原则？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最左前缀', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是数据库规范化的目的？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '消除冗余和数据依赖', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('第一范式（1NF）要求？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '属性不可再分', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('第二范式（2NF）要求？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '消除部分依赖', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('第三范式（3NF）要求？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '消除传递依赖', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('BC范式（BCNF）要求？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '消除主属性对候选键的依赖', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是反规范化的目的？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '提高查询性能', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('物化视图的作用是？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '预计算并存储查询结果', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('分区表的目的是？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '提高查询和管理效率', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL的存储引擎包括？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'InnoDB、MyISAM、MEMORY、CSV', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('InnoDB的行级锁基于？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '索引', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MyISAM的锁级别是？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '表级锁', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是乐观锁的实现方式？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '版本号', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是悲观锁的实现方式？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '排他锁', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('死锁的必要条件包括？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '互斥、占有并等待、不可抢占、循环等待', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是预防死锁的方法？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '统一加锁顺序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是解决死锁的方法？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '回滚并重试', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('索引覆盖是指？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '查询只需访问索引无需回表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('最左前缀匹配是指？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '从索引最左开始匹配', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('索引下推是指？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '将过滤条件下推存储引擎层', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MRR是指？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Multi-Range Read优化', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('BKA是指？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Batch Key Access优化', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('EXPLAIN的type列显示什么？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '访问类型', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('EXPLAIN的Extra列显示什么？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '额外信息', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('慢查询日志的作用是？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '记录执行时间长的SQL', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('profile命令用于？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分析SQL执行各个阶段耗时', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Optimizer Trace用于？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '查看优化器决策过程', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是SQL优化方向？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '增加表数量', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('分库分表的目的？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '解决单表数据量过大和并发压力', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('读写分离的目的是？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '提高并发和降低主库压力', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据同步方式包括？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '基于日志和基于触发器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ShardingSphere的功能？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数据分片', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是MyCat的作用？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数据库中间件', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TiDB的特点是？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分布式NewSQL', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的数据类型包括？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'String、List、Set、ZSet、Hash', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的String最大容量是？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '512MB', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Hash适用场景是？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '存储对象', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Set适用场景是？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '去重和集合操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的List适用场景是？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '消息队列和栈', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的ZSet适用场景是？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '排行榜和有序集合', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的HyperLogLog用于？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '基数统计', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Geo用于？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '地理位置', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Pipeline用于？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '批量执行命令', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Transaction支持？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'MULTI和EXEC', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Pub/Sub用于？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '发布订阅', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Lua脚本作用是？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '原子执行多个命令', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL中，InnoDB和MyISAM的主要区别是？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '事务支持、外键支持、锁粒度', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是索引的作用？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '加快查询、节省存储、保证唯一', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('事务的ACID中，D代表什么？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '持久性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个SQL语句用于授权？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'GRANT', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的ZSet适用于什么场景？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '排行榜', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的GROUP BY用于？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分组聚合计算', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个隔离级别可以防止脏读？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'READ COMMITTED', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据库连接池的作用是？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '减少连接创建开销、提高并发、管理生命周期', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是SQL的聚合函数？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'CONCAT', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的JOIN类型中，LEFT JOIN返回？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '左表全部记录', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是主键和唯一索引的区别？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '主键不允许NULL', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是复合索引的遵循原则？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最左前缀', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是数据库规范化的目的？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '消除冗余和数据依赖', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('第一范式（1NF）要求？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '属性不可再分', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('第二范式（2NF）要求？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '消除部分依赖', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('第三范式（3NF）要求？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '消除传递依赖', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('BC范式（BCNF）要求？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '消除主属性对候选键的依赖', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是反规范化的目的？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '提高查询性能', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('物化视图的作用是？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '预计算并存储查询结果', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('分区表的目的是？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '提高查询和管理效率', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL的存储引擎包括？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'InnoDB、MyISAM、MEMORY、CSV', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('InnoDB的行级锁基于？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '索引', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MyISAM的锁级别是？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '表级锁', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是乐观锁的实现方式？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '版本号', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是悲观锁的实现方式？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '排他锁', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('死锁的必要条件包括？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '互斥、占有并等待、不可抢占、循环等待', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是预防死锁的方法？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '统一加锁顺序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是解决死锁的方法？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '回滚并重试', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('索引覆盖是指？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '查询只需访问索引无需回表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('最左前缀匹配是指？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '从索引最左开始匹配', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('索引下推是指？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '将过滤条件下推存储引擎层', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MRR是指？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Multi-Range Read优化', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('BKA是指？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Batch Key Access优化', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('EXPLAIN的type列显示什么？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '访问类型', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('EXPLAIN的Extra列显示什么？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '额外信息', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('慢查询日志的作用是？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '记录执行时间长的SQL', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('profile命令用于？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分析SQL执行各个阶段耗时', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Optimizer Trace用于？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '查看优化器决策过程', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是SQL优化方向？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '增加表数量', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('分库分表的目的？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '解决单表数据量过大和并发压力', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('读写分离的目的是？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '提高并发和降低主库压力', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据同步方式包括？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '基于日志和基于触发器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ShardingSphere的功能？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数据分片', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是MyCat的作用？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数据库中间件', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TiDB的特点是？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分布式NewSQL', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的数据类型包括？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'String、List、Set、ZSet、Hash', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的String最大容量是？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '512MB', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Hash适用场景是？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '存储对象', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Set适用场景是？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '去重和集合操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的List适用场景是？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '消息队列和栈', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的ZSet适用场景是？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '排行榜和有序集合', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的HyperLogLog用于？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '基数统计', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Geo用于？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '地理位置', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Pipeline用于？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '批量执行命令', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Transaction支持？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'MULTI和EXEC', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Pub/Sub用于？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '发布订阅', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Lua脚本作用是？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '原子执行多个命令', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL中，InnoDB和MyISAM的主要区别是？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '事务支持、外键支持、锁粒度', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是索引的作用？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '加快查询、节省存储、保证唯一', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('事务的ACID中，D代表什么？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '持久性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个SQL语句用于授权？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'GRANT', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的ZSet适用于什么场景？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '排行榜', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的GROUP BY用于？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分组聚合计算', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个隔离级别可以防止脏读？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'READ COMMITTED', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据库连接池的作用是？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '减少连接创建开销、提高并发、管理生命周期', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是SQL的聚合函数？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'CONCAT', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的JOIN类型中，LEFT JOIN返回？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '左表全部记录', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是主键和唯一索引的区别？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '主键不允许NULL', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是复合索引的遵循原则？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最左前缀', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是数据库规范化的目的？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '消除冗余和数据依赖', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('第一范式（1NF）要求？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '属性不可再分', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('第二范式（2NF）要求？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '消除部分依赖', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('第三范式（3NF）要求？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '消除传递依赖', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('BC范式（BCNF）要求？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '消除主属性对候选键的依赖', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是反规范化的目的？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '提高查询性能', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('物化视图的作用是？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '预计算并存储查询结果', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('分区表的目的是？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '提高查询和管理效率', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL的存储引擎包括？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'InnoDB、MyISAM、MEMORY、CSV', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('InnoDB的行级锁基于？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '索引', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MyISAM的锁级别是？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '表级锁', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是乐观锁的实现方式？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '版本号', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是悲观锁的实现方式？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '排他锁', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('死锁的必要条件包括？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '互斥、占有并等待、不可抢占、循环等待', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是预防死锁的方法？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '统一加锁顺序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是解决死锁的方法？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '回滚并重试', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('索引覆盖是指？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '查询只需访问索引无需回表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('最左前缀匹配是指？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '从索引最左开始匹配', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('索引下推是指？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '将过滤条件下推存储引擎层', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MRR是指？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Multi-Range Read优化', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('BKA是指？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Batch Key Access优化', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('EXPLAIN的type列显示什么？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '访问类型', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('EXPLAIN的Extra列显示什么？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '额外信息', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('慢查询日志的作用是？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '记录执行时间长的SQL', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('profile命令用于？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分析SQL执行各个阶段耗时', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Optimizer Trace用于？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '查看优化器决策过程', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是SQL优化方向？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '增加表数量', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('分库分表的目的？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '解决单表数据量过大和并发压力', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('读写分离的目的是？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '提高并发和降低主库压力', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据同步方式包括？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '基于日志和基于触发器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ShardingSphere的功能？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数据分片', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是MyCat的作用？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数据库中间件', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TiDB的特点是？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分布式NewSQL', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的数据类型包括？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'String、List、Set、ZSet、Hash', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的String最大容量是？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '512MB', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Hash适用场景是？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '存储对象', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Set适用场景是？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '去重和集合操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的List适用场景是？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '消息队列和栈', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的ZSet适用场景是？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '排行榜和有序集合', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的HyperLogLog用于？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '基数统计', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Geo用于？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '地理位置', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Pipeline用于？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '批量执行命令', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Transaction支持？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'MULTI和EXEC', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Pub/Sub用于？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '发布订阅', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Lua脚本作用是？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '原子执行多个命令', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL中，InnoDB和MyISAM的主要区别是？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '事务支持、外键支持、锁粒度', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是索引的作用？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '加快查询、节省存储、保证唯一', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('事务的ACID中，D代表什么？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '持久性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个SQL语句用于授权？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'GRANT', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的ZSet适用于什么场景？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '排行榜', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的GROUP BY用于？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分组聚合计算', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个隔离级别可以防止脏读？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'READ COMMITTED', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据库连接池的作用是？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '减少连接创建开销、提高并发、管理生命周期', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是SQL的聚合函数？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'CONCAT', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的JOIN类型中，LEFT JOIN返回？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '左表全部记录', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是主键和唯一索引的区别？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '主键不允许NULL', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是复合索引的遵循原则？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最左前缀', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是数据库规范化的目的？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '消除冗余和数据依赖', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('第一范式（1NF）要求？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '属性不可再分', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('第二范式（2NF）要求？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '消除部分依赖', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('第三范式（3NF）要求？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '消除传递依赖', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('BC范式（BCNF）要求？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '消除主属性对候选键的依赖', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是反规范化的目的？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '提高查询性能', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('物化视图的作用是？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '预计算并存储查询结果', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('分区表的目的是？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '提高查询和管理效率', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL的存储引擎包括？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'InnoDB、MyISAM、MEMORY、CSV', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('InnoDB的行级锁基于？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '索引', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MyISAM的锁级别是？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '表级锁', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是乐观锁的实现方式？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '版本号', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是悲观锁的实现方式？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '排他锁', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('死锁的必要条件包括？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '互斥、占有并等待、不可抢占、循环等待', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是预防死锁的方法？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '统一加锁顺序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是解决死锁的方法？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '回滚并重试', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('索引覆盖是指？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '查询只需访问索引无需回表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('最左前缀匹配是指？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '从索引最左开始匹配', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('索引下推是指？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '将过滤条件下推存储引擎层', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MRR是指？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Multi-Range Read优化', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('BKA是指？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Batch Key Access优化', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('EXPLAIN的type列显示什么？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '访问类型', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('EXPLAIN的Extra列显示什么？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '额外信息', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('慢查询日志的作用是？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '记录执行时间长的SQL', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('profile命令用于？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分析SQL执行各个阶段耗时', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Optimizer Trace用于？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '查看优化器决策过程', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是SQL优化方向？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '增加表数量', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('分库分表的目的？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '解决单表数据量过大和并发压力', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('读写分离的目的是？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '提高并发和降低主库压力', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据同步方式包括？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '基于日志和基于触发器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ShardingSphere的功能？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数据分片', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是MyCat的作用？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数据库中间件', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TiDB的特点是？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分布式NewSQL', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的数据类型包括？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'String、List、Set、ZSet、Hash', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的String最大容量是？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '512MB', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Hash适用场景是？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '存储对象', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Set适用场景是？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '去重和集合操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的List适用场景是？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '消息队列和栈', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的ZSet适用场景是？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '排行榜和有序集合', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的HyperLogLog用于？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '基数统计', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Geo用于？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '地理位置', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Pipeline用于？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '批量执行命令', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Transaction支持？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'MULTI和EXEC', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Pub/Sub用于？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '发布订阅', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Lua脚本作用是？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '原子执行多个命令', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP三次握手的作用是？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '建立可靠连接', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP状态码404表示？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '资源未找到', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是四次挥手的FIN报文作用？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '释放连接请求', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS使用什么协议加密？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'TLS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS主要工作端口是？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '53', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP的滑动窗口用于？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '流量控制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie和Session的主要区别是？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '存储位置、安全性、大小限制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是HTTP方法？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'COPY', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP和UDP的主要区别是？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '连接vs无连接、可靠vs不可靠、有序vs无序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('在TCP/IP模型中，HTTP属于哪一层？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '应用层', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP三次握手的seq和ack是什么？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '序列号和确认号', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('四次挥手为什么TIME_WAIT要等待2MSL？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '确保对方收到断开请求', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP的慢启动算法用于？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '拥塞控制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP的快速重传基于？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '三个重复ACK', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP的快速恢复基于？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '快速重传后', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的Keep-Alive用于？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '持久连接', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的Chunked编码用于？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分块传输', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的Gzip压缩用于？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '减少传输量', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的Cache-Control用于？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '缓存控制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的ETag用于？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '资源标识', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的Last-Modified用于？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '资源最后修改时间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的If-Modified-Since用于？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '条件请求', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的If-None-Match用于？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '条件请求', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的Domain属性用于？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '指定可访问Cookie的域名', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的Path属性用于？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '指定可访问Cookie的路径', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的Expires属性用于？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '设置过期时间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Session的实现方式包括？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Cookie、URL参数、隐藏表单字段', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('跨域请求的限制是？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '浏览器同源策略', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('JSONP为什么能跨域？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'script标签不受同源限制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CORS的预检请求是？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'OPTIONS请求', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WebSocket的协议是？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'ws/wss', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP/2的特性包括？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '多路复用、服务器推送、header压缩', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP/3使用什么协议？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'QUIC', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CDN的作用是？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '加速访问、减轻源站压力', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的A记录用于？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '域名指向IPv4地址', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的AAAA记录用于？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '域名指向IPv6地址', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的CNAME记录用于？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '域名别名', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的MX记录用于？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '邮件服务器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的NS记录用于？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '域名服务器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的TXT记录用于？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '文本信息', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的递归查询是指？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DNS服务器代替客户端查询', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的迭代查询是指？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '返回参考让客户端继续查询', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ARP的作用是？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '将IP地址解析为MAC地址', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('RARP的作用是？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '将MAC地址解析为IP地址', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ICMP的Echo请求用于？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'ping命令', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ICMP的Destination Unreachable用于？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '报告目标不可达', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('路由选择协议中，RIP基于？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '距离向量', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('路由选择协议中，OSPF基于？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '链路状态', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('BGP的作用是？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '自治系统间路由', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('NAT的作用是？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '地址转换', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DHCP的端口是？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '67/68', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DHCP的功能是？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '动态分配IP地址', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('FTP的数据连接端口是？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '20', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('FTP的控制连接端口是？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '21', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Telnet的端口是？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '23', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SSH的端口是？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '22', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SMTP的端口是？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '25', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('POP3的端口是？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '110', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('IMAP的端口是？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '143', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('LDAP的端口是？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '389', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Kafka的端口是？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '9092', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Zookeeper的端口是？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '2181', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MongoDB的端口是？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '27017', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的端口是？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '6379', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL的端口是？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '3306', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('PostgreSQL的端口是？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '5432', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Tomcat的默认端口是？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '8080', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Apache的默认端口是？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '80', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Nginx的默认端口是？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '80', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS的默认端口是？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '443', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP/2的默认端口是？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '443', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WebSocket的默认端口是？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '80/443', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SSH默认端口是？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '22', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('FTP默认端口是？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '21', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('邮件 submission端口是？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '587', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('IMAPS端口是？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '993', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('POP3S端口是？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '995', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP三次握手的作用是？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '建立可靠连接', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP状态码404表示？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '资源未找到', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是四次挥手的FIN报文作用？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '释放连接请求', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS使用什么协议加密？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'TLS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS主要工作端口是？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '53', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP的滑动窗口用于？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '流量控制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie和Session的主要区别是？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '存储位置、安全性、大小限制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是HTTP方法？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'COPY', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP和UDP的主要区别是？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '连接vs无连接、可靠vs不可靠、有序vs无序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('在TCP/IP模型中，HTTP属于哪一层？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '应用层', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP三次握手的seq和ack是什么？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '序列号和确认号', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('四次挥手为什么TIME_WAIT要等待2MSL？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '确保对方收到断开请求', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP的慢启动算法用于？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '拥塞控制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP的快速重传基于？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '三个重复ACK', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP的快速恢复基于？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '快速重传后', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的Keep-Alive用于？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '持久连接', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的Chunked编码用于？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分块传输', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的Gzip压缩用于？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '减少传输量', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的Cache-Control用于？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '缓存控制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的ETag用于？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '资源标识', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的Last-Modified用于？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '资源最后修改时间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的If-Modified-Since用于？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '条件请求', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的If-None-Match用于？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '条件请求', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的Domain属性用于？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '指定可访问Cookie的域名', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的Path属性用于？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '指定可访问Cookie的路径', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的Expires属性用于？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '设置过期时间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Session的实现方式包括？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Cookie、URL参数、隐藏表单字段', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('跨域请求的限制是？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '浏览器同源策略', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('JSONP为什么能跨域？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'script标签不受同源限制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CORS的预检请求是？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'OPTIONS请求', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WebSocket的协议是？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'ws/wss', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP/2的特性包括？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '多路复用、服务器推送、header压缩', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP/3使用什么协议？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'QUIC', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CDN的作用是？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '加速访问、减轻源站压力', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的A记录用于？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '域名指向IPv4地址', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的AAAA记录用于？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '域名指向IPv6地址', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的CNAME记录用于？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '域名别名', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的MX记录用于？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '邮件服务器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的NS记录用于？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '域名服务器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的TXT记录用于？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '文本信息', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的递归查询是指？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DNS服务器代替客户端查询', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的迭代查询是指？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '返回参考让客户端继续查询', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ARP的作用是？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '将IP地址解析为MAC地址', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('RARP的作用是？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '将MAC地址解析为IP地址', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ICMP的Echo请求用于？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'ping命令', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ICMP的Destination Unreachable用于？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '报告目标不可达', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('路由选择协议中，RIP基于？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '距离向量', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('路由选择协议中，OSPF基于？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '链路状态', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('BGP的作用是？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '自治系统间路由', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('NAT的作用是？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '地址转换', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DHCP的端口是？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '67/68', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DHCP的功能是？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '动态分配IP地址', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('FTP的数据连接端口是？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '20', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('FTP的控制连接端口是？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '21', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Telnet的端口是？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '23', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SSH的端口是？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '22', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SMTP的端口是？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '25', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('POP3的端口是？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '110', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('IMAP的端口是？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '143', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('LDAP的端口是？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '389', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Kafka的端口是？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '9092', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Zookeeper的端口是？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '2181', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MongoDB的端口是？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '27017', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的端口是？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '6379', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL的端口是？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '3306', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('PostgreSQL的端口是？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '5432', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Tomcat的默认端口是？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '8080', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Apache的默认端口是？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '80', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Nginx的默认端口是？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '80', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS的默认端口是？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '443', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP/2的默认端口是？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '443', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WebSocket的默认端口是？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '80/443', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SSH默认端口是？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '22', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('FTP默认端口是？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '21', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('邮件 submission端口是？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '587', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('IMAPS端口是？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '993', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('POP3S端口是？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '995', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP三次握手的作用是？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '建立可靠连接', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP状态码404表示？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '资源未找到', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是四次挥手的FIN报文作用？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '释放连接请求', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS使用什么协议加密？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'TLS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS主要工作端口是？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '53', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP的滑动窗口用于？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '流量控制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie和Session的主要区别是？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '存储位置、安全性、大小限制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是HTTP方法？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'COPY', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP和UDP的主要区别是？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '连接vs无连接、可靠vs不可靠、有序vs无序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('在TCP/IP模型中，HTTP属于哪一层？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '应用层', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP三次握手的seq和ack是什么？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '序列号和确认号', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('四次挥手为什么TIME_WAIT要等待2MSL？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '确保对方收到断开请求', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP的慢启动算法用于？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '拥塞控制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP的快速重传基于？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '三个重复ACK', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP的快速恢复基于？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '快速重传后', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的Keep-Alive用于？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '持久连接', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的Chunked编码用于？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分块传输', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的Gzip压缩用于？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '减少传输量', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的Cache-Control用于？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '缓存控制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的ETag用于？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '资源标识', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的Last-Modified用于？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '资源最后修改时间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的If-Modified-Since用于？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '条件请求', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的If-None-Match用于？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '条件请求', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的Domain属性用于？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '指定可访问Cookie的域名', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的Path属性用于？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '指定可访问Cookie的路径', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的Expires属性用于？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '设置过期时间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Session的实现方式包括？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Cookie、URL参数、隐藏表单字段', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('跨域请求的限制是？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '浏览器同源策略', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('JSONP为什么能跨域？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'script标签不受同源限制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CORS的预检请求是？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'OPTIONS请求', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WebSocket的协议是？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'ws/wss', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP/2的特性包括？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '多路复用、服务器推送、header压缩', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP/3使用什么协议？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'QUIC', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CDN的作用是？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '加速访问、减轻源站压力', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的A记录用于？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '域名指向IPv4地址', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的AAAA记录用于？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '域名指向IPv6地址', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的CNAME记录用于？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '域名别名', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的MX记录用于？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '邮件服务器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的NS记录用于？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '域名服务器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的TXT记录用于？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '文本信息', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的递归查询是指？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DNS服务器代替客户端查询', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的迭代查询是指？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '返回参考让客户端继续查询', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ARP的作用是？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '将IP地址解析为MAC地址', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('RARP的作用是？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '将MAC地址解析为IP地址', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ICMP的Echo请求用于？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'ping命令', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ICMP的Destination Unreachable用于？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '报告目标不可达', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('路由选择协议中，RIP基于？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '距离向量', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('路由选择协议中，OSPF基于？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '链路状态', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('BGP的作用是？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '自治系统间路由', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('NAT的作用是？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '地址转换', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DHCP的端口是？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '67/68', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DHCP的功能是？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '动态分配IP地址', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('FTP的数据连接端口是？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '20', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('FTP的控制连接端口是？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '21', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Telnet的端口是？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '23', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SSH的端口是？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '22', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SMTP的端口是？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '25', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('POP3的端口是？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '110', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('IMAP的端口是？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '143', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('LDAP的端口是？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '389', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Kafka的端口是？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '9092', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Zookeeper的端口是？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '2181', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MongoDB的端口是？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '27017', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的端口是？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '6379', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL的端口是？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '3306', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('PostgreSQL的端口是？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '5432', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Tomcat的默认端口是？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '8080', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Apache的默认端口是？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '80', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Nginx的默认端口是？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '80', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS的默认端口是？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '443', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP/2的默认端口是？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '443', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WebSocket的默认端口是？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '80/443', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SSH默认端口是？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '22', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('FTP默认端口是？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '21', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('邮件 submission端口是？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '587', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('IMAPS端口是？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '993', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('POP3S端口是？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '995', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP三次握手的作用是？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '建立可靠连接', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP状态码404表示？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '资源未找到', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是四次挥手的FIN报文作用？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '释放连接请求', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS使用什么协议加密？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'TLS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS主要工作端口是？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '53', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP的滑动窗口用于？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '流量控制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie和Session的主要区别是？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '存储位置、安全性、大小限制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是HTTP方法？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'COPY', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP和UDP的主要区别是？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '连接vs无连接、可靠vs不可靠、有序vs无序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('在TCP/IP模型中，HTTP属于哪一层？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '应用层', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP三次握手的seq和ack是什么？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '序列号和确认号', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('四次挥手为什么TIME_WAIT要等待2MSL？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '确保对方收到断开请求', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP的慢启动算法用于？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '拥塞控制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP的快速重传基于？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '三个重复ACK', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP的快速恢复基于？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '快速重传后', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的Keep-Alive用于？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '持久连接', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的Chunked编码用于？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分块传输', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的Gzip压缩用于？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '减少传输量', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的Cache-Control用于？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '缓存控制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的ETag用于？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '资源标识', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的Last-Modified用于？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '资源最后修改时间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的If-Modified-Since用于？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '条件请求', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的If-None-Match用于？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '条件请求', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的Domain属性用于？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '指定可访问Cookie的域名', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的Path属性用于？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '指定可访问Cookie的路径', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的Expires属性用于？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '设置过期时间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Session的实现方式包括？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Cookie、URL参数、隐藏表单字段', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('跨域请求的限制是？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '浏览器同源策略', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('JSONP为什么能跨域？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'script标签不受同源限制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CORS的预检请求是？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'OPTIONS请求', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WebSocket的协议是？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'ws/wss', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP/2的特性包括？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '多路复用、服务器推送、header压缩', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP/3使用什么协议？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'QUIC', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CDN的作用是？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '加速访问、减轻源站压力', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的A记录用于？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '域名指向IPv4地址', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的AAAA记录用于？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '域名指向IPv6地址', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的CNAME记录用于？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '域名别名', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的MX记录用于？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '邮件服务器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的NS记录用于？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '域名服务器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的TXT记录用于？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '文本信息', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的递归查询是指？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DNS服务器代替客户端查询', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的迭代查询是指？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '返回参考让客户端继续查询', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ARP的作用是？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '将IP地址解析为MAC地址', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('RARP的作用是？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '将MAC地址解析为IP地址', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ICMP的Echo请求用于？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'ping命令', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ICMP的Destination Unreachable用于？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '报告目标不可达', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('路由选择协议中，RIP基于？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '距离向量', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('路由选择协议中，OSPF基于？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '链路状态', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('BGP的作用是？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '自治系统间路由', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('NAT的作用是？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '地址转换', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DHCP的端口是？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '67/68', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DHCP的功能是？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '动态分配IP地址', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('FTP的数据连接端口是？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '20', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('FTP的控制连接端口是？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '21', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Telnet的端口是？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '23', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SSH的端口是？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '22', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SMTP的端口是？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '25', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('POP3的端口是？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '110', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('IMAP的端口是？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '143', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('LDAP的端口是？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '389', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Kafka的端口是？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '9092', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Zookeeper的端口是？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '2181', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MongoDB的端口是？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '27017', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的端口是？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '6379', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL的端口是？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '3306', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('PostgreSQL的端口是？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '5432', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Tomcat的默认端口是？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '8080', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Apache的默认端口是？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '80', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Nginx的默认端口是？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '80', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS的默认端口是？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '443', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP/2的默认端口是？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '443', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WebSocket的默认端口是？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '80/443', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SSH默认端口是？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '22', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('FTP默认端口是？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '21', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('邮件 submission端口是？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '587', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('IMAPS端口是？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '993', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('POP3S端口是？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '995', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP三次握手的作用是？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '建立可靠连接', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP状态码404表示？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '资源未找到', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是四次挥手的FIN报文作用？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '释放连接请求', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS使用什么协议加密？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'TLS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS主要工作端口是？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '53', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP的滑动窗口用于？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '流量控制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie和Session的主要区别是？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '存储位置、安全性、大小限制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是HTTP方法？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'COPY', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP和UDP的主要区别是？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '连接vs无连接、可靠vs不可靠、有序vs无序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('在TCP/IP模型中，HTTP属于哪一层？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '应用层', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP三次握手的seq和ack是什么？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '序列号和确认号', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('四次挥手为什么TIME_WAIT要等待2MSL？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '确保对方收到断开请求', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP的慢启动算法用于？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '拥塞控制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP的快速重传基于？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '三个重复ACK', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP的快速恢复基于？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '快速重传后', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的Keep-Alive用于？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '持久连接', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的Chunked编码用于？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分块传输', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的Gzip压缩用于？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '减少传输量', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的Cache-Control用于？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '缓存控制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的ETag用于？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '资源标识', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的Last-Modified用于？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '资源最后修改时间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的If-Modified-Since用于？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '条件请求', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的If-None-Match用于？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '条件请求', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的Domain属性用于？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '指定可访问Cookie的域名', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的Path属性用于？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '指定可访问Cookie的路径', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的Expires属性用于？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '设置过期时间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Session的实现方式包括？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Cookie、URL参数、隐藏表单字段', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('跨域请求的限制是？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '浏览器同源策略', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('JSONP为什么能跨域？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'script标签不受同源限制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CORS的预检请求是？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'OPTIONS请求', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WebSocket的协议是？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'ws/wss', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP/2的特性包括？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '多路复用、服务器推送、header压缩', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP/3使用什么协议？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'QUIC', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CDN的作用是？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '加速访问、减轻源站压力', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的A记录用于？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '域名指向IPv4地址', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的AAAA记录用于？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '域名指向IPv6地址', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的CNAME记录用于？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '域名别名', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的MX记录用于？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '邮件服务器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的NS记录用于？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '域名服务器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的TXT记录用于？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '文本信息', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的递归查询是指？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DNS服务器代替客户端查询', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的迭代查询是指？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '返回参考让客户端继续查询', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ARP的作用是？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '将IP地址解析为MAC地址', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('RARP的作用是？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '将MAC地址解析为IP地址', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ICMP的Echo请求用于？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'ping命令', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ICMP的Destination Unreachable用于？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '报告目标不可达', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('路由选择协议中，RIP基于？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '距离向量', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('路由选择协议中，OSPF基于？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '链路状态', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('BGP的作用是？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '自治系统间路由', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('NAT的作用是？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '地址转换', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DHCP的端口是？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '67/68', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DHCP的功能是？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '动态分配IP地址', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('FTP的数据连接端口是？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '20', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('FTP的控制连接端口是？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '21', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Telnet的端口是？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '23', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SSH的端口是？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '22', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SMTP的端口是？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '25', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('POP3的端口是？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '110', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('IMAP的端口是？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '143', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('LDAP的端口是？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '389', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Kafka的端口是？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '9092', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Zookeeper的端口是？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '2181', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MongoDB的端口是？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '27017', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的端口是？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '6379', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL的端口是？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '3306', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('PostgreSQL的端口是？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '5432', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Tomcat的默认端口是？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '8080', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Apache的默认端口是？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '80', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Nginx的默认端口是？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '80', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS的默认端口是？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '443', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP/2的默认端口是？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '443', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WebSocket的默认端口是？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '80/443', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SSH默认端口是？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '22', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('FTP默认端口是？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '21', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('邮件 submission端口是？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '587', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('IMAPS端口是？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '993', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('POP3S端口是？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '995', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数组和链表的主要区别是？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '存储方式不同性能特性不同', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二叉树中，n0和n2的关系是？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'n0=n2+1', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('快速排序的平均时间复杂度是？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'O(n log n)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个排序是稳定的？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '归并排序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二分查找的前提条件是？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数组有序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('动态规划的核心是？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最优子结构和重叠子问题', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('深度优先搜索（DFS）使用什么数据结构？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '栈', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是堆的特征？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '完全二叉树、父节点大于等于子节点', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('图的邻接矩阵和邻接表，哪个适合稀疏图？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '邻接表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是常见的负载均衡算法？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '哈希一致性但不包含IP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是链表的插入时间复杂度？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'O(1)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是数组的查询时间复杂度？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'O(1)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是二叉搜索树的查询时间复杂度？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'O(log n)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是红黑树的特征？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '自平衡', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是B树的特征？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '多路平衡搜索树', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是B+树的特征？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '只有叶子节点存储数据', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是跳表的特点？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '多层索引', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是字典树的特点？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '前缀匹配', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是并查集的应用？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '社交网络朋友圈', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是拓扑排序的应用？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '课程选修顺序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Dijkstra算法用于？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '单源最短路径', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Bellman-Ford算法用于？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '单源最短路径可处理负权边', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Floyd-Warshall算法用于？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '多源最短路径', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Prim算法用于？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最小生成树', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Kruskal算法用于？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最小生成树', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是KMP算法的核心？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '部分匹配表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Manacher算法的用途？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最长回文子串', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是LRU的特点？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最近最少使用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是LFU的特点？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最不经常使用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是布隆过滤器的特点？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '空间效率高可能有假阳性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是单调栈的应用？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '下一个更大元素', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是单调队列的应用？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '滑动窗口最大值', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是分治算法的特征？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分解、解决、合并', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是回溯算法的特征？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '尝试所有可能', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是分支限界算法的特征？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '搜索剪枝', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是贪心算法的特征？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '局部最优期望全局最优', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是递归算法的特征？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '自己调用自己', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是迭代算法的特征？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '循环直到满足条件', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是朴素算法的特点？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '简单直接但效率低', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是滚动数组的作用？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '减少空间复杂度', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是状态压缩DP的条件？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '状态数有限', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是数位DP的特点？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '按数位处理', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是树形DP的特点？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '树形结构上DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是区间DP的特点？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '区间划分DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是概率DP的特点？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '概率转移', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是指针碰撞的双指针应用？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '两数之和', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是快慢指针的应用？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '链表环检测', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是滑动窗口的应用？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最大子序和', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是前缀和的应用？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '区间和查询', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是差分数组的应用？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '区间增减', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是哈希表解决冲突的方法？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '链地址法和开放地址法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是一致性哈希的特点？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '虚拟节点', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是分布式ID的特点？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '唯一性和趋势递增', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Top K问题的解法？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '堆或快速选择', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是岛屿问题的解法？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DFS或BFS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是括号问题的解法？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '栈', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是括号生成问题的解法？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '回溯', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是全排列问题的解法？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '回溯', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是组合总和问题的解法？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '回溯+剪枝', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是子集问题的解法？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '回溯', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是子序列问题的解法？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是公共子序列问题的解法？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是最长递增子序列的解法？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP或二分', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是最长公共子串的解法？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是最长回文子串的解法？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Manacher或DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是编辑距离的解法？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是股票问题的解法？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP或贪心', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是打家劫舍问题的解法？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是跳台阶问题的解法？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是变态跳台阶问题的解法？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数学公式', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是斐波那契问题的解法？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP或矩阵快速幂', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是矩形覆盖问题的解法？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是丑数问题的解法？', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '三指针', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是质数问题的解法？', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '埃氏筛法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是公约数问题的解法？', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '辗转相除法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是完全平方数问题的解法？', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'BFS或DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数组和链表的主要区别是？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '存储方式不同性能特性不同', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二叉树中，n0和n2的关系是？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'n0=n2+1', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('快速排序的平均时间复杂度是？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'O(n log n)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个排序是稳定的？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '归并排序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二分查找的前提条件是？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数组有序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('动态规划的核心是？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最优子结构和重叠子问题', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('深度优先搜索（DFS）使用什么数据结构？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '栈', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是堆的特征？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '完全二叉树、父节点大于等于子节点', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('图的邻接矩阵和邻接表，哪个适合稀疏图？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '邻接表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是常见的负载均衡算法？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '哈希一致性但不包含IP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是链表的插入时间复杂度？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'O(1)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是数组的查询时间复杂度？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'O(1)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是二叉搜索树的查询时间复杂度？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'O(log n)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是红黑树的特征？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '自平衡', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是B树的特征？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '多路平衡搜索树', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是B+树的特征？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '只有叶子节点存储数据', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是跳表的特点？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '多层索引', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是字典树的特点？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '前缀匹配', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是并查集的应用？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '社交网络朋友圈', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是拓扑排序的应用？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '课程选修顺序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Dijkstra算法用于？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '单源最短路径', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Bellman-Ford算法用于？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '单源最短路径可处理负权边', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Floyd-Warshall算法用于？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '多源最短路径', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Prim算法用于？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最小生成树', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Kruskal算法用于？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最小生成树', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是KMP算法的核心？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '部分匹配表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Manacher算法的用途？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最长回文子串', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是LRU的特点？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最近最少使用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是LFU的特点？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最不经常使用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是布隆过滤器的特点？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '空间效率高可能有假阳性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是单调栈的应用？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '下一个更大元素', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是单调队列的应用？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '滑动窗口最大值', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是分治算法的特征？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分解、解决、合并', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是回溯算法的特征？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '尝试所有可能', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是分支限界算法的特征？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '搜索剪枝', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是贪心算法的特征？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '局部最优期望全局最优', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是递归算法的特征？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '自己调用自己', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是迭代算法的特征？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '循环直到满足条件', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是朴素算法的特点？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '简单直接但效率低', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是滚动数组的作用？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '减少空间复杂度', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是状态压缩DP的条件？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '状态数有限', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是数位DP的特点？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '按数位处理', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是树形DP的特点？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '树形结构上DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是区间DP的特点？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '区间划分DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是概率DP的特点？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '概率转移', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是指针碰撞的双指针应用？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '两数之和', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是快慢指针的应用？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '链表环检测', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是滑动窗口的应用？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最大子序和', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是前缀和的应用？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '区间和查询', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是差分数组的应用？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '区间增减', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是哈希表解决冲突的方法？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '链地址法和开放地址法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是一致性哈希的特点？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '虚拟节点', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是分布式ID的特点？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '唯一性和趋势递增', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Top K问题的解法？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '堆或快速选择', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是岛屿问题的解法？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DFS或BFS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是括号问题的解法？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '栈', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是括号生成问题的解法？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '回溯', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是全排列问题的解法？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '回溯', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是组合总和问题的解法？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '回溯+剪枝', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是子集问题的解法？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '回溯', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是子序列问题的解法？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是公共子序列问题的解法？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是最长递增子序列的解法？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP或二分', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是最长公共子串的解法？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是最长回文子串的解法？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Manacher或DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是编辑距离的解法？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是股票问题的解法？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP或贪心', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是打家劫舍问题的解法？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是跳台阶问题的解法？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是变态跳台阶问题的解法？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数学公式', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是斐波那契问题的解法？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP或矩阵快速幂', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是矩形覆盖问题的解法？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是丑数问题的解法？ (第2组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '三指针', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是质数问题的解法？ (第2组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '埃氏筛法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是公约数问题的解法？ (第2组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '辗转相除法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是完全平方数问题的解法？ (第2组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'BFS或DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数组和链表的主要区别是？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '存储方式不同性能特性不同', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二叉树中，n0和n2的关系是？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'n0=n2+1', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('快速排序的平均时间复杂度是？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'O(n log n)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个排序是稳定的？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '归并排序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二分查找的前提条件是？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数组有序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('动态规划的核心是？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最优子结构和重叠子问题', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('深度优先搜索（DFS）使用什么数据结构？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '栈', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是堆的特征？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '完全二叉树、父节点大于等于子节点', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('图的邻接矩阵和邻接表，哪个适合稀疏图？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '邻接表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是常见的负载均衡算法？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '哈希一致性但不包含IP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是链表的插入时间复杂度？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'O(1)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是数组的查询时间复杂度？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'O(1)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是二叉搜索树的查询时间复杂度？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'O(log n)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是红黑树的特征？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '自平衡', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是B树的特征？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '多路平衡搜索树', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是B+树的特征？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '只有叶子节点存储数据', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是跳表的特点？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '多层索引', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是字典树的特点？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '前缀匹配', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是并查集的应用？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '社交网络朋友圈', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是拓扑排序的应用？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '课程选修顺序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Dijkstra算法用于？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '单源最短路径', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Bellman-Ford算法用于？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '单源最短路径可处理负权边', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Floyd-Warshall算法用于？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '多源最短路径', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Prim算法用于？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最小生成树', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Kruskal算法用于？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最小生成树', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是KMP算法的核心？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '部分匹配表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Manacher算法的用途？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最长回文子串', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是LRU的特点？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最近最少使用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是LFU的特点？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最不经常使用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是布隆过滤器的特点？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '空间效率高可能有假阳性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是单调栈的应用？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '下一个更大元素', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是单调队列的应用？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '滑动窗口最大值', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是分治算法的特征？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分解、解决、合并', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是回溯算法的特征？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '尝试所有可能', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是分支限界算法的特征？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '搜索剪枝', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是贪心算法的特征？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '局部最优期望全局最优', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是递归算法的特征？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '自己调用自己', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是迭代算法的特征？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '循环直到满足条件', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是朴素算法的特点？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '简单直接但效率低', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是滚动数组的作用？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '减少空间复杂度', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是状态压缩DP的条件？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '状态数有限', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是数位DP的特点？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '按数位处理', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是树形DP的特点？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '树形结构上DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是区间DP的特点？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '区间划分DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是概率DP的特点？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '概率转移', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是指针碰撞的双指针应用？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '两数之和', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是快慢指针的应用？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '链表环检测', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是滑动窗口的应用？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最大子序和', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是前缀和的应用？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '区间和查询', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是差分数组的应用？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '区间增减', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是哈希表解决冲突的方法？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '链地址法和开放地址法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是一致性哈希的特点？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '虚拟节点', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是分布式ID的特点？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '唯一性和趋势递增', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Top K问题的解法？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '堆或快速选择', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是岛屿问题的解法？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DFS或BFS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是括号问题的解法？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '栈', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是括号生成问题的解法？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '回溯', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是全排列问题的解法？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '回溯', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是组合总和问题的解法？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '回溯+剪枝', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是子集问题的解法？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '回溯', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是子序列问题的解法？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是公共子序列问题的解法？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是最长递增子序列的解法？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP或二分', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是最长公共子串的解法？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是最长回文子串的解法？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Manacher或DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是编辑距离的解法？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是股票问题的解法？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP或贪心', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是打家劫舍问题的解法？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是跳台阶问题的解法？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是变态跳台阶问题的解法？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数学公式', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是斐波那契问题的解法？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP或矩阵快速幂', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是矩形覆盖问题的解法？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是丑数问题的解法？ (第3组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '三指针', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是质数问题的解法？ (第3组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '埃氏筛法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是公约数问题的解法？ (第3组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '辗转相除法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是完全平方数问题的解法？ (第3组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'BFS或DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数组和链表的主要区别是？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '存储方式不同性能特性不同', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二叉树中，n0和n2的关系是？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'n0=n2+1', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('快速排序的平均时间复杂度是？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'O(n log n)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个排序是稳定的？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '归并排序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二分查找的前提条件是？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数组有序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('动态规划的核心是？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最优子结构和重叠子问题', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('深度优先搜索（DFS）使用什么数据结构？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '栈', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是堆的特征？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '完全二叉树、父节点大于等于子节点', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('图的邻接矩阵和邻接表，哪个适合稀疏图？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '邻接表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是常见的负载均衡算法？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '哈希一致性但不包含IP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是链表的插入时间复杂度？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'O(1)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是数组的查询时间复杂度？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'O(1)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是二叉搜索树的查询时间复杂度？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'O(log n)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是红黑树的特征？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '自平衡', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是B树的特征？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '多路平衡搜索树', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是B+树的特征？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '只有叶子节点存储数据', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是跳表的特点？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '多层索引', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是字典树的特点？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '前缀匹配', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是并查集的应用？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '社交网络朋友圈', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是拓扑排序的应用？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '课程选修顺序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Dijkstra算法用于？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '单源最短路径', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Bellman-Ford算法用于？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '单源最短路径可处理负权边', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Floyd-Warshall算法用于？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '多源最短路径', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Prim算法用于？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最小生成树', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Kruskal算法用于？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最小生成树', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是KMP算法的核心？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '部分匹配表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Manacher算法的用途？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最长回文子串', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是LRU的特点？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最近最少使用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是LFU的特点？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最不经常使用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是布隆过滤器的特点？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '空间效率高可能有假阳性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是单调栈的应用？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '下一个更大元素', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是单调队列的应用？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '滑动窗口最大值', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是分治算法的特征？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分解、解决、合并', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是回溯算法的特征？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '尝试所有可能', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是分支限界算法的特征？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '搜索剪枝', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是贪心算法的特征？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '局部最优期望全局最优', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是递归算法的特征？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '自己调用自己', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是迭代算法的特征？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '循环直到满足条件', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是朴素算法的特点？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '简单直接但效率低', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是滚动数组的作用？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '减少空间复杂度', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是状态压缩DP的条件？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '状态数有限', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是数位DP的特点？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '按数位处理', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是树形DP的特点？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '树形结构上DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是区间DP的特点？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '区间划分DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是概率DP的特点？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '概率转移', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是指针碰撞的双指针应用？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '两数之和', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是快慢指针的应用？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '链表环检测', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是滑动窗口的应用？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最大子序和', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是前缀和的应用？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '区间和查询', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是差分数组的应用？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '区间增减', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是哈希表解决冲突的方法？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '链地址法和开放地址法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是一致性哈希的特点？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '虚拟节点', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是分布式ID的特点？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '唯一性和趋势递增', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Top K问题的解法？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '堆或快速选择', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是岛屿问题的解法？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DFS或BFS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是括号问题的解法？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '栈', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是括号生成问题的解法？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '回溯', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是全排列问题的解法？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '回溯', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是组合总和问题的解法？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '回溯+剪枝', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是子集问题的解法？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '回溯', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是子序列问题的解法？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是公共子序列问题的解法？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是最长递增子序列的解法？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP或二分', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是最长公共子串的解法？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是最长回文子串的解法？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Manacher或DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是编辑距离的解法？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是股票问题的解法？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP或贪心', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是打家劫舍问题的解法？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是跳台阶问题的解法？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是变态跳台阶问题的解法？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数学公式', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是斐波那契问题的解法？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP或矩阵快速幂', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是矩形覆盖问题的解法？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是丑数问题的解法？ (第4组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '三指针', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是质数问题的解法？ (第4组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '埃氏筛法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是公约数问题的解法？ (第4组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '辗转相除法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是完全平方数问题的解法？ (第4组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'BFS或DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数组和链表的主要区别是？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '存储方式不同性能特性不同', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二叉树中，n0和n2的关系是？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'n0=n2+1', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('快速排序的平均时间复杂度是？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'O(n log n)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个排序是稳定的？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '归并排序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二分查找的前提条件是？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数组有序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('动态规划的核心是？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最优子结构和重叠子问题', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('深度优先搜索（DFS）使用什么数据结构？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '栈', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是堆的特征？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '完全二叉树、父节点大于等于子节点', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('图的邻接矩阵和邻接表，哪个适合稀疏图？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '邻接表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是常见的负载均衡算法？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '哈希一致性但不包含IP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是链表的插入时间复杂度？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'O(1)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是数组的查询时间复杂度？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'O(1)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是二叉搜索树的查询时间复杂度？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'O(log n)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是红黑树的特征？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '自平衡', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是B树的特征？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '多路平衡搜索树', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是B+树的特征？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '只有叶子节点存储数据', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是跳表的特点？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '多层索引', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是字典树的特点？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '前缀匹配', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是并查集的应用？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '社交网络朋友圈', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是拓扑排序的应用？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '课程选修顺序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Dijkstra算法用于？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '单源最短路径', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Bellman-Ford算法用于？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '单源最短路径可处理负权边', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Floyd-Warshall算法用于？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '多源最短路径', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Prim算法用于？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最小生成树', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Kruskal算法用于？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最小生成树', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是KMP算法的核心？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '部分匹配表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Manacher算法的用途？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最长回文子串', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是LRU的特点？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最近最少使用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是LFU的特点？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最不经常使用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是布隆过滤器的特点？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '空间效率高可能有假阳性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是单调栈的应用？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '下一个更大元素', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是单调队列的应用？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '滑动窗口最大值', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是分治算法的特征？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分解、解决、合并', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是回溯算法的特征？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '尝试所有可能', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是分支限界算法的特征？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '搜索剪枝', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是贪心算法的特征？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '局部最优期望全局最优', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是递归算法的特征？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '自己调用自己', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是迭代算法的特征？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '循环直到满足条件', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是朴素算法的特点？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '简单直接但效率低', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是滚动数组的作用？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '减少空间复杂度', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是状态压缩DP的条件？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '状态数有限', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是数位DP的特点？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '按数位处理', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是树形DP的特点？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '树形结构上DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是区间DP的特点？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '区间划分DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是概率DP的特点？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '概率转移', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是指针碰撞的双指针应用？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '两数之和', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是快慢指针的应用？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '链表环检测', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是滑动窗口的应用？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最大子序和', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是前缀和的应用？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '区间和查询', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是差分数组的应用？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '区间增减', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是哈希表解决冲突的方法？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '链地址法和开放地址法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是一致性哈希的特点？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '虚拟节点', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是分布式ID的特点？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '唯一性和趋势递增', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Top K问题的解法？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '堆或快速选择', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是岛屿问题的解法？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DFS或BFS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是括号问题的解法？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '栈', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是括号生成问题的解法？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '回溯', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是全排列问题的解法？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '回溯', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是组合总和问题的解法？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '回溯+剪枝', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是子集问题的解法？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '回溯', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是子序列问题的解法？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是公共子序列问题的解法？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是最长递增子序列的解法？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP或二分', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是最长公共子串的解法？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是最长回文子串的解法？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Manacher或DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是编辑距离的解法？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是股票问题的解法？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP或贪心', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是打家劫舍问题的解法？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是跳台阶问题的解法？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是变态跳台阶问题的解法？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数学公式', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是斐波那契问题的解法？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP或矩阵快速幂', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是矩形覆盖问题的解法？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是丑数问题的解法？ (第5组)', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '三指针', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是质数问题的解法？ (第5组)', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '埃氏筛法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是公约数问题的解法？ (第5组)', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '辗转相除法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是完全平方数问题的解法？ (第5组)', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'BFS或DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，八种基本数据类型包括：byte、short、int、long、float、double、char和____。', 'boolean', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，八种基本数据类型包括：byte、short、int、long、float、double、char和____。 (第2组)', 'boolean', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，八种基本数据类型包括：byte、short、int、long、float、double、char和____。 (第3组)', 'boolean', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，八种基本数据类型包括：byte、short、int、long、float、double、char和____。 (第4组)', 'boolean', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，八种基本数据类型包括：byte、short、int、long、float、double、char和____。 (第5组)', 'boolean', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，八种基本数据类型包括：byte、short、int、long、float、double、char和____。 (第6组)', 'boolean', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，八种基本数据类型包括：byte、short、int、long、float、double、char和____。 (第7组)', 'boolean', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，八种基本数据类型包括：byte、short、int、long、float、double、char和____。 (第8组)', 'boolean', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，八种基本数据类型包括：byte、short、int、long、float、double、char和____。 (第9组)', 'boolean', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，八种基本数据类型包括：byte、short、int、long、float、double、char和____。 (第10组)', 'boolean', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，String类的length()方法返回的是____类型。', 'int', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，String类的length()方法返回的是____类型。 (第2组)', 'int', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，String类的length()方法返回的是____类型。 (第3组)', 'int', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，String类的length()方法返回的是____类型。 (第4组)', 'int', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，String类的length()方法返回的是____类型。 (第5组)', 'int', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，String类的length()方法返回的是____类型。 (第6组)', 'int', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，String类的length()方法返回的是____类型。 (第7组)', 'int', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，String类的length()方法返回的是____类型。 (第8组)', 'int', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，String类的length()方法返回的是____类型。 (第9组)', 'int', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，String类的length()方法返回的是____类型。 (第10组)', 'int', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，使用____关键字来引用当前对象。', 'this', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，使用____关键字来引用当前对象。 (第2组)', 'this', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，使用____关键字来引用当前对象。 (第3组)', 'this', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，使用____关键字来引用当前对象。 (第4组)', 'this', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，使用____关键字来引用当前对象。 (第5组)', 'this', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，使用____关键字来引用当前对象。 (第6组)', 'this', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，使用____关键字来引用当前对象。 (第7组)', 'this', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，使用____关键字来引用当前对象。 (第8组)', 'this', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，使用____关键字来引用当前对象。 (第9组)', 'this', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，使用____关键字来引用当前对象。 (第10组)', 'this', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，静态方法使用____关键字修饰。', 'static', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，静态方法使用____关键字修饰。 (第2组)', 'static', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，静态方法使用____关键字修饰。 (第3组)', 'static', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，静态方法使用____关键字修饰。 (第4组)', 'static', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，静态方法使用____关键字修饰。 (第5组)', 'static', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，静态方法使用____关键字修饰。 (第6组)', 'static', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，静态方法使用____关键字修饰。 (第7组)', 'static', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，静态方法使用____关键字修饰。 (第8组)', 'static', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，静态方法使用____关键字修饰。 (第9组)', 'static', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，静态方法使用____关键字修饰。 (第10组)', 'static', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('抽象类不能直接____，需要通过继承创建子类对象。', '实例化', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('抽象类不能直接____，需要通过继承创建子类对象。 (第2组)', '实例化', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('抽象类不能直接____，需要通过继承创建子类对象。 (第3组)', '实例化', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('抽象类不能直接____，需要通过继承创建子类对象。 (第4组)', '实例化', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('抽象类不能直接____，需要通过继承创建子类对象。 (第5组)', '实例化', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('抽象类不能直接____，需要通过继承创建子类对象。 (第6组)', '实例化', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('抽象类不能直接____，需要通过继承创建子类对象。 (第7组)', '实例化', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('抽象类不能直接____，需要通过继承创建子类对象。 (第8组)', '实例化', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('抽象类不能直接____，需要通过继承创建子类对象。 (第9组)', '实例化', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('抽象类不能直接____，需要通过继承创建子类对象。 (第10组)', '实例化', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('接口中定义的变量默认是public static final，即____。', '常量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('接口中定义的变量默认是public static final，即____。 (第2组)', '常量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('接口中定义的变量默认是public static final，即____。 (第3组)', '常量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('接口中定义的变量默认是public static final，即____。 (第4组)', '常量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('接口中定义的变量默认是public static final，即____。 (第5组)', '常量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('接口中定义的变量默认是public static final，即____。 (第6组)', '常量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('接口中定义的变量默认是public static final，即____。 (第7组)', '常量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('接口中定义的变量默认是public static final，即____。 (第8组)', '常量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('接口中定义的变量默认是public static final，即____。 (第9组)', '常量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('接口中定义的变量默认是public static final，即____。 (第10组)', '常量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('方法重写要求方法名、参数列表和____都要相同。', '返回类型', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('方法重写要求方法名、参数列表和____都要相同。 (第2组)', '返回类型', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('方法重写要求方法名、参数列表和____都要相同。 (第3组)', '返回类型', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('方法重写要求方法名、参数列表和____都要相同。 (第4组)', '返回类型', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('方法重写要求方法名、参数列表和____都要相同。 (第5组)', '返回类型', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('方法重写要求方法名、参数列表和____都要相同。 (第6组)', '返回类型', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('方法重写要求方法名、参数列表和____都要相同。 (第7组)', '返回类型', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('方法重写要求方法名、参数列表和____都要相同。 (第8组)', '返回类型', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('方法重写要求方法名、参数列表和____都要相同。 (第9组)', '返回类型', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('方法重写要求方法名、参数列表和____都要相同。 (第10组)', '返回类型', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('异常处理的try-catch-finally块中，____块总会执行。', 'finally', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('异常处理的try-catch-finally块中，____块总会执行。 (第2组)', 'finally', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('异常处理的try-catch-finally块中，____块总会执行。 (第3组)', 'finally', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('异常处理的try-catch-finally块中，____块总会执行。 (第4组)', 'finally', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('异常处理的try-catch-finally块中，____块总会执行。 (第5组)', 'finally', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('异常处理的try-catch-finally块中，____块总会执行。 (第6组)', 'finally', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('异常处理的try-catch-finally块中，____块总会执行。 (第7组)', 'finally', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('异常处理的try-catch-finally块中，____块总会执行。 (第8组)', 'finally', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('异常处理的try-catch-finally块中，____块总会执行。 (第9组)', 'finally', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('异常处理的try-catch-finally块中，____块总会执行。 (第10组)', 'finally', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Object类的toString()方法默认返回类的____和哈希码。', '类名', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Object类的toString()方法默认返回类的____和哈希码。 (第2组)', '类名', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Object类的toString()方法默认返回类的____和哈希码。 (第3组)', '类名', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Object类的toString()方法默认返回类的____和哈希码。 (第4组)', '类名', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Object类的toString()方法默认返回类的____和哈希码。 (第5组)', '类名', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Object类的toString()方法默认返回类的____和哈希码。 (第6组)', '类名', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Object类的toString()方法默认返回类的____和哈希码。 (第7组)', '类名', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Object类的toString()方法默认返回类的____和哈希码。 (第8组)', '类名', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Object类的toString()方法默认返回类的____和哈希码。 (第9组)', '类名', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Object类的toString()方法默认返回类的____和哈希码。 (第10组)', '类名', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java的集合框架中，List接口的直接父接口是____。', 'Collection', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java的集合框架中，List接口的直接父接口是____。 (第2组)', 'Collection', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java的集合框架中，List接口的直接父接口是____。 (第3组)', 'Collection', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java的集合框架中，List接口的直接父接口是____。 (第4组)', 'Collection', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java的集合框架中，List接口的直接父接口是____。 (第5组)', 'Collection', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java的集合框架中，List接口的直接父接口是____。 (第6组)', 'Collection', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java的集合框架中，List接口的直接父接口是____。 (第7组)', 'Collection', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java的集合框架中，List接口的直接父接口是____。 (第8组)', 'Collection', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java的集合框架中，List接口的直接父接口是____。 (第9组)', 'Collection', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java的集合框架中，List接口的直接父接口是____。 (第10组)', 'Collection', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL注入攻击利用了Web应用程序对用户输入____不充分验证的漏洞。', '数据', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL注入攻击利用了Web应用程序对用户输入____不充分验证的漏洞。 (第2组)', '数据', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL注入攻击利用了Web应用程序对用户输入____不充分验证的漏洞。 (第3组)', '数据', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL注入攻击利用了Web应用程序对用户输入____不充分验证的漏洞。 (第4组)', '数据', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL注入攻击利用了Web应用程序对用户输入____不充分验证的漏洞。 (第5组)', '数据', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL注入攻击利用了Web应用程序对用户输入____不充分验证的漏洞。 (第6组)', '数据', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL注入攻击利用了Web应用程序对用户输入____不充分验证的漏洞。 (第7组)', '数据', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL注入攻击利用了Web应用程序对用户输入____不充分验证的漏洞。 (第8组)', '数据', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL注入攻击利用了Web应用程序对用户输入____不充分验证的漏洞。 (第9组)', '数据', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL注入攻击利用了Web应用程序对用户输入____不充分验证的漏洞。 (第10组)', '数据', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('参数化查询将SQL语句结构和____分离，防止注入。', '数据', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('参数化查询将SQL语句结构和____分离，防止注入。 (第2组)', '数据', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('参数化查询将SQL语句结构和____分离，防止注入。 (第3组)', '数据', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('参数化查询将SQL语句结构和____分离，防止注入。 (第4组)', '数据', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('参数化查询将SQL语句结构和____分离，防止注入。 (第5组)', '数据', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('参数化查询将SQL语句结构和____分离，防止注入。 (第6组)', '数据', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('参数化查询将SQL语句结构和____分离，防止注入。 (第7组)', '数据', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('参数化查询将SQL语句结构和____分离，防止注入。 (第8组)', '数据', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('参数化查询将SQL语句结构和____分离，防止注入。 (第9组)', '数据', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('参数化查询将SQL语句结构和____分离，防止注入。 (第10组)', '数据', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('XSS攻击的三种类型：反射型、存储型和____型。', 'DOM', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('XSS攻击的三种类型：反射型、存储型和____型。 (第2组)', 'DOM', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('XSS攻击的三种类型：反射型、存储型和____型。 (第3组)', 'DOM', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('XSS攻击的三种类型：反射型、存储型和____型。 (第4组)', 'DOM', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('XSS攻击的三种类型：反射型、存储型和____型。 (第5组)', 'DOM', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('XSS攻击的三种类型：反射型、存储型和____型。 (第6组)', 'DOM', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('XSS攻击的三种类型：反射型、存储型和____型。 (第7组)', 'DOM', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('XSS攻击的三种类型：反射型、存储型和____型。 (第8组)', 'DOM', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('XSS攻击的三种类型：反射型、存储型和____型。 (第9组)', 'DOM', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('XSS攻击的三种类型：反射型、存储型和____型。 (第10组)', 'DOM', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTML上下文中，需要对<、>、&字符进行____以防止XSS。', '编码或转义', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTML上下文中，需要对<、>、&字符进行____以防止XSS。 (第2组)', '编码或转义', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTML上下文中，需要对<、>、&字符进行____以防止XSS。 (第3组)', '编码或转义', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTML上下文中，需要对<、>、&字符进行____以防止XSS。 (第4组)', '编码或转义', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTML上下文中，需要对<、>、&字符进行____以防止XSS。 (第5组)', '编码或转义', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTML上下文中，需要对<、>、&字符进行____以防止XSS。 (第6组)', '编码或转义', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTML上下文中，需要对<、>、&字符进行____以防止XSS。 (第7组)', '编码或转义', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTML上下文中，需要对<、>、&字符进行____以防止XSS。 (第8组)', '编码或转义', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTML上下文中，需要对<、>、&字符进行____以防止XSS。 (第9组)', '编码或转义', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTML上下文中，需要对<、>、&字符进行____以防止XSS。 (第10组)', '编码或转义', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSRF利用浏览器的____特性自动发送Cookie。', '同源', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSRF利用浏览器的____特性自动发送Cookie。 (第2组)', '同源', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSRF利用浏览器的____特性自动发送Cookie。 (第3组)', '同源', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSRF利用浏览器的____特性自动发送Cookie。 (第4组)', '同源', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSRF利用浏览器的____特性自动发送Cookie。 (第5组)', '同源', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSRF利用浏览器的____特性自动发送Cookie。 (第6组)', '同源', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSRF利用浏览器的____特性自动发送Cookie。 (第7组)', '同源', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSRF利用浏览器的____特性自动发送Cookie。 (第8组)', '同源', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSRF利用浏览器的____特性自动发送Cookie。 (第9组)', '同源', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSRF利用浏览器的____特性自动发送Cookie。 (第10组)', '同源', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('同源策略的三要素：协议、域名和____。', '端口', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('同源策略的三要素：协议、域名和____。 (第2组)', '端口', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('同源策略的三要素：协议、域名和____。 (第3组)', '端口', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('同源策略的三要素：协议、域名和____。 (第4组)', '端口', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('同源策略的三要素：协议、域名和____。 (第5组)', '端口', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('同源策略的三要素：协议、域名和____。 (第6组)', '端口', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('同源策略的三要素：协议、域名和____。 (第7组)', '端口', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('同源策略的三要素：协议、域名和____。 (第8组)', '端口', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('同源策略的三要素：协议、域名和____。 (第9组)', '端口', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('同源策略的三要素：协议、域名和____。 (第10组)', '端口', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WAF是Web应用____的缩写。', '防火墙', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WAF是Web应用____的缩写。 (第2组)', '防火墙', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WAF是Web应用____的缩写。 (第3组)', '防火墙', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WAF是Web应用____的缩写。 (第4组)', '防火墙', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WAF是Web应用____的缩写。 (第5组)', '防火墙', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WAF是Web应用____的缩写。 (第6组)', '防火墙', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WAF是Web应用____的缩写。 (第7组)', '防火墙', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WAF是Web应用____的缩写。 (第8组)', '防火墙', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WAF是Web应用____的缩写。 (第9组)', '防火墙', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WAF是Web应用____的缩写。 (第10组)', '防火墙', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('敏感信息泄露可能通过错误信息、代码仓库和____等途径。', '日志文件', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('敏感信息泄露可能通过错误信息、代码仓库和____等途径。 (第2组)', '日志文件', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('敏感信息泄露可能通过错误信息、代码仓库和____等途径。 (第3组)', '日志文件', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('敏感信息泄露可能通过错误信息、代码仓库和____等途径。 (第4组)', '日志文件', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('敏感信息泄露可能通过错误信息、代码仓库和____等途径。 (第5组)', '日志文件', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('敏感信息泄露可能通过错误信息、代码仓库和____等途径。 (第6组)', '日志文件', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('敏感信息泄露可能通过错误信息、代码仓库和____等途径。 (第7组)', '日志文件', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('敏感信息泄露可能通过错误信息、代码仓库和____等途径。 (第8组)', '日志文件', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('敏感信息泄露可能通过错误信息、代码仓库和____等途径。 (第9组)', '日志文件', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('敏感信息泄露可能通过错误信息、代码仓库和____等途径。 (第10组)', '日志文件', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('防止CSRF的Token机制验证表单Token和____中Token的一致性。', 'Session', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('防止CSRF的Token机制验证表单Token和____中Token的一致性。 (第2组)', 'Session', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('防止CSRF的Token机制验证表单Token和____中Token的一致性。 (第3组)', 'Session', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('防止CSRF的Token机制验证表单Token和____中Token的一致性。 (第4组)', 'Session', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('防止CSRF的Token机制验证表单Token和____中Token的一致性。 (第5组)', 'Session', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('防止CSRF的Token机制验证表单Token和____中Token的一致性。 (第6组)', 'Session', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('防止CSRF的Token机制验证表单Token和____中Token的一致性。 (第7组)', 'Session', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('防止CSRF的Token机制验证表单Token和____中Token的一致性。 (第8组)', 'Session', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('防止CSRF的Token机制验证表单Token和____中Token的一致性。 (第9组)', 'Session', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('防止CSRF的Token机制验证表单Token和____中Token的一致性。 (第10组)', 'Session', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('安全的密码存储应使用加盐的____哈希算法。', 'BCrypt', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('安全的密码存储应使用加盐的____哈希算法。 (第2组)', 'BCrypt', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('安全的密码存储应使用加盐的____哈希算法。 (第3组)', 'BCrypt', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('安全的密码存储应使用加盐的____哈希算法。 (第4组)', 'BCrypt', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('安全的密码存储应使用加盐的____哈希算法。 (第5组)', 'BCrypt', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('安全的密码存储应使用加盐的____哈希算法。 (第6组)', 'BCrypt', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('安全的密码存储应使用加盐的____哈希算法。 (第7组)', 'BCrypt', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('安全的密码存储应使用加盐的____哈希算法。 (第8组)', 'BCrypt', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('安全的密码存储应使用加盐的____哈希算法。 (第9组)', 'BCrypt', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('安全的密码存储应使用加盐的____哈希算法。 (第10组)', 'BCrypt', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP三次握手：SYN、____、ACK。', 'SYN-ACK', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP三次握手：SYN、____、ACK。 (第2组)', 'SYN-ACK', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP三次握手：SYN、____、ACK。 (第3组)', 'SYN-ACK', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP三次握手：SYN、____、ACK。 (第4组)', 'SYN-ACK', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP三次握手：SYN、____、ACK。 (第5组)', 'SYN-ACK', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP三次握手：SYN、____、ACK。 (第6组)', 'SYN-ACK', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP三次握手：SYN、____、ACK。 (第7组)', 'SYN-ACK', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP三次握手：SYN、____、ACK。 (第8组)', 'SYN-ACK', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP三次握手：SYN、____、ACK。 (第9组)', 'SYN-ACK', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP三次握手：SYN、____、ACK。 (第10组)', 'SYN-ACK', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP四次挥手：FIN、____、FIN、ACK。', 'ACK', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP四次挥手：FIN、____、FIN、ACK。 (第2组)', 'ACK', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP四次挥手：FIN、____、FIN、ACK。 (第3组)', 'ACK', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP四次挥手：FIN、____、FIN、ACK。 (第4组)', 'ACK', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP四次挥手：FIN、____、FIN、ACK。 (第5组)', 'ACK', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP四次挥手：FIN、____、FIN、ACK。 (第6组)', 'ACK', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP四次挥手：FIN、____、FIN、ACK。 (第7组)', 'ACK', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP四次挥手：FIN、____、FIN、ACK。 (第8组)', 'ACK', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP四次挥手：FIN、____、FIN、ACK。 (第9组)', 'ACK', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP四次挥手：FIN、____、FIN、ACK。 (第10组)', 'ACK', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的____方法只获取响应头，不获取实体内容。', 'HEAD', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的____方法只获取响应头，不获取实体内容。 (第2组)', 'HEAD', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的____方法只获取响应头，不获取实体内容。 (第3组)', 'HEAD', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的____方法只获取响应头，不获取实体内容。 (第4组)', 'HEAD', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的____方法只获取响应头，不获取实体内容。 (第5组)', 'HEAD', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的____方法只获取响应头，不获取实体内容。 (第6组)', 'HEAD', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的____方法只获取响应头，不获取实体内容。 (第7组)', 'HEAD', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的____方法只获取响应头，不获取实体内容。 (第8组)', 'HEAD', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的____方法只获取响应头，不获取实体内容。 (第9组)', 'HEAD', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的____方法只获取响应头，不获取实体内容。 (第10组)', 'HEAD', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS使用____协议进行加密。', 'TLS', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS使用____协议进行加密。 (第2组)', 'TLS', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS使用____协议进行加密。 (第3组)', 'TLS', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS使用____协议进行加密。 (第4组)', 'TLS', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS使用____协议进行加密。 (第5组)', 'TLS', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS使用____协议进行加密。 (第6组)', 'TLS', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS使用____协议进行加密。 (第7组)', 'TLS', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS使用____协议进行加密。 (第8组)', 'TLS', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS使用____协议进行加密。 (第9组)', 'TLS', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS使用____协议进行加密。 (第10组)', 'TLS', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的全称是____，主要工作端口是53。', 'Domain Name System', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的全称是____，主要工作端口是53。 (第2组)', 'Domain Name System', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的全称是____，主要工作端口是53。 (第3组)', 'Domain Name System', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的全称是____，主要工作端口是53。 (第4组)', 'Domain Name System', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的全称是____，主要工作端口是53。 (第5组)', 'Domain Name System', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的全称是____，主要工作端口是53。 (第6组)', 'Domain Name System', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的全称是____，主要工作端口是53。 (第7组)', 'Domain Name System', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的全称是____，主要工作端口是53。 (第8组)', 'Domain Name System', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的全称是____，主要工作端口是53。 (第9组)', 'Domain Name System', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的全称是____，主要工作端口是53。 (第10组)', 'Domain Name System', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的HttpOnly属性可以防止____访问Cookie。', 'JavaScript', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的HttpOnly属性可以防止____访问Cookie。 (第2组)', 'JavaScript', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的HttpOnly属性可以防止____访问Cookie。 (第3组)', 'JavaScript', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的HttpOnly属性可以防止____访问Cookie。 (第4组)', 'JavaScript', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的HttpOnly属性可以防止____访问Cookie。 (第5组)', 'JavaScript', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的HttpOnly属性可以防止____访问Cookie。 (第6组)', 'JavaScript', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的HttpOnly属性可以防止____访问Cookie。 (第7组)', 'JavaScript', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的HttpOnly属性可以防止____访问Cookie。 (第8组)', 'JavaScript', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的HttpOnly属性可以防止____访问Cookie。 (第9组)', 'JavaScript', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的HttpOnly属性可以防止____访问Cookie。 (第10组)', 'JavaScript', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('滑动窗口用于TCP的____控制。', '流量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('滑动窗口用于TCP的____控制。 (第2组)', '流量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('滑动窗口用于TCP的____控制。 (第3组)', '流量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('滑动窗口用于TCP的____控制。 (第4组)', '流量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('滑动窗口用于TCP的____控制。 (第5组)', '流量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('滑动窗口用于TCP的____控制。 (第6组)', '流量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('滑动窗口用于TCP的____控制。 (第7组)', '流量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('滑动窗口用于TCP的____控制。 (第8组)', '流量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('滑动窗口用于TCP的____控制。 (第9组)', '流量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('滑动窗口用于TCP的____控制。 (第10组)', '流量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('IP地址分为____类和____类。', 'A|B', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('IP地址分为____类和____类。 (第2组)', 'A|B', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('IP地址分为____类和____类。 (第3组)', 'A|B', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('IP地址分为____类和____类。 (第4组)', 'A|B', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('IP地址分为____类和____类。 (第5组)', 'A|B', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('IP地址分为____类和____类。 (第6组)', 'A|B', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('IP地址分为____类和____类。 (第7组)', 'A|B', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('IP地址分为____类和____类。 (第8组)', 'A|B', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('IP地址分为____类和____类。 (第9组)', 'A|B', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('IP地址分为____类和____类。 (第10组)', 'A|B', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('路由选择协议中，RIP基于____算法。', '距离向量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('路由选择协议中，RIP基于____算法。 (第2组)', '距离向量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('路由选择协议中，RIP基于____算法。 (第3组)', '距离向量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('路由选择协议中，RIP基于____算法。 (第4组)', '距离向量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('路由选择协议中，RIP基于____算法。 (第5组)', '距离向量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('路由选择协议中，RIP基于____算法。 (第6组)', '距离向量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('路由选择协议中，RIP基于____算法。 (第7组)', '距离向量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('路由选择协议中，RIP基于____算法。 (第8组)', '距离向量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('路由选择协议中，RIP基于____算法。 (第9组)', '距离向量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('路由选择协议中，RIP基于____算法。 (第10组)', '距离向量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ARP协议用于将____地址解析为IP地址。', 'MAC', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ARP协议用于将____地址解析为IP地址。 (第2组)', 'MAC', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ARP协议用于将____地址解析为IP地址。 (第3组)', 'MAC', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ARP协议用于将____地址解析为IP地址。 (第4组)', 'MAC', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ARP协议用于将____地址解析为IP地址。 (第5组)', 'MAC', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ARP协议用于将____地址解析为IP地址。 (第6组)', 'MAC', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ARP协议用于将____地址解析为IP地址。 (第7组)', 'MAC', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ARP协议用于将____地址解析为IP地址。 (第8组)', 'MAC', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ARP协议用于将____地址解析为IP地址。 (第9组)', 'MAC', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ARP协议用于将____地址解析为IP地址。 (第10组)', 'MAC', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL的InnoDB存储引擎支持____和行级锁。', '事务', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL的InnoDB存储引擎支持____和行级锁。 (第2组)', '事务', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL的InnoDB存储引擎支持____和行级锁。 (第3组)', '事务', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL的InnoDB存储引擎支持____和行级锁。 (第4组)', '事务', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL的InnoDB存储引擎支持____和行级锁。 (第5组)', '事务', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL的InnoDB存储引擎支持____和行级锁。 (第6组)', '事务', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL的InnoDB存储引擎支持____和行级锁。 (第7组)', '事务', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL的InnoDB存储引擎支持____和行级锁。 (第8组)', '事务', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL的InnoDB存储引擎支持____和行级锁。 (第9组)', '事务', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL的InnoDB存储引擎支持____和行级锁。 (第10组)', '事务', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的聚合函数包括：COUNT、SUM、AVG、MAX和____。', 'MIN', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的聚合函数包括：COUNT、SUM、AVG、MAX和____。 (第2组)', 'MIN', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的聚合函数包括：COUNT、SUM、AVG、MAX和____。 (第3组)', 'MIN', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的聚合函数包括：COUNT、SUM、AVG、MAX和____。 (第4组)', 'MIN', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的聚合函数包括：COUNT、SUM、AVG、MAX和____。 (第5组)', 'MIN', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的聚合函数包括：COUNT、SUM、AVG、MAX和____。 (第6组)', 'MIN', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的聚合函数包括：COUNT、SUM、AVG、MAX和____。 (第7组)', 'MIN', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的聚合函数包括：COUNT、SUM、AVG、MAX和____。 (第8组)', 'MIN', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的聚合函数包括：COUNT、SUM、AVG、MAX和____。 (第9组)', 'MIN', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的聚合函数包括：COUNT、SUM、AVG、MAX和____。 (第10组)', 'MIN', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据库索引的____原则指最左前缀匹配。', '最左', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据库索引的____原则指最左前缀匹配。 (第2组)', '最左', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据库索引的____原则指最左前缀匹配。 (第3组)', '最左', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据库索引的____原则指最左前缀匹配。 (第4组)', '最左', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据库索引的____原则指最左前缀匹配。 (第5组)', '最左', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据库索引的____原则指最左前缀匹配。 (第6组)', '最左', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据库索引的____原则指最左前缀匹配。 (第7组)', '最左', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据库索引的____原则指最左前缀匹配。 (第8组)', '最左', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据库索引的____原则指最左前缀匹配。 (第9组)', '最左', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据库索引的____原则指最左前缀匹配。 (第10组)', '最左', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('事务的ACID特性：原子性、一致性、隔离性和____。', '持久性', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('事务的ACID特性：原子性、一致性、隔离性和____。 (第2组)', '持久性', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('事务的ACID特性：原子性、一致性、隔离性和____。 (第3组)', '持久性', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('事务的ACID特性：原子性、一致性、隔离性和____。 (第4组)', '持久性', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('事务的ACID特性：原子性、一致性、隔离性和____。 (第5组)', '持久性', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('事务的ACID特性：原子性、一致性、隔离性和____。 (第6组)', '持久性', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('事务的ACID特性：原子性、一致性、隔离性和____。 (第7组)', '持久性', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('事务的ACID特性：原子性、一致性、隔离性和____。 (第8组)', '持久性', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('事务的ACID特性：原子性、一致性、隔离性和____。 (第9组)', '持久性', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('事务的ACID特性：原子性、一致性、隔离性和____。 (第10组)', '持久性', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的持久化方式包括RDB快照和____日志。', 'AOF', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的持久化方式包括RDB快照和____日志。 (第2组)', 'AOF', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的持久化方式包括RDB快照和____日志。 (第3组)', 'AOF', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的持久化方式包括RDB快照和____日志。 (第4组)', 'AOF', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的持久化方式包括RDB快照和____日志。 (第5组)', 'AOF', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的持久化方式包括RDB快照和____日志。 (第6组)', 'AOF', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的持久化方式包括RDB快照和____日志。 (第7组)', 'AOF', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的持久化方式包括RDB快照和____日志。 (第8组)', 'AOF', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的持久化方式包括RDB快照和____日志。 (第9组)', 'AOF', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的持久化方式包括RDB快照和____日志。 (第10组)', 'AOF', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis使用____实现分布式锁。', 'SETNX', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis使用____实现分布式锁。 (第2组)', 'SETNX', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis使用____实现分布式锁。 (第3组)', 'SETNX', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis使用____实现分布式锁。 (第4组)', 'SETNX', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis使用____实现分布式锁。 (第5组)', 'SETNX', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis使用____实现分布式锁。 (第6组)', 'SETNX', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis使用____实现分布式锁。 (第7组)', 'SETNX', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis使用____实现分布式锁。 (第8组)', 'SETNX', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis使用____实现分布式锁。 (第9组)', 'SETNX', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis使用____实现分布式锁。 (第10组)', 'SETNX', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的JOIN类型中，____JOIN返回左表全部记录。', 'LEFT', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的JOIN类型中，____JOIN返回左表全部记录。 (第2组)', 'LEFT', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的JOIN类型中，____JOIN返回左表全部记录。 (第3组)', 'LEFT', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的JOIN类型中，____JOIN返回左表全部记录。 (第4组)', 'LEFT', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的JOIN类型中，____JOIN返回左表全部记录。 (第5组)', 'LEFT', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的JOIN类型中，____JOIN返回左表全部记录。 (第6组)', 'LEFT', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的JOIN类型中，____JOIN返回左表全部记录。 (第7组)', 'LEFT', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的JOIN类型中，____JOIN返回左表全部记录。 (第8组)', 'LEFT', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的JOIN类型中，____JOIN返回左表全部记录。 (第9组)', 'LEFT', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的JOIN类型中，____JOIN返回左表全部记录。 (第10组)', 'LEFT', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL默认的事务隔离级别是____。', 'REPEATABLE READ', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL默认的事务隔离级别是____。 (第2组)', 'REPEATABLE READ', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL默认的事务隔离级别是____。 (第3组)', 'REPEATABLE READ', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL默认的事务隔离级别是____。 (第4组)', 'REPEATABLE READ', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL默认的事务隔离级别是____。 (第5组)', 'REPEATABLE READ', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL默认的事务隔离级别是____。 (第6组)', 'REPEATABLE READ', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL默认的事务隔离级别是____。 (第7组)', 'REPEATABLE READ', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL默认的事务隔离级别是____。 (第8组)', 'REPEATABLE READ', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL默认的事务隔离级别是____。 (第9组)', 'REPEATABLE READ', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL默认的事务隔离级别是____。 (第10组)', 'REPEATABLE READ', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据库____范式旨在消除冗余和数据依赖问题。', '规范化', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据库____范式旨在消除冗余和数据依赖问题。 (第2组)', '规范化', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据库____范式旨在消除冗余和数据依赖问题。 (第3组)', '规范化', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据库____范式旨在消除冗余和数据依赖问题。 (第4组)', '规范化', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据库____范式旨在消除冗余和数据依赖问题。 (第5组)', '规范化', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据库____范式旨在消除冗余和数据依赖问题。 (第6组)', '规范化', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据库____范式旨在消除冗余和数据依赖问题。 (第7组)', '规范化', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据库____范式旨在消除冗余和数据依赖问题。 (第8组)', '规范化', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据库____范式旨在消除冗余和数据依赖问题。 (第9组)', '规范化', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据库____范式旨在消除冗余和数据依赖问题。 (第10组)', '规范化', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MongoDB是____型NoSQL数据库。', '文档', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MongoDB是____型NoSQL数据库。 (第2组)', '文档', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MongoDB是____型NoSQL数据库。 (第3组)', '文档', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MongoDB是____型NoSQL数据库。 (第4组)', '文档', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MongoDB是____型NoSQL数据库。 (第5组)', '文档', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MongoDB是____型NoSQL数据库。 (第6组)', '文档', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MongoDB是____型NoSQL数据库。 (第7组)', '文档', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MongoDB是____型NoSQL数据库。 (第8组)', '文档', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MongoDB是____型NoSQL数据库。 (第9组)', '文档', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MongoDB是____型NoSQL数据库。 (第10组)', '文档', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数组下标从____开始。', '0', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数组下标从____开始。 (第2组)', '0', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数组下标从____开始。 (第3组)', '0', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数组下标从____开始。 (第4组)', '0', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数组下标从____开始。 (第5组)', '0', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数组下标从____开始。 (第6组)', '0', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数组下标从____开始。 (第7组)', '0', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数组下标从____开始。 (第8组)', '0', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数组下标从____开始。 (第9组)', '0', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数组下标从____开始。 (第10组)', '0', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二叉树的深度为log2(n+1)向下取整适用于____二叉树。', '完全', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二叉树的深度为log2(n+1)向下取整适用于____二叉树。 (第2组)', '完全', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二叉树的深度为log2(n+1)向下取整适用于____二叉树。 (第3组)', '完全', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二叉树的深度为log2(n+1)向下取整适用于____二叉树。 (第4组)', '完全', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二叉树的深度为log2(n+1)向下取整适用于____二叉树。 (第5组)', '完全', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二叉树的深度为log2(n+1)向下取整适用于____二叉树。 (第6组)', '完全', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二叉树的深度为log2(n+1)向下取整适用于____二叉树。 (第7组)', '完全', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二叉树的深度为log2(n+1)向下取整适用于____二叉树。 (第8组)', '完全', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二叉树的深度为log2(n+1)向下取整适用于____二叉树。 (第9组)', '完全', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二叉树的深度为log2(n+1)向下取整适用于____二叉树。 (第10组)', '完全', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('快速排序的平均时间复杂度是____。', 'O(n log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('快速排序的平均时间复杂度是____。 (第2组)', 'O(n log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('快速排序的平均时间复杂度是____。 (第3组)', 'O(n log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('快速排序的平均时间复杂度是____。 (第4组)', 'O(n log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('快速排序的平均时间复杂度是____。 (第5组)', 'O(n log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('快速排序的平均时间复杂度是____。 (第6组)', 'O(n log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('快速排序的平均时间复杂度是____。 (第7组)', 'O(n log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('快速排序的平均时间复杂度是____。 (第8组)', 'O(n log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('快速排序的平均时间复杂度是____。 (第9组)', 'O(n log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('快速排序的平均时间复杂度是____。 (第10组)', 'O(n log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二分查找的时间复杂度是____。', 'O(log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二分查找的时间复杂度是____。 (第2组)', 'O(log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二分查找的时间复杂度是____。 (第3组)', 'O(log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二分查找的时间复杂度是____。 (第4组)', 'O(log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二分查找的时间复杂度是____。 (第5组)', 'O(log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二分查找的时间复杂度是____。 (第6组)', 'O(log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二分查找的时间复杂度是____。 (第7组)', 'O(log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二分查找的时间复杂度是____。 (第8组)', 'O(log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二分查找的时间复杂度是____。 (第9组)', 'O(log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二分查找的时间复杂度是____。 (第10组)', 'O(log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('栈的特点是____。', 'LIFO或后进先出', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('栈的特点是____。 (第2组)', 'LIFO或后进先出', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('栈的特点是____。 (第3组)', 'LIFO或后进先出', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('栈的特点是____。 (第4组)', 'LIFO或后进先出', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('栈的特点是____。 (第5组)', 'LIFO或后进先出', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('栈的特点是____。 (第6组)', 'LIFO或后进先出', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('栈的特点是____。 (第7组)', 'LIFO或后进先出', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('栈的特点是____。 (第8组)', 'LIFO或后进先出', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('栈的特点是____。 (第9组)', 'LIFO或后进先出', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('栈的特点是____。 (第10组)', 'LIFO或后进先出', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('队列的特点是____。', 'FIFO或先进先出', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('队列的特点是____。 (第2组)', 'FIFO或先进先出', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('队列的特点是____。 (第3组)', 'FIFO或先进先出', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('队列的特点是____。 (第4组)', 'FIFO或先进先出', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('队列的特点是____。 (第5组)', 'FIFO或先进先出', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('队列的特点是____。 (第6组)', 'FIFO或先进先出', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('队列的特点是____。 (第7组)', 'FIFO或先进先出', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('队列的特点是____。 (第8组)', 'FIFO或先进先出', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('队列的特点是____。 (第9组)', 'FIFO或先进先出', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('队列的特点是____。 (第10组)', 'FIFO或先进先出', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('堆用于实现优先级队列，堆排序的时间复杂度始终是____。', 'O(n log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('堆用于实现优先级队列，堆排序的时间复杂度始终是____。 (第2组)', 'O(n log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('堆用于实现优先级队列，堆排序的时间复杂度始终是____。 (第3组)', 'O(n log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('堆用于实现优先级队列，堆排序的时间复杂度始终是____。 (第4组)', 'O(n log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('堆用于实现优先级队列，堆排序的时间复杂度始终是____。 (第5组)', 'O(n log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('堆用于实现优先级队列，堆排序的时间复杂度始终是____。 (第6组)', 'O(n log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('堆用于实现优先级队列，堆排序的时间复杂度始终是____。 (第7组)', 'O(n log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('堆用于实现优先级队列，堆排序的时间复杂度始终是____。 (第8组)', 'O(n log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('堆用于实现优先级队列，堆排序的时间复杂度始终是____。 (第9组)', 'O(n log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('堆用于实现优先级队列，堆排序的时间复杂度始终是____。 (第10组)', 'O(n log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('动态规划的核心是最优子结构和____子问题。', '重叠', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('动态规划的核心是最优子结构和____子问题。 (第2组)', '重叠', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('动态规划的核心是最优子结构和____子问题。 (第3组)', '重叠', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('动态规划的核心是最优子结构和____子问题。 (第4组)', '重叠', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('动态规划的核心是最优子结构和____子问题。 (第5组)', '重叠', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('动态规划的核心是最优子结构和____子问题。 (第6组)', '重叠', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('动态规划的核心是最优子结构和____子问题。 (第7组)', '重叠', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('动态规划的核心是最优子结构和____子问题。 (第8组)', '重叠', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('动态规划的核心是最优子结构和____子问题。 (第9组)', '重叠', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('动态规划的核心是最优子结构和____子问题。 (第10组)', '重叠', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('图的遍历算法包括____和广度优先搜索。', '深度优先搜索', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('图的遍历算法包括____和广度优先搜索。 (第2组)', '深度优先搜索', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('图的遍历算法包括____和广度优先搜索。 (第3组)', '深度优先搜索', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('图的遍历算法包括____和广度优先搜索。 (第4组)', '深度优先搜索', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('图的遍历算法包括____和广度优先搜索。 (第5组)', '深度优先搜索', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('图的遍历算法包括____和广度优先搜索。 (第6组)', '深度优先搜索', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('图的遍历算法包括____和广度优先搜索。 (第7组)', '深度优先搜索', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('图的遍历算法包括____和广度优先搜索。 (第8组)', '深度优先搜索', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('图的遍历算法包括____和广度优先搜索。 (第9组)', '深度优先搜索', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('图的遍历算法包括____和广度优先搜索。 (第10组)', '深度优先搜索', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('哈希表处理哈希冲突的方法包括链地址法和____法。', '开放地址', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('哈希表处理哈希冲突的方法包括链地址法和____法。 (第2组)', '开放地址', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('哈希表处理哈希冲突的方法包括链地址法和____法。 (第3组)', '开放地址', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('哈希表处理哈希冲突的方法包括链地址法和____法。 (第4组)', '开放地址', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('哈希表处理哈希冲突的方法包括链地址法和____法。 (第5组)', '开放地址', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('哈希表处理哈希冲突的方法包括链地址法和____法。 (第6组)', '开放地址', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('哈希表处理哈希冲突的方法包括链地址法和____法。 (第7组)', '开放地址', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('哈希表处理哈希冲突的方法包括链地址法和____法。 (第8组)', '开放地址', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('哈希表处理哈希冲突的方法包括链地址法和____法。 (第9组)', '开放地址', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('哈希表处理哈希冲突的方法包括链地址法和____法。 (第10组)', '开放地址', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('进程是资源分配的独立单位，线程是____调度的独立单位。', 'CPU', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('进程是资源分配的独立单位，线程是____调度的独立单位。 (第2组)', 'CPU', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('进程是资源分配的独立单位，线程是____调度的独立单位。 (第3组)', 'CPU', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('进程是资源分配的独立单位，线程是____调度的独立单位。 (第4组)', 'CPU', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('进程是资源分配的独立单位，线程是____调度的独立单位。 (第5组)', 'CPU', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('进程是资源分配的独立单位，线程是____调度的独立单位。 (第6组)', 'CPU', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('进程是资源分配的独立单位，线程是____调度的独立单位。 (第7组)', 'CPU', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('进程是资源分配的独立单位，线程是____调度的独立单位。 (第8组)', 'CPU', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('进程是资源分配的独立单位，线程是____调度的独立单位。 (第9组)', 'CPU', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('进程是资源分配的独立单位，线程是____调度的独立单位。 (第10组)', 'CPU', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____命令用于查看当前工作目录。', 'pwd', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____命令用于查看当前工作目录。 (第2组)', 'pwd', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____命令用于查看当前工作目录。 (第3组)', 'pwd', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____命令用于查看当前工作目录。 (第4组)', 'pwd', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____命令用于查看当前工作目录。 (第5组)', 'pwd', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____命令用于查看当前工作目录。 (第6组)', 'pwd', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____命令用于查看当前工作目录。 (第7组)', 'pwd', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____命令用于查看当前工作目录。 (第8组)', 'pwd', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____命令用于查看当前工作目录。 (第9组)', 'pwd', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____命令用于查看当前工作目录。 (第10组)', 'pwd', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____命令用于修改文件权限。', 'chmod', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____命令用于修改文件权限。 (第2组)', 'chmod', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____命令用于修改文件权限。 (第3组)', 'chmod', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____命令用于修改文件权限。 (第4组)', 'chmod', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____命令用于修改文件权限。 (第5组)', 'chmod', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____命令用于修改文件权限。 (第6组)', 'chmod', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____命令用于修改文件权限。 (第7组)', 'chmod', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____命令用于修改文件权限。 (第8组)', 'chmod', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____命令用于修改文件权限。 (第9组)', 'chmod', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____命令用于修改文件权限。 (第10组)', 'chmod', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Shell脚本中，$#表示____个数。', '参数', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Shell脚本中，$#表示____个数。 (第2组)', '参数', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Shell脚本中，$#表示____个数。 (第3组)', '参数', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Shell脚本中，$#表示____个数。 (第4组)', '参数', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Shell脚本中，$#表示____个数。 (第5组)', '参数', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Shell脚本中，$#表示____个数。 (第6组)', '参数', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Shell脚本中，$#表示____个数。 (第7组)', '参数', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Shell脚本中，$#表示____个数。 (第8组)', '参数', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Shell脚本中，$#表示____个数。 (第9组)', '参数', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Shell脚本中，$#表示____个数。 (第10组)', '参数', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('虚拟内存通过____表实现地址映射。', '页', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('虚拟内存通过____表实现地址映射。 (第2组)', '页', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('虚拟内存通过____表实现地址映射。 (第3组)', '页', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('虚拟内存通过____表实现地址映射。 (第4组)', '页', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('虚拟内存通过____表实现地址映射。 (第5组)', '页', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('虚拟内存通过____表实现地址映射。 (第6组)', '页', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('虚拟内存通过____表实现地址映射。 (第7组)', '页', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('虚拟内存通过____表实现地址映射。 (第8组)', '页', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('虚拟内存通过____表实现地址映射。 (第9组)', '页', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('虚拟内存通过____表实现地址映射。 (第10组)', '页', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('死锁的必要条件包括：互斥、占有并等待、不可抢占和____。', '循环等待', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('死锁的必要条件包括：互斥、占有并等待、不可抢占和____。 (第2组)', '循环等待', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('死锁的必要条件包括：互斥、占有并等待、不可抢占和____。 (第3组)', '循环等待', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('死锁的必要条件包括：互斥、占有并等待、不可抢占和____。 (第4组)', '循环等待', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('死锁的必要条件包括：互斥、占有并等待、不可抢占和____。 (第5组)', '循环等待', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('死锁的必要条件包括：互斥、占有并等待、不可抢占和____。 (第6组)', '循环等待', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('死锁的必要条件包括：互斥、占有并等待、不可抢占和____。 (第7组)', '循环等待', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('死锁的必要条件包括：互斥、占有并等待、不可抢占和____。 (第8组)', '循环等待', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('死锁的必要条件包括：互斥、占有并等待、不可抢占和____。 (第9组)', '循环等待', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('死锁的必要条件包括：互斥、占有并等待、不可抢占和____。 (第10组)', '循环等待', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CPU调度的三种基本算法：先来先服务、时间片轮转和____。', '优先级调度', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CPU调度的三种基本算法：先来先服务、时间片轮转和____。 (第2组)', '优先级调度', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CPU调度的三种基本算法：先来先服务、时间片轮转和____。 (第3组)', '优先级调度', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CPU调度的三种基本算法：先来先服务、时间片轮转和____。 (第4组)', '优先级调度', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CPU调度的三种基本算法：先来先服务、时间片轮转和____。 (第5组)', '优先级调度', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CPU调度的三种基本算法：先来先服务、时间片轮转和____。 (第6组)', '优先级调度', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CPU调度的三种基本算法：先来先服务、时间片轮转和____。 (第7组)', '优先级调度', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CPU调度的三种基本算法：先来先服务、时间片轮转和____。 (第8组)', '优先级调度', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CPU调度的三种基本算法：先来先服务、时间片轮转和____。 (第9组)', '优先级调度', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CPU调度的三种基本算法：先来先服务、时间片轮转和____。 (第10组)', '优先级调度', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____命令用于查找文件。', 'find', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____命令用于查找文件。 (第2组)', 'find', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____命令用于查找文件。 (第3组)', 'find', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____命令用于查找文件。 (第4组)', 'find', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____命令用于查找文件。 (第5组)', 'find', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____命令用于查找文件。 (第6组)', 'find', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____命令用于查找文件。 (第7组)', 'find', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____命令用于查找文件。 (第8组)', 'find', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____命令用于查找文件。 (第9组)', 'find', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____命令用于查找文件。 (第10组)', 'find', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('操作系统的四大基本功能：进程管理、内存管理、文件管理和____管理。', '设备', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('操作系统的四大基本功能：进程管理、内存管理、文件管理和____管理。 (第2组)', '设备', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('操作系统的四大基本功能：进程管理、内存管理、文件管理和____管理。 (第3组)', '设备', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('操作系统的四大基本功能：进程管理、内存管理、文件管理和____管理。 (第4组)', '设备', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('操作系统的四大基本功能：进程管理、内存管理、文件管理和____管理。 (第5组)', '设备', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('操作系统的四大基本功能：进程管理、内存管理、文件管理和____管理。 (第6组)', '设备', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('操作系统的四大基本功能：进程管理、内存管理、文件管理和____管理。 (第7组)', '设备', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('操作系统的四大基本功能：进程管理、内存管理、文件管理和____管理。 (第8组)', '设备', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('操作系统的四大基本功能：进程管理、内存管理、文件管理和____管理。 (第9组)', '设备', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('操作系统的四大基本功能：进程管理、内存管理、文件管理和____管理。 (第10组)', '设备', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('____是操作系统将CPU时间划分成多个时间片，轮流分配给多个任务。', '时间片轮转', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('____是操作系统将CPU时间划分成多个时间片，轮流分配给多个任务。 (第2组)', '时间片轮转', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('____是操作系统将CPU时间划分成多个时间片，轮流分配给多个任务。 (第3组)', '时间片轮转', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('____是操作系统将CPU时间划分成多个时间片，轮流分配给多个任务。 (第4组)', '时间片轮转', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('____是操作系统将CPU时间划分成多个时间片，轮流分配给多个任务。 (第5组)', '时间片轮转', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('____是操作系统将CPU时间划分成多个时间片，轮流分配给多个任务。 (第6组)', '时间片轮转', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('____是操作系统将CPU时间划分成多个时间片，轮流分配给多个任务。 (第7组)', '时间片轮转', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('____是操作系统将CPU时间划分成多个时间片，轮流分配给多个任务。 (第8组)', '时间片轮转', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('____是操作系统将CPU时间划分成多个时间片，轮流分配给多个任务。 (第9组)', '时间片轮转', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('____是操作系统将CPU时间划分成多个时间片，轮流分配给多个任务。 (第10组)', '时间片轮转', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('JavaScript中，null表示____，undefined表示未定义。', '空值', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('JavaScript中，null表示____，undefined表示未定义。 (第2组)', '空值', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('JavaScript中，null表示____，undefined表示未定义。 (第3组)', '空值', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('JavaScript中，null表示____，undefined表示未定义。 (第4组)', '空值', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('JavaScript中，null表示____，undefined表示未定义。 (第5组)', '空值', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('JavaScript中，null表示____，undefined表示未定义。 (第6组)', '空值', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('JavaScript中，null表示____，undefined表示未定义。 (第7组)', '空值', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('JavaScript中，null表示____，undefined表示未定义。 (第8组)', '空值', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('JavaScript中，null表示____，undefined表示未定义。 (第9组)', '空值', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('JavaScript中，null表示____，undefined表示未定义。 (第10组)', '空值', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ES6的____语法用于声明常量。', 'const', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ES6的____语法用于声明常量。 (第2组)', 'const', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ES6的____语法用于声明常量。 (第3组)', 'const', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ES6的____语法用于声明常量。 (第4组)', 'const', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ES6的____语法用于声明常量。 (第5组)', 'const', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ES6的____语法用于声明常量。 (第6组)', 'const', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ES6的____语法用于声明常量。 (第7组)', 'const', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ES6的____语法用于声明常量。 (第8组)', 'const', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ES6的____语法用于声明常量。 (第9组)', 'const', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ES6的____语法用于声明常量。 (第10组)', 'const', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSS Flex布局中，justify-content用于设置主轴对齐，____用于设置交叉轴对齐。', 'align-items', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSS Flex布局中，justify-content用于设置主轴对齐，____用于设置交叉轴对齐。 (第2组)', 'align-items', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSS Flex布局中，justify-content用于设置主轴对齐，____用于设置交叉轴对齐。 (第3组)', 'align-items', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSS Flex布局中，justify-content用于设置主轴对齐，____用于设置交叉轴对齐。 (第4组)', 'align-items', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSS Flex布局中，justify-content用于设置主轴对齐，____用于设置交叉轴对齐。 (第5组)', 'align-items', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSS Flex布局中，justify-content用于设置主轴对齐，____用于设置交叉轴对齐。 (第6组)', 'align-items', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSS Flex布局中，justify-content用于设置主轴对齐，____用于设置交叉轴对齐。 (第7组)', 'align-items', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSS Flex布局中，justify-content用于设置主轴对齐，____用于设置交叉轴对齐。 (第8组)', 'align-items', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSS Flex布局中，justify-content用于设置主轴对齐，____用于设置交叉轴对齐。 (第9组)', 'align-items', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSS Flex布局中，justify-content用于设置主轴对齐，____用于设置交叉轴对齐。 (第10组)', 'align-items', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Vue的双向绑定基于____和数据劫持。', '响应式', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Vue的双向绑定基于____和数据劫持。 (第2组)', '响应式', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Vue的双向绑定基于____和数据劫持。 (第3组)', '响应式', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Vue的双向绑定基于____和数据劫持。 (第4组)', '响应式', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Vue的双向绑定基于____和数据劫持。 (第5组)', '响应式', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Vue的双向绑定基于____和数据劫持。 (第6组)', '响应式', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Vue的双向绑定基于____和数据劫持。 (第7组)', '响应式', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Vue的双向绑定基于____和数据劫持。 (第8组)', '响应式', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Vue的双向绑定基于____和数据劫持。 (第9组)', '响应式', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Vue的双向绑定基于____和数据劫持。 (第10组)', '响应式', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('React的useState用于在函数组件中创建____。', '状态变量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('React的useState用于在函数组件中创建____。 (第2组)', '状态变量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('React的useState用于在函数组件中创建____。 (第3组)', '状态变量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('React的useState用于在函数组件中创建____。 (第4组)', '状态变量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('React的useState用于在函数组件中创建____。 (第5组)', '状态变量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('React的useState用于在函数组件中创建____。 (第6组)', '状态变量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('React的useState用于在函数组件中创建____。 (第7组)', '状态变量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('React的useState用于在函数组件中创建____。 (第8组)', '状态变量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('React的useState用于在函数组件中创建____。 (第9组)', '状态变量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('React的useState用于在函数组件中创建____。 (第10组)', '状态变量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Promise有三种状态：pending、fulfilled和____。', 'rejected', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Promise有三种状态：pending、fulfilled和____。 (第2组)', 'rejected', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Promise有三种状态：pending、fulfilled和____。 (第3组)', 'rejected', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Promise有三种状态：pending、fulfilled和____。 (第4组)', 'rejected', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Promise有三种状态：pending、fulfilled和____。 (第5组)', 'rejected', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Promise有三种状态：pending、fulfilled和____。 (第6组)', 'rejected', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Promise有三种状态：pending、fulfilled和____。 (第7组)', 'rejected', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Promise有三种状态：pending、fulfilled和____。 (第8组)', 'rejected', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Promise有三种状态：pending、fulfilled和____。 (第9组)', 'rejected', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Promise有三种状态：pending、fulfilled和____。 (第10组)', 'rejected', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSS的____属性用于设置元素在主轴上的增长因子。', 'flex-grow', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSS的____属性用于设置元素在主轴上的增长因子。 (第2组)', 'flex-grow', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSS的____属性用于设置元素在主轴上的增长因子。 (第3组)', 'flex-grow', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSS的____属性用于设置元素在主轴上的增长因子。 (第4组)', 'flex-grow', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSS的____属性用于设置元素在主轴上的增长因子。 (第5组)', 'flex-grow', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSS的____属性用于设置元素在主轴上的增长因子。 (第6组)', 'flex-grow', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSS的____属性用于设置元素在主轴上的增长因子。 (第7组)', 'flex-grow', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSS的____属性用于设置元素在主轴上的增长因子。 (第8组)', 'flex-grow', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSS的____属性用于设置元素在主轴上的增长因子。 (第9组)', 'flex-grow', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSS的____属性用于设置元素在主轴上的增长因子。 (第10组)', 'flex-grow', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTML5新增的语义化标签包括：article、section、nav和____。', 'header', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTML5新增的语义化标签包括：article、section、nav和____。 (第2组)', 'header', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTML5新增的语义化标签包括：article、section、nav和____。 (第3组)', 'header', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTML5新增的语义化标签包括：article、section、nav和____。 (第4组)', 'header', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTML5新增的语义化标签包括：article、section、nav和____。 (第5组)', 'header', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTML5新增的语义化标签包括：article、section、nav和____。 (第6组)', 'header', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTML5新增的语义化标签包括：article、section、nav和____。 (第7组)', 'header', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTML5新增的语义化标签包括：article、section、nav和____。 (第8组)', 'header', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTML5新增的语义化标签包括：article、section、nav和____。 (第9组)', 'header', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTML5新增的语义化标签包括：article、section、nav和____。 (第10组)', 'header', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('____是浏览器的一个安全机制，限制不同源之间的资源访问。', '同源策略', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('____是浏览器的一个安全机制，限制不同源之间的资源访问。 (第2组)', '同源策略', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('____是浏览器的一个安全机制，限制不同源之间的资源访问。 (第3组)', '同源策略', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('____是浏览器的一个安全机制，限制不同源之间的资源访问。 (第4组)', '同源策略', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('____是浏览器的一个安全机制，限制不同源之间的资源访问。 (第5组)', '同源策略', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('____是浏览器的一个安全机制，限制不同源之间的资源访问。 (第6组)', '同源策略', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('____是浏览器的一个安全机制，限制不同源之间的资源访问。 (第7组)', '同源策略', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('____是浏览器的一个安全机制，限制不同源之间的资源访问。 (第8组)', '同源策略', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('____是浏览器的一个安全机制，限制不同源之间的资源访问。 (第9组)', '同源策略', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('____是浏览器的一个安全机制，限制不同源之间的资源访问。 (第10组)', '同源策略', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP请求中，____头用于传递CSRF Token。', 'X-CSRF-Token', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP请求中，____头用于传递CSRF Token。 (第2组)', 'X-CSRF-Token', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP请求中，____头用于传递CSRF Token。 (第3组)', 'X-CSRF-Token', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP请求中，____头用于传递CSRF Token。 (第4组)', 'X-CSRF-Token', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP请求中，____头用于传递CSRF Token。 (第5组)', 'X-CSRF-Token', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP请求中，____头用于传递CSRF Token。 (第6组)', 'X-CSRF-Token', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP请求中，____头用于传递CSRF Token。 (第7组)', 'X-CSRF-Token', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP请求中，____头用于传递CSRF Token。 (第8组)', 'X-CSRF-Token', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP请求中，____头用于传递CSRF Token。 (第9组)', 'X-CSRF-Token', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP请求中，____头用于传递CSRF Token。 (第10组)', 'X-CSRF-Token', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker的核心组件包括：Docker daemon、Client、____和Container。', 'Image', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker的核心组件包括：Docker daemon、Client、____和Container。 (第2组)', 'Image', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker的核心组件包括：Docker daemon、Client、____和Container。 (第3组)', 'Image', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker的核心组件包括：Docker daemon、Client、____和Container。 (第4组)', 'Image', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker的核心组件包括：Docker daemon、Client、____和Container。 (第5组)', 'Image', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker的核心组件包括：Docker daemon、Client、____和Container。 (第6组)', 'Image', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker的核心组件包括：Docker daemon、Client、____和Container。 (第7组)', 'Image', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker的核心组件包括：Docker daemon、Client、____和Container。 (第8组)', 'Image', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker的核心组件包括：Docker daemon、Client、____和Container。 (第9组)', 'Image', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker的核心组件包括：Docker daemon、Client、____和Container。 (第10组)', 'Image', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('K8s中，Pod是最小的____单位。', '调度', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('K8s中，Pod是最小的____单位。 (第2组)', '调度', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('K8s中，Pod是最小的____单位。 (第3组)', '调度', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('K8s中，Pod是最小的____单位。 (第4组)', '调度', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('K8s中，Pod是最小的____单位。 (第5组)', '调度', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('K8s中，Pod是最小的____单位。 (第6组)', '调度', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('K8s中，Pod是最小的____单位。 (第7组)', '调度', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('K8s中，Pod是最小的____单位。 (第8组)', '调度', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('K8s中，Pod是最小的____单位。 (第9组)', '调度', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('K8s中，Pod是最小的____单位。 (第10组)', '调度', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Git中，____命令用于将文件添加到暂存区。', 'git add', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Git中，____命令用于将文件添加到暂存区。 (第2组)', 'git add', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Git中，____命令用于将文件添加到暂存区。 (第3组)', 'git add', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Git中，____命令用于将文件添加到暂存区。 (第4组)', 'git add', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Git中，____命令用于将文件添加到暂存区。 (第5组)', 'git add', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Git中，____命令用于将文件添加到暂存区。 (第6组)', 'git add', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Git中，____命令用于将文件添加到暂存区。 (第7组)', 'git add', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Git中，____命令用于将文件添加到暂存区。 (第8组)', 'git add', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Git中，____命令用于将文件添加到暂存区。 (第9组)', 'git add', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Git中，____命令用于将文件添加到暂存区。 (第10组)', 'git add', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Git中，____命令用于创建分支。', 'git branch', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Git中，____命令用于创建分支。 (第2组)', 'git branch', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Git中，____命令用于创建分支。 (第3组)', 'git branch', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Git中，____命令用于创建分支。 (第4组)', 'git branch', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Git中，____命令用于创建分支。 (第5组)', 'git branch', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Git中，____命令用于创建分支。 (第6组)', 'git branch', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Git中，____命令用于创建分支。 (第7组)', 'git branch', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Git中，____命令用于创建分支。 (第8组)', 'git branch', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Git中，____命令用于创建分支。 (第9组)', 'git branch', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Git中，____命令用于创建分支。 (第10组)', 'git branch', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CI/CD中，CI指持续____，CD指持续____。', '集成|部署', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CI/CD中，CI指持续____，CD指持续____。 (第2组)', '集成|部署', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CI/CD中，CI指持续____，CD指持续____。 (第3组)', '集成|部署', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CI/CD中，CI指持续____，CD指持续____。 (第4组)', '集成|部署', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CI/CD中，CI指持续____，CD指持续____。 (第5组)', '集成|部署', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CI/CD中，CI指持续____，CD指持续____。 (第6组)', '集成|部署', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CI/CD中，CI指持续____，CD指持续____。 (第7组)', '集成|部署', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CI/CD中，CI指持续____，CD指持续____。 (第8组)', '集成|部署', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CI/CD中，CI指持续____，CD指持续____。 (第9组)', '集成|部署', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CI/CD中，CI指持续____，CD指持续____。 (第10组)', '集成|部署', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Dockerfile的____指令用于声明容器监听的端口。', 'EXPOSE', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Dockerfile的____指令用于声明容器监听的端口。 (第2组)', 'EXPOSE', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Dockerfile的____指令用于声明容器监听的端口。 (第3组)', 'EXPOSE', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Dockerfile的____指令用于声明容器监听的端口。 (第4组)', 'EXPOSE', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Dockerfile的____指令用于声明容器监听的端口。 (第5组)', 'EXPOSE', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Dockerfile的____指令用于声明容器监听的端口。 (第6组)', 'EXPOSE', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Dockerfile的____指令用于声明容器监听的端口。 (第7组)', 'EXPOSE', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Dockerfile的____指令用于声明容器监听的端口。 (第8组)', 'EXPOSE', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Dockerfile的____指令用于声明容器监听的端口。 (第9组)', 'EXPOSE', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Dockerfile的____指令用于声明容器监听的端口。 (第10组)', 'EXPOSE', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('K8s中，____用于服务发现和负载均衡。', 'Service', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('K8s中，____用于服务发现和负载均衡。 (第2组)', 'Service', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('K8s中，____用于服务发现和负载均衡。 (第3组)', 'Service', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('K8s中，____用于服务发现和负载均衡。 (第4组)', 'Service', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('K8s中，____用于服务发现和负载均衡。 (第5组)', 'Service', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('K8s中，____用于服务发现和负载均衡。 (第6组)', 'Service', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('K8s中，____用于服务发现和负载均衡。 (第7组)', 'Service', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('K8s中，____用于服务发现和负载均衡。 (第8组)', 'Service', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('K8s中，____用于服务发现和负载均衡。 (第9组)', 'Service', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('K8s中，____用于服务发现和负载均衡。 (第10组)', 'Service', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker网络模式包括：bridge、host、none和____。', 'container', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker网络模式包括：bridge、host、none和____。 (第2组)', 'container', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker网络模式包括：bridge、host、none和____。 (第3组)', 'container', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker网络模式包括：bridge、host、none和____。 (第4组)', 'container', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker网络模式包括：bridge、host、none和____。 (第5组)', 'container', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker网络模式包括：bridge、host、none和____。 (第6组)', 'container', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker网络模式包括：bridge、host、none和____。 (第7组)', 'container', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker网络模式包括：bridge、host、none和____。 (第8组)', 'container', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker网络模式包括：bridge、host、none和____。 (第9组)', 'container', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker网络模式包括：bridge、host、none和____。 (第10组)', 'container', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Helm是K8s的____管理器。', '包', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Helm是K8s的____管理器。 (第2组)', '包', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Helm是K8s的____管理器。 (第3组)', '包', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Helm是K8s的____管理器。 (第4组)', '包', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Helm是K8s的____管理器。 (第5组)', '包', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Helm是K8s的____管理器。 (第6组)', '包', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Helm是K8s的____管理器。 (第7组)', '包', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Helm是K8s的____管理器。 (第8组)', '包', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Helm是K8s的____管理器。 (第9组)', '包', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Helm是K8s的____管理器。 (第10组)', '包', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker使用____技术实现资源隔离。', '容器或namespace', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker使用____技术实现资源隔离。 (第2组)', '容器或namespace', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker使用____技术实现资源隔离。 (第3组)', '容器或namespace', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker使用____技术实现资源隔离。 (第4组)', '容器或namespace', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker使用____技术实现资源隔离。 (第5组)', '容器或namespace', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker使用____技术实现资源隔离。 (第6组)', '容器或namespace', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker使用____技术实现资源隔离。 (第7组)', '容器或namespace', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker使用____技术实现资源隔离。 (第8组)', '容器或namespace', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker使用____技术实现资源隔离。 (第9组)', '容器或namespace', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker使用____技术实现资源隔离。 (第10组)', '容器或namespace', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('对称加密和非对称加密的主要区别是密钥____数量不同。', '使用', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('对称加密和非对称加密的主要区别是密钥____数量不同。 (第2组)', '使用', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('对称加密和非对称加密的主要区别是密钥____数量不同。 (第3组)', '使用', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('对称加密和非对称加密的主要区别是密钥____数量不同。 (第4组)', '使用', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('对称加密和非对称加密的主要区别是密钥____数量不同。 (第5组)', '使用', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('对称加密和非对称加密的主要区别是密钥____数量不同。 (第6组)', '使用', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('对称加密和非对称加密的主要区别是密钥____数量不同。 (第7组)', '使用', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('对称加密和非对称加密的主要区别是密钥____数量不同。 (第8组)', '使用', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('对称加密和非对称加密的主要区别是密钥____数量不同。 (第9组)', '使用', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('对称加密和非对称加密的主要区别是密钥____数量不同。 (第10组)', '使用', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数字签名用于验证消息的完整性和____身份。', '发送者', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数字签名用于验证消息的完整性和____身份。 (第2组)', '发送者', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数字签名用于验证消息的完整性和____身份。 (第3组)', '发送者', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数字签名用于验证消息的完整性和____身份。 (第4组)', '发送者', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数字签名用于验证消息的完整性和____身份。 (第5组)', '发送者', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数字签名用于验证消息的完整性和____身份。 (第6组)', '发送者', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数字签名用于验证消息的完整性和____身份。 (第7组)', '发送者', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数字签名用于验证消息的完整性和____身份。 (第8组)', '发送者', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数字签名用于验证消息的完整性和____身份。 (第9组)', '发送者', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数字签名用于验证消息的完整性和____身份。 (第10组)', '发送者', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('哈希函数具有单向性、确定性和____效应。', '雪崩', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('哈希函数具有单向性、确定性和____效应。 (第2组)', '雪崩', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('哈希函数具有单向性、确定性和____效应。 (第3组)', '雪崩', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('哈希函数具有单向性、确定性和____效应。 (第4组)', '雪崩', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('哈希函数具有单向性、确定性和____效应。 (第5组)', '雪崩', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('哈希函数具有单向性、确定性和____效应。 (第6组)', '雪崩', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('哈希函数具有单向性、确定性和____效应。 (第7组)', '雪崩', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('哈希函数具有单向性、确定性和____效应。 (第8组)', '雪崩', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('哈希函数具有单向性、确定性和____效应。 (第9组)', '雪崩', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('哈希函数具有单向性、确定性和____效应。 (第10组)', '雪崩', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('AES是____加密算法。', '对称或分组', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('AES是____加密算法。 (第2组)', '对称或分组', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('AES是____加密算法。 (第3组)', '对称或分组', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('AES是____加密算法。 (第4组)', '对称或分组', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('AES是____加密算法。 (第5组)', '对称或分组', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('AES是____加密算法。 (第6组)', '对称或分组', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('AES是____加密算法。 (第7组)', '对称或分组', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('AES是____加密算法。 (第8组)', '对称或分组', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('AES是____加密算法。 (第9组)', '对称或分组', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('AES是____加密算法。 (第10组)', '对称或分组', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('PKI体系的核心是____。', '数字证书', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('PKI体系的核心是____。 (第2组)', '数字证书', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('PKI体系的核心是____。 (第3组)', '数字证书', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('PKI体系的核心是____。 (第4组)', '数字证书', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('PKI体系的核心是____。 (第5组)', '数字证书', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('PKI体系的核心是____。 (第6组)', '数字证书', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('PKI体系的核心是____。 (第7组)', '数字证书', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('PKI体系的核心是____。 (第8组)', '数字证书', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('PKI体系的核心是____。 (第9组)', '数字证书', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('PKI体系的核心是____。 (第10组)', '数字证书', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS混合加密：非对称加密用于密钥交换，____加密用于数据传输。', '对称', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS混合加密：非对称加密用于密钥交换，____加密用于数据传输。 (第2组)', '对称', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS混合加密：非对称加密用于密钥交换，____加密用于数据传输。 (第3组)', '对称', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS混合加密：非对称加密用于密钥交换，____加密用于数据传输。 (第4组)', '对称', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS混合加密：非对称加密用于密钥交换，____加密用于数据传输。 (第5组)', '对称', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS混合加密：非对称加密用于密钥交换，____加密用于数据传输。 (第6组)', '对称', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS混合加密：非对称加密用于密钥交换，____加密用于数据传输。 (第7组)', '对称', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS混合加密：非对称加密用于密钥交换，____加密用于数据传输。 (第8组)', '对称', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS混合加密：非对称加密用于密钥交换，____加密用于数据传输。 (第9组)', '对称', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS混合加密：非对称加密用于密钥交换，____加密用于数据传输。 (第10组)', '对称', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('密码存储应使用加盐的专用哈希算法，如BCrypt、____和Argon2。', 'PBKDF2', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('密码存储应使用加盐的专用哈希算法，如BCrypt、____和Argon2。 (第2组)', 'PBKDF2', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('密码存储应使用加盐的专用哈希算法，如BCrypt、____和Argon2。 (第3组)', 'PBKDF2', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('密码存储应使用加盐的专用哈希算法，如BCrypt、____和Argon2。 (第4组)', 'PBKDF2', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('密码存储应使用加盐的专用哈希算法，如BCrypt、____和Argon2。 (第5组)', 'PBKDF2', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('密码存储应使用加盐的专用哈希算法，如BCrypt、____和Argon2。 (第6组)', 'PBKDF2', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('密码存储应使用加盐的专用哈希算法，如BCrypt、____和Argon2。 (第7组)', 'PBKDF2', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('密码存储应使用加盐的专用哈希算法，如BCrypt、____和Argon2。 (第8组)', 'PBKDF2', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('密码存储应使用加盐的专用哈希算法，如BCrypt、____和Argon2。 (第9组)', 'PBKDF2', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('密码存储应使用加盐的专用哈希算法，如BCrypt、____和Argon2。 (第10组)', 'PBKDF2', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数字信封用对称密钥加密数据，用接收方的____加密对称密钥。', '公钥', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数字信封用对称密钥加密数据，用接收方的____加密对称密钥。 (第2组)', '公钥', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数字信封用对称密钥加密数据，用接收方的____加密对称密钥。 (第3组)', '公钥', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数字信封用对称密钥加密数据，用接收方的____加密对称密钥。 (第4组)', '公钥', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数字信封用对称密钥加密数据，用接收方的____加密对称密钥。 (第5组)', '公钥', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数字信封用对称密钥加密数据，用接收方的____加密对称密钥。 (第6组)', '公钥', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数字信封用对称密钥加密数据，用接收方的____加密对称密钥。 (第7组)', '公钥', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数字信封用对称密钥加密数据，用接收方的____加密对称密钥。 (第8组)', '公钥', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数字信封用对称密钥加密数据，用接收方的____加密对称密钥。 (第9组)', '公钥', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数字信封用对称密钥加密数据，用接收方的____加密对称密钥。 (第10组)', '公钥', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('RSA算法的安全性基于大数____的困难性。', '分解', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('RSA算法的安全性基于大数____的困难性。 (第2组)', '分解', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('RSA算法的安全性基于大数____的困难性。 (第3组)', '分解', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('RSA算法的安全性基于大数____的困难性。 (第4组)', '分解', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('RSA算法的安全性基于大数____的困难性。 (第5组)', '分解', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('RSA算法的安全性基于大数____的困难性。 (第6组)', '分解', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('RSA算法的安全性基于大数____的困难性。 (第7组)', '分解', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('RSA算法的安全性基于大数____的困难性。 (第8组)', '分解', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('RSA算法的安全性基于大数____的困难性。 (第9组)', '分解', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('RSA算法的安全性基于大数____的困难性。 (第10组)', '分解', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('____是加密和解密使用同一密钥的加密方式。', '对称加密', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('____是加密和解密使用同一密钥的加密方式。 (第2组)', '对称加密', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('____是加密和解密使用同一密钥的加密方式。 (第3组)', '对称加密', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('____是加密和解密使用同一密钥的加密方式。 (第4组)', '对称加密', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('____是加密和解密使用同一密钥的加密方式。 (第5组)', '对称加密', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('____是加密和解密使用同一密钥的加密方式。 (第6组)', '对称加密', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('____是加密和解密使用同一密钥的加密方式。 (第7组)', '对称加密', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('____是加密和解密使用同一密钥的加密方式。 (第8组)', '对称加密', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('____是加密和解密使用同一密钥的加密方式。 (第9组)', '对称加密', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('____是加密和解密使用同一密钥的加密方式。 (第10组)', '对称加密', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('测试金字塔：底层是____测试，中层是集成测试，顶层是E2E测试。', '单元', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('测试金字塔：底层是____测试，中层是集成测试，顶层是E2E测试。 (第2组)', '单元', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('测试金字塔：底层是____测试，中层是集成测试，顶层是E2E测试。 (第3组)', '单元', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('测试金字塔：底层是____测试，中层是集成测试，顶层是E2E测试。 (第4组)', '单元', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('测试金字塔：底层是____测试，中层是集成测试，顶层是E2E测试。 (第5组)', '单元', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('测试金字塔：底层是____测试，中层是集成测试，顶层是E2E测试。 (第6组)', '单元', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('测试金字塔：底层是____测试，中层是集成测试，顶层是E2E测试。 (第7组)', '单元', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('测试金字塔：底层是____测试，中层是集成测试，顶层是E2E测试。 (第8组)', '单元', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('测试金字塔：底层是____测试，中层是集成测试，顶层是E2E测试。 (第9组)', '单元', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('测试金字塔：底层是____测试，中层是集成测试，顶层是E2E测试。 (第10组)', '单元', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('黑盒测试关注功能，不关注内部____。', '实现', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('黑盒测试关注功能，不关注内部____。 (第2组)', '实现', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('黑盒测试关注功能，不关注内部____。 (第3组)', '实现', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('黑盒测试关注功能，不关注内部____。 (第4组)', '实现', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('黑盒测试关注功能，不关注内部____。 (第5组)', '实现', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('黑盒测试关注功能，不关注内部____。 (第6组)', '实现', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('黑盒测试关注功能，不关注内部____。 (第7组)', '实现', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('黑盒测试关注功能，不关注内部____。 (第8组)', '实现', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('黑盒测试关注功能，不关注内部____。 (第9组)', '实现', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('黑盒测试关注功能，不关注内部____。 (第10组)', '实现', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('单元测试应遵循AIR原则：Automatic、Independent、____。', 'Repeatable', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('单元测试应遵循AIR原则：Automatic、Independent、____。 (第2组)', 'Repeatable', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('单元测试应遵循AIR原则：Automatic、Independent、____。 (第3组)', 'Repeatable', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('单元测试应遵循AIR原则：Automatic、Independent、____。 (第4组)', 'Repeatable', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('单元测试应遵循AIR原则：Automatic、Independent、____。 (第5组)', 'Repeatable', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('单元测试应遵循AIR原则：Automatic、Independent、____。 (第6组)', 'Repeatable', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('单元测试应遵循AIR原则：Automatic、Independent、____。 (第7组)', 'Repeatable', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('单元测试应遵循AIR原则：Automatic、Independent、____。 (第8组)', 'Repeatable', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('单元测试应遵循AIR原则：Automatic、Independent、____。 (第9组)', 'Repeatable', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('单元测试应遵循AIR原则：Automatic、Independent、____。 (第10组)', 'Repeatable', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('代码覆盖率包括语句覆盖、分支覆盖和____覆盖。', '条件', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('代码覆盖率包括语句覆盖、分支覆盖和____覆盖。 (第2组)', '条件', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('代码覆盖率包括语句覆盖、分支覆盖和____覆盖。 (第3组)', '条件', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('代码覆盖率包括语句覆盖、分支覆盖和____覆盖。 (第4组)', '条件', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('代码覆盖率包括语句覆盖、分支覆盖和____覆盖。 (第5组)', '条件', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('代码覆盖率包括语句覆盖、分支覆盖和____覆盖。 (第6组)', '条件', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('代码覆盖率包括语句覆盖、分支覆盖和____覆盖。 (第7组)', '条件', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('代码覆盖率包括语句覆盖、分支覆盖和____覆盖。 (第8组)', '条件', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('代码覆盖率包括语句覆盖、分支覆盖和____覆盖。 (第9组)', '条件', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('代码覆盖率包括语句覆盖、分支覆盖和____覆盖。 (第10组)', '条件', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('回归测试确保代码修改没有破坏____功能。', '现有', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('回归测试确保代码修改没有破坏____功能。 (第2组)', '现有', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('回归测试确保代码修改没有破坏____功能。 (第3组)', '现有', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('回归测试确保代码修改没有破坏____功能。 (第4组)', '现有', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('回归测试确保代码修改没有破坏____功能。 (第5组)', '现有', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('回归测试确保代码修改没有破坏____功能。 (第6组)', '现有', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('回归测试确保代码修改没有破坏____功能。 (第7组)', '现有', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('回归测试确保代码修改没有破坏____功能。 (第8组)', '现有', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('回归测试确保代码修改没有破坏____功能。 (第9组)', '现有', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('回归测试确保代码修改没有破坏____功能。 (第10组)', '现有', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('自动化测试的优势：提高效率、可重复执行、覆盖率高和____性好。', '一致', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('自动化测试的优势：提高效率、可重复执行、覆盖率高和____性好。 (第2组)', '一致', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('自动化测试的优势：提高效率、可重复执行、覆盖率高和____性好。 (第3组)', '一致', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('自动化测试的优势：提高效率、可重复执行、覆盖率高和____性好。 (第4组)', '一致', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('自动化测试的优势：提高效率、可重复执行、覆盖率高和____性好。 (第5组)', '一致', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('自动化测试的优势：提高效率、可重复执行、覆盖率高和____性好。 (第6组)', '一致', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('自动化测试的优势：提高效率、可重复执行、覆盖率高和____性好。 (第7组)', '一致', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('自动化测试的优势：提高效率、可重复执行、覆盖率高和____性好。 (第8组)', '一致', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('自动化测试的优势：提高效率、可重复执行、覆盖率高和____性好。 (第9组)', '一致', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('自动化测试的优势：提高效率、可重复执行、覆盖率高和____性好。 (第10组)', '一致', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('冒烟测试快速验证____功能是否正常。', '核心', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('冒烟测试快速验证____功能是否正常。 (第2组)', '核心', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('冒烟测试快速验证____功能是否正常。 (第3组)', '核心', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('冒烟测试快速验证____功能是否正常。 (第4组)', '核心', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('冒烟测试快速验证____功能是否正常。 (第5组)', '核心', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('冒烟测试快速验证____功能是否正常。 (第6组)', '核心', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('冒烟测试快速验证____功能是否正常。 (第7组)', '核心', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('冒烟测试快速验证____功能是否正常。 (第8组)', '核心', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('冒烟测试快速验证____功能是否正常。 (第9组)', '核心', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('冒烟测试快速验证____功能是否正常。 (第10组)', '核心', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('集成测试的策略包括：自顶向下、自底向上和____。', '三明治', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('集成测试的策略包括：自顶向下、自底向上和____。 (第2组)', '三明治', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('集成测试的策略包括：自顶向下、自底向上和____。 (第3组)', '三明治', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('集成测试的策略包括：自顶向下、自底向上和____。 (第4组)', '三明治', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('集成测试的策略包括：自顶向下、自底向上和____。 (第5组)', '三明治', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('集成测试的策略包括：自顶向下、自底向上和____。 (第6组)', '三明治', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('集成测试的策略包括：自顶向下、自底向上和____。 (第7组)', '三明治', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('集成测试的策略包括：自顶向下、自底向上和____。 (第8组)', '三明治', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('集成测试的策略包括：自顶向下、自底向上和____。 (第9组)', '三明治', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('集成测试的策略包括：自顶向下、自底向上和____。 (第10组)', '三明治', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('验收测试确认系统满足业务____和用户期望。', '需求', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('验收测试确认系统满足业务____和用户期望。 (第2组)', '需求', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('验收测试确认系统满足业务____和用户期望。 (第3组)', '需求', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('验收测试确认系统满足业务____和用户期望。 (第4组)', '需求', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('验收测试确认系统满足业务____和用户期望。 (第5组)', '需求', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('验收测试确认系统满足业务____和用户期望。 (第6组)', '需求', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('验收测试确认系统满足业务____和用户期望。 (第7组)', '需求', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('验收测试确认系统满足业务____和用户期望。 (第8组)', '需求', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('验收测试确认系统满足业务____和用户期望。 (第9组)', '需求', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('验收测试确认系统满足业务____和用户期望。 (第10组)', '需求', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('测试用例包含：测试目标、输入数据、操作步骤和____结果。', '预期', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('测试用例包含：测试目标、输入数据、操作步骤和____结果。 (第2组)', '预期', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('测试用例包含：测试目标、输入数据、操作步骤和____结果。 (第3组)', '预期', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('测试用例包含：测试目标、输入数据、操作步骤和____结果。 (第4组)', '预期', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('测试用例包含：测试目标、输入数据、操作步骤和____结果。 (第5组)', '预期', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('测试用例包含：测试目标、输入数据、操作步骤和____结果。 (第6组)', '预期', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('测试用例包含：测试目标、输入数据、操作步骤和____结果。 (第7组)', '预期', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('测试用例包含：测试目标、输入数据、操作步骤和____结果。 (第8组)', '预期', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('测试用例包含：测试目标、输入数据、操作步骤和____结果。 (第9组)', '预期', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('测试用例包含：测试目标、输入数据、操作步骤和____结果。 (第10组)', '预期', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('GDPR的中文名称是____。', '通用数据保护条例', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('GDPR的中文名称是____。 (第2组)', '通用数据保护条例', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('GDPR的中文名称是____。 (第3组)', '通用数据保护条例', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('GDPR的中文名称是____。 (第4组)', '通用数据保护条例', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('GDPR的中文名称是____。 (第5组)', '通用数据保护条例', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('GDPR的中文名称是____。 (第6组)', '通用数据保护条例', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('GDPR的中文名称是____。 (第7组)', '通用数据保护条例', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('GDPR的中文名称是____。 (第8组)', '通用数据保护条例', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('GDPR的中文名称是____。 (第9组)', '通用数据保护条例', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('GDPR的中文名称是____。 (第10组)', '通用数据保护条例', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('个人信息保护原则：合法、正当、____。', '必要', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('个人信息保护原则：合法、正当、____。 (第2组)', '必要', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('个人信息保护原则：合法、正当、____。 (第3组)', '必要', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('个人信息保护原则：合法、正当、____。 (第4组)', '必要', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('个人信息保护原则：合法、正当、____。 (第5组)', '必要', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('个人信息保护原则：合法、正当、____。 (第6组)', '必要', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('个人信息保护原则：合法、正当、____。 (第7组)', '必要', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('个人信息保护原则：合法、正当、____。 (第8组)', '必要', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('个人信息保护原则：合法、正当、____。 (第9组)', '必要', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('个人信息保护原则：合法、正当、____。 (第10组)', '必要', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('等保测评分为____级。', '五', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('等保测评分为____级。 (第2组)', '五', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('等保测评分为____级。 (第3组)', '五', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('等保测评分为____级。 (第4组)', '五', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('等保测评分为____级。 (第5组)', '五', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('等保测评分为____级。 (第6组)', '五', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('等保测评分为____级。 (第7组)', '五', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('等保测评分为____级。 (第8组)', '五', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('等保测评分为____级。 (第9组)', '五', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('等保测评分为____级。 (第10组)', '五', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据分类分级用于____化保护。', '差异', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据分类分级用于____化保护。 (第2组)', '差异', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据分类分级用于____化保护。 (第3组)', '差异', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据分类分级用于____化保护。 (第4组)', '差异', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据分类分级用于____化保护。 (第5组)', '差异', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据分类分级用于____化保护。 (第6组)', '差异', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据分类分级用于____化保护。 (第7组)', '差异', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据分类分级用于____化保护。 (第8组)', '差异', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据分类分级用于____化保护。 (第9组)', '差异', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据分类分级用于____化保护。 (第10组)', '差异', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('被遗忘权允许数据主体要求____其个人数据。', '删除', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('被遗忘权允许数据主体要求____其个人数据。 (第2组)', '删除', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('被遗忘权允许数据主体要求____其个人数据。 (第3组)', '删除', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('被遗忘权允许数据主体要求____其个人数据。 (第4组)', '删除', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('被遗忘权允许数据主体要求____其个人数据。 (第5组)', '删除', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('被遗忘权允许数据主体要求____其个人数据。 (第6组)', '删除', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('被遗忘权允许数据主体要求____其个人数据。 (第7组)', '删除', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('被遗忘权允许数据主体要求____其个人数据。 (第8组)', '删除', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('被遗忘权允许数据主体要求____其个人数据。 (第9组)', '删除', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('被遗忘权允许数据主体要求____其个人数据。 (第10组)', '删除', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CCPA是美国____州的消费者隐私法案。', '加州', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CCPA是美国____州的消费者隐私法案。 (第2组)', '加州', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CCPA是美国____州的消费者隐私法案。 (第3组)', '加州', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CCPA是美国____州的消费者隐私法案。 (第4组)', '加州', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CCPA是美国____州的消费者隐私法案。 (第5组)', '加州', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CCPA是美国____州的消费者隐私法案。 (第6组)', '加州', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CCPA是美国____州的消费者隐私法案。 (第7组)', '加州', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CCPA是美国____州的消费者隐私法案。 (第8组)', '加州', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CCPA是美国____州的消费者隐私法案。 (第9组)', '加州', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CCPA是美国____州的消费者隐私法案。 (第10组)', '加州', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('隐私影响评估用于评估____风险。', '隐私', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('隐私影响评估用于评估____风险。 (第2组)', '隐私', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('隐私影响评估用于评估____风险。 (第3组)', '隐私', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('隐私影响评估用于评估____风险。 (第4组)', '隐私', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('隐私影响评估用于评估____风险。 (第5组)', '隐私', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('隐私影响评估用于评估____风险。 (第6组)', '隐私', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('隐私影响评估用于评估____风险。 (第7组)', '隐私', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('隐私影响评估用于评估____风险。 (第8组)', '隐私', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('隐私影响评估用于评估____风险。 (第9组)', '隐私', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('隐私影响评估用于评估____风险。 (第10组)', '隐私', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据泄露应急响应：遏制→评估→____→调查→修复。', '通知', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据泄露应急响应：遏制→评估→____→调查→修复。 (第2组)', '通知', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据泄露应急响应：遏制→评估→____→调查→修复。 (第3组)', '通知', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据泄露应急响应：遏制→评估→____→调查→修复。 (第4组)', '通知', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据泄露应急响应：遏制→评估→____→调查→修复。 (第5组)', '通知', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据泄露应急响应：遏制→评估→____→调查→修复。 (第6组)', '通知', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据泄露应急响应：遏制→评估→____→调查→修复。 (第7组)', '通知', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据泄露应急响应：遏制→评估→____→调查→修复。 (第8组)', '通知', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据泄露应急响应：遏制→评估→____→调查→修复。 (第9组)', '通知', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据泄露应急响应：遏制→评估→____→调查→修复。 (第10组)', '通知', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('最小权限原则只授予完成任务所需的____权限。', '最小', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('最小权限原则只授予完成任务所需的____权限。 (第2组)', '最小', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('最小权限原则只授予完成任务所需的____权限。 (第3组)', '最小', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('最小权限原则只授予完成任务所需的____权限。 (第4组)', '最小', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('最小权限原则只授予完成任务所需的____权限。 (第5组)', '最小', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('最小权限原则只授予完成任务所需的____权限。 (第6组)', '最小', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('最小权限原则只授予完成任务所需的____权限。 (第7组)', '最小', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('最小权限原则只授予完成任务所需的____权限。 (第8组)', '最小', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('最小权限原则只授予完成任务所需的____权限。 (第9组)', '最小', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('最小权限原则只授予完成任务所需的____权限。 (第10组)', '最小', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('日志审计用于发现安全事件、追踪问题和满足____要求。', '合规', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('日志审计用于发现安全事件、追踪问题和满足____要求。 (第2组)', '合规', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('日志审计用于发现安全事件、追踪问题和满足____要求。 (第3组)', '合规', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('日志审计用于发现安全事件、追踪问题和满足____要求。 (第4组)', '合规', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('日志审计用于发现安全事件、追踪问题和满足____要求。 (第5组)', '合规', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('日志审计用于发现安全事件、追踪问题和满足____要求。 (第6组)', '合规', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('日志审计用于发现安全事件、追踪问题和满足____要求。 (第7组)', '合规', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('日志审计用于发现安全事件、追踪问题和满足____要求。 (第8组)', '合规', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('日志审计用于发现安全事件、追踪问题和满足____要求。 (第9组)', '合规', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('日志审计用于发现安全事件、追踪问题和满足____要求。 (第10组)', '合规', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Java的基本数据类型？', 'A,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'byte、short、int、long、float、double、char、boolean', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Java的基本数据类型？ (第2组)', 'A,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'byte、short、int、long、float、double、char、boolean', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Java的基本数据类型？ (第3组)', 'A,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'byte、short、int、long、float、double、char、boolean', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些修饰符可以修饰类？', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'public、abstract、final', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些修饰符可以修饰类？ (第2组)', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'public、abstract、final', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些修饰符可以修饰类？ (第3组)', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'public、abstract、final', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是创建线程的方式？', 'A,B,C,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '继承Thread、实现Runnable、实现Callable、线程池', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是创建线程的方式？ (第2组)', 'A,B,C,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '继承Thread、实现Runnable、实现Callable、线程池', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是创建线程的方式？ (第3组)', 'A,B,C,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '继承Thread、实现Runnable、实现Callable、线程池', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Collection接口的方法？', 'A,B,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'add、remove、size、clear', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Collection接口的方法？ (第2组)', 'A,B,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'add、remove、size、clear', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Collection接口的方法？ (第3组)', 'A,B,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'add、remove、size、clear', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是fail-fast的特性？', 'A,B,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'ArrayList、HashMap、Vector的迭代器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是fail-fast的特性？ (第2组)', 'A,B,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'ArrayList、HashMap、Vector的迭代器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是fail-fast的特性？ (第3组)', 'A,B,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'ArrayList、HashMap、Vector的迭代器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是SOLID原则的内容？', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '单一职责、开闭、里氏替换、接口隔离、依赖倒置', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是SOLID原则的内容？ (第2组)', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '单一职责、开闭、里氏替换、接口隔离、依赖倒置', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是SOLID原则的内容？ (第3组)', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '单一职责、开闭、里氏替换、接口隔离、依赖倒置', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些可以有效防御SQL注入？', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '参数化查询、输入验证、ORM框架、最小权限、错误处理', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些可以有效防御SQL注入？ (第2组)', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '参数化查询、输入验证、ORM框架、最小权限、错误处理', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些可以有效防御SQL注入？ (第3组)', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '参数化查询、输入验证、ORM框架、最小权限、错误处理', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是XSS的攻击类型？', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '反射型、存储型、DOM型', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是XSS的攻击类型？ (第2组)', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '反射型、存储型、DOM型', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是XSS的攻击类型？ (第3组)', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '反射型、存储型、DOM型', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是CSRF的防护措施？', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Referer验证、Token、SameSite Cookie、验证码', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是CSRF的防护措施？ (第2组)', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Referer验证、Token、SameSite Cookie、验证码', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是CSRF的防护措施？ (第3组)', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Referer验证、Token、SameSite Cookie、验证码', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是安全的密码存储方式？', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'BCrypt、PBKDF2', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是安全的密码存储方式？ (第2组)', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'BCrypt、PBKDF2', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是安全的密码存储方式？ (第3组)', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'BCrypt、PBKDF2', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是TCP的可靠传输机制？', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '确认、超时重传、流量控制、拥塞控制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是TCP的可靠传输机制？ (第2组)', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '确认、超时重传、流量控制、拥塞控制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是TCP的可靠传输机制？ (第3组)', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '确认、超时重传、流量控制、拥塞控制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Redis的数据结构？', 'A,B,C,D,E,F', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'String、List、Set、ZSet、Hash、Geo', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Redis的数据结构？ (第2组)', 'A,B,C,D,E,F', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'String、List、Set、ZSet、Hash、Geo', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Redis的数据结构？ (第3组)', 'A,B,C,D,E,F', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'String、List、Set、ZSet、Hash、Geo', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Kubernetes的安全机制？', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'RBAC、NetworkPolicy、PSP、Secrets', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Kubernetes的安全机制？ (第2组)', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'RBAC、NetworkPolicy、PSP、Secrets', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Kubernetes的安全机制？ (第3组)', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'RBAC、NetworkPolicy、PSP、Secrets', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Docker安全措施？', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'User namespace、Caps、Seccomp、AppArmor', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Docker安全措施？ (第2组)', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'User namespace、Caps、Seccomp、AppArmor', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Docker安全措施？ (第3组)', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'User namespace、Caps、Seccomp、AppArmor', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是身份认证的方式？', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '用户名密码、短信验证码、OAuth、LDAP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是身份认证的方式？ (第2组)', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '用户名密码、短信验证码、OAuth、LDAP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是身份认证的方式？ (第3组)', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '用户名密码、短信验证码、OAuth、LDAP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是日志分析的作用？', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '发现入侵、追踪问题、合规审计、优化性能', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是日志分析的作用？ (第2组)', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '发现入侵、追踪问题、合规审计、优化性能', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是日志分析的作用？ (第3组)', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '发现入侵、追踪问题、合规审计、优化性能', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是数据备份策略？', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '全量、增量、差异、异地', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是数据备份策略？ (第2组)', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '全量、增量、差异、异地', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是数据备份策略？ (第3组)', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '全量、增量、差异、异地', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是数据库优化手段？', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '索引、查询优化、分库分表、缓存', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是数据库优化手段？ (第2组)', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '索引、查询优化、分库分表、缓存', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是数据库优化手段？ (第3组)', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '索引、查询优化、分库分表、缓存', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是消息队列的特性？', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '异步、解耦、削峰', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是消息队列的特性？ (第2组)', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '异步、解耦、削峰', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是消息队列的特性？ (第3组)', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '异步、解耦、削峰', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是微服务架构的优势？', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '独立部署、技术多样性、容错隔离', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是微服务架构的优势？ (第2组)', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '独立部署、技术多样性、容错隔离', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是微服务架构的优势？ (第3组)', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '独立部署、技术多样性、容错隔离', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述SQL注入攻击的基本原理和防御措施。', 'SQL注入是通过在用户输入中插入恶意SQL代码，当应用程序将输入直接拼接到SQL查询时执行。防御措施：使用参数化查询、输入验证、白名单过滤、最小权限原则、错误信息处理。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述SQL注入攻击的基本原理和防御措施。 (变体1)', 'SQL注入是通过在用户输入中插入恶意SQL代码，当应用程序将输入直接拼接到SQL查询时执行。防御措施：使用参数化查询、输入验证、白名单过滤、最小权限原则、错误信息处理。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述SQL注入攻击的基本原理和防御措施。 (变体2)', 'SQL注入是通过在用户输入中插入恶意SQL代码，当应用程序将输入直接拼接到SQL查询时执行。防御措施：使用参数化查询、输入验证、白名单过滤、最小权限原则、错误信息处理。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述SQL注入攻击的基本原理和防御措施。 (变体3)', 'SQL注入是通过在用户输入中插入恶意SQL代码，当应用程序将输入直接拼接到SQL查询时执行。防御措施：使用参数化查询、输入验证、白名单过滤、最小权限原则、错误信息处理。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述HTTPS的工作原理。 (第2组)', 'HTTPS在HTTP和TCP之间增加SSL/TLS层。握手过程：客户端发起请求→服务器返回证书→客户端验证→生成对称密钥→加密通信。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述HTTPS的工作原理。 (变体1)', 'HTTPS在HTTP和TCP之间增加SSL/TLS层。握手过程：客户端发起请求→服务器返回证书→客户端验证→生成对称密钥→加密通信。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述HTTPS的工作原理。 (变体2)', 'HTTPS在HTTP和TCP之间增加SSL/TLS层。握手过程：客户端发起请求→服务器返回证书→客户端验证→生成对称密钥→加密通信。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述HTTPS的工作原理。 (变体3)', 'HTTPS在HTTP和TCP之间增加SSL/TLS层。握手过程：客户端发起请求→服务器返回证书→客户端验证→生成对称密钥→加密通信。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述TCP三次握手的过程和作用。 (第3组)', '三次握手：客户端发送SYN→服务器返回SYN-ACK→客户端发送ACK。作用：建立可靠连接，确认双方收发能力。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述TCP三次握手的过程和作用。 (变体1)', '三次握手：客户端发送SYN→服务器返回SYN-ACK→客户端发送ACK。作用：建立可靠连接，确认双方收发能力。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述TCP三次握手的过程和作用。 (变体2)', '三次握手：客户端发送SYN→服务器返回SYN-ACK→客户端发送ACK。作用：建立可靠连接，确认双方收发能力。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述TCP三次握手的过程和作用。 (变体3)', '三次握手：客户端发送SYN→服务器返回SYN-ACK→客户端发送ACK。作用：建立可靠连接，确认双方收发能力。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述单例模式的应用场景和实现方式。 (第4组)', '应用：配置管理、线程池、缓存、日志。实现：饿汉式、懒汉式（双重检查）、静态内部类、枚举。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述单例模式的应用场景和实现方式。 (变体1)', '应用：配置管理、线程池、缓存、日志。实现：饿汉式、懒汉式（双重检查）、静态内部类、枚举。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述单例模式的应用场景和实现方式。 (变体2)', '应用：配置管理、线程池、缓存、日志。实现：饿汉式、懒汉式（双重检查）、静态内部类、枚举。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述单例模式的应用场景和实现方式。 (变体3)', '应用：配置管理、线程池、缓存、日志。实现：饿汉式、懒汉式（双重检查）、静态内部类、枚举。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述进程和线程的区别与联系。 (第5组)', '区别：进程是资源分配单位（有独立地址空间），线程是CPU调度单位（共享进程资源）。联系：线程是进程的组成部分，共享进程资源。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述进程和线程的区别与联系。 (变体1)', '区别：进程是资源分配单位（有独立地址空间），线程是CPU调度单位（共享进程资源）。联系：线程是进程的组成部分，共享进程资源。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述进程和线程的区别与联系。 (变体2)', '区别：进程是资源分配单位（有独立地址空间），线程是CPU调度单位（共享进程资源）。联系：线程是进程的组成部分，共享进程资源。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述进程和线程的区别与联系。 (变体3)', '区别：进程是资源分配单位（有独立地址空间），线程是CPU调度单位（共享进程资源）。联系：线程是进程的组成部分，共享进程资源。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述什么是XSS攻击，有哪几种类型？ (第6组)', 'XSS是跨站脚本攻击，通过在网页中注入恶意脚本。三种类型：反射型、存储型、DOM型。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述什么是XSS攻击，有哪几种类型？ (变体1)', 'XSS是跨站脚本攻击，通过在网页中注入恶意脚本。三种类型：反射型、存储型、DOM型。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述什么是XSS攻击，有哪几种类型？ (变体2)', 'XSS是跨站脚本攻击，通过在网页中注入恶意脚本。三种类型：反射型、存储型、DOM型。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述什么是XSS攻击，有哪几种类型？ (变体3)', 'XSS是跨站脚本攻击，通过在网页中注入恶意脚本。三种类型：反射型、存储型、DOM型。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述数据库事务的ACID特性。 (第7组)', 'ACID：原子性（事务是最小执行单位）、一致性（执行前后状态一致）、隔离性（并发互不干扰）、持久性（提交后结果永久保存）。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述数据库事务的ACID特性。 (变体1)', 'ACID：原子性（事务是最小执行单位）、一致性（执行前后状态一致）、隔离性（并发互不干扰）、持久性（提交后结果永久保存）。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述数据库事务的ACID特性。 (变体2)', 'ACID：原子性（事务是最小执行单位）、一致性（执行前后状态一致）、隔离性（并发互不干扰）、持久性（提交后结果永久保存）。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述数据库事务的ACID特性。 (变体3)', 'ACID：原子性（事务是最小执行单位）、一致性（执行前后状态一致）、隔离性（并发互不干扰）、持久性（提交后结果永久保存）。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述快速排序的基本思想。 (第8组)', '快速排序采用分治思想：选择基准元素、分区（比基准小和比基准大两部分）、递归对两部分继续排序。平均O(n log n)。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述快速排序的基本思想。 (变体1)', '快速排序采用分治思想：选择基准元素、分区（比基准小和比基准大两部分）、递归对两部分继续排序。平均O(n log n)。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述快速排序的基本思想。 (变体2)', '快速排序采用分治思想：选择基准元素、分区（比基准小和比基准大两部分）、递归对两部分继续排序。平均O(n log n)。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述快速排序的基本思想。 (变体3)', '快速排序采用分治思想：选择基准元素、分区（比基准小和比基准大两部分）、递归对两部分继续排序。平均O(n log n)。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述什么是CSRF攻击以及防护措施。 (第9组)', 'CSRF是跨站请求伪造，利用用户已登录身份发起伪造请求。防护：验证码、Token、SameSite Cookie、Referer验证。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述什么是CSRF攻击以及防护措施。 (变体1)', 'CSRF是跨站请求伪造，利用用户已登录身份发起伪造请求。防护：验证码、Token、SameSite Cookie、Referer验证。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述什么是CSRF攻击以及防护措施。 (变体2)', 'CSRF是跨站请求伪造，利用用户已登录身份发起伪造请求。防护：验证码、Token、SameSite Cookie、Referer验证。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述什么是CSRF攻击以及防护措施。 (变体3)', 'CSRF是跨站请求伪造，利用用户已登录身份发起伪造请求。防护：验证码、Token、SameSite Cookie、Referer验证。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述对称加密和非对称加密的区别和应用场景。 (第10组)', '区别：对称加密用同一密钥（快速），非对称用公钥私钥（安全）。应用：对称加密大量数据，非对称加密密钥交换和数字签名。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述对称加密和非对称加密的区别和应用场景。 (变体1)', '区别：对称加密用同一密钥（快速），非对称用公钥私钥（安全）。应用：对称加密大量数据，非对称加密密钥交换和数字签名。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述对称加密和非对称加密的区别和应用场景。 (变体2)', '区别：对称加密用同一密钥（快速），非对称用公钥私钥（安全）。应用：对称加密大量数据，非对称加密密钥交换和数字签名。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('请简述对称加密和非对称加密的区别和应用场景。 (变体3)', '区别：对称加密用同一密钥（快速），非对称用公钥私钥（安全）。应用：对称加密大量数据，非对称加密密钥交换和数字签名。', 5, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个字符串是否是回文。回文是指正读和反读都一样的字符串。
输入: \"aba\" 输出: true
输入: \"abca\" 输出: false', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3332, 'aba', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3332, 'abca', 'false', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3332, 'a', 'true', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3332, 'abc', 'false', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个字符串是否是回文。回文是指正读和反读都一样的字符串。
输入: \"aba\" 输出: true
输入: \"abca\" 输出: false (变体)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3333, 'aba', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3333, 'abca', 'false', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3333, 'a', 'true', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3333, 'abc', 'false', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，计算字符串中单词的数量。单词是用空格分隔的连续字符序列。
输入: \"hello world\" 输出: 2
输入: \"abc\" 输出: 1 (第2组)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3334, 'hello world', '2', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3334, 'abc', '1', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3334, 'a b c', '3', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3334, '', '0', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，计算字符串中单词的数量。单词是用空格分隔的连续字符序列。
输入: \"hello world\" 输出: 2
输入: \"abc\" 输出: 1 (变体)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3335, 'hello world', '2', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3335, 'abc', '1', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3335, 'a b c', '3', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3335, '', '0', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，移除数组中所有等于val的元素，返回新数组长度。
输入: [3,2,3,3], val=3 输出: 2 (第3组)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3336, '[3,2,3,3] 3', '2', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3336, '[1,2,3,4] 5', '4', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3336, '[1,1,1] 1', '0', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，移除数组中所有等于val的元素，返回新数组长度。
输入: [3,2,3,3], val=3 输出: 2 (变体)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3337, '[3,2,3,3] 3', '2', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3337, '[1,2,3,4] 5', '4', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3337, '[1,1,1] 1', '0', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，合并两个有序数组为一个有序数组。
输入: [1,3,5], [2,4,6] 输出: [1,2,3,4,5,6] (第4组)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3338, '[1,3,5] [2,4,6]', '[1,2,3,4,5,6]', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3338, '[1,2,3] [4,5,6]', '[1,2,3,4,5,6]', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，合并两个有序数组为一个有序数组。
输入: [1,3,5], [2,4,6] 输出: [1,2,3,4,5,6] (变体)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3339, '[1,3,5] [2,4,6]', '[1,2,3,4,5,6]', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3339, '[1,2,3] [4,5,6]', '[1,2,3,4,5,6]', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个数是否是质数。质数是大于1的自然数，除了1和它本身外不能被其他自然数整除。
输入: 2 输出: true
输入: 4 输出: false (第5组)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3340, '2', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3340, '3', 'true', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3340, '4', 'false', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3340, '17', 'true', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个数是否是质数。质数是大于1的自然数，除了1和它本身外不能被其他自然数整除。
输入: 2 输出: true
输入: 4 输出: false (变体)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3341, '2', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3341, '3', 'true', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3341, '4', 'false', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3341, '17', 'true', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，返回斐波那契数列第n项。F(0)=0, F(1)=1, F(n)=F(n-1)+F(n-2)。
输入: 5 输出: 5
输入: 10 输出: 55 (第6组)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3342, '5', '5', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3342, '10', '55', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3342, '0', '0', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3342, '1', '1', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，返回斐波那契数列第n项。F(0)=0, F(1)=1, F(n)=F(n-1)+F(n-2)。
输入: 5 输出: 5
输入: 10 输出: 55 (变体)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3343, '5', '5', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3343, '10', '55', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3343, '0', '0', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3343, '1', '1', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，计算一个整数的阶乘。n! = n × (n-1) × ... × 2 × 1
输入: 5 输出: 120
输入: 0 输出: 1 (第7组)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3344, '5', '120', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3344, '0', '1', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3344, '10', '3628800', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，计算一个整数的阶乘。n! = n × (n-1) × ... × 2 × 1
输入: 5 输出: 120
输入: 0 输出: 1 (变体)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3345, '5', '120', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3345, '0', '1', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3345, '10', '3628800', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，求两个数的最大公约数（欧几里得算法）。
输入: 12, 8 输出: 4
输入: 24, 18 输出: 6 (第8组)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3346, '12 8', '4', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3346, '24 18', '6', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3346, '100 25', '25', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，求两个数的最大公约数（欧几里得算法）。
输入: 12, 8 输出: 4
输入: 24, 18 输出: 6 (变体)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3347, '12 8', '4', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3347, '24 18', '6', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3347, '100 25', '25', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，求两个数的最小公倍数。
输入: 4, 6 输出: 12
输入: 5, 10 输出: 10 (第9组)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3348, '4 6', '12', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3348, '5 10', '10', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3348, '7 3', '21', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，求两个数的最小公倍数。
输入: 4, 6 输出: 12
输入: 5, 10 输出: 10 (变体)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3349, '4 6', '12', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3349, '5 10', '10', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3349, '7 3', '21', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，将字符串中的空格替换为%20。
输入: \"hello world\" 输出: \"hello%20world\"
输入: \" \" 输出: \"%20\" (第10组)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3350, 'hello world', 'hello%20world', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3350, '  ', '%20', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3350, 'abc', 'abc', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，将字符串中的空格替换为%20。
输入: \"hello world\" 输出: \"hello%20world\"
输入: \" \" 输出: \"%20\" (变体)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3351, 'hello world', 'hello%20world', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3351, '  ', '%20', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3351, 'abc', 'abc', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个链表是否有环。
输入: 3->2->1->2 返回true
输入: 1->2 返回false (第11组)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3352, '3', '2', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3352, '1', '2', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个链表是否有环。
输入: 3->2->1->2 返回true
输入: 1->2 返回false (变体)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3353, '3', '2', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3353, '1', '2', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，返回链表的倒数第k个节点。
输入: 1->2->3->4->5, k=2 输出: 4
输入: 1->2->3, k=3 输出: 1 (第12组)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3354, '1', '2', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3354, '1', '2', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，返回链表的倒数第k个节点。
输入: 1->2->3->4->5, k=2 输出: 4
输入: 1->2->3, k=3 输出: 1 (变体)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3355, '1', '2', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3355, '1', '2', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个数是否是2的幂。
输入: 8 输出: true
输入: 6 输出: false (第13组)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3356, '8', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3356, '6', 'false', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3356, '1', 'true', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3356, '1024', 'true', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个数是否是2的幂。
输入: 8 输出: true
输入: 6 输出: false (变体)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3357, '8', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3357, '6', 'false', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3357, '1', 'true', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3357, '1024', 'true', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，返回字符串中第一个不重复的字符。
输入: \"abracadabra\" 输出: \'c\'
输入: \"aabbcc\" 输出: null (第14组)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3358, 'abracadabra', 'c', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3358, 'aabbcc', 'null', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3358, 'abc', 'a', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，返回字符串中第一个不重复的字符。
输入: \"abracadabra\" 输出: \'c\'
输入: \"aabbcc\" 输出: null (变体)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3359, 'abracadabra', 'c', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3359, 'aabbcc', 'null', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3359, 'abc', 'a', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，将数字转换为字符串。
输入: 123 输出: \"123\"
输入: -456 输出: \"-456\" (第15组)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3360, '123', '123', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3360, '-456', '-456', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3360, '0', '0', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，将数字转换为字符串。
输入: 123 输出: \"123\"
输入: -456 输出: \"-456\" (变体)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3361, '123', '123', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3361, '-456', '-456', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3361, '0', '0', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，将字符串转换为整数。
输入: \"123\" 输出: 123
输入: \"-456\" 输出: -456 (第16组)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3362, '123', '123', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3362, '-456', '-456', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3362, '  -42', '-42', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，将字符串转换为整数。
输入: \"123\" 输出: 123
输入: \"-456\" 输出: -456 (变体)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3363, '123', '123', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3363, '-456', '-456', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3363, '  -42', '-42', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，计算数组中连续子数组的最大和。
输入: [-2,1,-3,4,-1,2,1,-5,4] 输出: 6
输入: [1] 输出: 1 (第17组)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3364, '[-2,1,-3,4,-1,2,1,-5,4]', '6', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3364, '[1]', '1', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3364, '[5,4,-1,7,8]', '23', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，计算数组中连续子数组的最大和。
输入: [-2,1,-3,4,-1,2,1,-5,4] 输出: 6
输入: [1] 输出: 1 (变体)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3365, '[-2,1,-3,4,-1,2,1,-5,4]', '6', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3365, '[1]', '1', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3365, '[5,4,-1,7,8]', '23', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断两个字符串是否是字母异位词。
输入: \"anagram\", \"nagaram\" 输出: true
输入: \"rat\", \"car\" 输出: false (第18组)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3366, 'anagram nagaram', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3366, 'rat car', 'false', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3366, 'a', 'true', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断两个字符串是否是字母异位词。
输入: \"anagram\", \"nagaram\" 输出: true
输入: \"rat\", \"car\" 输出: false (变体)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3367, 'anagram nagaram', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3367, 'rat car', 'false', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3367, 'a', 'true', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，求两个链表的交点。
输入: A: 1->3->5, B: 2->4->3->5 输出: 5 (第19组)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3368, '1', '3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3368, '1', '2 3', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，求两个链表的交点。
输入: A: 1->3->5, B: 2->4->3->5 输出: 5 (变体)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3369, '1', '3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3369, '1', '2 3', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个数是否是水仙花数。
输入: 153 输出: true (1^3+5^3+3^3=153)
输入: 123 输出: false (第20组)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3370, '153', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3370, '123', 'false', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3370, '407', 'true', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个数是否是水仙花数。
输入: 153 输出: true (1^3+5^3+3^3=153)
输入: 123 输出: false (变体)', '', 6, 10, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3371, '153', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3371, '123', 'false', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (3371, '407', 'true', 25, 2);