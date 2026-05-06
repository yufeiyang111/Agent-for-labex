#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import sys
import io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

import json
import urllib.request

BASE_URL = "http://localhost:8080/api"

def make_request(url, method="GET", data=None, headers=None):
    if headers is None:
        headers = {}
    headers["Content-Type"] = "application/json"
    
    req = urllib.request.Request(url, data=data, headers=headers, method=method)
    
    try:
        with urllib.request.urlopen(req, timeout=10) as response:
            return json.loads(response.read().decode("utf-8"))
    except urllib.error.HTTPError as e:
        return {"error": f"HTTP {e.code}", "body": e.read().decode("utf-8", errors="ignore")}
    except Exception as e:
        return {"error": str(e)}

print("=== 获取所有教师账号 ===\n")

# 先登录管理员获取token
data = json.dumps({"account": "admin", "password": "123456", "role": "TEACHER"}).encode("utf-8")
result = make_request(f"{BASE_URL}/auth/login", "POST", data)

if result.get("success"):
    token = result["data"]["token"]
    headers = {"Authorization": f"Bearer {token}"}
    
    # 获取教师列表
    resp = make_request(f"{BASE_URL}/admin/teacher/list", "GET", headers=headers)
    if resp.get("success"):
        teachers = resp.get("data", {}).get("list", [])
        print(f"找到 {len(teachers)} 个教师账号:\n")
        for t in teachers:
            print(f"  ID: {t.get('teacherId')}, 账号: {t.get('teacherAccount')}, 姓名: {t.get('teacherName')}, 角色: {t.get('role')}")
    else:
        print(f"获取教师列表失败: {resp}")
else:
    print("管理员登录失败")

# 测试学生账号
print("\n=== 测试学生账号 ===\n")
student_tests = [
    ("23201335", "123456"),
    ("23201335", "c9668e0f75ce49ebaf7813f903076e5f"),  # MD5
]

for account, pwd in student_tests:
    data = json.dumps({"account": account, "password": pwd, "role": "STUDENT"}).encode("utf-8")
    result = make_request(f"{BASE_URL}/auth/login", "POST", data)
    if result.get("success"):
        print(f"学生账号 {account} + 密码 {pwd} - SUCCESS")
    else:
        print(f"学生账号 {account} + 密码 {pwd} - FAIL: {result.get('message')}")
