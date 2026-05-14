import pymysql

conn = pymysql.connect(host='localhost', user='root', password='yu6670980506', database='labex', charset='utf8mb4')
cursor = conn.cursor()

# Get raw bytes to verify actual encoding in database
cursor.execute("SELECT question FROM t_question WHERE id = 1")
row = cursor.fetchone()
print("Question 1 raw bytes:")
print(f"  repr: {repr(row[0])}")
print(f"  bytes: {row[0].encode('utf-8', errors='replace')[:100]}")

# Get the actual string
cursor.execute("SELECT question FROM t_question WHERE id = 1")
row = cursor.fetchone()
print(f"\nQuestion 1 actual text:")
print(row[0][:100])

# Check character by character
cursor.execute("SELECT question FROM t_question WHERE id = 1")
row = cursor.fetchone()
for i, c in enumerate(row[0][:30]):
    print(f"  char {i}: {repr(c)} ord={ord(c)}")

conn.close()