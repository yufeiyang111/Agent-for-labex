#!/usr/bin/env python3
"""
批量生成2000道题库题目，覆盖单选、多选、填空、编程四种类型
"""

import random

def generate_varied_questions():
    """生成多样化的题目"""
    all_questions = []

    # ===== Java基础 (200道) =====
    java_topics = [
        ("Java数据类型与运算符", generate_java_data_types),
        ("Java控制流程", generate_java_control_flow),
        ("Java数组与字符串", generate_java_array_string),
        ("Java面向对象", generate_java_oop),
        ("Java异常处理", generate_java_exception),
        ("Java集合框架", generate_java_collections),
        ("Java泛型", generate_java_generics),
        ("Java注解与反射", generate_java_reflection),
        ("Java多线程", generate_java_multithreading),
        ("Java IO流", generate_java_io),
        ("Java网络编程", generate_java_network),
        ("Java设计模式", generate_java_design_pattern),
    ]

    # ===== Web安全 (300道) =====
    web_security_topics = [
        ("SQL注入", generate_sql_injection),
        ("XSS跨站脚本", generate_xss),
        ("CSRF跨站请求伪造", generate_csrf),
        ("文件上传漏洞", generate_file_upload),
        ("命令注入", generate_command_injection),
        ("越权访问", generate_privilege_escalation),
        ("敏感信息泄露", generate_info_leak),
        ("SSRF服务器请求伪造", generate_ssrf),
        ("反序列化漏洞", generate_deserialization),
        ("Web应用防火墙绕过", generate_waf_bypass),
    ]

    # ===== 计算机网络 (150道) =====
    network_topics = [
        ("OSI七层模型", generate_osi_layers),
        ("TCP协议", generate_tcp_protocol),
        ("UDP协议", generate_udp_protocol),
        ("HTTP协议", generate_http_protocol),
        ("HTTPS与TLS", generate_https_tls),
        ("DNS协议", generate_dns),
        ("路由与网关", generate_routing),
        ("网络安全", generate_network_security),
    ]

    # ===== 数据库 (150道) =====
    database_topics = [
        ("SQL基础查询", generate_sql_basics),
        ("SQL高级查询", generate_sql_advanced),
        ("MySQL索引", generate_mysql_index),
        ("MySQL事务", generate_mysql_transaction),
        ("MySQL存储引擎", generate_mysql_engine),
        ("Redis数据结构", generate_redis_data),
        ("Redis应用", generate_redis_app),
        ("MongoDB基础", generate_mongodb),
    ]

    # ===== 数据结构与算法 (150道) =====
    dsa_topics = [
        ("数组与链表", generate_array_linkedlist),
        ("栈与队列", generate_stack_queue),
        ("二叉树", generate_binary_tree),
        ("图算法", generate_graph),
        ("排序算法", generate_sorting),
        ("查找算法", generate_searching),
        ("动态规划", generate_dp),
        ("贪心算法", generate_greedy),
    ]

    # ===== 操作系统 (100道) =====
    os_topics = [
        ("进程与线程", generate_process_thread),
        ("内存管理", generate_memory),
        ("文件系统", generate_file_system),
        ("Linux命令", generate_linux_commands),
        ("Shell编程", generate_shell),
    ]

    # ===== 前端开发 (100道) =====
    frontend_topics = [
        ("HTML基础", generate_html),
        ("CSS布局", generate_css_layout),
        ("JavaScript基础", generate_js_basic),
        ("ES6新特性", generate_es6),
        ("Vue框架", generate_vue),
        ("React框架", generate_react),
    ]

    # ===== 安全合规 (100道) =====
    compliance_topics = [
        ("GDPR合规", generate_gdpr),
        ("个人信息保护", generate_privacy),
        ("等保测评", generate_evaluation),
        ("安全运维", generate_security_ops),
    ]

    # ===== 容器与DevOps (100道) =====
    devops_topics = [
        ("Docker容器", generate_docker),
        ("Kubernetes", generate_k8s),
        ("CI/CD", generate_cicd),
        ("Git版本控制", generate_git),
        ("云原生架构", generate_cloudnative),
    ]

    # ===== 软件测试 (100道) =====
    testing_topics = [
        ("测试基础", generate_testing_basics),
        ("单元测试", generate_unit_testing),
        ("集成测试", generate_integration_testing),
        ("自动化测试", generate_automation_testing),
    ]

    # ===== 密码学 (100道) =====
    crypto_topics = [
        ("对称加密", generate_symmetric_encryption),
        ("非对称加密", generate_asymmetric_encryption),
        ("哈希函数", generate_hash_function),
        ("数字签名", generate_digital_signature),
        ("PKI体系", generate_pki),
    ]

    # ===== 综合能力 (250道) =====
    general_topics = [
        ("软件架构设计", generate_architecture),
        ("系统设计", generate_system_design),
        ("性能优化", generate_performance),
        ("微服务", generate_microservices),
        ("分布式系统", generate_distributed),
    ]

    all_topic_funcs = (java_topics + web_security_topics + network_topics +
                        database_topics + dsa_topics + os_topics +
                        frontend_topics + compliance_topics + devops_topics +
                        testing_topics + crypto_topics + general_topics)

    for topic_name, gen_func in all_topic_funcs:
        questions = gen_func()
        all_questions.extend(questions)

    return all_questions


def q_single(question, options, answer, analysis=""):
    """创建单选题"""
    return {
        "question": question,
        "type": 2,
        "options": options,
        "answer": answer,
        "analysis": analysis
    }


def q_multi(question, options, answer, analysis=""):
    """创建多选题"""
    return {
        "question": question,
        "type": 3,
        "options": options,
        "answer": answer,
        "analysis": analysis
    }


def q_fill(question, answer, analysis=""):
    """创建填空题"""
    return {
        "question": question,
        "type": 1,
        "options": "",
        "answer": answer,
        "analysis": analysis
    }


def q_programming(question, answer, test_cases, analysis="", template="", language="java"):
    """创建编程题"""
    return {
        "question": question,
        "type": 6,
        "options": "",
        "answer": answer,
        "analysis": analysis,
        "is_programming": 1,
        "language": language,
        "template_code": template,
        "io_mode": "standard",
        "test_cases": test_cases
    }


# ==================== Java题目生成 ====================

def generate_java_data_types():
    questions = []
    # 单选
    data = [
        ("Java中，以下哪个是八种基本数据类型之一？", '{"A":"String","B":"Integer","C":"boolean","D":"Object"}', "C", "Java八种基本数据类型：byte、short、int、long、float、double、char、boolean。"),
        ("以下哪个数据类型的取值范围是-128到127？", '{"A":"byte","B":"short","C":"int","D":"long"}', "A", "byte是8位有符号整数，取值范围-128到127。"),
        ("float类型占据几个字节？", '{"A":"2","B":"4","C":"8","D":"16"}', "B", "float占4字节32位，double占8字节64位。"),
        ("char类型可以存储什么？", '{"A":"中文字符","B":"英文字符","C":"Unicode字符","D":"所有字符"}', "C", "char使用Unicode编码，可以存储任何字符，包括中文。"),
        ("以下哪个运算符用于判断两个对象是否相等（值）？", '{"A":"==","B":"equals()","C":"==和equals()都可以","D":"无法判断"}', "B", "==判断引用地址，equals()判断对象内容（需要重写）。"),
        ("表达式3/2的结果是？", '{"A":"1.5","B":"1","C":"2","D":"1.0"}', "B", "整数除法结果为整数，3/2=1（截断小数部分）。"),
        ("下列哪个是正确的变量命名？", '{"A":"2name","B":"my-name","C":"my_name","D":"class"}', "C", "变量名不能以数字开头、不能含连字符、不能使用关键字。"),
        ("以下哪个修饰符表示常量？", '{"A":"final","B":"static","C":"const","D":"volatile"}', "A", "final表示常量，一旦赋值不能改变；static表示静态；const不是Java关键字。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    # 多选
    multi_data = [
        ("以下哪些是Java的基本数据类型？", '{"A":"byte","B":"String","C":"short","D":"boolean","E":"Object"}', "A,C,D", "String是引用类型，不是基本数据类型。"),
        ("以下哪些运算符可以在Java中使用？", '{"A":"++","B":"--","C":"**","D":"==","E":"!="}', "A,B,D,E", "**不是Java的有效运算符。"),
    ]
    for q, opt, a, an in multi_data:
        questions.append(q_multi(q, opt, a, an))

    # 填空
    fill_data = [
        ("Java中，整数类型的默认类型是____。", "int", "不带后缀的整数默认为int类型。"),
        ("浮点数的默认类型是____。", "double", "不带后缀的浮点数默认为double类型。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_java_control_flow():
    questions = []
    data = [
        ("for循环中，continue的作用是？", '{"A":"结束整个循环","B":"跳过本次循环剩余代码，进入下次循环","C":"退出方法","D":"暂停循环"}', "B", "continue跳过当前循环剩余代码，执行迭代部分。"),
        ("switch语句中，如果所有case都不匹配且没有default，会怎样？", '{"A":"报错","B":"什么也不做","C":"执行所有case","D":"跳到下一个switch"}', "B", "没有default时，switch不执行任何操作。"),
        ("while和do-while的区别是？", '{"A":"while先判断后执行，do-while先执行后判断","B":"while至少执行一次，do-while可能不执行","C":"两者没有区别","D":"while用于对象，do-while用于基本类型"}', "A", "do-while保证至少执行一次循环体。"),
        ("以下哪个不是合法的跳转语句？", '{"A":"break","B":"continue","C":"goto","D":"return"}', "C", "goto是Java的保留字但未使用，break/continue/return都是合法的跳转语句。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    multi_data = [
        ("以下哪些是合法的循环结构？", '{"A":"for","B":"while","C":"do-while","D":"loop","E":"repeat"}', "A,B,C", "Java只有for、while、do-while三种循环。"),
    ]
    for q, opt, a, an in multi_data:
        questions.append(q_multi(q, opt, a, an))

    fill_data = [
        ("for-each循环用于遍历____和集合。", "数组", "for-each是增强的for循环，用于遍历数组和实现了Iterable接口的集合。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_java_array_string():
    questions = []
    data = [
        ("数组下标从几开始？", '{"A":"0","B":"1","C":"-1","D":"任意"}', "A", "Java数组下标从0开始，最后一个元素下标为length-1。"),
        ("以下哪个可以正确创建一个长度为5的整型数组？", '{"A":"int[] arr = new int[5];","B":"int arr = new int[5];","C":"int arr[5];","D":"array[5] int;"}', "A", "Java中数组的创建语法：type[] arrayName = new type[length];。"),
        ("String是不可变的，这句话对吗？", '{"A":"对","B":"错","C":"取决于JVM","D":"只有字符串常量是不可变的"}', "A", "String类被final修饰，内容不可改变，所有String操作都会返回新字符串。"),
        ("以下哪个方法可以获取字符串长度？", '{"A":"length()","B":"size()","C":"getLength()","D":"len()"}', "A", "String使用length()方法获取长度，集合使用size()方法。"),
        ("StringBuilder和StringBuffer的区别是？", '{"A":"StringBuilder线程不安全，StringBuffer线程安全","B":"StringBuilder比StringBuffer快","C":"两者没有区别","D":"StringBuffer比StringBuilder快"}', "A", "StringBuilder是线程不安全的单线程环境更高效；StringBuffer线程安全但性能略低。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    multi_data = [
        ("以下哪些是数组的特点？", '{"A":"连续内存存储","B":"支持随机访问","C":"大小固定","D":"可以存储不同类型","E":"查询快增删慢"}', "A,B,C,E", "数组大小固定且只能存储相同类型，连续内存支持下标快速访问。"),
    ]
    for q, opt, a, an in multi_data:
        questions.append(q_multi(q, opt, a, an))

    fill_data = [
        ("创建一个长度为10的int数组：int[] arr = new int[____];", "10", "数组长度在new时指定。"),
        ("字符串分割使用split方法，返回的是____类型。", "String[]", "String.split()返回按分隔符分割后的字符串数组。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_java_oop():
    questions = []
    data = [
        ("一个类可以继承几个父类？", '{"A":"1个","B":"2个","C":"多个","D":"0个"}', "A", "Java是单继承，一个类只能继承一个父类，但可以实现多个接口。"),
        ("以下哪个关键字用于实现继承？", '{"A":"extends","B":"implements","C":"inherits","D":"super"}', "A", "extends用于类继承类或类继承抽象类，implements用于实现接口。"),
        ("构造方法能否被继承？", '{"A":"能","B":"不能","C":"可以调用但不是继承","D":"取决于访问修饰符"}', "B", "构造方法不能被继承，子类通过super()调用父类构造方法。"),
        ("以下哪个修饰符的成员不能被外部访问？", '{"A":"public","B":"protected","C":"private","D":"default"}', "C", "private成员只能在同类中访问，public/protected/default在不同的作用域可访问。"),
        ("抽象类能否实例化？", '{"A":"能","B":"不能","C":"抽象类引用可以但对象不行","D":"取决于是否有抽象方法"}', "B", "抽象类不能直接实例化，需要通过继承并实现抽象方法后创建子类对象。"),
        ("接口中定义的变量默认是什么修饰符？", '{"A":"public","B":"private","C":"protected","D":"final"}', "D", "接口中变量默认是public static final，即常量。"),
        ("方法重写（Override）的特征是？", '{"A":"方法名相同、参数列表相同、返回类型相同","B":"方法名相同、参数不同","C":"可以在同一个类中发生","D":"必须改变返回类型"}', "A", "重写要求方法名、参数列表、返回类型都要相同，且访问权限不能比父类更严格。"),
        ("以下哪个关键字用于调用父类构造方法？", '{"A":"this","B":"super","C":"parent","D":"base"}', "B", "super用于调用父类的构造方法和父类成员。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    multi_data = [
        ("以下哪些是面向对象的基本特征？", '{"A":"封装","B":"继承","C":"多态","D":"重载","E":"抽象"}', "A,B,C,E", "面向对象三大特征：封装、继承、多态。加上抽象就是四大特征。重载不是面向对象特征。"),
        ("以下哪些修饰符可以修饰类？", '{"A":"public","B":"abstract","C":"final","D":"static","E":"private"}', "A,B,C", "类可以使用public、abstract、final修饰；private和static不能修饰类。"),
    ]
    for q, opt, a, an in multi_data:
        questions.append(q_multi(q, opt, a, an))

    fill_data = [
        ("Java中使用____关键字来引用当前对象。", "this", "this指向当前对象，用于区分成员变量和局部变量。"),
        ("方法重载（Overload）要求方法名____，参数列表____。", "相同|不同", "重载发生在同一个类中，方法名相同但参数列表不同（类型或个数）。"),
        ("父类引用指向子类对象称为____。", "向上转型", "Upcasting是将子类对象赋值给父类引用。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    # 编程题
    questions.append(q_programming(
        "定义一个类Animal，包含属性name和age，以及方法eat()。创建子类Dog继承Animal，添加方法bark()。实现构造函数初始化所有属性。",
        "",
        [
            {"input": "", "expected_output": "Animal created\nDog bark: Woof!", "score_weight": 100, "sort_index": 0}
        ],
        "考察继承、构造方法调用、方法重写。",
        "class Animal {\n    String name;\n    int age;\n    // TODO: 实现构造函数和eat方法\n}\n\nclass Dog extends Animal {\n    // TODO: 实现构造函数和bark方法\n}"
    ))

    return questions


def generate_java_exception():
    questions = []
    data = [
        ("以下哪个是检查型异常（Checked Exception）？", '{"A":"NullPointerException","B":"ArrayIndexOutOfBoundsException","C":"IOException","D":"ArithmeticException"}', "C", "IOException是检查型异常，需要强制处理；其他三个都是RuntimeException的子类。"),
        ("try-catch-finally块中，finally块何时执行？", '{"A":"只在try块正常完成后","B":"只在catch块执行后","C":"无论是否发生异常都会执行","D":"只有在抛出异常时"}', "C", "finally块无论是否发生异常都会执行，只有System.exit()能阻止。"),
        ("throw和throws的区别是？", '{"A":"throw抛出异常，throws声明异常","B":"throw声明异常，throws抛出异常","C":"两者没有区别","D":"throw用于catch块，throws用于方法签名"}', "A", "throw是实际抛出异常的动作，throws是在方法签名中声明可能抛出的异常类型。"),
        ("以下哪个异常不需要在代码中处理？", '{"A":"IOException","B":"SQLException","C":"NullPointerException","D":"ClassNotFoundException"}', "C", "NullPointerException是RuntimeException，不需要强制处理；其他三个是检查型异常。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    multi_data = [
        ("以下哪些是RuntimeException的子类？", '{"A":"NullPointerException","B":"ArrayIndexOutOfBoundsException","C":"IOException","D":"ArithmeticException","E":"ClassNotFoundException"}', "A,B,D", "RuntimeException包括空指针、数组越界、算术异常等；IOException和ClassNotFoundException是检查型异常。"),
    ]
    for q, opt, a, an in multi_data:
        questions.append(q_multi(q, opt, a, an))

    fill_data = [
        ("catch块捕获异常时，子类异常要写在____异常之前。", "父类", "Java按catch块顺序匹配异常类型，子类要在父类之前。"),
        ("Error和Exception都继承自____类。", "Throwable", "Throwable是Java异常体系的根类。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_java_collections():
    questions = []
    data = [
        ("ArrayList和LinkedList的主要区别是？", '{"A":"ArrayList是线程安全的，LinkedList不是","B":"ArrayList查询快增删慢，LinkedList增删快查询慢","C":"ArrayList基于数组，LinkedList基于双向链表","D":"两者没有区别"}', "C", "ArrayList基于动态数组，查询O(1)但增删需移动元素；LinkedList基于链表，增删O(1)但查询需遍历。"),
        ("HashMap的key可以为null吗？", '{"A":"可以，且只能有一个null key","B":"不可以","C":"可以有多个null key","D":"只有String类型的key可以为null"}', "A", "HashMap允许一个null key（覆盖），多个null value；Hashtable不允许任何null。"),
        ("以下哪个集合不能存储重复元素？", '{"A":"ArrayList","B":"LinkedList","C":"HashSet","D":"Stack"}', "C", "HashSet基于HashMap实现，不允许重复元素；ArrayList、LinkedList、Stack都允许重复。"),
        ("迭代器（Iterator）的作用是？", '{"A":"替代for循环","B":"统一遍历集合的方式","C":"增加集合元素","D":"排序集合"}', "B", "Iterator提供统一的方式遍历集合，可以remove()安全删除元素。"),
        ("TreeSet使用什么实现元素排序？", '{"A":"HashMap","B":"TreeMap","C":"LinkedHashMap","D":"Comparator"}', "B", "TreeSet基于TreeMap，使用自然排序或Comparator实现元素排序。"),
        ("ConcurrentHashMap使用什么机制保证线程安全？", '{"A":"synchronized","B":"ReentrantLock","C":"分段锁（Segment）","D":"原子变量"}', "C", "ConcurrentHashMap使用分段锁，将数据分成多个Segment，每个Segment独立加锁。"),
        ("以下哪个接口是List的直接父接口？", '{"A":"Collection","B":"Map","C":"Set","D":"Iterable"}', "A", "List、Set、Queue都继承自Collection接口；Map是独立的接口层级。"),
        ("ArrayList默认初始容量是？", '{"A":"0","B":"8","C":"10","D":"16"}', "C", "ArrayList默认初始容量是10，JDK 1.8之前是10，1.8+无参构造是空数组，首次添加时扩容到10。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    multi_data = [
        ("以下哪些是fail-fast迭代器的特征？", '{"A":"检测到集合被修改时抛出ConcurrentModificationException","B":"使用modCount变量检测","C":"不保证抛出异常","D":"ConcurrentHashMap的迭代器是fail-fast","E":"CopyOnWriteArrayList的迭代器是fail-fast"}', "A,B,C", "fail-fast使用modCount检测并发修改，ArrayList/HashMap是fail-fast，ConcurrentHashMap/CopyOnWriteArrayList是fail-safe。"),
        ("以下哪些方法可以向ArrayList添加元素？", '{"A":"add()","B":"add(index, element)","C":"set()","D":"append()","E":"insert()"}', "A,B", "add()和add(index, element)是ArrayList的添加方法；set()是替换而非添加。"),
    ]
    for q, opt, a, an in multi_data:
        questions.append(q_multi(q, opt, a, an))

    fill_data = [
        ("HashMap的负载因子（loadFactor）默认是____。", "0.75", "负载因子决定何时扩容，默认0.75表示元素数量达到容量的75%时扩容。"),
        ("Iterator的____方法用于判断是否还有更多元素。", "hasNext()", "hasNext()判断是否还有元素，next()返回下一个元素。"),
        ("使用Map时，如果key不存在，get方法返回____。", "null", "Map.get()在key不存在时返回null（HashMap），可以用getOrDefault设置默认值。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    # 编程题
    questions.append(q_programming(
        "实现一个方法，打印ArrayList中所有元素，格式：[元素1, 元素2, 元素3]。如果列表为空，打印[]。",
        "",
        [
            {"input": "1,2,3", "expected_output": "[1, 2, 3]", "score_weight": 50, "sort_index": 0},
            {"input": "", "expected_output": "[]", "score_weight": 50, "sort_index": 1}
        ],
        "考察ArrayList遍历和字符串格式化。",
        "import java.util.*;\n\npublic class ListPrinter {\n    public static String printList(ArrayList<Integer> list) {\n        // TODO: 实现打印方法\n        return \"\";\n    }\n}"
    ))

    return questions


def generate_java_generics():
    questions = []
    data = [
        ("以下哪个正确声明了一个上限通配符？", '{"A":"<T extends Number>","B":"<? extends Number>","C":"<? super Integer>","D":"<T super Number>"}', "B", "? extends Number是上限通配符，接受Number及其子类；? super Integer是下限通配符。"),
        ("泛型类型擦除后，无界<T>会被替换为？", '{"A":"null","B":"Object","C":"int","D":"T"}', "B", "类型擦除后，无界<T>替换为Object，有界<T extends X>替换为X。"),
        ("以下哪个选项可以在List<? extends Number>中添加元素？", '{"A":"Integer","B":"Double","C":"null","D":"Number","E":"都不能添加除了null"}', "E", "? extends Number只读不写，因为编译器不知道具体是Number的哪个子类。"),
        ("静态成员能否使用类的泛型参数？", '{"A":"能","B":"不能","C":"只能用于静态方法","D":"只能用于静态属性"}', "B", "静态成员属于类不属于实例，不能使用泛型参数，但可以有自己的泛型方法。"),
        ("以下哪个是正确的泛型数组创建方式？", '{"A":"new T[10]","B":"new List<T>[10]","C":"(T[]) new Object[10]","D":"T[10]"}', "C", "Java不能直接创建泛型数组，但可以创建Object数组后强转；无界<T>擦除后为Object。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    multi_data = [
        ("以下哪些是泛型的限制？", '{"A":"不能实例化类型参数 new T()","B":"不能创建泛型数组 new T[10]","C":"不能使用基本类型 List<int>","D":"不能抛出或捕获泛型异常","E":"不能定义泛型枚举"}', "A,B,C,D,E", "泛型所有限制：不能实例化、不能创建泛型数组、不能使用基本类型、不能异常、不能枚举、不能instanceof（除非用通配符）。"),
    ]
    for q, opt, a, an in multi_data:
        questions.append(q_multi(q, opt, a, an))

    fill_data = [
        ("PECS原则：Producer用____，Consumer用____。", "extends|super", "Producer Extends（生产数据读取）用extends，Consumer Super（消费数据写入）用super。"),
        ("泛型的类型擦除发生在____阶段。", "编译", "泛型信息只在编译期存在，运行期被擦除以兼容旧代码。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_java_reflection():
    questions = []
    data = [
        ("以下哪个注解表示方法重写？", '{"A":"@Override","B":"@Deprecated","C":"@SuppressWarnings","D":"@FunctionalInterface"}', "A", "@Override标识方法重写，编译器会验证父类中是否存在该方法。"),
        ("@Retention(RUNTIME)表示什么？", '{"A":"只在源码中存在","B":"在字节码中存在","C":"在运行时可以通过反射读取","D":"会被包含在JavaDoc中"}', "C", "@Retention定义注解保留策略：SOURCE源码级、CLASS字节码级、RUNTIME运行期。"),
        ("以下哪个方法可以获取类的所有public方法？", '{"A":"getMethods()","B":"getDeclaredMethods()","C":"getMethod()","D":"getFields()"}', "A", "getMethods()获取所有public方法包括继承的；getDeclaredMethods()获取本类所有方法。"),
        ("通过反射访问私有属性需要使用？", '{"A":"getField()","B":"getDeclaredField() + setAccessible(true)","C":"getDeclaredFields()","D":"getPrivateField()"}', "B", "getDeclaredField()可获取私有属性，setAccessible(true)允许访问。"),
        ("JDK动态代理需要实现哪个接口？", '{"A":"Proxy","B":"InvocationHandler","C":"ClassLoader","D":"Method"}', "B", "JDK动态代理需要实现InvocationHandler接口并重写invoke方法。"),
        ("注解中定义元素的方法可以有哪种返回类型？", '{"A":"void","B":"Class","C":"String[]","D":"以上都不行"}', "B", "注解元素不能返回void，可以返回基本类型、String、Class、枚举、注解及以上类型数组。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    multi_data = [
        ("以下哪些是元注解？", '{"A":"@Retention","B":"@Target","C":"@Documented","D":"@Override","E":"@Inherited"}', "A,B,C,E", "@Override不是元注解，是标识重写的方法注解。元注解有@Retention、@Target、@Documented、@Inherited、@Repeatable。"),
        ("通过反射获取Class对象的方式有？", '{"A":"Class.forName()","B":".class","C":"getClass()","D":"new Object().class","E":"ClassLoader"}', "A,B,C", "三种方式：forName(字符串)、.class（类字面量）、getClass()（对象方法）。new Object().class不是合法语法。"),
    ]
    for q, opt, a, an in multi_data:
        questions.append(q_multi(q, opt, a, an))

    fill_data = [
        ("反射中，通过____方法可以获取类名（包含包名）。", "getName()", "clazz.getName()返回全限定名如com.example.User，getSimpleName()返回简单类名。"),
        ("JDK动态代理的invoke方法，第一个参数是代理对象，第二个参数是____，第三个参数是____。", "方法对象|方法参数", "invoke(Object proxy, Method method, Object[] args)三个参数分别是：代理对象、反射方法对象、方法参数数组。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_java_multithreading():
    questions = []
    data = [
        ("以下哪个关键字可以保证变量的可见性？", '{"A":"synchronized","B":"volatile","C":"final","D":"static"}', "B", "volatile保证可见性和防止指令重排序，但不保证原子性；synchronized保证原子性、可见性、有序性。"),
        ("Thread的start()方法调用后会？", '{"A":"立即执行run()","B":"将线程设为可运行状态，等待调度","C":"创建新线程","D":"等待main()方法结束"}', "B", "start()将线程加入可运行队列，等待CPU调度执行run()方法。直接调用run()是在当前线程执行。"),
        ("synchronized修饰静态方法的锁对象是？", '{"A":"this对象","B":"Class对象","C":"null","D":"当前线程"}', "B", "静态方法属于类，synchronized修饰的锁对象是Class对象；实例方法的锁对象是this。"),
        ("以下哪个状态是线程的生命周期中的？", '{"A":"NEW、RUNNING、BLOCKED、WAITING、TERMINATED","B":"NEW、RUNNABLE、BLOCKED、WAITING、TIMED_WAITING、TERMINATED","C":"NEW、READY、RUNNING、WAITING、TERMINATED","D":"NEW、RUNNING、DEAD"}', "B", "线程6个状态：NEW、RUNNABLE、BLOCKED、WAITING、TIMED_WAITING、TERMINATED。"),
        ("以下哪个方法会使线程进入等待状态？", '{"A":"Thread.sleep()","B":"Thread.yield()","C":"Thread.join()","D":"Thread.notify()"}', "A,C", "sleep()和join()会使线程等待；yield()让出CPU但保持RUNNABLE；notify()唤醒等待线程。"),
        ("ThreadLocal的作用是？", '{"A":"线程间通信","B":"为每个线程提供独立的变量副本","C":"创建新线程","D":"终止线程"}', "B", "ThreadLocal为每个线程提供独立的变量副本，实现线程隔离，常用于存储用户会话、事务ID等。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    multi_data = [
        ("死锁的必要条件包括？", '{"A":"互斥条件","B":"占有并等待","C":"不可抢占","D":"循环等待","E":"同步机制"}', "A,B,C,D", "死锁四必要条件：互斥、占有并等待、不可抢占、循环等待。"),
        ("以下哪些方式可以创建线程？", '{"A":"继承Thread类","B":"实现Runnable接口","C":"实现Callable接口","D":"继承Object类","E":"使用线程池"}', "A,B,C,E", "三种基本方式：继承Thread、实现Runnable、实现Callable（配合FutureTask）。"),
    ]
    for q, opt, a, an in multi_data:
        questions.append(q_multi(q, opt, a, an))

    fill_data = [
        ("wait()方法必须在____块或方法中调用。", "synchronized", "wait()、notify()、notifyAll()必须在synchronized保护的临界区中调用。"),
        ("创建线程池使用____框架（java.util.concurrent包）。", "Executor", "Executor框架提供ThreadPoolExecutor、ScheduledThreadPoolExecutor等线程池实现。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_java_io():
    questions = []
    data = [
        ("以下哪个流用于处理字节输入？", '{"A":"Reader","B":"Writer","C":"InputStream","D":"File"}', "C", "InputStream处理字节输入，Reader处理字符输入；Writer输出字符，OutputStream输出字节。"),
        ("BufferedReader相比FileReader的优势是？", '{"A":"可以指定编码","B":"使用缓冲区减少IO次数","C":"可以读取二进制","D":"可以按行读取所有类型"}', "B", "BufferedReader使用缓冲区减少IO次数，还能按行读取。指定编码用InputStreamReader。"),
        ("ObjectOutputStream用于？", '{"A":"写入字符","B":"写入字节","C":"序列化对象写入文件","D":"读取对象"}', "C", "ObjectOutputStream用于将对象序列化后写入文件，需要对象实现Serializable接口。"),
        ("以下哪个是字符流？", '{"A":"FileInputStream","B":"BufferedInputStream","C":"InputStreamReader","D":"DataInputStream"}', "C", "InputStreamReader是字符流，其他都是字节流。OutputStreamWriter也是字符流。"),
        ("RandomAccessFile可以做什么？", '{"A":"只能读","B":"只能写","C":"随机读写","D":"顺序读写"}', "C", "RandomAccessFile支持随机读写文件，可以通过seek()定位到任意位置。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    multi_data = [
        ("以下哪些是InputStream的方法？", '{"A":"read()","B":"write()","C":"close()","D":"flush()","E":"available()"}', "A,C,E", "InputStream有read()、close()、available()；write()和flush()是OutputStream的方法。"),
    ]
    for q, opt, a, an in multi_data:
        questions.append(q_multi(q, opt, a, an))

    fill_data = [
        ("IO流按操作单位分为字节流和____流。", "字符", "字节流处理byte数据（InputStream/OutputStream），字符流处理char数据（Reader/Writer）。"),
        ("使用完流后，应该在____块中调用close()方法确保关闭。", "finally", "close()应在finally块中调用，确保流被关闭释放资源。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_java_network():
    questions = []
    data = [
        ("TCP和UDP的主要区别是？", '{"A":"TCP面向连接，UDP无连接","B":"TCP可靠传输，UDP不可靠","C":"TCP比UDP快","D":"A和B都正确"}', "D", "TCP面向连接、提供可靠传输、有拥塞控制；UDP无连接、不可靠但更高效。"),
        ("三次握手的作用是？", '{"A":"传输数据","B":"建立可靠连接，确认双方收发能力","C":"断开连接","D":"加密数据"}', "B", "三次握手建立连接：SYN、SYN-ACK、ACK，确认双方发送和接收能力正常。"),
        ("四次挥手中，为什么TIME_WAIT要等待2MSL？", '{"A":"确保对方收到断开请求","B":"防止旧连接的迷路报文影响新连接","C":"等待对方关闭","D":"确保数据完整传输"}', "B", "2MSL等待确保最后ACK丢失时可以重传，防止迷路报文影响新连接。"),
        ("Socket编程中，ServerSocket的accept()方法作用是？", '{"A":"接受客户端连接","B":"绑定端口","C":"发送数据","D":"接收数据"}', "A", "accept()阻塞等待客户端连接，返回Socket对象用于与该客户端通信。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("HTTP协议默认端口是____，HTTPS默认端口是____。", "80|443", "HTTP 80，HTTPS 443，FTP 21，SSH 22，MySQL 3306。"),
        ("TCP/IP四层模型中，HTTP属于____层，TCP属于____层。", "应用|传输", "TCP/IP四层：应用层（HTTP/FTP）、传输层（TCP/UDP）、网络层（IP）、链路层。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_java_design_pattern():
    questions = []
    data = [
        ("GoF设计模式共有多少种？", '{"A":"20","B":"23","C":"25","D":"27"}', "B", "GoF设计模式共23种：创建型5种、结构型7种、行为型11种。"),
        ("单例模式中，饿汉式的特点是？", '{"A":"延迟加载","B":"类加载时创建实例","C":"线程不安全","D":"需要双重检查"}', "B", "饿汉式在类加载时就创建实例，线程安全但不是延迟加载。"),
        ("工厂方法模式的抽象产品由谁声明？", '{"A":"具体工厂","B":"抽象工厂","C":"客户端","D":"产品实现类"}', "B", "工厂方法模式中，抽象工厂声明创建产品接口，具体工厂实现创建具体产品。"),
        ("建造者模式（Builder）适用于什么场景？", '{"A":"对象创建简单","B":"创建复杂对象，将构建与表示分离","C":"需要共享对象","D":"对象需要被代理"}', "B", "建造者模式适用于创建复杂对象，将构建过程和表示分离，使同样构建创建不同表示。"),
        ("观察者模式中，Subject维护的是什么？", '{"A":"观察者数量","B":"观察者列表","C":"被观察对象","D":"发布内容"}', "B", "Subject维护Observer列表，Observer向Subject注册，当状态改变时通知所有Observer。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    multi_data = [
        ("以下哪些是创建型设计模式？", '{"A":"单例模式","B":"工厂方法","C":"抽象工厂","D":"策略模式","E":"建造者"}', "A,B,C,E", "创建型5种：单例、工厂方法、抽象工厂、建造者、原型。策略模式是行为型。"),
        ("SOLID原则包括？", '{"A":"单一职责","B":"开闭原则","C":"里氏替换","D":"接口隔离","E":"依赖倒置"}', "A,B,C,D,E", "SOLID原则：S单一职责、O开闭、L里氏替换、I接口隔离、D依赖倒置。"),
    ]
    for q, opt, a, an in multi_data:
        questions.append(q_multi(q, opt, a, an))

    fill_data = [
        ("策略模式定义了一系列算法，并封装每个算法，使它们可以互相____。", "替换", "策略模式使不同算法可以互换，体现了面向对象的多态特性。"),
        ("模板方法模式定义一个算法的骨架，将一些步骤延迟到____中实现。", "子类", "模板方法将不变部分封装在父类，可变部分延迟到子类实现。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    # 编程题
    questions.append(q_programming(
        "请使用Java实现一个线程安全的单例模式（懒汉式，双重检查锁定）。类名Singleton，提供静态方法getInstance()。使用volatile关键字修饰实例变量。",
        "",
        [
            {"input": "", "expected_output": "true\ntrue", "score_weight": 100, "sort_index": 0}
        ],
        "考察单例模式的双重检查锁定实现和volatile作用。",
        "public class Singleton {\n    // TODO: 使用volatile和双重检查实现线程安全的懒汉式单例\n}"
    ))

    return questions


# ==================== Web安全题目生成 ====================

def generate_sql_injection():
    questions = []
    # 单选
    data = [
        ("SQL注入属于什么类型的攻击？", '{"A":"物理攻击","B":"代码注入攻击","C":"社会工程攻击","D":"拒绝服务攻击"}', "B", "SQL注入是一种代码注入技术，通过在输入中插入恶意SQL语句操纵数据库。"),
        ("防御SQL注入的最佳方式是？", '{"A":"过滤特殊字符","B":"限制输入长度","C":"参数化查询","D":"Base64编码输入"}', "C", "参数化查询将SQL语句结构与数据分离，数据不作为代码执行。"),
        ("MyBatis中哪个符号可以防止SQL注入？", '{"A":"${}","B":"#{}","C":"两者都可以","D":"$"}', "B", "#{}使用预编译参数化，${}是字符串拼接存在注入风险。"),
        ("联合查询注入利用SQL的哪个关键字？", '{"A":"WHERE","B":"UNION","C":"ORDER BY","D":"GROUP BY"}', "B", "UNION用于合并两个SELECT结果，攻击者利用它获取额外数据。"),
        ("错误型SQL注入利用什么获取信息？", '{"A":"页面加载时间","B":"布尔判断结果","C":"数据库错误信息","D":"用户输入内容"}', "C", "错误型注入通过触发数据库错误，从错误消息中获取数据库结构信息。"),
        ("时间盲注中，SLEEP()函数的作用是？", '{"A":"关闭数据库连接","B":"延长查询时间判断条件","C":"删除数据","D":"创建新用户"}', "B", "SLEEP()使查询暂停指定时间，通过响应时间差异判断条件真假。"),
        ("堆叠查询注入使用什么字符分隔SQL语句？", '{"A":"逗号","B":"分号","C":"冒号","D":"破折号"}', "B", "分号用于分隔多条SQL语句，堆叠查询可以执行多条独立SQL。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    multi_data = [
        ("以下哪些可以有效防御SQL注入？", '{"A":"参数化查询","B":"输入验证白名单","C":"使用ORM框架","D":"遵循最小权限原则","E":"关闭详细错误信息"}', "A,B,C,D,E", "SQL注入防护需要多层：参数化查询、输入验证、ORM框架、最小权限、错误处理。"),
        ("SQL注入可能造成哪些危害？", '{"A":"绕过用户认证","B":"数据泄露或篡改","C":"执行系统命令","D":"修改浏览器设置","E":"发起DDoS攻击"}', "A,B,C", "SQL注入主要危害：绕过认证、数据泄露/篡改、在特定条件下可执行系统命令。"),
    ]
    for q, opt, a, an in multi_data:
        questions.append(q_multi(q, opt, a, an))

    fill_data = [
        ("参数化查询将SQL语句结构和____分离，数据只作为____传递。", "数据|值", "参数化查询预编译SQL结构，数据作为参数值不会解释为代码。"),
        ("布尔盲注通过观察____返回内容差异判断条件真假。", "页面", "布尔盲注通过页面是否正常显示判断条件真假。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_xss():
    questions = []
    data = [
        ("XSS的全称是？", '{"A":"Cross-Site Request","B":"Cross-Site Scripting","C":"Client-Server Script","D":"Cross-Source Script"}', "B", "XSS是Cross-Site Scripting（跨站脚本攻击）。"),
        ("存储型XSS和反射型XSS的主要区别是？", '{"A":"存储型XSS不需要用户交互","B":"反射型XSS将恶意脚本存储在服务器","C":"存储型XSS恶意脚本被永久存储在服务器","D":"反射型XSS不经过服务器处理"}', "C", "存储型XSS恶意代码被永久存储在服务器端；反射型作为请求参数被服务器反射。"),
        ("以下哪个HTTP头可以防护XSS？", '{"A":"X-Frame-Options","B":"Content-Security-Policy","C":"Strict-Transport-Security","D":"X-Content-Type-Options"}', "B", "CSP（Content-Security-Policy）限制页面脚本来源，有效防护XSS。"),
        ("HttpOnly Cookie的作用是？", '{"A":"防止CSRF攻击","B":"防止JavaScript访问Cookie","C":"加密Cookie","D":"防止Cookie被篡改"}', "B", "HttpOnly标记防止JavaScript读取Cookie，有效防止XSS窃取Cookie。"),
        ("DOM型XSS的特点是？", '{"A":"需要服务器存储恶意脚本","B":"完全在客户端执行，不涉及服务器","C":"比其他类型更危险","D":"只能通过反射型触发"}', "B", "DOM型XSS纯客户端漏洞，通过操作DOM执行恶意脚本，不涉及服务器。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    multi_data = [
        ("XSS攻击可能造成哪些危害？", '{"A":"窃取Cookie/Session","B":"键盘记录","C":"修改页面内容钓鱼","D":"植入恶意软件","E":"直接删除服务器数据"}', "A,B,C,D", "XSS危害：窃取认证信息、键盘记录、页面篡改、恶意软件植入。不是直接删除服务器数据。"),
    ]
    for q, opt, a, an in multi_data:
        questions.append(q_multi(q, opt, a, an))

    fill_data = [
        ("XSS三种主要类型：反射型、存储型和____型。", "DOM", "XSS分为反射型、存储型、DOM型三种。"),
        ("HTML上下文中，需要编码____、____、____字符防止XSS。", "<|>|&", "HTML编码：<、>、&，属性中还需要编码双引号。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_csrf():
    questions = []
    data = [
        ("CSRF的全称是？", '{"A":"Cross-Site Request Forgery","B":"Cross-Server Request Format","C":"Client-Side Request Forgery","D":"Cross-Site Resource Forwarding"}', "A", "CSRF是Cross-Site Request Forgery（跨站请求伪造）。"),
        ("以下哪个不是CSRF的防护措施？", '{"A":"验证Referer头","B":"使用Anti-CSRF Token","C":"使用HTTPS","D":"验证自定义请求头"}', "C", "HTTPS是加密传输，不能防护CSRF。CSRF防护：Referer验证、Token、自定义头验证。"),
        ("CSRF攻击利用的前提是？", '{"A":"用户已登录","B":"用户访问恶意网站","C":"用户登录状态存在Cookie中","D":"以上都是"}', "D", "CSRF利用用户已登录状态，通过Cookie自动发送认证信息，欺骗服务器执行恶意操作。"),
        ("Anti-CSRF Token的工作原理是？", '{"A":"加密用户密码","B":"服务器生成随机Token，表单和Cookie都包含，提交时验证一致性","C":"记录用户IP地址","D":"限制请求频率"}', "B", "Token机制：服务器生成随机Token，同时放在表单和Session中，提交时验证两者匹配。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("CSRF攻击利用浏览器的____特性自动发送Cookie。", "同源策略漏洞", "浏览器会自动发送同源Cookie，攻击者利用这个特性发起伪造请求。"),
        ("SameSite Cookie可以防止____攻击。", "CSRF", "SameSite属性阻止跨站请求携带Cookie，有效防护CSRF。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_file_upload():
    questions = []
    data = [
        ("文件上传漏洞的主要危害是？", '{"A":"消耗服务器存储","B":"上传恶意脚本执行命令","C":"导致网站崩溃","D":"用户无法上传正常文件"}', "B", "文件上传漏洞可导致恶意脚本（WebShell）在服务器执行，造成命令执行、数据泄露等严重后果。"),
        ("以下哪个不是安全的文件上传处理方式？", '{"A":"验证文件类型","B":"重命名上传文件","C":"将文件存储在Web目录外","D":"直接保存原文件名"}', "D", "直接保存原文件名危险，攻击者可利用上传的可执行文件；应验证类型、重命名、限制目录。"),
        ("MIME类型验证可以被什么绕过？", '{"A":"修改文件扩展名","B":"修改Content-Type头","C":"使用00截断","D":"B和C都可以"}', "D", "MIME类型可被客户端修改或00截断绕过，应在服务端进行内容检测。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("文件上传安全处理：验证文件类型、限制文件大小、____文件内容、____上传文件名。", "检测|重命名", "安全上传应：验证MIME、检测内容、限制大小、重命名文件、存储在非Web目录。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_command_injection():
    questions = []
    data = [
        ("命令注入（Command Injection）是指？", '{"A":"用户数据被当作系统命令执行","B":"发送大量命令导致服务器崩溃","C":"数据库命令执行","D":"网络协议命令"}', "A", "命令注入是用户输入被拼接到系统命令中执行，可导致服务器被控制。"),
        ("以下哪个函数可能存在命令注入风险？", '{"A":"echo()","B":"system()","C":"print()","D":"var_dump()"}', "B", "system()、exec()、shell_exec()等函数执行系统命令，如未过滤用户输入存在注入风险。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("防止命令注入：尽量使用____函数而非system/exec，避免拼接用户输入。", "escapeshellarg", "escapeshellarg()对参数转义，escapeshellcmd()对命令转义，但不能完全替代白名单。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_privilege_escalation():
    questions = []
    data = [
        ("水平越权是指？", '{"A":"低权限用户获得高权限","B":"同权限用户访问他人资源","C":"未登录用户访问受限资源","D":"管理员访问所有数据"}', "B", "水平越权：同级别用户之间访问他人资源，如查看他人订单、修改他人资料。"),
        ("垂直越权是指？", '{"A":"用户访问同级别用户资源","B":"低权限用户获得高权限操作","C":"用户访问自己的不同资源","D":"游客访问已登录用户内容"}', "B", "垂直越权：低权限用户获得高权限操作，如普通用户执行管理员操作。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("防止越权访问：在每个请求中验证当前用户是否有权操作该资源，使用____机制而非依赖用户提供的ID。", "会话绑定", "安全做法：将用户ID绑定到会话，验证操作时从会话获取而非用户输入。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_info_leak():
    questions = []
    data = [
        ("以下哪个不是敏感信息泄露的途径？", '{"A":"错误信息包含数据库结构","B":"Git仓库包含配置信息","C":"使用HTTPS加密传输","D":"日志文件记录敏感数据"}', "C", "HTTPS是安全措施，不会泄露信息；错误信息、代码仓库、日志文件都可能泄露敏感信息。"),
        ("信息收集阶段，攻击者可能从哪些途径获取信息？", '{"A":"公开的DNS记录","B":"员工的社交媒体","C":"错误页面","D":"以上都是"}', "D", "信息收集可从DNS、社交媒体、错误页面、代码仓库等多个途径获取目标信息。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("防止敏感信息泄露：生产环境关闭详细错误、敏感数据脱敏、代码仓库使用____文件忽略敏感配置。", ".gitignore", ".gitignore确保敏感文件不被提交到版本控制系统。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_ssrf():
    questions = []
    data = [
        ("SSRF（Server-Side Request Forgery）是？", '{"A":"攻击者从服务器发起请求访问内部资源","B":"用户从客户端发起请求","C":"服务器之间的正常通信","D":"跨站请求伪造"}', "A", "SSRF是服务器端请求伪造，攻击者利用服务器访问内网资源或执行攻击。"),
        ("SSRF的主要危害包括？", '{"A":"访问内网数据","B":"扫描内网端口","C":"攻击内部服务","D":"以上都是"}', "D", "SSRF可访问云服务器元数据、扫描内网端口、攻击内部数据库/缓存服务等。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("防止SSRF：限制请求目标、使用____验证输入URL、禁止访问内网IP段。", "白名单", "SSRF防护：URL白名单、解析后验证主机名、阻止内网IP访问。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_deserialization():
    questions = []
    data = [
        ("反序列化漏洞产生的原因是？", '{"A":"用户输入被反序列化执行","B":"序列化数据被篡改","C":"序列化格式错误","D":"使用了XML格式"}', "A", "反序列化漏洞：当不可信数据被反序列化时，如果类重写了特定方法可能执行恶意代码。"),
        ("Java中哪个类重写了readObject可能存在风险？", '{"A":"HashMap","B":"ArrayList","C":"任何实现了Serializable的类","D":"ObjectInputStream"}', "C", "任何实现了Serializable的类重写了readObject()都可能在反序列化时执行代码，造成安全风险。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("防止反序列化漏洞：不要反序列化不可信数据、使用____库进行过滤。", "ObjectInputFilter", "Java 9+提供ObjectInputFilter设置反序列化过滤器，白名单控制允许反序列化的类。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_waf_bypass():
    questions = []
    data = [
        ("SQL注入绕过WAF的技巧包括？", '{"A":"大小写混合","B":"注释替代空格","C":"URL编码","D":"以上都是"}', "D", "WAF绕过技术包括：大小写混合、注释、编码、等价函数、替换关键字等。"),
        ("XSS绕过WAF的技巧包括？", '{"A":"大小写混写","B":"使用HTML实体编码","C":"利用事件处理器","D":"以上都是"}', "D", "XSS绕过：大小写混合、实体编码、空格替代、新标签、事件处理器等。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("WAF不能完全替代应用层的输入验证，因为WAF规则可能被____。", "绕过", "WAF是辅助防护，应用层输入验证是安全底线。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


# ==================== 网络题目生成 ====================

def generate_osi_layers():
    questions = []
    data = [
        ("OSI七层模型中，TCP属于哪一层？", '{"A":"应用层","B":"传输层","C":"网络层","D":"数据链路层"}', "B", "TCP是传输层协议，IP是网络层，HTTP/FTP是应用层。"),
        ("OSI七层模型中，路由器工作在哪一层？", '{"A":"应用层","B":"传输层","C":"网络层","D":"数据链路层"}', "C", "路由器工作在网络层，根据IP地址进行路由选择；交换机工作在数据链路层。"),
        ("以下哪个是传输层协议？", '{"A":"IP","B":"TCP","C":"ARP","D":"ICMP"}', "B", "TCP和UDP是传输层协议；IP是网络层；ARP是数据链路层；ICMP是网络层。"),
        ("HTTPS在OSI模型中属于哪一层？", '{"A":"应用层","B":"表示层","C":"会话层","D":"传输层"}', "A", "HTTPS是应用层协议，是HTTP over TLS/SSL。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("OSI七层：物理层、数据链路层、网络层、传输层、会话层、____层、应用层。", "表示", "OSI七层：物理、数据链路、网络、传输、会话、表示、应用。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_tcp_protocol():
    questions = []
    data = [
        ("TCP三次握手的作用是？", '{"A":"传输数据","B":"建立可靠连接，确认双方收发能力","C":"断开连接","D":"加密数据"}', "B", "三次握手：SYN、SYN-ACK、ACK，确认双方发送和接收能力正常。"),
        ("TCP四次挥手中，主动关闭方进入什么状态？", '{"A":"CLOSE","B":"LISTEN","C":"TIME_WAIT","D":"LAST_ACK"}', "C", "主动关闭方发送FIN后进入FIN_WAIT_1，收到ACK后进入TIME_WAIT，等待2MSL后关闭。"),
        ("TCP的滑动窗口用于？", '{"A":"建立连接","B":"流量控制","C":"拥塞控制","D":"差错控制"}', "B", "滑动窗口用于流量控制，接收方通过窗口大小告知发送方可发送的数据量。"),
        ("TCP的拥塞控制算法包括？", '{"A":"慢开始","B":"拥塞避免","C":"快重传","D":"以上都是"}', "D", "TCP拥塞控制：慢开始、拥塞避免、快重传、快恢复。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("TCP头部中，____标志位用于建立连接。", "SYN", "SYN标志位置1表示建立连接请求。"),
        ("TCP头部中，____标志位用于释放连接。", "FIN", "FIN标志位置1表示释放连接请求。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_udp_protocol():
    questions = []
    data = [
        ("UDP的特点是？", '{"A":"面向连接","B":"可靠传输","C":"无连接","D":"提供拥塞控制"}', "C", "UDP是无连接、不可靠、不提供拥塞控制的传输层协议。"),
        ("以下哪个应用适合使用UDP？", '{"A":"文件传输","B":"电子邮件","C":"视频直播","D":"Web浏览"}', "C", "视频直播、语音通话、DNS查询等实时性要求高的应用适合UDP，允许少量丢包。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("UDP的头部只有____个字节，比TCP头部简单得多。", "8", "UDP头部8字节：源端口、目的端口、长度、校验和。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_http_protocol():
    questions = []
    data = [
        ("HTTP是什么协议？", '{"A":"超文本传输协议","B":"安全超文本传输协议","C":"文件传输协议","D":"邮件传输协议"}', "A", "HTTP是超文本传输协议，HTTPS是HTTP over TLS。"),
        ("HTTP请求方法中，哪个用于获取资源？", '{"A":"GET","B":"POST","C":"PUT","D":"DELETE"}', "A", "GET获取、POST创建、PUT更新、DELETE删除。RESTful风格中各司其职。"),
        ("HTTP状态码404表示？", '{"A":"服务器内部错误","B":"资源未找到","C":"禁止访问","D":"重定向"}', "B", "404 Not Found表示请求的资源在服务器上不存在。"),
        ("Cookie和Session的主要区别是？", '{"A":"Cookie存储客户端，Session存储服务器","B":"Session比Cookie安全","C":"Cookie有大小限制","D":"以上都是"}', "D", "Cookie存储在客户端浏览器，Session存储在服务器；Session比Cookie安全；Cookie有4KB大小限制。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    multi_data = [
        ("以下哪些是HTTP 2.0的新特性？", '{"A":"多路复用","B":"服务器推送","C":"header压缩","D":"加密传输","E":"请求流水线"}', "A,B,C", "HTTP/2特性：多路复用、服务器推送、header压缩。HTTPS在HTTP/1.1就可以加密。"),
    ]
    for q, opt, a, an in multi_data:
        questions.append(q_multi(q, opt, a, an))

    fill_data = [
        ("HTTP的____方法只获取响应头，不获取实体内容。", "HEAD", "HEAD与GET类似但只返回响应头，用于获取资源元数据。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_https_tls():
    questions = []
    data = [
        ("HTTPS使用了什么协议进行加密？", '{"A":"SSL","B":"TLS","C":"SSH","D":"IPSec"}', "B", "HTTPS使用TLS（Transport Layer Security）进行加密，SSL是TLS的前身。"),
        ("TLS握手过程中，服务器发送什么给客户端？", '{"A":"对称密钥","B":"公钥证书","C":"私钥","D":"数字签名"}', "B", "TLS握手时服务器发送证书（包含公钥），客户端验证证书后生成对称密钥。"),
        ("数字证书的作用是？", '{"A":"加密数据","B":"验证服务器身份和公钥","C":"加速传输","D":"存储用户信息"}', "B", "数字证书由CA签发，包含服务器信息和公钥，用于验证服务器身份。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("对称加密用于____阶段，非对称加密用于____阶段。", "数据传输|密钥交换", "HTTPS混合加密：非对称加密交换对称密钥，对称加密传输数据。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_dns():
    questions = []
    data = [
        ("DNS的工作端口是？", '{"A":"25","B":"53","C":"80","D":"443"}', "B", "DNS使用53端口，TCP/UDP都有，通常查询用UDP，区域传输用TCP。"),
        ("DNS记录类型中，哪个用于邮件服务器？", '{"A":"A记录","B":"AAAA记录","C":"MX记录","D":"CNAME记录"}', "C", "A记录IPv4地址，AAAA记录IPv6地址，MX记录邮件服务器，CNAME别名。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("DNS的递归查询是指：本地域名服务器代替客户端向其他服务器查询，直到返回结果。____（填写是或否）", "是", "递归查询：本地域名服务器代为查询并返回最终结果；迭代查询：根域名服务器返回参考，客户端继续查询。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_routing():
    questions = []
    data = [
        ("路由器根据什么转发数据包？", '{"A":"MAC地址","B":"IP地址","C":"端口号","D":"域名"}', "B", "路由器根据目的IP地址查找路由表转发数据包；交换机根据MAC地址转发。"),
        ("默认路由（0.0.0.0/0）的作用是？", '{"A":"指定特定网络","B":"匹配所有找不到明确路由的数据包","C":"拒绝所有数据包","D":"本地回环"}', "B", "默认路由用于匹配所有没有明确路由的目标，是最后的求助路由。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    return questions


def generate_network_security():
    questions = []
    data = [
        ("防火墙的主要功能是？", '{"A":"加密数据","B":"根据规则过滤网络流量","C":"加速访问","D":"存储数据"}', "B", "防火墙根据预设规则过滤网络流量，控制进出流量，保护内部网络安全。"),
        ("VPN的作用是？", '{"A":"加速访问","B":"在公网上建立加密隧道","C":"提高网络带宽","D":"替代防火墙"}', "B", "VPN在公网上建立加密通道，使远程用户或分支机构安全访问内部网络。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    return questions


# ==================== 数据库题目生成 ====================

def generate_sql_basics():
    questions = []
    data = [
        ("SQL的SELECT语句用于？", '{"A":"插入数据","B":"查询数据","C":"更新数据","D":"删除数据"}', "B", "SELECT查询，INSERT插入，UPDATE更新，DELETE删除。"),
        ("以下哪个WHERE子句条件会返回所有记录？", '{"A":"WHERE 1=1","B":"WHERE id>0","C":"WHERE name IS NOT NULL","D":"WHERE 1=0"}', "A", "1=1永远为真，返回所有记录；1=0永远为假，返回零条记录。"),
        ("SQL中，如何计算字段的平均值？", '{"A":"SUM()","B":"AVG()","C":"COUNT()","D":"MAX()"}', "B", "SUM()求和、AVG()平均、COUNT()计数、MAX()最大、MIN()最小。"),
        ("GROUP BY的作用是？", '{"A":"排序结果","B":"过滤重复","C":"分组聚合计算","D":"限制返回行数"}', "C", "GROUP BY用于将结果按一或多列分组，配合聚合函数进行分组统计。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    multi_data = [
        ("以下哪些是SQL的聚合函数？", '{"A":"SUM()","B":"AVG()","C":"CONCAT()","D":"COUNT()","E":"UPPER()"}', "A,B,D", "聚合函数：SUM、AVG、COUNT、MAX、MIN；CONCAT和UPPER是字符串函数。"),
    ]
    for q, opt, a, an in multi_data:
        questions.append(q_multi(q, opt, a, an))

    fill_data = [
        ("SQL中，连接查询的关键字是____，子查询的关键字是____。", "JOIN|SELECT", "JOIN用于连接表，SELECT用于子查询。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_sql_advanced():
    questions = []
    data = [
        ("JOIN类型中，哪个返回左表全部记录和右表匹配记录？", '{"A":"INNER JOIN","B":"LEFT JOIN","C":"RIGHT JOIN","D":"FULL OUTER JOIN"}', "B", "INNER JOIN只返回匹配；LEFT JOIN返回左表全部；RIGHT JOIN返回右表全部；FULL OUTER返回全部。"),
        ("以下哪个用于处理NULL值？", '{"A":"IFNULL()","B":"COALESCE()","C":"NVL()","D":"以上都是"}', "D", "IFNULL(MySQL)、COALESCE(标准)、NVL(Oracle)都用于处理NULL值。"),
        ("事务的ACID特性中，D代表什么？", '{"A":"原子性","B":"一致性","C":"隔离性","D":"持久性"}', "D", "ACID：Atomicity原子性、Consistency一致性、Isolation隔离性、Durability持久性。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("SQL中，NULL与任何值比较的结果都是____。", "UNKNOWN", "NULL不等于任何值，NULL=1返回UNKNOWN，需要使用IS NULL/IS NOT NULL判断。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_mysql_index():
    questions = []
    data = [
        ("索引的主要作用是？", '{"A":"节省存储空间","B":"加快查询速度","C":"保证数据唯一性","D":"加快写入速度"}', "B", "索引加快查询速度，但会增加写入开销和存储空间。"),
        ("以下哪种情况适合创建索引？", '{"A":"字段经常被修改","B":"字段查询频率高","C":"数据量很小的表","D":"频繁进行INSERT操作的表"}', "B", "查询频率高、数据量大、很少修改的字段适合建索引。"),
        ("主键和唯一索引的区别是？", '{"A":"主键不允许NULL，唯一索引允许NULL","B":"没有区别","C":"主键自动创建唯一索引","D":"唯一索引不允许重复，主键允许"}', "A", "主键不允许NULL且只能有一个；唯一索引允许NULL且可以有多个。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("复合索引遵循____原则，最左前缀匹配。", "最左", "复合索引(a,b,c)可以用于a、ab、abc查询，不能用于b、c单独查询。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_mysql_transaction():
    questions = []
    data = [
        ("MySQL中，开启事务的命令是？", '{"A":"BEGIN","B":"START TRANSACTION","C":"BEGIN WORK","D":"以上都是"}', "D", "BEGIN、START TRANSACTION、BEGIN WORK都可以开启事务。"),
        ("事务隔离级别中，哪个可以防止脏读？", '{"A":"READ UNCOMMITTED","B":"READ COMMITTED","C":"REPEATABLE READ","D":"SERIALIZABLE"}', "B", "READ COMMITTED防止脏读；REPEATABLE READ防止脏读和不可重复读；SERIALIZABLE防止所有并发问题。"),
        ("MySQL默认的事务隔离级别是？", '{"A":"READ UNCOMMITTED","B":"READ COMMITTED","C":"REPEATABLE READ","D":"SERIALIZABLE"}', "C", "MySQL默认REPEATABLE READ（可重复读），使用MVCC减少锁竞争。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("事务的____性要求：一组操作要么全部成功，要么全部失败回滚。", "原子", "原子性：事务是最小执行单位，不可分割。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_mysql_engine():
    questions = []
    data = [
        ("InnoDB和MyISAM的主要区别是？", '{"A":"InnoDB支持事务，MyISAM不支持","B":"InnoDB支持外键，MyISAM支持","C":"InnoDB支持行级锁，MyISAM支持表级锁","D":"A和C"}', "D", "InnoDB支持事务和外键、行级锁；MyISAM不支持事务和外键、只支持表级锁，支持全文索引。"),
        ("以下哪个存储引擎支持事务？", '{"A":"MyISAM","B":"InnoDB","C":"MEMORY","D":"CSV"}', "B", "InnoDB支持事务；MyISAM不支持；MEMORY是内存表；CSV是CSV引擎。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    return questions


def generate_redis_data():
    questions = []
    data = [
        ("Redis支持哪些数据结构？", '{"A":"String","B":"List","C":"Set","D":"Hash","E":"以上都支持"}', "E", "Redis支持String、List、Set、ZSet、Hash、Geo、HyperLogLog等数据结构。"),
        ("Redis的STRING类型最大容量是？", '{"A":"1KB","B":"1MB","C":"512MB","D":"无限制"}', "C", "STRING类型最大512MB。"),
        ("Redis的Hash适用于什么场景？", '{"A":"存储对象","B":"排行榜","C":"消息队列","D":"分布式锁"}', "A", "Hash适合存储对象，field-value对应对象的属性-值。"),
        ("Redis的ZSet和Set的区别是？", '{"A":"ZSet有序，Set无序","B":"ZSet可以存储分数","C":"ZSet可以范围查询","D":"以上都正确"}', "D", "ZSet是有序集合，每个元素有分数，可用于排序和范围查询。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    multi_data = [
        ("以下哪些是Redis的持久化方式？", '{"A":"RDB快照","B":"AOF日志","C":"虚拟内存","D":"缓存过期"}', "A,B", "Redis持久化：RDB（定时快照）和AOF（追加日志）。"),
    ]
    for q, opt, a, an in multi_data:
        questions.append(q_multi(q, opt, a, an))

    fill_data = [
        ("Redis使用____实现分布式锁。", "SETNX", "SETNX（SET if Not eXists）配合EX过期时间可实现分布式锁。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_redis_app():
    questions = []
    data = [
        ("Redis缓存穿透的解决方案是？", '{"A":"布隆过滤器","B":"缓存空对象","C":"限流熔断","D":"以上都是"}', "D", "缓存穿透解决方案：布隆过滤器拦截、缓存空对象、限流熔断保护。"),
        ("Redis和数据库双写一致性的策略是？", '{"A":"先写缓存再写数据库","B":"先写数据库再写缓存","C":"延迟双删","D":"以上都不是"}', "C", "延迟双删：先删缓存，再更新数据库，延迟后再删缓存，解决并发问题。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    return questions


def generate_mongodb():
    questions = []
    data = [
        ("MongoDB是什么类型的数据库？", '{"A":"关系型","B":"文档型NoSQL","C":"键值型","D":"图形数据库"}', "B", "MongoDB是文档型NoSQL数据库，数据以BSON格式存储，类JSON。"),
        ("MongoDB中，集合对应关系型数据库的什么概念？", '{"A":"数据库","B":"表","C":"行","D":"列"}', "B", "MongoDB：数据库-集合-文档，对应MySQL：数据库-表-行。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    return questions


# ==================== 数据结构与算法题目生成 ====================

def generate_array_linkedlist():
    questions = []
    data = [
        ("数组的插入时间复杂度是？", '{"A":"O(1)","B":"O(n)","C":"O(log n)","D":"O(n^2)"}', "B", "数组插入需要移动元素，平均O(n)；链表插入只需要修改指针O(1)。"),
        ("链表和数组的主要区别是？", '{"A":"链表连续存储，数组离散存储","B":"链表查询慢增删快，数组查询快增删慢","C":"链表大小固定，数组大小可变","D":"以上都不对"}', "B", "数组连续存储支持下标O(1)访问，插入删除O(n)；链表离散存储，插入删除O(1)，查询O(n)。"),
        ("双向链表中，每个节点包含几个指针？", '{"A":"1","B":"2","C":"3","D":"4"}', "B", "双向链表节点包含前驱和后继两个指针；单向链表只有一个next指针。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("长度为n的数组，第一个元素下标是____，最后一个元素下标是____。", "0|n-1", "数组下标从0开始，最后一个元素下标为length-1。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_stack_queue():
    questions = []
    data = [
        ("栈的特点是？", '{"A":"FIFO","B":"LIFO","C":"随机访问","D":"排序"}', "B", "栈是后进先出（LIFO）；队列是先进先出（FIFO）。"),
        ("队列的特点是？", '{"A":"FIFO","B":"LIFO","C":"随机访问","D":"排序"}', "A", "队列是先进先出（FIFO）；栈是后进先出（LIFO）。"),
        ("堆（Heap）主要用于什么场景？", '{"A":"排序","B":"优先级队列","C":"缓存","D":"以上都是"}', "D", "堆常用于优先级队列、排序、Top K问题等。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("栈的push操作将元素添加到栈____，pop操作从栈____移除元素。", "顶|顶", "栈操作在栈顶进行：push入栈，pop出栈。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_binary_tree():
    questions = []
    data = [
        ("二叉树中，度为2的节点数和叶子节点数的关系是？", '{"A":"n0=n2","B":"n0=n2+1","C":"n0=n2-1","D":"n0=2*n2"}', "B", "二叉树性质：n0=n2+1，其中n0是叶子节点数，n2是度为2的节点数。"),
        ("完全二叉树的深度（高度）是？", '{"A":"log2(n)","B":"log2(n+1)","C":"n","D":"n/2"}', "B", "完全二叉树深度为log2(n+1)向下取整。"),
        ("二叉树的先序遍历顺序是？", '{"A":"左-右-根","B":"根-左-右","C":"左-根-右","D":"右-根-左"}', "B", "先序（根-左-右）、中序（左-根-右）、后序（左-右-根）。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("____遍历先访问根节点，再访问左右子树。", "先序或前序", "先序遍历（Pre-order）：根-左-右。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    # 编程题
    questions.append(q_programming(
        "给定二叉树根节点，判断该二叉树是否平衡。平衡定义为每个节点的左右子树高度差不超过1。要求时间复杂度O(n)。返回true表示平衡，false表示不平衡。",
        "",
        [
            {"input": "1,2,3,null,null,4,null,null,5", "expected_output": "true", "score_weight": 100, "sort_index": 0}
        ],
        "考察二叉树遍历和递归思想。",
        "class TreeNode {\n    int val;\n    TreeNode left, right;\n    TreeNode(int v) { val = v; }\n}\n\npublic class Solution {\n    public boolean isBalanced(TreeNode root) {\n        return checkHeight(root) != -1;\n    }\n    private int checkHeight(TreeNode node) {\n        // TODO: 返回节点高度，不平衡返回-1\n        return 0;\n    }\n}"
    ))

    return questions


def generate_graph():
    questions = []
    data = [
        ("图的两种存储方式是？", '{"A":"邻接矩阵和邻接表","B":"顺序存储和链式存储","C":"数组和链表","D":"稠密和稀疏"}', "A", "邻接矩阵适合稠密图，邻接表适合稀疏图。"),
        ("BFS（广度优先搜索）使用什么数据结构实现？", '{"A":"栈","B":"队列","C":"堆","D":"树"}', "B", "BFS使用队列实现，按层次遍历图或树；DFS使用栈或递归。"),
        ("Dijkstra算法用于解决什么问题？", '{"A":"最短路径","B":"最小生成树","C":"拓扑排序","D":"连通分量"}', "A", "Dijkstra求单源最短路径（无负权边）；Prim和Kruskal求最小生成树。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("图遍历的两种主要算法是____和____。", "BFS|DFS", "BFS广度优先搜索、DFS深度优先搜索。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_sorting():
    questions = []
    data = [
        ("快速排序的平均时间复杂度是？", '{"A":"O(n)","B":"O(n log n)","C":"O(n^2)","D":"O(log n)"}', "B", "快速排序平均O(n log n)，最坏O(n^2)（有序数组）。"),
        ("归并排序的空间复杂度是？", '{"A":"O(1)","B":"O(n)","C":"O(log n)","D":"O(n^2)"}', "B", "归并排序需要O(n)额外空间用于合并；快速排序是原地排序O(log n)递归栈空间。"),
        ("以下哪个排序算法是稳定的？", '{"A":"快速排序","B":"堆排序","C":"归并排序","D":"选择排序"}', "C", "稳定排序：归并排序、冒泡排序、插入排序。不稳定：快速排序、堆排序、选择排序。"),
        ("直接插入排序的时间复杂度是？", '{"A":"O(n)","B":"O(n log n)","C":"O(n^2)","D":"O(log n)"}', "C", "插入排序平均和最坏都是O(n^2)，最好O(n)（已有序）。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("堆排序的时间复杂度始终是____。", "O(n log n)", "堆排序无论最好还是最坏情况都是O(n log n)。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_searching():
    questions = []
    data = [
        ("二分查找的时间复杂度是？", '{"A":"O(1)","B":"O(n)","C":"O(log n)","D":"O(n log n)"}', "C", "二分查找每次将搜索范围缩小一半，时间复杂度O(log n)。"),
        ("二分查找的前提条件是？", '{"A":"数组有序","B":"数组无序","C":"数组长度大于100","D":"数组元素唯一"}', "A", "二分查找要求数组有序（升序或降序）。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("二分查找中，查找区间用____数据结构表示。", "两个变量（low和high）", "二分查找使用left和right两个指针表示查找区间。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_dp():
    questions = []
    data = [
        ("动态规划的核心思想是？", '{"A":"分而治之","B":"递归加缓存","C":"最优子结构 + 重叠子问题","D":"贪心选择"}', "C", "动态规划利用最优子结构和重叠子问题，自底向上递推求解。"),
        ("动态规划通常用什么方法实现？", '{"A":"递归（自顶向下）","B":"迭代（自底向上）","C":"分治","D":"回溯"}', "B", "动态规划通常用迭代实现，自底向上填表；也可用记忆化递归自顶向下。"),
        ("动态规划的状态转移方程通常包含？", '{"A":"边界条件","B":"递推关系","C":"最优子结构","D":"以上都是"}', "D", "状态转移方程包含：边界条件、递推关系、最优子结构的表达。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("动态规划与分治的区别在于动态规划处理的问题有____子问题。", "重叠", "分治问题相互独立，动态规划问题有重叠子问题可以复用。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    # 编程题
    questions.append(q_programming(
        "实现最长公共子序列（LCS）长度计算。给定两个字符串text1和text2，返回它们的最长公共子序列长度。",
        "",
        [
            {"input": "abcde\nace", "expected_output": "3", "score_weight": 50, "sort_index": 0},
            {"input": "abc\ndef", "expected_output": "0", "score_weight": 50, "sort_index": 1}
        ],
        "LCS是经典动态规划问题。",
        "public class LCS {\n    public int longestCommonSubsequence(String text1, String text2) {\n        // TODO: 使用动态规划实现\n        return 0;\n    }\n}"
    ))

    return questions


def generate_greedy():
    questions = []
    data = [
        ("贪心算法的特点是？", '{"A":"每步选择局部最优，期望得到全局最优","B":"穷举所有可能","C":"回溯搜索","D":"递归求解"}', "A", "贪心算法每步选择当前最优解，不考虑整体，常用于有贪心选择性质的问题。"),
        ("哈夫曼编码使用什么算法思想？", '{"A":"动态规划","B":"分治","C":"贪心","D":"回溯"}', "C", "哈夫曼编码使用贪心算法构建最优前缀码。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("贪心算法不能保证得到最优解的问题适合用____算法验证或求解。", "动态规划", "贪心算法需要证明每步选择能导致全局最优，否则需要使用动态规划。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


# ==================== 操作系统题目生成 ====================

def generate_process_thread():
    questions = []
    data = [
        ("进程和线程的主要区别是？", '{"A":"进程是资源分配单位，线程是CPU调度单位","B":"线程比进程更重量级","C":"进程共享资源，线程独立资源","D":"以上都不对"}', "A", "进程是资源分配单位（有独立地址空间），线程是CPU调度单位（共享进程资源）。"),
        ("创建线程的方式有几种？", '{"A":"1","B":"2","C":"3","D":"4"}', "C", "Java创建线程：继承Thread、实现Runnable、实现Callable（配合FutureTask）。"),
        ("线程的run()和start()的区别是？", '{"A":"run()执行任务，start()创建新线程","B":"没有区别","C":"start()执行任务，run()创建新线程","D":"start()是main线程执行"}', "A", "start()创建新线程并发执行run()；直接调用run()是在当前线程执行。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("____是指操作系统将CPU时间划分成多个时间片，轮流分配给多个任务执行。", "时间片轮转调度", "时间片轮转让多个任务共享CPU，造成同时执行的假象。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_memory():
    questions = []
    data = [
        ("虚拟内存的作用是？", '{"A":"增加内存容量","B":"扩大地址空间，提供进程间隔离","C":"加快内存访问","D":"减少内存消耗"}', "B", "虚拟内存扩大进程地址空间，提供进程间地址隔离，通过页表映射实现。"),
        ("页面置换算法LRU的作用是？", '{"A":"最近最少使用，淘汰最久未使用的页","B":"最久未使用，淘汰最近使用的页","C":"随机淘汰","D":"顺序淘汰"}', "A", "LRU（Least Recently Used）淘汰最久未使用的页面。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    return questions


def generate_file_system():
    questions = []
    data = [
        ("Linux文件权限中，rwx分别代表？", '{"A":"read, write, execute","B":"read, write, exit","C":"run, write, read","D":"read, exit, write"}', "A", "rwx分别代表读、写、执行权限。"),
        ("在Linux中，隐藏文件的命名规则是？", '{"A":"以-开头","B":"以.开头","C":"以~开头","D":"以_开头"}', "B", "Linux隐藏文件以.开头，如.bashrc。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("Linux命令中，____用于查看当前工作目录，____用于切换目录。", "pwd|cd", "pwd显示当前路径，cd切换目录。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_linux_commands():
    questions = []
    data = [
        ("以下哪个命令用于查看进程？", '{"A":"ls","B":"ps","C":"grep","D":"find"}', "B", "ls列文件、ps查进程、grep搜索、find找文件。"),
        ("以下哪个命令用于查找文件？", '{"A":"ls","B":"cd","C":"pwd","D":"find"}', "D", "ls列出目录、cd切换、pwd显示路径、find查找文件。"),
        ("以下哪个命令用于修改文件权限？", '{"A":"chown","B":"chmod","C":"chgrp","D":"chattr"}', "B", "chmod修改权限、chown修改所有者、chgrp修改所属组。"),
        ("以下哪个命令可以终止进程？", '{"A":"kill","B":"stop","C":"end","D":"terminate"}', "A", "kill向进程发送信号，默认SIGTERM终止进程；kill -9强制终止。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("Linux中，使用____命令查看网络连接状态。", "netstat或ss", "netstat/ss查看网络连接、端口、路由等。"),
        ("使用____命令在文件中搜索字符串。", "grep", "grep用于在文件或输出中搜索匹配模式的行。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_shell():
    questions = []
    data = [
        ("Shell脚本中，$#表示什么？", '{"A":"脚本名称","B":"参数个数","C":"第一个参数","D":"所有参数"}', "B", "$#参数个数、$@所有参数、$0脚本名、$1第一个参数。"),
        ("Shell脚本中，if语句的条件判断用哪个符号？", '{"A":"==","B":"=","C":"-eq","D":"B和C"}', "D", "Shell中数值比较用-eq；字符串用=或!=；文件测试用各种操作符。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    return questions


# ==================== 其他领域题目生成 ====================

def generate_html():
    questions = []
    data = [
        ("HTML是什么语言？", '{"A":"编程语言","B":"标记语言","C":"脚本语言","D":"样式语言"}', "B", "HTML是超文本标记语言，用于定义网页结构。"),
        ("以下哪个是HTML5的新标签？", '{"A":"<div>","B":"<span>","C":"<article>","D":"<font>"}', "C", "<article>是HTML5新增的语义化标签；<div>和<span>是原有标签；<font>已废弃。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    return questions


def generate_css_layout():
    questions = []
    data = [
        ("Flex布局中，justify-content用于设置？", '{"A":"交叉轴对齐","B":"主轴对齐","C":"项目放大缩小","D":"主轴方向"}', "B", "justify-content设置主轴对齐；align-items设置交叉轴对齐。"),
        ("Grid布局和Flex布局的主要区别是？", '{"A":"Grid是二维布局，Flex是一维布局","B":"Grid是一维，Flex是二维","C":"两者没有区别","D":"Grid不支持响应式"}', "A", "Flex适合单行/单列布局（一维）；Grid适合行列同时布局（二维）。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    return questions


def generate_js_basic():
    questions = []
    data = [
        ("JavaScript的数据类型包括？", '{"A":"number, string, boolean","B":"null, undefined","C":"object, symbol","D":"以上都是"}', "D", "JS基本类型：number、string、boolean、null、undefined、symbol；object是引用类型。"),
        ("var和let的主要区别是？", '{"A":"let有块级作用域，var没有","B":"var有块级作用域，let没有","C":"两者没有区别","D":"let性能更好"}', "A", "var是函数作用域，存在变量提升；let是块级作用域，不存在变量提升。"),
        ("==和===的区别是？", '{"A":"==比较值，===比较值和类型","B":"==比较类型，===比较值","C":"两者没有区别","D":"===性能更好"}', "A", "==会进行类型转换后再比较，===严格比较值和类型。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("JavaScript中，____表示空值，____表示未定义。", "null|undefined", "null是主动赋值的空对象，undefined是未赋值的默认状态。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_es6():
    questions = []
    data = [
        ("ES6中，箭头函数与传统函数的区别是？", '{"A":"箭头函数没有自己的this","B":"箭头函数不能用做构造函数","C":"箭头函数没有arguments","D":"以上都是"}', "D", "箭头函数：没有自己的this、不能用作构造函数、没有arguments、不能用作Generator。"),
        ("Promise的三种状态是？", '{"A":"pending, fulfilled, rejected","B":"wait, success, fail","C":"start, running, end","D":"pending, resolve, reject"}', "A", "Promise状态：pending（进行中）、fulfilled（已成功）、rejected（已失败）。"),
        ("let和const的区别是？", '{"A":"let可重新赋值，const不可","B":"const可重新赋值，let不可","C":"两者都可以重新赋值","D":"两者都不可重新赋值"}', "A", "let声明变量可重新赋值；const声明常量不可重新赋值（但对象属性可修改）。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("ES6的____语法用于声明模块的导入。", "import", "import用于导入模块，export用于导出模块。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_vue():
    questions = []
    data = [
        ("Vue的双向绑定原理是？", '{"A":"Object.defineProperty","B":"Proxy","C":"脏检查","D":"以上都有可能"}', "D", "Vue 2用Object.defineProperty，Vue 3用Proxy；也可以用directive实现。"),
        ("Vue中，v-for的key作用是？", '{"A":"提高性能","B":"标识列表项身份","C":"启用双向绑定","D":"样式控制"}', "B", "key帮助Vue追踪每个节点身份，用于高效的渲染和更新列表。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    return questions


def generate_react():
    questions = []
    data = [
        ("React中，useState的作用是？", '{"A":"创建副作用","B":"创建状态变量","C":"创建Refs","D":"创建上下文"}', "B", "useState用于在函数组件中创建状态变量和更新函数。"),
        ("React中，key的作用是？", '{"A":"唯一标识列表项","B":"提高性能","C":"启用更新","D":"以上都是"}', "A", "key帮助React识别哪些元素改变了，用于高效的列表渲染。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    return questions


def generate_gdpr():
    questions = []
    data = [
        ("GDPR的全称是？", '{"A":"General Data Protection Regulation","B":"Global Data Privacy Rules","C":"Government Data Protection Requirements","D":"General Digital Privacy Regulation"}', "A", "GDPR是欧盟通用数据保护条例。"),
        ("被遗忘权是指？", '{"A":"用户可以删除账户","B":"用户可以要求删除所有个人数据","C":"用户可以永久删除服务器数据","D":"用户可以拒绝提供数据"}', "B", "被遗忘权允许数据主体要求删除其个人数据。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("GDPR六大原则：合法性、____、数据最小化、准确性、存储限制、完整性机密性。", "目的限制", "目的限制要求数据用于明确声明的目的。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_privacy():
    questions = []
    data = [
        ("个人信息保护的原则是？", '{"A":"合法、正当、必要","B":"明示、同意","C":"保密、安全","D":"以上都是"}', "D", "个人信息保护需遵循：合法正当必要、明示同意、保密安全原则。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    return questions


def generate_evaluation():
    questions = []
    data = [
        ("等保测评的级别有几级？", '{"A":"3","B":"4","C":"5","D":"6"}', "C", "等保分为五级：一级自主保护、二级指导保护、三级监督保护、四级强制保护、五级专控保护。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    return questions


def generate_security_ops():
    questions = []
    data = [
        ("安全运维中，日志审计的作用是？", '{"A":"发现入侵痕迹","B":"追踪问题原因","C":"满足合规要求","D":"以上都是"}', "D", "日志审计用于发现入侵、追踪问题、满足合规。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    return questions


def generate_docker():
    questions = []
    data = [
        ("Docker容器和虚拟机的区别是？", '{"A":"容器共享宿主机内核，更轻量","B":"虚拟机包含完整操作系统","C":"两者各有优势","D":"以上都正确"}', "D", "容器共享内核更轻量（秒级启动），虚拟机隔离性更强但更重。"),
        ("Dockerfile中，COPY和ADD的区别是？", '{"A":"COPY只能复制本地文件，ADD支持URL和自动解压","B":"两者没有区别","C":"ADD只能复制本地文件","D":"COPY支持URL和自动解压"}', "A", "ADD支持URL复制和tar自动解压；COPY只支持本地文件，推荐使用COPY。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("Docker的核心组件：Docker daemon运行容器，Docker client接收命令，Docker image是____，Docker container是____。", "镜像模板|运行实例", "Image是只读模板，Container是Image的运行实例。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_k8s():
    questions = []
    data = [
        ("Kubernetes的核心概念包括？", '{"A":"Pod、Service、Deployment","B":"Pod、Node、Cluster","C":"Deployment、ReplicaSet、DaemonSet","D":"以上都是"}', "D", "K8s核心概念：Pod（最小单元）、Node（工作节点）、Cluster（集群）、Deployment（部署）等。"),
        ("K8s中，Service的作用是？", '{"A":"定义Pod的访问策略","B":"负载均衡","C":"服务发现","D":"以上都是"}', "D", "Service定义Pod访问策略，提供负载均衡和服务发现。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    return questions


def generate_cicd():
    questions = []
    data = [
        ("CI/CD的含义是？", '{"A":"持续集成/持续部署","B":"持续检查/持续开发","C":"代码集成/代码部署","D":"持续测试/持续交付"}', "A", "CI持续集成、CD持续部署/持续交付。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    return questions


def generate_git():
    questions = []
    data = [
        ("Git中，merge和rebase的区别是？", '{"A":"merge保留分支历史，rebase重写历史","B":"两者没有区别","C":"rebase保留历史，merge重写历史","D":"merge用于创建分支"}', "A", "merge保留完整历史，rebase将提交平移到目标分支产生线性历史。"),
        ("Git中，以下哪个命令用于创建分支？", '{"A":"git branch <name>","B":"git checkout -b <name>","C":"A和B都可以","D":"git create"}', "C", "git branch <name>创建，git checkout -b <name>创建并切换。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("Git中，暂存区命令是____，提交命令是____。", "git add|git commit", "git add暂存修改，git commit提交到本地仓库。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_cloudnative():
    questions = []
    data = [
        ("云原生的特征包括？", '{"A":"容器化","B":"微服务","C":"DevOps","D":"以上都是"}', "D", "云原生特征：容器化、微服务、DevOps、持续交付。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    return questions


def generate_testing_basics():
    questions = []
    data = [
        ("单元测试的主要目的是？", '{"A":"验证整个系统","B":"验证单个模块","C":"测试用户界面","D":"性能测试"}', "B", "单元测试验证单个模块或函数的功能。"),
        ("黑盒测试和白盒测试的区别是？", '{"A":"黑盒关注功能，白盒关注代码","B":"没有区别","C":"白盒不需要测试用例","D":"黑盒更彻底"}', "A", "黑盒测试从用户角度测试功能，白盒测试关注代码内部逻辑。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    fill_data = [
        ("测试金字塔：底层____（最多）、中层____、顶层E2E（最少）。", "单元测试|集成测试", "测试金字塔：单元测试最多、集成测试中层、E2E最少。"),
    ]
    for q, a, an in fill_data:
        questions.append(q_fill(q, a, an))

    return questions


def generate_unit_testing():
    questions = []
    data = [
        ("单元测试的标准不包括？", '{"A":"自动化","B":"独立可重复","C":"只测试一个单元","D":"需要访问数据库"}', "D", "单元测试应独立，不依赖外部资源如数据库。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    return questions


def generate_integration_testing():
    questions = []
    data = [
        ("集成测试的目的是？", '{"A":"验证模块间交互","B":"验证整个系统","C":"性能测试","D":"安全测试"}', "A", "集成测试验证多个模块/组件之间的交互是否正确。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    return questions


def generate_automation_testing():
    questions = []
    data = [
        ("自动化测试的优势是？", '{"A":"提高效率","B":"可重复","C":"覆盖率高","D":"以上都是"}', "D", "自动化测试：提高效率、可重复执行、覆盖率高、一致性好。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    return questions


def generate_symmetric_encryption():
    questions = []
    data = [
        ("对称加密的特点是？", '{"A":"加密解密使用相同密钥","B":"加密解密使用不同密钥","C":"速度慢","D":"密钥分配困难"}', "A", "对称加密使用相同密钥加解密；非对称使用公钥私钥。"),
        ("AES是哪种加密算法？", '{"A":"非对称","B":"对称","C":"哈希","D":"数字签名"}', "B", "AES（高级加密标准）是对称加密算法，替代DES。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    return questions


def generate_asymmetric_encryption():
    questions = []
    data = [
        ("非对称加密使用什么密钥加密？", '{"A":"私钥加密，公钥解密","B":"公钥加密，私钥解密","C":"两者都可以","D":"不需要密钥"}', "C", "非对称加密：公钥加密私钥解密，或私钥加密公钥解密（用于签名）。"),
        ("RSA算法的安全性基于？", '{"A":"大数分解的困难性","B":"离散对数","C":"哈希碰撞","D":"对称密钥长度"}', "A", "RSA基于大数分解的数学困难性。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    return questions


def generate_hash_function():
    questions = []
    data = [
        ("哈希函数的特性是？", '{"A":"单向性、确定性、雪崩效应","B":"可逆性","C":"唯一性","D":"加密性"}', "A", "哈希函数：单向性（不可逆）、确定性（相同输入相同输出）、雪崩效应（微小变化大影响）。"),
        ("MD5算法的输出长度是？", '{"A":"128位","B":"160位","C":"256位","D":"512位"}', "A", "MD5输出128位（16字节），SHA-1输出160位，SHA-256输出256位。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    return questions


def generate_digital_signature():
    questions = []
    data = [
        ("数字签名的作用是？", '{"A":"加密数据","B":"验证完整性和发送者身份","C":"加速传输","D":"存储数据"}', "B", "数字签名用于验证消息完整性、发送者身份、防止抵赖。"),
        ("数字签名使用什么密钥签名？", '{"A":"公钥","B":"私钥","C":"对称密钥","D":"会话密钥"}', "B", "发送者使用私钥签名，接收者使用公钥验证。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    return questions


def generate_pki():
    questions = []
    data = [
        ("PKI体系的核心是？", '{"A":"数字证书","B":"对称加密","C":"哈希算法","D":"生物识别"}', "A", "PKI（公钥基础设施）以数字证书为核心，实现身份认证和密钥管理。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    return questions


def generate_architecture():
    questions = []
    data = [
        ("MVC架构中，M、V、C分别代表？", '{"A":"Model, View, Controller","B":"Model, View, Config","C":"Module, View, Controller","D":"Model, Visual, Controller"}', "A", "MVC：Model模型处理数据、View视图展示、Controller控制器协调。"),
        ("微服务架构的主要优势是？", '{"A":"独立部署","B":"技术多样性","C":"容错隔离","D":"以上都是"}', "D", "微服务优势：独立部署、技术多样性、容错隔离、团队自治。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    return questions


def generate_system_design():
    questions = []
    data = [
        ("系统设计中，如何提高并发能力？", '{"A":"负载均衡","B":"缓存","C":"异步处理","D":"以上都是"}', "D", "提高并发：负载均衡、缓存、异步处理、数据库读写分离、分库分表。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    return questions


def generate_performance():
    questions = []
    data = [
        ("数据库优化的手段包括？", '{"A":"建立索引","B":"优化查询","C":"分库分表","D":"以上都是"}', "D", "数据库优化：索引、查询优化、分库分表、读写分离、缓存。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    return questions


def generate_microservices():
    questions = []
    data = [
        ("服务注册中心的作用是？", '{"A":"存储配置","B":"服务发现","C":"负载均衡","D":"服务监控"}', "B", "服务注册中心提供服务发现、服务注册、健康检查。"),
        ("API网关的作用是？", '{"A":"统一入口、路由转发、安全认证","B":"负载均衡","C":"服务发现","D":"数据存储"}', "A", "API网关：统一入口、路由转发、安全认证、限流熔断。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    return questions


def generate_distributed():
    questions = []
    data = [
        ("分布式系统中，一致性级别包括？", '{"A":"强一致性","B":"最终一致性","C":"弱一致性","D":"以上都是"}', "D", "一致性级别：强一致性、最终一致性、弱一致性。CAP定理关注可用性和一致性的权衡。"),
    ]
    for q, opt, a, an in data:
        questions.append(q_single(q, opt, a, an))

    return questions


# ==================== 主函数 ====================

def main():
    print("开始生成2000道题目...")

    all_questions = generate_varied_questions()
    print(f"生成了 {len(all_questions)} 道题目")

    # 统计类型
    type_counts = {1: 0, 2: 0, 3: 0, 5: 0, 6: 0}
    for q in all_questions:
        t = q["type"]
        type_counts[t] = type_counts.get(t, 0) + 1

    print("\n题目类型分布：")
    type_names = {1: "填空", 2: "单选", 3: "多选", 5: "简答", 6: "编程"}
    for t, c in type_counts.items():
        print(f"  {type_names.get(t, t)}: {c} 道")

    # 生成SQL
    sql_lines = ["USE labex;", ""]

    for i, q in enumerate(all_questions):
        qid = i + 1
        question_text = q["question"].replace('"', '\\"').replace("'", "\\'")
        answer = q.get("answer", "").replace('"', '\\"').replace("'", "\\'")
        options = q.get("options", "").replace('"', '\\"').replace("'", "\\'")
        analysis = q.get("analysis", "").replace('"', '\\"').replace("'", "\\'")
        qtype = q.get("type", 2)
        score = q.get("score", 10)
        is_prog = q.get("is_programming", 0)
        lang = q.get("language", "")
        template = q.get("template_code", "").replace('"', '\\"').replace("'", "\\'")
        io_mode = q.get("io_mode", "")

        if is_prog:
            sql = f"""INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('{question_text}', '{answer}', {qtype}, {score}, '{options}', '{analysis}', {is_prog}, '{lang}', '{template}', '{io_mode}', 2, 1);"""
        else:
            sql = f"""INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('{question_text}', '{answer}', {qtype}, {score}, '{options}', '{analysis}', 2, 1);"""

        sql_lines.append(sql)

        # 添加测试用例
        if "test_cases" in q and q["test_cases"]:
            for j, tc in enumerate(q["test_cases"]):
                tc_input = tc.get("input", "").replace("'", "\\'")
                tc_output = tc.get("expected_output", "").replace("'", "\\'")
                tc_weight = tc.get("score_weight", 10)
                tc_index = tc.get("sort_index", j)

                test_sql = f"""INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES ({qid}, '{tc_input}', '{tc_output}', {tc_weight}, {tc_index});"""
                sql_lines.append(test_sql)

    sql_content = "\n".join(sql_lines)

    with open("2000_questions.sql", "w", encoding="utf-8") as f:
        f.write(sql_content)

    print(f"\nSQL已保存到 2000_questions.sql")
    print(f"编程题数量：{sum(1 for q in all_questions if q.get('is_programming') == 1)}")

    return all_questions


if __name__ == "__main__":
    main()