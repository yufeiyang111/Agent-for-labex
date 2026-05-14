import pymysql
import json

conn = pymysql.connect(host='localhost', user='root', password='yu6670980506', database='labex', charset='utf8mb4')
cursor = conn.cursor()

# Get questions and save to file
cursor.execute("SELECT id, question, answer, type FROM t_question WHERE id IN (1, 501, 1001, 1501)")
rows = cursor.fetchall()

with open('D:/workfordasan/question_check.txt', 'w', encoding='utf-8') as f:
    for row in rows:
        f.write(f"ID: {row[0]}\n")
        f.write(f"Question: {row[1]}\n")
        f.write(f"Answer: {row[2]}\n")
        f.write(f"Type: {row[3]}\n")
        f.write("-" * 50 + "\n")

print("Questions saved to question_check.txt")

conn.close()