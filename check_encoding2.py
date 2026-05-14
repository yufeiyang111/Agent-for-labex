import pymysql

conn = pymysql.connect(host='localhost', user='root', password='yu6670980506', database='labex', charset='utf8mb4')
cursor = conn.cursor()

# Get raw bytes
cursor.execute("SELECT question FROM t_question WHERE id = 1")
row = cursor.fetchone()
print("Raw bytes for question 1:")
for byte in row[0].encode('utf-8')[:50]:
    print(f"  {hex(byte)}", end=" ")
print()

# Decode manually
cursor.execute("SELECT question FROM t_question WHERE id = 1")
row = cursor.fetchone()
print("\nManually decoded:")
text = row[0].encode('latin1').decode('utf-8')
print(text[:100])

conn.close()