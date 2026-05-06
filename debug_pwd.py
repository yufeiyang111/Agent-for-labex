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

# 测试各种密码组合
print("=== 密码测试 ===\n")

# 教师账号 admin - 原数据库中密码是 MD5("123456") = e10adc3949ba59abbe56e057f20f883e
print("测试教师账号 'admin' (角色=TEACHER):")
test_cases = [
    ("123456", "MD5原密码"),
    ("admin123", "明文"),
    ("e10adc3949ba59abbe56e057f20f883e", "直接MD5"),
]

for pwd, desc in test_cases:
    data = json.dumps({"account": "admin", "password": pwd, "role": "TEACHER"}).encode("utf-8")
    result = make_request(f"{BASE_URL}/auth/login", "POST", data)
    if result.get("success"):
        print(f"  [{desc}] {pwd} - SUCCESS")
    else:
        print(f"  [{desc}] {pwd} - FAIL: {result.get('message', result.get('error'))}")

print("\n测试管理员账号 'admin' (角色=ADMIN):")
for pwd, desc in test_cases:
    data = json.dumps({"account": "admin", "password": pwd, "role": "ADMIN"}).encode("utf-8")
    result = make_request(f"{BASE_URL}/auth/login", "POST", data)
    if result.get("success"):
        print(f"  [{desc}] {pwd} - SUCCESS")
    else:
        print(f"  [{desc}] {pwd} - FAIL: {result.get('message', result.get('error'))}")

# 测试其他教师账号
print("\n测试教师账号 'arga27' (角色=TEACHER):")
data = json.dumps({"account": "arga27", "password": "123456", "role": "TEACHER"}).encode("utf-8")
result = make_request(f"{BASE_URL}/auth/login", "POST", data)
if result.get("success"):
    print(f"  123456 - SUCCESS")
else:
    print(f"  123456 - FAIL: {result.get('message', result.get('error'))}")
