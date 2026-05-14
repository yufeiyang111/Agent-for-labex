import pymysql

conn = pymysql.connect(host='localhost', user='root', password='yu6670980506', database='labex', charset='utf8mb4')
cursor = conn.cursor()

# Check the encoding issue
cursor.execute("SELECT id, question, type FROM t_question WHERE id > 4000 AND id < 4010")
for row in cursor.fetchall():
    print(f"ID: {row[0]}, Type: {row[2]}")
    print(f"Question bytes: {row[1].encode('utf-8', errors='replace')[:50]}")
    print(f"Question repr: {repr(row[1][:80])}")
    print()

conn.close()