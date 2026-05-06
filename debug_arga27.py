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

# 测试arga27账号
print("=== 测试 arga27 账号 ===\n")

# 原数据库中密码是 MD5("123456")
pwd_tests = [
    "123456",
    "e10adc3949ba59abbe56e057f20f883e",  # 直接MD5
]

for pwd in pwd_tests:
    print(f"测试密码: {pwd}")
    data = json.dumps({"account": "arga27", "password": pwd, "role": "TEACHER"}).encode("utf-8")
    result = make_request(f"{BASE_URL}/auth/login", "POST", data)
    if result.get("success"):
        print(f"  SUCCESS - {result.get('message')}")
    else:
        print(f"  FAIL - {result.get('message', result.get('error'))}")
    print()
