-- 题目推荐功能测试数据

-- 1. 确保有知识点数据
INSERT IGNORE INTO t_knowledge_point (id, name, description, topic_id, source, confidence, create_time) VALUES
('kp-java-basics', 'Java基础语法', 'Java语言的基础语法知识', 'topic-java', 'MANUAL', 0.95, NOW()),
('kp-java-oop', '面向对象编程', 'Java面向对象的三大特性：封装、继承、多模态', 'topic-java', 'MANUAL', 0.90, NOW()),
('kp-java-exception', '异常处理', 'Java异常处理机制', 'topic-java', 'MANUAL', 0.85, NOW()),
('kp-java-collection', '集合框架', 'Java集合框架的使用', 'topic-java', 'MANUAL', 0.88, NOW()),
('kp-java-io', 'IO流', 'Java IO流操作', 'topic-java', 'MANUAL', 0.80, NOW()),
('kp-java-thread', '多线程', 'Java多线程编程', 'topic-java', 'MANUAL', 0.75, NOW()),
('kp-java-network', '网络编程', 'Java网络编程基础', 'topic-java', 'MANUAL', 0.70, NOW()),
('kp-java-database', '数据库操作', 'JDBC和数据库操作', 'topic-java', 'MANUAL', 0.82, NOW());

-- 2. 确保有足够的题目数据
INSERT IGNORE INTO t_question (id, question, answer, type, score, state, teacher_id) VALUES
(1001, 'Java中用于定义类的关键字是______', 'class', 1, 10, 1, 1),
(1002, 'Java中用于创建对象的关键字是______', 'new', 1, 10, 1, 1),
(1003, '以下哪个不是Java的访问修饰符？', 'C', 2, 10, 1, 1),
(1004, 'Java中实现继承使用的关键字是______', 'extends', 1, 10, 1, 1),
(1005, 'Java中实现接口使用的关键字是______', 'implements', 1, 10, 1, 1),
(1006, '以下哪个是Java的异常处理关键字？', 'D', 2, 10, 1, 1),
(1007, 'Java中用于抛出异常的关键字是______', 'throw/throws', 1, 10, 1, 1),
(1008, '以下哪个不是Java集合框架的接口？', 'C', 2, 10, 1, 1),
(1009, 'Java中List接口的特点是______', '有序可重复', 1, 10, 1, 1),
(1010, 'Java中Set接口的特点是______', '无序不重复', 1, 10, 1, 1),
(1011, 'Java中用于读取文件的类是______', 'FileReader/BufferedReader', 1, 10, 1, 1),
(1012, 'Java中用于写入文件的类是______', 'FileWriter/BufferedWriter', 1, 10, 1, 1),
(1013, 'Java中创建线程的方式有几种？', '2种', 1, 10, 1, 1),
(1014, 'Java中实现Runnable接口需要重写的方法是______', 'run()', 1, 10, 1, 1),
(1015, 'Java中用于网络编程的类位于哪个包？', 'java.net', 1, 10, 1, 1),
(1016, 'Java中JDBC的全称是______', 'Java Database Connectivity', 1, 10, 1, 1),
(1017, 'Java中用于加载数据库驱动的类是______', 'Class.forName()', 1, 10, 1, 1),
(1018, 'Java中Connection接口用于______', '建立数据库连接', 1, 10, 1, 1),
(1019, 'Java中PreparedStatement的优点是______', '防止SQL注入', 1, 10, 1, 1),
(1020, 'Java中ResultSet用于______', '存储查询结果', 1, 10, 1, 1);

-- 3. 关联题目到知识点
INSERT IGNORE INTO t_question_knowledge_point (question_id, knowledge_point_id, weight, is_primary) VALUES
(1001, 'kp-java-basics', 0.9, 1),
(1002, 'kp-java-basics', 0.8, 1),
(1003, 'kp-java-basics', 0.7, 1),
(1004, 'kp-java-oop', 0.9, 1),
(1005, 'kp-java-oop', 0.8, 1),
(1006, 'kp-java-exception', 0.9, 1),
(1007, 'kp-java-exception', 0.8, 1),
(1008, 'kp-java-collection', 0.9, 1),
(1009, 'kp-java-collection', 0.8, 1),
(1010, 'kp-java-collection', 0.7, 1),
(1011, 'kp-java-io', 0.9, 1),
(1012, 'kp-java-io', 0.8, 1),
(1013, 'kp-java-thread', 0.9, 1),
(1014, 'kp-java-thread', 0.8, 1),
(1015, 'kp-java-network', 0.9, 1),
(1016, 'kp-java-database', 0.9, 1),
(1017, 'kp-java-database', 0.8, 1),
(1018, 'kp-java-database', 0.7, 1),
(1019, 'kp-java-database', 0.6, 1),
(1020, 'kp-java-database', 0.5, 1);

-- 4. 创建学生答题记录（模拟学生答题情况）
INSERT IGNORE INTO t_student_question (student_id, question_id, my_answer, is_correct, graded, score, fill_time) VALUES
-- 学生1：基础语法掌握较好，数据库掌握较差
(1, 1001, 'class', 1, 1, 10, NOW()),
(1, 1002, 'new', 1, 1, 10, NOW()),
(1, 1003, 'C', 1, 1, 10, NOW()),
(1, 1004, 'extends', 1, 1, 10, NOW()),
(1, 1005, 'implements', 1, 1, 10, NOW()),
(1, 1016, 'Java Database Connectivity', 1, 1, 10, NOW()),
(1, 1017, 'Class', 0, 1, 0, NOW()),
(1, 1018, '连接数据库', 0, 1, 5, NOW()),
(1, 1019, '提高性能', 0, 1, 3, NOW()),
(1, 1020, '存储数据', 0, 1, 2, NOW());

-- 5. 创建知识点掌握度数据
INSERT IGNORE INTO t_student_mastery (student_id, knowledge_point_id, mastery_score, attempt_count, correct_count, last_attempted) VALUES
(1, 'kp-java-basics', 0.95, 3, 3, NOW()),
(1, 'kp-java-oop', 0.90, 2, 2, NOW()),
(1, 'kp-java-exception', 0.85, 2, 2, NOW()),
(1, 'kp-java-collection', 0.80, 2, 2, NOW()),
(1, 'kp-java-io', 0.75, 2, 2, NOW()),
(1, 'kp-java-thread', 0.70, 2, 2, NOW()),
(1, 'kp-java-network', 0.65, 2, 2, NOW()),
(1, 'kp-java-database', 0.40, 4, 1, NOW());

-- 6. 更新题目表，添加知识点字段（如果不存在）
ALTER TABLE t_question ADD COLUMN IF NOT EXISTS knowledge_point VARCHAR(100) DEFAULT NULL COMMENT '知识点';

-- 7. 更新题目知识点
UPDATE t_question SET knowledge_point = 'Java基础语法' WHERE id = 1001;
UPDATE t_question SET knowledge_point = 'Java基础语法' WHERE id = 1002;
UPDATE t_question SET knowledge_point = 'Java基础语法' WHERE id = 1003;
UPDATE t_question SET knowledge_point = '面向对象编程' WHERE id = 1004;
UPDATE t_question SET knowledge_point = '面向对象编程' WHERE id = 1005;
UPDATE t_question SET knowledge_point = '异常处理' WHERE id = 1006;
UPDATE t_question SET knowledge_point = '异常处理' WHERE id = 1007;
UPDATE t_question SET knowledge_point = '集合框架' WHERE id = 1008;
UPDATE t_question SET knowledge_point = '集合框架' WHERE id = 1009;
UPDATE t_question SET knowledge_point = '集合框架' WHERE id = 1010;
UPDATE t_question SET knowledge_point = 'IO流' WHERE id = 1011;
UPDATE t_question SET knowledge_point = 'IO流' WHERE id = 1012;
UPDATE t_question SET knowledge_point = '多线程' WHERE id = 1013;
UPDATE t_question SET knowledge_point = '多线程' WHERE id = 1014;
UPDATE t_question SET knowledge_point = '网络编程' WHERE id = 1015;
UPDATE t_question SET knowledge_point = '数据库操作' WHERE id = 1016;
UPDATE t_question SET knowledge_point = '数据库操作' WHERE id = 1017;
UPDATE t_question SET knowledge_point = '数据库操作' WHERE id = 1018;
UPDATE t_question SET knowledge_point = '数据库操作' WHERE id = 1019;
UPDATE t_question SET knowledge_point = '数据库操作' WHERE id = 1020;
