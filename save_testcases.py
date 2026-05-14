import pymysql

conn = pymysql.connect(host='localhost', user='root', password='yu6670980506', database='labex', charset='utf8mb4')
cursor = conn.cursor()

# Get test cases
cursor.execute("SELECT id, question_id, input, expected_output FROM t_question_test_case WHERE question_id = 1501 LIMIT 5")

with open('D:/workfordasan/testcase_check.txt', 'w', encoding='utf-8') as f:
    for row in cursor.fetchall():
        f.write(f"ID: {row[0]}, QID: {row[1]}\n")
        f.write(f"Input: {row[2]}\n")
        f.write(f"Expected: {row[3]}\n")
        f.write("-" * 30 + "\n")

print("Test cases saved to testcase_check.txt")

conn.close()