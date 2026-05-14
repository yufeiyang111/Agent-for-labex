import pymysql

conn = pymysql.connect(host='localhost', user='root', password='yu6670980506', database='labex', charset='utf8mb4')
cursor = conn.cursor()

# Get question 1
cursor.execute("SELECT question FROM t_question WHERE id = 1")
row = cursor.fetchone()
print("Question 1:")
print(row[0])
print()

# Get question 501 (fill-in)
cursor.execute("SELECT question FROM t_question WHERE id = 501")
row = cursor.fetchone()
print("Question 501 (fill-in):")
print(row[0])
print()

# Get question 1501 (programming)
cursor.execute("SELECT question FROM t_question WHERE id = 1501")
row = cursor.fetchone()
print("Question 1501 (programming):")
print(row[0])
print()

# Get test case
cursor.execute("SELECT input, expected_output FROM t_question_test_case WHERE question_id = 1501 LIMIT 2")
print("Test cases for 1501:")
for row in cursor.fetchall():
    print(f"  input: {row[0]}, expected: {row[1]}")

conn.close()