import pymysql

conn = pymysql.connect(host='localhost', user='root', password='yu6670980506', database='labex', charset='utf8mb4')
cursor = conn.cursor()

# Check a few questions
cursor.execute("SELECT id, LEFT(question, 50), type FROM t_question WHERE type = 2 LIMIT 3")
print("Single choice questions:")
for row in cursor.fetchall():
    print(f"  ID {row[0]}: {row[1]}")

cursor.execute("SELECT id, LEFT(question, 50), type FROM t_question WHERE type = 1 LIMIT 3")
print("\nFill-in questions:")
for row in cursor.fetchall():
    print(f"  ID {row[0]}: {row[1]}")

cursor.execute("SELECT id, LEFT(question, 50), type FROM t_question WHERE type = 6 LIMIT 3")
print("\nProgramming questions:")
for row in cursor.fetchall():
    print(f"  ID {row[0]}: {row[1][:50]}...")

# Check test cases
cursor.execute("SELECT tc.question_id, tc.input, tc.expected_output FROM t_question_test_case tc LIMIT 3")
print("\nTest cases:")
for row in cursor.fetchall():
    print(f"  Q{row[0]}: input={row[1]}, expected={row[2]}")

conn.close()