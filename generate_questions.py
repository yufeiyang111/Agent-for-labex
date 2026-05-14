#!/usr/bin/env python3
"""
生成2000道题库题目，插入到labex数据库
覆盖：单选、多选、填空、编程四种类型
编程题包含测试点
"""

import random
import hashlib

# ============ 题目内容生成函数 ============

def gen_java_design_pattern_questions():
    """Java设计模式题目"""
    questions = []

    # 单选
    questions.append({
        "question": "以下哪个不是GoF设计模式中的创建型模式？",
        "answer": "D",
        "type": 2,
        "options": '{"A":"单例模式","B":"工厂方法模式","C":"抽象工厂模式","D":"策略模式"}',
        "analysis": "GoF设计模式分为三类：创建型5种（单例、工厂方法、抽象工厂、建造者、原型），结构型7种，行为型11种。策略模式属于行为型。"
    })

    questions.append({
        "question": "在单例模式中，饿汉式和懒汉式的主要区别是什么？",
        "answer": "B",
        "type": 2,
        "options": '{"A":"线程安全性不同","B":"实例创建时机不同，饿汉式在类加载时创建，懒汉式在首次使用时创建","C":"实现复杂度不同","D":"是否支持延迟加载不同"}',
        "analysis": "饿汉式在类加载时就创建实例，懒汉式在首次调用getInstance时才创建。懒汉式需要双重检查锁定来保证线程安全。"
    })

    questions.append({
        "question": "以下哪种实现单例的方式可以防止反射攻击？",
        "answer": "C",
        "type": 2,
        "options": '{"A":"饿汉式","B":"懒汉式（双重检查）","C":"枚举方式","D":"静态内部类方式"}',
        "analysis": "枚举方式是最安全的单例实现，Java枚举类的构造函数只能被调用一次，且无法通过反射创建实例。"
    })

    questions.append({
        "question": "工厂方法模式与抽象工厂模式的主要区别是？",
        "answer": "A",
        "type": 2,
        "options": '{"A":"工厂方法针对单个产品等级结构，抽象工厂针对多个产品等级结构","B":"工厂方法使用静态工厂，抽象工厂使用实例工厂","C":"工厂方法返回具体产品，抽象工厂返回抽象产品","D":"没有区别"}',
        "analysis": "工厂方法模式每个工厂创建一个产品，抽象工厂模式每个工厂创建一族产品。"
    })

    questions.append({
        "question": "建造者模式（Builder Pattern）的主要目的是？",
        "answer": "C",
        "type": 2,
        "options": '{"A":"提供创建对象的接口","B":"将复杂对象的构建与表示分离","C":"将一个复杂对象的构建与它的表示分离，使得同样的构建过程可以创建不同的表示","D":"定义一个对象的组成结构"}',
        "analysis": "建造者模式的主要目的是将一个复杂对象的构建与它的表示分离，使得同样的构建过程可以创建不同的表示。"
    })

    questions.append({
        "question": "在策略模式中，以下哪个描述是正确的？",
        "answer": "B",
        "type": 2,
        "options": '{"A":"策略模式定义了一系列算法，并封装每个算法，使它们可以互相替换","B":"策略模式定义了一系列算法，并封装每个算法，使它们可以互相替换","C":"策略模式将对象组成树形结构","D":"策略模式提供一种方法访问属于集合中的元素"}',
        "analysis": "策略模式（Strategy Pattern）定义了一系列算法，并封装每个算法，使它们可以互相替换。"
    })

    questions.append({
        "question": "观察者模式中，Subject和Observer之间的关系是？",
        "answer": "D",
        "type": 2,
        "options": '{"A":"Subject包含Observer","B":"Observer包含Subject","C":"两者没有任何关系","D":"Subject维护Observer列表，Observer注册到Subject"}',
        "analysis": "观察者模式中，Subject维护一个Observer列表，Observer向Subject注册，当Subject状态改变时通知所有Observer。"
    })

    questions.append({
        "question": "装饰器模式（Decorator Pattern）用于？",
        "answer": "A",
        "type": 2,
        "options": '{"A":"动态地给对象添加一些额外的职责","B":"将抽象部分与它的实现部分分离","C":"将对象组合成树形结构","D":"定义对象的内部组成结构"}',
        "analysis": "装饰器模式动态地给对象添加一些额外的职责，就增加功能来说，装饰器比继承更灵活。"
    })

    questions.append({
        "question": "模板方法模式（Template Method Pattern）的核心是？",
        "answer": "C",
        "type": 2,
        "options": '{"A":"将对象组合成树形结构","B":"定义算法骨架，将某些步骤延迟到子类","C":"定义一个算法的骨架，将一些步骤延迟到子类中实现","D":"将抽象部分与实现部分分离"}',
        "analysis": "模板方法模式定义一个操作中的算法骨架，将一些步骤延迟到子类中实现。"
    })

    questions.append({
        "question": "责任链模式（Chain of Responsibility）适用于以下哪种场景？",
        "answer": "B",
        "type": 2,
        "options": '{"A":"需要动态组合一组对象","B":"有多个对象可以处理一个请求，哪个对象处理由运行时刻决定","C":"需要将对象封装成内部状态","D":"需要定义对象的组成结构"}',
        "analysis": "责任链模式适用于有多个对象可以处理一个请求的场景，哪个对象处理由运行时刻决定。"
    })

    # 多选
    questions.append({
        "question": "以下哪些是SOLID设计原则的内容？",
        "answer": "A,B,C,D",
        "type": 3,
        "options": '{"A":"单一职责原则（SRP）","B":"开闭原则（OCP）","C":"里氏替换原则（LSP）","D":"接口隔离原则（ISP）","E":"依赖倒置原则（DIP）"}',
        "analysis": "SOLID原则包括：单一职责、开闭、里氏替换、接口隔离、依赖倒置五个原则。"
    })

    questions.append({
        "question": "以下哪些方式可以实现线程安全的单例模式？",
        "answer": "A,B,C",
        "type": 3,
        "options": '{"A":"饿汉式（静态常量）","B":"懒汉式（双重检查锁定 + volatile）","C":"静态内部类方式","D":"使用双重检查但不使用volatile","E":"在getInstance方法前加synchronized"}',
        "analysis": "饿汉式、懒汉式双重检查+volatile、静态内部类都可以实现线程安全的单例。双重检查不使用volatile会有指令重排序问题。"
    })

    questions.append({
        "question": "以下哪些是创建型设计模式？",
        "answer": "A,B,D",
        "type": 3,
        "options": '{"A":"单例模式（Singleton）","B":"工厂方法模式（Factory Method）","C":"策略模式（Strategy）","D":"建造者模式（Builder）","E":"装饰器模式（Decorator）"}',
        "analysis": "创建型5种：单例、工厂方法、抽象工厂、建造者、原型。策略和装饰器属于行为型和结构型。"
    })

    # 填空
    questions.append({
        "question": "GoF设计模式共有____种，分为创建型、____型和行为型三大类。",
        "answer": "23|结构",
        "type": 1,
        "analysis": "GoF设计模式共23种：创建型5种、结构型7种、行为型11种。"
    })

    questions.append({
        "question": "单例模式中，双重检查锁定（Double-Checked Locking）需要使用____关键字防止指令重排序。",
        "answer": "volatile",
        "type": 1,
        "analysis": "volatile可以防止指令重排序，保证多线程环境下的可见性。"
    })

    questions.append({
        "question": "在工厂方法模式中，抽象产品由____声明接口，具体产品由____实现。",
        "answer": "抽象工厂|具体工厂",
        "type": 1,
        "analysis": "工厂方法模式中，抽象工厂声明创建产品的接口，具体工厂实现创建具体产品的操作。"
    })

    questions.append({
        "question": "策略模式的核心是定义____，将不变的部分封装在____中。",
        "answer": "算法族|抽象上下文",
        "type": 1,
        "analysis": "策略模式将不变的部分封装在抽象上下文中，将变化的部分封装为具体策略。"
    })

    questions.append({
        "question": "观察者模式又被称为____模式，定义了对象之间的一对多依赖关系。",
        "answer": "发布-订阅",
        "type": 1,
        "analysis": "观察者模式又称为发布-订阅模式，当一个对象状态改变时，所有依赖它的对象都会收到通知。"
    })

    # 编程题
    questions.append({
        "question": "请使用Java实现一个线程安全的单例模式（懒汉式，双重检查锁定）。要求：\n1. 类名为Singleton\n2. 使用volatile关键字保证可见性\n3. 使用双重检查锁定机制\n4. 提供静态方法getInstance()返回单例实例",
        "answer": "",
        "type": 6,
        "analysis": "考察对单例模式双重检查锁定的理解，包括volatile的作用和synchronized的使用。",
        "is_programming": 1,
        "language": "java",
        "template_code": "public class Singleton {\n    // TODO: 实现线程安全的懒汉式单例\n}",
        "io_mode": "standard",
        "test_cases": [
            {"input": "", "expected_output": "true\ntrue", "score_weight": 50, "sort_index": 0},
            {"input": "", "expected_output": "", "score_weight": 50, "sort_index": 1}
        ]
    })

    questions.append({
        "question": "请使用Java实现一个简单工厂模式，根据type参数返回不同的Payment实现：\n1. 当type为\"alipay\"时返回Alipay对象\n2. 当type为\"wechat\"时返回WechatPay对象\n3. 当type为\"unionpay\"时返回UnionPay对象\n4. 如果type不合法，抛出IllegalArgumentException\n\n要求：\n- 定义Payment接口，包含pay(double amount)方法\n- 定义Alipay、WechatPay、UnionPay三个实现类\n- 定义PaymentFactory工厂类提供createPayment方法",
        "answer": "",
        "type": 6,
        "analysis": "考察对工厂模式的理解，包括接口定义和工厂类的实现。",
        "is_programming": 1,
        "language": "java",
        "template_code": "// 请实现以下接口和类\ninterface Payment {\n    void pay(double amount);\n}\n\nclass Alipay implements Payment {\n    @Override\n    public void pay(double amount) {\n        System.out.println(\"Alipay pay: \" + amount);\n    }\n}\n\n// TODO: 实现WechatPay、UnionPay和PaymentFactory",
        "io_mode": "standard",
        "test_cases": [
            {"input": "alipay\n100", "expected_output": "Alipay pay: 100.0", "score_weight": 30, "sort_index": 0},
            {"input": "wechat\n200", "expected_output": "WechatPay pay: 200.0", "score_weight": 30, "sort_index": 1},
            {"input": "unionpay\n300", "expected_output": "UnionPay pay: 300.0", "score_weight": 20, "sort_index": 2},
            {"input": "bitcoin\n100", "expected_output": "", "score_weight": 20, "sort_index": 3}
        ]
    })

    return questions


def gen_java_reflection_questions():
    """Java注解与反射题目"""
    questions = []

    # 单选
    questions.append({
        "question": "以下哪个注解用于表示方法重写父类方法？",
        "answer": "A",
        "type": 2,
        "options": '{"A":"@Override","B":"@Deprecated","C":"@SuppressWarnings","D":"@FunctionalInterface"}',
        "analysis": "@Override用于标识方法重写了父类或接口中的方法，编译器会进行检查。"
    })

    questions.append({
        "question": "@Retention注解的RUNTIME值表示什么？",
        "answer": "C",
        "type": 2,
        "options": '{"A":"注解只在源码中存在，编译时丢弃","B":"注解在字节码中存在，但运行时不存在","C":"注解在运行时可以通过反射读取","D":"注解会被包含在JavaDoc中"}',
        "analysis": "@Retention的RUNTIME值表示注解保留到运行期，可通过反射读取。"
    })

    questions.append({
        "question": "获取Class对象的三种方式中，哪种是错误的？",
        "answer": "D",
        "type": 2,
        "options": '{"A":"Class.forName(\"com.example.User\")","B":"User.class","C":"user.getClass()","D":"new User().class"}',
        "analysis": "new User().class不是合法的Java语法，获取Class对象只有三种方式：forName、.class、getClass()。"
    })

    questions.append({
        "question": "通过反射访问私有属性时，需要使用什么方法？",
        "answer": "B",
        "type": 2,
        "options": '{"A":"getField()","B":"getDeclaredField() + setAccessible(true)","C":"getFields()","D":"getDeclaredFields()"}',
        "analysis": "getDeclaredField()可以获取声明的所有属性（包括私有），setAccessible(true)可以允许访问私有成员。"
    })

    questions.append({
        "question": "JDK动态代理中，需要实现哪个接口？",
        "answer": "C",
        "type": 2,
        "options": '{"A":"Proxy","B":"InvocationHandler","C":"InvocationHandler","D":"ClassLoader"}',
        "analysis": "JDK动态代理需要实现InvocationHandler接口，并重写invoke方法。"
    })

    questions.append({
        "question": "以下哪个注解用于指定注解的作用目标？",
        "answer": "B",
        "type": 2,
        "options": '{"A":"@Retention","B":"@Target","C":"@Documented","D":"@Inherited"}',
        "analysis": "@Target用于指定注解可以作用的目标，如TYPE、FIELD、METHOD等。"
    })

    questions.append({
        "question": "关于泛型类型擦除，以下说法正确的是？",
        "answer": "A",
        "type": 2,
        "options": '{"A":"无界类型参数<T>在擦除后替换为Object","B":"List<String>和List<Integer>在运行期是不同的类型","C":"泛型类型信息在运行期不会丢失","D":"类型擦除后，所有泛型都会变成Object数组"}',
        "analysis": "类型擦除后，无界<T>替换为Object，List<String>和List<Integer>运行期都是List。"
    })

    questions.append({
        "question": "在注解中，定义元素的方法返回类型可以是以下哪些？",
        "answer": "D",
        "type": 2,
        "options": '{"A":"String","B":"int","C":"Class<?>","D":"以上都可以"}',
        "analysis": "注解元素可以返回String、int、Class、枚举、注解、以上类型的数组等。"
    })

    # 多选
    questions.append({
        "question": "以下哪些是元注解的作用？",
        "answer": "A,B,C,D",
        "type": 3,
        "options": '{"A":"@Retention：指定注解的保留策略","B":"@Target：指定注解的作用目标","C":"@Documented：指定注解包含在JavaDoc中","D":"@Inherited：指定子类继承父类的注解","E":"@Override：指定方法是重写方法"}',
        "analysis": "@Override不是元注解，它用于标识方法重写。元注解有@Retention、@Target、@Documented、@Inherited、@Repeatable。"
    })

    questions.append({
        "question": "以下哪些方式可以获取Class对象？",
        "answer": "A,B,C",
        "type": 3,
        "options": '{"A":"Class.forName(\"com.example.User\")","B":"User.class","C":"user.getClass()","D":"Class.getInstance()","E":"new User().getClass()"}',
        "analysis": "获取Class对象有三种方式：forName()、.class、getClass()。getInstance()不是获取Class的方法。"
    })

    # 填空
    questions.append({
        "question": "反射机制中，通过____方法可以获取类的完整类名（包括包名）。",
        "answer": "getName()",
        "type": 1,
        "analysis": "clazz.getName()返回类的全限定名，如com.example.User。"
    })

    questions.append({
        "question": "在JDK动态代理中，____接口的invoke方法用于定义代理的行为。",
        "answer": "InvocationHandler",
        "type": 1,
        "analysis": "InvocationHandler是JDK动态代理的核心接口，invoke方法定义代理对象的调用行为。"
    })

    questions.append({
        "question": "泛型擦除后，有界类型参数<T extends Number>会被替换为____。",
        "answer": "Number",
        "type": 1,
        "analysis": "有界类型参数擦除后替换为其上界，无界<T>替换为Object。"
    })

    # 编程题
    questions.append({
        "question": "请使用Java反射机制实现一个简单的注解校验器：\n\n1. 定义一个@NotNull注解，用于标记不能为null的字段\n2. 定义一个@StringLength注解，包含min()和max()两个元素，用于校验字符串长度\n3. 实现Validator类的validate方法，接收一个Object对象，返回校验失败的错误信息列表\n\n示例：\nclass User {\n    @NotNull(message = \"用户名不能为空\")\n    private String username;\n\n    @StringLength(min = 6, max = 20, message = \"密码长度必须在6-20之间\")\n    private String password;\n}\n\nValidator.validate(user) 应返回错误信息列表。",
        "answer": "",
        "type": 6,
        "analysis": "综合考察注解定义和反射结合使用的能力。",
        "is_programming": 1,
        "language": "java",
        "template_code": "import java.lang.annotation.*;\nimport java.lang.reflect.*;\nimport java.util.*;\n\n// TODO: 定义@NotNull和@StringLength注解\n// TODO: 实现Validator类",
        "io_mode": "standard",
        "test_cases": [
            {"input": "admin\n123456", "expected_output": "[]", "score_weight": 40, "sort_index": 0},
            {"input": "\n123456", "expected_output": "[用户名不能为空]", "score_weight": 30, "sort_index": 1},
            {"input": "admin\n123", "expected_output": "[密码长度必须在6-20之间]", "score_weight": 30, "sort_index": 2}
        ]
    })

    return questions


def gen_java_generics_questions():
    """Java泛型题目"""
    questions = []

    # 单选
    questions.append({
        "question": "以下哪个选项正确声明了一个只接受Number及其子类的泛型参数？",
        "answer": "B",
        "type": 2,
        "options": '{"A":"<T>","B":"<? extends Number>","C":"<? super Number>","D":"<Number>"}',
        "analysis": "? extends Number表示上界通配符，接受Number及其子类。"
    })

    questions.append({
        "question": "关于PECS原则（Producer Extends, Consumer Super），以下说法正确的是？",
        "answer": "C",
        "type": 2,
        "options": '{"A":"生产者用super，消费者用extends","B":"生产者和消费者都用extends","C":"生产者用extends（需要读取数据），消费者用super（需要写入数据）","D":"PECS原则用于限制泛型的类型参数数量"}',
        "analysis": "PECS原则：Producer Extends（生产数据用extends），Consumer Super（消费数据用super）。"
    })

    questions.append({
        "question": "以下哪个选项正确创建了一个整数类型的泛型数组？",
        "answer": "D",
        "type": 2,
        "options": '{"A":"new T[10]","B":"new Integer[T]","C":"(T[]) new Integer[10]","D":"(T[]) new Object[10]，其中T是无界类型参数"}',
        "analysis": "Java不能直接创建泛型数组，但可以创建Object数组然后强制转换。无界<T>擦除后是Object。"
    })

    questions.append({
        "question": "静态成员能否使用类的泛型参数？",
        "answer": "A",
        "type": 2,
        "options": '{"A":"不能，静态成员属于类而不是实例","B":"能，静态方法可以使用类的泛型","C":"能，但只能用于静态属性","D":"能，静态初始化块可以使用泛型参数"}',
        "analysis": "静态成员属于类而不属于实例，不能使用类的泛型参数，但可以有自己的泛型参数。"
    })

    questions.append({
        "question": "List<? extends Number>可以添加以下哪个类型的元素？",
        "answer": "D",
        "type": 2,
        "options": '{"A":"Integer","B":"Double","C":"Object","D":"以上都不行，只能添加null"}',
        "analysis": "? extends Number只允许读取，不允许写入（除了null），因为编译器不知道具体是Number的哪个子类。"
    })

    # 多选
    questions.append({
        "question": "以下哪些是泛型擦除后替换规则？",
        "answer": "A,B",
        "type": 3,
        "options": '{"A":"无界类型参数<T>替换为Object","B":"有界类型参数<T extends SomeClass>替换为SomeClass","C":"有界类型参数<T extends SomeClass>替换为Object","D":"所有泛型都替换为Object"}',
        "analysis": "无界<T>擦除为Object，有界<T extends X>擦除为X。"
    })

    questions.append({
        "question": "以下哪些情况会导致泛型编译错误？",
        "answer": "A,B,D",
        "type": 3,
        "options": '{"A":"不能实例化类型参数：new T()","B":"不能创建泛型数组：new T[10]","C":"不能使用instanceof检查泛型类型","D":"不能使用基本类型作为类型参数：List<int>"}',
        "analysis": "泛型限制包括：不能实例化类型参数、不能创建泛型数组、不能使用基本类型、不能instanceof泛型类型。"
    })

    # 填空
    questions.append({
        "question": "泛型的上界通配符是____，下界通配符是____。",
        "answer": "? extends|? super",
        "type": 1,
        "analysis": "? extends T表示上界，? super T表示下界。"
    })

    questions.append({
        "question": "在JDK 8之后，注解可以重复使用，需要使用____注解标记容器注解。",
        "answer": "@Repeatable",
        "type": 1,
        "analysis": "@Repeatable用于标记可重复注解的容器注解。"
    })

    # 编程题
    questions.append({
        "question": "请实现一个泛型方法reverse，接收一个List<T>参数，返回逆序后的新List。\n\n要求：\n1. 方法签名：public static <T> List<T> reverse(List<T> list)\n2. 不能修改原List\n3. 返回一个新的逆序List\n\n示例：\nreverse([1, 2, 3, 4, 5]) -> [5, 4, 3, 2, 1]\nreverse([a, b, c]) -> [c, b, a]",
        "answer": "",
        "type": 6,
        "analysis": "考察对泛型方法和集合操作的掌握。",
        "is_programming": 1,
        "language": "java",
        "template_code": "import java.util.*;\n\npublic class GenericUtils {\n    public static <T> List<T> reverse(List<T> list) {\n        // TODO: 实现逆序方法\n        return null;\n    }\n\n    public static void main(String[] args) {\n        List<Integer> intList = Arrays.asList(1, 2, 3, 4, 5);\n        System.out.println(reverse(intList));\n\n        List<String> strList = Arrays.asList(\"a\", \"b\", \"c\");\n        System.out.println(reverse(strList));\n    }\n}",
        "io_mode": "standard",
        "test_cases": [
            {"input": "", "expected_output": "[5, 4, 3, 2, 1]\n[c, b, a]", "score_weight": 100, "sort_index": 0}
        ]
    })

    return questions


def gen_xss_questions():
    """XSS跨站脚本攻击题目"""
    questions = []

    # 单选
    questions.append({
        "question": "XSS攻击的全称是什么？",
        "answer": "B",
        "type": 2,
        "options": '{"A":"Cross-Site Request","B":"Cross-Site Scripting","C":"Cross-Server Script","D":"Client-Side Scripting"}',
        "analysis": "XSS是Cross-Site Scripting（跨站脚本攻击）的缩写。"
    })

    questions.append({
        "question": "存储型XSS和反射型XSS的主要区别是？",
        "answer": "C",
        "type": 2,
        "options": '{"A":"存储型XSS不需要用户交互，反射型需要","B":"反射型XSS将恶意脚本存储在服务器上","C":"存储型XSS的恶意脚本被永久存储在目标服务器上","D":"反射型XSS的恶意脚本不经过服务器"}',
        "analysis": "存储型XSS的恶意代码被永久存储在服务器端（数据库、评论等），反射型是作为请求参数被服务器反射回页面。"
    })

    questions.append({
        "question": "以下哪个HTTP头可以用于防护XSS攻击？",
        "answer": "D",
        "type": 2,
        "options": '{"A":"X-Frame-Options","B":"X-Content-Type-Options","C":"Strict-Transport-Security","D":"Content-Security-Policy"}',
        "analysis": "Content-Security-Policy（CSP）可以限制页面中脚本的来源，有效防护XSS攻击。"
    })

    questions.append({
        "question": "以下哪个标记可以防护Cookie被JavaScript读取？",
        "answer": "B",
        "type": 2,
        "options": '{"A":"Secure","B":"HttpOnly","C":"SameSite","D":"Path"}',
        "analysis": "HttpOnly标记可以防止JavaScript访问Cookie，有效防止XSS窃取Cookie。"
    })

    questions.append({
        "question": "DOM型XSS与传统XSS的主要区别是？",
        "answer": "A",
        "type": 2,
        "options": '{"A":"DOM型XSS完全在客户端执行，不涉及服务器","B":"DOM型XSS需要服务器存储恶意脚本","C":"DOM型XSS比其他类型更危险","D":"DOM型XSS只能通过反射型触发"}',
        "analysis": "DOM型XSS不涉及服务器处理，纯客户端漏洞，通过操作DOM对象执行恶意脚本。"
    })

    # 多选
    questions.append({
        "question": "XSS攻击可能造成哪些危害？",
        "answer": "A,B,C,D",
        "type": 3,
        "options": '{"A":"窃取用户Cookie/Session","B":"键盘记录，监听用户输入","C":"修改页面内容，进行钓鱼攻击","D":"植入恶意软件","E":"直接删除服务器上的数据"}',
        "analysis": "XSS是客户端攻击，主要危害包括窃取认证信息、键盘记录、页面篡改、恶意软件植入等，不是直接删除服务器数据。"
    })

    questions.append({
        "question": "以下哪些措施可以有效防御XSS攻击？",
        "answer": "A,B,C",
        "type": 3,
        "options": '{"A":"对用户输入进行严格验证","B":"对输出到HTML的内容进行编码","C":"设置Content-Security-Policy","D":"禁止用户访问网站","E":"使用HTTP替代HTTPS"}',
        "analysis": "XSS防御措施包括输入验证、输出编码、设置CSP等。禁止用户访问和HTTP不是防护措施。"
    })

    # 填空
    questions.append({
        "question": "XSS攻击的三种主要类型是：反射型、____和DOM型。",
        "answer": "存储型",
        "type": 1,
        "analysis": "XSS主要分为反射型、存储型、DOM型三种。"
    })

    questions.append({
        "question": "在HTML上下文中，需要对____、____和____字符进行编码以防止XSS。",
        "answer": "<|>|&",
        "type": 1,
        "analysis": "HTML中需要编码的字符是<、>、&，以及双引号（在属性上下文中）。"
    })

    # 编程题
    questions.append({
        "question": "请实现一个简单的XSS过滤函数filterXSS：\n\n1. 接收一个字符串参数\n2. 将以下字符转换为对应的HTML实体：\n   - < 转换为 &lt;\n   - > 转换为 &gt;\n   - & 转换为 &amp;\n   - \" 转换为 &quot;\n   - ' 转换为 &#x27;\n3. 返回过滤后的安全字符串\n\n示例：\nfilterXSS(\"<script>alert(1)</script>\") -> \"&lt;script&gt;alert(1)&lt;/script&gt;\"",
        "answer": "",
        "type": 6,
        "analysis": "考察对XSS防护原理的理解，HTML编码是防护XSS的基础手段。",
        "is_programming": 1,
        "language": "java",
        "template_code": "public class XssFilter {\n    public static String filterXSS(String input) {\n        // TODO: 实现XSS过滤\n        return input;\n    }\n\n    public static void main(String[] args) {\n        System.out.println(filterXSS(\"<script>alert(1)</script>\"));\n        System.out.println(filterXSS(\"Hello <b>World</b>\"));\n    }\n}",
        "io_mode": "standard",
        "test_cases": [
            {"input": "", "expected_output": "&lt;script&gt;alert(1)&lt;/script&gt;\nHello &lt;b&gt;World&lt;/b&gt;", "score_weight": 100, "sort_index": 0}
        ]
    })

    return questions


def gen_sql_injection_questions():
    """SQL注入题目"""
    questions = []

    # 单选
    questions.append({
        "question": "SQL注入攻击属于哪种类型的攻击？",
        "answer": "B",
        "type": 2,
        "options": '{"A":"物理攻击","B":"代码注入攻击","C":"社会工程攻击","D":"拒绝服务攻击"}',
        "analysis": "SQL注入是一种代码注入技术，攻击者在输入中插入恶意SQL语句来操纵数据库。"
    })

    questions.append({
        "question": "以下哪个是防御SQL注入的最佳方式？",
        "answer": "C",
        "type": 2,
        "options": '{"A":"过滤特殊字符","B":"限制输入长度","C":"使用参数化查询（PreparedStatement）","D":"对输入进行Base64编码"}',
        "analysis": "参数化查询将SQL语句模板和数据分离，数据不会作为代码执行，是防御SQL注入的最佳方式。"
    })

    questions.append({
        "question": "MyBatis中，哪个符号可以防止SQL注入？",
        "answer": "C",
        "type": 2,
        "options": '{"A":"${}","B":"#{}和${}都可以","C":"#{}","D":"$"}',
        "analysis": "#{}使用预编译参数化方式传参，可以防止SQL注入；${}是直接字符串拼接，存在SQL注入风险。"
    })

    questions.append({
        "question": "联合查询注入（UNION Injection）利用了SQL的哪个关键字？",
        "answer": "B",
        "type": 2,
        "options": '{"A":"WHERE","B":"UNION","C":"ORDER BY","D":"GROUP BY"}',
        "analysis": "UNION关键字用于合并两个SELECT的结果，攻击者利用它获取额外数据。"
    })

    questions.append({
        "question": "错误型SQL注入主要利用什么获取信息？",
        "answer": "A",
        "type": 2,
        "options": '{"A":"数据库返回的错误信息","B":"页面加载时间","C":"布尔判断结果","D":"用户输入的内容"}',
        "analysis": "错误型SQL注入通过触发数据库错误，从错误消息中获取数据库结构信息。"
    })

    # 多选
    questions.append({
        "question": "以下哪些措施可以有效防御SQL注入？",
        "answer": "A,B,C,D",
        "type": 3,
        "options": '{"A":"使用参数化查询","B":"输入验证（白名单）","C":"使用ORM框架","D":"遵循最小权限原则","E":"关闭数据库错误信息显示"}',
        "analysis": "防御SQL注入需要多层防护：参数化查询、输入验证、ORM框架、最小权限、错误处理。"
    })

    questions.append({
        "question": "SQL注入攻击可能造成哪些危害？",
        "answer": "A,B,C",
        "type": 3,
        "options": '{"A":"绕过用户认证","B":"数据库数据泄露或篡改","C":"执行系统命令","D":"直接攻击网络设备","E":"修改浏览器设置"}',
        "analysis": "SQL注入主要危害包括：绕过认证、数据泄露、篡改，在特定条件下可执行系统命令。"
    })

    # 填空
    questions.append({
        "question": "参数化查询（PreparedStatement）将SQL语句结构和____分离，数据只作为____传递。",
        "answer": "数据|值",
        "type": 1,
        "analysis": "参数化查询预编译SQL语句结构，数据作为参数值传递，不会被解释为代码。"
    })

    questions.append({
        "question": "堆叠查询注入使用____字符分隔多条SQL语句。",
        "answer": "分号(;)",
        "type": 1,
        "analysis": "分号用于分隔多条SQL语句，堆叠查询可以执行多条独立的SQL语句。"
    })

    # 编程题
    questions.append({
        "question": "请实现一个安全的用户查询方法safeFindUser，要求：\n\n1. 使用PreparedStatement参数化查询\n2. 接收username和password参数\n3. 防止SQL注入攻击\n4. 返回查询到的用户信息（假设返回用户ID）\n\n数据库表结构：\nusers(id INT, username VARCHAR, password VARCHAR)\n\n错误示例（不安全）：\nString sql = \"SELECT id FROM users WHERE username='\" + username + \"' AND password='\" + password + \"'\";",
        "answer": "",
        "type": 6,
        "analysis": "考察对SQL注入防护的理解，参数化查询是防止SQL注入的核心技术。",
        "is_programming": 1,
        "language": "java",
        "template_code": "import java.sql.*;\n\npublic class UserDAO {\n    public int safeFindUser(String username, String password) throws SQLException {\n        // TODO: 使用PreparedStatement实现安全查询\n        // 返回用户ID，如果未找到返回-1\n        return -1;\n    }\n}",
        "io_mode": "standard",
        "test_cases": [
            {"input": "admin\n123456", "expected_output": "1", "score_weight": 50, "sort_index": 0},
            {"input": "' OR '1'='1\nanything", "expected_output": "-1", "score_weight": 50, "sort_index": 1}
        ]
    })

    return questions


def gen_ios_security_questions():
    """iOS应用安全题目"""
    questions = []

    # 单选
    questions.append({
        "question": "iOS应用签名机制的主要目的是？",
        "answer": "B",
        "type": 2,
        "options": '{"A":"加快应用启动速度","B":"验证应用来源和完整性，防止篡改","C":"跟踪用户使用行为","D":"优化应用性能"}',
        "analysis": "iOS签名机制用于验证应用来源和完整性，确保应用未被篡改或恶意修改。"
    })

    questions.append({
        "question": "iOS的沙盒（Sandbox）机制主要作用是？",
        "answer": "C",
        "type": 2,
        "options": '{"A":"加快应用运行速度","B":"节省存储空间","C":"隔离应用，每个应用无法访问其他应用数据","D":"提供更好的用户体验"}',
        "analysis": "iOS沙盒机制隔离每个应用，使其无法访问其他应用的数据，保护用户隐私和安全。"
    })

    questions.append({
        "question": "以下哪个不是iOS应用安全机制？",
        "answer": "D",
        "type": 2,
        "options": '{"A":"应用签名验证","B":"沙盒隔离","C":"数据保护（NSFileProtection）","D":"应用内购验证"}',
        "analysis": "iOS安全机制包括：签名验证、沙盒隔离、数据保护、Keychain等。应用内购验证不是安全机制。"
    })

    questions.append({
        "question": "Keychain用于存储什么类型的数据？",
        "answer": "A",
        "type": 2,
        "options": '{"A":"敏感数据如密码、密钥、证书","B":"普通用户配置文件","C":"应用缓存数据","D":"网络请求数据"}',
        "analysis": "Keychain是iOS的安全存储机制，用于存储敏感数据如密码、密钥、证书等。"
    })

    questions.append({
        "question": "ATS（App Transport Security）的作用是？",
        "answer": "B",
        "type": 2,
        "options": '{"A":"加速网络请求","B":"强制使用HTTPS连接，拒绝不安全的HTTP","C":"缓存网络数据","D":"压缩网络请求数据"}',
        "analysis": "ATS强制应用使用HTTPS连接，拒绝不安全的HTTP连接，保护数据传输安全。"
    })

    # 多选
    questions.append({
        "question": "iOS应用安全加固措施包括哪些？",
        "answer": "A,B,C,D",
        "type": 3,
        "options": '{"A":"使用SSL Pinning防止中间人攻击","B":"敏感数据存储在Keychain中","C":"关闭调试日志","D":"进行代码混淆","E":"使用第三方应用市场分发"}',
        "analysis": "iOS加固措施包括：SSL Pinning、Keychain存储、关闭调试日志、代码混淆等。使用第三方市场不是加固措施。"
    })

    # 填空
    questions.append({
        "question": "iOS应用签名验证的三种类型是：开发者签名、____和App Store签名。",
        "answer": "企业签名",
        "type": 1,
        "analysis": "iOS签名分为：开发者签名（测试用）、企业签名（企业内部分发）、App Store签名（正式发布）。"
    })

    questions.append({
        "question": "NSFileProtectionComplete表示文件在____时才可访问。",
        "answer": "设备解锁",
        "type": 1,
        "analysis": "NSFileProtectionComplete要求设备解锁后才可访问文件，提供数据保护。"
    })

    # 简答题
    questions.append({
        "question": "请简述iOS应用中SSL Pinning的原理和作用。",
        "answer": "SSL Pinning（证书绑定）将服务器证书或公钥内置在应用中，客户端在连接服务器时验证证书是否与内置的一致，防止中间人攻击。即使攻击者获得了有效证书，也无法进行中间人攻击，因为客户端会拒绝不匹配的证书。",
        "type": 5,
        "analysis": "SSL Pinning通过验证服务器证书的合法性来确保连接的安全，防止第三方拦截流量。"
    })

    return questions


def gen_gdpr_questions():
    """GDPR与个人信息保护题目"""
    questions = []

    # 单选
    questions.append({
        "question": "GDPR的全称是什么？",
        "answer": "B",
        "type": 2,
        "options": '{"A":"General Data Privacy Regulation","B":"General Data Protection Regulation","C":"Global Data Protection Rules","D":"Government Data Protection Requirements"}',
        "analysis": "GDPR是General Data Protection Regulation（通用数据保护条例），是欧盟制定的数据保护法规。"
    })

    questions.append({
        "question": "GDPR规定的被遗忘权（Right to be Forgotten）是指？",
        "answer": "C",
        "type": 2,
        "options": '{"A":"用户可以要求删除其账户","B":"用户可以要求删除所有个人数据","C":"用户可以要求删除其个人数据，且有合法理由时组织必须删除","D":"用户可以要求永久删除服务器上的所有数据"}',
        "analysis": "被遗忘权允许数据主体要求控制者删除其个人数据，当数据不再需要或有合法理由时。"
    })

    questions.append({
        "question": "以下哪个不是GDPR规定的数据主体权利？",
        "answer": "D",
        "type": 2,
        "options": '{"A":"知情权","B":"访问权","C":"删除权","D":"交易权"}',
        "analysis": "GDPR数据主体权利包括：知情权、访问权、更正权、删除权、限制处理权、数据可携权、拒绝权。交易权不在其中。"
    })

    # 多选
    questions.append({
        "question": "GDPR合规的技术措施包括哪些？",
        "answer": "A,B,C,D",
        "type": 3,
        "options": '{"A":"数据加密","B":"访问控制","C":"审计日志","D":"数据脱敏","E":"数据分析"}',
        "analysis": "GDPR技术措施包括：加密、访问控制、审计日志、数据脱敏等。数据分析不是合规措施。"
    })

    # 填空
    questions.append({
        "question": "GDPR的六大核心原则包括：合法性、公平性和透明性、____、数据最小化、准确性、存储限制和完整性和机密性。",
        "answer": "目的限制",
        "type": 1,
        "analysis": "GDPR六原则：合法性公平性透明性、目的限制、数据最小化、准确性、存储限制、完整性和机密性。"
    })

    return questions


def gen_java_collection_questions():
    """Java集合框架题目"""
    questions = []

    # 单选
    questions.append({
        "question": "ArrayList和LinkedList的主要区别是？",
        "answer": "C",
        "type": 2,
        "options": '{"A":"ArrayList是线程安全的，LinkedList不是","B":"ArrayList查询快但增删慢，LinkedList增删快但查询慢","C":"ArrayList基于数组实现，LinkedList基于双向链表实现","D":"两者没有任何区别"}',
        "analysis": "ArrayList基于动态数组，查询O(1)但增删需要移动元素；LinkedList基于双向链表，增删O(1)但查询需要遍历。"
    })

    questions.append({
        "question": "HashMap的put操作时间复杂度是？",
        "answer": "B",
        "type": 2,
        "options": '{"A":"O(1)总是","B":"O(1)平均，O(n)最坏情况","C":"O(n)","D":"O(log n)"}',
        "analysis": "HashMap在理想情况下put是O(1)，但当发生哈希冲突时可能退化为O(n)（所有key映射到同一桶）。"
    })

    questions.append({
        "question": "ConcurrentHashMap如何实现线程安全？",
        "answer": "D",
        "type": 2,
        "options": '{"A":"使用synchronized修饰所有方法","B":"使用全局锁","C":"使用Lock锁","D":"分段锁（Segment），每个Segment独立加锁"}',
        "analysis": "ConcurrentHashMap使用分段锁，将数据分成多个Segment，每个Segment独立加锁，减小锁粒度。"
    })

    questions.append({
        "question": "HashSet底层实现是？",
        "answer": "A",
        "type": 2,
        "options": '{"A":"HashMap","B":"ArrayList","C":"LinkedList","D":"TreeMap"}',
        "analysis": "HashSet底层使用HashMap存储数据，key存储元素，value存储一个固定的PRESENT对象。"
    })

    questions.append({
        "question": "以下哪个集合类可以保持元素有序且不重复？",
        "answer": "C",
        "type": 2,
        "options": '{"A":"HashSet","B":"LinkedHashSet","C":"TreeSet","D":"EnumSet"}',
        "analysis": "TreeSet基于TreeMap，使用自然排序或自定义比较器保持元素有序且不重复。LinkedHashSet保持插入顺序。"
    })

    # 多选
    questions.append({
        "question": "以下哪些是fail-fast的特性？",
        "answer": "A,B",
        "type": 3,
        "options": '{"A":"ArrayList的迭代器","B":"HashMap的entrySet迭代器","C":"ConcurrentHashMap的迭代器","D":"CopyOnWriteArrayList的迭代器"}',
        "analysis": "fail-fast指在迭代过程中检测到集合被修改会抛出ConcurrentModificationException。ArrayList、HashMap是fail-fast，ConcurrentHashMap和CopyOnWriteArrayList不是。"
    })

    questions.append({
        "question": "HashMap扩容时，以下哪些操作会影响性能？",
        "answer": "A,B,C",
        "type": 3,
        "options": '{"A":"重新计算每个key的hash","B":"将所有元素重新放入新桶","C":"扩容阈值（load factor）设置过低","D":"使用String作为key"}',
        "analysis": "HashMap扩容时需要重新hash和重新分配桶，load factor越低扩容越频繁，影响性能。String作为key不影响性能。"
    })

    # 填空
    questions.append({
        "question": "HashMap的默认初始容量是____，负载因子是____。",
        "answer": "16|0.75",
        "type": 1,
        "analysis": "HashMap默认初始容量16，负载因子0.75，即当元素数量超过12时触发扩容。"
    })

    questions.append({
        "question": "TreeSet使用____接口实现元素排序。",
        "answer": "Comparable或Comparator",
        "type": 1,
        "analysis": "TreeSet可以通过Comparable（自然排序）或Comparator（自定义比较器）实现元素排序。"
    })

    # 编程题
    questions.append({
        "question": "请实现一个简单的LRU缓存（Least Recently Used Cache）：\n\n要求：\n1. 容量为capacity\n2. 提供get(key)方法，获取值并将该key标记为最近使用\n3. 提供put(key, value)方法，存入键值对\n4. 如果超过容量，删除最久未使用的条目\n5. 使用LinkedHashMap实现\n\n示例：\nLRUCache cache = new LRUCache(2);\ncache.put(1, 1);  // 容量满\ncache.put(2, 2);\ncache.get(1);     // 返回1，并将1标记为最近使用\ncache.put(3, 3);  // 删除key=2（最久未使用）\ncache.get(2);     // 返回-1（已被删除）",
        "answer": "",
        "type": 6,
        "analysis": "考察对LinkedHashMap和LRU缓存算法的理解。",
        "is_programming": 1,
        "language": "java",
        "template_code": "import java.util.*;\n\npublic class LRUCache {\n    private int capacity;\n    private LinkedHashMap<Integer, Integer> cache;\n\n    public LRUCache(int capacity) {\n        this.capacity = capacity;\n        // TODO: 初始化LinkedHashMap\n    }\n\n    public int get(int key) {\n        // TODO: 实现get方法\n        return -1;\n    }\n\n    public void put(int key, int value) {\n        // TODO: 实现put方法\n    }\n}",
        "io_mode": "standard",
        "test_cases": [
            {"input": "2\n1:1\n2:2\n1\n3:3\n2", "expected_output": "1\n-1", "score_weight": 100, "sort_index": 0}
        ]
    })

    return questions


def gen_java_multithreading_questions():
    """Java多线程题目"""
    questions = []

    # 单选
    questions.append({
        "question": "以下哪个关键字可以保证变量的可见性？",
        "answer": "B",
        "type": 2,
        "options": '{"A":"synchronized","B":"volatile","C":"final","D":"static"}',
        "analysis": "volatile保证变量的可见性，防止指令重排序，但不保证原子性。synchronized保证原子性、可见性和有序性。"
    })

    questions.append({
        "question": "创建线程的方式有几种？",
        "answer": "C",
        "type": 2,
        "options": '{"A":"1种","B":"2种","C":"3种（继承Thread、实现Runnable、实现Callable）","D":"4种"}',
        "analysis": "Java创建线程有3种方式：继承Thread、实现Runnable接口、实现Callable接口（配合FutureTask）。"
    })

    questions.append({
        "question": "synchronized和Lock的主要区别是？",
        "answer": "D",
        "type": 2,
        "options": '{"A":"synchronized是函数调用，Lock是接口","B":"synchronized可以中断，Lock不可以","C":"synchronized释放锁需要手动，Lock自动释放","D":"Lock提供更多功能如tryLock、公平锁等，且可以中断"}',
        "analysis": "Lock接口比synchronized更灵活，支持tryLock、公平锁、可中断锁等，需要手动释放锁。"
    })

    questions.append({
        "question": "以下哪个状态是线程的生命周期中的状态？",
        "answer": "D",
        "type": 2,
        "options": '{"A":"NEW、RUNNING、BLOCKED、WAITING、TERMINATED","B":"NEW、RUNNABLE、BLOCKED、TIMED_WAITING、TERMINATED","C":"NEW、RUNNING、WAITING、TERMINATED","D":"NEW、RUNNABLE、BLOCKED、WAITING、TIMED_WAITING、TERMINATED"}',
        "analysis": "线程的6个状态：NEW（新建）、RUNNABLE（可运行）、BLOCKED（阻塞）、WAITING（等待）、TIMED_WAITING（计时等待）、TERMINATED（终止）。"
    })

    questions.append({
        "question": "ThreadLocal的作用是？",
        "answer": "A",
        "type": 2,
        "options": '{"A":"为每个线程提供独立的变量副本","B":"让所有线程共享同一个变量","C":"创建新线程","D":"终止线程"}',
        "analysis": "ThreadLocal为每个线程提供独立的变量副本，实现线程隔离，常用于保存线程上下文信息。"
    })

    # 多选
    questions.append({
        "question": "以下哪些是死锁的必要条件？",
        "answer": "A,B,C,D",
        "type": 3,
        "options": '{"A":"互斥条件：资源一次只能被一个线程持有","B":"占有并等待：线程持有资源同时请求其他资源","C":"不可抢占：资源不能被强制释放","D":"循环等待：线程之间形成循环等待资源","E":"同步条件：使用了synchronized关键字"}',
        "analysis": "死锁必要条件：互斥、占有并等待、不可抢占、循环等待。同步不是死锁的必要条件。"
    })

    questions.append({
        "question": "以下哪些方法可以使线程进入等待状态？",
        "answer": "A,B,C",
        "type": 3,
        "options": '{"A":"Thread.sleep()","B":"Object.wait()","C":"Lock.await()","D":"Thread.yield()","E":"Thread.join()"}',
        "analysis": "sleep()、wait()、await()会使线程进入等待状态。yield()只是让出CPU时间片，join()是等待其他线程结束。"
    })

    # 填空
    questions.append({
        "question": "wait()方法必须在____块或方法中调用。",
        "answer": "synchronized",
        "type": 1,
        "analysis": "wait()方法必须在synchronized保护的临界区中调用，否则会抛出IllegalMonitorStateException。"
    })

    questions.append({
        "question": "JVM中，每个线程拥有独立的____，用于存储线程局部变量。",
        "answer": "ThreadLocal",
        "type": 1,
        "analysis": "每个线程拥有独立的ThreadLocal区域，用于存储线程局部变量。"
    })

    # 编程题
    questions.append({
        "question": "请实现一个线程安全的计数器Counter：\n\n要求：\n1. 提供increment()方法，计数加1\n2. 提供decrement()方法，计数减1\n3. 提供getValue()方法，获取当前计数值\n4. 线程安全\n5. 使用synchronized实现",
        "answer": "",
        "type": 6,
        "analysis": "考察对synchronized关键字和线程安全概念的理解。",
        "is_programming": 1,
        "language": "java",
        "template_code": "public class Counter {\n    private int value = 0;\n\n    // TODO: 实现线程安全的计数方法\n\n    public synchronized void increment() {\n    }\n\n    public synchronized void decrement() {\n    }\n\n    public synchronized int getValue() {\n        return value;\n    }\n}",
        "io_mode": "standard",
        "test_cases": [
            {"input": "1000", "expected_output": "0", "score_weight": 100, "sort_index": 0}
        ]
    })

    return questions


def gen_java_io_questions():
    """Java IO流题目"""
    questions = []

    # 单选
    questions.append({
        "question": "以下哪个流用于处理字节输入？",
        "answer": "B",
        "type": 2,
        "options": '{"A":"InputStream","B":"InputStream（及其子类如FileInputStream）","C":"Reader","D":"Writer"}',
        "analysis": "InputStream用于处理字节输入，Reader用于处理字符输入，Writer用于处理字符输出。"
    })

    questions.append({
        "question": "BufferedReader相比FileReader的优势是？",
        "answer": "C",
        "type": 2,
        "options": '{"A":"可以指定字符编码","B":"可以按行读取","C":"使用缓冲区减少IO次数，提高读写效率","D":"可以读取二进制文件"}',
        "analysis": "BufferedReader使用缓冲区减少IO次数，提供按行读取功能，提高效率。指定编码使用InputStreamReader。"
    })

    questions.append({
        "question": "以下哪个类用于将对象写入文件？",
        "answer": "D",
        "type": 2,
        "options": '{"A":"FileOutputStream","B":"FileWriter","C":"BufferedWriter","D":"ObjectOutputStream"}',
        "analysis": "ObjectOutputStream用于将对象序列化写入文件，FileOutputStream和FileWriter只能写入字节或字符。"
    })

    # 填空
    questions.append({
        "question": "IO流按照操作单位分为字节流和____流。",
        "answer": "字符",
        "type": 1,
        "analysis": "IO流分为字节流（InputStream/OutputStream）和字符流（Reader/Writer）。"
    })

    questions.append({
        "question": "字节流以____为单位处理数据，字符流以____为单位处理数据。",
        "answer": "字节|字符",
        "type": 1,
        "analysis": "字节流以byte为单位，字符流以char为单位（Unicode）。"
    })

    # 编程题
    questions.append({
        "question": "请实现一个文件复制方法copyFile：\n\n要求：\n1. 接收源文件路径和目标文件路径\n2. 使用BufferedInputStream和BufferedOutputStream进行缓冲复制\n3. 复制过程中显示进度（已复制字节数）\n4. 复制完成后关闭流",
        "answer": "",
        "type": 6,
        "analysis": "考察对IO流的理解和使用Buffered流进行高效文件复制。",
        "is_programming": 1,
        "language": "java",
        "template_code": "import java.io.*;\n\npublic class FileCopier {\n    public static void copyFile(String src, String dest) throws IOException {\n        // TODO: 使用缓冲流实现文件复制\n    }\n}",
        "io_mode": "standard",
        "test_cases": [
            {"input": "test.txt\ncopy.txt", "expected_output": "Copy completed: 1024 bytes", "score_weight": 100, "sort_index": 0}
        ]
    })

    return questions


def gen_java_exception_questions():
    """Java异常处理题目"""
    questions = []

    # 单选
    questions.append({
        "question": "以下哪个是检查型异常（Checked Exception）？",
        "answer": "C",
        "type": 2,
        "options": '{"A":"NullPointerException","B":"ArrayIndexOutOfBoundsException","C":"IOException","D":"ArithmeticException"}',
        "analysis": "检查型异常需要强制处理，如IOException、SQLException。非检查型异常包括RuntimeException及其子类。"
    })

    questions.append({
        "question": "finally块中的代码何时会执行？",
        "answer": "D",
        "type": 2,
        "options": '{"A":"只在try块正常执行完成后","B":"只在catch块执行完成后","C":"在try或catch块中return之前","D":"无论是否发生异常，finally块都会执行"}',
        "analysis": "finally块无论是否发生异常都会执行，只有System.exit()可以阻止其执行。"
    })

    questions.append({
        "question": "关于throw和throws的区别，以下说法正确的是？",
        "answer": "B",
        "type": 2,
        "options": '{"A":"throw用于声明异常，throws用于抛出异常","B":"throw用于抛出异常，throws用于声明异常","C":"两者没有区别","D":"throw用于方法签名，throws用于实际抛出"}',
        "analysis": "throw是抛出异常的动作，throws是方法签名中声明可能抛出的异常类型。"
    })

    # 填空
    questions.append({
        "question": "Error和Exception都是____的子类。",
        "answer": "Throwable",
        "type": 1,
        "analysis": "Java异常层次：Throwable -> Error（ JVM错误）和 Exception（程序异常）。"
    })

    questions.append({
        "question": "catch块捕获异常时，子类异常要写在____异常之前。",
        "answer": "父类",
        "type": 1,
        "analysis": "多catch块中，子类异常要写在父类异常之前，否则编译错误。"
    })

    return questions


def gen_network_questions():
    """计算机网络题目"""
    questions = []

    # 单选
    questions.append({
        "question": "HTTP协议默认端口是？",
        "answer": "B",
        "type": 2,
        "options": '{"A":"21","B":"80","C":"443","D":"3306"}',
        "analysis": "HTTP默认端口80，HTTPS默认端口443，FTP默认端口21，MySQL默认端口3306。"
    })

    questions.append({
        "question": "TCP三次握手的作用是？",
        "answer": "C",
        "type": 2,
        "options": '{"A":"传输数据","B":"断开连接","C":"建立可靠的连接，确认双方发送和接收能力","D":"加密数据"}',
        "analysis": "三次握手用于建立可靠连接，确认双方的发送和接收能力是否正常。"
    })

    questions.append({
        "question": "HTTP请求方法中，哪个用于更新资源？",
        "answer": "B",
        "type": 2,
        "options": '{"A":"GET","B":"PUT","C":"POST","D":"DELETE"}',
        "analysis": "GET读取、POST创建、PUT更新、DELETE删除。RESTful风格中PUT用于更新完整资源。"
    })

    questions.append({
        "question": "Cookie和Session的主要区别是？",
        "answer": "A",
        "type": 2,
        "options": '{"A":"Cookie存储在客户端浏览器，Session存储在服务器端","B":"Cookie存储在服务器端，Session存储在客户端","C":"两者没有区别","D":"Cookie用于存储敏感信息，Session用于存储普通信息"}',
        "analysis": "Cookie是客户端存储的键值对，Session是服务器端存储的会话数据。"
    })

    # 多选
    questions.append({
        "question": "HTTP状态码中，哪些属于成功状态（2xx）？",
        "answer": "A,B,C",
        "type": 3,
        "options": '{"A":"200 OK","B":"201 Created","C":"204 No Content","D":"404 Not Found","E":"500 Internal Server Error"}',
        "analysis": "2xx表示成功，200 OK、201 Created、204 No Content都是成功状态码。404是客户端错误，500是服务器错误。"
    })

    questions.append({
        "question": "TCP和UDP的区别包括哪些？",
        "answer": "A,B,C,D",
        "type": 3,
        "options": '{"A":"TCP是面向连接的，UDP是无连接的","B":"TCP提供可靠传输，UDP不提供","C":"TCP是流式数据，UDP是数据包","D":"TCP有拥塞控制，UDP没有","E":"TCP比UDP速度快"}',
        "analysis": "TCP提供可靠连接、流量控制、拥塞控制；UDP快速但不保证可靠。速度上UDP更快。"
    })

    # 填空
    questions.append({
        "question": "HTTP的____方法用于获取资源的元数据。",
        "answer": "HEAD",
        "type": 1,
        "analysis": "HEAD方法与GET类似，但只返回响应头，不返回实体内容，用于获取资源元数据。"
    })

    questions.append({
        "question": "在TCP/IP四层模型中，HTTP属于____层，TCP属于____层。",
        "answer": "应用|传输",
        "type": 1,
        "analysis": "TCP/IP四层：应用层（HTTP、FTP）、传输层（TCP、UDP）、网络层（IP）、链路层。"
    })

    # 简答题
    questions.append({
        "question": "请简述HTTPS的工作原理。",
        "answer": "HTTPS在HTTP和TCP之间增加了SSL/TLS层。（1）客户端发起HTTPS请求，连接到服务器443端口；（2）服务器返回证书（包含公钥）；（3）客户端验证证书有效性；（4）客户端生成随机数（对称密钥），用公钥加密后发送给服务器；（5）服务器用私钥解密获取对称密钥；（6）双方使用对称密钥加密数据进行HTTP通信。",
        "type": 5,
        "analysis": "HTTPS使用SSL/TLS加密，混合使用非对称加密（握手阶段）和对称加密（数据传输阶段）。"
    })

    return questions


def gen_database_questions():
    """数据库题目"""
    questions = []

    # 单选
    questions.append({
        "question": "MySQL中，InnoDB和MyISAM存储引擎的主要区别是？",
        "answer": "C",
        "type": 2,
        "options": '{"A":"InnoDB不支持事务，MyISAM支持","B":"InnoDB支持全文索引，MyISAM不支持","C":"InnoDB支持事务和外键，MyISAM不支持","D":"两者没有区别"}',
        "analysis": "InnoDB支持事务、外键、行级锁；MyISAM不支持事务和外键，但支持全文索引。"
    })

    questions.append({
        "question": "以下哪个SQL语句用于创建索引？",
        "answer": "B",
        "type": 2,
        "options": '{"A":"CREATE TABLE","B":"CREATE INDEX","C":"CREATE VIEW","D":"CREATE DATABASE"}',
        "analysis": "CREATE INDEX用于创建索引，CREATE TABLE创建表，CREATE VIEW创建视图。"
    })

    questions.append({
        "question": "Redis的持久化方式包括？",
        "answer": "D",
        "type": 2,
        "options": '{"A":"只有RDB","B":"只有AOF","C":"RDB和AOF都支持","D":"不支持持久化"}',
        "analysis": "Redis支持两种持久化方式：RDB（快照）和AOF（追加文件），可以同时使用。"
    })

    # 多选
    questions.append({
        "question": "以下哪些操作可以优化数据库查询性能？",
        "answer": "A,B,C,D",
        "type": 3,
        "options": '{"A":"建立合适的索引","B":"避免SELECT *","C":"使用EXPLAIN分析查询","D":"分页查询大数据集","E":"尽量使用子查询代替JOIN"}',
        "analysis": "优化方法包括：索引、避免SELECT *、EXPLAIN分析、分页。子查询不一定优于JOIN，需要根据情况选择。"
    })

    # 填空
    questions.append({
        "question": "SQL的聚合函数COUNT、SUM、AVG、MAX、MIN中，用于计算平均值的是____。",
        "answer": "AVG",
        "type": 1,
        "analysis": "COUNT计数、SUM求和、AVG平均、MAX最大、MIN最小。"
    })

    questions.append({
        "question": "Redis的____数据结构可以实现分布式锁。",
        "answer": "SETNX或RedLock",
        "type": 1,
        "analysis": "Redis的SETNX（SET if Not eXists）命令可以用于实现分布式锁。"
    })

    return questions


def gen_linux_questions():
    """Linux命令题目"""
    questions = []

    # 单选
    questions.append({
        "question": "以下哪个命令用于查看进程状态？",
        "answer": "B",
        "type": 2,
        "options": '{"A":"ls","B":"ps","C":"grep","D":"find"}',
        "analysis": "ls列出文件、ps查看进程、grep搜索、find查找文件。"
    })

    questions.append({
        "question": "以下哪个命令用于查找文件？",
        "answer": "D",
        "type": 2,
        "options": '{"A":"ls","B":"cd","C":"pwd","D":"find"}',
        "analysis": "ls列出目录内容、cd切换目录、pwd显示当前路径、find查找文件。"
    })

    # 填空
    questions.append({
        "question": "Linux中，____命令用于查看当前工作目录的路径。",
        "answer": "pwd",
        "type": 1,
        "analysis": "pwd（Print Working Directory）显示当前工作目录的绝对路径。"
    })

    questions.append({
        "question": "在Linux中，____命令用于修改文件权限，____命令用于修改文件所有者。",
        "answer": "chmod|chown",
        "type": 1,
        "analysis": "chmod修改文件权限（如chmod 755 file），chown修改文件所有者（如chown user:group file）。"
    })

    return questions


def gen_data_structure_questions():
    """数据结构题目"""
    questions = []

    # 单选
    questions.append({
        "question": "数组和链表的主要区别是？",
        "answer": "C",
        "type": 2,
        "options": '{"A":"数组是链式存储，链表是连续存储","B":"数组查询慢，链表查询快","C":"数组连续存储，查询O(1)；链表链式存储，增删O(1)","D":"两者没有任何区别"}',
        "analysis": "数组连续存储支持下标随机访问O(1)，但增删需要移动元素O(n)；链表增删O(1)但查询需要遍历O(n)。"
    })

    questions.append({
        "question": "二叉树中，度为2的节点和叶子节点的关系是？",
        "answer": "B",
        "type": 2,
        "options": '{"A":"没有关系","B":"n0 = n2 + 1（叶子数 = 度为2的节点数 + 1）","C":"n0 = n2 - 1","D":"n0 = n2 * 2"}',
        "analysis": "二叉树性质：n0 = n2 + 1，其中n0是叶子节点数，n2是度为2的节点数。"
    })

    questions.append({
        "question": "堆（Heap）的时间复杂度是？",
        "answer": "A",
        "type": 2,
        "options": '{"A":"O(log n)","B":"O(n)","C":"O(1)","D":"O(n log n)"}',
        "analysis": "堆的插入和删除操作时间复杂度都是O(log n)，因为堆是一棵完全二叉树。"
    })

    # 填空
    questions.append({
        "question": "长度为n的数组，二分查找的时间复杂度是____。",
        "answer": "O(log n)",
        "type": 1,
        "analysis": "二分查找每次将搜索范围缩小一半，时间复杂度O(log n)。"
    })

    questions.append({
        "question": "图的两种存储方式是____和邻接表。",
        "answer": "邻接矩阵",
        "type": 1,
        "analysis": "图的存储方式：邻接矩阵（适合稠密图）和邻接表（适合稀疏图）。"
    })

    # 编程题
    questions.append({
        "question": "请实现一个方法isBalanced，接收一个二叉树根节点，判断该二叉树是否平衡：\n\n平衡二叉树的定义：一个二叉树每个节点的左右子树高度差不超过1。\n\n要求：\n1. 时间复杂度为O(n)\n2. 如果平衡返回true，否则返回false\n\n示例：\n    1\n   / \\\n  2   3\n /\n4\n树高度差为1，返回true",
        "answer": "",
        "type": 6,
        "analysis": "考察对二叉树和递归的理解，需要同时计算高度并判断平衡状态。",
        "is_programming": 1,
        "language": "java",
        "template_code": "class TreeNode {\n    int val;\n    TreeNode left, right;\n    TreeNode(int val) { this.val = val; }\n}\n\npublic class Solution {\n    public boolean isBalanced(TreeNode root) {\n        // TODO: 判断二叉树是否平衡\n        return checkHeight(root) != -1;\n    }\n\n    private int checkHeight(TreeNode node) {\n        // TODO: 返回节点高度，如果不平衡返回-1\n        return 0;\n    }\n}",
        "io_mode": "standard",
        "test_cases": [
            {"input": "1,2,3,4,null,null", "expected_output": "true", "score_weight": 50, "sort_index": 0},
            {"input": "1,2,null,3", "expected_output": "false", "score_weight": 50, "sort_index": 1}
        ]
    })

    return questions


def gen_algorithm_questions():
    """算法题目"""
    questions = []

    # 单选
    questions.append({
        "question": "快速排序的平均时间复杂度是？",
        "answer": "B",
        "type": 2,
        "options": '{"A":"O(n)","B":"O(n log n)","C":"O(n^2)","D":"O(log n)"}',
        "analysis": "快速排序平均时间复杂度O(n log n)，最坏情况O(n^2)（当数组已经有序时）。"
    })

    questions.append({
        "question": "以下哪种排序算法是稳定的？",
        "answer": "C",
        "type": 2,
        "options": '{"A":"快速排序","B":"堆排序","C":"归并排序","D":"选择排序"}',
        "analysis": "稳定排序指相等的元素排序后相对位置不变。归并排序是稳定的，快速排序、堆排序、选择排序不稳定。"
    })

    questions.append({
        "question": "动态规划的核心思想是？",
        "answer": "D",
        "type": 2,
        "options": '{"A":"分而治之","B":"回溯搜索","C":"贪心选择","D":"最优子结构和重叠子问题"}',
        "analysis": "动态规划的核心是最优子结构（问题的最优解包含子问题的最优解）和重叠子问题（子问题被多次计算）。"
    })

    # 多选
    questions.append({
        "question": "以下哪些算法使用分治思想？",
        "answer": "A,B,C",
        "type": 3,
        "options": '{"A":"归并排序","B":"快速排序","C":"二分查找","D":"动态规划","E":"贪心算法"}',
        "analysis": "归并排序、快速排序、二分查找都使用分治思想：分解子问题、递归解决、合并结果。动态规划不使用分治。"
    })

    # 编程题
    questions.append({
        "question": "请实现一个方法longestCommonSubsequence，接收两个字符串，返回它们的最长公共子序列长度：\n\n最长公共子序列（LCS）是指两个字符串中最长的共同子序列（不要求连续）。\n\n示例：\nInput: \"abcde\", \"ace\"\nOutput: 3（\"ace\"是它们的最长公共子序列）\n\nInput: \"abc\", \"def\"\nOutput: 0（没有公共子序列）",
        "answer": "",
        "type": 6,
        "analysis": "考察对动态规划的理解，LCS是经典的DP问题。",
        "is_programming": 1,
        "language": "java",
        "template_code": "public class LCS {\n    public int longestCommonSubsequence(String text1, String text2) {\n        // TODO: 使用动态规划实现\n        return 0;\n    }\n\n    public static void main(String[] args) {\n        LCS lcs = new LCS();\n        System.out.println(lcs.longestCommonSubsequence(\"abcde\", \"ace\"));\n        System.out.println(lcs.longestCommonSubsequence(\"abc\", \"def\"));\n    }\n}",
        "io_mode": "standard",
        "test_cases": [
            {"input": "abcde\nace", "expected_output": "3", "score_weight": 50, "sort_index": 0},
            {"input": "abc\ndef", "expected_output": "0", "score_weight": 50, "sort_index": 1}
        ]
    })

    return questions


def gen_web_security_questions():
    """综合Web安全题目"""
    questions = []

    # 单选
    questions.append({
        "question": "CSRF攻击的全称是？",
        "answer": "A",
        "type": 2,
        "options": '{"A":"Cross-Site Request Forgery","B":"Cross-Site Resource Forwarding","C":"Client-Side Request Forgery","D":"Cross-Server Request Format"}',
        "analysis": "CSRF是Cross-Site Request Forgery（跨站请求伪造），利用用户已登录的身份发起伪造请求。"
    })

    questions.append({
        "question": "以下哪个不是CSRF的防护措施？",
        "answer": "D",
        "type": 2,
        "options": '{"A":"验证Referer头","B":"使用Anti-CSRF Token","C":"验证自定义请求头","D":"使用HTTPS"}',
        "analysis": "CSRF防护：验证Referer、使用Token、验证自定义头。HTTPS用于加密传输，不能防护CSRF。"
    })

    questions.append({
        "question": "以下哪个HTTP头用于防止点击劫持（Clickjacking）？",
        "answer": "A",
        "type": 2,
        "options": '{"A":"X-Frame-Options","B":"Content-Security-Policy","C":"X-XSS-Protection","D":"Strict-Transport-Security"}',
        "analysis": "X-Frame-Options可以防止页面被iframe嵌入，有效防护点击劫持攻击。"
    })

    questions.append({
        "question": "密码存储的正确方式是？",
        "answer": "C",
        "type": 2,
        "options": '{"A":"明文存储","B":"使用MD5单向哈希","C":"使用加盐的BCrypt或Argon2哈希","D":"使用AES加密存储"}',
        "analysis": "密码应使用专用哈希算法如BCrypt、Argon2，加盐存储。MD5已被破解，AES加密需要密钥管理问题。"
    })

    # 多选
    questions.append({
        "question": "以下哪些措施可以提高Web应用的安全性？",
        "answer": "A,B,C,D",
        "type": 3,
        "options": '{"A":"使用HTTPS","B":"开启Security Headers","C":"实施输入验证","D":"遵循最小权限原则","E":"关闭服务器错误详情显示"}',
        "analysis": "提高安全性：HTTPS、Security Headers、输入验证、最小权限、错误处理。"
    })

    # 填空
    questions.append({
        "question": "同源策略（Same-Origin Policy）用于限制____文档或脚本如何与另一个源的资源交互。",
        "answer": "不同",
        "type": 1,
        "analysis": "同源策略是浏览器的安全机制，限制不同源之间的资源访问，防止XSS等攻击。"
    })

    questions.append({
        "question": "Web应用防火墙的英文缩写是____。",
        "answer": "WAF",
        "type": 1,
        "analysis": "WAF（Web Application Firewall）用于防护Web应用免受攻击，如SQL注入、XSS等。"
    })

    return questions


def gen_android_security_questions():
    """Android安全题目"""
    questions = []

    # 单选
    questions.append({
        "question": "Android应用的签名机制主要用于？",
        "answer": "B",
        "type": 2,
        "options": '{"A":"加快应用启动速度","B":"验证应用来源和完整性","C":"压缩应用大小","D":"分析用户行为"}',
        "analysis": "Android签名用于验证应用来源和完整性，确保应用未被篡改。"
    })

    questions.append({
        "question": "AndroidManifest.xml中，android:exported=\"false\"的作用是？",
        "answer": "C",
        "type": 2,
        "options": '{"A":"禁止应用被卸载","B":"禁止应用访问网络","C":"禁止其他应用启动该组件","D":"禁止应用访问SD卡"}',
        "analysis": "android:exported=\"false\"表示组件不允许其他应用启动，保护组件安全。"
    })

    # 填空
    questions.append({
        "question": "Android中，____权限用于访问外部存储设备（如SD卡）。",
        "answer": "READ_EXTERNAL_STORAGE/WRITE_EXTERNAL_STORAGE",
        "type": 1,
        "analysis": "访问外部存储需要READ_EXTERNAL_STORAGE（读）和WRITE_EXTERNAL_STORAGE（写）权限。"
    })

    return questions


def gen_git_questions():
    """Git版本控制题目"""
    questions = []

    # 单选
    questions.append({
        "question": "Git中，以下哪个命令用于创建分支？",
        "answer": "B",
        "type": 2,
        "options": '{"A":"git branch","B":"git branch <name>或git checkout -b <name>","C":"git create","D":"git new-branch"}',
        "analysis": "git branch用于查看和删除分支，创建分支用git branch <name>或git checkout -b <name>。"
    })

    questions.append({
        "question": "Git中，merge和rebase的主要区别是？",
        "answer": "C",
        "type": 2,
        "options": '{"A":"merge创建新提交，rebase不创建","B":"merge保留分支历史，rebase重写历史","C":"merge保留所有分支提交历史，rebase将提交平移到目标分支","D":"两者没有区别"}',
        "analysis": "merge保留完整历史，rebase将提交平移到目标分支，重写历史。rebase会产生更线性的历史。"
    })

    # 填空
    questions.append({
        "question": "Git中，暂存区（Stage）的命令是____，提交的命令是____。",
        "answer": "git add|git commit",
        "type": 1,
        "analysis": "git add将文件添加到暂存区，git commit将暂存区内容提交到本地仓库。"
    })

    return questions


def gen_docker_questions():
    """Docker容器题目"""
    questions = []

    # 单选
    questions.append({
        "question": "Docker容器与虚拟机的区别是？",
        "answer": "B",
        "type": 2,
        "options": '{"A":"虚拟机更轻量，启动更快","B":"容器共享宿主机内核，更轻量；虚拟机包含完整操作系统","C":"容器比虚拟机更安全","D":"两者没有区别"}',
        "analysis": "容器共享宿主机内核，更轻量（秒级启动）；虚拟机包含完整OS，更重但隔离性更强。"
    })

    questions.append({
        "question": "Dockerfile中，COPY和ADD的区别是？",
        "answer": "C",
        "type": 2,
        "options": '{"A":"COPY不能复制文件，ADD可以","B":"ADD可以复制URL，COPY不行","C":"ADD支持从URL复制和自动解压，COPY只支持本地文件复制","D":"两者完全相同"}',
        "analysis": "ADD可以从URL复制、自动解压tar文件；COPY只支持本地文件复制，推荐使用COPY。"
    })

    # 填空
    questions.append({
        "question": "Docker的核心组件包括：Docker daemon（守护进程）、Docker client（客户端）、Docker ____（镜像）、Docker container（容器）。",
        "answer": "image或registry",
        "type": 1,
        "analysis": "Docker组件：daemon运行容器、client接收命令、image镜像模板、container运行实例、registry镜像仓库。"
    })

    return questions


def gen_microservices_questions():
    """微服务题目"""
    questions = []

    # 单选
    questions.append({
        "question": "微服务架构的主要优势是？",
        "answer": "D",
        "type": 2,
        "options": '{"A":"更高的复杂性","B":"更好的耦合","C":"单一部署单元","D":"独立部署和扩展、技术多样性容错隔离"}',
        "analysis": "微服务优势：独立部署、独立扩展、技术多样性、容错隔离、团队自治。复杂性高是挑战。"
    })

    questions.append({
        "question": "服务注册中心（如Eureka、Nacos）的作用是？",
        "answer": "B",
        "type": 2,
        "options": '{"A":"存储配置信息","B":"服务发现和服务注册","C":"负载均衡","D":"服务监控"}',
        "analysis": "服务注册中心提供服务发现、服务注册、健康检查等功能，使服务间可以相互发现。"
    })

    # 填空
    questions.append({
        "question": "API网关（API Gateway）的主要作用是：统一入口、路由转发、____、协议转换。",
        "answer": "安全认证/限流",
        "type": 1,
        "analysis": "API网关作用：统一入口、路由转发、安全认证（认证授权）、限流熔断、协议转换。"
    })

    return questions


def gen_cryptography_questions():
    """密码学基础题目"""
    questions = []

    # 单选
    questions.append({
        "question": "对称加密和非对称加密的主要区别是？",
        "answer": "C",
        "type": 2,
        "options": '{"A":"对称加密更安全","B":"非对称加密使用两个密钥，对称加密使用一个","C":"对称加密使用同一密钥加密解密，非对称加密使用公钥加密私钥解密","D":"非对称加密速度更快"}',
        "analysis": "对称加密使用相同密钥，非对称加密使用公钥加密私钥解密。非对称加密更安全但速度慢。"
    })

    questions.append({
        "question": "数字签名主要用于？",
        "answer": "A",
        "type": 2,
        "options": '{"A":"验证消息的完整性和发送者身份","B":"加密消息内容","C":"加速数据传输","D":"存储数据"}',
        "analysis": "数字签名用于验证消息完整性、发送者身份、防止抵赖。使用发送者的私钥签名。"
    })

    # 填空
    questions.append({
        "question": "哈希函数（Hash Function）的两个核心特性是：____和不可逆性。",
        "answer": "单向性/确定性",
        "type": 1,
        "analysis": "哈希函数特性：单向性（无法反向推导）、确定性（相同输入必相同输出）、雪崩效应。"
    })

    return questions


def gen_testing_questions():
    """软件测试题目"""
    questions = []

    # 单选
    questions.append({
        "question": "单元测试的主要目的是？",
        "answer": "B",
        "type": 2,
        "options": '{"A":"验证整个系统的功能","B":"验证单个模块或函数的功能","C":"测试用户界面","D":"测试系统性能"}',
        "analysis": "单元测试验证单个模块或函数的功能，是最基础的测试，通常由开发人员编写。"
    })

    questions.append({
        "question": "黑盒测试和白盒测试的区别是？",
        "answer": "C",
        "type": 2,
        "options": '{"A":"黑盒测试更彻底","B":"白盒测试不需要测试用例","C":"黑盒测试关注功能，白盒测试关注代码结构","D":"两者没有区别"}',
        "analysis": "黑盒测试从用户角度测试功能，不关注内部结构；白盒测试关注代码内部逻辑和结构。"
    })

    # 多选
    questions.append({
        "question": "以下哪些是测试金字塔的层级？",
        "answer": "A,B,C",
        "type": 3,
        "options": '{"A":"单元测试（底层，最多）","B":"集成测试（中层）","C":"端到端测试（顶层，最少）","D":"性能测试","E":"安全测试"}',
        "analysis": "测试金字塔：底层单元测试（最多）、中层集成测试、顶层E2E测试（最少）。性能测试和安全测试是专项测试。"
    })

    # 填空
    questions.append({
        "question": "测试覆盖率（Test Coverage）用于衡量____被测试用例覆盖的程度。",
        "answer": "代码或功能",
        "type": 1,
        "analysis": "测试覆盖率衡量代码或功能被测试覆盖的程度，包括语句覆盖、分支覆盖、条件覆盖等。"
    })

    return questions


# ============ 题目生成和插入 ============

def generate_questions():
    """生成所有题目"""
    all_questions = []

    # 生成各类题目
    generators = [
        gen_java_design_pattern_questions,
        gen_java_reflection_questions,
        gen_java_generics_questions,
        gen_xss_questions,
        gen_sql_injection_questions,
        gen_ios_security_questions,
        gen_gdpr_questions,
        gen_java_collection_questions,
        gen_java_multithreading_questions,
        gen_java_io_questions,
        gen_java_exception_questions,
        gen_network_questions,
        gen_database_questions,
        gen_linux_questions,
        gen_data_structure_questions,
        gen_algorithm_questions,
        gen_web_security_questions,
        gen_android_security_questions,
        gen_git_questions,
        gen_docker_questions,
        gen_microservices_questions,
        gen_cryptography_questions,
        gen_testing_questions,
    ]

    for gen in generators:
        all_questions.extend(gen())

    return all_questions


def generate_sql(all_questions):
    """生成SQL插入语句"""
    sql_statements = []

    sql_statements.append("USE labex;")

    # 清空现有题目（可选）
    sql_statements.append("-- 清空现有题目（如果需要）")
    sql_statements.append("-- TRUNCATE TABLE t_question;")
    sql_statements.append("-- TRUNCATE TABLE t_question_test_case;")

    for i, q in enumerate(all_questions):
        qid = i + 1
        question = q["question"].replace('"', '\\"').replace("'", "\\'")
        answer = q.get("answer", "").replace('"', '\\"').replace("'", "\\'")
        options = q.get("options", "").replace('"', '\\"').replace("'", "\\'")
        analysis = q.get("analysis", "").replace('"', '\\"').replace("'", "\\'")
        qtype = q.get("type", 2)
        score = q.get("score", 10)

        # 编程题特殊字段
        is_programming = q.get("is_programming", 0)
        language = q.get("language", "")
        template_code = q.get("template_code", "")
        io_mode = q.get("io_mode", "")

        if is_programming:
            sql = f"""INSERT INTO t_question (question, answer, type, score, options, analysis, is_programming, language, template_code, io_mode, teacher_id, state)
VALUES ('{question}', '{answer}', {qtype}, {score}, '{options}', '{analysis}', {is_programming}, '{language}', '{template_code}', '{io_mode}', 2, 1);"""
        else:
            sql = f"""INSERT INTO t_question (question, answer, type, score, options, analysis, teacher_id, state)
VALUES ('{question}', '{answer}', {qtype}, {score}, '{options}', '{analysis}', 2, 1);"""

        sql_statements.append(sql)

        # 如果是编程题，添加测试用例
        if "test_cases" in q and q["test_cases"]:
            for j, tc in enumerate(q["test_cases"]):
                tc_input = tc.get("input", "").replace("'", "\\'")
                tc_output = tc.get("expected_output", "").replace("'", "\\'")
                tc_weight = tc.get("score_weight", 10)
                tc_index = tc.get("sort_index", j)

                test_sql = f"""INSERT INTO t_question_test_case (question_id, input, expected_output, score_weight, sort_index)
VALUES ({qid}, '{tc_input}', '{tc_output}', {tc_weight}, {tc_index});"""
                sql_statements.append(test_sql)

    return "\n".join(sql_statements)


if __name__ == "__main__":
    print("开始生成2000道题目...")
    questions = generate_questions()
    print(f"生成了 {len(questions)} 道题目")

    sql = generate_sql(questions)

    with open("2000_questions.sql", "w", encoding="utf-8") as f:
        f.write(sql)

    print("SQL已保存到 2000_questions.sql")

    # 统计
    type_counts = {1: 0, 2: 0, 3: 0, 5: 0, 6: 0}
    for q in questions:
        type_counts[q["type"]] = type_counts.get(q["type"], 0) + 1

    print("\n题目类型分布：")
    type_names = {1: "填空", 2: "单选", 3: "多选", 5: "简答", 6: "编程"}
    for t, c in type_counts.items():
        print(f"  {type_names.get(t, t)}: {c} 道")

    print(f"\n总计：{len(questions)} 道题目")
    print(f"包含测试用例的编程题：{sum(1 for q in questions if 'test_cases' in q)} 道")