import pymysql

# Test connection with different charsets
conn = pymysql.connect(
    host='localhost',
    user='root',
    password='yu6670980506',
    database='labex',
    charset='utf8mb4',
    init_command='SET NAMES utf8mb4'
)
cursor = conn.cursor()

# Test insert a simple Chinese string
test_text = "Java中，以下哪个不是基本数据类型？"
print(f"Original text: {test_text}")
print(f"Original bytes: {test_text.encode('utf-8')}")

# Check what MySQL receives
cursor.execute("SELECT LENGTH(%s), CHAR_LENGTH(%s)", (test_text, test_text))
row = cursor.fetchone()
print(f"MySQL length (bytes): {row[0]}, char length: {row[1]}")

# Insert test
cursor.execute("DELETE FROM t_question WHERE question = %s", (test_text,))
conn.commit()

cursor.execute("INSERT INTO t_question (question, answer, type, score, teacher_id, state) VALUES (%s, 'A', 2, 10, 2, 1)", (test_text,))
conn.commit()

# Read back
cursor.execute("SELECT question FROM t_question WHERE question = %s", (test_text,))
row = cursor.fetchone()
if row:
    print(f"Read back: {row[0]}")
    print(f"Read back bytes: {row[0].encode('utf-8')}")
else:
    print("Not found!")

conn.close()