import pymysql

conn = pymysql.connect(host='localhost', user='root', password='yu6670980506', database='labex', charset='utf8mb4')
cursor = conn.cursor()

# Check id 7 which should be early fill-in question
cursor.execute("SELECT id, LEFT(question, 20), type FROM t_question WHERE id = 7")
row = cursor.fetchone()
print(f"ID 7: {repr(row[1])}")

# Check a type 2 question
cursor.execute("SELECT id, LEFT(question, 30), type FROM t_question WHERE type = 2 AND id < 100 LIMIT 1")
row = cursor.fetchone()
print(f"Type 2 early: ID {row[0]}: {repr(row[1])}")

# Check what percentage are corrupted (question mark only or very short)
cursor.execute("SELECT COUNT(*) FROM t_question WHERE LENGTH(question) < 5 OR question LIKE '%?%'")
count = cursor.fetchone()[0]
print(f"Potentially corrupted: {count}")

conn.close()