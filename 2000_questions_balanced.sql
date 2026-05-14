USE labex;

INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，以下哪个不是基本数据类型？ [题1]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'String是引用类型', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项修饰符表示方法可以被继承？ [题2]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'protected成员可被继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于无限循环？ [题3]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'for(;;)、while(true)、do{}while(true)都是', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个操作不会改变数组内容？ [题4]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '增强for循环只是读取', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个方法不能继承？ [题5]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '构造方法不能被继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是接口的默认方法特性？ [题6]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Java 8起接口可以有default方法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个集合属于有序的？ [题7]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'TreeSet自然排序，LinkedHashSet保持插入顺序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于线程安全类？ [题8]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'ArrayList不是线程安全', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个注解表示弃用？ [题9]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '@Deprecated标记弃用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项关键字表示跳过本次循环？ [题10]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'continue跳过本次循环', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('String类的trim()方法作用属于？ [题11]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '去除首尾空格', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个方法可以获取字符串长度？ [题12]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'String用length()', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是重载的特征？ [题13]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '方法名相同参数列表不同', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项关键字用于抛出异常？ [题14]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'throw抛出异常', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于抽象类的特征？ [题15]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不能实例化可以有抽象方法不能用final修饰', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Object类的hashCode()方法返回？ [题16]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '返回对象的哈希码', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个修饰符的成员不能被继承？ [题17]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'private成员不能被继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是HashMap的工作原理？ [题18]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数组+链表/红黑树', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个操作会产生OOM？ [题19]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '创建超大数组或递归深度过大', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，HashMap的默认初始容量是？ [题20]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '16', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ArrayList的默认初始容量？ [题21]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '10', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项方法用于线程同步？ [题22]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'wait()、notify()、synchronized都用于线程同步', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于Java的自动装箱类型？ [题23]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Integer', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于Collection接口的方法？ [题24]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'get()是List接口的方法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Vector和ArrayList的区别？ [题25]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Vector线程安全', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项关键字用于定义常量？ [题26]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'final', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个访问修饰符允许同包访问？ [题27]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'default(package-private)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是静态内部类的特点？ [题28]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '可以不依赖外部类实例创建', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是内部类的作用？ [题29]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '访问外部类成员、实现多重继承、提高封装性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是方法重写的特征？ [题30]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '方法名参数返回类型都要相同', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于this关键字的作用？ [题31]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '引用当前对象、区分成员变量和局部变量、调用构造方法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是super关键字的作用？ [题32]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '调用父类成员、调用父类构造方法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是final关键字的作用？ [题33]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '修饰类不能被继承、修饰方法不能被重写、修饰变量不能改变', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是try-with-resources的特点？ [题34]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '自动关闭资源', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于Lambda表达式的特征？ [题35]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '简洁语法、函数式接口、单参数可省略括号', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Stream API的特点？ [题36]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '链式操作、惰性求值、中间操作和终端操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Optional的作用？ [题37]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '避免空指针异常', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是CompletableFuture的特点？ [题38]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '异步编程、链式调用、组合操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于ReentrantLock的特点？ [题39]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '可重入、tryLock、公平锁选择', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是CopyOnWriteArrayList的特点？ [题40]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '读不加锁写加锁', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ConcurrentHashMap的并发级别？ [题41]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分段锁', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是LongAdder的特点？ [题42]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '高并发下性能优于AtomicLong', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于ThreadLocal的作用？ [题43]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '为每个线程提供独立变量副本', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是volatile的作用？ [题44]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '保证可见性、防止指令重排序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是synchronized的作用？ [题45]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '保证原子性、可见性、有序性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是CAS的作用？ [题46]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '比较并交换', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于AQS的作用？ [题47]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '队列同步器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Fork/Join框架的特点？ [题48]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分而治之、工作窃取', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Java 10的新特性？ [题49]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '局部变量类型推断', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是Java 14的新特性？ [题50]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Switch表达式', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于Record的特点？ [题51]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '简洁数据类定义', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Sealed Class的作用？ [题52]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '限制类的继承层次', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Pattern类的matches方法？ [题53]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '完全匹配', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是Matcher的find方法？ [题54]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '查找下一个匹配', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于NumberFormat的用途？ [题55]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数字格式化', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是DecimalFormat的自定义模式？ [题56]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '0和#的区别', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是LocalDate的of方法？ [题57]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '创建指定日期', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是Duration的between方法？ [题58]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '计算时间间隔', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于ZoneId的作用？ [题59]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '时区标识', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Instant的特点？ [题60]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '时间线上的点', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Path的toUri方法？ [题61]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '转换为URI', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是Files的lines方法？ [题62]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '读取文件所有行', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于Stream的reduce方法？ [题63]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '归约操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Stream的collect方法？ [题64]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '收集操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Optional的orElse方法？ [题65]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '提供默认值', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是Function的compose方法？ [题66]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '组合函数', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于Consumer的andThen方法？ [题67]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '组合消费者', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Predicate的and方法？ [题68]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '组合断言', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Supplier的get方法？ [题69]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '获取结果', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是BiFunction的作用？ [题70]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '接收两个参数返回结果', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于BiConsumer的作用？ [题71]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '接收两个参数无返回值', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是UnaryOperator的作用？ [题72]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '一元操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是BinaryOperator的作用？ [题73]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '二元操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是Map的computeIfAbsent方法？ [题74]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '计算不存在时存入', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于List的replaceAll方法？ [题75]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '替换所有元素', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Set的stream方法？ [题76]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '转换为流', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Queue的offer方法？ [题77]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '添加元素不抛异常', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是Deque的push方法？ [题78]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '栈操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于Iterator的remove方法？ [题79]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '安全删除', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ListIterator的特点？ [题80]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '双向遍历', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('一个类可以继承几个父类？ [题81]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Java单继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项关键字用于实现继承？ [题82]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'extends', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('构造方法能否被继承？ [题83]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不能被继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个修饰符的成员不能被外部访问？ [题84]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'private', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('抽象类能否实例化？ [题85]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不能', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('接口中定义的变量默认是什么修饰符？ [题86]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'public static final', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个关键字用于调用父类构造方法？ [题87]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'super', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('方法重写时，返回类型可以不同吗？ [题88]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '可以是父类返回类型的子类型', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是多重继承的实现方式？ [题89]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '类和接口组合', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('内部类可以访问外部类的什么成员？ [题90]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '所有成员包括私有', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('静态内部类和成员内部类的区别属于？ [题91]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不需要外部类实例', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('匿名内部类的特点是？ [题92]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '没有名字、只能继承一个类或实现一个接口', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是封装的作用？ [题93]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '隐藏实现细节', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是继承的作用？ [题94]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '代码复用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于多态的作用？ [题95]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '父类引用指向子类对象', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是里氏替换原则的要求？ [题96]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '子类可以替换父类', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是开闭原则的要求？ [题97]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '对扩展开放对修改关闭', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是单一职责原则的要求？ [题98]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '一个类只负责一个职责', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于依赖倒置原则的要求？ [题99]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '依赖抽象而非具体', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是接口隔离原则的要求？ [题100]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '接口尽量细化', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('组合和继承的区别是？ [题101]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '组合是has-a关系，继承是is-a关系', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是委托的作用？ [题102]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '将任务交给其他类处理', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('策略模式和简单工厂的区别属于？ [题103]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '策略模式将算法封装', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('模板方法模式的组成是？ [题104]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '抽象模板和具体实现', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('装饰器模式和继承的区别是？ [题105]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '装饰器更灵活', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('代理模式的作用是？ [题106]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '控制对对象的访问', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('观察者模式中Subject的作用属于？ [题107]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '维护观察者列表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('建造者模式的链式调用返回什么？ [题108]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Builder本身', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('单例模式的线程安全要求是？ [题109]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '实例只创建一个', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('工厂方法模式的抽象产品由谁创建？ [题110]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '抽象工厂', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('抽象工厂模式的适用场景属于？ [题111]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '多个产品族', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('适配器模式的作用是？ [题112]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '接口转换', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('桥接模式的作用是？ [题113]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分离抽象和实现', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('组合模式的作用是？ [题114]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '树形结构统一处理', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('享元模式的作用属于？ [题115]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '共享细粒度对象', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('责任链模式的组成是？ [题116]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '处理器和next引用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('命令模式的作用是？ [题117]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '请求封装为对象', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('迭代器模式的组成是？ [题118]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Iterator和Collection', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('中介者模式的作用属于？ [题119]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '集中对象交互', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('备忘录模式的作用是？ [题120]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '保存和恢复状态', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('状态模式的作用是？ [题121]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '对象状态改变行为改变', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('访问者模式的作用是？ [题122]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '操作和数据分离', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('解释器模式的作用属于？ [题123]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '定义语法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于GoF设计模式？ [题124]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'MVC', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('设计模式的核心目的是？ [题125]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '复用解决方案', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项原则要求面向接口编程？ [题126]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '依赖倒置', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个原则要求少用继承多用组合？ [题127]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '组合优于继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是反模式？ [题128]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'God Object', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是代码重构的目标？ [题129]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '提高可读性和可维护性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是DRY原则？ [题130]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Don\'t Repeat Yourself', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL注入属于什么类型的攻击？ [题131]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '代码注入', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是防御SQL注入的最佳方式？ [题132]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '参数化查询', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MyBatis中哪个符号可以防止SQL注入？ [题133]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '#{}', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('联合查询注入利用SQL的哪个关键字？ [题134]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'UNION', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('错误型SQL注入利用什么获取信息？ [题135]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数据库错误信息', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('时间盲注中SLEEP()函数的作用是？ [题136]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '延长查询时间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('堆叠查询注入使用什么字符分隔SQL语句？ [题137]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分号', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('布尔盲注通过什么判断条件真假？ [题138]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '页面返回内容', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('XSS的全称属于？ [题139]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Cross-Site Scripting', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个HTTP头可以防护XSS？ [题140]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Content-Security-Policy', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HttpOnly Cookie的作用是？ [题141]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '防止JavaScript访问', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DOM型XSS的特点是？ [题142]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '完全在客户端执行', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSRF的全称属于？ [题143]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Cross-Site Request Forgery', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于CSRF的防护措施？ [题144]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '使用HTTPS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSRF攻击利用的前提是？ [题145]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '用户已登录', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Anti-CSRF Token的工作原理是？ [题146]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '验证表单和Session中Token一致性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SSRF属于指？ [题147]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '服务器端请求伪造', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SSRF的主要危害包括？ [题148]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '访问内网数据、扫描端口、攻击内部服务', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不是安全的密码存储方式？ [题149]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'MD5', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是安全的密码存储方式？ [题150]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'BCrypt', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数字信封的组成属于？ [题151]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '对称加密数据+接收方公钥加密密钥', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('同源策略的三要素是？ [题152]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '协议、域名、端口', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个HTTP头用于防止点击劫持？ [题153]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'X-Frame-Options', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('文件上传漏洞的主要危害是？ [题154]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '上传恶意脚本执行命令', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不属于安全的文件上传处理方式？ [题155]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '直接保存原文件名', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MIME类型验证可以被什么绕过？ [题156]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '修改Content-Type头和使用00截断', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('命令注入（Command Injection）是指？ [题157]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '用户数据被当作系统命令执行', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('水平越权是指？ [题158]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '同权限用户访问他人资源', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('垂直越权属于指？ [题159]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '低权限用户获得高权限操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('敏感信息泄露的途径包括？ [题160]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '错误信息、代码仓库、日志文件', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('防止SQL注入的参数化查询原理是？ [题161]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'SQL结构和数据分离', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL注入中，\' OR \'1\'=\'1 的作用是？ [题162]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '使条件永远为真', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('UNION注入要求两个SELECT的什么相同？ [题163]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '列数', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ORDER BY注入通过什么确定列数？ [题164]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '递增数字直到报错', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个函数常用于错误型注入？ [题165]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'UPDATEXML()', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项函数常用于时间盲注？ [题166]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'SLEEP()', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('BENCHMARK()函数的作用属于？ [题167]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '重复执行表达式消耗时间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是布尔盲注的特征？ [题168]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '页面正常或异常两种状态', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('堆叠查询可以执行什么类型的SQL？ [题169]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DDL、DML、DCL', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('参数化查询的PreparedStatement如何工作？ [题170]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '预编译SQL结构后绑定参数', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('在Java中，哪个类用于参数化查询？ [题171]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'PreparedStatement', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MyBatis中${}为什么不安全？ [题172]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '直接字符串替换', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('使用参数化查询后还需要输入验证吗？ [题173]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '需要业务层面校验', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ORM框架能完全防止SQL注入吗？ [题174]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '使用原生SQL时仍有风险', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('输入验证中白名单和黑名单哪个更安全？ [题175]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '白名单', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('仅仅过滤SQL关键字能防御注入吗？ [题176]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不能，攻击者可使用编码绕过', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据库最小权限原则的作用是？ [题177]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '限制攻击成功后的损害范围', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Web应用防火墙（WAF）的作用是？ [题178]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '检测和阻止Web攻击', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('安全错误处理的原则属于？ [题179]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '对用户隐藏错误详情记录到日志', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSP的default-src指令作用是？ [题180]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '设置默认资源来源', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('X-XSS-Protection头的作用是？ [题181]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '启用浏览器XSS过滤器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Referer头可以完全防止CSRF吗？ [题182]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不能，Referer可被篡改或丢失', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Samesite Cookie可以防止什么攻击？ [题183]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'CSRF', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('JSONP为什么存在安全风险？ [题184]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '缺乏origin验证', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('JSON劫持攻击的目标是？ [题185]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '获取敏感JSON数据', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('预检请求使用什么HTTP方法？ [题186]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'OPTIONS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于CSP的script-src指令作用？ [题187]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '限制JavaScript来源', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('X-Content-Type-Options头的作用是？ [题188]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '禁止MIME sniffing', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HSTS头的作用是？ [题189]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '强制使用HTTPS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的Secure属性作用是？ [题190]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '仅在HTTPS发送', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的HttpOnly属性作用属于？ [题191]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '禁止JavaScript访问', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL中，InnoDB和MyISAM的主要区别是？ [题192]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '事务支持、外键支持、锁粒度', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是索引的作用？ [题193]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '加快查询、节省存储、保证唯一', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('事务的ACID中，D代表什么？ [题194]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '持久性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个SQL语句用于授权？ [题195]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'GRANT', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的ZSet适用于什么场景？ [题196]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '排行榜', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的GROUP BY用于？ [题197]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分组聚合计算', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项隔离级别可以防止脏读？ [题198]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'READ COMMITTED', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据库连接池的作用属于？ [题199]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '减少连接创建开销、提高并发、管理生命周期', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于SQL的聚合函数？ [题200]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'CONCAT', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的JOIN类型中，LEFT JOIN返回？ [题201]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '左表全部记录', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是主键和唯一索引的区别？ [题202]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '主键不允许NULL', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于复合索引的遵循原则？ [题203]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最左前缀', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是数据库规范化的目的？ [题204]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '消除冗余和数据依赖', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('第一范式（1NF）要求？ [题205]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '属性不可再分', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('第二范式（2NF）要求？ [题206]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '消除部分依赖', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('第三范式（3NF）要求？ [题207]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '消除传递依赖', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('BC范式（BCNF）要求？ [题208]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '消除主属性对候选键的依赖', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是反规范化的目的？ [题209]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '提高查询性能', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('分区表的目的是？ [题210]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '提高查询和管理效率', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL的存储引擎包括？ [题211]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'InnoDB、MyISAM、MEMORY、CSV', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('InnoDB的行级锁基于？ [题212]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '索引', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MyISAM的锁级别是？ [题213]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '表级锁', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是乐观锁的实现方式？ [题214]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '版本号', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于悲观锁的实现方式？ [题215]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '排他锁', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('死锁的必要条件包括？ [题216]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '互斥、占有并等待、不可抢占、循环等待', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('索引覆盖是指？ [题217]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '查询只需访问索引无需回表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('最左前缀匹配是指？ [题218]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '从索引最左开始匹配', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('EXPLAIN的type列显示什么？ [题219]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '访问类型', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('EXPLAIN的Extra列显示什么？ [题220]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '额外信息', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('慢查询日志的作用是？ [题221]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '记录执行时间长的SQL', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('分库分表的目的？ [题222]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '解决单表数据量过大和并发压力', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('读写分离的目的属于？ [题223]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '提高并发和降低主库压力', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是ShardingSphere的功能？ [题224]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数据分片', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的数据类型包括？ [题225]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'String、List、Set、ZSet、Hash', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的String最大容量是？ [题226]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '512MB', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Hash适用场景属于？ [题227]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '存储对象', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Set适用场景是？ [题228]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '去重和集合操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的List适用场景是？ [题229]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '消息队列和栈', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的ZSet适用场景是？ [题230]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '排行榜和有序集合', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Pipeline用于？ [题231]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '批量执行命令', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Transaction支持？ [题232]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'MULTI和EXEC', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Pub/Sub用于？ [题233]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '发布订阅', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的Lua脚本作用是？ [题234]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '原子执行多个命令', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的SAVE命令用于？ [题235]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '同步保存到磁盘', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的EXPIRE命令用于？ [题236]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '设置过期时间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的TTL命令用于？ [题237]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '获取剩余生存时间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的KEYS命令用于？ [题238]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '模式匹配查找键', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的SCAN命令用于？ [题239]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '增量迭代键', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP三次握手的作用是？ [题240]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '建立可靠连接', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP状态码404表示？ [题241]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '资源未找到', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是四次挥手的FIN报文作用？ [题242]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '释放连接请求', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS使用什么协议加密？ [题243]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'TLS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS主要工作端口是？ [题244]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '53', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP的滑动窗口用于？ [题245]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '流量控制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie和Session的主要区别是？ [题246]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '存储位置、安全性、大小限制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个不属于HTTP方法？ [题247]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'COPY', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP和UDP的主要区别是？ [题248]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '连接vs无连接、可靠vs不可靠、有序vs无序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('在TCP/IP模型中，HTTP属于哪一层？ [题249]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '应用层', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP三次握手的seq和ack是什么？ [题250]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '序列号和确认号', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('四次挥手为什么TIME_WAIT要等待2MSL？ [题251]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '确保对方收到断开请求', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP的慢启动算法用于？ [题252]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '拥塞控制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP的快速重传基于？ [题253]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '三个重复ACK', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的Keep-Alive用于？ [题254]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '持久连接', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的Chunked编码用于？ [题255]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '分块传输', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的Gzip压缩用于？ [题256]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '减少传输量', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的Cache-Control用于？ [题257]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '缓存控制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的ETag用于？ [题258]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '资源标识', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的Domain属性用于？ [题259]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '指定可访问Cookie的域名', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Session的实现方式包括？ [题260]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Cookie、URL参数、隐藏表单字段', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('跨域请求的限制是？ [题261]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '浏览器同源策略', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('JSONP为什么能跨域？ [题262]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'script标签不受同源限制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CORS的预检请求属于？ [题263]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'OPTIONS请求', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WebSocket的协议是？ [题264]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'ws/wss', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP/2的特性包括？ [题265]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '多路复用、服务器推送、header压缩', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP/3使用什么协议？ [题266]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'QUIC', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CDN的作用属于？ [题267]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '加速访问、减轻源站压力', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的A记录用于？ [题268]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '域名指向IPv4地址', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的CNAME记录用于？ [题269]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '域名别名', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的MX记录用于？ [题270]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '邮件服务器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ARP的作用属于？ [题271]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '将IP地址解析为MAC地址', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ICMP的Echo请求用于？ [题272]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'ping命令', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('路由选择协议中，RIP基于？ [题273]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '距离向量', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('路由选择协议中，OSPF基于？ [题274]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '链路状态', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('BGP的作用属于？ [题275]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '自治系统间路由', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('NAT的作用是？ [题276]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '地址转换', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DHCP的端口是？ [题277]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '67/68', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('FTP的数据连接端口是？ [题278]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '20', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('FTP的控制连接端口属于？ [题279]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '21', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SSH的端口是？ [题280]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '22', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SMTP的端口是？ [题281]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '25', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('POP3的端口是？ [题282]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '110', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL的端口属于？ [题283]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '3306', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的端口是？ [题284]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '6379', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MongoDB的端口是？ [题285]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '27017', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Kafka的端口是？ [题286]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '9092', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Tomcat的默认端口属于？ [题287]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '8080', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS的默认端口是？ [题288]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '443', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数组和链表的主要区别是？ [题289]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '存储方式不同性能特性不同', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二叉树中，n0和n2的关系是？ [题290]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'n0=n2+1', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('快速排序的平均时间复杂度属于？ [题291]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'O(n log n)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个排序是稳定的？ [题292]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '归并排序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二分查找的前提条件是？ [题293]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数组有序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('动态规划的核心是？ [题294]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最优子结构和重叠子问题', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('深度优先搜索（DFS）使用什么数据结构？ [题295]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '栈', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是堆的特征？ [题296]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '完全二叉树、父节点大于等于子节点', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('图的邻接矩阵和邻接表，哪个适合稀疏图？ [题297]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '邻接表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项不是常见的负载均衡算法？ [题298]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '哈希一致性但不包含IP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于链表的插入时间复杂度？ [题299]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'O(1)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是数组的查询时间复杂度？ [题300]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'O(1)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是二叉搜索树的查询时间复杂度？ [题301]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'O(log n)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是红黑树的特征？ [题302]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '自平衡', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于B+树的特征？ [题303]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '只有叶子节点存储数据', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是跳表的特点？ [题304]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '多层索引', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是字典树的特点？ [题305]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '前缀匹配', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是并查集的应用？ [题306]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '社交网络朋友圈', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于拓扑排序的应用？ [题307]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '课程选修顺序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Dijkstra算法用于？ [题308]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '单源最短路径', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Bellman-Ford算法用于？ [题309]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '单源最短路径可处理负权边', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是Floyd-Warshall算法用于？ [题310]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '多源最短路径', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于Prim算法用于？ [题311]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最小生成树', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Kruskal算法用于？ [题312]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最小生成树', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是KMP算法的核心？ [题313]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '部分匹配表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是Manacher算法的用途？ [题314]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最长回文子串', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于LRU的特点？ [题315]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最近最少使用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是LFU的特点？ [题316]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最不经常使用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是布隆过滤器的特点？ [题317]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '空间效率高可能有假阳性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是单调栈的应用？ [题318]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '下一个更大元素', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于滑动窗口的应用？ [题319]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最大子序和', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是前缀和的应用？ [题320]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '区间和查询', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是哈希表解决冲突的方法？ [题321]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '链地址法和开放地址法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是一致性哈希的特点？ [题322]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '虚拟节点', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于Top K问题的解法？ [题323]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '堆或快速选择', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是岛屿问题的解法？ [题324]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DFS或BFS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是括号问题的解法？ [题325]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '栈', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是全排列问题的解法？ [题326]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '回溯', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于子集问题的解法？ [题327]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '回溯', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是最长递增子序列的解法？ [题328]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP或二分', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是最长公共子串的解法？ [题329]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是最长回文子串的解法？ [题330]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Manacher或DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于编辑距离的解法？ [题331]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是股票问题的解法？ [题332]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP或贪心', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是打家劫舍问题的解法？ [题333]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是跳台阶问题的解法？ [题334]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于斐波那契问题的解法？ [题335]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'DP或矩阵快速幂', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是丑数问题的解法？ [题336]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '三指针', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是质数问题的解法？ [题337]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '埃氏筛法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是公约数问题的解法？ [题338]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '辗转相除法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('进程和线程的主要区别属于？ [题339]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '进程是资源分配单位，线程是CPU调度单位', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是进程的状态？ [题340]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '创建、就绪、运行、阻塞、终止', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，查看进程用什么命令？ [题341]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'ps', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是僵尸进程的原因？ [题342]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '子进程退出但父进程未回收', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('孤儿进程属于指？ [题343]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '父进程退出但子进程仍在运行', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('进程间通信方式包括？ [题344]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '管道、消息队列、共享内存、Socket', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('线程间通信可以使用？ [题345]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '共享变量、消息传递', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是死锁的必要条件？ [题346]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '互斥、占有并等待、不可抢占、循环等待', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('预防死锁的方法属于？ [题347]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '破坏占有并等待条件', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('避免死锁的算法是？ [题348]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '银行家算法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是页面置换算法？ [题349]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'LRU、FIFO、Clock', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('FIFO页面置换算法的缺点是？ [题350]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Belady现象', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于LRU算法的思想？ [题351]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最近最少使用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('内存管理中，碎片包括？ [题352]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '内碎片和外碎片', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('分页存储管理的优点是？ [题353]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '消除外部碎片', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('分段存储管理的优点是？ [题354]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '符合用户视角', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('虚拟内存的作用属于？ [题355]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '扩展地址空间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cache的作用是？ [题356]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '加速CPU访问主存', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('时间局部性是指？ [题357]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最近访问的地址近期还会访问', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('空间局部性是指？ [题358]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最近访问的地址附近的地址近期会访问', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于Linux的进程状态？ [题359]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '运行、睡眠、停止、僵尸', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Shell脚本中，$0表示？ [题360]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '脚本名称', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Shell脚本中，$1表示？ [题361]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '第一个参数', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，创建进程用哪个系统调用？ [题362]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'fork', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，exec函数族的作用属于？ [题363]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '替换进程映像', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('管道分为哪两种？ [题364]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '匿名管道和命名管道', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('socket通信用于？ [题365]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '网络通信', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('信号量用于？ [题366]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '进程同步', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('互斥锁用于？ [题367]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '保护临界资源', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('哲学家就餐问题是为了说明？ [题368]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '死锁和资源竞争', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('读者写者问题用于说明？ [题369]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '读写同步', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('生产者和消费者问题用于说明？ [题370]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '同步和缓冲', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CPU调度算法中，FCFS属于？ [题371]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '先来先服务', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SJF调度算法的缺点是？ [题372]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '可能产生饥饿', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('时间片轮转调度中，时间片过大的影响是？ [题373]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '退化为FCFS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('多级反馈队列调度算法的优点是？ [题374]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '综合考虑响应时间和周转时间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('实时系统的调度算法包括？ [题375]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'RM、EDF', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('系统调用和普通函数调用的区别是？ [题376]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '系统调用进入内核', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('中断的作用是？ [题377]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '提高I/O效率', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('异常和中断的区别是？ [题378]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '异常由CPU产生，中断由外设产生', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('系统开机过程属于？ [题379]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'BIOS->MBR->GRUB->Kernel->Init', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，文件系统Ext4的特点是？ [题380]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '日志文件系统', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('JavaScript中，null和undefined的区别是？ [题381]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'null表示空对象，undefined表示未定义', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是ES6的let关键字特性？ [题382]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '块级作用域', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('const声明的变量能修改吗？ [题383]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '如果指向对象，可以修改属性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是箭头函数的特点？ [题384]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '没有自己的this', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Promise的状态？ [题385]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'pending、fulfilled、rejected', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('async/await的作用是？ [题386]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '简化异步编程', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于深拷贝的方法？ [题387]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'JSON.parse(JSON.stringify())', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('JavaScript的事件循环机制是？ [题388]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '同步任务执行完后执行微任务，然后执行宏任务', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是防抖的作用？ [题389]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '减少函数调用频率', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('节流的作用是？ [题390]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '限制函数在一定时间内只执行一次', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSS的flex布局中，justify-content用于？ [题391]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '主轴对齐', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('align-items用于？ [题392]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '交叉轴对齐', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Vue的双向绑定原理？ [题393]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数据劫持+发布订阅', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Vue中，computed和watch的区别是？ [题394]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'computed有缓存，watch没有', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于Vue的生命周期钩子？ [题395]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'created、mounted、updated、destroyed', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('React中，useState的作用是？ [题396]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '在函数组件中添加状态', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('useEffect的第二个参数作用是？ [题397]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '指定依赖项', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是Redux的核心概念？ [题398]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Store、Action、Reducer', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Vuex和Pinia的区别属于？ [题399]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Pinia更轻量，API更现代化', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是TypeScript的类型推断？ [题400]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不必显式指定类型', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('interface和type的区别是？ [题401]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'interface可以声明合并', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是Webpack的作用？ [题402]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '模块打包', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Vite的优势属于？ [题403]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '基于ESM的快速开发服务器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Axios的特点？ [题404]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '基于Promise的HTTP客户端', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Fetch API的优势是？ [题405]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '原生浏览器API', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是WebSocket的特点？ [题406]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '全双工通信', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie、SessionStorage、LocalStorage的区别属于？ [题407]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '容量、生命周期、共享范围', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是跨域请求的解决方案？ [题408]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'CORS、JSONP、代理服务器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP缓存中，Cache-Control的max-age表示？ [题409]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '缓存最大生存时间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ETag的作用是？ [题410]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '资源版本标识', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSS的BFC属于指？ [题411]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '块级格式化上下文', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是清除浮动的方法？ [题412]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'clear:both、overflow:auto', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('伪类和伪元素的区别是？ [题413]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '伪类表示状态，伪元素表示内容', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是CSS的盒模型？ [题414]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'content、padding、border、margin', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('box-sizing:border-box的作用属于？ [题415]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'width包含padding和border', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是响应式布局的方法？ [题416]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '媒体查询、Flex、Grid', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('移动端适配的方法包括？ [题417]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'viewport、rem、媒体查询', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Retina屏幕使用什么单位？ [题418]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '物理像素而非逻辑像素', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于SVG的特点？ [题419]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '矢量图形、可缩放', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Canvas和SVG的区别是？ [题420]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Canvas是位图，SVG是矢量图', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是WebGL的用途？ [题421]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '3D图形渲染', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker的核心组件包括？ [题422]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Client、Docker daemon、Registry、Container', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于Dockerfile的FROM指令作用？ [题423]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '指定基础镜像', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('COPY和ADD指令的区别是？ [题424]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'ADD支持URL和解压功能', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WORKDIR指令的作用是？ [题425]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '设置工作目录', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('EXPOSE指令的作用是？ [题426]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '声明容器监听端口', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CMD和ENTRYPOINT的区别属于？ [题427]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'CMD可被覆盖，ENTRYPOINT不可', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Docker的数据持久化方式？ [题428]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Volume', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker网络模式bridge的特点是？ [题429]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '默认模式，有独立网络命名空间', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('host网络模式的特点是？ [题430]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '容器共享主机网络', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于Kubernetes的Pod？ [题431]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '最小调度单位', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Deployment的作用是？ [题432]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '管理Pod副本数', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Service的作用是？ [题433]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '提供服务发现和负载均衡', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ConfigMap的作用是？ [题434]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '存储配置数据', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Secret的作用属于？ [题435]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '存储敏感信息', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Git的工作区？ [题436]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Working Directory', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('暂存区是？ [题437]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Staging Area', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Git中，HEAD表示？ [题438]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '当前分支的最新提交', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于Git的克隆命令？ [题439]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'git clone', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('git add的作用是？ [题440]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '添加到暂存区', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('git commit的作用是？ [题441]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '提交到本地仓库', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('git push的作用是？ [题442]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '推送到远程仓库', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('git pull的作用属于？ [题443]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '拉取并合并远程更新', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('git merge和git rebase的区别是？ [题444]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'merge保留分支历史，rebase是线性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('git reset的--soft参数是？ [题445]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '保留暂存区', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('git reset的--hard参数是？ [题446]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '重置工作区和暂存区', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于CI/CD的目标？ [题447]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '自动化构建、测试、部署', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Jenkins的作用是？ [题448]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '持续集成服务器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('GitLab CI的流水线包括？ [题449]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Stages、Jobs、Steps', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SonarQube的作用是？ [题450]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '代码质量分析', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于Maven的生命周期？ [题451]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'clean、compile、test、package、install、deploy', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Gradle的特点是？ [题452]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '基于Groovy的构建工具', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker Compose的作用是？ [题453]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '定义多容器应用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Helm的作用是？ [题454]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Kubernetes包管理器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Prometheus的作用属于？ [题455]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '监控和告警', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Grafana的作用是？ [题456]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '可视化监控数据', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是日志收集工具？ [题457]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'ELK、Fluentd、 Loki', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Istio的作用是？ [题458]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '服务网格', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Terraform的作用属于？ [题459]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '基础设施即代码', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Ansible的作用是？ [题460]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '配置管理自动化', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Jenkinsfile使用什么语法？ [题461]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Groovy', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ArgoCD的作用是？ [题462]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'GitOps持续部署', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，以下哪个不属于基本数据类型？ [题463]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'String是引用类型', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个修饰符表示方法可以被继承？ [题464]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'protected成员可被继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是无限循环？ [题465]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'for(;;)、while(true)、do{}while(true)都是', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项操作不会改变数组内容？ [题466]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '增强for循环只是读取', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个方法不能继承？ [题467]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '构造方法不能被继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是接口的默认方法特性？ [题468]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Java 8起接口可以有default方法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个集合是有序的？ [题469]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'TreeSet自然排序，LinkedHashSet保持插入顺序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项不是线程安全类？ [题470]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'ArrayList不是线程安全', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个注解表示弃用？ [题471]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '@Deprecated标记弃用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个关键字表示跳过本次循环？ [题472]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'continue跳过本次循环', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('String类的trim()方法作用是？ [题473]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '去除首尾空格', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项方法可以获取字符串长度？ [题474]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'String用length()', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于重载的特征？ [题475]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '方法名相同参数列表不同', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个关键字用于抛出异常？ [题476]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'throw抛出异常', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是抽象类的特征？ [题477]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '不能实例化可以有抽象方法不能用final修饰', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Object类的hashCode()方法返回？ [题478]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '返回对象的哈希码', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个修饰符的成员不能被继承？ [题479]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'private成员不能被继承', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是HashMap的工作原理？ [题480]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '数组+链表/红黑树', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个操作会产生OOM？ [题481]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '创建超大数组或递归深度过大', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，HashMap的默认初始容量是？ [题482]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '16', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于ArrayList的默认初始容量？ [题483]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '10', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个方法用于线程同步？ [题484]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'wait()、notify()、synchronized都用于线程同步', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Java的自动装箱类型？ [题485]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Integer', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项不是Collection接口的方法？ [题486]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'get()是List接口的方法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于Vector和ArrayList的区别？ [题487]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'Vector线程安全', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个关键字用于定义常量？ [题488]', 'A', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'final', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个访问修饰符允许同包访问？ [题489]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', 'default(package-private)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是静态内部类的特点？ [题490]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '可以不依赖外部类实例创建', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于内部类的作用？ [题491]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '访问外部类成员、实现多重继承、提高封装性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是方法重写的特征？ [题492]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '方法名参数返回类型都要相同', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是this关键字的作用？ [题493]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '引用当前对象、区分成员变量和局部变量、调用构造方法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是super关键字的作用？ [题494]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '调用父类成员、调用父类构造方法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于final关键字的作用？ [题495]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '修饰类不能被继承、修饰方法不能被重写、修饰变量不能改变', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是try-with-resources的特点？ [题496]', 'B', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '自动关闭资源', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Lambda表达式的特征？ [题497]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '简洁语法、函数式接口、单参数可省略括号', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('下列哪项是Stream API的特点？ [题498]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '链式操作、惰性求值、中间操作和终端操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个属于Optional的作用？ [题499]', 'C', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '避免空指针异常', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是CompletableFuture的特点？ [题500]', 'D', 2, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\"}', '异步编程、链式调用、组合操作', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，八种基本数据类型包括：byte、short、int、long、float、double、char和____。 [题1]', 'boolean', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，String类的length()方法返回的是____类型。 [题2]', 'int', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，使用____关键字来引用当前对象。 [题3]', 'this', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，静态方法使用____关键字修饰。 [题4]', 'static', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('抽象类不能直接____，需要通过继承创建子类对象。 [题5]', '实例化', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('接口中定义的变量默认是public static final，即____。 [题6]', '常量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('方法重写要求方法名、参数列表和____都要相同。 [题7]', '返回类型', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('异常处理的try-catch-finally块中，____块总会执行。 [题8]', 'finally', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Object类的toString()方法默认返回类的____和哈希码。 [题9]', '类名', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java的集合框架中，List接口的直接父接口是____。 [题10]', 'Collection', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HashMap的put方法返回值为null表示____。 [题11]', '插入成功或value为null', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ArrayList的默认初始容量是____。 [题12]', '10', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HashMap的默认初始容量是____。 [题13]', '16', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HashMap的负载因子默认是____。 [题14]', '0.75', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二叉树的深度计算公式是log2(n+1)向下取整适用于____二叉树。 [题15]', '完全', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，使用____关键字来定义泛型。 [题16]', 'T或泛型', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Java的自动装箱类型？____ [题17]', 'Integer', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Java的多线程状态？____ [题18]', 'NEW、RUNNABLE、BLOCKED、WAITING、TIMED_WAITING、TERMINATED', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('synchronized关键字可以修饰____、方法和代码块。 [题19]', '代码块或成员变量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('volatile关键字保证变量的____可见性和禁止指令重排序。 [题20]', '可见性', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Object类的wait方法必须由____块调用。 [题21]', 'synchronized', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Thread类的____方法用于启动线程。 [题22]', 'start', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Runnable接口的____方法用于执行线程任务。 [题23]', 'run', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Future接口的____方法用于获取异步结果。 [题24]', 'get', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CompletableFuture的____方法用于异步执行任务。 [题25]', 'supplyAsync', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Lambda表达式省略了接口的____类型声明。 [题26]', '目标', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Stream的____方法用于过滤元素。 [题27]', 'filter', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Stream的____方法用于映射转换。 [题28]', 'map', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Stream的____方法用于排序。 [题29]', 'sorted', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Stream的____方法用于收集结果。 [题30]', 'collect', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Optional类的____方法用于获取值或默认值。 [题31]', 'orElse', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('LocalDateTime的____方法用于获取当前时间。 [题32]', 'now', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Duration的____方法用于计算时间间隔。 [题33]', 'between', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('BigDecimal的____方法用于加法运算。 [题34]', 'add', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('BigInteger的____方法用于比较大小。 [题35]', 'compareTo', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Pattern类的____方法用于编译正则表达式。 [题36]', 'compile', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Matcher类的____方法用于查找匹配。 [题37]', 'find', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Files类的____方法用于读取文件所有行。 [题38]', 'lines', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Path接口的____方法用于获取路径字符串。 [题39]', 'toString', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('System类的____方法用于复制数组。 [题40]', 'arraycopy', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Math类的____方法用于四舍五入。 [题41]', 'round', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL注入攻击利用了Web应用程序对用户输入____不充分验证的漏洞。 [题42]', '数据', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('参数化查询将SQL语句结构和____分离，防止注入。 [题43]', '数据', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('XSS攻击的三种类型：反射型、存储型和____型。 [题44]', 'DOM', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTML上下文中，需要对<、>、&字符进行____以防止XSS。 [题45]', '编码或转义', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSRF利用浏览器的____特性自动发送Cookie。 [题46]', '同源', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('同源策略的三要素：协议、域名和____。 [题47]', '端口', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WAF是Web应用____的缩写。 [题48]', '防火墙', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('敏感信息泄露可能通过错误信息、代码仓库和____等途径。 [题49]', '日志文件', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('防止CSRF的Token机制验证表单Token和____中Token的一致性。 [题50]', 'Session', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('安全的密码存储应使用加盐的____哈希算法。 [题51]', 'BCrypt', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('XSS攻击主要通过在页面中注入____脚本来获取用户信息。 [题52]', '恶意或JavaScript', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('存储型XSS的注入点通常包括____、用户资料等。 [题53]', '评论区', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DOM型XSS的注入点是浏览器的____代码。 [题54]', 'JavaScript', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HttpOnly属性可以防止____脚本访问Cookie。 [题55]', 'JavaScript', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSP的____src指令用于限制JavaScript来源。 [题56]', 'script', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('X-Frame-Options头可以防止____劫持。 [题57]', '点击', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Samesite Cookie属性可以防止____攻击。 [题58]', 'CSRF', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL注入中，注释符是____。 [题59]', '--或#', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('UNION注入要求两个SELECT的____数相同。 [题60]', '列', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ORDER BY注入通过____数字确定列数。 [题61]', '递增', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('布尔盲注通过页面返回的____判断条件真假。 [题62]', '内容或状态', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('时间盲注利用____函数延长查询时间。 [题63]', 'SLEEP', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('堆叠查询使用____分隔多条SQL语句。 [题64]', '分号或;', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MyBatis中#{}使用____查询防止SQL注入。 [题65]', '参数化', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MyBatis中${}直接字符串替换，____不安全。 [题66]', '可能或存在风险', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('PreparedStatement通过预编译____结构来防止注入。 [题67]', 'SQL', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WAF是Web应用____，用于检测和阻止Web攻击。 [题68]', '防火墙', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SSRF是服务器端____伪造，用于访问内网资源。 [题69]', '请求', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('水平越权是同权限用户访问____的资源。 [题70]', '他人', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('垂直越权是低权限用户获得____权限操作。 [题71]', '更高', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('文件上传漏洞的危害是上传____脚本执行命令。 [题72]', '恶意', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MIME类型验证可以被修改____头绕过。 [题73]', 'Content-Type', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('命令注入是用户输入被当作____执行。 [题74]', '系统命令', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('00截断可以绕过____检查。 [题75]', '文件类型', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数字信封用对称密钥加密数据，用接收方的____加密对称密钥。 [题76]', '公钥', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS混合加密：非对称加密用于____，对称加密用于数据传输。 [题77]', '密钥交换', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('AES是____加密算法。 [题78]', '对称', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('RSA算法的安全性基于大数____的困难性。 [题79]', '分解', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数字签名用于验证消息的完整性和____身份。 [题80]', '发送者', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('哈希函数具有单向性、确定性和____效应。 [题81]', '雪崩', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('PKI体系的核心是____。 [题82]', '数字证书', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('对称加密和非对称加密的主要区别是密钥____数量不同。 [题83]', '使用', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('BCrypt使用____算法存储密码。 [题84]', '自适应哈希', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('_argon2是哪种哈希算法？____ [题85]', 'Argon2', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('PBKDF2是____哈希算法。 [题86]', '基于密码', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Salt的作用是防止____攻击。 [题87]', '彩虹表', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('撞库攻击利用用户在多个网站使用相同____的习惯。 [题88]', '密码', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('暴破解使用____尝试登录。 [题89]', '字典或暴力', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('中间人攻击截获的是____加密的数据。 [题90]', '无', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS使用____协议加密。 [题91]', 'TLS', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HSTS头强制浏览器使用____访问。 [题92]', 'HTTPS', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HPKP头用于____固定防止中间人攻击。 [题93]', '公钥', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('X-Content-Type-Options头防止MIME____。 [题94]', '类型嗅探', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Referer头可以验证请求的____来源。 [题95]', 'Web', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CORS的origin头用于跨域请求____。 [题96]', '授权或验证', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('预检请求使用____HTTP方法。 [题97]', 'OPTIONS', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('JSONP缺乏____验证，存在安全风险。 [题98]', 'origin', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WebSocket没有____限制。 [题99]', '同源策略', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的____属性限制Cookie在HTTPS下发送。 [题100]', 'Secure', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Session和Cookie的主要区别是____位置不同。 [题101]', '存储', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP三次握手：SYN、____、ACK。 [题102]', 'SYN-ACK', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP四次挥手：FIN、____、FIN、ACK。 [题103]', 'ACK', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的____方法只获取响应头，不获取实体内容。 [题104]', 'HEAD', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS使用____协议进行加密。 [题105]', 'TLS', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的全称是____，主要工作端口是53。 [题106]', 'Domain Name System', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的HttpOnly属性可以防止____访问Cookie。 [题107]', 'JavaScript', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('滑动窗口用于TCP的____控制。 [题108]', '流量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('IP地址分为____类和____类。 [题109]', 'A|B', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('路由选择协议中，RIP基于____算法。 [题110]', '距离向量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ARP协议用于将____地址解析为IP地址。 [题111]', 'MAC', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ICMP的____请求用于ping命令。 [题112]', 'Echo', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP的滑动窗口用于____控制。 [题113]', '流量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('UDP的____头部只有8字节。 [题114]', '首部', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP状态码404表示____未找到。 [题115]', '资源', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP状态码500表示____错误。 [题116]', '服务器', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP状态码200表示____成功。 [题117]', '请求', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP状态码301表示____重定向。 [题118]', '永久', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP状态码302表示____重定向。 [题119]', '临时', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的Keep-Alive用于____连接。 [题120]', '持久', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的____编码用于分块传输。 [题121]', 'Chunked', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的Cache-Control用于____控制。 [题122]', '缓存', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的ETag用于资源____标识。 [题123]', '版本', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CORS的预检请求使用____方法。 [题124]', 'OPTIONS', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WebSocket的协议是____或wss。 [题125]', 'ws', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP/2支持____复用。 [题126]', '多路', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP/2头部使用____压缩。 [题127]', 'HPACK', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP/3使用____协议。 [题128]', 'QUIC', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的A记录用于域名指向____地址。 [题129]', 'IPv4', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的AAAA记录用于域名指向____地址。 [题130]', 'IPv6', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的CNAME记录用于域名____。 [题131]', '别名', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的MX记录用于____服务器。 [题132]', '邮件', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的NS记录用于____服务器。 [题133]', '域名', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CDN用于____加速和减轻源站压力。 [题134]', '内容', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('NAT用于____转换。 [题135]', '地址', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DHCP使用____端口。 [题136]', '67/68', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('FTP的控制连接端口是____。 [题137]', '21', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('FTP的数据连接端口是____。 [题138]', '20', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SSH使用____端口。 [题139]', '22', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Telnet使用____端口。 [题140]', '23', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SMTP使用____端口。 [题141]', '25', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('POP3使用____端口。 [题142]', '110', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS使用____端口。 [题143]', '443', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL使用____端口。 [题144]', '3306', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis使用____端口。 [题145]', '6379', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MongoDB使用____端口。 [题146]', '27017', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Kafka使用____端口。 [题147]', '9092', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Zookeeper使用____端口。 [题148]', '2181', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP的三次握手用于建立____连接。 [题149]', '可靠', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP的四次挥手用于断开____连接。 [题150]', '可靠', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TIME_WAIT状态等待____MSL。 [题151]', '2', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL的InnoDB存储引擎支持____和行级锁。 [题152]', '事务', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的聚合函数包括：COUNT、SUM、AVG、MAX和____。 [题153]', 'MIN', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据库索引的____原则指最左前缀匹配。 [题154]', '最左', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('事务的ACID特性：原子性、一致性、隔离性和____。 [题155]', '持久性', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的持久化方式包括RDB快照和____日志。 [题156]', 'AOF', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis使用____实现分布式锁。 [题157]', 'SETNX', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的JOIN类型中，____JOIN返回左表全部记录。 [题158]', 'LEFT', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL默认的事务隔离级别是____。 [题159]', 'REPEATABLE READ', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数据库____范式旨在消除冗余和数据依赖问题。 [题160]', '规范化', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MongoDB是____型NoSQL数据库。 [题161]', '文档', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL的GROUP BY用于____聚合计算。 [题162]', '分组', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HAVING子句用于过滤____。 [题163]', '分组', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ORDER BY用于____排序。 [题164]', '结果', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('LIMIT用于____结果数量。 [题165]', '限制', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DISTINCT用于____重复记录。 [题166]', '去重', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('UNION用于____多个查询结果。 [题167]', '合并', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('JOIN的ON子句用于指定____条件。 [题168]', '连接', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('LEFT JOIN返回____表的全部记录。 [题169]', '左', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('INNER JOIN只返回____的记录。 [题170]', '匹配', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('子查询发生在____语句内部的SELECT。 [题171]', 'SQL', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('索引的____原则是最左前缀匹配。 [题172]', '最左', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('覆盖索引指查询____访问索引无需回表。 [题173]', '只需', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('索引下推将____下推到存储引擎层。 [题174]', '条件', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MySQL的存储引擎包括____、MyISAM、MEMORY等。 [题175]', 'InnoDB', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('InnoDB使用____锁实现行级锁。 [题176]', '意向', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MyISAM使用____锁实现表级锁。 [题177]', '表', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('乐观锁通常使用____实现。 [题178]', '版本号', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('悲观锁使用____实现。 [题179]', '排他锁', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('死锁的四个必要条件：互斥、占有并等待、不可抢占和____。 [题180]', '循环等待', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('解决死锁的方法包括回滚和____。 [题181]', '重试', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('分库分表用于解决单表____过大的问题。 [题182]', '数据量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('读写分离用于提高并发和降低____压力。 [题183]', '主库', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的____类型用于实现分布式锁。 [题184]', 'String', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的____类型用于存储对象。 [题185]', 'Hash', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的____类型用于去重和集合操作。 [题186]', 'Set', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的____类型用于排行榜。 [题187]', 'ZSet', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的____类型用于消息队列。 [题188]', 'List', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的____命令用于发布消息。 [题189]', 'PUBLISH', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的____命令用于订阅频道。 [题190]', 'SUBSCRIBE', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的____命令用于开启事务。 [题191]', 'MULTI', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的____命令用于执行事务。 [题192]', 'EXEC', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的____命令用于监控键变化。 [题193]', 'WATCH', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的____命令用于设置过期时间。 [题194]', 'EXPIRE', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的____命令用于获取剩余生存时间。 [题195]', 'TTL', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的SAVE命令用于____保存到磁盘。 [题196]', '同步', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的BGSAVE命令用于____保存到磁盘。 [题197]', '异步', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的____持久化追加命令到日志。 [题198]', 'AOF', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Redis的____持久化定时生成快照。 [题199]', 'RDB', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数组下标从____开始。 [题200]', '0', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二叉树的深度为log2(n+1)向下取整适用于____二叉树。 [题201]', '完全', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('快速排序的平均时间复杂度是____。 [题202]', 'O(n log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二分查找的时间复杂度是____。 [题203]', 'O(log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('栈的特点是____。 [题204]', 'LIFO或后进先出', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('队列的特点是____。 [题205]', 'FIFO或先进先出', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('堆用于实现优先级队列，堆排序的时间复杂度始终是____。 [题206]', 'O(n log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('动态规划的核心是最优子结构和____子问题。 [题207]', '重叠', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('图的遍历算法包括____和广度优先搜索。 [题208]', '深度优先搜索', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('哈希表处理哈希冲突的方法包括链地址法和____法。 [题209]', '开放地址', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('链表的插入时间复杂度是____。 [题210]', 'O(1)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数组的查询时间复杂度是____。 [题211]', 'O(1)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二叉搜索树的查询时间复杂度是____。 [题212]', 'O(log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('红黑树是一种____平衡二叉搜索树。 [题213]', '自', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('B树是一种多路____搜索树。 [题214]', '平衡', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('B+树只有____节点存储数据。 [题215]', '叶子', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('跳表使用____层索引。 [题216]', '多', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('字典树用于____匹配。 [题217]', '前缀', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('并查集用于处理____合并和查找。 [题218]', '集合', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('拓扑排序用于____依赖排序。 [题219]', '任务', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Dijkstra算法用于____最短路径。 [题220]', '单源', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Bellman-Ford算法用于____最短路径可处理负权边。 [题221]', '单源', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Floyd-Warshall算法用于____最短路径。 [题222]', '多源', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Prim算法用于____生成树。 [题223]', '最小', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Kruskal算法用于____生成树。 [题224]', '最小', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('KMP算法的核心是____匹配表。 [题225]', '部分', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Manacher算法用于____回文子串。 [题226]', '最长', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('LRU用于____淘汰。 [题227]', '缓存', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('LFU用于____淘汰。 [题228]', '频率', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('布隆过滤器可能出现____阳性。 [题229]', '假', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('单调栈用于____更大元素。 [题230]', '下一个', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('滑动窗口用于____子数组。 [题231]', '最大', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('前缀和用于____和查询。 [题232]', '区间', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('差分数组用于____增减操作。 [题233]', '区间', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('分治算法包括分解、____和合并。 [题234]', '解决', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('回溯算法通过____所有可能求解。 [题235]', '尝试', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('分支限界通过____搜索空间。 [题236]', '剪枝', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('贪心算法期望____最优导致全局最优。 [题237]', '局部', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('递归算法需要设置____防止无限递归。 [题238]', '终止条件', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('快速排序的平均时间复杂度是____。 [题239]', 'O(n log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('归并排序的时间复杂度是____。 [题240]', 'O(n log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('堆排序的时间复杂度是____。 [题241]', 'O(n log n)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('冒泡排序的时间复杂度是____。 [题242]', 'O(n^2)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('选择排序的时间复杂度是____。 [题243]', 'O(n^2)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('插入排序的时间复杂度是____。 [题244]', 'O(n^2)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('希尔排序的时间复杂度是____。 [题245]', 'O(n^1.3)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('计数排序的时间复杂度是____。 [题246]', 'O(n+k)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('基数排序的时间复杂度是____。 [题247]', 'O(nk)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('桶排序的时间复杂度是____。 [题248]', 'O(n+k)', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('进程是资源分配的独立单位，线程是____调度的独立单位。 [题249]', 'CPU', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____命令用于查看当前工作目录。 [题250]', 'pwd', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____命令用于修改文件权限。 [题251]', 'chmod', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Shell脚本中，$#表示____个数。 [题252]', '参数', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('虚拟内存通过____表实现地址映射。 [题253]', '页', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('死锁的必要条件包括：互斥、占有并等待、不可抢占和____。 [题254]', '循环等待', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CPU调度的三种基本算法：先来先服务、时间片轮转和____。 [题255]', '优先级调度', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____命令用于查找文件。 [题256]', 'find', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('操作系统的四大基本功能：进程管理、内存管理、文件管理和____管理。 [题257]', '设备', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('____是操作系统将CPU时间划分成多个时间片，轮流分配给多个任务。 [题258]', '时间片轮转', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('进程的状态包括：创建、____、运行、阻塞和终止。 [题259]', '就绪', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('僵尸进程是子进程已退出但____未回收。 [题260]', '父进程', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('孤儿进程是父进程已退出但____仍在运行。 [题261]', '子进程', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('进程间通信方式包括：管道、消息队列、共享内存和____。 [题262]', 'Socket', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('线程间通信可以通过____变量实现。 [题263]', '共享', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('预防死锁的方法之一是破坏____条件。 [题264]', '占有并等待', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('银行家算法用于____死锁。 [题265]', '避免', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('页面置换算法包括：FIFO、LRU和____。 [题266]', 'Clock', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('FIFO算法可能出现____现象。 [题267]', 'Belady', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('LRU算法的全称是____。 [题268]', '最近最少使用', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('内存碎片包括____碎片和外部碎片。 [题269]', '内部', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('分页存储管理可以消除____碎片。 [题270]', '外部', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('分段存储管理符合____视角。 [题271]', '用户', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('虚拟内存使用____置换算法。 [题272]', '页面', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cache使用____替换策略。 [题273]', '局部性', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('时间局部性指____访问的地址近期还会访问。 [题274]', '最近', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('空间局部性指____访问的地址附近近期会访问。 [题275]', '最近', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，____系统调用用于创建进程。 [题276]', 'fork', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Linux中，exec函数族用于____进程映像。 [题277]', '替换', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('管道分为____管道和命名管道。 [题278]', '匿名', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('信号量用于进程____。 [题279]', '同步', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('互斥锁用于保护____资源。 [题280]', '临界', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('哲学家就餐问题说明____和资源竞争。 [题281]', '死锁', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('读者写者问题说明____同步。 [题282]', '读写', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('FCFS调度算法全称是____。 [题283]', '先来先服务', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SJF调度算法可能产生____。 [题284]', '饥饿', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('时间片轮转中，时间片过大会退化为____。 [题285]', 'FCFS', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('多级反馈队列调度综合考虑____时间和周转时间。 [题286]', '响应', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('实时系统调度算法包括RM和____。 [题287]', 'EDF', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('系统调用进入____执行。 [题288]', '内核', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('中断提高____效率。 [题289]', 'I/O', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('JavaScript中，null表示____，undefined表示未定义。 [题290]', '空值', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ES6的____语法用于声明常量。 [题291]', 'const', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSS Flex布局中，justify-content用于设置主轴对齐，____用于设置交叉轴对齐。 [题292]', 'align-items', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Vue的双向绑定基于____和数据劫持。 [题293]', '响应式', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('React的useState用于在函数组件中创建____。 [题294]', '状态变量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Promise有三种状态：pending、fulfilled和____。 [题295]', 'rejected', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSS的____属性用于设置元素在主轴上的增长因子。 [题296]', 'flex-grow', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTML5新增的语义化标签包括：article、section、nav和____。 [题297]', 'header', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('____是浏览器的一个安全机制，限制不同源之间的资源访问。 [题298]', '同源策略', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP请求中，____头用于传递CSRF Token。 [题299]', 'X-CSRF-Token', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ES6的let关键字具有____作用域。 [题300]', '块级', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('箭头函数没有自己的____。 [题301]', 'this', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('深拷贝可以使用JSON的____方法实现。 [题302]', 'parse和stringify', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('防抖函数在____后执行。 [题303]', '停止调用或延迟', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('节流函数在____内只执行一次。 [题304]', '一定时间', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Vuex是Vue的____状态管理。 [题305]', '集中式', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Pinia是Vue的____状态管理。 [题306]', '新一代', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('computed属性有____。 [题307]', '缓存', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('watch用于____变化。 [题308]', '监听', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Vue的生命周期钩子包括created、mounted、____和destroyed。 [题309]', 'updated', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TypeScript的____不必显式声明。 [题310]', '类型推断', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('interface和____都可以定义类型。 [题311]', 'type', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Webpack是____工具。 [题312]', '模块打包', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Vite基于____提供快速开发服务器。 [题313]', 'ESM', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Axios是基于____的HTTP客户端。 [题314]', 'Promise', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Fetch是浏览器的____API。 [题315]', '原生', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WebSocket支持____通信。 [题316]', '全双工', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的____属性限制在HTTPS发送。 [题317]', 'Secure', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SessionStorage生命周期为____。 [题318]', '窗口或会话', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('LocalStorage生命周期为____。 [题319]', '永久', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('跨域解决方案包括CORS、JSONP和____。 [题320]', '代理服务器', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cache-Control的max-age表示缓存最大____时间。 [题321]', '生存', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('BFC是____格式化上下文。 [题322]', '块级', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('清除浮动可以使用____属性。 [题323]', 'clear或overflow', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('伪类表示元素____。 [题324]', '状态', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('伪元素表示____内容。 [题325]', '生成或虚拟', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('box-sizing属性设置为border-box时，width包含____和border。 [题326]', 'padding', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('响应式布局可以使用媒体查询、Flex和____。 [题327]', 'Grid', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('移动端适配可以使用____单位。 [题328]', 'rem', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Retina屏幕使用____像素而非逻辑像素。 [题329]', '物理', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SVG是____图形格式。 [题330]', '矢量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker的核心组件包括：Docker daemon、Client、____和Container。 [题331]', 'Image', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('K8s中，Pod是最小的____单位。 [题332]', '调度', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Git中，____命令用于将文件添加到暂存区。 [题333]', 'git add', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Git中，____命令用于创建分支。 [题334]', 'git branch', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CI/CD中，CI指持续____，CD指持续____。 [题335]', '集成|部署', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Dockerfile的____指令用于声明容器监听的端口。 [题336]', 'EXPOSE', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('K8s中，____用于服务发现和负载均衡。 [题337]', 'Service', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker网络模式包括：bridge、host、none和____。 [题338]', 'container', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Helm是K8s的____管理器。 [题339]', '包', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker使用____技术实现资源隔离。 [题340]', '容器或namespace', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Dockerfile的FROM指令用于指定____镜像。 [题341]', '基础', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Dockerfile的COPY指令用于____文件到镜像。 [题342]', '复制', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Dockerfile的WORKDIR指令用于设置____目录。 [题343]', '工作', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Dockerfile的CMD指令用于____容器启动命令。 [题344]', '指定', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CMD和ENTRYPOINT的区别是CMD可被____。 [题345]', '覆盖', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker的Volume用于____持久化。 [题346]', '数据', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker bridge网络模式有独立____命名空间。 [题347]', '网络', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('K8s的Deployment用于管理____副本数。 [题348]', 'Pod', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('K8s的Service用于提供____和负载均衡。 [题349]', '服务发现', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('K8s的ConfigMap用于存储____数据。 [题350]', '配置', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('K8s的Secret用于存储____信息。 [题351]', '敏感', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Git的暂存区是____ Area。 [题352]', 'Staging', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Git中HEAD表示当前____的最新提交。 [题353]', '分支', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('git clone用于____仓库。 [题354]', '克隆', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('git commit用于____到本地仓库。 [题355]', '提交', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('git push用于____到远程仓库。 [题356]', '推送', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('git pull用于____并合并远程更新。 [题357]', '拉取', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('git merge和git____的区别是是否保留分支历史。 [题358]', 'rebase', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('git reset的--soft参数____暂存区。 [题359]', '保留', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('git reset的--hard参数重置____和暂存区。 [题360]', '工作区', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CI/CD的目标是自动化____、测试和部署。 [题361]', '构建', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Jenkins是____集成服务器。 [题362]', '持续', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('GitLab CI的流水线包括Stages、____和Steps。 [题363]', 'Jobs', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SonarQube用于____分析。 [题364]', '代码质量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Maven的生命周期包括clean、compile、test、package、install和____。 [题365]', 'deploy', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Gradle是基于____的构建工具。 [题366]', 'Groovy', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Docker Compose用于定义____容器应用。 [题367]', '多', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Prometheus用于____和告警。 [题368]', '监控', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Grafana用于____监控数据。 [题369]', '可视化', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ELK是日志____工具。 [题370]', '收集', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Istio是____网格。 [题371]', '服务', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，八种基本数据类型包括：byte、short、int、long、float、double、char和____。 [题372]', 'boolean', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，String类的length()方法返回的是____类型。 [题373]', 'int', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，使用____关键字来引用当前对象。 [题374]', 'this', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，静态方法使用____关键字修饰。 [题375]', 'static', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('抽象类不能直接____，需要通过继承创建子类对象。 [题376]', '实例化', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('接口中定义的变量默认是public static final，即____。 [题377]', '常量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('方法重写要求方法名、参数列表和____都要相同。 [题378]', '返回类型', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('异常处理的try-catch-finally块中，____块总会执行。 [题379]', 'finally', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Object类的toString()方法默认返回类的____和哈希码。 [题380]', '类名', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java的集合框架中，List接口的直接父接口是____。 [题381]', 'Collection', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HashMap的put方法返回值为null表示____。 [题382]', '插入成功或value为null', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ArrayList的默认初始容量是____。 [题383]', '10', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HashMap的默认初始容量是____。 [题384]', '16', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HashMap的负载因子默认是____。 [题385]', '0.75', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('二叉树的深度计算公式是log2(n+1)向下取整适用于____二叉树。 [题386]', '完全', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Java中，使用____关键字来定义泛型。 [题387]', 'T或泛型', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Java的自动装箱类型？____ [题388]', 'Integer', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪个是Java的多线程状态？____ [题389]', 'NEW、RUNNABLE、BLOCKED、WAITING、TIMED_WAITING、TERMINATED', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('synchronized关键字可以修饰____、方法和代码块。 [题390]', '代码块或成员变量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('volatile关键字保证变量的____可见性和禁止指令重排序。 [题391]', '可见性', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Object类的wait方法必须由____块调用。 [题392]', 'synchronized', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Thread类的____方法用于启动线程。 [题393]', 'start', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Runnable接口的____方法用于执行线程任务。 [题394]', 'run', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Future接口的____方法用于获取异步结果。 [题395]', 'get', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CompletableFuture的____方法用于异步执行任务。 [题396]', 'supplyAsync', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Lambda表达式省略了接口的____类型声明。 [题397]', '目标', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Stream的____方法用于过滤元素。 [题398]', 'filter', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Stream的____方法用于映射转换。 [题399]', 'map', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Stream的____方法用于排序。 [题400]', 'sorted', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Stream的____方法用于收集结果。 [题401]', 'collect', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Optional类的____方法用于获取值或默认值。 [题402]', 'orElse', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('LocalDateTime的____方法用于获取当前时间。 [题403]', 'now', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Duration的____方法用于计算时间间隔。 [题404]', 'between', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('BigDecimal的____方法用于加法运算。 [题405]', 'add', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('BigInteger的____方法用于比较大小。 [题406]', 'compareTo', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Pattern类的____方法用于编译正则表达式。 [题407]', 'compile', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Matcher类的____方法用于查找匹配。 [题408]', 'find', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Files类的____方法用于读取文件所有行。 [题409]', 'lines', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Path接口的____方法用于获取路径字符串。 [题410]', 'toString', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('System类的____方法用于复制数组。 [题411]', 'arraycopy', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Math类的____方法用于四舍五入。 [题412]', 'round', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL注入攻击利用了Web应用程序对用户输入____不充分验证的漏洞。 [题413]', '数据', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('参数化查询将SQL语句结构和____分离，防止注入。 [题414]', '数据', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('XSS攻击的三种类型：反射型、存储型和____型。 [题415]', 'DOM', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTML上下文中，需要对<、>、&字符进行____以防止XSS。 [题416]', '编码或转义', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSRF利用浏览器的____特性自动发送Cookie。 [题417]', '同源', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('同源策略的三要素：协议、域名和____。 [题418]', '端口', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WAF是Web应用____的缩写。 [题419]', '防火墙', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('敏感信息泄露可能通过错误信息、代码仓库和____等途径。 [题420]', '日志文件', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('防止CSRF的Token机制验证表单Token和____中Token的一致性。 [题421]', 'Session', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('安全的密码存储应使用加盐的____哈希算法。 [题422]', 'BCrypt', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('XSS攻击主要通过在页面中注入____脚本来获取用户信息。 [题423]', '恶意或JavaScript', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('存储型XSS的注入点通常包括____、用户资料等。 [题424]', '评论区', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DOM型XSS的注入点是浏览器的____代码。 [题425]', 'JavaScript', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HttpOnly属性可以防止____脚本访问Cookie。 [题426]', 'JavaScript', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CSP的____src指令用于限制JavaScript来源。 [题427]', 'script', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('X-Frame-Options头可以防止____劫持。 [题428]', '点击', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Samesite Cookie属性可以防止____攻击。 [题429]', 'CSRF', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SQL注入中，注释符是____。 [题430]', '--或#', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('UNION注入要求两个SELECT的____数相同。 [题431]', '列', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ORDER BY注入通过____数字确定列数。 [题432]', '递增', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('布尔盲注通过页面返回的____判断条件真假。 [题433]', '内容或状态', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('时间盲注利用____函数延长查询时间。 [题434]', 'SLEEP', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('堆叠查询使用____分隔多条SQL语句。 [题435]', '分号或;', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MyBatis中#{}使用____查询防止SQL注入。 [题436]', '参数化', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MyBatis中${}直接字符串替换，____不安全。 [题437]', '可能或存在风险', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('PreparedStatement通过预编译____结构来防止注入。 [题438]', 'SQL', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WAF是Web应用____，用于检测和阻止Web攻击。 [题439]', '防火墙', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('SSRF是服务器端____伪造，用于访问内网资源。 [题440]', '请求', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('水平越权是同权限用户访问____的资源。 [题441]', '他人', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('垂直越权是低权限用户获得____权限操作。 [题442]', '更高', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('文件上传漏洞的危害是上传____脚本执行命令。 [题443]', '恶意', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('MIME类型验证可以被修改____头绕过。 [题444]', 'Content-Type', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('命令注入是用户输入被当作____执行。 [题445]', '系统命令', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('00截断可以绕过____检查。 [题446]', '文件类型', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数字信封用对称密钥加密数据，用接收方的____加密对称密钥。 [题447]', '公钥', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS混合加密：非对称加密用于____，对称加密用于数据传输。 [题448]', '密钥交换', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('AES是____加密算法。 [题449]', '对称', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('RSA算法的安全性基于大数____的困难性。 [题450]', '分解', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('数字签名用于验证消息的完整性和____身份。 [题451]', '发送者', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('哈希函数具有单向性、确定性和____效应。 [题452]', '雪崩', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('PKI体系的核心是____。 [题453]', '数字证书', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('对称加密和非对称加密的主要区别是密钥____数量不同。 [题454]', '使用', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('BCrypt使用____算法存储密码。 [题455]', '自适应哈希', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('_argon2是哪种哈希算法？____ [题456]', 'Argon2', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('PBKDF2是____哈希算法。 [题457]', '基于密码', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Salt的作用是防止____攻击。 [题458]', '彩虹表', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('撞库攻击利用用户在多个网站使用相同____的习惯。 [题459]', '密码', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('暴破解使用____尝试登录。 [题460]', '字典或暴力', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('中间人攻击截获的是____加密的数据。 [题461]', '无', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS使用____协议加密。 [题462]', 'TLS', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HSTS头强制浏览器使用____访问。 [题463]', 'HTTPS', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HPKP头用于____固定防止中间人攻击。 [题464]', '公钥', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('X-Content-Type-Options头防止MIME____。 [题465]', '类型嗅探', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Referer头可以验证请求的____来源。 [题466]', 'Web', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CORS的origin头用于跨域请求____。 [题467]', '授权或验证', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('预检请求使用____HTTP方法。 [题468]', 'OPTIONS', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('JSONP缺乏____验证，存在安全风险。 [题469]', 'origin', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WebSocket没有____限制。 [题470]', '同源策略', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的____属性限制Cookie在HTTPS下发送。 [题471]', 'Secure', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Session和Cookie的主要区别是____位置不同。 [题472]', '存储', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP三次握手：SYN、____、ACK。 [题473]', 'SYN-ACK', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP四次挥手：FIN、____、FIN、ACK。 [题474]', 'ACK', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的____方法只获取响应头，不获取实体内容。 [题475]', 'HEAD', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTPS使用____协议进行加密。 [题476]', 'TLS', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的全称是____，主要工作端口是53。 [题477]', 'Domain Name System', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('Cookie的HttpOnly属性可以防止____访问Cookie。 [题478]', 'JavaScript', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('滑动窗口用于TCP的____控制。 [题479]', '流量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('IP地址分为____类和____类。 [题480]', 'A|B', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('路由选择协议中，RIP基于____算法。 [题481]', '距离向量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ARP协议用于将____地址解析为IP地址。 [题482]', 'MAC', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('ICMP的____请求用于ping命令。 [题483]', 'Echo', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('TCP的滑动窗口用于____控制。 [题484]', '流量', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('UDP的____头部只有8字节。 [题485]', '首部', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP状态码404表示____未找到。 [题486]', '资源', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP状态码500表示____错误。 [题487]', '服务器', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP状态码200表示____成功。 [题488]', '请求', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP状态码301表示____重定向。 [题489]', '永久', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP状态码302表示____重定向。 [题490]', '临时', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的Keep-Alive用于____连接。 [题491]', '持久', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的____编码用于分块传输。 [题492]', 'Chunked', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的Cache-Control用于____控制。 [题493]', '缓存', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP的ETag用于资源____标识。 [题494]', '版本', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('CORS的预检请求使用____方法。 [题495]', 'OPTIONS', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('WebSocket的协议是____或wss。 [题496]', 'ws', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP/2支持____复用。 [题497]', '多路', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP/2头部使用____压缩。 [题498]', 'HPACK', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('HTTP/3使用____协议。 [题499]', 'QUIC', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('DNS的A记录用于域名指向____地址。 [题500]', 'IPv4', 1, 10, '', '', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Java的基本数据类型？ [题1]', 'A,C,D,F', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'byte、short、int、long、float、double、char、boolean', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些修饰符可以修饰类？ [题2]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'public、abstract、final', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是创建线程的方式？ [题3]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '继承Thread、实现Runnable、实现Callable、线程池', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Collection接口的方法？ [题4]', 'A,B,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'add、remove、size、clear', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是fail-fast的特性？ [题5]', 'A,B,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'ArrayList、HashMap、Vector的迭代器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是SOLID原则的内容？ [题6]', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '单一职责、开闭、里氏替换、接口隔离、依赖倒置', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Java 8的新特性？ [题7]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Lambda、Stream、Optional、接口default方法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是java.util.concurrent包下的类？ [题8]', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'ConcurrentHashMap、CopyOnWriteArrayList、LongAdder、Semaphore、CountDownLatch', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是线程安全的类？ [题9]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Vector、Hashtable、ConcurrentHashMap、CopyOnWriteArrayList', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Object类的方法？ [题10]', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'equals、hashCode、toString、getClass、notify、wait', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是String类的方法？ [题11]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'length、charAt、substring、indexOf、replace', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是ArrayList的特点？ [题12]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '基于数组、线程不安全、支持随机访问', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是LinkedList的特点？ [题13]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '基于双向链表、线程不安全、插入删除效率高、可作为栈或队列', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是HashMap的扩容条件？ [题14]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '元素数量超过capacity*loadFactor、链表长度超过8', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是ConcurrentHashMap的并发机制？ [题15]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '分段锁、CAS、volatile', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是CompletableFuture的方法？ [题16]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'thenApply、thenCompose、exceptionally、join', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Stream的中间操作？ [题17]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'filter、map、flatMap、distinct、sorted', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Stream的终端操作？ [题18]', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'collect、reduce、forEach、count、toArray', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Optional的方法？ [题19]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'of、empty、isPresent、get、orElse', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是LocalDateTime的获取方法？ [题20]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'now、of、getYear、getMonth、getDayOfMonth', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是 Duration的单位？ [题21]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '秒、毫秒、微秒、纳秒', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些可以有效防御SQL注入？ [题22]', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '参数化查询、输入验证、ORM框架、最小权限、错误处理', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是XSS的攻击类型？ [题23]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '反射型、存储型、DOM型', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是CSRF的防护措施？ [题24]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Referer验证、Token、SameSite Cookie、验证码', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是安全的密码存储方式？ [题25]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'BCrypt、PBKDF2', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是HTTP安全头？ [题26]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Content-Security-Policy、X-Frame-Options、HSTS、X-XSS-Protection', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是同源策略的三要素？ [题27]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '协议、域名、端口', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是CSRF的特征？ [题28]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '利用用户已登录状态、伪造请求、第三方站点发起', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是XSS的防护措施？ [题29]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '输入验证、输出编码、CSP、HttpOnly Cookie', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是SSRF的危害？ [题30]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '访问内网数据、扫描端口、攻击内部服务、读取本地文件', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是文件上传的安全措施？ [题31]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '文件类型验证、文件内容检测、重命名文件、隔离存储', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是MyBatis防止SQL注入的方式？ [题32]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '使用#{}、使用bind标签', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Redis的安全措施？ [题33]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '设置密码、绑定IP、禁用危险命令', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是防止撞库的方法？ [题34]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '验证码、账号锁定、IP封禁、密码强度要求', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是中间人攻击的防护？ [题35]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'HTTPS、数字证书、证书校验', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是WebSocket的安全措施？ [题36]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '验证origin、使用wss、Token认证', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是JSONP的安全风险？ [题37]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '缺乏origin验证、数据泄露、可能被劫持', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是CORS的安全配置？ [题38]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '指定具体origin、credentials设置、限制Methods', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Clickjacking的防护？ [题39]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'X-Frame-Options、CSP、Frame-breaking脚本', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是敏感信息保护措施？ [题40]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '加密存储、脱敏展示、访问控制、日志审计', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是安全开发的原则？ [题41]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '最小权限、纵深防御、安全默认值、Fail Secure', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是MySQL的存储引擎？ [题42]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'InnoDB、MyISAM、MEMORY、ARCHIVE', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是事务的ACID特性？ [题43]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '原子性、一致性、隔离性、持久性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是索引的类型？ [题44]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '主键索引、唯一索引、普通索引、全文索引', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是数据库隔离级别？ [题45]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'READ UNCOMMITTED、READ COMMITTED、REPEATABLE READ、SERIALIZABLE', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是SQL的聚合函数？ [题46]', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'COUNT、SUM、AVG、MAX、MIN', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是JOIN的类型？ [题47]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'INNER JOIN、LEFT JOIN、RIGHT JOIN、FULL OUTER JOIN', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Redis的数据类型？ [题48]', 'A,B,C,D,E,F', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'String、List、Set、ZSet、Hash、HyperLogLog', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Redis的持久化方式？ [题49]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'RDB、AOF', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Redis的应用场景？ [题50]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '缓存、Session存储、排行榜、消息队列', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是数据库设计范式？ [题51]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '第一范式、第二范式、第三范式', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是MySQL的优化方向？ [题52]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '索引优化、查询优化、表结构优化、架构优化', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是分库分表的方式？ [题53]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '水平分库、垂直分库、水平分表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是读写分离的实现方式？ [题54]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '主从复制、数据库中间件、应用层分派', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是SQL优化技巧？ [题55]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '避免SELECT *、使用覆盖索引、减少JOIN、使用分页', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是数据库连接池的作用？ [题56]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '减少连接创建开销、提高并发、管理连接生命周期、支持高并发', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是NoSQL数据库的特点？ [题57]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '高性能、高可用、灵活的数据模型', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是MongoDB的特点？ [题58]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '文档存储、水平扩展、丰富的查询语言、高可用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Redis的部署模式？ [题59]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '单机、主从、哨兵、集群', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是MongoDB的索引类型？ [题60]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '单字段索引、复合索引、文本索引、地理位置索引', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是数据库备份类型？ [题61]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '全量备份、增量备份、差异备份', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是TCP的可靠传输机制？ [题62]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '确认、超时重传、流量控制、拥塞控制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是HTTP的方法？ [题63]', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'GET、POST、PUT、DELETE、PATCH', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是HTTP状态码的类别？ [题64]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '1xx信息、2xx成功、3xx重定向、4xx客户端错误、5xx服务器错误', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是DNS的记录类型？ [题65]', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'A、AAAA、CNAME、MX、NS、TXT', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是WebSocket的特点？ [题66]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '全双工、低延迟、基于TCP持久连接、跨域通信', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是HTTPS的加密机制？ [题67]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '非对称加密交换密钥、对称加密传输数据、数字证书验证身份', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是CDN的作用？ [题68]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '加速访问、减轻源站压力、防御DDoS、就近访问', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是HTTP/2的特性？ [题69]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '多路复用、服务器推送、header压缩、流优先级', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是TCP三次握手的状态变化？ [题70]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'SYN-SENT、SYN-RECEIVED、ESTABLISHED', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是TCP四次挥手的状态变化？ [题71]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'FIN-WAIT-1、FIN-WAIT-2、CLOSE-WAIT、TIME-WAIT', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是跨域请求的解决方案？ [题72]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'CORS、JSONP、代理服务器、WebSocket', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Cookie的安全属性？ [题73]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Secure、HttpOnly、SameSite、Path', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是HTTP缓存的策略？ [题74]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Cache-Control、ETag、Last-Modified、Pragma', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是TCP和UDP的区别？ [题75]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '连接vs无连接、可靠vs不可靠、有序vs无序、拥塞控制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是常用端口号？ [题76]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'SSH(22)、HTTP(80)、HTTPS(443)、MySQL(3306)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是网络协议的分层？ [题77]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '应用层、传输层、网络层、数据链路层', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是ping命令使用的协议？ [题78]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'ICMP、IP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是ARP的作用？ [题79]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '将IP地址解析为MAC地址、维护ARP缓存', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是路由选择协议？ [题80]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'RIP、OSPF、BGP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是防火墙的功能？ [题81]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '包过滤、状态检测、应用网关、深度检测', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是稳定的排序算法？ [题82]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '归并排序、冒泡排序、插入排序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是不稳定的排序算法？ [题83]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '快速排序、选择排序、堆排序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是常见的数据结构？ [题84]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '数组、链表、树、图、哈希表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是树的特点？ [题85]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '层次结构、节点度、根节点、叶节点', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是二叉树的遍历方式？ [题86]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '前序、中序、后序、层序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是图的基本概念？ [题87]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '顶点、边、有向图、无向图', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是图的存储方式？ [题88]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '邻接矩阵、邻接表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是图的遍历算法？ [题89]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'DFS、BFS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是动态规划的条件？ [题90]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '最优子结构、重叠子问题', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是回溯算法的特征？ [题91]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '尝试所有可能、剪枝、回溯', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是贪心算法的特征？ [题92]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '局部最优、全局最优', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是分治算法的步骤？ [题93]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '分解、解决、合并', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是常见的设计模式？ [题94]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '单例、工厂、观察者、策略', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是时间复杂度从低到高的排序？ [题95]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'O(1)、O(log n)、O(n)、O(n log n)、O(n^2)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是空间复杂度为O(1)的排序？ [题96]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '冒泡、插入、选择', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是哈希表解决冲突的方法？ [题97]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '链地址法、开放地址法、再哈希法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是B树的特征？ [题98]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '多路平衡、每个节点多个键、子树数量有范围', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是红黑树的特征？ [题99]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '节点红色或黑色、根节点黑色、叶子节点黑色、红色节点子节点黑色', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是并查集的操作？ [题100]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'find、union', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Top K问题的解法？ [题101]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '堆、快速选择', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是进程的状态？ [题102]', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '创建、就绪、运行、阻塞、终止', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是进程间通信方式？ [题103]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '管道、消息队列、共享内存、Socket', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是线程的状态？ [题104]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'NEW、RUNNABLE、BLOCKED、WAITING、TIMED_WAITING、TERMINATED', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是死锁的必要条件？ [题105]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '互斥、占有并等待、不可抢占、循环等待', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是预防死锁的方法？ [题106]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '破坏占有并等待、破坏不可抢占、破坏循环等待', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是页面置换算法？ [题107]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'FIFO、LRU、OPT、Clock', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是CPU调度算法？ [题108]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'FCFS、SJF、RR、多级反馈队列', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是磁盘调度算法？ [题109]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'FCFS、SSTF、SCAN、C-SCAN', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是银行家算法的数据结构？ [题110]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Available、Max、Allocation、Need', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是操作系统的基本功能？ [题111]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '进程管理、内存管理、文件管理、设备管理', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Linux的进程状态？ [题112]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '运行、睡眠、停止、僵尸', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Shell的特殊变量？ [题113]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '$0、$1、$#、$$、$?', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Linux的IO模型？ [题114]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '阻塞IO、非阻塞IO、IO多路复用、异步IO', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是虚拟内存的作用？ [题115]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '扩展地址空间、提供内存保护、实现内存映射', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Cache的替换策略？ [题116]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'FIFO、LRU、LFU', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是同步机制？ [题117]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '信号量、互斥锁、条件变量、屏障', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是死锁的处理方法？ [题118]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '预防、避免、检测解除', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是内存管理的方式？ [题119]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '连续分配、分页、分段、分页+分段', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是SPOOLing技术的组成？ [题120]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '输入井、输出井、输入缓冲、输出缓冲', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是操作系统的结构？ [题121]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '单体结构、层次结构、微内核、模块化', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是JavaScript的数据类型？ [题122]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'string、number、boolean、null、undefined、object', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是ES6的新特性？ [题123]', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'let/const、箭头函数、模板字符串、解构、模块', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Promise的方法？ [题124]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'then、catch、finally、race、all', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Vue的指令？ [题125]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'v-if、v-for、v-bind、v-on、v-model', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是React的Hook？ [题126]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'useState、useEffect、useContext、useRef', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是CSS的盒子属性？ [题127]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'content、padding、border、margin', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Flex布局的属性？ [题128]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'flex-direction、justify-content、align-items、flex-wrap', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Grid布局的属性？ [题129]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'grid-template-columns、grid-template-rows、gap、grid-area', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是HTTP状态码的类别？ [题130]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '1xx信息、2xx成功、3xx重定向、4xx客户端错误、5xx服务器错误', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是跨域的解决方案？ [题131]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'CORS、JSONP、代理服务器、WebSocket', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是浏览器存储的方式？ [题132]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Cookie、SessionStorage、LocalStorage', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Vuex的属性？ [题133]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'state、getters、mutations、actions、modules', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是TypeScript的类型？ [题134]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'string、number、boolean、any、void、never', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Webpack的加载器？ [题135]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'css-loader、babel-loader、ts-loader、file-loader', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Webpack的插件？ [题136]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'HtmlWebpackPlugin、CleanWebpackPlugin、UglifyJsPlugin', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是HTTP的请求头？ [题137]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Content-Type、Authorization、Cookie、User-Agent', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是HTTP的响应头？ [题138]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Set-Cookie、Cache-Control、ETag、Last-Modified', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是异步编程的方式？ [题139]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '回调、Promise、async/await、Generator', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是性能优化的方法？ [题140]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '减少请求、压缩资源、缓存、代码分割', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是前端安全措施？ [题141]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'XSS防护、CSRF防护、SQL注入防护、点击劫持防护', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Docker的核心组件？ [题142]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Client、Docker daemon、Registry、Container', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Dockerfile的指令？ [题143]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'FROM、COPY、RUN、CMD、EXPOSE', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Docker的网络模式？ [题144]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'bridge、host、none、container', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Kubernetes的资源对象？ [题145]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Pod、Deployment、Service、ConfigMap', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Git的常用命令？ [题146]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'clone、add、commit、push、pull', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Git的操作？ [题147]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'merge、rebase、reset、stash', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是CI/CD的工具？ [题148]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Jenkins、GitLab CI、Travis CI、CircleCI', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Docker的数据持久化方式？ [题149]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Volume、bind mount', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Kubernetes的Ingress？ [题150]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'HTTP代理、HTTPS终止、域名-based routing', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Prometheus的指标类型？ [题151]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Counter、Gauge、Histogram、Summary', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是容器编排工具？ [题152]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Kubernetes、Docker Swarm、Mesos、Nomad', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是代码质量工具？ [题153]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'SonarQube、ESLint、Checkstyle', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是日志收集工具？ [题154]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'ELK、Fluentd、Loki、Prometheus', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是配置管理工具？ [题155]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Ansible、Chef、Puppet、SaltStack', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是基础设施即代码工具？ [题156]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Terraform、CloudFormation、Pulumi', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是容器安全措施？ [题157]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'User namespace、Capabilities、Seccomp、AppArmor', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是K8s的Service类型？ [题158]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'ClusterIP、NodePort、LoadBalancer、ExternalName', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Helm的概念？ [题159]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Chart、Repository、Release', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Docker Compose的服务？ [题160]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'build、image、ports、volumes', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是微服务架构的特点？ [题161]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '独立部署、技术多样性、容错隔离、康威定律', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Java的基本数据类型？ [题162]', 'A,C,D,F', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'byte、short、int、long、float、double、char、boolean', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些修饰符可以修饰类？ [题163]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'public、abstract、final', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是创建线程的方式？ [题164]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '继承Thread、实现Runnable、实现Callable、线程池', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Collection接口的方法？ [题165]', 'A,B,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'add、remove、size、clear', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是fail-fast的特性？ [题166]', 'A,B,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'ArrayList、HashMap、Vector的迭代器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是SOLID原则的内容？ [题167]', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '单一职责、开闭、里氏替换、接口隔离、依赖倒置', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Java 8的新特性？ [题168]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Lambda、Stream、Optional、接口default方法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是java.util.concurrent包下的类？ [题169]', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'ConcurrentHashMap、CopyOnWriteArrayList、LongAdder、Semaphore、CountDownLatch', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是线程安全的类？ [题170]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Vector、Hashtable、ConcurrentHashMap、CopyOnWriteArrayList', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Object类的方法？ [题171]', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'equals、hashCode、toString、getClass、notify、wait', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是String类的方法？ [题172]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'length、charAt、substring、indexOf、replace', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是ArrayList的特点？ [题173]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '基于数组、线程不安全、支持随机访问', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是LinkedList的特点？ [题174]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '基于双向链表、线程不安全、插入删除效率高、可作为栈或队列', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是HashMap的扩容条件？ [题175]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '元素数量超过capacity*loadFactor、链表长度超过8', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是ConcurrentHashMap的并发机制？ [题176]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '分段锁、CAS、volatile', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是CompletableFuture的方法？ [题177]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'thenApply、thenCompose、exceptionally、join', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Stream的中间操作？ [题178]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'filter、map、flatMap、distinct、sorted', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Stream的终端操作？ [题179]', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'collect、reduce、forEach、count、toArray', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Optional的方法？ [题180]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'of、empty、isPresent、get、orElse', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是LocalDateTime的获取方法？ [题181]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'now、of、getYear、getMonth、getDayOfMonth', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是 Duration的单位？ [题182]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '秒、毫秒、微秒、纳秒', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些可以有效防御SQL注入？ [题183]', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '参数化查询、输入验证、ORM框架、最小权限、错误处理', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是XSS的攻击类型？ [题184]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '反射型、存储型、DOM型', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是CSRF的防护措施？ [题185]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Referer验证、Token、SameSite Cookie、验证码', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是安全的密码存储方式？ [题186]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'BCrypt、PBKDF2', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是HTTP安全头？ [题187]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Content-Security-Policy、X-Frame-Options、HSTS、X-XSS-Protection', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是同源策略的三要素？ [题188]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '协议、域名、端口', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是CSRF的特征？ [题189]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '利用用户已登录状态、伪造请求、第三方站点发起', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是XSS的防护措施？ [题190]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '输入验证、输出编码、CSP、HttpOnly Cookie', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是SSRF的危害？ [题191]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '访问内网数据、扫描端口、攻击内部服务、读取本地文件', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是文件上传的安全措施？ [题192]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '文件类型验证、文件内容检测、重命名文件、隔离存储', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是MyBatis防止SQL注入的方式？ [题193]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '使用#{}、使用bind标签', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Redis的安全措施？ [题194]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '设置密码、绑定IP、禁用危险命令', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是防止撞库的方法？ [题195]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '验证码、账号锁定、IP封禁、密码强度要求', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是中间人攻击的防护？ [题196]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'HTTPS、数字证书、证书校验', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是WebSocket的安全措施？ [题197]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '验证origin、使用wss、Token认证', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是JSONP的安全风险？ [题198]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '缺乏origin验证、数据泄露、可能被劫持', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是CORS的安全配置？ [题199]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '指定具体origin、credentials设置、限制Methods', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Clickjacking的防护？ [题200]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'X-Frame-Options、CSP、Frame-breaking脚本', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是敏感信息保护措施？ [题201]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '加密存储、脱敏展示、访问控制、日志审计', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是安全开发的原则？ [题202]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '最小权限、纵深防御、安全默认值、Fail Secure', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是MySQL的存储引擎？ [题203]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'InnoDB、MyISAM、MEMORY、ARCHIVE', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是事务的ACID特性？ [题204]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '原子性、一致性、隔离性、持久性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是索引的类型？ [题205]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '主键索引、唯一索引、普通索引、全文索引', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是数据库隔离级别？ [题206]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'READ UNCOMMITTED、READ COMMITTED、REPEATABLE READ、SERIALIZABLE', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是SQL的聚合函数？ [题207]', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'COUNT、SUM、AVG、MAX、MIN', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是JOIN的类型？ [题208]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'INNER JOIN、LEFT JOIN、RIGHT JOIN、FULL OUTER JOIN', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Redis的数据类型？ [题209]', 'A,B,C,D,E,F', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'String、List、Set、ZSet、Hash、HyperLogLog', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Redis的持久化方式？ [题210]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'RDB、AOF', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Redis的应用场景？ [题211]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '缓存、Session存储、排行榜、消息队列', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是数据库设计范式？ [题212]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '第一范式、第二范式、第三范式', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是MySQL的优化方向？ [题213]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '索引优化、查询优化、表结构优化、架构优化', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是分库分表的方式？ [题214]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '水平分库、垂直分库、水平分表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是读写分离的实现方式？ [题215]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '主从复制、数据库中间件、应用层分派', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是SQL优化技巧？ [题216]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '避免SELECT *、使用覆盖索引、减少JOIN、使用分页', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是数据库连接池的作用？ [题217]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '减少连接创建开销、提高并发、管理连接生命周期、支持高并发', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是NoSQL数据库的特点？ [题218]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '高性能、高可用、灵活的数据模型', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是MongoDB的特点？ [题219]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '文档存储、水平扩展、丰富的查询语言、高可用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Redis的部署模式？ [题220]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '单机、主从、哨兵、集群', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是MongoDB的索引类型？ [题221]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '单字段索引、复合索引、文本索引、地理位置索引', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是数据库备份类型？ [题222]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '全量备份、增量备份、差异备份', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是TCP的可靠传输机制？ [题223]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '确认、超时重传、流量控制、拥塞控制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是HTTP的方法？ [题224]', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'GET、POST、PUT、DELETE、PATCH', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是HTTP状态码的类别？ [题225]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '1xx信息、2xx成功、3xx重定向、4xx客户端错误、5xx服务器错误', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是DNS的记录类型？ [题226]', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'A、AAAA、CNAME、MX、NS、TXT', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是WebSocket的特点？ [题227]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '全双工、低延迟、基于TCP持久连接、跨域通信', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是HTTPS的加密机制？ [题228]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '非对称加密交换密钥、对称加密传输数据、数字证书验证身份', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是CDN的作用？ [题229]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '加速访问、减轻源站压力、防御DDoS、就近访问', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是HTTP/2的特性？ [题230]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '多路复用、服务器推送、header压缩、流优先级', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是TCP三次握手的状态变化？ [题231]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'SYN-SENT、SYN-RECEIVED、ESTABLISHED', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是TCP四次挥手的状态变化？ [题232]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'FIN-WAIT-1、FIN-WAIT-2、CLOSE-WAIT、TIME-WAIT', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是跨域请求的解决方案？ [题233]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'CORS、JSONP、代理服务器、WebSocket', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Cookie的安全属性？ [题234]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Secure、HttpOnly、SameSite、Path', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是HTTP缓存的策略？ [题235]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Cache-Control、ETag、Last-Modified、Pragma', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是TCP和UDP的区别？ [题236]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '连接vs无连接、可靠vs不可靠、有序vs无序、拥塞控制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是常用端口号？ [题237]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'SSH(22)、HTTP(80)、HTTPS(443)、MySQL(3306)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是网络协议的分层？ [题238]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '应用层、传输层、网络层、数据链路层', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是ping命令使用的协议？ [题239]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'ICMP、IP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是ARP的作用？ [题240]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '将IP地址解析为MAC地址、维护ARP缓存', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是路由选择协议？ [题241]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'RIP、OSPF、BGP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是防火墙的功能？ [题242]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '包过滤、状态检测、应用网关、深度检测', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是稳定的排序算法？ [题243]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '归并排序、冒泡排序、插入排序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是不稳定的排序算法？ [题244]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '快速排序、选择排序、堆排序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是常见的数据结构？ [题245]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '数组、链表、树、图、哈希表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是树的特点？ [题246]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '层次结构、节点度、根节点、叶节点', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是二叉树的遍历方式？ [题247]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '前序、中序、后序、层序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是图的基本概念？ [题248]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '顶点、边、有向图、无向图', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是图的存储方式？ [题249]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '邻接矩阵、邻接表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是图的遍历算法？ [题250]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'DFS、BFS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是动态规划的条件？ [题251]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '最优子结构、重叠子问题', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是回溯算法的特征？ [题252]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '尝试所有可能、剪枝、回溯', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是贪心算法的特征？ [题253]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '局部最优、全局最优', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是分治算法的步骤？ [题254]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '分解、解决、合并', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是常见的设计模式？ [题255]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '单例、工厂、观察者、策略', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是时间复杂度从低到高的排序？ [题256]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'O(1)、O(log n)、O(n)、O(n log n)、O(n^2)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是空间复杂度为O(1)的排序？ [题257]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '冒泡、插入、选择', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是哈希表解决冲突的方法？ [题258]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '链地址法、开放地址法、再哈希法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是B树的特征？ [题259]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '多路平衡、每个节点多个键、子树数量有范围', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是红黑树的特征？ [题260]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '节点红色或黑色、根节点黑色、叶子节点黑色、红色节点子节点黑色', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是并查集的操作？ [题261]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'find、union', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Top K问题的解法？ [题262]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '堆、快速选择', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是进程的状态？ [题263]', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '创建、就绪、运行、阻塞、终止', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是进程间通信方式？ [题264]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '管道、消息队列、共享内存、Socket', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是线程的状态？ [题265]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'NEW、RUNNABLE、BLOCKED、WAITING、TIMED_WAITING、TERMINATED', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是死锁的必要条件？ [题266]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '互斥、占有并等待、不可抢占、循环等待', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是预防死锁的方法？ [题267]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '破坏占有并等待、破坏不可抢占、破坏循环等待', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是页面置换算法？ [题268]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'FIFO、LRU、OPT、Clock', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是CPU调度算法？ [题269]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'FCFS、SJF、RR、多级反馈队列', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是磁盘调度算法？ [题270]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'FCFS、SSTF、SCAN、C-SCAN', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是银行家算法的数据结构？ [题271]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Available、Max、Allocation、Need', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是操作系统的基本功能？ [题272]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '进程管理、内存管理、文件管理、设备管理', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Linux的进程状态？ [题273]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '运行、睡眠、停止、僵尸', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Shell的特殊变量？ [题274]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '$0、$1、$#、$$、$?', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Linux的IO模型？ [题275]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '阻塞IO、非阻塞IO、IO多路复用、异步IO', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是虚拟内存的作用？ [题276]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '扩展地址空间、提供内存保护、实现内存映射', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Cache的替换策略？ [题277]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'FIFO、LRU、LFU', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是同步机制？ [题278]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '信号量、互斥锁、条件变量、屏障', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是死锁的处理方法？ [题279]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '预防、避免、检测解除', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是内存管理的方式？ [题280]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '连续分配、分页、分段、分页+分段', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是SPOOLing技术的组成？ [题281]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '输入井、输出井、输入缓冲、输出缓冲', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是操作系统的结构？ [题282]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '单体结构、层次结构、微内核、模块化', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是JavaScript的数据类型？ [题283]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'string、number、boolean、null、undefined、object', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是ES6的新特性？ [题284]', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'let/const、箭头函数、模板字符串、解构、模块', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Promise的方法？ [题285]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'then、catch、finally、race、all', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Vue的指令？ [题286]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'v-if、v-for、v-bind、v-on、v-model', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是React的Hook？ [题287]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'useState、useEffect、useContext、useRef', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是CSS的盒子属性？ [题288]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'content、padding、border、margin', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Flex布局的属性？ [题289]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'flex-direction、justify-content、align-items、flex-wrap', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Grid布局的属性？ [题290]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'grid-template-columns、grid-template-rows、gap、grid-area', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是HTTP状态码的类别？ [题291]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '1xx信息、2xx成功、3xx重定向、4xx客户端错误、5xx服务器错误', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是跨域的解决方案？ [题292]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'CORS、JSONP、代理服务器、WebSocket', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是浏览器存储的方式？ [题293]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Cookie、SessionStorage、LocalStorage', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Vuex的属性？ [题294]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'state、getters、mutations、actions、modules', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是TypeScript的类型？ [题295]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'string、number、boolean、any、void、never', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Webpack的加载器？ [题296]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'css-loader、babel-loader、ts-loader、file-loader', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Webpack的插件？ [题297]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'HtmlWebpackPlugin、CleanWebpackPlugin、UglifyJsPlugin', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是HTTP的请求头？ [题298]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Content-Type、Authorization、Cookie、User-Agent', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是HTTP的响应头？ [题299]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Set-Cookie、Cache-Control、ETag、Last-Modified', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是异步编程的方式？ [题300]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '回调、Promise、async/await、Generator', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是性能优化的方法？ [题301]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '减少请求、压缩资源、缓存、代码分割', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是前端安全措施？ [题302]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'XSS防护、CSRF防护、SQL注入防护、点击劫持防护', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Docker的核心组件？ [题303]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Client、Docker daemon、Registry、Container', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Dockerfile的指令？ [题304]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'FROM、COPY、RUN、CMD、EXPOSE', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Docker的网络模式？ [题305]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'bridge、host、none、container', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Kubernetes的资源对象？ [题306]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Pod、Deployment、Service、ConfigMap', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Git的常用命令？ [题307]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'clone、add、commit、push、pull', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Git的操作？ [题308]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'merge、rebase、reset、stash', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是CI/CD的工具？ [题309]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Jenkins、GitLab CI、Travis CI、CircleCI', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Docker的数据持久化方式？ [题310]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Volume、bind mount', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Kubernetes的Ingress？ [题311]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'HTTP代理、HTTPS终止、域名-based routing', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Prometheus的指标类型？ [题312]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Counter、Gauge、Histogram、Summary', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是容器编排工具？ [题313]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Kubernetes、Docker Swarm、Mesos、Nomad', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是代码质量工具？ [题314]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'SonarQube、ESLint、Checkstyle', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是日志收集工具？ [题315]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'ELK、Fluentd、Loki、Prometheus', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是配置管理工具？ [题316]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Ansible、Chef、Puppet、SaltStack', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是基础设施即代码工具？ [题317]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Terraform、CloudFormation、Pulumi', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是容器安全措施？ [题318]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'User namespace、Capabilities、Seccomp、AppArmor', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是K8s的Service类型？ [题319]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'ClusterIP、NodePort、LoadBalancer、ExternalName', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Helm的概念？ [题320]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Chart、Repository、Release', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Docker Compose的服务？ [题321]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'build、image、ports、volumes', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是微服务架构的特点？ [题322]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '独立部署、技术多样性、容错隔离、康威定律', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Java的基本数据类型？ [题323]', 'A,C,D,F', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'byte、short、int、long、float、double、char、boolean', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些修饰符可以修饰类？ [题324]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'public、abstract、final', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是创建线程的方式？ [题325]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '继承Thread、实现Runnable、实现Callable、线程池', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Collection接口的方法？ [题326]', 'A,B,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'add、remove、size、clear', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是fail-fast的特性？ [题327]', 'A,B,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'ArrayList、HashMap、Vector的迭代器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是SOLID原则的内容？ [题328]', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '单一职责、开闭、里氏替换、接口隔离、依赖倒置', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Java 8的新特性？ [题329]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Lambda、Stream、Optional、接口default方法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是java.util.concurrent包下的类？ [题330]', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'ConcurrentHashMap、CopyOnWriteArrayList、LongAdder、Semaphore、CountDownLatch', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是线程安全的类？ [题331]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Vector、Hashtable、ConcurrentHashMap、CopyOnWriteArrayList', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Object类的方法？ [题332]', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'equals、hashCode、toString、getClass、notify、wait', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是String类的方法？ [题333]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'length、charAt、substring、indexOf、replace', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是ArrayList的特点？ [题334]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '基于数组、线程不安全、支持随机访问', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是LinkedList的特点？ [题335]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '基于双向链表、线程不安全、插入删除效率高、可作为栈或队列', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是HashMap的扩容条件？ [题336]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '元素数量超过capacity*loadFactor、链表长度超过8', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是ConcurrentHashMap的并发机制？ [题337]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '分段锁、CAS、volatile', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是CompletableFuture的方法？ [题338]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'thenApply、thenCompose、exceptionally、join', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Stream的中间操作？ [题339]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'filter、map、flatMap、distinct、sorted', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Stream的终端操作？ [题340]', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'collect、reduce、forEach、count、toArray', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Optional的方法？ [题341]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'of、empty、isPresent、get、orElse', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是LocalDateTime的获取方法？ [题342]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'now、of、getYear、getMonth、getDayOfMonth', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是 Duration的单位？ [题343]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '秒、毫秒、微秒、纳秒', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些可以有效防御SQL注入？ [题344]', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '参数化查询、输入验证、ORM框架、最小权限、错误处理', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是XSS的攻击类型？ [题345]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '反射型、存储型、DOM型', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是CSRF的防护措施？ [题346]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Referer验证、Token、SameSite Cookie、验证码', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是安全的密码存储方式？ [题347]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'BCrypt、PBKDF2', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是HTTP安全头？ [题348]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Content-Security-Policy、X-Frame-Options、HSTS、X-XSS-Protection', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是同源策略的三要素？ [题349]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '协议、域名、端口', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是CSRF的特征？ [题350]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '利用用户已登录状态、伪造请求、第三方站点发起', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是XSS的防护措施？ [题351]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '输入验证、输出编码、CSP、HttpOnly Cookie', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是SSRF的危害？ [题352]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '访问内网数据、扫描端口、攻击内部服务、读取本地文件', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是文件上传的安全措施？ [题353]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '文件类型验证、文件内容检测、重命名文件、隔离存储', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是MyBatis防止SQL注入的方式？ [题354]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '使用#{}、使用bind标签', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Redis的安全措施？ [题355]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '设置密码、绑定IP、禁用危险命令', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是防止撞库的方法？ [题356]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '验证码、账号锁定、IP封禁、密码强度要求', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是中间人攻击的防护？ [题357]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'HTTPS、数字证书、证书校验', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是WebSocket的安全措施？ [题358]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '验证origin、使用wss、Token认证', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是JSONP的安全风险？ [题359]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '缺乏origin验证、数据泄露、可能被劫持', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是CORS的安全配置？ [题360]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '指定具体origin、credentials设置、限制Methods', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Clickjacking的防护？ [题361]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'X-Frame-Options、CSP、Frame-breaking脚本', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是敏感信息保护措施？ [题362]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '加密存储、脱敏展示、访问控制、日志审计', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是安全开发的原则？ [题363]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '最小权限、纵深防御、安全默认值、Fail Secure', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是MySQL的存储引擎？ [题364]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'InnoDB、MyISAM、MEMORY、ARCHIVE', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是事务的ACID特性？ [题365]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '原子性、一致性、隔离性、持久性', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是索引的类型？ [题366]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '主键索引、唯一索引、普通索引、全文索引', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是数据库隔离级别？ [题367]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'READ UNCOMMITTED、READ COMMITTED、REPEATABLE READ、SERIALIZABLE', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是SQL的聚合函数？ [题368]', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'COUNT、SUM、AVG、MAX、MIN', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是JOIN的类型？ [题369]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'INNER JOIN、LEFT JOIN、RIGHT JOIN、FULL OUTER JOIN', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Redis的数据类型？ [题370]', 'A,B,C,D,E,F', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'String、List、Set、ZSet、Hash、HyperLogLog', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Redis的持久化方式？ [题371]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'RDB、AOF', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Redis的应用场景？ [题372]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '缓存、Session存储、排行榜、消息队列', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是数据库设计范式？ [题373]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '第一范式、第二范式、第三范式', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是MySQL的优化方向？ [题374]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '索引优化、查询优化、表结构优化、架构优化', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是分库分表的方式？ [题375]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '水平分库、垂直分库、水平分表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是读写分离的实现方式？ [题376]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '主从复制、数据库中间件、应用层分派', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是SQL优化技巧？ [题377]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '避免SELECT *、使用覆盖索引、减少JOIN、使用分页', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是数据库连接池的作用？ [题378]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '减少连接创建开销、提高并发、管理连接生命周期、支持高并发', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是NoSQL数据库的特点？ [题379]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '高性能、高可用、灵活的数据模型', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是MongoDB的特点？ [题380]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '文档存储、水平扩展、丰富的查询语言、高可用', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Redis的部署模式？ [题381]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '单机、主从、哨兵、集群', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是MongoDB的索引类型？ [题382]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '单字段索引、复合索引、文本索引、地理位置索引', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是数据库备份类型？ [题383]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '全量备份、增量备份、差异备份', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是TCP的可靠传输机制？ [题384]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '确认、超时重传、流量控制、拥塞控制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是HTTP的方法？ [题385]', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'GET、POST、PUT、DELETE、PATCH', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是HTTP状态码的类别？ [题386]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '1xx信息、2xx成功、3xx重定向、4xx客户端错误、5xx服务器错误', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是DNS的记录类型？ [题387]', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'A、AAAA、CNAME、MX、NS、TXT', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是WebSocket的特点？ [题388]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '全双工、低延迟、基于TCP持久连接、跨域通信', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是HTTPS的加密机制？ [题389]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '非对称加密交换密钥、对称加密传输数据、数字证书验证身份', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是CDN的作用？ [题390]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '加速访问、减轻源站压力、防御DDoS、就近访问', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是HTTP/2的特性？ [题391]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '多路复用、服务器推送、header压缩、流优先级', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是TCP三次握手的状态变化？ [题392]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'SYN-SENT、SYN-RECEIVED、ESTABLISHED', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是TCP四次挥手的状态变化？ [题393]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'FIN-WAIT-1、FIN-WAIT-2、CLOSE-WAIT、TIME-WAIT', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是跨域请求的解决方案？ [题394]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'CORS、JSONP、代理服务器、WebSocket', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Cookie的安全属性？ [题395]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Secure、HttpOnly、SameSite、Path', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是HTTP缓存的策略？ [题396]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Cache-Control、ETag、Last-Modified、Pragma', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是TCP和UDP的区别？ [题397]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '连接vs无连接、可靠vs不可靠、有序vs无序、拥塞控制', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是常用端口号？ [题398]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'SSH(22)、HTTP(80)、HTTPS(443)、MySQL(3306)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是网络协议的分层？ [题399]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '应用层、传输层、网络层、数据链路层', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是ping命令使用的协议？ [题400]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'ICMP、IP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是ARP的作用？ [题401]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '将IP地址解析为MAC地址、维护ARP缓存', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是路由选择协议？ [题402]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'RIP、OSPF、BGP', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是防火墙的功能？ [题403]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '包过滤、状态检测、应用网关、深度检测', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是稳定的排序算法？ [题404]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '归并排序、冒泡排序、插入排序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是不稳定的排序算法？ [题405]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '快速排序、选择排序、堆排序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是常见的数据结构？ [题406]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '数组、链表、树、图、哈希表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是树的特点？ [题407]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '层次结构、节点度、根节点、叶节点', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是二叉树的遍历方式？ [题408]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '前序、中序、后序、层序', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是图的基本概念？ [题409]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '顶点、边、有向图、无向图', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是图的存储方式？ [题410]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '邻接矩阵、邻接表', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是图的遍历算法？ [题411]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'DFS、BFS', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是动态规划的条件？ [题412]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '最优子结构、重叠子问题', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是回溯算法的特征？ [题413]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '尝试所有可能、剪枝、回溯', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是贪心算法的特征？ [题414]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '局部最优、全局最优', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是分治算法的步骤？ [题415]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '分解、解决、合并', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是常见的设计模式？ [题416]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '单例、工厂、观察者、策略', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是时间复杂度从低到高的排序？ [题417]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'O(1)、O(log n)、O(n)、O(n log n)、O(n^2)', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是空间复杂度为O(1)的排序？ [题418]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '冒泡、插入、选择', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是哈希表解决冲突的方法？ [题419]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '链地址法、开放地址法、再哈希法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是B树的特征？ [题420]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '多路平衡、每个节点多个键、子树数量有范围', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是红黑树的特征？ [题421]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '节点红色或黑色、根节点黑色、叶子节点黑色、红色节点子节点黑色', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是并查集的操作？ [题422]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'find、union', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Top K问题的解法？ [题423]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '堆、快速选择', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是进程的状态？ [题424]', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '创建、就绪、运行、阻塞、终止', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是进程间通信方式？ [题425]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '管道、消息队列、共享内存、Socket', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是线程的状态？ [题426]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'NEW、RUNNABLE、BLOCKED、WAITING、TIMED_WAITING、TERMINATED', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是死锁的必要条件？ [题427]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '互斥、占有并等待、不可抢占、循环等待', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是预防死锁的方法？ [题428]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '破坏占有并等待、破坏不可抢占、破坏循环等待', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是页面置换算法？ [题429]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'FIFO、LRU、OPT、Clock', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是CPU调度算法？ [题430]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'FCFS、SJF、RR、多级反馈队列', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是磁盘调度算法？ [题431]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'FCFS、SSTF、SCAN、C-SCAN', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是银行家算法的数据结构？ [题432]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Available、Max、Allocation、Need', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是操作系统的基本功能？ [题433]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '进程管理、内存管理、文件管理、设备管理', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Linux的进程状态？ [题434]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '运行、睡眠、停止、僵尸', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Shell的特殊变量？ [题435]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '$0、$1、$#、$$、$?', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Linux的IO模型？ [题436]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '阻塞IO、非阻塞IO、IO多路复用、异步IO', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是虚拟内存的作用？ [题437]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '扩展地址空间、提供内存保护、实现内存映射', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Cache的替换策略？ [题438]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'FIFO、LRU、LFU', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是同步机制？ [题439]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '信号量、互斥锁、条件变量、屏障', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是死锁的处理方法？ [题440]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '预防、避免、检测解除', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是内存管理的方式？ [题441]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '连续分配、分页、分段、分页+分段', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是SPOOLing技术的组成？ [题442]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '输入井、输出井、输入缓冲、输出缓冲', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是操作系统的结构？ [题443]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '单体结构、层次结构、微内核、模块化', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是JavaScript的数据类型？ [题444]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'string、number、boolean、null、undefined、object', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是ES6的新特性？ [题445]', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'let/const、箭头函数、模板字符串、解构、模块', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Promise的方法？ [题446]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'then、catch、finally、race、all', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Vue的指令？ [题447]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'v-if、v-for、v-bind、v-on、v-model', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是React的Hook？ [题448]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'useState、useEffect、useContext、useRef', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是CSS的盒子属性？ [题449]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'content、padding、border、margin', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Flex布局的属性？ [题450]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'flex-direction、justify-content、align-items、flex-wrap', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Grid布局的属性？ [题451]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'grid-template-columns、grid-template-rows、gap、grid-area', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是HTTP状态码的类别？ [题452]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '1xx信息、2xx成功、3xx重定向、4xx客户端错误、5xx服务器错误', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是跨域的解决方案？ [题453]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'CORS、JSONP、代理服务器、WebSocket', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是浏览器存储的方式？ [题454]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Cookie、SessionStorage、LocalStorage', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Vuex的属性？ [题455]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'state、getters、mutations、actions、modules', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是TypeScript的类型？ [题456]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'string、number、boolean、any、void、never', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Webpack的加载器？ [题457]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'css-loader、babel-loader、ts-loader、file-loader', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Webpack的插件？ [题458]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'HtmlWebpackPlugin、CleanWebpackPlugin、UglifyJsPlugin', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是HTTP的请求头？ [题459]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Content-Type、Authorization、Cookie、User-Agent', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是HTTP的响应头？ [题460]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Set-Cookie、Cache-Control、ETag、Last-Modified', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是异步编程的方式？ [题461]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '回调、Promise、async/await、Generator', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是性能优化的方法？ [题462]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '减少请求、压缩资源、缓存、代码分割', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是前端安全措施？ [题463]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'XSS防护、CSRF防护、SQL注入防护、点击劫持防护', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Docker的核心组件？ [题464]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Client、Docker daemon、Registry、Container', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Dockerfile的指令？ [题465]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'FROM、COPY、RUN、CMD、EXPOSE', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Docker的网络模式？ [题466]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'bridge、host、none、container', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Kubernetes的资源对象？ [题467]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Pod、Deployment、Service、ConfigMap', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Git的常用命令？ [题468]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'clone、add、commit、push、pull', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Git的操作？ [题469]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'merge、rebase、reset、stash', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是CI/CD的工具？ [题470]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Jenkins、GitLab CI、Travis CI、CircleCI', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Docker的数据持久化方式？ [题471]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Volume、bind mount', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Kubernetes的Ingress？ [题472]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'HTTP代理、HTTPS终止、域名-based routing', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Prometheus的指标类型？ [题473]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Counter、Gauge、Histogram、Summary', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是容器编排工具？ [题474]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Kubernetes、Docker Swarm、Mesos、Nomad', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是代码质量工具？ [题475]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'SonarQube、ESLint、Checkstyle', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是日志收集工具？ [题476]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'ELK、Fluentd、Loki、Prometheus', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是配置管理工具？ [题477]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Ansible、Chef、Puppet、SaltStack', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是基础设施即代码工具？ [题478]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Terraform、CloudFormation、Pulumi', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是容器安全措施？ [题479]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'User namespace、Capabilities、Seccomp、AppArmor', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是K8s的Service类型？ [题480]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'ClusterIP、NodePort、LoadBalancer、ExternalName', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Helm的概念？ [题481]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Chart、Repository、Release', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Docker Compose的服务？ [题482]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'build、image、ports、volumes', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是微服务架构的特点？ [题483]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '独立部署、技术多样性、容错隔离、康威定律', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Java的基本数据类型？ [题484]', 'A,C,D,F', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'byte、short、int、long、float、double、char、boolean', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些修饰符可以修饰类？ [题485]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'public、abstract、final', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是创建线程的方式？ [题486]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '继承Thread、实现Runnable、实现Callable、线程池', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Collection接口的方法？ [题487]', 'A,B,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'add、remove、size、clear', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是fail-fast的特性？ [题488]', 'A,B,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'ArrayList、HashMap、Vector的迭代器', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是SOLID原则的内容？ [题489]', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '单一职责、开闭、里氏替换、接口隔离、依赖倒置', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Java 8的新特性？ [题490]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Lambda、Stream、Optional、接口default方法', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是java.util.concurrent包下的类？ [题491]', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'ConcurrentHashMap、CopyOnWriteArrayList、LongAdder、Semaphore、CountDownLatch', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是线程安全的类？ [题492]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'Vector、Hashtable、ConcurrentHashMap、CopyOnWriteArrayList', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Object类的方法？ [题493]', 'A,B,C,D,E', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'equals、hashCode、toString、getClass、notify、wait', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是String类的方法？ [题494]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'length、charAt、substring、indexOf、replace', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是ArrayList的特点？ [题495]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '基于数组、线程不安全、支持随机访问', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是LinkedList的特点？ [题496]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '基于双向链表、线程不安全、插入删除效率高、可作为栈或队列', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是HashMap的扩容条件？ [题497]', 'A,B', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '元素数量超过capacity*loadFactor、链表长度超过8', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是ConcurrentHashMap的并发机制？ [题498]', 'A,B,C', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', '分段锁、CAS、volatile', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是CompletableFuture的方法？ [题499]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'thenApply、thenCompose、exceptionally、join', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('以下哪些是Stream的中间操作？ [题500]', 'A,B,C,D', 3, 10, '{\"A\":\"选项A\",\"B\":\"选项B\",\"C\":\"选项C\",\"D\":\"选项D\",\"E\":\"选项E\"}', 'filter、map、flatMap、distinct、sorted', 2, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个字符串是否是回文。回文是指正读和反读都一样的字符串。
输入: \"aba\" 输出: true
输入: \"abca\" 输出: false [题1]', '使用双指针或反转比较', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1501, 'aba', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1501, 'abca', 'false', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1501, 'a', 'true', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1501, 'abc', 'false', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，计算字符串中单词的数量。单词是用空格分隔的连续字符序列。
输入: \"hello world\" 输出: 2
输入: \"abc\" 输出: 1 [题2]', '按空格分割', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1502, 'hello world', '2', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1502, 'abc', '1', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1502, 'a b c', '3', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1502, '', '0', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，移除数组中所有等于val的元素，返回新数组长度。
输入: [3,2,3,3], val=3 输出: 2 [题3]', '双指针法', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1503, '[3', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1503, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1503, '3', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1503, '3] 3', '2', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1503, '[1', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1503, '2', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1503, '3', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1503, '4] 5', '4', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1503, '[1', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1503, '1', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1503, '1] 1', '0', 25, 10);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，合并两个有序数组为一个有序数组。
输入: [1,3,5], [2,4,6] 输出: [1,2,3,4,5,6] [题4]', '双指针合并', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1504, '[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1504, '3', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1504, '5] [2', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1504, '4', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1504, '6]', '[1', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1504, '2', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1504, '3', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1504, '4', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1504, '5', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1504, '6]', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1504, '[1', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1504, '2', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1504, '3] [4', '', 25, 12);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1504, '5', '', 25, 13);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1504, '6]', '[1', 25, 14);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1504, '2', '', 25, 15);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1504, '3', '', 25, 16);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1504, '4', '', 25, 17);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1504, '5', '', 25, 18);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1504, '6]', '', 25, 19);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个数是否是质数。质数是大于1的自然数，除了1和它本身外不能被其他自然数整除。
输入: 2 输出: true
输入: 4 输出: false [题5]', '试除法', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1505, '2', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1505, '3', 'true', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1505, '4', 'false', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1505, '17', 'true', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1505, '1', 'false', 25, 4);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，返回斐波那契数列第n项。F(0)=0, F(1)=1, F(n)=F(n-1)+F(n-2)。
输入: 5 输出: 5
输入: 10 输出: 55 [题6]', '迭代或矩阵', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1506, '5', '5', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1506, '10', '55', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1506, '0', '0', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1506, '1', '1', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，计算一个整数的阶乘。n! = n × (n-1) × ... × 2 × 1
输入: 5 输出: 120
输入: 0 输出: 1 [题7]', '递归或迭代', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1507, '5', '120', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1507, '0', '1', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1507, '10', '3628800', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，求两个数的最大公约数（欧几里得算法）。
输入: 12, 8 输出: 4
输入: 24, 18 输出: 6 [题8]', '辗转相除', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1508, '12 8', '4', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1508, '24 18', '6', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1508, '100 25', '25', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，求两个数的最小公倍数。
输入: 4, 6 输出: 12
输入: 5, 10 输出: 10 [题9]', '公式LCM=a*b/GCD', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1509, '4 6', '12', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1509, '5 10', '10', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1509, '7 3', '21', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，将字符串中的空格替换为%20。
输入: \"hello world\" 输出: \"hello%20world\"
输入: \" \" 输出: \"%20\" [题10]', '从后往前复制', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1510, 'hello world', 'hello%20world', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1510, '  ', '%20', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1510, 'abc', 'abc', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个链表是否有环。
输入: 3->2->1->2 返回true
输入: 1->2 返回false [题11]', '快慢指针', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1511, '3', '2', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1511, '1', '2', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，返回链表的倒数第k个节点。
输入: 1->2->3->4->5, k=2 输出: 4
输入: 1->2->3, k=3 输出: 1 [题12]', '快慢指针', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1512, '1', '2', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1512, '1', '2', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个数是否是2的幂。
输入: 8 输出: true
输入: 6 输出: false [题13]', '二进制或除二', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1513, '8', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1513, '6', 'false', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1513, '1', 'true', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1513, '1024', 'true', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，返回字符串中第一个不重复的字符。
输入: \"abracadabra\" 输出: \'c\'
输入: \"aabbcc\" 输出: null [题14]', '哈希表计数', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1514, 'abracadabra', 'c', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1514, 'aabbcc', 'null', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1514, 'abc', 'a', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，将数字转换为字符串。
输入: 123 输出: \"123\"
输入: -456 输出: \"-456\" [题15]', '考虑负数', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1515, '123', '123', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1515, '-456', '-456', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1515, '0', '0', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，将字符串转换为整数。
输入: \"123\" 输出: 123
输入: \"-456\" 输出: -456 [题16]', '考虑空字符和正负号', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1516, '123', '123', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1516, '-456', '-456', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1516, '  -42', '-42', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，计算数组中连续子数组的最大和。
输入: [-2,1,-3,4,-1,2,1,-5,4] 输出: 6
输入: [1] 输出: 1 [题17]', 'Kadane算法', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1517, '[-2', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1517, '1', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1517, '-3', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1517, '4', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1517, '-1', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1517, '2', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1517, '1', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1517, '-5', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1517, '4]', '6', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1517, '[1]', '1', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1517, '[5', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1517, '4', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1517, '-1', '', 25, 12);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1517, '7', '', 25, 13);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1517, '8]', '23', 25, 14);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断两个字符串是否是字母异位词。
输入: \"anagram\", \"nagaram\" 输出: true
输入: \"rat\", \"car\" 输出: false [题18]', '计数比较', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1518, 'anagram nagaram', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1518, 'rat car', 'false', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1518, 'a', 'true', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，求两个链表的交点。
输入: A: 1->3->5, B: 2->4->3->5 输出: 5 [题19]', '双指针遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1519, '1', '3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1519, '1', '2 3', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个数是否是水仙花数。
输入: 153 输出: true (1^3+5^3+3^3=153)
输入: 123 输出: false [题20]', '立方和计算', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1520, '153', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1520, '123', 'false', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1520, '407', 'true', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，返回数组中第K大的元素。
输入: [3,2,1,5,6,4], k=2 输出: 5 [题21]', '快速选择或堆', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1521, '[3', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1521, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1521, '1', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1521, '5', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1521, '6', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1521, '4] 2', '5', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1521, '[3', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1521, '1', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1521, '2] 1', '3', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，验证二叉搜索树。
输入: [2,1,3] 输出: true
输入: [5,1,4,null,null,3,6] 输出: false [题22]', '递归验证范围', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1522, '2', '1', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1522, '5', '1', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，合并两个有序链表。
输入: 1->2->4, 1->3->4 输出: 1->1->2->3->4->4 [题23]', '双指针归并', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1523, '1', '2', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个二叉树是否平衡。
输入: [3,9,20,null,null,15,7] 输出: true [题24]', '递归计算深度', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1524, '3', '9', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，实现pow(x, n)，计算x的n次幂。
输入: 2, 10 输出: 1024
输入: 2, -2 输出: 0.5 [题25]', '快速幂', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1525, '2 10', '1024', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1525, '2 -2', '0.5', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1525, '3 3', '27', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，遍历二叉树每行。
输入: [3,9,20,null,null,15,7] 输出: [[3],[9,20],[15,7]] [题26]', '层序遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1526, '3', '9', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1526, '[9', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1526, '20]', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1526, '[15', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1526, '7]]', '', 25, 4);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，从数组中找出和为目标值的两个数的下标。
输入: [2,7,11,15], target=9 输出: [0,1] [题27]', '哈希表', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1527, '[2', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1527, '7', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1527, '11', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1527, '15] 9', '[0', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1527, '1]', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1527, '[3', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1527, '2', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1527, '4] 6', '[1', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1527, '2]', '', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，生成杨辉三角。
输入: 5 输出: [[1],[1,1],[1,2,1],[1,3,3,1],[1,4,6,4,1]] [题28]', '递推生成', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1528, '5', '[[1]', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1528, '[1', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1528, '1]', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1528, '[1', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1528, '2', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1528, '1]', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1528, '[1', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1528, '3', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1528, '3', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1528, '1]', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1528, '[1', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1528, '4', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1528, '6', '', 25, 12);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1528, '4', '', 25, 13);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1528, '1]]', '', 25, 14);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1528, '3', '[[1]', 25, 15);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1528, '[1', '', 25, 16);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1528, '1]', '', 25, 17);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1528, '[1', '', 25, 18);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1528, '2', '', 25, 19);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1528, '1]]', '', 25, 20);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，螺旋矩阵。
输入: 3 输出: [[1,2,3],[8,9,4],[7,6,5]] [题29]', '模拟遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1529, '3', '[[1', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1529, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1529, '3]', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1529, '[8', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1529, '9', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1529, '4]', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1529, '[7', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1529, '6', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1529, '5]]', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1529, '2', '[[1', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1529, '2]', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1529, '[4', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1529, '3]]', '', 25, 12);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，搜索旋转排序数组。
输入: [4,5,6,7,0,1,2], target=0 输出: 4 [题30]', '二分查找', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1530, '[4', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1530, '5', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1530, '6', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1530, '7', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1530, '0', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1530, '1', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1530, '2] 0', '4', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1530, '[4', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1530, '5', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1530, '6', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1530, '7', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1530, '0', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1530, '1', '', 25, 12);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1530, '2] 5', '1', 25, 13);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，找到数组中的多数元素。
输入: [3,2,3] 输出: 3
输入: [2,2,1,1,1,2,2] 输出: 2 [题31]', '投票算法', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1531, '[3', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1531, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1531, '3]', '3', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1531, '[2', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1531, '2', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1531, '1', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1531, '1', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1531, '1', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1531, '2', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1531, '2]', '2', 25, 9);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，求岛屿数量。
输入: [[\'1\',\'1\',\'0\',\'0\',\'0\'],[\'1\',\'1\',\'0\',\'0\',\'0\']] 输出: 1 [题32]', 'DFS或BFS', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1532, 'grid', '1', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1532, 'grid', '2', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，括号生成。
输入: 3 输出: [\'((()))\',\'(()())\',\'(())()\',\'()(())\',\'()()()\'] [题33]', '回溯', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1533, '3', '5', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1533, '2', '2', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，全排列。
输入: [1,2,3] 输出: [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]] [题34]', '回溯', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1534, '[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1534, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1534, '3]', '6', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1534, '[1]', '1', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，组合总和。
输入: candidates=[2,3,6,7], target=7 输出: [[2,2,3],[7]] [题35]', '回溯+剪枝', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1535, '2', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1535, '3', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1535, '6', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1535, '7 7', '[[2', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1535, '2', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1535, '3]', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1535, '[7]]', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1535, '1', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1535, '2 3', '[[1', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1535, '1', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1535, '1]', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1535, '[1', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1535, '2]]', '', 25, 12);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，子集。
输入: [1,2,3] 输出: [[],[1],[2],[3],[1,2],[1,3],[2,3],[1,2,3]] [题36]', '回溯', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1536, '[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1536, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1536, '3]', '8', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1536, '[1]', '2', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，括号有效。
输入: \"()[]{}\" 输出: true
输入: \"([)]\" 输出: false [题37]', '栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1537, '()[]{}', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1537, '([)]', 'false', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1537, '(', 'false', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串解码。
输入: \"3[a]2[bc]\" 输出: \"aaabcbc\"
输入: \"2[abc]3[cd]ef\" 输出: \"abcabccdcdcdef\" [题38]', '栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1538, '3[a]2[bc]', 'aaabcbc', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1538, '2[abc]3[cd]ef', 'abcabccdcdcdef', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，岛屿最大面积。
输入: [[0,0,1,0,0],[0,0,0,0,0]] 输出: 1 [题39]', 'DFS', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1539, 'grid', '1', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1539, 'grid', '4', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，课程表。
输入: numCourses=4, prerequisites=[[1,0],[2,0],[3,1],[3,2]] 输出: true [题40]', '拓扑排序', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1540, '4 [[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1540, '0]', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1540, '[2', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1540, '0]', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1540, '[3', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1540, '1]', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1540, '[3', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1540, '2]]', 'true', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1540, '2 [[1', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1540, '0]]', 'true', 25, 9);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，合并区间。
输入: [[1,3],[2,6],[8,10],[15,18]] 输出: [[1,6],[8,10],[15,18]] [题41]', '排序后合并', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1541, '[[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1541, '3]', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1541, '[2', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1541, '6]', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1541, '[8', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1541, '10]', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1541, '[15', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1541, '18]]', '[[1', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1541, '6]', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1541, '[8', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1541, '10]', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1541, '[15', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1541, '18]]', '', 25, 12);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，最长递增子序列长度。
输入: [10,9,2,5,3,7,101,18] 输出: 4 [题42]', 'DP或二分', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1542, '[10', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1542, '9', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1542, '2', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1542, '5', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1542, '3', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1542, '7', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1542, '101', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1542, '18]', '4', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1542, '[1]', '1', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，最长公共子序列。
输入: \"abcde\", \"ace\" 输出: 3 [题43]', 'DP', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1543, 'abcde ace', '3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1543, 'abc abc', '3', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，最长回文子串。
输入: \"babad\" 输出: \"bab\"
输入: \"cbbd\" 输出: \"bb\" [题44]', 'Manacher或DP', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1544, 'babad', 'bab', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1544, 'cbbd', 'bb', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，编辑距离。
输入: \"horse\", \"ros\" 输出: 3 [题45]', 'DP', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1545, 'horse ros', '3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1545, 'ros ros', '0', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，买卖股票最佳时机。
输入: [7,1,5,3,6,4] 输出: 5 [题46]', '一次遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1546, '[7', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1546, '1', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1546, '5', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1546, '3', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1546, '6', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1546, '4]', '5', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1546, '[7', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1546, '6', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1546, '4', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1546, '3', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1546, '1]', '0', 25, 10);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，打家劫舍。
输入: [1,2,3,1] 输出: 4
输入: [2,7,9,3,1] 输出: 12 [题47]', 'DP', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1547, '[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1547, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1547, '3', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1547, '1]', '4', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1547, '[2', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1547, '7', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1547, '9', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1547, '3', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1547, '1]', '12', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，跳台阶。
输入: 10 输出: 89 [题48]', '斐波那契', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1548, '10', '89', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1548, '5', '8', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1548, '0', '1', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，三数之和。
输入: [-1,0,1,2,-1,-4] 输出: [[-1,-1,2],[-1,0,1]] [题49]', '双指针', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1549, '[-1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1549, '0', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1549, '1', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1549, '2', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1549, '-1', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1549, '-4]', '[[-1', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1549, '-1', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1549, '2]', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1549, '[-1', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1549, '0', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1549, '1]]', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1549, '[]', '[]', 25, 11);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，电话号码的字母组合。
输入: \"23\" 输出: [\"ad\",\"ae\",\"af\",\"bd\",\"be\",\"bf\",\"cd\",\"ce\",\"cf\"] [题50]', '回溯', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1550, '23', '9', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1550, '2', '3', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，二叉树的最大深度。
输入: [3,9,20,null,null,15,7] 输出: 3 [题51]', '递归', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1551, '3', '9', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1551, '1', '1', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，对称二叉树。
输入: [1,2,2,3,4,4,3] 输出: true [题52]', '递归比较', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1552, '1', '2', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，二叉树层序遍历。
输入: [3,9,20,null,null,15,7] 输出: [[3],[9,20],[15,7]] [题53]', '队列', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1553, '3', '9', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1553, '[9', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1553, '20]', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1553, '[15', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1553, '7]]', '', 25, 4);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，填充每个节点的下一个右侧节点指针。
输入: [1,2,3,4,5,6,7] 输出: [[1,#],[2,3,#],[4,5,6,7,#]] [题54]', '层序', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1554, '1', '2', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，二叉树前序遍历。
输入: [1,null,2,3] 输出: [1,2,3] [题55]', '递归或栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1555, '1', 'null', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1555, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1555, '3]', '', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，二叉树中序遍历。
输入: [1,null,2,3] 输出: [1,3,2] [题56]', '递归或栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1556, '1', 'null', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1556, '3', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1556, '2]', '', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，二叉树后序遍历。
输入: [1,2,3] 输出: [3,2,1] [题57]', '递归或栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1557, '1', '2', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1557, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1557, '1]', '', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，路径总和。
输入: [5,4,8,11,null,13,4,7,2,null,null,1] 输出: true [题58]', '递归', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1558, 'tree 22', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1558, 'tree 12', 'false', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，从前序和中序构建二叉树。
输入: preorder=[3,9,20,15,7], inorder=[9,3,15,20,7] 输出: [3,9,20,null,null,15,7] [题59]', '递归', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1559, 'preorder inorder', 'tree', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，搜索二维矩阵。
输入: [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target=3 输出: true [题60]', '二分或Z字搜索', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1560, 'matrix 3', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1560, 'matrix 13', 'false', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，搜索旋转数组最小值。
输入: [3,4,5,1,2] 输出: 1 [题61]', '二分', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1561, '[3', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1561, '4', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1561, '5', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1561, '1', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1561, '2]', '1', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1561, '[1]', '1', 25, 5);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，查找元素范围。
输入: [5,7,7,8,8,10], target=8 输出: [3,4] [题62]', '二分', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1562, '[5', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1562, '7', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1562, '7', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1562, '8', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1562, '8', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1562, '10] 8', '[3', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1562, '4]', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1562, '[1', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1562, '2', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1562, '3] 4', '[-1', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1562, '-1]', '', 25, 10);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串转浮点数。
输入: \"123.45\" 输出: 123.45
输入: \"-6.78\" 输出: -6.78 [题63]', '处理整数和小数部分', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1563, '123.45', '123.45', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1563, '-6.78', '-6.78', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，扁平化嵌套列表。
输入: [[1,2],3,[4,5]] 输出: [1,2,3,4,5] [题64]', '递归或栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1564, '[[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1564, '2]', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1564, '3', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1564, '[4', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1564, '5]]', '[1', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1564, '2', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1564, '3', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1564, '4', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1564, '5]', '', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，扁平化二叉树为链表。
输入: [1,2,null,3,null,4,null,5] 输出: [1,null,2,null,3,null,4,null,5,null] [题65]', '前序遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1565, 'tree', 'linked', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，验证平衡括号。
输入: \'{[()]}\' 输出: true
输入: \'{[(])}\' 输出: false [题66]', '栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1566, '{[()]}', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1566, '{[(])}', 'false', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，无重复字符最长子串。
输入: \"abcabcbb\" 输出: 3
输入: \"bbbbb\" 输出: 1 [题67]', '滑动窗口', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1567, 'abcabcbb', '3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1567, 'bbbbb', '1', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串所有排列。
输入: \"abc\" 输出: [\"abc\",\"acb\",\"bac\",\"bca\",\"cab\",\"cba\"] [题68]', '回溯', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1568, 'abc', '6', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1568, 'a', '1', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，第N个丑数。
输入: 10 输出: 12 [题69]', '三指针', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1569, '10', '12', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1569, '1', '1', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，两个链表的下一个更大节点。
输入: 2->1->5 输出: 5->5->0 [题70]', '单调栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1570, '2', '1', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，移除重复元素使得出现一次。
输入: [1,2,2,3,3,3] 输出: 6 [题71]', '异或运算', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1571, '[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1571, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1571, '2', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1571, '3', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1571, '3', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1571, '3]', '6', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1571, '[1', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1571, '1', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1571, '1]', '1', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串最后一个单词长度。
输入: \"hello world\" 输出: 5 [题72]', '反向遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1572, 'hello world', '5', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1572, 'abc', '3', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，验证回文串。
输入: \"A man, a plan, a canal: Panama\" 输出: true [题73]', '双指针', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1573, 'A man a plan a canal Panama', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1573, 'race a car', 'false', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，模拟浏览器前进后退。
输入: BrowserHistory(\'leetcode.com\') [题74]', '双栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1574, 'leetcode.com forward', 'com', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1574, 'back', 'leetcode.com', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，最大栈。
输入: MaxStack() 输出: 支持push、pop、max操作 [题75]', '辅助栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1575, 'push', 'pop', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，丑数。
输入: 6 输出: true
输入: 8 输出: true
输入: 14 输出: false [题76]', '分解质因数', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1576, '6', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1576, '8', 'true', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1576, '14', 'false', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，完全平方数。
输入: 12 输出: 3 (因为3^2=9是最接近的完全平方数) [题77]', '动态规划或二分', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1577, '12', '3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1577, '16', '0', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1577, '1', '0', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串循环移位。
输入: \"abcdef\" 左移2位 输出: \"cdefab\" [题78]', '拼接', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1578, 'abcdef 2', 'cdefab', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，乱序单词分组。
输入: [\"eat\",\"tea\",\"tan\",\"ate\",\"nat\",\"bat\"] 输出: [[\"eat\",\"tea\",\"ate\"],[\"tan\",\"nat\"],[\"bat\"]] [题79]', '排序后哈希', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1579, 'eat tea tan ate nat bat', '3组', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串压缩。
输入: \"aabcccccaaa\" 输出: \"a2b1c5a3\" [题80]', '计数压缩', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1580, 'aabcccccaaa', 'a2b1c5a3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1580, 'abcd', 'abcd', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，旋转图像90度。
输入: [[1,2,3],[4,5,6],[7,8,9]] 输出: [[7,4,1],[8,5,2],[9,6,3]] [题81]', '先转置再翻转', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1581, 'matrix', 'rotated', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，矩阵置零。
输入: [[1,1,1],[1,0,1],[1,1,1]] 输出: [[1,0,1],[0,0,0],[1,0,1]] [题82]', '标记行列', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1582, 'matrix', 'zeroed', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，加一。
输入: [1,2,3] 输出: [1,2,4]
输入: [9,9,9] 输出: [1,0,0,0] [题83]', '进位处理', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1583, '1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1583, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1583, '3', '1', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1583, '2', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1583, '4', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1583, '9', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1583, '9', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1583, '9', '1', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1583, '0', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1583, '0', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1583, '0', '', 25, 10);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串相乘。
输入: \"123\" × \"456\" 输出: \"56088\" [题84]', '列竖式', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1584, '123 456', '56088', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1584, '0 0', '0', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，有效的数独。
输入: 9x9数独数组 输出: true/false [题85]', '行列宫遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1585, 'board', 'true/false', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，颠倒二进制位。
输入: 43261596 (二进制 00000010100101000001111010011100) 输出: 964176192 [题86]', '逐位反转', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1586, '43261596', '964176192', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1586, '1', '2147483648', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，位1的个数。
输入: 11 (二进制 00000000000000000000000000001011) 输出: 3 [题87]', '位运算', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1587, '11', '3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1587, '128', '1', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，2的幂次方。
输入: 1 输出: true
输入: 16 输出: true
输入: 218 输出: false [题88]', 'n&(n-1)==0', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1588, '1', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1588, '16', 'true', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1588, '218', 'false', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，缺失的第一个正数。
输入: [3,-1,4,2] 输出: 1
输入: [1,2,0] 输出: 3 [题89]', '原地哈希', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1589, '3 -1 4 2', '1', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1589, '1 2 0', '3', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字母异位词分组。
输入: [\"eat\",\"tea\",\"tan\"] 输出: [[\"eat\",\"tea\",\"ate\"],[\"tan\"]] [题90]', '排序哈希', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1590, 'eat tea tan', '2组', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，合并两个有序数组。
输入: nums1=[1,2,3], m=3, nums2=[2,5,6], n=3 输出: [1,2,2,3,5,6] [题91]', '从后往前', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1591, 'nums1 nums2', 'merged', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，验证二叉搜索树。
输入: [5,1,4,null,null,3,6] 输出: false [题92]', '递归', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1592, '5', '1', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，二叉搜索树最近公共祖先。
输入: [6,2,8,0,4,7,9,null,null,3,5], p=2, q=8 输出: 6 [题93]', 'BST性质', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1593, 'tree 2 8', '6', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1593, 'tree 2 4', '2', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，二叉树路径总和II。
输入: [1,2] 输出: 所有从根到叶子路径和为sum的路径 [题94]', '回溯', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1594, '1', '2', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1594, '2]]', '', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，构建乘积数组。
输入: [1,2,3,4,5] 输出: [120,60,40,30,24] [题95]', '左右遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1595, '[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1595, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1595, '3', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1595, '4', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1595, '5]', '[120', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1595, '60', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1595, '40', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1595, '30', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1595, '24]', '', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，复制带随机指针的链表。
输入: 链表，每个节点有next和random指针 输出: 深拷贝 [题96]', '哈希表', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1596, 'linked', 'cloned', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，变位词组。
输入: \"eat\",\"tea\",\"tan\",\"ate\",\"nat\",\"bat\" 输出: [[\"eat\",\"tea\",\"ate\"],[\"tan\",\"nat\"],[\"bat\"]] [题97]', '排序分组', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1597, '6words', '3组', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，前K个高频元素。
输入: [1,1,1,2,2,3], k=2 输出: [1,2] [题98]', '堆', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1598, '[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1598, '1', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1598, '1', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1598, '2', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1598, '2', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1598, '3] 2', '[1', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1598, '2]', '', 25, 6);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，合并区间。
输入: [[1,4],[0,4]] 输出: [[0,4]] [题99]', '排序合并', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1599, 'intervals', 'merged', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串解码。
输入: \"3[a2[c]]\" 输出: \"accaccacc\" [题100]', '栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1600, '3[a2[c]]', 'accaccacc', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，简化路径。
输入: \"/home//foo/\" 输出: \"/home/foo\" [题101]', '栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1601, '/home//foo/', '/home/foo', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，逆波兰表达式求值。
输入: [\"2\",\"1\",\"+\",\"3\",\"*\"] 输出: 9 [题102]', '栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1602, '2 1 + 3 *', '9', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，跳跃游戏。
输入: [2,3,1,1,4] 输出: true [题103]', '贪心', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1603, '[2', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1603, '3', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1603, '1', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1603, '1', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1603, '4]', 'true', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1603, '[3', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1603, '2', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1603, '1', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1603, '0]', 'false', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，加油站。
输入: gas=[1,2,3,4,5], cost=[2,3,4,5,1] 输出: 3 [题104]', '贪心', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1604, 'gas cost', '3', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，分糖果。
输入: ratings=[1,0,2] 输出: 5 [题105]', '贪心', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1605, 'ratings', '5', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，赎金信。
输入: ransom=\"aa\", magazine=\"aab\" 输出: true [题106]', '哈希计数', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1606, 'aa aab', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1606, 'ab aac', 'false', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个字符串是否是回文。回文是指正读和反读都一样的字符串。
输入: \"aba\" 输出: true
输入: \"abca\" 输出: false [题107]', '使用双指针或反转比较', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1607, 'aba', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1607, 'abca', 'false', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1607, 'a', 'true', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1607, 'abc', 'false', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，计算字符串中单词的数量。单词是用空格分隔的连续字符序列。
输入: \"hello world\" 输出: 2
输入: \"abc\" 输出: 1 [题108]', '按空格分割', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1608, 'hello world', '2', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1608, 'abc', '1', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1608, 'a b c', '3', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1608, '', '0', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，移除数组中所有等于val的元素，返回新数组长度。
输入: [3,2,3,3], val=3 输出: 2 [题109]', '双指针法', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1609, '[3', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1609, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1609, '3', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1609, '3] 3', '2', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1609, '[1', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1609, '2', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1609, '3', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1609, '4] 5', '4', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1609, '[1', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1609, '1', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1609, '1] 1', '0', 25, 10);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，合并两个有序数组为一个有序数组。
输入: [1,3,5], [2,4,6] 输出: [1,2,3,4,5,6] [题110]', '双指针合并', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1610, '[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1610, '3', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1610, '5] [2', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1610, '4', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1610, '6]', '[1', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1610, '2', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1610, '3', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1610, '4', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1610, '5', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1610, '6]', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1610, '[1', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1610, '2', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1610, '3] [4', '', 25, 12);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1610, '5', '', 25, 13);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1610, '6]', '[1', 25, 14);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1610, '2', '', 25, 15);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1610, '3', '', 25, 16);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1610, '4', '', 25, 17);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1610, '5', '', 25, 18);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1610, '6]', '', 25, 19);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个数是否是质数。质数是大于1的自然数，除了1和它本身外不能被其他自然数整除。
输入: 2 输出: true
输入: 4 输出: false [题111]', '试除法', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1611, '2', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1611, '3', 'true', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1611, '4', 'false', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1611, '17', 'true', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1611, '1', 'false', 25, 4);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，返回斐波那契数列第n项。F(0)=0, F(1)=1, F(n)=F(n-1)+F(n-2)。
输入: 5 输出: 5
输入: 10 输出: 55 [题112]', '迭代或矩阵', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1612, '5', '5', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1612, '10', '55', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1612, '0', '0', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1612, '1', '1', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，计算一个整数的阶乘。n! = n × (n-1) × ... × 2 × 1
输入: 5 输出: 120
输入: 0 输出: 1 [题113]', '递归或迭代', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1613, '5', '120', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1613, '0', '1', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1613, '10', '3628800', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，求两个数的最大公约数（欧几里得算法）。
输入: 12, 8 输出: 4
输入: 24, 18 输出: 6 [题114]', '辗转相除', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1614, '12 8', '4', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1614, '24 18', '6', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1614, '100 25', '25', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，求两个数的最小公倍数。
输入: 4, 6 输出: 12
输入: 5, 10 输出: 10 [题115]', '公式LCM=a*b/GCD', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1615, '4 6', '12', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1615, '5 10', '10', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1615, '7 3', '21', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，将字符串中的空格替换为%20。
输入: \"hello world\" 输出: \"hello%20world\"
输入: \" \" 输出: \"%20\" [题116]', '从后往前复制', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1616, 'hello world', 'hello%20world', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1616, '  ', '%20', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1616, 'abc', 'abc', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个链表是否有环。
输入: 3->2->1->2 返回true
输入: 1->2 返回false [题117]', '快慢指针', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1617, '3', '2', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1617, '1', '2', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，返回链表的倒数第k个节点。
输入: 1->2->3->4->5, k=2 输出: 4
输入: 1->2->3, k=3 输出: 1 [题118]', '快慢指针', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1618, '1', '2', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1618, '1', '2', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个数是否是2的幂。
输入: 8 输出: true
输入: 6 输出: false [题119]', '二进制或除二', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1619, '8', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1619, '6', 'false', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1619, '1', 'true', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1619, '1024', 'true', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，返回字符串中第一个不重复的字符。
输入: \"abracadabra\" 输出: \'c\'
输入: \"aabbcc\" 输出: null [题120]', '哈希表计数', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1620, 'abracadabra', 'c', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1620, 'aabbcc', 'null', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1620, 'abc', 'a', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，将数字转换为字符串。
输入: 123 输出: \"123\"
输入: -456 输出: \"-456\" [题121]', '考虑负数', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1621, '123', '123', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1621, '-456', '-456', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1621, '0', '0', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，将字符串转换为整数。
输入: \"123\" 输出: 123
输入: \"-456\" 输出: -456 [题122]', '考虑空字符和正负号', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1622, '123', '123', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1622, '-456', '-456', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1622, '  -42', '-42', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，计算数组中连续子数组的最大和。
输入: [-2,1,-3,4,-1,2,1,-5,4] 输出: 6
输入: [1] 输出: 1 [题123]', 'Kadane算法', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1623, '[-2', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1623, '1', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1623, '-3', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1623, '4', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1623, '-1', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1623, '2', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1623, '1', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1623, '-5', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1623, '4]', '6', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1623, '[1]', '1', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1623, '[5', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1623, '4', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1623, '-1', '', 25, 12);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1623, '7', '', 25, 13);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1623, '8]', '23', 25, 14);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断两个字符串是否是字母异位词。
输入: \"anagram\", \"nagaram\" 输出: true
输入: \"rat\", \"car\" 输出: false [题124]', '计数比较', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1624, 'anagram nagaram', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1624, 'rat car', 'false', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1624, 'a', 'true', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，求两个链表的交点。
输入: A: 1->3->5, B: 2->4->3->5 输出: 5 [题125]', '双指针遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1625, '1', '3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1625, '1', '2 3', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个数是否是水仙花数。
输入: 153 输出: true (1^3+5^3+3^3=153)
输入: 123 输出: false [题126]', '立方和计算', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1626, '153', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1626, '123', 'false', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1626, '407', 'true', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，返回数组中第K大的元素。
输入: [3,2,1,5,6,4], k=2 输出: 5 [题127]', '快速选择或堆', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1627, '[3', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1627, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1627, '1', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1627, '5', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1627, '6', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1627, '4] 2', '5', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1627, '[3', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1627, '1', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1627, '2] 1', '3', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，验证二叉搜索树。
输入: [2,1,3] 输出: true
输入: [5,1,4,null,null,3,6] 输出: false [题128]', '递归验证范围', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1628, '2', '1', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1628, '5', '1', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，合并两个有序链表。
输入: 1->2->4, 1->3->4 输出: 1->1->2->3->4->4 [题129]', '双指针归并', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1629, '1', '2', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个二叉树是否平衡。
输入: [3,9,20,null,null,15,7] 输出: true [题130]', '递归计算深度', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1630, '3', '9', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，实现pow(x, n)，计算x的n次幂。
输入: 2, 10 输出: 1024
输入: 2, -2 输出: 0.5 [题131]', '快速幂', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1631, '2 10', '1024', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1631, '2 -2', '0.5', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1631, '3 3', '27', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，遍历二叉树每行。
输入: [3,9,20,null,null,15,7] 输出: [[3],[9,20],[15,7]] [题132]', '层序遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1632, '3', '9', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1632, '[9', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1632, '20]', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1632, '[15', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1632, '7]]', '', 25, 4);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，从数组中找出和为目标值的两个数的下标。
输入: [2,7,11,15], target=9 输出: [0,1] [题133]', '哈希表', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1633, '[2', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1633, '7', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1633, '11', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1633, '15] 9', '[0', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1633, '1]', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1633, '[3', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1633, '2', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1633, '4] 6', '[1', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1633, '2]', '', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，生成杨辉三角。
输入: 5 输出: [[1],[1,1],[1,2,1],[1,3,3,1],[1,4,6,4,1]] [题134]', '递推生成', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1634, '5', '[[1]', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1634, '[1', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1634, '1]', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1634, '[1', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1634, '2', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1634, '1]', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1634, '[1', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1634, '3', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1634, '3', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1634, '1]', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1634, '[1', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1634, '4', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1634, '6', '', 25, 12);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1634, '4', '', 25, 13);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1634, '1]]', '', 25, 14);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1634, '3', '[[1]', 25, 15);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1634, '[1', '', 25, 16);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1634, '1]', '', 25, 17);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1634, '[1', '', 25, 18);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1634, '2', '', 25, 19);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1634, '1]]', '', 25, 20);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，螺旋矩阵。
输入: 3 输出: [[1,2,3],[8,9,4],[7,6,5]] [题135]', '模拟遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1635, '3', '[[1', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1635, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1635, '3]', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1635, '[8', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1635, '9', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1635, '4]', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1635, '[7', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1635, '6', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1635, '5]]', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1635, '2', '[[1', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1635, '2]', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1635, '[4', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1635, '3]]', '', 25, 12);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，搜索旋转排序数组。
输入: [4,5,6,7,0,1,2], target=0 输出: 4 [题136]', '二分查找', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1636, '[4', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1636, '5', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1636, '6', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1636, '7', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1636, '0', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1636, '1', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1636, '2] 0', '4', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1636, '[4', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1636, '5', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1636, '6', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1636, '7', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1636, '0', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1636, '1', '', 25, 12);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1636, '2] 5', '1', 25, 13);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，找到数组中的多数元素。
输入: [3,2,3] 输出: 3
输入: [2,2,1,1,1,2,2] 输出: 2 [题137]', '投票算法', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1637, '[3', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1637, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1637, '3]', '3', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1637, '[2', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1637, '2', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1637, '1', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1637, '1', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1637, '1', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1637, '2', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1637, '2]', '2', 25, 9);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，求岛屿数量。
输入: [[\'1\',\'1\',\'0\',\'0\',\'0\'],[\'1\',\'1\',\'0\',\'0\',\'0\']] 输出: 1 [题138]', 'DFS或BFS', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1638, 'grid', '1', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1638, 'grid', '2', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，括号生成。
输入: 3 输出: [\'((()))\',\'(()())\',\'(())()\',\'()(())\',\'()()()\'] [题139]', '回溯', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1639, '3', '5', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1639, '2', '2', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，全排列。
输入: [1,2,3] 输出: [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]] [题140]', '回溯', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1640, '[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1640, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1640, '3]', '6', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1640, '[1]', '1', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，组合总和。
输入: candidates=[2,3,6,7], target=7 输出: [[2,2,3],[7]] [题141]', '回溯+剪枝', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1641, '2', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1641, '3', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1641, '6', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1641, '7 7', '[[2', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1641, '2', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1641, '3]', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1641, '[7]]', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1641, '1', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1641, '2 3', '[[1', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1641, '1', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1641, '1]', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1641, '[1', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1641, '2]]', '', 25, 12);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，子集。
输入: [1,2,3] 输出: [[],[1],[2],[3],[1,2],[1,3],[2,3],[1,2,3]] [题142]', '回溯', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1642, '[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1642, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1642, '3]', '8', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1642, '[1]', '2', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，括号有效。
输入: \"()[]{}\" 输出: true
输入: \"([)]\" 输出: false [题143]', '栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1643, '()[]{}', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1643, '([)]', 'false', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1643, '(', 'false', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串解码。
输入: \"3[a]2[bc]\" 输出: \"aaabcbc\"
输入: \"2[abc]3[cd]ef\" 输出: \"abcabccdcdcdef\" [题144]', '栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1644, '3[a]2[bc]', 'aaabcbc', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1644, '2[abc]3[cd]ef', 'abcabccdcdcdef', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，岛屿最大面积。
输入: [[0,0,1,0,0],[0,0,0,0,0]] 输出: 1 [题145]', 'DFS', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1645, 'grid', '1', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1645, 'grid', '4', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，课程表。
输入: numCourses=4, prerequisites=[[1,0],[2,0],[3,1],[3,2]] 输出: true [题146]', '拓扑排序', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1646, '4 [[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1646, '0]', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1646, '[2', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1646, '0]', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1646, '[3', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1646, '1]', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1646, '[3', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1646, '2]]', 'true', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1646, '2 [[1', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1646, '0]]', 'true', 25, 9);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，合并区间。
输入: [[1,3],[2,6],[8,10],[15,18]] 输出: [[1,6],[8,10],[15,18]] [题147]', '排序后合并', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1647, '[[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1647, '3]', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1647, '[2', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1647, '6]', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1647, '[8', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1647, '10]', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1647, '[15', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1647, '18]]', '[[1', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1647, '6]', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1647, '[8', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1647, '10]', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1647, '[15', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1647, '18]]', '', 25, 12);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，最长递增子序列长度。
输入: [10,9,2,5,3,7,101,18] 输出: 4 [题148]', 'DP或二分', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1648, '[10', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1648, '9', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1648, '2', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1648, '5', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1648, '3', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1648, '7', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1648, '101', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1648, '18]', '4', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1648, '[1]', '1', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，最长公共子序列。
输入: \"abcde\", \"ace\" 输出: 3 [题149]', 'DP', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1649, 'abcde ace', '3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1649, 'abc abc', '3', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，最长回文子串。
输入: \"babad\" 输出: \"bab\"
输入: \"cbbd\" 输出: \"bb\" [题150]', 'Manacher或DP', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1650, 'babad', 'bab', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1650, 'cbbd', 'bb', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，编辑距离。
输入: \"horse\", \"ros\" 输出: 3 [题151]', 'DP', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1651, 'horse ros', '3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1651, 'ros ros', '0', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，买卖股票最佳时机。
输入: [7,1,5,3,6,4] 输出: 5 [题152]', '一次遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1652, '[7', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1652, '1', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1652, '5', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1652, '3', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1652, '6', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1652, '4]', '5', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1652, '[7', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1652, '6', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1652, '4', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1652, '3', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1652, '1]', '0', 25, 10);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，打家劫舍。
输入: [1,2,3,1] 输出: 4
输入: [2,7,9,3,1] 输出: 12 [题153]', 'DP', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1653, '[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1653, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1653, '3', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1653, '1]', '4', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1653, '[2', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1653, '7', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1653, '9', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1653, '3', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1653, '1]', '12', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，跳台阶。
输入: 10 输出: 89 [题154]', '斐波那契', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1654, '10', '89', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1654, '5', '8', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1654, '0', '1', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，三数之和。
输入: [-1,0,1,2,-1,-4] 输出: [[-1,-1,2],[-1,0,1]] [题155]', '双指针', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1655, '[-1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1655, '0', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1655, '1', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1655, '2', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1655, '-1', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1655, '-4]', '[[-1', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1655, '-1', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1655, '2]', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1655, '[-1', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1655, '0', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1655, '1]]', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1655, '[]', '[]', 25, 11);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，电话号码的字母组合。
输入: \"23\" 输出: [\"ad\",\"ae\",\"af\",\"bd\",\"be\",\"bf\",\"cd\",\"ce\",\"cf\"] [题156]', '回溯', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1656, '23', '9', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1656, '2', '3', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，二叉树的最大深度。
输入: [3,9,20,null,null,15,7] 输出: 3 [题157]', '递归', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1657, '3', '9', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1657, '1', '1', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，对称二叉树。
输入: [1,2,2,3,4,4,3] 输出: true [题158]', '递归比较', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1658, '1', '2', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，二叉树层序遍历。
输入: [3,9,20,null,null,15,7] 输出: [[3],[9,20],[15,7]] [题159]', '队列', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1659, '3', '9', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1659, '[9', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1659, '20]', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1659, '[15', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1659, '7]]', '', 25, 4);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，填充每个节点的下一个右侧节点指针。
输入: [1,2,3,4,5,6,7] 输出: [[1,#],[2,3,#],[4,5,6,7,#]] [题160]', '层序', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1660, '1', '2', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，二叉树前序遍历。
输入: [1,null,2,3] 输出: [1,2,3] [题161]', '递归或栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1661, '1', 'null', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1661, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1661, '3]', '', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，二叉树中序遍历。
输入: [1,null,2,3] 输出: [1,3,2] [题162]', '递归或栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1662, '1', 'null', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1662, '3', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1662, '2]', '', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，二叉树后序遍历。
输入: [1,2,3] 输出: [3,2,1] [题163]', '递归或栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1663, '1', '2', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1663, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1663, '1]', '', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，路径总和。
输入: [5,4,8,11,null,13,4,7,2,null,null,1] 输出: true [题164]', '递归', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1664, 'tree 22', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1664, 'tree 12', 'false', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，从前序和中序构建二叉树。
输入: preorder=[3,9,20,15,7], inorder=[9,3,15,20,7] 输出: [3,9,20,null,null,15,7] [题165]', '递归', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1665, 'preorder inorder', 'tree', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，搜索二维矩阵。
输入: [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target=3 输出: true [题166]', '二分或Z字搜索', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1666, 'matrix 3', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1666, 'matrix 13', 'false', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，搜索旋转数组最小值。
输入: [3,4,5,1,2] 输出: 1 [题167]', '二分', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1667, '[3', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1667, '4', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1667, '5', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1667, '1', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1667, '2]', '1', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1667, '[1]', '1', 25, 5);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，查找元素范围。
输入: [5,7,7,8,8,10], target=8 输出: [3,4] [题168]', '二分', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1668, '[5', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1668, '7', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1668, '7', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1668, '8', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1668, '8', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1668, '10] 8', '[3', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1668, '4]', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1668, '[1', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1668, '2', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1668, '3] 4', '[-1', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1668, '-1]', '', 25, 10);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串转浮点数。
输入: \"123.45\" 输出: 123.45
输入: \"-6.78\" 输出: -6.78 [题169]', '处理整数和小数部分', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1669, '123.45', '123.45', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1669, '-6.78', '-6.78', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，扁平化嵌套列表。
输入: [[1,2],3,[4,5]] 输出: [1,2,3,4,5] [题170]', '递归或栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1670, '[[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1670, '2]', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1670, '3', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1670, '[4', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1670, '5]]', '[1', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1670, '2', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1670, '3', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1670, '4', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1670, '5]', '', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，扁平化二叉树为链表。
输入: [1,2,null,3,null,4,null,5] 输出: [1,null,2,null,3,null,4,null,5,null] [题171]', '前序遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1671, 'tree', 'linked', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，验证平衡括号。
输入: \'{[()]}\' 输出: true
输入: \'{[(])}\' 输出: false [题172]', '栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1672, '{[()]}', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1672, '{[(])}', 'false', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，无重复字符最长子串。
输入: \"abcabcbb\" 输出: 3
输入: \"bbbbb\" 输出: 1 [题173]', '滑动窗口', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1673, 'abcabcbb', '3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1673, 'bbbbb', '1', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串所有排列。
输入: \"abc\" 输出: [\"abc\",\"acb\",\"bac\",\"bca\",\"cab\",\"cba\"] [题174]', '回溯', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1674, 'abc', '6', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1674, 'a', '1', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，第N个丑数。
输入: 10 输出: 12 [题175]', '三指针', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1675, '10', '12', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1675, '1', '1', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，两个链表的下一个更大节点。
输入: 2->1->5 输出: 5->5->0 [题176]', '单调栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1676, '2', '1', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，移除重复元素使得出现一次。
输入: [1,2,2,3,3,3] 输出: 6 [题177]', '异或运算', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1677, '[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1677, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1677, '2', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1677, '3', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1677, '3', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1677, '3]', '6', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1677, '[1', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1677, '1', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1677, '1]', '1', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串最后一个单词长度。
输入: \"hello world\" 输出: 5 [题178]', '反向遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1678, 'hello world', '5', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1678, 'abc', '3', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，验证回文串。
输入: \"A man, a plan, a canal: Panama\" 输出: true [题179]', '双指针', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1679, 'A man a plan a canal Panama', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1679, 'race a car', 'false', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，模拟浏览器前进后退。
输入: BrowserHistory(\'leetcode.com\') [题180]', '双栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1680, 'leetcode.com forward', 'com', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1680, 'back', 'leetcode.com', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，最大栈。
输入: MaxStack() 输出: 支持push、pop、max操作 [题181]', '辅助栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1681, 'push', 'pop', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，丑数。
输入: 6 输出: true
输入: 8 输出: true
输入: 14 输出: false [题182]', '分解质因数', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1682, '6', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1682, '8', 'true', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1682, '14', 'false', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，完全平方数。
输入: 12 输出: 3 (因为3^2=9是最接近的完全平方数) [题183]', '动态规划或二分', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1683, '12', '3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1683, '16', '0', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1683, '1', '0', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串循环移位。
输入: \"abcdef\" 左移2位 输出: \"cdefab\" [题184]', '拼接', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1684, 'abcdef 2', 'cdefab', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，乱序单词分组。
输入: [\"eat\",\"tea\",\"tan\",\"ate\",\"nat\",\"bat\"] 输出: [[\"eat\",\"tea\",\"ate\"],[\"tan\",\"nat\"],[\"bat\"]] [题185]', '排序后哈希', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1685, 'eat tea tan ate nat bat', '3组', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串压缩。
输入: \"aabcccccaaa\" 输出: \"a2b1c5a3\" [题186]', '计数压缩', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1686, 'aabcccccaaa', 'a2b1c5a3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1686, 'abcd', 'abcd', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，旋转图像90度。
输入: [[1,2,3],[4,5,6],[7,8,9]] 输出: [[7,4,1],[8,5,2],[9,6,3]] [题187]', '先转置再翻转', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1687, 'matrix', 'rotated', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，矩阵置零。
输入: [[1,1,1],[1,0,1],[1,1,1]] 输出: [[1,0,1],[0,0,0],[1,0,1]] [题188]', '标记行列', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1688, 'matrix', 'zeroed', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，加一。
输入: [1,2,3] 输出: [1,2,4]
输入: [9,9,9] 输出: [1,0,0,0] [题189]', '进位处理', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1689, '1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1689, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1689, '3', '1', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1689, '2', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1689, '4', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1689, '9', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1689, '9', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1689, '9', '1', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1689, '0', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1689, '0', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1689, '0', '', 25, 10);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串相乘。
输入: \"123\" × \"456\" 输出: \"56088\" [题190]', '列竖式', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1690, '123 456', '56088', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1690, '0 0', '0', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，有效的数独。
输入: 9x9数独数组 输出: true/false [题191]', '行列宫遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1691, 'board', 'true/false', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，颠倒二进制位。
输入: 43261596 (二进制 00000010100101000001111010011100) 输出: 964176192 [题192]', '逐位反转', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1692, '43261596', '964176192', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1692, '1', '2147483648', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，位1的个数。
输入: 11 (二进制 00000000000000000000000000001011) 输出: 3 [题193]', '位运算', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1693, '11', '3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1693, '128', '1', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，2的幂次方。
输入: 1 输出: true
输入: 16 输出: true
输入: 218 输出: false [题194]', 'n&(n-1)==0', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1694, '1', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1694, '16', 'true', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1694, '218', 'false', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，缺失的第一个正数。
输入: [3,-1,4,2] 输出: 1
输入: [1,2,0] 输出: 3 [题195]', '原地哈希', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1695, '3 -1 4 2', '1', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1695, '1 2 0', '3', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字母异位词分组。
输入: [\"eat\",\"tea\",\"tan\"] 输出: [[\"eat\",\"tea\",\"ate\"],[\"tan\"]] [题196]', '排序哈希', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1696, 'eat tea tan', '2组', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，合并两个有序数组。
输入: nums1=[1,2,3], m=3, nums2=[2,5,6], n=3 输出: [1,2,2,3,5,6] [题197]', '从后往前', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1697, 'nums1 nums2', 'merged', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，验证二叉搜索树。
输入: [5,1,4,null,null,3,6] 输出: false [题198]', '递归', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1698, '5', '1', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，二叉搜索树最近公共祖先。
输入: [6,2,8,0,4,7,9,null,null,3,5], p=2, q=8 输出: 6 [题199]', 'BST性质', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1699, 'tree 2 8', '6', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1699, 'tree 2 4', '2', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，二叉树路径总和II。
输入: [1,2] 输出: 所有从根到叶子路径和为sum的路径 [题200]', '回溯', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1700, '1', '2', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1700, '2]]', '', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，构建乘积数组。
输入: [1,2,3,4,5] 输出: [120,60,40,30,24] [题201]', '左右遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1701, '[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1701, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1701, '3', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1701, '4', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1701, '5]', '[120', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1701, '60', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1701, '40', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1701, '30', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1701, '24]', '', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，复制带随机指针的链表。
输入: 链表，每个节点有next和random指针 输出: 深拷贝 [题202]', '哈希表', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1702, 'linked', 'cloned', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，变位词组。
输入: \"eat\",\"tea\",\"tan\",\"ate\",\"nat\",\"bat\" 输出: [[\"eat\",\"tea\",\"ate\"],[\"tan\",\"nat\"],[\"bat\"]] [题203]', '排序分组', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1703, '6words', '3组', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，前K个高频元素。
输入: [1,1,1,2,2,3], k=2 输出: [1,2] [题204]', '堆', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1704, '[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1704, '1', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1704, '1', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1704, '2', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1704, '2', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1704, '3] 2', '[1', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1704, '2]', '', 25, 6);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，合并区间。
输入: [[1,4],[0,4]] 输出: [[0,4]] [题205]', '排序合并', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1705, 'intervals', 'merged', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串解码。
输入: \"3[a2[c]]\" 输出: \"accaccacc\" [题206]', '栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1706, '3[a2[c]]', 'accaccacc', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，简化路径。
输入: \"/home//foo/\" 输出: \"/home/foo\" [题207]', '栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1707, '/home//foo/', '/home/foo', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，逆波兰表达式求值。
输入: [\"2\",\"1\",\"+\",\"3\",\"*\"] 输出: 9 [题208]', '栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1708, '2 1 + 3 *', '9', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，跳跃游戏。
输入: [2,3,1,1,4] 输出: true [题209]', '贪心', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1709, '[2', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1709, '3', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1709, '1', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1709, '1', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1709, '4]', 'true', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1709, '[3', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1709, '2', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1709, '1', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1709, '0]', 'false', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，加油站。
输入: gas=[1,2,3,4,5], cost=[2,3,4,5,1] 输出: 3 [题210]', '贪心', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1710, 'gas cost', '3', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，分糖果。
输入: ratings=[1,0,2] 输出: 5 [题211]', '贪心', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1711, 'ratings', '5', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，赎金信。
输入: ransom=\"aa\", magazine=\"aab\" 输出: true [题212]', '哈希计数', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1712, 'aa aab', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1712, 'ab aac', 'false', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个字符串是否是回文。回文是指正读和反读都一样的字符串。
输入: \"aba\" 输出: true
输入: \"abca\" 输出: false [题213]', '使用双指针或反转比较', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1713, 'aba', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1713, 'abca', 'false', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1713, 'a', 'true', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1713, 'abc', 'false', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，计算字符串中单词的数量。单词是用空格分隔的连续字符序列。
输入: \"hello world\" 输出: 2
输入: \"abc\" 输出: 1 [题214]', '按空格分割', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1714, 'hello world', '2', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1714, 'abc', '1', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1714, 'a b c', '3', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1714, '', '0', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，移除数组中所有等于val的元素，返回新数组长度。
输入: [3,2,3,3], val=3 输出: 2 [题215]', '双指针法', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1715, '[3', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1715, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1715, '3', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1715, '3] 3', '2', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1715, '[1', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1715, '2', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1715, '3', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1715, '4] 5', '4', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1715, '[1', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1715, '1', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1715, '1] 1', '0', 25, 10);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，合并两个有序数组为一个有序数组。
输入: [1,3,5], [2,4,6] 输出: [1,2,3,4,5,6] [题216]', '双指针合并', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1716, '[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1716, '3', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1716, '5] [2', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1716, '4', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1716, '6]', '[1', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1716, '2', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1716, '3', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1716, '4', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1716, '5', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1716, '6]', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1716, '[1', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1716, '2', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1716, '3] [4', '', 25, 12);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1716, '5', '', 25, 13);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1716, '6]', '[1', 25, 14);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1716, '2', '', 25, 15);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1716, '3', '', 25, 16);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1716, '4', '', 25, 17);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1716, '5', '', 25, 18);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1716, '6]', '', 25, 19);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个数是否是质数。质数是大于1的自然数，除了1和它本身外不能被其他自然数整除。
输入: 2 输出: true
输入: 4 输出: false [题217]', '试除法', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1717, '2', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1717, '3', 'true', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1717, '4', 'false', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1717, '17', 'true', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1717, '1', 'false', 25, 4);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，返回斐波那契数列第n项。F(0)=0, F(1)=1, F(n)=F(n-1)+F(n-2)。
输入: 5 输出: 5
输入: 10 输出: 55 [题218]', '迭代或矩阵', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1718, '5', '5', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1718, '10', '55', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1718, '0', '0', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1718, '1', '1', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，计算一个整数的阶乘。n! = n × (n-1) × ... × 2 × 1
输入: 5 输出: 120
输入: 0 输出: 1 [题219]', '递归或迭代', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1719, '5', '120', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1719, '0', '1', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1719, '10', '3628800', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，求两个数的最大公约数（欧几里得算法）。
输入: 12, 8 输出: 4
输入: 24, 18 输出: 6 [题220]', '辗转相除', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1720, '12 8', '4', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1720, '24 18', '6', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1720, '100 25', '25', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，求两个数的最小公倍数。
输入: 4, 6 输出: 12
输入: 5, 10 输出: 10 [题221]', '公式LCM=a*b/GCD', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1721, '4 6', '12', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1721, '5 10', '10', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1721, '7 3', '21', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，将字符串中的空格替换为%20。
输入: \"hello world\" 输出: \"hello%20world\"
输入: \" \" 输出: \"%20\" [题222]', '从后往前复制', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1722, 'hello world', 'hello%20world', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1722, '  ', '%20', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1722, 'abc', 'abc', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个链表是否有环。
输入: 3->2->1->2 返回true
输入: 1->2 返回false [题223]', '快慢指针', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1723, '3', '2', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1723, '1', '2', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，返回链表的倒数第k个节点。
输入: 1->2->3->4->5, k=2 输出: 4
输入: 1->2->3, k=3 输出: 1 [题224]', '快慢指针', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1724, '1', '2', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1724, '1', '2', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个数是否是2的幂。
输入: 8 输出: true
输入: 6 输出: false [题225]', '二进制或除二', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1725, '8', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1725, '6', 'false', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1725, '1', 'true', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1725, '1024', 'true', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，返回字符串中第一个不重复的字符。
输入: \"abracadabra\" 输出: \'c\'
输入: \"aabbcc\" 输出: null [题226]', '哈希表计数', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1726, 'abracadabra', 'c', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1726, 'aabbcc', 'null', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1726, 'abc', 'a', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，将数字转换为字符串。
输入: 123 输出: \"123\"
输入: -456 输出: \"-456\" [题227]', '考虑负数', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1727, '123', '123', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1727, '-456', '-456', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1727, '0', '0', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，将字符串转换为整数。
输入: \"123\" 输出: 123
输入: \"-456\" 输出: -456 [题228]', '考虑空字符和正负号', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1728, '123', '123', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1728, '-456', '-456', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1728, '  -42', '-42', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，计算数组中连续子数组的最大和。
输入: [-2,1,-3,4,-1,2,1,-5,4] 输出: 6
输入: [1] 输出: 1 [题229]', 'Kadane算法', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1729, '[-2', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1729, '1', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1729, '-3', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1729, '4', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1729, '-1', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1729, '2', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1729, '1', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1729, '-5', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1729, '4]', '6', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1729, '[1]', '1', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1729, '[5', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1729, '4', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1729, '-1', '', 25, 12);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1729, '7', '', 25, 13);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1729, '8]', '23', 25, 14);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断两个字符串是否是字母异位词。
输入: \"anagram\", \"nagaram\" 输出: true
输入: \"rat\", \"car\" 输出: false [题230]', '计数比较', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1730, 'anagram nagaram', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1730, 'rat car', 'false', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1730, 'a', 'true', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，求两个链表的交点。
输入: A: 1->3->5, B: 2->4->3->5 输出: 5 [题231]', '双指针遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1731, '1', '3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1731, '1', '2 3', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个数是否是水仙花数。
输入: 153 输出: true (1^3+5^3+3^3=153)
输入: 123 输出: false [题232]', '立方和计算', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1732, '153', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1732, '123', 'false', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1732, '407', 'true', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，返回数组中第K大的元素。
输入: [3,2,1,5,6,4], k=2 输出: 5 [题233]', '快速选择或堆', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1733, '[3', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1733, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1733, '1', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1733, '5', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1733, '6', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1733, '4] 2', '5', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1733, '[3', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1733, '1', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1733, '2] 1', '3', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，验证二叉搜索树。
输入: [2,1,3] 输出: true
输入: [5,1,4,null,null,3,6] 输出: false [题234]', '递归验证范围', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1734, '2', '1', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1734, '5', '1', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，合并两个有序链表。
输入: 1->2->4, 1->3->4 输出: 1->1->2->3->4->4 [题235]', '双指针归并', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1735, '1', '2', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个二叉树是否平衡。
输入: [3,9,20,null,null,15,7] 输出: true [题236]', '递归计算深度', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1736, '3', '9', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，实现pow(x, n)，计算x的n次幂。
输入: 2, 10 输出: 1024
输入: 2, -2 输出: 0.5 [题237]', '快速幂', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1737, '2 10', '1024', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1737, '2 -2', '0.5', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1737, '3 3', '27', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，遍历二叉树每行。
输入: [3,9,20,null,null,15,7] 输出: [[3],[9,20],[15,7]] [题238]', '层序遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1738, '3', '9', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1738, '[9', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1738, '20]', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1738, '[15', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1738, '7]]', '', 25, 4);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，从数组中找出和为目标值的两个数的下标。
输入: [2,7,11,15], target=9 输出: [0,1] [题239]', '哈希表', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1739, '[2', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1739, '7', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1739, '11', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1739, '15] 9', '[0', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1739, '1]', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1739, '[3', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1739, '2', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1739, '4] 6', '[1', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1739, '2]', '', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，生成杨辉三角。
输入: 5 输出: [[1],[1,1],[1,2,1],[1,3,3,1],[1,4,6,4,1]] [题240]', '递推生成', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1740, '5', '[[1]', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1740, '[1', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1740, '1]', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1740, '[1', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1740, '2', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1740, '1]', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1740, '[1', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1740, '3', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1740, '3', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1740, '1]', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1740, '[1', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1740, '4', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1740, '6', '', 25, 12);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1740, '4', '', 25, 13);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1740, '1]]', '', 25, 14);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1740, '3', '[[1]', 25, 15);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1740, '[1', '', 25, 16);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1740, '1]', '', 25, 17);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1740, '[1', '', 25, 18);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1740, '2', '', 25, 19);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1740, '1]]', '', 25, 20);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，螺旋矩阵。
输入: 3 输出: [[1,2,3],[8,9,4],[7,6,5]] [题241]', '模拟遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1741, '3', '[[1', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1741, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1741, '3]', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1741, '[8', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1741, '9', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1741, '4]', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1741, '[7', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1741, '6', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1741, '5]]', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1741, '2', '[[1', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1741, '2]', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1741, '[4', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1741, '3]]', '', 25, 12);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，搜索旋转排序数组。
输入: [4,5,6,7,0,1,2], target=0 输出: 4 [题242]', '二分查找', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1742, '[4', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1742, '5', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1742, '6', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1742, '7', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1742, '0', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1742, '1', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1742, '2] 0', '4', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1742, '[4', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1742, '5', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1742, '6', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1742, '7', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1742, '0', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1742, '1', '', 25, 12);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1742, '2] 5', '1', 25, 13);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，找到数组中的多数元素。
输入: [3,2,3] 输出: 3
输入: [2,2,1,1,1,2,2] 输出: 2 [题243]', '投票算法', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1743, '[3', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1743, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1743, '3]', '3', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1743, '[2', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1743, '2', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1743, '1', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1743, '1', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1743, '1', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1743, '2', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1743, '2]', '2', 25, 9);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，求岛屿数量。
输入: [[\'1\',\'1\',\'0\',\'0\',\'0\'],[\'1\',\'1\',\'0\',\'0\',\'0\']] 输出: 1 [题244]', 'DFS或BFS', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1744, 'grid', '1', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1744, 'grid', '2', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，括号生成。
输入: 3 输出: [\'((()))\',\'(()())\',\'(())()\',\'()(())\',\'()()()\'] [题245]', '回溯', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1745, '3', '5', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1745, '2', '2', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，全排列。
输入: [1,2,3] 输出: [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]] [题246]', '回溯', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1746, '[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1746, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1746, '3]', '6', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1746, '[1]', '1', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，组合总和。
输入: candidates=[2,3,6,7], target=7 输出: [[2,2,3],[7]] [题247]', '回溯+剪枝', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1747, '2', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1747, '3', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1747, '6', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1747, '7 7', '[[2', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1747, '2', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1747, '3]', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1747, '[7]]', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1747, '1', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1747, '2 3', '[[1', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1747, '1', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1747, '1]', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1747, '[1', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1747, '2]]', '', 25, 12);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，子集。
输入: [1,2,3] 输出: [[],[1],[2],[3],[1,2],[1,3],[2,3],[1,2,3]] [题248]', '回溯', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1748, '[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1748, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1748, '3]', '8', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1748, '[1]', '2', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，括号有效。
输入: \"()[]{}\" 输出: true
输入: \"([)]\" 输出: false [题249]', '栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1749, '()[]{}', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1749, '([)]', 'false', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1749, '(', 'false', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串解码。
输入: \"3[a]2[bc]\" 输出: \"aaabcbc\"
输入: \"2[abc]3[cd]ef\" 输出: \"abcabccdcdcdef\" [题250]', '栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1750, '3[a]2[bc]', 'aaabcbc', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1750, '2[abc]3[cd]ef', 'abcabccdcdcdef', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，岛屿最大面积。
输入: [[0,0,1,0,0],[0,0,0,0,0]] 输出: 1 [题251]', 'DFS', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1751, 'grid', '1', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1751, 'grid', '4', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，课程表。
输入: numCourses=4, prerequisites=[[1,0],[2,0],[3,1],[3,2]] 输出: true [题252]', '拓扑排序', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1752, '4 [[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1752, '0]', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1752, '[2', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1752, '0]', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1752, '[3', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1752, '1]', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1752, '[3', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1752, '2]]', 'true', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1752, '2 [[1', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1752, '0]]', 'true', 25, 9);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，合并区间。
输入: [[1,3],[2,6],[8,10],[15,18]] 输出: [[1,6],[8,10],[15,18]] [题253]', '排序后合并', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1753, '[[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1753, '3]', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1753, '[2', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1753, '6]', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1753, '[8', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1753, '10]', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1753, '[15', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1753, '18]]', '[[1', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1753, '6]', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1753, '[8', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1753, '10]', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1753, '[15', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1753, '18]]', '', 25, 12);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，最长递增子序列长度。
输入: [10,9,2,5,3,7,101,18] 输出: 4 [题254]', 'DP或二分', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1754, '[10', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1754, '9', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1754, '2', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1754, '5', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1754, '3', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1754, '7', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1754, '101', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1754, '18]', '4', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1754, '[1]', '1', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，最长公共子序列。
输入: \"abcde\", \"ace\" 输出: 3 [题255]', 'DP', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1755, 'abcde ace', '3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1755, 'abc abc', '3', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，最长回文子串。
输入: \"babad\" 输出: \"bab\"
输入: \"cbbd\" 输出: \"bb\" [题256]', 'Manacher或DP', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1756, 'babad', 'bab', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1756, 'cbbd', 'bb', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，编辑距离。
输入: \"horse\", \"ros\" 输出: 3 [题257]', 'DP', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1757, 'horse ros', '3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1757, 'ros ros', '0', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，买卖股票最佳时机。
输入: [7,1,5,3,6,4] 输出: 5 [题258]', '一次遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1758, '[7', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1758, '1', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1758, '5', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1758, '3', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1758, '6', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1758, '4]', '5', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1758, '[7', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1758, '6', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1758, '4', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1758, '3', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1758, '1]', '0', 25, 10);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，打家劫舍。
输入: [1,2,3,1] 输出: 4
输入: [2,7,9,3,1] 输出: 12 [题259]', 'DP', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1759, '[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1759, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1759, '3', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1759, '1]', '4', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1759, '[2', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1759, '7', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1759, '9', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1759, '3', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1759, '1]', '12', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，跳台阶。
输入: 10 输出: 89 [题260]', '斐波那契', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1760, '10', '89', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1760, '5', '8', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1760, '0', '1', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，三数之和。
输入: [-1,0,1,2,-1,-4] 输出: [[-1,-1,2],[-1,0,1]] [题261]', '双指针', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1761, '[-1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1761, '0', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1761, '1', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1761, '2', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1761, '-1', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1761, '-4]', '[[-1', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1761, '-1', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1761, '2]', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1761, '[-1', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1761, '0', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1761, '1]]', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1761, '[]', '[]', 25, 11);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，电话号码的字母组合。
输入: \"23\" 输出: [\"ad\",\"ae\",\"af\",\"bd\",\"be\",\"bf\",\"cd\",\"ce\",\"cf\"] [题262]', '回溯', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1762, '23', '9', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1762, '2', '3', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，二叉树的最大深度。
输入: [3,9,20,null,null,15,7] 输出: 3 [题263]', '递归', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1763, '3', '9', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1763, '1', '1', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，对称二叉树。
输入: [1,2,2,3,4,4,3] 输出: true [题264]', '递归比较', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1764, '1', '2', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，二叉树层序遍历。
输入: [3,9,20,null,null,15,7] 输出: [[3],[9,20],[15,7]] [题265]', '队列', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1765, '3', '9', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1765, '[9', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1765, '20]', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1765, '[15', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1765, '7]]', '', 25, 4);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，填充每个节点的下一个右侧节点指针。
输入: [1,2,3,4,5,6,7] 输出: [[1,#],[2,3,#],[4,5,6,7,#]] [题266]', '层序', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1766, '1', '2', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，二叉树前序遍历。
输入: [1,null,2,3] 输出: [1,2,3] [题267]', '递归或栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1767, '1', 'null', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1767, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1767, '3]', '', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，二叉树中序遍历。
输入: [1,null,2,3] 输出: [1,3,2] [题268]', '递归或栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1768, '1', 'null', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1768, '3', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1768, '2]', '', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，二叉树后序遍历。
输入: [1,2,3] 输出: [3,2,1] [题269]', '递归或栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1769, '1', '2', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1769, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1769, '1]', '', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，路径总和。
输入: [5,4,8,11,null,13,4,7,2,null,null,1] 输出: true [题270]', '递归', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1770, 'tree 22', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1770, 'tree 12', 'false', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，从前序和中序构建二叉树。
输入: preorder=[3,9,20,15,7], inorder=[9,3,15,20,7] 输出: [3,9,20,null,null,15,7] [题271]', '递归', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1771, 'preorder inorder', 'tree', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，搜索二维矩阵。
输入: [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target=3 输出: true [题272]', '二分或Z字搜索', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1772, 'matrix 3', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1772, 'matrix 13', 'false', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，搜索旋转数组最小值。
输入: [3,4,5,1,2] 输出: 1 [题273]', '二分', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1773, '[3', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1773, '4', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1773, '5', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1773, '1', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1773, '2]', '1', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1773, '[1]', '1', 25, 5);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，查找元素范围。
输入: [5,7,7,8,8,10], target=8 输出: [3,4] [题274]', '二分', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1774, '[5', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1774, '7', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1774, '7', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1774, '8', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1774, '8', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1774, '10] 8', '[3', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1774, '4]', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1774, '[1', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1774, '2', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1774, '3] 4', '[-1', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1774, '-1]', '', 25, 10);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串转浮点数。
输入: \"123.45\" 输出: 123.45
输入: \"-6.78\" 输出: -6.78 [题275]', '处理整数和小数部分', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1775, '123.45', '123.45', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1775, '-6.78', '-6.78', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，扁平化嵌套列表。
输入: [[1,2],3,[4,5]] 输出: [1,2,3,4,5] [题276]', '递归或栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1776, '[[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1776, '2]', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1776, '3', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1776, '[4', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1776, '5]]', '[1', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1776, '2', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1776, '3', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1776, '4', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1776, '5]', '', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，扁平化二叉树为链表。
输入: [1,2,null,3,null,4,null,5] 输出: [1,null,2,null,3,null,4,null,5,null] [题277]', '前序遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1777, 'tree', 'linked', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，验证平衡括号。
输入: \'{[()]}\' 输出: true
输入: \'{[(])}\' 输出: false [题278]', '栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1778, '{[()]}', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1778, '{[(])}', 'false', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，无重复字符最长子串。
输入: \"abcabcbb\" 输出: 3
输入: \"bbbbb\" 输出: 1 [题279]', '滑动窗口', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1779, 'abcabcbb', '3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1779, 'bbbbb', '1', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串所有排列。
输入: \"abc\" 输出: [\"abc\",\"acb\",\"bac\",\"bca\",\"cab\",\"cba\"] [题280]', '回溯', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1780, 'abc', '6', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1780, 'a', '1', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，第N个丑数。
输入: 10 输出: 12 [题281]', '三指针', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1781, '10', '12', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1781, '1', '1', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，两个链表的下一个更大节点。
输入: 2->1->5 输出: 5->5->0 [题282]', '单调栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1782, '2', '1', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，移除重复元素使得出现一次。
输入: [1,2,2,3,3,3] 输出: 6 [题283]', '异或运算', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1783, '[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1783, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1783, '2', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1783, '3', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1783, '3', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1783, '3]', '6', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1783, '[1', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1783, '1', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1783, '1]', '1', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串最后一个单词长度。
输入: \"hello world\" 输出: 5 [题284]', '反向遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1784, 'hello world', '5', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1784, 'abc', '3', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，验证回文串。
输入: \"A man, a plan, a canal: Panama\" 输出: true [题285]', '双指针', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1785, 'A man a plan a canal Panama', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1785, 'race a car', 'false', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，模拟浏览器前进后退。
输入: BrowserHistory(\'leetcode.com\') [题286]', '双栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1786, 'leetcode.com forward', 'com', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1786, 'back', 'leetcode.com', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，最大栈。
输入: MaxStack() 输出: 支持push、pop、max操作 [题287]', '辅助栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1787, 'push', 'pop', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，丑数。
输入: 6 输出: true
输入: 8 输出: true
输入: 14 输出: false [题288]', '分解质因数', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1788, '6', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1788, '8', 'true', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1788, '14', 'false', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，完全平方数。
输入: 12 输出: 3 (因为3^2=9是最接近的完全平方数) [题289]', '动态规划或二分', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1789, '12', '3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1789, '16', '0', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1789, '1', '0', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串循环移位。
输入: \"abcdef\" 左移2位 输出: \"cdefab\" [题290]', '拼接', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1790, 'abcdef 2', 'cdefab', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，乱序单词分组。
输入: [\"eat\",\"tea\",\"tan\",\"ate\",\"nat\",\"bat\"] 输出: [[\"eat\",\"tea\",\"ate\"],[\"tan\",\"nat\"],[\"bat\"]] [题291]', '排序后哈希', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1791, 'eat tea tan ate nat bat', '3组', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串压缩。
输入: \"aabcccccaaa\" 输出: \"a2b1c5a3\" [题292]', '计数压缩', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1792, 'aabcccccaaa', 'a2b1c5a3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1792, 'abcd', 'abcd', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，旋转图像90度。
输入: [[1,2,3],[4,5,6],[7,8,9]] 输出: [[7,4,1],[8,5,2],[9,6,3]] [题293]', '先转置再翻转', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1793, 'matrix', 'rotated', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，矩阵置零。
输入: [[1,1,1],[1,0,1],[1,1,1]] 输出: [[1,0,1],[0,0,0],[1,0,1]] [题294]', '标记行列', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1794, 'matrix', 'zeroed', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，加一。
输入: [1,2,3] 输出: [1,2,4]
输入: [9,9,9] 输出: [1,0,0,0] [题295]', '进位处理', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1795, '1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1795, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1795, '3', '1', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1795, '2', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1795, '4', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1795, '9', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1795, '9', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1795, '9', '1', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1795, '0', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1795, '0', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1795, '0', '', 25, 10);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串相乘。
输入: \"123\" × \"456\" 输出: \"56088\" [题296]', '列竖式', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1796, '123 456', '56088', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1796, '0 0', '0', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，有效的数独。
输入: 9x9数独数组 输出: true/false [题297]', '行列宫遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1797, 'board', 'true/false', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，颠倒二进制位。
输入: 43261596 (二进制 00000010100101000001111010011100) 输出: 964176192 [题298]', '逐位反转', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1798, '43261596', '964176192', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1798, '1', '2147483648', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，位1的个数。
输入: 11 (二进制 00000000000000000000000000001011) 输出: 3 [题299]', '位运算', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1799, '11', '3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1799, '128', '1', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，2的幂次方。
输入: 1 输出: true
输入: 16 输出: true
输入: 218 输出: false [题300]', 'n&(n-1)==0', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1800, '1', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1800, '16', 'true', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1800, '218', 'false', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，缺失的第一个正数。
输入: [3,-1,4,2] 输出: 1
输入: [1,2,0] 输出: 3 [题301]', '原地哈希', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1801, '3 -1 4 2', '1', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1801, '1 2 0', '3', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字母异位词分组。
输入: [\"eat\",\"tea\",\"tan\"] 输出: [[\"eat\",\"tea\",\"ate\"],[\"tan\"]] [题302]', '排序哈希', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1802, 'eat tea tan', '2组', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，合并两个有序数组。
输入: nums1=[1,2,3], m=3, nums2=[2,5,6], n=3 输出: [1,2,2,3,5,6] [题303]', '从后往前', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1803, 'nums1 nums2', 'merged', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，验证二叉搜索树。
输入: [5,1,4,null,null,3,6] 输出: false [题304]', '递归', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1804, '5', '1', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，二叉搜索树最近公共祖先。
输入: [6,2,8,0,4,7,9,null,null,3,5], p=2, q=8 输出: 6 [题305]', 'BST性质', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1805, 'tree 2 8', '6', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1805, 'tree 2 4', '2', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，二叉树路径总和II。
输入: [1,2] 输出: 所有从根到叶子路径和为sum的路径 [题306]', '回溯', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1806, '1', '2', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1806, '2]]', '', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，构建乘积数组。
输入: [1,2,3,4,5] 输出: [120,60,40,30,24] [题307]', '左右遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1807, '[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1807, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1807, '3', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1807, '4', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1807, '5]', '[120', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1807, '60', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1807, '40', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1807, '30', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1807, '24]', '', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，复制带随机指针的链表。
输入: 链表，每个节点有next和random指针 输出: 深拷贝 [题308]', '哈希表', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1808, 'linked', 'cloned', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，变位词组。
输入: \"eat\",\"tea\",\"tan\",\"ate\",\"nat\",\"bat\" 输出: [[\"eat\",\"tea\",\"ate\"],[\"tan\",\"nat\"],[\"bat\"]] [题309]', '排序分组', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1809, '6words', '3组', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，前K个高频元素。
输入: [1,1,1,2,2,3], k=2 输出: [1,2] [题310]', '堆', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1810, '[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1810, '1', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1810, '1', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1810, '2', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1810, '2', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1810, '3] 2', '[1', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1810, '2]', '', 25, 6);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，合并区间。
输入: [[1,4],[0,4]] 输出: [[0,4]] [题311]', '排序合并', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1811, 'intervals', 'merged', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串解码。
输入: \"3[a2[c]]\" 输出: \"accaccacc\" [题312]', '栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1812, '3[a2[c]]', 'accaccacc', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，简化路径。
输入: \"/home//foo/\" 输出: \"/home/foo\" [题313]', '栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1813, '/home//foo/', '/home/foo', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，逆波兰表达式求值。
输入: [\"2\",\"1\",\"+\",\"3\",\"*\"] 输出: 9 [题314]', '栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1814, '2 1 + 3 *', '9', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，跳跃游戏。
输入: [2,3,1,1,4] 输出: true [题315]', '贪心', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1815, '[2', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1815, '3', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1815, '1', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1815, '1', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1815, '4]', 'true', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1815, '[3', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1815, '2', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1815, '1', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1815, '0]', 'false', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，加油站。
输入: gas=[1,2,3,4,5], cost=[2,3,4,5,1] 输出: 3 [题316]', '贪心', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1816, 'gas cost', '3', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，分糖果。
输入: ratings=[1,0,2] 输出: 5 [题317]', '贪心', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1817, 'ratings', '5', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，赎金信。
输入: ransom=\"aa\", magazine=\"aab\" 输出: true [题318]', '哈希计数', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1818, 'aa aab', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1818, 'ab aac', 'false', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个字符串是否是回文。回文是指正读和反读都一样的字符串。
输入: \"aba\" 输出: true
输入: \"abca\" 输出: false [题319]', '使用双指针或反转比较', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1819, 'aba', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1819, 'abca', 'false', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1819, 'a', 'true', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1819, 'abc', 'false', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，计算字符串中单词的数量。单词是用空格分隔的连续字符序列。
输入: \"hello world\" 输出: 2
输入: \"abc\" 输出: 1 [题320]', '按空格分割', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1820, 'hello world', '2', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1820, 'abc', '1', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1820, 'a b c', '3', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1820, '', '0', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，移除数组中所有等于val的元素，返回新数组长度。
输入: [3,2,3,3], val=3 输出: 2 [题321]', '双指针法', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1821, '[3', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1821, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1821, '3', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1821, '3] 3', '2', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1821, '[1', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1821, '2', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1821, '3', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1821, '4] 5', '4', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1821, '[1', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1821, '1', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1821, '1] 1', '0', 25, 10);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，合并两个有序数组为一个有序数组。
输入: [1,3,5], [2,4,6] 输出: [1,2,3,4,5,6] [题322]', '双指针合并', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1822, '[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1822, '3', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1822, '5] [2', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1822, '4', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1822, '6]', '[1', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1822, '2', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1822, '3', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1822, '4', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1822, '5', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1822, '6]', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1822, '[1', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1822, '2', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1822, '3] [4', '', 25, 12);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1822, '5', '', 25, 13);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1822, '6]', '[1', 25, 14);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1822, '2', '', 25, 15);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1822, '3', '', 25, 16);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1822, '4', '', 25, 17);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1822, '5', '', 25, 18);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1822, '6]', '', 25, 19);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个数是否是质数。质数是大于1的自然数，除了1和它本身外不能被其他自然数整除。
输入: 2 输出: true
输入: 4 输出: false [题323]', '试除法', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1823, '2', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1823, '3', 'true', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1823, '4', 'false', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1823, '17', 'true', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1823, '1', 'false', 25, 4);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，返回斐波那契数列第n项。F(0)=0, F(1)=1, F(n)=F(n-1)+F(n-2)。
输入: 5 输出: 5
输入: 10 输出: 55 [题324]', '迭代或矩阵', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1824, '5', '5', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1824, '10', '55', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1824, '0', '0', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1824, '1', '1', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，计算一个整数的阶乘。n! = n × (n-1) × ... × 2 × 1
输入: 5 输出: 120
输入: 0 输出: 1 [题325]', '递归或迭代', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1825, '5', '120', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1825, '0', '1', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1825, '10', '3628800', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，求两个数的最大公约数（欧几里得算法）。
输入: 12, 8 输出: 4
输入: 24, 18 输出: 6 [题326]', '辗转相除', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1826, '12 8', '4', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1826, '24 18', '6', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1826, '100 25', '25', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，求两个数的最小公倍数。
输入: 4, 6 输出: 12
输入: 5, 10 输出: 10 [题327]', '公式LCM=a*b/GCD', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1827, '4 6', '12', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1827, '5 10', '10', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1827, '7 3', '21', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，将字符串中的空格替换为%20。
输入: \"hello world\" 输出: \"hello%20world\"
输入: \" \" 输出: \"%20\" [题328]', '从后往前复制', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1828, 'hello world', 'hello%20world', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1828, '  ', '%20', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1828, 'abc', 'abc', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个链表是否有环。
输入: 3->2->1->2 返回true
输入: 1->2 返回false [题329]', '快慢指针', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1829, '3', '2', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1829, '1', '2', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，返回链表的倒数第k个节点。
输入: 1->2->3->4->5, k=2 输出: 4
输入: 1->2->3, k=3 输出: 1 [题330]', '快慢指针', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1830, '1', '2', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1830, '1', '2', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个数是否是2的幂。
输入: 8 输出: true
输入: 6 输出: false [题331]', '二进制或除二', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1831, '8', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1831, '6', 'false', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1831, '1', 'true', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1831, '1024', 'true', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，返回字符串中第一个不重复的字符。
输入: \"abracadabra\" 输出: \'c\'
输入: \"aabbcc\" 输出: null [题332]', '哈希表计数', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1832, 'abracadabra', 'c', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1832, 'aabbcc', 'null', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1832, 'abc', 'a', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，将数字转换为字符串。
输入: 123 输出: \"123\"
输入: -456 输出: \"-456\" [题333]', '考虑负数', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1833, '123', '123', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1833, '-456', '-456', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1833, '0', '0', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，将字符串转换为整数。
输入: \"123\" 输出: 123
输入: \"-456\" 输出: -456 [题334]', '考虑空字符和正负号', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1834, '123', '123', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1834, '-456', '-456', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1834, '  -42', '-42', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，计算数组中连续子数组的最大和。
输入: [-2,1,-3,4,-1,2,1,-5,4] 输出: 6
输入: [1] 输出: 1 [题335]', 'Kadane算法', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1835, '[-2', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1835, '1', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1835, '-3', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1835, '4', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1835, '-1', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1835, '2', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1835, '1', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1835, '-5', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1835, '4]', '6', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1835, '[1]', '1', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1835, '[5', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1835, '4', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1835, '-1', '', 25, 12);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1835, '7', '', 25, 13);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1835, '8]', '23', 25, 14);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断两个字符串是否是字母异位词。
输入: \"anagram\", \"nagaram\" 输出: true
输入: \"rat\", \"car\" 输出: false [题336]', '计数比较', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1836, 'anagram nagaram', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1836, 'rat car', 'false', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1836, 'a', 'true', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，求两个链表的交点。
输入: A: 1->3->5, B: 2->4->3->5 输出: 5 [题337]', '双指针遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1837, '1', '3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1837, '1', '2 3', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个数是否是水仙花数。
输入: 153 输出: true (1^3+5^3+3^3=153)
输入: 123 输出: false [题338]', '立方和计算', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1838, '153', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1838, '123', 'false', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1838, '407', 'true', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，返回数组中第K大的元素。
输入: [3,2,1,5,6,4], k=2 输出: 5 [题339]', '快速选择或堆', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1839, '[3', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1839, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1839, '1', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1839, '5', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1839, '6', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1839, '4] 2', '5', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1839, '[3', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1839, '1', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1839, '2] 1', '3', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，验证二叉搜索树。
输入: [2,1,3] 输出: true
输入: [5,1,4,null,null,3,6] 输出: false [题340]', '递归验证范围', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1840, '2', '1', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1840, '5', '1', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，合并两个有序链表。
输入: 1->2->4, 1->3->4 输出: 1->1->2->3->4->4 [题341]', '双指针归并', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1841, '1', '2', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个二叉树是否平衡。
输入: [3,9,20,null,null,15,7] 输出: true [题342]', '递归计算深度', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1842, '3', '9', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，实现pow(x, n)，计算x的n次幂。
输入: 2, 10 输出: 1024
输入: 2, -2 输出: 0.5 [题343]', '快速幂', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1843, '2 10', '1024', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1843, '2 -2', '0.5', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1843, '3 3', '27', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，遍历二叉树每行。
输入: [3,9,20,null,null,15,7] 输出: [[3],[9,20],[15,7]] [题344]', '层序遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1844, '3', '9', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1844, '[9', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1844, '20]', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1844, '[15', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1844, '7]]', '', 25, 4);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，从数组中找出和为目标值的两个数的下标。
输入: [2,7,11,15], target=9 输出: [0,1] [题345]', '哈希表', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1845, '[2', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1845, '7', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1845, '11', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1845, '15] 9', '[0', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1845, '1]', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1845, '[3', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1845, '2', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1845, '4] 6', '[1', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1845, '2]', '', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，生成杨辉三角。
输入: 5 输出: [[1],[1,1],[1,2,1],[1,3,3,1],[1,4,6,4,1]] [题346]', '递推生成', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1846, '5', '[[1]', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1846, '[1', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1846, '1]', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1846, '[1', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1846, '2', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1846, '1]', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1846, '[1', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1846, '3', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1846, '3', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1846, '1]', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1846, '[1', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1846, '4', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1846, '6', '', 25, 12);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1846, '4', '', 25, 13);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1846, '1]]', '', 25, 14);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1846, '3', '[[1]', 25, 15);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1846, '[1', '', 25, 16);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1846, '1]', '', 25, 17);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1846, '[1', '', 25, 18);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1846, '2', '', 25, 19);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1846, '1]]', '', 25, 20);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，螺旋矩阵。
输入: 3 输出: [[1,2,3],[8,9,4],[7,6,5]] [题347]', '模拟遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1847, '3', '[[1', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1847, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1847, '3]', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1847, '[8', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1847, '9', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1847, '4]', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1847, '[7', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1847, '6', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1847, '5]]', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1847, '2', '[[1', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1847, '2]', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1847, '[4', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1847, '3]]', '', 25, 12);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，搜索旋转排序数组。
输入: [4,5,6,7,0,1,2], target=0 输出: 4 [题348]', '二分查找', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1848, '[4', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1848, '5', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1848, '6', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1848, '7', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1848, '0', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1848, '1', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1848, '2] 0', '4', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1848, '[4', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1848, '5', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1848, '6', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1848, '7', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1848, '0', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1848, '1', '', 25, 12);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1848, '2] 5', '1', 25, 13);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，找到数组中的多数元素。
输入: [3,2,3] 输出: 3
输入: [2,2,1,1,1,2,2] 输出: 2 [题349]', '投票算法', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1849, '[3', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1849, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1849, '3]', '3', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1849, '[2', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1849, '2', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1849, '1', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1849, '1', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1849, '1', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1849, '2', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1849, '2]', '2', 25, 9);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，求岛屿数量。
输入: [[\'1\',\'1\',\'0\',\'0\',\'0\'],[\'1\',\'1\',\'0\',\'0\',\'0\']] 输出: 1 [题350]', 'DFS或BFS', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1850, 'grid', '1', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1850, 'grid', '2', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，括号生成。
输入: 3 输出: [\'((()))\',\'(()())\',\'(())()\',\'()(())\',\'()()()\'] [题351]', '回溯', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1851, '3', '5', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1851, '2', '2', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，全排列。
输入: [1,2,3] 输出: [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]] [题352]', '回溯', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1852, '[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1852, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1852, '3]', '6', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1852, '[1]', '1', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，组合总和。
输入: candidates=[2,3,6,7], target=7 输出: [[2,2,3],[7]] [题353]', '回溯+剪枝', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1853, '2', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1853, '3', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1853, '6', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1853, '7 7', '[[2', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1853, '2', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1853, '3]', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1853, '[7]]', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1853, '1', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1853, '2 3', '[[1', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1853, '1', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1853, '1]', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1853, '[1', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1853, '2]]', '', 25, 12);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，子集。
输入: [1,2,3] 输出: [[],[1],[2],[3],[1,2],[1,3],[2,3],[1,2,3]] [题354]', '回溯', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1854, '[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1854, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1854, '3]', '8', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1854, '[1]', '2', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，括号有效。
输入: \"()[]{}\" 输出: true
输入: \"([)]\" 输出: false [题355]', '栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1855, '()[]{}', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1855, '([)]', 'false', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1855, '(', 'false', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串解码。
输入: \"3[a]2[bc]\" 输出: \"aaabcbc\"
输入: \"2[abc]3[cd]ef\" 输出: \"abcabccdcdcdef\" [题356]', '栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1856, '3[a]2[bc]', 'aaabcbc', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1856, '2[abc]3[cd]ef', 'abcabccdcdcdef', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，岛屿最大面积。
输入: [[0,0,1,0,0],[0,0,0,0,0]] 输出: 1 [题357]', 'DFS', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1857, 'grid', '1', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1857, 'grid', '4', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，课程表。
输入: numCourses=4, prerequisites=[[1,0],[2,0],[3,1],[3,2]] 输出: true [题358]', '拓扑排序', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1858, '4 [[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1858, '0]', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1858, '[2', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1858, '0]', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1858, '[3', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1858, '1]', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1858, '[3', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1858, '2]]', 'true', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1858, '2 [[1', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1858, '0]]', 'true', 25, 9);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，合并区间。
输入: [[1,3],[2,6],[8,10],[15,18]] 输出: [[1,6],[8,10],[15,18]] [题359]', '排序后合并', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1859, '[[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1859, '3]', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1859, '[2', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1859, '6]', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1859, '[8', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1859, '10]', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1859, '[15', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1859, '18]]', '[[1', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1859, '6]', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1859, '[8', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1859, '10]', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1859, '[15', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1859, '18]]', '', 25, 12);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，最长递增子序列长度。
输入: [10,9,2,5,3,7,101,18] 输出: 4 [题360]', 'DP或二分', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1860, '[10', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1860, '9', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1860, '2', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1860, '5', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1860, '3', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1860, '7', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1860, '101', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1860, '18]', '4', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1860, '[1]', '1', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，最长公共子序列。
输入: \"abcde\", \"ace\" 输出: 3 [题361]', 'DP', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1861, 'abcde ace', '3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1861, 'abc abc', '3', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，最长回文子串。
输入: \"babad\" 输出: \"bab\"
输入: \"cbbd\" 输出: \"bb\" [题362]', 'Manacher或DP', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1862, 'babad', 'bab', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1862, 'cbbd', 'bb', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，编辑距离。
输入: \"horse\", \"ros\" 输出: 3 [题363]', 'DP', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1863, 'horse ros', '3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1863, 'ros ros', '0', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，买卖股票最佳时机。
输入: [7,1,5,3,6,4] 输出: 5 [题364]', '一次遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1864, '[7', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1864, '1', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1864, '5', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1864, '3', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1864, '6', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1864, '4]', '5', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1864, '[7', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1864, '6', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1864, '4', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1864, '3', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1864, '1]', '0', 25, 10);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，打家劫舍。
输入: [1,2,3,1] 输出: 4
输入: [2,7,9,3,1] 输出: 12 [题365]', 'DP', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1865, '[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1865, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1865, '3', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1865, '1]', '4', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1865, '[2', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1865, '7', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1865, '9', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1865, '3', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1865, '1]', '12', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，跳台阶。
输入: 10 输出: 89 [题366]', '斐波那契', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1866, '10', '89', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1866, '5', '8', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1866, '0', '1', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，三数之和。
输入: [-1,0,1,2,-1,-4] 输出: [[-1,-1,2],[-1,0,1]] [题367]', '双指针', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1867, '[-1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1867, '0', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1867, '1', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1867, '2', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1867, '-1', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1867, '-4]', '[[-1', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1867, '-1', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1867, '2]', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1867, '[-1', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1867, '0', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1867, '1]]', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1867, '[]', '[]', 25, 11);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，电话号码的字母组合。
输入: \"23\" 输出: [\"ad\",\"ae\",\"af\",\"bd\",\"be\",\"bf\",\"cd\",\"ce\",\"cf\"] [题368]', '回溯', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1868, '23', '9', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1868, '2', '3', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，二叉树的最大深度。
输入: [3,9,20,null,null,15,7] 输出: 3 [题369]', '递归', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1869, '3', '9', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1869, '1', '1', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，对称二叉树。
输入: [1,2,2,3,4,4,3] 输出: true [题370]', '递归比较', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1870, '1', '2', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，二叉树层序遍历。
输入: [3,9,20,null,null,15,7] 输出: [[3],[9,20],[15,7]] [题371]', '队列', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1871, '3', '9', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1871, '[9', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1871, '20]', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1871, '[15', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1871, '7]]', '', 25, 4);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，填充每个节点的下一个右侧节点指针。
输入: [1,2,3,4,5,6,7] 输出: [[1,#],[2,3,#],[4,5,6,7,#]] [题372]', '层序', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1872, '1', '2', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，二叉树前序遍历。
输入: [1,null,2,3] 输出: [1,2,3] [题373]', '递归或栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1873, '1', 'null', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1873, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1873, '3]', '', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，二叉树中序遍历。
输入: [1,null,2,3] 输出: [1,3,2] [题374]', '递归或栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1874, '1', 'null', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1874, '3', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1874, '2]', '', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，二叉树后序遍历。
输入: [1,2,3] 输出: [3,2,1] [题375]', '递归或栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1875, '1', '2', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1875, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1875, '1]', '', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，路径总和。
输入: [5,4,8,11,null,13,4,7,2,null,null,1] 输出: true [题376]', '递归', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1876, 'tree 22', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1876, 'tree 12', 'false', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，从前序和中序构建二叉树。
输入: preorder=[3,9,20,15,7], inorder=[9,3,15,20,7] 输出: [3,9,20,null,null,15,7] [题377]', '递归', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1877, 'preorder inorder', 'tree', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，搜索二维矩阵。
输入: [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target=3 输出: true [题378]', '二分或Z字搜索', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1878, 'matrix 3', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1878, 'matrix 13', 'false', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，搜索旋转数组最小值。
输入: [3,4,5,1,2] 输出: 1 [题379]', '二分', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1879, '[3', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1879, '4', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1879, '5', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1879, '1', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1879, '2]', '1', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1879, '[1]', '1', 25, 5);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，查找元素范围。
输入: [5,7,7,8,8,10], target=8 输出: [3,4] [题380]', '二分', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1880, '[5', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1880, '7', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1880, '7', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1880, '8', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1880, '8', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1880, '10] 8', '[3', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1880, '4]', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1880, '[1', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1880, '2', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1880, '3] 4', '[-1', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1880, '-1]', '', 25, 10);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串转浮点数。
输入: \"123.45\" 输出: 123.45
输入: \"-6.78\" 输出: -6.78 [题381]', '处理整数和小数部分', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1881, '123.45', '123.45', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1881, '-6.78', '-6.78', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，扁平化嵌套列表。
输入: [[1,2],3,[4,5]] 输出: [1,2,3,4,5] [题382]', '递归或栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1882, '[[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1882, '2]', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1882, '3', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1882, '[4', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1882, '5]]', '[1', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1882, '2', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1882, '3', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1882, '4', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1882, '5]', '', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，扁平化二叉树为链表。
输入: [1,2,null,3,null,4,null,5] 输出: [1,null,2,null,3,null,4,null,5,null] [题383]', '前序遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1883, 'tree', 'linked', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，验证平衡括号。
输入: \'{[()]}\' 输出: true
输入: \'{[(])}\' 输出: false [题384]', '栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1884, '{[()]}', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1884, '{[(])}', 'false', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，无重复字符最长子串。
输入: \"abcabcbb\" 输出: 3
输入: \"bbbbb\" 输出: 1 [题385]', '滑动窗口', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1885, 'abcabcbb', '3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1885, 'bbbbb', '1', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串所有排列。
输入: \"abc\" 输出: [\"abc\",\"acb\",\"bac\",\"bca\",\"cab\",\"cba\"] [题386]', '回溯', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1886, 'abc', '6', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1886, 'a', '1', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，第N个丑数。
输入: 10 输出: 12 [题387]', '三指针', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1887, '10', '12', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1887, '1', '1', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，两个链表的下一个更大节点。
输入: 2->1->5 输出: 5->5->0 [题388]', '单调栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1888, '2', '1', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，移除重复元素使得出现一次。
输入: [1,2,2,3,3,3] 输出: 6 [题389]', '异或运算', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1889, '[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1889, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1889, '2', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1889, '3', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1889, '3', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1889, '3]', '6', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1889, '[1', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1889, '1', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1889, '1]', '1', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串最后一个单词长度。
输入: \"hello world\" 输出: 5 [题390]', '反向遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1890, 'hello world', '5', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1890, 'abc', '3', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，验证回文串。
输入: \"A man, a plan, a canal: Panama\" 输出: true [题391]', '双指针', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1891, 'A man a plan a canal Panama', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1891, 'race a car', 'false', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，模拟浏览器前进后退。
输入: BrowserHistory(\'leetcode.com\') [题392]', '双栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1892, 'leetcode.com forward', 'com', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1892, 'back', 'leetcode.com', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，最大栈。
输入: MaxStack() 输出: 支持push、pop、max操作 [题393]', '辅助栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1893, 'push', 'pop', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，丑数。
输入: 6 输出: true
输入: 8 输出: true
输入: 14 输出: false [题394]', '分解质因数', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1894, '6', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1894, '8', 'true', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1894, '14', 'false', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，完全平方数。
输入: 12 输出: 3 (因为3^2=9是最接近的完全平方数) [题395]', '动态规划或二分', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1895, '12', '3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1895, '16', '0', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1895, '1', '0', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串循环移位。
输入: \"abcdef\" 左移2位 输出: \"cdefab\" [题396]', '拼接', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1896, 'abcdef 2', 'cdefab', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，乱序单词分组。
输入: [\"eat\",\"tea\",\"tan\",\"ate\",\"nat\",\"bat\"] 输出: [[\"eat\",\"tea\",\"ate\"],[\"tan\",\"nat\"],[\"bat\"]] [题397]', '排序后哈希', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1897, 'eat tea tan ate nat bat', '3组', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串压缩。
输入: \"aabcccccaaa\" 输出: \"a2b1c5a3\" [题398]', '计数压缩', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1898, 'aabcccccaaa', 'a2b1c5a3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1898, 'abcd', 'abcd', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，旋转图像90度。
输入: [[1,2,3],[4,5,6],[7,8,9]] 输出: [[7,4,1],[8,5,2],[9,6,3]] [题399]', '先转置再翻转', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1899, 'matrix', 'rotated', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，矩阵置零。
输入: [[1,1,1],[1,0,1],[1,1,1]] 输出: [[1,0,1],[0,0,0],[1,0,1]] [题400]', '标记行列', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1900, 'matrix', 'zeroed', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，加一。
输入: [1,2,3] 输出: [1,2,4]
输入: [9,9,9] 输出: [1,0,0,0] [题401]', '进位处理', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1901, '1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1901, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1901, '3', '1', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1901, '2', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1901, '4', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1901, '9', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1901, '9', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1901, '9', '1', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1901, '0', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1901, '0', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1901, '0', '', 25, 10);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串相乘。
输入: \"123\" × \"456\" 输出: \"56088\" [题402]', '列竖式', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1902, '123 456', '56088', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1902, '0 0', '0', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，有效的数独。
输入: 9x9数独数组 输出: true/false [题403]', '行列宫遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1903, 'board', 'true/false', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，颠倒二进制位。
输入: 43261596 (二进制 00000010100101000001111010011100) 输出: 964176192 [题404]', '逐位反转', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1904, '43261596', '964176192', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1904, '1', '2147483648', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，位1的个数。
输入: 11 (二进制 00000000000000000000000000001011) 输出: 3 [题405]', '位运算', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1905, '11', '3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1905, '128', '1', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，2的幂次方。
输入: 1 输出: true
输入: 16 输出: true
输入: 218 输出: false [题406]', 'n&(n-1)==0', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1906, '1', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1906, '16', 'true', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1906, '218', 'false', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，缺失的第一个正数。
输入: [3,-1,4,2] 输出: 1
输入: [1,2,0] 输出: 3 [题407]', '原地哈希', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1907, '3 -1 4 2', '1', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1907, '1 2 0', '3', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字母异位词分组。
输入: [\"eat\",\"tea\",\"tan\"] 输出: [[\"eat\",\"tea\",\"ate\"],[\"tan\"]] [题408]', '排序哈希', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1908, 'eat tea tan', '2组', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，合并两个有序数组。
输入: nums1=[1,2,3], m=3, nums2=[2,5,6], n=3 输出: [1,2,2,3,5,6] [题409]', '从后往前', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1909, 'nums1 nums2', 'merged', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，验证二叉搜索树。
输入: [5,1,4,null,null,3,6] 输出: false [题410]', '递归', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1910, '5', '1', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，二叉搜索树最近公共祖先。
输入: [6,2,8,0,4,7,9,null,null,3,5], p=2, q=8 输出: 6 [题411]', 'BST性质', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1911, 'tree 2 8', '6', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1911, 'tree 2 4', '2', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，二叉树路径总和II。
输入: [1,2] 输出: 所有从根到叶子路径和为sum的路径 [题412]', '回溯', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1912, '1', '2', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1912, '2]]', '', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，构建乘积数组。
输入: [1,2,3,4,5] 输出: [120,60,40,30,24] [题413]', '左右遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1913, '[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1913, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1913, '3', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1913, '4', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1913, '5]', '[120', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1913, '60', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1913, '40', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1913, '30', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1913, '24]', '', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，复制带随机指针的链表。
输入: 链表，每个节点有next和random指针 输出: 深拷贝 [题414]', '哈希表', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1914, 'linked', 'cloned', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，变位词组。
输入: \"eat\",\"tea\",\"tan\",\"ate\",\"nat\",\"bat\" 输出: [[\"eat\",\"tea\",\"ate\"],[\"tan\",\"nat\"],[\"bat\"]] [题415]', '排序分组', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1915, '6words', '3组', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，前K个高频元素。
输入: [1,1,1,2,2,3], k=2 输出: [1,2] [题416]', '堆', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1916, '[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1916, '1', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1916, '1', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1916, '2', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1916, '2', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1916, '3] 2', '[1', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1916, '2]', '', 25, 6);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，合并区间。
输入: [[1,4],[0,4]] 输出: [[0,4]] [题417]', '排序合并', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1917, 'intervals', 'merged', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串解码。
输入: \"3[a2[c]]\" 输出: \"accaccacc\" [题418]', '栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1918, '3[a2[c]]', 'accaccacc', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，简化路径。
输入: \"/home//foo/\" 输出: \"/home/foo\" [题419]', '栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1919, '/home//foo/', '/home/foo', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，逆波兰表达式求值。
输入: [\"2\",\"1\",\"+\",\"3\",\"*\"] 输出: 9 [题420]', '栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1920, '2 1 + 3 *', '9', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，跳跃游戏。
输入: [2,3,1,1,4] 输出: true [题421]', '贪心', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1921, '[2', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1921, '3', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1921, '1', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1921, '1', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1921, '4]', 'true', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1921, '[3', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1921, '2', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1921, '1', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1921, '0]', 'false', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，加油站。
输入: gas=[1,2,3,4,5], cost=[2,3,4,5,1] 输出: 3 [题422]', '贪心', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1922, 'gas cost', '3', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，分糖果。
输入: ratings=[1,0,2] 输出: 5 [题423]', '贪心', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1923, 'ratings', '5', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，赎金信。
输入: ransom=\"aa\", magazine=\"aab\" 输出: true [题424]', '哈希计数', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1924, 'aa aab', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1924, 'ab aac', 'false', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个字符串是否是回文。回文是指正读和反读都一样的字符串。
输入: \"aba\" 输出: true
输入: \"abca\" 输出: false [题425]', '使用双指针或反转比较', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1925, 'aba', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1925, 'abca', 'false', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1925, 'a', 'true', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1925, 'abc', 'false', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，计算字符串中单词的数量。单词是用空格分隔的连续字符序列。
输入: \"hello world\" 输出: 2
输入: \"abc\" 输出: 1 [题426]', '按空格分割', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1926, 'hello world', '2', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1926, 'abc', '1', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1926, 'a b c', '3', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1926, '', '0', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，移除数组中所有等于val的元素，返回新数组长度。
输入: [3,2,3,3], val=3 输出: 2 [题427]', '双指针法', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1927, '[3', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1927, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1927, '3', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1927, '3] 3', '2', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1927, '[1', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1927, '2', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1927, '3', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1927, '4] 5', '4', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1927, '[1', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1927, '1', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1927, '1] 1', '0', 25, 10);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，合并两个有序数组为一个有序数组。
输入: [1,3,5], [2,4,6] 输出: [1,2,3,4,5,6] [题428]', '双指针合并', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1928, '[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1928, '3', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1928, '5] [2', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1928, '4', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1928, '6]', '[1', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1928, '2', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1928, '3', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1928, '4', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1928, '5', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1928, '6]', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1928, '[1', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1928, '2', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1928, '3] [4', '', 25, 12);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1928, '5', '', 25, 13);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1928, '6]', '[1', 25, 14);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1928, '2', '', 25, 15);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1928, '3', '', 25, 16);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1928, '4', '', 25, 17);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1928, '5', '', 25, 18);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1928, '6]', '', 25, 19);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个数是否是质数。质数是大于1的自然数，除了1和它本身外不能被其他自然数整除。
输入: 2 输出: true
输入: 4 输出: false [题429]', '试除法', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1929, '2', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1929, '3', 'true', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1929, '4', 'false', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1929, '17', 'true', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1929, '1', 'false', 25, 4);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，返回斐波那契数列第n项。F(0)=0, F(1)=1, F(n)=F(n-1)+F(n-2)。
输入: 5 输出: 5
输入: 10 输出: 55 [题430]', '迭代或矩阵', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1930, '5', '5', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1930, '10', '55', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1930, '0', '0', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1930, '1', '1', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，计算一个整数的阶乘。n! = n × (n-1) × ... × 2 × 1
输入: 5 输出: 120
输入: 0 输出: 1 [题431]', '递归或迭代', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1931, '5', '120', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1931, '0', '1', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1931, '10', '3628800', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，求两个数的最大公约数（欧几里得算法）。
输入: 12, 8 输出: 4
输入: 24, 18 输出: 6 [题432]', '辗转相除', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1932, '12 8', '4', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1932, '24 18', '6', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1932, '100 25', '25', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，求两个数的最小公倍数。
输入: 4, 6 输出: 12
输入: 5, 10 输出: 10 [题433]', '公式LCM=a*b/GCD', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1933, '4 6', '12', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1933, '5 10', '10', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1933, '7 3', '21', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，将字符串中的空格替换为%20。
输入: \"hello world\" 输出: \"hello%20world\"
输入: \" \" 输出: \"%20\" [题434]', '从后往前复制', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1934, 'hello world', 'hello%20world', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1934, '  ', '%20', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1934, 'abc', 'abc', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个链表是否有环。
输入: 3->2->1->2 返回true
输入: 1->2 返回false [题435]', '快慢指针', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1935, '3', '2', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1935, '1', '2', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，返回链表的倒数第k个节点。
输入: 1->2->3->4->5, k=2 输出: 4
输入: 1->2->3, k=3 输出: 1 [题436]', '快慢指针', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1936, '1', '2', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1936, '1', '2', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个数是否是2的幂。
输入: 8 输出: true
输入: 6 输出: false [题437]', '二进制或除二', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1937, '8', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1937, '6', 'false', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1937, '1', 'true', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1937, '1024', 'true', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，返回字符串中第一个不重复的字符。
输入: \"abracadabra\" 输出: \'c\'
输入: \"aabbcc\" 输出: null [题438]', '哈希表计数', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1938, 'abracadabra', 'c', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1938, 'aabbcc', 'null', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1938, 'abc', 'a', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，将数字转换为字符串。
输入: 123 输出: \"123\"
输入: -456 输出: \"-456\" [题439]', '考虑负数', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1939, '123', '123', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1939, '-456', '-456', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1939, '0', '0', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，将字符串转换为整数。
输入: \"123\" 输出: 123
输入: \"-456\" 输出: -456 [题440]', '考虑空字符和正负号', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1940, '123', '123', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1940, '-456', '-456', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1940, '  -42', '-42', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，计算数组中连续子数组的最大和。
输入: [-2,1,-3,4,-1,2,1,-5,4] 输出: 6
输入: [1] 输出: 1 [题441]', 'Kadane算法', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1941, '[-2', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1941, '1', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1941, '-3', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1941, '4', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1941, '-1', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1941, '2', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1941, '1', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1941, '-5', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1941, '4]', '6', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1941, '[1]', '1', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1941, '[5', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1941, '4', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1941, '-1', '', 25, 12);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1941, '7', '', 25, 13);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1941, '8]', '23', 25, 14);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断两个字符串是否是字母异位词。
输入: \"anagram\", \"nagaram\" 输出: true
输入: \"rat\", \"car\" 输出: false [题442]', '计数比较', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1942, 'anagram nagaram', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1942, 'rat car', 'false', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1942, 'a', 'true', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，求两个链表的交点。
输入: A: 1->3->5, B: 2->4->3->5 输出: 5 [题443]', '双指针遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1943, '1', '3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1943, '1', '2 3', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个数是否是水仙花数。
输入: 153 输出: true (1^3+5^3+3^3=153)
输入: 123 输出: false [题444]', '立方和计算', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1944, '153', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1944, '123', 'false', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1944, '407', 'true', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，返回数组中第K大的元素。
输入: [3,2,1,5,6,4], k=2 输出: 5 [题445]', '快速选择或堆', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1945, '[3', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1945, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1945, '1', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1945, '5', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1945, '6', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1945, '4] 2', '5', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1945, '[3', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1945, '1', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1945, '2] 1', '3', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，验证二叉搜索树。
输入: [2,1,3] 输出: true
输入: [5,1,4,null,null,3,6] 输出: false [题446]', '递归验证范围', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1946, '2', '1', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1946, '5', '1', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，合并两个有序链表。
输入: 1->2->4, 1->3->4 输出: 1->1->2->3->4->4 [题447]', '双指针归并', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1947, '1', '2', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，判断一个二叉树是否平衡。
输入: [3,9,20,null,null,15,7] 输出: true [题448]', '递归计算深度', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1948, '3', '9', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，实现pow(x, n)，计算x的n次幂。
输入: 2, 10 输出: 1024
输入: 2, -2 输出: 0.5 [题449]', '快速幂', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1949, '2 10', '1024', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1949, '2 -2', '0.5', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1949, '3 3', '27', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，遍历二叉树每行。
输入: [3,9,20,null,null,15,7] 输出: [[3],[9,20],[15,7]] [题450]', '层序遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1950, '3', '9', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1950, '[9', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1950, '20]', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1950, '[15', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1950, '7]]', '', 25, 4);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，从数组中找出和为目标值的两个数的下标。
输入: [2,7,11,15], target=9 输出: [0,1] [题451]', '哈希表', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1951, '[2', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1951, '7', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1951, '11', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1951, '15] 9', '[0', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1951, '1]', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1951, '[3', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1951, '2', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1951, '4] 6', '[1', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1951, '2]', '', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，生成杨辉三角。
输入: 5 输出: [[1],[1,1],[1,2,1],[1,3,3,1],[1,4,6,4,1]] [题452]', '递推生成', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1952, '5', '[[1]', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1952, '[1', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1952, '1]', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1952, '[1', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1952, '2', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1952, '1]', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1952, '[1', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1952, '3', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1952, '3', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1952, '1]', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1952, '[1', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1952, '4', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1952, '6', '', 25, 12);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1952, '4', '', 25, 13);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1952, '1]]', '', 25, 14);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1952, '3', '[[1]', 25, 15);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1952, '[1', '', 25, 16);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1952, '1]', '', 25, 17);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1952, '[1', '', 25, 18);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1952, '2', '', 25, 19);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1952, '1]]', '', 25, 20);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，螺旋矩阵。
输入: 3 输出: [[1,2,3],[8,9,4],[7,6,5]] [题453]', '模拟遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1953, '3', '[[1', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1953, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1953, '3]', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1953, '[8', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1953, '9', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1953, '4]', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1953, '[7', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1953, '6', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1953, '5]]', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1953, '2', '[[1', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1953, '2]', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1953, '[4', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1953, '3]]', '', 25, 12);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，搜索旋转排序数组。
输入: [4,5,6,7,0,1,2], target=0 输出: 4 [题454]', '二分查找', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1954, '[4', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1954, '5', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1954, '6', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1954, '7', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1954, '0', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1954, '1', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1954, '2] 0', '4', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1954, '[4', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1954, '5', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1954, '6', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1954, '7', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1954, '0', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1954, '1', '', 25, 12);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1954, '2] 5', '1', 25, 13);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，找到数组中的多数元素。
输入: [3,2,3] 输出: 3
输入: [2,2,1,1,1,2,2] 输出: 2 [题455]', '投票算法', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1955, '[3', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1955, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1955, '3]', '3', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1955, '[2', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1955, '2', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1955, '1', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1955, '1', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1955, '1', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1955, '2', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1955, '2]', '2', 25, 9);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，求岛屿数量。
输入: [[\'1\',\'1\',\'0\',\'0\',\'0\'],[\'1\',\'1\',\'0\',\'0\',\'0\']] 输出: 1 [题456]', 'DFS或BFS', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1956, 'grid', '1', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1956, 'grid', '2', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，括号生成。
输入: 3 输出: [\'((()))\',\'(()())\',\'(())()\',\'()(())\',\'()()()\'] [题457]', '回溯', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1957, '3', '5', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1957, '2', '2', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，全排列。
输入: [1,2,3] 输出: [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]] [题458]', '回溯', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1958, '[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1958, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1958, '3]', '6', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1958, '[1]', '1', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，组合总和。
输入: candidates=[2,3,6,7], target=7 输出: [[2,2,3],[7]] [题459]', '回溯+剪枝', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1959, '2', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1959, '3', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1959, '6', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1959, '7 7', '[[2', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1959, '2', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1959, '3]', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1959, '[7]]', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1959, '1', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1959, '2 3', '[[1', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1959, '1', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1959, '1]', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1959, '[1', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1959, '2]]', '', 25, 12);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，子集。
输入: [1,2,3] 输出: [[],[1],[2],[3],[1,2],[1,3],[2,3],[1,2,3]] [题460]', '回溯', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1960, '[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1960, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1960, '3]', '8', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1960, '[1]', '2', 25, 3);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，括号有效。
输入: \"()[]{}\" 输出: true
输入: \"([)]\" 输出: false [题461]', '栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1961, '()[]{}', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1961, '([)]', 'false', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1961, '(', 'false', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串解码。
输入: \"3[a]2[bc]\" 输出: \"aaabcbc\"
输入: \"2[abc]3[cd]ef\" 输出: \"abcabccdcdcdef\" [题462]', '栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1962, '3[a]2[bc]', 'aaabcbc', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1962, '2[abc]3[cd]ef', 'abcabccdcdcdef', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，岛屿最大面积。
输入: [[0,0,1,0,0],[0,0,0,0,0]] 输出: 1 [题463]', 'DFS', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1963, 'grid', '1', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1963, 'grid', '4', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，课程表。
输入: numCourses=4, prerequisites=[[1,0],[2,0],[3,1],[3,2]] 输出: true [题464]', '拓扑排序', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1964, '4 [[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1964, '0]', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1964, '[2', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1964, '0]', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1964, '[3', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1964, '1]', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1964, '[3', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1964, '2]]', 'true', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1964, '2 [[1', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1964, '0]]', 'true', 25, 9);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，合并区间。
输入: [[1,3],[2,6],[8,10],[15,18]] 输出: [[1,6],[8,10],[15,18]] [题465]', '排序后合并', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1965, '[[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1965, '3]', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1965, '[2', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1965, '6]', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1965, '[8', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1965, '10]', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1965, '[15', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1965, '18]]', '[[1', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1965, '6]', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1965, '[8', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1965, '10]', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1965, '[15', '', 25, 11);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1965, '18]]', '', 25, 12);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，最长递增子序列长度。
输入: [10,9,2,5,3,7,101,18] 输出: 4 [题466]', 'DP或二分', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1966, '[10', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1966, '9', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1966, '2', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1966, '5', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1966, '3', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1966, '7', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1966, '101', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1966, '18]', '4', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1966, '[1]', '1', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，最长公共子序列。
输入: \"abcde\", \"ace\" 输出: 3 [题467]', 'DP', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1967, 'abcde ace', '3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1967, 'abc abc', '3', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，最长回文子串。
输入: \"babad\" 输出: \"bab\"
输入: \"cbbd\" 输出: \"bb\" [题468]', 'Manacher或DP', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1968, 'babad', 'bab', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1968, 'cbbd', 'bb', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，编辑距离。
输入: \"horse\", \"ros\" 输出: 3 [题469]', 'DP', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1969, 'horse ros', '3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1969, 'ros ros', '0', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，买卖股票最佳时机。
输入: [7,1,5,3,6,4] 输出: 5 [题470]', '一次遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1970, '[7', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1970, '1', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1970, '5', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1970, '3', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1970, '6', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1970, '4]', '5', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1970, '[7', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1970, '6', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1970, '4', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1970, '3', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1970, '1]', '0', 25, 10);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，打家劫舍。
输入: [1,2,3,1] 输出: 4
输入: [2,7,9,3,1] 输出: 12 [题471]', 'DP', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1971, '[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1971, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1971, '3', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1971, '1]', '4', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1971, '[2', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1971, '7', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1971, '9', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1971, '3', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1971, '1]', '12', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，跳台阶。
输入: 10 输出: 89 [题472]', '斐波那契', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1972, '10', '89', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1972, '5', '8', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1972, '0', '1', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，三数之和。
输入: [-1,0,1,2,-1,-4] 输出: [[-1,-1,2],[-1,0,1]] [题473]', '双指针', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1973, '[-1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1973, '0', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1973, '1', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1973, '2', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1973, '-1', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1973, '-4]', '[[-1', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1973, '-1', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1973, '2]', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1973, '[-1', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1973, '0', '', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1973, '1]]', '', 25, 10);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1973, '[]', '[]', 25, 11);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，电话号码的字母组合。
输入: \"23\" 输出: [\"ad\",\"ae\",\"af\",\"bd\",\"be\",\"bf\",\"cd\",\"ce\",\"cf\"] [题474]', '回溯', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1974, '23', '9', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1974, '2', '3', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，二叉树的最大深度。
输入: [3,9,20,null,null,15,7] 输出: 3 [题475]', '递归', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1975, '3', '9', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1975, '1', '1', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，对称二叉树。
输入: [1,2,2,3,4,4,3] 输出: true [题476]', '递归比较', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1976, '1', '2', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，二叉树层序遍历。
输入: [3,9,20,null,null,15,7] 输出: [[3],[9,20],[15,7]] [题477]', '队列', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1977, '3', '9', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1977, '[9', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1977, '20]', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1977, '[15', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1977, '7]]', '', 25, 4);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，填充每个节点的下一个右侧节点指针。
输入: [1,2,3,4,5,6,7] 输出: [[1,#],[2,3,#],[4,5,6,7,#]] [题478]', '层序', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1978, '1', '2', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，二叉树前序遍历。
输入: [1,null,2,3] 输出: [1,2,3] [题479]', '递归或栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1979, '1', 'null', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1979, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1979, '3]', '', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，二叉树中序遍历。
输入: [1,null,2,3] 输出: [1,3,2] [题480]', '递归或栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1980, '1', 'null', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1980, '3', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1980, '2]', '', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，二叉树后序遍历。
输入: [1,2,3] 输出: [3,2,1] [题481]', '递归或栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1981, '1', '2', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1981, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1981, '1]', '', 25, 2);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，路径总和。
输入: [5,4,8,11,null,13,4,7,2,null,null,1] 输出: true [题482]', '递归', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1982, 'tree 22', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1982, 'tree 12', 'false', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，从前序和中序构建二叉树。
输入: preorder=[3,9,20,15,7], inorder=[9,3,15,20,7] 输出: [3,9,20,null,null,15,7] [题483]', '递归', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1983, 'preorder inorder', 'tree', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，搜索二维矩阵。
输入: [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target=3 输出: true [题484]', '二分或Z字搜索', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1984, 'matrix 3', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1984, 'matrix 13', 'false', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，搜索旋转数组最小值。
输入: [3,4,5,1,2] 输出: 1 [题485]', '二分', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1985, '[3', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1985, '4', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1985, '5', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1985, '1', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1985, '2]', '1', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1985, '[1]', '1', 25, 5);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，查找元素范围。
输入: [5,7,7,8,8,10], target=8 输出: [3,4] [题486]', '二分', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1986, '[5', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1986, '7', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1986, '7', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1986, '8', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1986, '8', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1986, '10] 8', '[3', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1986, '4]', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1986, '[1', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1986, '2', '', 25, 8);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1986, '3] 4', '[-1', 25, 9);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1986, '-1]', '', 25, 10);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串转浮点数。
输入: \"123.45\" 输出: 123.45
输入: \"-6.78\" 输出: -6.78 [题487]', '处理整数和小数部分', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1987, '123.45', '123.45', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1987, '-6.78', '-6.78', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，扁平化嵌套列表。
输入: [[1,2],3,[4,5]] 输出: [1,2,3,4,5] [题488]', '递归或栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1988, '[[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1988, '2]', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1988, '3', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1988, '[4', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1988, '5]]', '[1', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1988, '2', '', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1988, '3', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1988, '4', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1988, '5]', '', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，扁平化二叉树为链表。
输入: [1,2,null,3,null,4,null,5] 输出: [1,null,2,null,3,null,4,null,5,null] [题489]', '前序遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1989, 'tree', 'linked', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，验证平衡括号。
输入: \'{[()]}\' 输出: true
输入: \'{[(])}\' 输出: false [题490]', '栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1990, '{[()]}', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1990, '{[(])}', 'false', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，无重复字符最长子串。
输入: \"abcabcbb\" 输出: 3
输入: \"bbbbb\" 输出: 1 [题491]', '滑动窗口', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1991, 'abcabcbb', '3', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1991, 'bbbbb', '1', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串所有排列。
输入: \"abc\" 输出: [\"abc\",\"acb\",\"bac\",\"bca\",\"cab\",\"cba\"] [题492]', '回溯', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1992, 'abc', '6', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1992, 'a', '1', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，第N个丑数。
输入: 10 输出: 12 [题493]', '三指针', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1993, '10', '12', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1993, '1', '1', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，两个链表的下一个更大节点。
输入: 2->1->5 输出: 5->5->0 [题494]', '单调栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1994, '2', '1', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，移除重复元素使得出现一次。
输入: [1,2,2,3,3,3] 输出: 6 [题495]', '异或运算', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1995, '[1', '', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1995, '2', '', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1995, '2', '', 25, 2);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1995, '3', '', 25, 3);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1995, '3', '', 25, 4);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1995, '3]', '6', 25, 5);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1995, '[1', '', 25, 6);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1995, '1', '', 25, 7);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1995, '1]', '1', 25, 8);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，字符串最后一个单词长度。
输入: \"hello world\" 输出: 5 [题496]', '反向遍历', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1996, 'hello world', '5', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1996, 'abc', '3', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，验证回文串。
输入: \"A man, a plan, a canal: Panama\" 输出: true [题497]', '双指针', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1997, 'A man a plan a canal Panama', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1997, 'race a car', 'false', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，模拟浏览器前进后退。
输入: BrowserHistory(\'leetcode.com\') [题498]', '双栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1998, 'leetcode.com forward', 'com', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1998, 'back', 'leetcode.com', 25, 1);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，最大栈。
输入: MaxStack() 输出: 支持push、pop、max操作 [题499]', '辅助栈', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (1999, 'push', 'pop', 25, 0);
INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('请实现一个方法，丑数。
输入: 6 输出: true
输入: 8 输出: true
输入: 14 输出: false [题500]', '分解质因数', 6, 15, '', '', 1, 'java', '', 'standard', 2, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (2000, '6', 'true', 25, 0);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (2000, '8', 'true', 25, 1);
INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES (2000, '14', 'false', 25, 2);