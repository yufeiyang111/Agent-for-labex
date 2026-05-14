import pymysql

conn = pymysql.connect(host='localhost', user='root', password='yu6670980506', database='labex', charset='utf8mb4')
cursor = conn.cursor()

# Delete test cases first (foreign key constraint)
print("Deleting test cases...")
cursor.execute("DELETE FROM t_question_test_case")
print(f"Deleted {cursor.rowcount} test cases")

# Delete questions
print("Deleting questions...")
cursor.execute("DELETE FROM t_question")
print(f"Deleted {cursor.rowcount} questions")

conn.commit()

# Reset auto_increment
print("Resetting auto_increment...")
cursor.execute("ALTER TABLE t_question AUTO_INCREMENT = 1")
cursor.execute("ALTER TABLE t_question_test_case AUTO_INCREMENT = 1")
conn.commit()

print("Database cleaned!")

conn.close()