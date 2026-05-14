#!/usr/bin/env python3
"""
批量生成2000道题库题目
"""

def q_single(question, options, answer, analysis=""):
    return {
        "question": question, "type": 2, "options": options,
        "answer": answer, "analysis": analysis
    }

def q_multi(question, options, answer, analysis=""):
    return {
        "question": question, "type": 3, "options": options,
        "answer": answer, "analysis": analysis
    }

def q_fill(question, answer, analysis=""):
    return {
        "question": question, "type": 1, "options": "",
        "answer": answer, "analysis": analysis
    }

def q_program(question, answer, test_cases, analysis="", template="", language="java"):
    return {
        "question": question, "type": 6, "options": "",
        "answer": answer, "analysis": analysis,
        "is_programming": 1, "language": language,
        "template_code": template, "io_mode": "standard",
        "test_cases": test_cases
    }

def q_short(question, answer, analysis=""):
    return {
        "question": question, "type": 5, "options": "",
        "answer": answer, "analysis": analysis
    }


def gen_math_variations():
    """生成数学相关的多样题目"""
    questions = []
    speeds = [2, 3, 4, 5, 6, 8, 10, 12, 15]
    distances = [10, 20, 30, 40, 50, 60, 80, 100, 120, 200]
    times_list = [5, 10, 15, 20, 25, 30, 40, 50, 60]

    # 速度时间距离问题 - 单选
    for speed in speeds[:5]:
        for dist in distances[:3]:
            time = dist / speed
            q = f"一个人以{speed}m/s的速度走完{dist}米需要多少秒？"
            opt = '{"A":"' + str(time - 2) + '","B":"' + str(time) + '","C":"' + str(time + 2) + '","D":"' + str(time * 2) + '"}'
            questions.append(q_single(q, opt, "B", f"时间=距离÷速度={dist}÷{speed}={time}秒"))

    # 时间计算问题 - 单选
    for t in times_list[:5]:
        for speed in speeds[:3]:
            dist = t * speed
            q = f"一个人以{speed}m/s的速度行走{t}秒，能走多远？"
            opt = '{"A":"' + str(dist - 10) + '","B":"' + str(dist) + '","C":"' + str(dist + 10) + '","D":"' + str(dist * 2) + '"}'
            questions.append(q_single(q, opt, "B", f"距离=速度×时间={speed}×{t}={dist}米"))

    # 填空题
    fill_qs = [
        ("一个物体以{v1}m/s的速度运动，{t}秒后走了____米。", "{result}"),
        ("速度为{v1}m/s，{dist}米的路程需要____秒。", "{result}"),
        ("一个人以{v1}m/s的速度走完{dist}米，用时____秒。", "{result}"),
        ("速度单位m/s表示____时间内通过的距离。", "每秒"),
        ("计算平均速度的公式是____除以时间。", "路程"),
        ("匀速直线运动中，速度保持____。", "不变或恒定"),
    ]
    for q_template, a_template in fill_qs:
        for v1, dist, t in [(3, 30, 10), (5, 50, 10), (4, 40, 10), (2, 20, 10), (6, 60, 10)]:
            q = q_template.format(v1=v1, dist=dist, t=t)
            if "{result}" in a_template:
                result = v1 * t
                a = str(result)
            else:
                a = a_template
            questions.append(q_fill(q, a))

    return questions


def gen_programming_problems():
    """生成编程题"""
    questions = []

    # 编程题1：两数之和
    questions.append(q_program(
        "给定一个整数数组nums和一个目标值target，请找出数组中两个数之和等于target的两个索引。假设每题只有一个答案，不能使用同一元素两次。返回两个索引的数组（顺序无所谓）。\n\n示例：\n输入: nums=[2,7,11,15], target=9\n输出: [0,1]（因为nums[0]+nums[1]=2+7=9）\n\n输入: nums=[3,2,4], target=6\n输出: [1,2]",
        "",
        [
            {"input": "[2,7,11,15]\n9", "expected_output": "[0, 1]", "score_weight": 40, "sort_index": 0},
            {"input": "[3,2,4]\n6", "expected_output": "[1, 2]", "score_weight": 30, "sort_index": 1},
            {"input": "[3,3]\n6", "expected_output": "[0, 1]", "score_weight": 30, "sort_index": 2}
        ],
        "考察哈希表或双指针思想。",
        "import java.util.*;\n\npublic class Solution {\n    public int[] twoSum(int[] nums, int target) {\n        // TODO: 使用哈希表实现两数之和\n        return new int[]{0, 1};\n    }\n}"
    ))

    # 编程题2：反转链表
    questions.append(q_program(
        "给定一个单链表，反转链表并返回反转后的链表头节点。\n\n示例：\n输入: 1->2->3->4->5\n输出: 5->4->3->2->1\n\n输入: 1->2\n输出: 2->1",
        "",
        [
            {"input": "1,2,3,4,5", "expected_output": "5,4,3,2,1", "score_weight": 50, "sort_index": 0},
            {"input": "1,2", "expected_output": "2,1", "score_weight": 50, "sort_index": 1}
        ],
        "考察链表操作和递归/迭代思想。",
        "class ListNode {\n    int val;\n    ListNode next;\n    ListNode(int x) { val = x; }\n}\n\npublic class Solution {\n    public ListNode reverseList(ListNode head) {\n        // TODO: 实现链表反转\n        return head;\n    }\n}"
    ))

    # 编程题3：合并两个有序数组
    questions.append(q_program(
        "给定两个升序整数数组nums1和nums2，将nums2合并到nums1中，返回合并后的有序数组。假设nums1有足够空间（大小>=m+n），前面m个元素有效，后面n个元素初始化为0。\n\n示例：\n输入: nums1=[1,2,3], m=3, nums2=[2,5,6], n=3\n输出: [1,2,2,3,5,6]",
        "",
        [
            {"input": "[1,2,3]\n3\n[2,5,6]\n3", "expected_output": "[1, 2, 2, 3, 5, 6]", "score_weight": 100, "sort_index": 0}
        ],
        "考察双指针从后往前合并。",
        "import java.util.*;\n\npublic class Solution {\n    public void merge(int[] nums1, int m, int[] nums2, int n) {\n        // TODO: 合并两个有序数组\n    }\n}"
    ))

    # 编程题4：有效的括号
    questions.append(q_program(
        "给定一个只包括'('，')'，'{'，'}'，'['，']'的字符串，判断括号是否匹配。\n左括号必须用相同类型的右括号闭合，左括号必须以正确的顺序闭合。\n\n示例：\n输入: \"()\"  输出: true\n输入: \"()[]{}\"  输出: true\n输入: \"(]\"  输出: false\n输入: \"([)]\"  输出: false",
        "",
        [
            {"input": "()", "expected_output": "true", "score_weight": 25, "sort_index": 0},
            {"input": "()[]{}", "expected_output": "true", "score_weight": 25, "sort_index": 1},
            {"input": "(]", "expected_output": "false", "score_weight": 25, "sort_index": 2},
            {"input": "([)]", "expected_output": "false", "score_weight": 25, "sort_index": 3}
        ],
        "考察栈的使用。",
        "import java.util.*;\n\npublic class Solution {\n    public boolean isValid(String s) {\n        // TODO: 使用栈判断括号匹配\n        return false;\n    }\n}"
    ))

    # 编程题5：最大子序和
    questions.append(q_program(
        "给定一个整数数组nums，找到连续子数组（至少包含一个元素）具有最大和，返回最大和。\n\n示例：\n输入: [-2,1,-3,4,-1,2,1,-5,4]\n输出: 6（子数组[4,-1,2,1]和最大）\n\n输入: [1]\n输出: 1\n\n输入: [5,4,-1,7,8]\n输出: 23",
        "",
        [
            {"input": "[-2,1,-3,4,-1,2,1,-5,4]", "expected_output": "6", "score_weight": 50, "sort_index": 0},
            {"input": "[1]", "expected_output": "1", "score_weight": 25, "sort_index": 1},
            {"input": "[5,4,-1,7,8]", "expected_output": "23", "score_weight": 25, "sort_index": 2}
        ],
        "考察贪心算法或动态规划（Kadane算法）。",
        "import java.util.*;\n\npublic class Solution {\n    public int maxSubArray(int[] nums) {\n        // TODO: 实现最大子序和\n        return 0;\n    }\n}"
    ))

    # 编程题6：爬楼梯
    questions.append(q_program(
        "假设你正在爬楼梯，需要n阶才能到达顶部。每次你可以爬1阶或2阶。有多少种不同的方法可以爬到顶部？\n\n示例：\n输入: 2\n输出: 2（1+1 或 2）\n\n输入: 3\n输出: 3（1+1+1、1+2、2+1）\n\n输入: 4\n输出: 5（1+1+1+1、1+1+2、1+2+1、2+1+1、2+2）",
        "",
        [
            {"input": "2", "expected_output": "2", "score_weight": 30, "sort_index": 0},
            {"input": "3", "expected_output": "3", "score_weight": 30, "sort_index": 1},
            {"input": "4", "expected_output": "5", "score_weight": 40, "sort_index": 2}
        ],
        "考察动态规划，斐波那契数列。",
        "public class Solution {\n    public int climbStairs(int n) {\n        // TODO: 实现爬楼梯方法计数\n        return 0;\n    }\n}"
    ))

    # 编程题7：二叉树中序遍历
    questions.append(q_program(
        "给定一个二叉树，返回其中序遍历（左子树->根->右子树）的节点值序列。\n\n示例：\n    1\n   / \\\n  2   3\n /\n4\n输入: [1,null,2,3,4]\n输出: [4,2,1,3]（或[4, 2, 1, 3]）",
        "",
        [
            {"input": "[1,null,2,3,4]", "expected_output": "[4, 2, 1, 3]", "score_weight": 100, "sort_index": 0}
        ],
        "考察二叉树遍历和递归/迭代实现。",
        "import java.util.*;\n\nclass TreeNode {\n    int val;\n    TreeNode left, right;\n    TreeNode(int x) { val = x; }\n}\n\npublic class Solution {\n    public List<Integer> inorderTraversal(TreeNode root) {\n        // TODO: 实现中序遍历\n        return new ArrayList<>();\n    }\n}"
    ))

    # 编程题8：判断回文数
    questions.append(q_program(
        "给定一个整数x，如果x是回文数则返回true。回文数是指正序（从左向右）和倒序（从右向左）读都是一样的整数。\n\n示例：\n输入: 121  输出: true（121反转还是121）\n输入: -121 输出: false（-121反转是121-）\n输入: 10   输出: false（10反转是01）",
        "",
        [
            {"input": "121", "expected_output": "true", "score_weight": 30, "sort_index": 0},
            {"input": "-121", "expected_output": "false", "score_weight": 30, "sort_index": 1},
            {"input": "10", "expected_output": "false", "score_weight": 40, "sort_index": 2}
        ],
        "考察数字反转和字符串操作。",
        "public class Solution {\n    public boolean isPalindrome(int x) {\n        // TODO: 判断回文数\n        return false;\n    }\n}"
    ))

    return questions


def gen_common_programming():
    """生成通用编程题目"""
    questions = []
    problem_templates = [
        ("斐波那契数列第n项", "返回斐波那契数列第n项的值。F(0)=0, F(1)=1, F(n)=F(n-1)+F(n-2)",
         ["5->5", "10->55", "15->610"], "考察递归或迭代"),
        ("判断质数", "判断一个数n是否是质数（质数定义为大于1的自然数，除了1和它本身外不能被其他自然数整除）",
         ["2->true", "4->false", "17->true"], "考察质数判断"),
        ("求阶乘", "计算n的阶乘（n! = n × (n-1) × ... × 2 × 1）",
         ["5->120", "0->1", "10->3628800"], "考察循环或递归"),
        ("求最大公约数", "使用欧几里得算法求两个数的最大公约数",
         ["12,8->4", "24,18->6", "100,25->25"], "考察辗转相除法"),
        ("求最小公倍数", "求两个数的最小公倍数",
         ["4,6->12", "5,10->10", "7,3->21"], "考察LCM公式"),
        ("杨辉三角第n行", "返回杨辉三角第n行（索引从0开始）",
         ["0->[1]", "1->[1,1]", "3->[1,3,3,1]"], "考察二维数组"),
        ("最后一个单词长度", "给定字符串，找到最后一个单词的长度",
         ["hello world->5", "happy birthday->8", "a->1"], "考察字符串处理"),
        ("杨辉三角生成", "生成前n行杨辉三角",
         ["3->[[1],[1,1],[1,2,1]]", "5->[[1],[1,1],[1,2,1],[1,3,3,1],[1,4,6,4,1]]"], "考察二维数组"),
        ("岛屿数量", "给定二维网格，'1'表示陆地，'0'表示水，计算岛屿数量",
         ["11110->1", "11000->1", "11001->2"], "考察DFS/BFS"),
        ("括号生成", "生成n对括号的所有有效组合",
         ["1->[()]", "2->[()(), ()()]", "3->[((())), (()()), (())(), ()(()), ()()()]"], "考察回溯算法"),
        ("搜索旋转排序数组", "在旋转后的升序数组中搜索target",
         ["[4,5,6,7,0,1,2], target=0->4", "[4,5,6,7,0,1,2], target=3->-1"], "考察二分查找变体"),
        ("在排序数组中查找元素位置", "在排序数组中查找target的起始和结束位置",
         ["[5,7,7,8,8,10], target=8->[3,4]", "[5,7,7,8,8,10], target=6->[-1,-1]"], "考察二分查找"),
        ("移动零", "将数组中所有0移到末尾，同时保持非零元素的相对顺序",
         ["[0,1,0,3,12]->[1,3,12,0,0]", "[0,0,1]->[1,0,0]"], "考察双指针"),
("买卖股票最佳时机", "给定数组prices，第i个元素是第i天的股票价格，最多交易一次（买一次卖一次），获取最大利润",
         ["[7,1,5,3,6,4]->5", "[7,6,4,3,1]->0"], "考察一次遍历"),
        ("反转字符串", "原地反转字符串",
         ["hello->olleh", "world->dlrow", "a->a"], "考察双指针或交换"),
        ("字符串转整数", "实现字符串转整数（类似atoi）",
         ["42->42", "   -42->-42", "4193 with words->4193"], "考察状态机处理"),
        ("合并区间", "合并重叠的区间",
         ["[[1,3],[2,6],[8,10],[15,18]]->[[1,6],[8,10],[15,18]]", "[[1,4],[4,5]]->[[1,5]]"], "考察排序和区间合并"),
        ("简化路径", "Unix风格简化文件路径",
         ["/home/->/home", "/../->/", "/home//foo/->/home/foo"], "考察栈处理"),
        ("数组中出现次数超过一半的数字", "找到数组中出现次数超过数组长度一半的数字",
         ["[1,2,3,2,2,2,5,2]->2", "[1]->1"], "考察摩尔投票算法"),
        ("构建乘积数组", "给定数组A，构建数组B，其中B[i]是A数组中除A[i]外所有元素的乘积",
         ["[1,2,3,4]->[24,12,8,6]", "[1,2,3]->[6,3,2]"], "考察数学思维"),
    ]

    for name, desc, cases, analysis in problem_templates:
        test_cases = []
        for case in cases:
            parts = case.split("->")
            inp = parts[0]
            expected = parts[1]
            test_cases.append({
                "input": inp,
                "expected_output": expected,
                "score_weight": 25,
                "sort_index": cases.index(case)
            })

        q = f"实现{name}：{desc}\n\n测试用例：\n" + "\n".join([f"输入: {tc['input']} 输出: {tc['expected_output']}" for tc in test_cases])

        template = "// 请实现 " + name

        questions.append(q_program(q, "", test_cases, analysis, template))

    return questions


def generate_single_questions():
    """生成单选题"""
    questions = []

    # Java基础
    java_basics = [
        ("Java中，以下哪个不是基本数据类型？", '{"A":"int","B":"String","C":"double","D":"boolean"}', "B", "String是引用类型，不是基本数据类型。"),
        ("以下哪个修饰符表示方法可以被继承？", '{"A":"final","B":"static","C":"protected","D":"abstract"}', "C", "protected成员可以被继承；final不能被继承；static不涉及继承；abstract方法需要被子类实现。"),
        ("以下哪个是无限循环？", '{"A":"for(;;)","B":"while(true)","C":"do{}while(true)","D":"以上都是"}', "D", "for(;;)、while(true)、do{}while(true)都是无限循环。"),
        ("以下哪个操作不会改变数组内容？", '{"A":"增强for循环读取","B":"Arrays.sort()","C":"使用下标赋值","D":"以上都是"}', "A", "增强for循环只是读取，不会修改数组；sort()会改变数组顺序；赋值会修改元素。"),
        ("以下哪个方法不能继承？", '{"A":"构造方法","B":"实例方法","C":"静态方法","D":"私有方法"}', "A", "构造方法不能被继承，但可以通过super()调用。"),
        ("以下哪个是接口的默认方法特性？", '{"A":"可以有方法体","B":"不能有方法体","C":"必须被实现","D":"不能有静态方法"}', "A", "Java 8起接口可以有default方法和static方法，default方法有默认实现。"),
        ("以下哪个集合是有序的？", '{"A":"HashSet","B":"TreeSet","C":"LinkedHashSet的插入顺序","D":"B和C"}', "D", "TreeSet自然排序，LinkedHashSet保持插入顺序，HashSet无序。"),
        ("以下哪个不是线程安全类？", '{"A":"Vector","B":"HashTable","C":"ArrayList","D":"ConcurrentHashMap"}', "C", "ArrayList不是线程安全；Vector、HashTable、ConcurrentHashMap都是线程安全的。"),
        ("以下哪个注解表示弃用？", '{"A":"@Override","B":"@Deprecated","C":"@SuppressWarnings","D":"@FunctionalInterface"}', "B", "@Deprecated标记弃用的类/方法；@Override标记重写；@SuppressWarnings抑制警告；@FunctionalInterface标记函数式接口。"),
        ("以下哪个关键字表示跳过本次循环？", '{"A":"break","B":"continue","C":"return","D":"exit"}', "B", "break结束整个循环；continue跳过本次循环；return结束方法；exit退出JVM。"),
        ("String类的trim()方法作用是？", '{"A":"去除首尾空格","B":"去除所有空格","C":"转小写","D":"转大写"}', "A", "trim()去除首尾空白字符，不处理中间空格。"),
        ("以下哪个方法可以获取字符串长度？", '{"A":"size()","B":"length()","C":"getSize()","D":"count()"}', "B", "String用length()；集合用size()；数组用length属性。"),
        ("以下哪个是重载（Overload）的特征？", '{"A":"方法名相同，参数列表不同","B":"方法名不同，参数列表相同","C":"方法名和参数列表都相同","D":"返回类型不同"}', "A", "重载：同类方法名相同，参数列表不同（类型或个数），与返回类型无关。"),
        ("以下哪个关键字用于抛出异常？", '{"A":"throw","B":"throws","C":"try","D":"catch"}', "A", "throw抛出异常对象；throws方法签名声明异常；try-catch捕获处理异常。"),
        ("以下哪个是抽象类的特征？", '{"A":"可以实例化","B":"可以有抽象方法","C":"不能用final修饰","D":"B和C"}', "D", "抽象类不能实例化，可以有抽象方法，不能用final修饰（否则无法继承）。"),
        ("以下哪个是内部类的优势？", '{"A":"可以访问外部类的所有成员","B":"可以实现多重继承","C":"可以提高代码封装性","D":"以上都是"}', "D", "内部类可以访问外部类所有成员、可以实现多重继承、提高封装性。"),
        ("以下哪个修饰符的成员不能被继承？", '{"A":"public","B":"protected","C":"private","D":"default"}', "C", "private成员不能被继承；public/protected/default在不同作用域可被继承。"),
        ("以下哪个方法用于线程同步？", '{"A":"wait()","B":"notify()","C":"synchronized","D":"以上都是"}', "D", "wait()、notify()、notifyAll()用于线程通信；synchronized用于同步。"),
        ("以下哪个是HashMap的工作原理？", '{"A":"数组+链表","B":"数组+红黑树","C":"链表","D":"数组"}', "B", "JDK 1.8后HashMap使用数组+链表/红黑树解决哈希冲突，链表超过8转为红黑树。"),
        ("以下哪个操作会产生OOM？", '{"A":"new byte[1024]","B":"new byte[Integer.MAX_VALUE]","C":"递归深度过大","D":"B和C"}', "D", "创建超大数组会导致OOM；递归深度过大导致StackOverflowError。"),
    ]
    for q, opt, a, an in java_basics:
        questions.append(q_single(q, opt, a, an))

    # Web安全
    web_security = [
        ("SQL注入攻击属于哪种攻击类型？", '{"A":"代码注入","B":"物理攻击","C":"社会工程","D":"拒绝服务"}', "A", "SQL注入是代码注入攻击，通过在SQL语句中插入恶意代码。"),
        ("以下哪个HTTP头可以防止XSS？", '{"A":"Content-Security-Policy","B":"X-Frame-Options","C":"Strict-Transport-Security","D":"X-Content-Type-Options"}', "A", "CSP用于限制脚本来源防护XSS；X-Frame-Options防点击劫持；HSTS防中间人。"),
        ("CSRF攻击利用浏览器的什么特性？", '{"A":"Cookie自动发送","B":"缓存机制","C":"同源策略","D":"跨域请求"}', "A", "CSRF利用浏览器会自动发送同源Cookie的特性，欺骗服务器执行恶意请求。"),
        ("以下哪个不是防护CSRF的措施？", '{"A":"验证码","B":"Referer验证","C":"Token验证","D":"使用HTTP"}', "D", "HTTPS是加密传输，不能防护CSRF。验证码、Referer验证、Token验证都是CSRF防护手段。"),
        ("以下哪个是存储型XSS的特征？", '{"A":"恶意代码存储在服务器","B":"恶意代码不经过服务器","C":"只在客户端执行","D":"不需要用户交互"}', "A", "存储型XSS的恶意代码被永久存储在目标服务器上，所有访问该数据的用户都会被攻击。"),
        ("以下哪个HTTP头用于防护点击劫持？", '{"A":"X-Frame-Options","B":"Content-Security-Policy","C":"X-XSS-Protection","D":"Cache-Control"}', "A", "X-Frame-Options可以防止页面被iframe嵌入，防护点击劫持。"),
        ("MyBatis中${}和#{}的区别是？", '{"A":"${}直接替换，#{}使用参数化","B":"两者没有区别","C":"#{}直接替换，${}使用参数化","D":"${}更安全"}', "A", "${}直接字符串替换存在SQL注入风险；#{}使用预编译参数化更安全。"),
        ("数字信封的组成是？", '{"A":"用对称密钥加密数据，用接收方公钥加密对称密钥","B":"用接收方公钥加密数据","C":"用发送方私钥加密数据","D":"用对称密钥加密密钥"}', "A", "数字信封：用对称密钥加密数据，用接收方公钥加密对称密钥，兼顾效率和安全性。"),
        ("以下哪个不是安全的密码存储方式？", '{"A":"明文存储","B":"MD5哈希","C":"BCrypt哈希","D":"PBKDF2哈希"}', "A", "密码应使用加盐哈希（BCrypt、PBKDF2、Argon2）存储，明文和MD5都不安全。"),
        ("以下哪个是同源策略的作用？", '{"A":"防止跨域请求","B":"防止读取其他源的数据","C":"限制Cookie发送","D":"以上都是"}', "D", "同源策略限制不同源之间的资源访问，防止XSS等攻击。"),
        ("XSS攻击的主要危害包括？", '{"A":"窃取Cookie","B":"修改页面内容","C":"植入恶意软件","D":"以上都是"}', "D", "XSS可造成：窃取认证信息、篡改页面、植入恶意代码、发起其他攻击。"),
        ("文件上传漏洞的主要危害是？", '{"A":"消耗存储空间","B":"上传WebShell执行命令","C":"导致服务器崩溃","D":"用户无法上传"}', "B", "文件上传漏洞可导致恶意脚本在服务器执行，造成命令执行等严重后果。"),
        ("以下哪个不是正确的会话管理措施？", '{"A":"会话超时验证","B":"使用安全的Cookie属性","C":"在URL中传递SessionID","D":"登录时更换SessionID"}', "C", "URL传递SessionID不安全，应使用Cookie并配置HttpOnly、Secure、SameSite属性。"),
        ("SSRF攻击的主要危害是？", '{"A":"读取内网数据","B":"扫描内网端口","C":"攻击内部服务","D":"以上都是"}', "D", "SSRF可访问内网数据、扫描端口、攻击内部服务如云元数据。"),
        ("以下哪个是Web应用防火墙（WAF）的特点？", '{"A":"工作在应用层","B":"检测和阻止Web攻击","C":"不能完全替代输入验证","D":"以上都是"}', "D", "WAF是应用层防护，检测阻止Web攻击，但不能替代应用层输入验证。"),
    ]
    for q, opt, a, an in web_security:
        questions.append(q_single(q, opt, a, an))

    # 计算机网络
    network = [
        ("TCP三次握手的作用是？", '{"A":"建立可靠连接","B":"传输数据","C":"断开连接","D":"加密数据"}', "A", "三次握手建立可靠连接，确认双方收发能力正常。"),
        ("HTTP状态码404表示？", '{"A":"服务器内部错误","B":"资源未找到","C":"禁止访问","D":"重定向"}', "B", "404表示请求的资源在服务器上不存在。"),
        ("以下哪个是四次挥手的FIN报文作用？", '{"A":"建立连接请求","B":"确认收到","C":"释放连接请求","D":"重传数据"}', "C", "FIN用于释放连接请求。"),
        ("HTTPS使用什么协议加密？", '{"A":"SSL","B":"TLS","C":"SSH","D":"IPSec"}', "B", "HTTPS使用TLS（Transport Layer Security）加密。"),
        ("DNS主要工作端口是？", '{"A":"21","B":"53","C":"80","D":"443"}', "B", "DNS使用53端口（UDP/TCP）。"),
        ("TCP的滑动窗口用于？", '{"A":"流量控制","B":"拥塞控制","C":"差错控制","D":"连接管理"}', "A", "滑动窗口用于流量控制，接收方通过窗口大小告知发送方可发送的数据量。"),
        ("Cookie和Session的主要区别是？", '{"A":"存储位置不同","B":"安全性不同","C":"大小限制不同","D":"以上都是"}', "D", "Cookie存储在客户端，Session存储在服务器；Session更安全但占用服务器资源。"),
        ("以下哪个不是HTTP方法？", '{"A":"GET","B":"POST","C":"PUT","D":"COPY"}', "D", "HTTP方法：GET、POST、PUT、DELETE、HEAD、OPTIONS等。COPY不是HTTP方法。"),
        ("TCP和UDP的主要区别是？", '{"A":"连接vs无连接","B":"可靠vs不可靠","C":"有序vs无序","D":"以上都是"}', "D", "TCP面向连接、可靠传输、有序；UDP无连接、不可靠、无序但更高效。"),
        ("在TCP/IP模型中，HTTP属于哪一层？", '{"A":"应用层","B":"传输层","C":"网络层","D":"网络接口层"}', "A", "HTTP是应用层协议。"),
    ]
    for q, opt, a, an in network:
        questions.append(q_single(q, opt, a, an))

    # 数据库
    database = [
        ("MySQL中，InnoDB和MyISAM的主要区别是？", '{"A":"事务支持","B":"外键支持","C":"锁粒度","D":"以上都是"}', "D", "InnoDB支持事务、外键、行级锁；MyISAM不支持事务和外键，只支持表级锁。"),
        ("以下哪个是索引的作用？", '{"A":"加快查询速度","B":"节省存储","C":"保证数据唯一","D":"以上都是"}', "D", "索引加快查询、节省存储（唯一索引）、保证数据唯一性。"),
        ("事务的ACID中，D代表什么？", '{"A":"原子性","B":"一致性","C":"隔离性","D":"持久性"}', "D", "ACID：Atomicity原子性、Consistency一致性、Isolation隔离性、Durability持久性。"),
        ("以下哪个SQL语句用于授权？", '{"A":"GRANT","B":"REVOKE","C":"CREATE USER","D":"DROP USER"}', "A", "GRANT授权，REVOKE撤销权限。"),
        ("Redis的ZSet适用于什么场景？", '{"A":"排行榜","B":"标签系统","C":"去重","D":"消息队列"}', "A", "ZSet有序集合带分数，适合排行榜。Set去重、List消息队列、Hash存储对象。"),
        ("以下哪个是Redis的持久化方式？", '{"A":"RDB","B":"AOF","C":"两者都是","D":"两者都不是"}', "C", "Redis支持RDB（快照）和AOF（日志）两种持久化方式。"),
        ("SQL的GROUP BY用于？", '{"A":"分组聚合计算","B":"排序","C":"过滤","D":"连接"}', "A", "GROUP BY将结果分组，配合聚合函数进行分组统计。"),
        ("以下哪个隔离级别可以防止脏读？", '{"A":"READ COMMITTED","B":"READ UNCOMMITTED","C":"REPEATABLE READ","D":"SERIALIZABLE"}', "A", "READ COMMITTED防止脏读；READ UNCOMMITTED允许脏读；REPEATABLE READ防止脏读和不可重复读。"),
        ("数据库连接池的作用是？", '{"A":"减少连接创建开销","B":"提高并发性能","C":"管理连接生命周期","D":"以上都是"}', "D", "连接池复用连接，减少开销，提高性能，管理连接生命周期。"),
        ("以下哪个不是SQL的聚合函数？", '{"A":"SUM()","B":"AVG()","C":"CONCAT()","D":"COUNT()"}', "C", "CONCAT是字符串函数，不是聚合函数。"),
    ]
    for q, opt, a, an in database:
        questions.append(q_single(q, opt, a, an))

    # 数据结构与算法
    dsa = [
        ("数组和链表的主要区别是？", '{"A":"存储方式不同，性能特性不同","B":"没有区别","C":"数组是链式存储","D":"链表是连续存储"}', "A", "数组连续存储查询快增删慢；链表离散存储增删快查询慢。"),
        ("二叉树中，n0和n2的关系是？", '{"A":"n0=n2","B":"n0=n2+1","C":"n0=n2-1","D":"n0=2*n2"}', "B", "二叉树性质：n0=n2+1（叶子数=度为2节点数+1）。"),
        ("快速排序的平均时间复杂度是？", '{"A":"O(n)","B":"O(n log n)","C":"O(n^2)","D":"O(log n)"}', "B", "快排平均O(n log n)，最坏O(n^2)。"),
        ("以下哪个排序是稳定的？", '{"A":"快速排序","B":"归并排序","C":"堆排序","D":"选择排序"}', "B", "归并排序稳定；快速排序、堆排序、选择排序不稳定。"),
        ("二分查找的前提条件是？", '{"A":"数组有序","B":"数组无序","C":"数组长度已知","D":"数组元素唯一"}', "A", "二分查找要求数组有序。"),
        ("动态规划的核心是？", '{"A":"最优子结构","B":"重叠子问题","C":"状态转移方程","D":"以上都是"}', "D", "动态规划核心是最优子结构和重叠子问题，通过状态转移方程迭代求解。"),
        ("深度优先搜索（DFS）使用什么数据结构？", '{"A":"队列","B":"栈","C":"堆","D":"树"}', "B", "DFS使用栈（递归或显式栈）；BFS使用队列。"),
        ("以下哪个是堆的特征？", '{"A":"完全二叉树","B":"父节点大于等于子节点（最大堆）","C":"用于实现优先级队列","D":"以上都是"}', "D", "堆是完全二叉树，可分为最大堆和最小堆，常用于优先级队列和Top K问题。"),
        ("图的邻接矩阵和邻接表，哪个适合稀疏图？", '{"A":"邻接矩阵","B":"邻接表","C":"两者一样","D":"无法确定"}', "B", "邻接表适合稀疏图（省空间）；邻接矩阵适合稠密图。"),
        ("以下哪个不是常见的负载均衡算法？", '{"A":"轮询","B":"随机","C":"加权轮询","D":"哈希一致性但不包含IP"}', "D", "负载均衡算法：轮询、加权轮询、最少连接、加权最少连接、随机、源IP哈希等。"),
    ]
    for q, opt, a, an in dsa:
        questions.append(q_single(q, opt, a, an))

    # 操作系统
    os = [
        ("进程和线程的主要区别是？", '{"A":"资源分配 vs CPU调度","B":"线程是进程的组成部分","C":"进程有独立地址空间","D":"以上都是"}', "D", "进程是资源分配单位（有独立地址空间），线程是CPU调度单位（共享进程资源）。"),
        ("Linux中，以下哪个命令用于查看进程？", '{"A":"ps","B":"ls","C":"grep","D":"find"}', "A", "ps查看进程状态；ls列文件；grep搜索；find查找文件。"),
        ("以下哪个是虚拟内存的作用？", '{"A":"扩大地址空间","B":"提供进程间隔离","C":"通过页表映射","D":"以上都是"}', "D", "虚拟内存扩大进程地址空间，提供进程间隔离，通过页表实现地址映射。"),
        ("Shell脚本中，$#表示？", '{"A":"参数个数","B":"脚本名称","C":"第一个参数","D":"所有参数"}', "A", "$#参数个数、$@所有参数、$0脚本名、$1第一个参数。"),
        ("Linux文件权限中，rwx分别代表？", '{"A":"read, write, execute","B":"read, write, exit","C":"run, write, read","D":"read, exit, write"}', "A", "rwx代表读、写、执行权限。"),
        ("以下哪个是时间片轮转调度的特点？", '{"A":"每个任务轮流执行","B":"时间片用完切换","C":"保证公平性","D":"以上都是"}', "D", "时间片轮转将CPU时间分配给多个任务，轮流执行，保证公平性。"),
        ("内存泄漏是指？", '{"A":"内存无法被回收","B":"内存被错误释放","C":"内存越界访问","D":"内存不足"}', "A", "内存泄漏是程序分配内存后未释放，导致内存浪费。"),
        ("以下哪个不是死锁的必要条件？", '{"A":"互斥","B":"占有并等待","C":"不可抢占","D":"同步机制"}', "D", "死锁四必要条件：互斥、占有并等待、不可抢占、循环等待。同步机制不是必要条件。"),
        ("上下文切换发生在？", '{"A":"进程/线程切换时","B":"CPU从一个进程切换到另一个","C":"保存和恢复执行状态","D":"以上都是"}', "D", "上下文切换是保存当前进程/线程状态，加载另一个进程/线程状态的过程。"),
        ("以下哪个是Linux中的隐藏文件命名规则？", '{"A":"以.开头","B":"以-开头","C":"以~开头","D":"以_开头"}', "A", "Linux隐藏文件以.开头，如.bashrc。"),
    ]
    for q, opt, a, an in os:
        questions.append(q_single(q, opt, a, an))

    # 前端开发
    frontend = [
        ("JavaScript中，==和===的区别是？", '{"A":"==比较值，===比较值和类型","B":"没有区别","C":"===比较值，==比较类型","D":"==更快"}', "A", "==会类型转换后比较，===严格比较值和类型。"),
        ("以下哪个是ES6的箭头函数特点？", '{"A":"没有自己的this","B":"不能用做构造函数","C":"没有arguments","D":"以上都是"}', "D", "箭头函数：没有自己的this、不能用作构造函数、没有arguments。"),
        ("CSS Flex布局中，justify-content用于？", '{"A":"主轴对齐","B":"交叉轴对齐","C":"项目放大缩小","D":"主轴方向"}', "A", "justify-content设置主轴对齐；align-items设置交叉轴对齐。"),
        ("Vue的双向绑定原理是？", '{"A":"Object.defineProperty或Proxy","B":"脏检查","C":"数据劫持","D":"以上都是"}', "D", "Vue 2用Object.defineProperty，Vue 3用Proxy实现双向绑定。"),
        ("以下哪个不是HTML5新增的标签？", '{"A":"<article>","B":"<section>","C":"<font>","D":"<nav>"}', "C", "<font>是原有标签已废弃；<article>、<section>、<nav>都是HTML5新增的语义化标签。"),
        ("React中，useState的作用是？", '{"A":"创建状态变量","B":"创建副作用","C":"创建Refs","D":"创建上下文"}', "A", "useState用于在函数组件中创建状态和更新函数。"),
        ("以下哪个是Promise的状态？", '{"A":"pending","B":"fulfilled","C":"rejected","D":"以上都是"}', "D", "Promise状态：pending进行中、fulfilled已成功、rejected已失败。"),
        ("let和var的主要区别是？", '{"A":"let是块级作用域，var是函数作用域","B":"var有变量提升","C":"let不能重复声明","D":"以上都是"}', "D", "let是块级作用域、不提升、不能重复声明；var是函数作用域、存在提升。"),
        ("以下哪个HTTP头用于防止CSRF？", '{"A":"X-CSRF-Token","B":"Content-Type","C":"Accept","D":"User-Agent"}', "A", "X-CSRF-Token是常用的CSRF防护头。"),
        ("以下哪个不是CSS选择器？", '{"A":".class","B":"#id","C":"@media","D":"&element"}', "D", "&不是CSS选择器；.class类选择器、#id ID选择器、@media媒体查询。"),
    ]
    for q, opt, a, an in frontend:
        questions.append(q_single(q, opt, a, an))

    # 容器与DevOps
    devops = [
        ("Docker容器和虚拟机的主要区别是？", '{"A":"容器共享宿主机内核","B":"容器更轻量","C":"启动更快","D":"以上都是"}', "D", "容器共享内核更轻量（秒级启动），虚拟机隔离性更强但更重。"),
        ("以下哪个是Dockerfile的COPY和ADD的区别？", '{"A":"COPY只复制本地文件，ADD支持URL和自动解压","B":"ADD只复制本地文件","C":"两者没有区别","D":"COPY支持URL"}', "A", "ADD支持URL复制和tar自动解压；COPY只支持本地文件，推荐COPY。"),
        ("Kubernetes中，Pod的最小调度单位是？", '{"A":"Node","B":"Pod","C":"Cluster","D":"Namespace"}', "B", "Pod是K8s的最小调度单位，可以包含一个或多个容器。"),
        ("以下哪个是Git的merge和rebase的区别？", '{"A":"merge保留历史，rebase重写历史","B":"rebase保留历史","C":"两者没有区别","D":"merge用于创建分支"}', "A", "merge保留完整历史，rebase将提交平移产生线性历史。"),
        ("Docker的核心组件是？", '{"A":"Daemon","B":"Client","C":"Image和Container","D":"以上都是"}', "D", "Docker：Daemon运行容器、Client接收命令、Image镜像模板、Container运行实例。"),
        ("CI/CD中，CI是指？", '{"A":"持续集成","B":"持续部署","C":"持续交付","D":"持续监控"}', "A", "CI持续集成、CD持续部署/交付。"),
        ("以下哪个不是Docker的网络模式？", '{"A":"bridge","B":"host","C":"container","D":"swarm"}', "D", "Docker网络模式：bridge、host、none、container；swarm是容器编排工具。"),
        ("K8s中，Service的作用是？", '{"A":"服务发现和负载均衡","B":"副本管理","C":"配置管理","D":"存储管理"}', "A", "Service提供服务发现和负载均衡，为Pod提供稳定的访问入口。"),
        ("Dockerfile中，EXPOSE指令的作用是？", '{"A":"声明容器监听端口","B":"发布端口到宿主机","C":"设置环境变量","D":"复制文件"}', "A", "EXPOSE声明容器监听的端口，-p才是发布到宿主机。"),
        ("以下哪个是Helm在K8s中的作用？", '{"A":"包管理器","B":"模板渲染","C":"版本管理","D":"以上都是"}', "D", "Helm是K8s的包管理器，提供模板渲染、版本管理、依赖管理等。"),
    ]
    for q, opt, a, an in devops:
        questions.append(q_single(q, opt, a, an))

    # 加密与安全
    crypto = [
        ("对称加密和非对称加密的主要区别是？", '{"A":"密钥数量不同","B":"加密解密速度不同","C":"密钥分配方式不同","D":"以上都是"}', "D", "对称加密用一个密钥，非对称用公钥私钥一对；对称快，非对称密钥分配更安全。"),
        ("数字签名使用什么密钥？", '{"A":"发送方私钥","B":"发送方公钥","C":"接收方私钥","D":"接收方公钥"}', "A", "发送者用私钥签名，接收者用发送者公钥验证。"),
        ("以下哪个是哈希函数的特性？", '{"A":"单向性","B":"确定性","C":"雪崩效应","D":"以上都是"}', "D", "哈希函数：单向性（不可逆）、确定性（相同输入相同输出）、雪崩效应（微小变化大影响）。"),
        ("MD5的输出长度是？", '{"A":"128位","B":"160位","C":"256位","D":"512位"}', "A", "MD5输出128位（16字节），SHA-1输出160位，SHA-256输出256位。"),
        ("HTTPS的混合加密是指？", '{"A":"非对称加密交换密钥，对称加密传输数据","B":"对称和非对称都加密数据","C":"只使用非对称加密","D":"只使用对称加密"}', "A", "HTTPS用非对称加密交换对称密钥，用对称加密传输数据，兼顾安全和效率。"),
        ("RSA算法的安全性基于？", '{"A":"大数分解的困难性","B":"离散对数","C":"哈希碰撞","D":"对称密钥长度"}', "A", "RSA基于大数分解的数学困难性。"),
        ("数字证书的作用是？", '{"A":"验证服务器身份和公钥","B":"加密数据传输","C":"加速连接","D":"存储用户信息"}', "A", "数字证书由CA签发，包含服务器信息和公钥，用于验证身份。"),
        ("以下哪个不是安全的密码存储方式？", '{"A":"明文","B":"MD5","C":"BCrypt","D":"PBKDF2"}', "B", "密码应使用加盐哈希（BCrypt/PBKDF2/Argon2）；MD5已被破解。"),
        ("以下哪个是AES算法的特点？", '{"A":"对称加密","B":"分组密码","C":"128/192/256位密钥","D":"以上都是"}', "D", "AES是对称分组密码，支持128/192/256位密钥，替代DES。"),
        ("以下哪个是数字信封的原理？", '{"A":"用对称密钥加密数据，用接收方公钥加密对称密钥","B":"用接收方私钥加密","C":"用发送方公钥加密","D":"用对称密钥加密密钥"}', "A", "数字信封：用对称密钥加密数据，用接收方公钥加密对称密钥。"),
    ]
    for q, opt, a, an in crypto:
        questions.append(q_single(q, opt, a, an))

    # 软件测试
    testing = [
        ("单元测试的主要目的是？", '{"A":"验证单个模块功能","B":"验证整个系统","C":"测试用户界面","D":"性能测试"}', "A", "单元测试验证单个模块或函数功能，是最基础的测试。"),
        ("以下哪个是黑盒测试的特征？", '{"A":"关注功能，不关注内部实现","B":"需要代码访问权限","C":"测试代码结构","D":"找出所有bug"}', "A", "黑盒测试从用户角度测试功能，不关注内部实现；白盒测试关注代码结构。"),
        ("以下哪个是测试金字塔的底层？", '{"A":"单元测试","B":"集成测试","C":"E2E测试","D":"性能测试"}', "A", "测试金字塔：底层单元测试（最多）、中层集成测试、顶层E2E测试（最少）。"),
        ("以下哪个不是测试用例的内容？", '{"A":"测试目标","B":"测试步骤","C":"预期结果","D":"源代码"}', "D", "测试用例包含：测试目标、输入数据、测试步骤、预期结果；不需要源代码。"),
        ("以下哪个是冒烟测试的作用？", '{"A":"快速验证核心功能","B":"全面测试","C":"性能测试","D":"安全测试"}', "A", "冒烟测试快速验证核心功能，如果失败则不进一歩测试。"),
        ("以下哪个是回归测试的目的？", '{"A":"确保修改没有引入新问题","B":"测试新功能","C":"性能测试","D":"安全测试"}', "A", "回归测试确保代码修改没有破坏现有功能。"),
        ("以下哪个是自动化测试的优势？", '{"A":"提高效率","B":"可重复执行","C":"覆盖率高","D":"以上都是"}', "D", "自动化测试：提高效率、可重复、覆盖率高、一致性好。"),
        ("以下哪个是代码覆盖率的类型？", '{"A":"语句覆盖","B":"分支覆盖","C":"条件覆盖","D":"以上都是"}', "D", "代码覆盖率类型：语句覆盖、分支覆盖、条件覆盖、路径覆盖等。"),
        ("以下哪个是集成测试的策略？", '{"A":"自顶向下","B":"自底向上","C":"三明治","D":"以上都是"}', "D", "集成测试策略：自顶向下、自底向上、三明治（混合）。"),
        ("以下哪个是验收测试的目的？", '{"A":"确认系统满足业务需求","B":"找出所有bug","C":"性能测试","D":"安全测试"}', "A", "验收测试确认系统满足业务需求和用户期望。"),
    ]
    for q, opt, a, an in testing:
        questions.append(q_single(q, opt, a, an))

    # 安全合规
    compliance = [
        ("GDPR的全称是？", '{"A":"General Data Protection Regulation","B":"Global Data Privacy Rules","C":"Government Data Protection Requirements","D":"General Digital Privacy Regulation"}', "A", "GDPR是欧盟通用数据保护条例。"),
        ("以下哪个是被遗忘权的定义？", '{"A":"用户可以要求删除个人数据","B":"用户可以拒绝提供数据","C":"用户可以访问数据","D":"用户可以转移数据"}', "A", "被遗忘权允许数据主体要求删除其个人数据。"),
        ("等保测评分为几级？", '{"A":"3","B":"4","C":"5","D":"6"}', "C", "等保分为五级：一级自主、二级指导、三级监督、四级强制、五级专控。"),
        ("以下哪个是个人信息保护的原则？", '{"A":"合法、正当、必要","B":"明示、同意","C":"保密、安全","D":"以上都是"}', "D", "个人信息保护原则：合法正当必要、明示同意、保密安全。"),
        ("以下哪个不是数据脱敏的技术？", '{"A":"替换","B":"加密","C":"删除","D":"明文存储"}', "D", "数据脱敏技术：替换、加密、掩码、删除；明文存储不是脱敏。"),
        ("CCPA是哪个国家的隐私法规？", '{"A":"美国加州","B":"欧盟","C":"中国","D":"日本"}', "A", "CCPA是美国加州消费者隐私法案。"),
        ("数据分类分级的目的是？", '{"A":"差异化保护","B":"风险管理","C":"合规要求","D":"以上都是"}', "D", "数据分类分级用于差异化保护、风险管理和合规要求。"),
        ("隐私影响评估（PIA）的作用是？", '{"A":"评估隐私风险","B":"制定保护措施","C":"监控执行","D":"以上都是"}', "D", "PIA评估隐私风险、制定保护措施、监控执行。"),
        ("数据泄露应急响应的第一步是？", '{"A":"遏制泄露","B":"通知相关方","C":"调查原因","D":"恢复系统"}', "A", "数据泄露应急：遏制泄露→评估影响→通知监管/受影响方→调查原因→修复→总结。"),
        ("最小权限原则是指？", '{"A":"只授予完成任务所需的最小权限","B":"所有用户同等权限","C":"管理员拥有所有权限","D":"禁止所有权限"}', "A", "最小权限原则只授予完成工作所需的最小权限，降低风险。"),
    ]
    for q, opt, a, an in compliance:
        questions.append(q_single(q, opt, a, an))

    return questions


def generate_multi_questions():
    """生成多选题"""
    questions = []

    # Java多选
    java_multi = [
        ("以下哪些是Java的基本数据类型？", '{"A":"byte","B":"String","C":"short","D":"boolean","E":"Object"}', "A,C,D", "String是引用类型；Object是类；byte和short是基本类型。"),
        ("以下哪些修饰符可以修饰类？", '{"A":"public","B":"abstract","C":"final","D":"static","E":"private"}', "A,B,C", "类可使用public、abstract、final修饰；static和private不能修饰类。"),
        ("以下哪些是创建线程的方式？", '{"A":"继承Thread","B":"实现Runnable","C":"实现Callable","D":"继承Object","E":"使用线程池"}', "A,B,C,E", "四种基本方式：继承Thread、实现Runnable、实现Callable（配合FutureTask）；线程池是高级封装。"),
        ("以下哪些是Collection接口的方法？", '{"A":"add()","B":"remove()","C":"get()","D":"size()","E":"clear()"}', "A,B,D,E", "get()是List接口的方法，不是Collection通用方法。"),
        ("以下哪些是fail-fast的特性？", '{"A":"ArrayList的迭代器","B":"HashMap的entrySet迭代器","C":"ConcurrentHashMap迭代器","D":"CopyOnWriteArrayList迭代器","E":"Vector迭代器"}', "A,B,E", "ArrayList、HashMap、Vector是fail-fast；ConcurrentHashMap、CopyOnWriteArrayList是fail-safe。"),
        ("以下哪些是SOLID原则的内容？", '{"A":"单一职责","B":"开闭原则","C":"里氏替换","D":"接口隔离","E":"依赖倒置"}', "A,B,C,D,E", "SOLID：S单一职责、O开闭、L里氏替换、I接口隔离、D依赖倒置。"),
    ]
    for q, opt, a, an in java_multi:
        questions.append(q_multi(q, opt, a, an))

    # Web安全多选
    web_multi = [
        ("以下哪些可以有效防御SQL注入？", '{"A":"参数化查询","B":"输入验证","C":"使用ORM框架","D":"最小权限","E":"关闭错误信息"}', "A,B,C,D,E", "SQL注入防护需要多层：参数化、输入验证、ORM、最小权限、错误处理。"),
        ("XSS攻击的主要危害包括？", '{"A":"窃取Cookie","B":"键盘记录","C":"修改页面","D":"植入恶意软件","E":"直接删除数据库"}', "A,B,C,D", "XSS可窃取认证信息、键盘记录、页面篡改、植入恶意代码。"),
        ("以下哪些是CSRF的防护措施？", '{"A":"验证Referer","B":"使用Token","C":"SameSite Cookie","D":"验证码","E":"使用HTTP"}', "A,B,C,D", "CSRF防护：Referer验证、Anti-CSRF Token、SameSite Cookie、验证码。HTTP不能防护CSRF。"),
        ("以下哪些是安全的密码存储方式？", '{"A":"BCrypt","B":"PBKDF2","C":"MD5","D":"SHA-256","E":"明文"}', "A,B", "密码应使用BCrypt、PBKDF2、Argon2等专用哈希算法；MD5/SHA-256不是密码哈希。"),
        ("以下哪些是同源策略的组成部分？", '{"A":"协议","B":"域名","C":"端口","D":"路径","E":"参数"}', "A,B,C", "同源策略三要素：协议、域名、端口；路径和参数不影响同源判断。"),
        ("以下哪些是信息收集的方法？", '{"A":"DNS查询","B":"搜索引擎","C":"社会工程","D":"端口扫描","E":"漏洞利用"}', "A,B,C,D", "信息收集方法：DNS查询、搜索引擎、社会工程、网络扫描等；漏洞利用是后续攻击阶段。"),
    ]
    for q, opt, a, an in web_multi:
        questions.append(q_multi(q, opt, a, an))

    # 网络多选
    network_multi = [
        ("TCP的可靠传输机制包括？", '{"A":"确认机制","B":"超时重传","C":"流量控制","D":"拥塞控制","E":"广播"}', "A,B,C,D", "TCP可靠传输：确认、超时重传、流量控制（滑动窗口）、拥塞控制。"),
        ("HTTP 2.0的新特性包括？", '{"A":"多路复用","B":"服务器推送","C":"header压缩","D":"加密传输","E":"请求流水线"}', "A,B,C", "HTTP/2特性：多路复用、服务器推送、header压缩。加密传输HTTP/1.1可通过TLS实现。"),
        ("以下哪些是DNS记录类型？", '{"A":"A","B":"AAAA","C":"MX","D":"CNAME","E":"POST"}', "A,B,C,D", "DNS记录：A（IPv4）、AAAA（IPv6）、MX（邮件）、CNAME（别名）；POST不是DNS记录类型。"),
        ("以下哪些可以优化数据库性能？", '{"A":"建立索引","B":"优化查询","C":"分库分表","D":"使用ORM","E":"关闭事务"}', "A,B,C,D", "数据库优化：索引、查询优化、分库分表、ORM框架、缓存等。关闭事务不是优化手段。"),
        ("以下哪些是Redis的数据结构？", '{"A":"String","B":"List","C":"Set","D":"ZSet","E":"Hash","F":"以上都是"}', "A,B,C,D,E,F", "Redis支持String、List、Set、ZSet、Hash、Geo、HyperLogLog等数据结构。"),
        ("负载均衡算法包括？", '{"A":"轮询","B":"加权轮询","C":"最少连接","D":"随机","E":"源IP哈希","F":"以上都是"}', "A,B,C,D,E,F", "负载均衡算法：轮询、加权轮询、最少连接、随机、源IP哈希等。"),
    ]
    for q, opt, a, an in network_multi:
        questions.append(q_multi(q, opt, a, an))

    # 安全多选
    security_multi = [
        ("以下哪些是Kubernetes的安全机制？", '{"A":"RBAC授权","B":"NetworkPolicy","C":"PodSecurityPolicy","D":"Secrets管理","E":"以上都是"}', "A,B,C,D,E", "K8s安全机制：RBAC、NetworkPolicy、PSP、Secrets、SecurityContext等。"),
        ("Docker安全措施包括？", '{"A":"用户命名空间","B":"Capabilities限制","C":"Seccomp","D":"AppArmor","E":"以上都是"}', "A,B,C,D,E", "Docker安全：User namespace、Caps、Seccomp、AppArmor、Selinux等。"),
        ("以下哪些是身份认证的方式？", '{"A":"用户名密码","B":"短信验证码","C":"OAuth","D":"LDAP","E":"以上都是"}', "A,B,C,D,E", "身份认证方式：用户名密码、短信/邮件验证码、OAuth、SAML、LDAP、生物识别等。"),
        ("以下哪些是日志分析的作用？", '{"A":"发现入侵痕迹","B":"追踪问题原因","C":"满足合规要求","D":"优化性能","E":"以上都是"}', "A,B,C,D,E", "日志分析：发现安全事件、追踪问题、合规审计、性能优化。"),
        ("以下哪些是数据备份策略？", '{"A":"全量备份","B":"增量备份","C":"差异备份","D":"异地备份","E":"以上都是"}', "A,B,C,D,E", "备份策略：全量、增量、差异备份；异地副本提高可靠性。"),
    ]
    for q, opt, a, an in security_multi:
        questions.append(q_multi(q, opt, a, an))

    return questions


def generate_fill_questions():
    """生成填空题"""
    questions = []

    fill_data = [
        # Java
        ("Java中，八种基本数据类型包括：byte、short、int、long、float、double、char和____。", "boolean"),
        ("Java中，String类的length()方法返回的是____类型。", "int"),
        ("Java中，使用____关键字来引用当前对象。", "this"),
        ("Java中，静态方法使用____关键字修饰。", "static"),
        ("抽象类不能直接____，需要通过继承创建子类对象。", "实例化"),
        ("接口中定义的变量默认是____，即常量。", "public static final"),
        ("方法重写要求方法名、参数列表和____都要相同。", "返回类型"),
        ("异常处理的try-catch-finally块中，____块总会执行。", "finally"),
        ("Object类的toString()方法默认返回类的____和哈希码。", "类名"),
        ("Java的集合框架中，List接口的直接父接口是____。", "Collection"),

        # Web安全
        ("SQL注入攻击利用了Web应用程序对用户输入____不充分验证的漏洞。", "数据"),
        ("参数化查询将SQL语句结构和____分离，防止注入。", "数据"),
        ("XSS攻击的三种类型：反射型、存储型和____型。", "DOM"),
        ("HTML上下文中，需要对<、>、&字符进行____以防止XSS。", "编码或转义"),
        ("CSRF利用浏览器的____特性自动发送Cookie。", "同源"),
        ("同源策略的三要素：协议、域名和____。", "端口"),
        ("WAF是Web应用____的缩写。", "防火墙"),
        ("敏感信息泄露可能通过错误信息、代码仓库和____等途径。", "日志文件"),
        ("防止CSRF的Token机制验证表单Token和____中Token的一致性。", "Session或Cookie"),
        ("安全的密码存储应使用加盐的____哈希算法。", "BCrypt或Argon2"),

        # 网络
        ("TCP三次握手：SYN、____、ACK。", "SYN-ACK"),
        ("TCP四次挥手：FIN、____、FIN、ACK。", "ACK"),
        ("HTTP的____方法只获取响应头，不获取实体内容。", "HEAD"),
        ("HTTPS使用____协议进行加密。", "TLS或SSL"),
        ("DNS的全称是____，主要工作端口是53。", "Domain Name System"),
        ("Cookie的HttpOnly属性可以防止____访问Cookie。", "JavaScript"),
        ("滑动窗口用于TCP的____控制。", "流量"),
        ("IP地址分为____类和____类。", "A|B"),
        ("路由选择协议中，RIP基于____算法，OSPF基于最短路径优先算法。", "距离向量"),
        ("ARP协议用于将____地址解析为IP地址。", "MAC"),

        # 数据库
        ("MySQL的InnoDB存储引擎支持____和行级锁。", "事务"),
        ("SQL的聚合函数包括：COUNT、SUM、AVG、MAX和____。", "MIN"),
        ("数据库索引的____原则指最左前缀匹配。", "最左"),
        ("事务的ACID特性：原子性、一致性、隔离性和____。", "持久性"),
        ("Redis的持久化方式包括RDB快照和____日志。", "AOF"),
        ("Redis使用____实现分布式锁。", "SETNX"),
        ("SQL的JOIN类型中，____ JOIN返回左表全部记录。", "LEFT"),
        ("MySQL默认的事务隔离级别是____。", "REPEATABLE READ"),
        ("数据库____范式旨在消除冗余和数据依赖问题。", "规范化或范式"),
        ("MongoDB是____型NoSQL数据库。", "文档"),

        # 数据结构与算法
        ("数组下标从____开始。", "0或零"),
        ("二叉树的深度为log2(n+1)向下取整适用于____二叉树。", "完全"),
        ("快速排序的平均时间复杂度是____。", "O(n log n)"),
        ("二分查找的时间复杂度是____。", "O(log n)"),
        ("栈的特点是____。", "LIFO或后进先出"),
        ("队列的特点是____。", "FIFO或先进先出"),
        ("堆用于实现优先级队列，堆排序的时间复杂度始终是____。", "O(n log n)"),
        ("动态规划的核心是最优子结构和____子问题。", "重叠"),
        ("图的遍历算法包括____和广度优先搜索。", "深度优先搜索"),
        ("哈希表处理哈希冲突的方法包括链地址法和____法。", "开放地址"),

        # 操作系统
        ("进程是资源分配的独立单位，线程是____调度的独立单位。", "CPU或处理器"),
        ("Linux中，____命令用于查看当前工作目录。", "pwd"),
        ("Linux中，____命令用于修改文件权限。", "chmod"),
        ("Shell脚本中，$#表示____个数。", "参数"),
        ("虚拟内存通过____表实现地址映射。", "页"),
        ("死锁的必要条件包括：互斥、占有并等待、不可抢占和____。", "循环等待"),
        ("CPU调度的三种基本算法：先来先服务、时间片轮转和____。", "优先级调度"),
        ("Linux中，____命令用于查找文件。", "find"),
        ("操作系统的四大基本功能：进程管理、内存管理、文件管理和____管理。", "设备"),
        ("____是操作系统将CPU时间划分成多个时间片，轮流分配给多个任务。", "时间片轮转"),

        # 前端
        ("JavaScript中，null表示____，undefined表示未定义。", "空值"),
        ("ES6的____语法用于声明常量。", "const"),
        ("CSS Flex布局中，justify-content用于设置主轴对齐，____用于设置交叉轴对齐。", "align-items"),
        ("Vue的双向绑定基于____和数据劫持。", "响应式"),
        ("React的useState用于在函数组件中创建____。", "状态变量"),
        ("Promise有三种状态：pending、fulfilled和____。", "rejected"),
        ("CSS的____属性用于设置元素在主轴上的增长因子。", "flex-grow"),
        ("HTML5新增的语义化标签包括：article、section、nav和____。", "header或footer"),
        ("____是浏览器的一个安全机制，限制不同源之间的资源访问。", "同源策略"),
        ("HTTP请求中，____头用于传递CSRF Token。", "X-CSRF-Token"),

        # 容器与DevOps
        ("Docker的核心组件包括：Docker daemon、Client、____和Container。", "Image或镜像"),
        ("K8s中，Pod是最小的____单位。", "调度"),
        ("Git中，____命令用于将文件添加到暂存区。", "git add"),
        ("Git中，____命令用于创建分支。", "git branch"),
        ("CI/CD中，CI指持续____，CD指持续____。", "集成|部署或交付"),
        ("Dockerfile的____指令用于声明容器监听的端口。", "EXPOSE"),
        ("K8s中，____用于服务发现和负载均衡。", "Service"),
        ("Docker网络模式包括：bridge、host、none和____。", "container"),
        ("Helm是K8s的____管理器。", "包"),
        ("Docker使用____技术实现资源隔离。", "容器或namespace/cgroups"),

        # 加密与安全
        ("对称加密和非对称加密的主要区别是密钥____数量不同。", "使用或类型"),
        ("数字签名用于验证消息的完整性和____身份。", "发送者"),
        ("哈希函数具有单向性、确定性和____效应。", "雪崩"),
        ("AES是____加密算法。", "对称或分组"),
        ("PKI体系的核心是____。", "数字证书"),
        ("HTTPS混合加密：非对称加密用于密钥交换，____加密用于数据传输。", "对称"),
        ("密码存储应使用加盐的专用哈希算法，如BCrypt、____和Argon2。", "PBKDF2"),
        ("数字信封用对称密钥加密数据，用接收方的____加密对称密钥。", "公钥"),
        ("RSA算法的安全性基于大数____的困难性。", "分解"),
        ("____是加密和解密使用同一密钥的加密方式。", "对称加密"),

        # 测试
        ("测试金字塔：底层是____测试，中层是集成测试，顶层是E2E测试。", "单元"),
        ("黑盒测试关注功能，不关注内部____。", "实现或代码结构"),
        ("单元测试应遵循AIR原则：Automatic、Independent、____。", "Repeatable或可重复"),
        ("代码覆盖率包括语句覆盖、分支覆盖和____覆盖。", "条件或路径"),
        ("回归测试确保代码修改没有破坏____功能。", "现有或已有"),
        ("自动化测试的优势：提高效率、可重复执行、覆盖率高和____性好。", "一致"),
        ("冒烟测试快速验证____功能是否正常。", "核心"),
        ("集成测试的策略包括：自顶向下、自底向上和____。", "三明治或混合"),
        ("验收测试确认系统满足业务____和用户期望。", "需求"),
        ("测试用例包含：测试目标、输入数据、操作步骤和____结果。", "预期"),

        # 合规
        ("GDPR的中文名称是____。", "通用数据保护条例"),
        ("个人信息保护原则：合法、正当、____。", "必要"),
        ("等保测评分为____级。", "五"),
        ("数据分类分级用于____化保护。", "差异"),
        ("被遗忘权允许数据主体要求____其个人数据。", "删除"),
        ("CCPA是美国____州的消费者隐私法案。", "加州"),
        ("隐私影响评估用于评估____风险。", "隐私"),
        ("数据泄露应急响应：遏制→评估→____→调查→修复。", "通知或报告"),
        ("最小权限原则只授予完成任务所需的____权限。", "最小"),
        ("日志审计用于发现安全事件、追踪问题和满足____要求。", "合规"),
    ]

    for q, a in fill_data:
        questions.append(q_fill(q, a))

    return questions


def generate_short_questions():
    """生成简答题"""
    questions = []

    short_data = [
        ("请简述SQL注入攻击的基本原理和防御措施。", "SQL注入是通过在用户输入中插入恶意SQL代码，当应用程序将输入直接拼接到SQL查询时执行。防御措施：使用参数化查询、输入验证、白名单过滤、最小权限原则、错误信息处理。", "考察SQL注入原理和防御理解。"),
        ("请简述HTTPS的工作原理。", "HTTPS在HTTP和TCP之间增加SSL/TLS层。（1）客户端发起HTTPS请求，连接服务器443端口；（2）服务器返回证书（包含公钥）；（3）客户端验证证书；（4）客户端生成随机数（对称密钥），用公钥加密发送；（5）服务器用私钥解密获取对称密钥；（6）双方使用对称密钥加密HTTP通信。", "考察HTTPS原理理解。"),
        ("请简述TCP三次握手的过程和作用。", "三次握手过程：客户端发送SYN包（SYN=x）→服务器返回SYN-ACK包（SYN=y, ACK=x+1）→客户端发送ACK包（ACK=y+1）。作用：建立可靠连接，确认双方的发送和接收能力是否正常。", "考察TCP握手理解。"),
        ("请简述单例模式的应用场景和实现方式。", "单例模式应用：配置管理类、线程池、缓存、日志对象等保证全局唯一。实现方式：饿汉式（类加载创建）、懒汉式（双重检查锁定+volatile）、静态内部类、枚举。", "考察单例模式理解。"),
        ("请简述进程和线程的区别与联系。", "区别：进程是资源分配单位（有独立地址空间），线程是CPU调度单位（共享进程资源）。联系：线程是进程的组成部分，一个进程可包含多个线程，线程共享进程资源但有独立栈和寄存器。", "考察进程线程理解。"),
        ("请简述什么是XSS攻击，有哪几种类型？", "XSS是跨站脚本攻击，通过在网页中注入恶意脚本，当用户浏览时被执行。类型：（1）反射型XSS：作为请求参数被服务器反射；（2）存储型XSS：恶意代码被永久存储在服务器；（3）DOM型XSS：纯客户端通过操作DOM执行。", "考察XSS攻击理解。"),
        ("请简述数据库事务的ACID特性。", "ACID：原子性（Atomicity）- 事务是最小执行单位，不可分割；一致性（Consistency）- 事务执行前后数据库状态一致；隔离性（Isolation）- 并发事务互不干扰；持久性（Durability）- 事务提交后结果永久保存。", "考察事务ACID理解。"),
        ("请简述快速排序的基本思想。", "快速排序采用分治思想：（1）选择基准元素；（2）分区：将数组分为比基准小的和比基准大的两部分；（3）递归对两部分继续排序。平均时间复杂度O(n log n)，最坏O(n^2)。", "考察快速排序理解。"),
        ("请简述什么是CSRF攻击以及防护措施。", "CSRF是跨站请求伪造，利用用户已登录的身份发起伪造请求。防护措施：验证Referer头、使用Anti-CSRF Token、验证自定义请求头、SameSite Cookie、验证码。", "考察CSRF攻击理解。"),
        ("请简述对称加密和非对称加密的区别和应用场景。", "区别：对称加密加解密使用相同密钥，速度快；非对称加密使用公钥私钥，更安全但速度慢。应用：对称加密用于大量数据加密（如HTTPS数据传输）；非对称加密用于密钥交换、数字签名。", "考察加密算法理解。"),
    ]

    for q, a, an in short_data:
        questions.append(q_short(q, a, an))

    return questions


def main():
    print("开始生成2000道题目...")
    all_questions = []

    # 收集所有题目
    all_questions.extend(gen_math_variations())
    all_questions.extend(gen_programming_problems())
    all_questions.extend(gen_common_programming())
    all_questions.extend(generate_single_questions())
    all_questions.extend(generate_multi_questions())
    all_questions.extend(generate_fill_questions())
    all_questions.extend(generate_short_questions())

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