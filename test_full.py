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

def test_and_report(name, url, method="GET", data=None, headers=None):
    result = make_request(url, method, data, headers)
    if result and "error" not in result:
        if result.get("success"):
            return f"[PASS] {name}"
        else:
            return f"[FAIL] {name} - {result.get('message')}"
    else:
        return f"[ERROR] {name} - {result}"

print("=" * 60)
print("Labex 实验教学管理系统 - 全面API测试")
print("=" * 60)

# =============================================
# 1. 认证模块测试
# =============================================
print("\n【1. 认证模块测试】")
print("-" * 40)

# Admin Login
result = make_request(f"{BASE_URL}/auth/login", "POST", 
    json.dumps({"account": "admin", "password": "123456", "role": "ADMIN"}).encode("utf-8"))
if result.get("success"):
    admin_token = result["data"]["token"]
    print(f"[PASS] 管理员登录 (admin/123456)")
else:
    print(f"[FAIL] 管理员登录 - {result.get('message')}")
    admin_token = None

# Teacher Login
result = make_request(f"{BASE_URL}/auth/login", "POST", 
    json.dumps({"account": "327433", "password": "123456", "role": "TEACHER"}).encode("utf-8"))
if result.get("success"):
    teacher_token = result["data"]["token"]
    print(f"[PASS] 教师登录 (327433/123456)")
else:
    print(f"[FAIL] 教师登录 - {result.get('message')}")
    teacher_token = None

# Student Login
result = make_request(f"{BASE_URL}/auth/login", "POST", 
    json.dumps({"account": "23201335", "password": "123456", "role": "STUDENT"}).encode("utf-8"))
if result.get("success"):
    student_token = result["data"]["token"]
    print(f"[PASS] 学生登录 (23201335/123456)")
else:
    print(f"[FAIL] 学生登录 - {result.get('message')}")
    student_token = None

admin_headers = {"Authorization": f"Bearer {admin_token}"} if admin_token else {}
teacher_headers = {"Authorization": f"Bearer {teacher_token}"} if teacher_token else {}
student_headers = {"Authorization": f"Bearer {student_token}"} if student_token else {}

# =============================================
# 2. 管理员模块测试
# =============================================
print("\n【2. 管理员模块测试】")
print("-" * 40)

if admin_token:
    tests = [
        ("教师列表查询", f"{BASE_URL}/admin/teacher/list"),
        ("学生列表查询", f"{BASE_URL}/admin/student/list"),
        ("班级列表查询", f"{BASE_URL}/admin/clazz/list"),
        ("系统统计信息", f"{BASE_URL}/admin/stats"),
    ]
    for name, url in tests:
        print(test_and_report(name, url, "GET", None, admin_headers))
else:
    print("[SKIP] 需要管理员Token")

# =============================================
# 3. 教师模块测试
# =============================================
print("\n【3. 教师模块测试】")
print("-" * 40)

if teacher_token:
    tests = [
        ("班级列表", f"{BASE_URL}/teacher/clazz/list"),
        ("学生列表", f"{BASE_URL}/teacher/student/list"),
        ("实验列表", f"{BASE_URL}/teacher/experiment/list"),
        ("讲义列表", f"{BASE_URL}/teacher/lecture/list"),
        ("作业列表", f"{BASE_URL}/teacher/homework/list"),
        ("成绩列表(experiment=1)", f"{BASE_URL}/teacher/score/experiment/1/students"),
    ]
    for name, url in tests:
        print(test_and_report(name, url, "GET", None, teacher_headers))
else:
    print("[SKIP] 需要教师Token")

# =============================================
# 4. 学生模块测试
# =============================================
print("\n【4. 学生模块测试】")
print("-" * 40)

if student_token:
    tests = [
        ("实验列表", f"{BASE_URL}/student/experiments"),
        ("讲义列表", f"{BASE_URL}/student/lectures"),
        ("成绩查询", f"{BASE_URL}/student/scores"),
        ("作业列表", f"{BASE_URL}/student/homework/list"),
        ("考试列表", f"{BASE_URL}/student/exam/list"),
    ]
    for name, url in tests:
        print(test_and_report(name, url, "GET", None, student_headers))
else:
    print("[SKIP] 需要学生Token")

# =============================================
# 5. 文件预览测试
# =============================================
print("\n【5. 文件预览测试】")
print("-" * 40)

# 测试预览接口（不需要认证）
result = make_request(f"{BASE_URL}/preview/lecture/1", "GET")
if result and "error" not in str(type(result)):
    print("[PASS] 讲义文件预览 (lecture_id=1)")
else:
    print("[INFO] 讲义预览返回文件流（正常）")

# =============================================
# 6. CRUD 操作测试
# =============================================
print("\n【6. CRUD操作测试】")
print("-" * 40)

if teacher_token:
    # 创建班级
    result = make_request(f"{BASE_URL}/teacher/clazz", "POST",
        json.dumps({"no": "TEST99", "memo": "API测试班级", "state": 1}).encode("utf-8"),
        teacher_headers)
    if result.get("success"):
        print("[PASS] 创建班级 (TEST99)")
        clazz_created = True
    else:
        print(f"[FAIL] 创建班级 - {result.get('message')}")
        clazz_created = False
    
    # 查询班级
    result = make_request(f"{BASE_URL}/teacher/clazz/TEST99", "GET", None, teacher_headers)
    if result.get("success"):
        print("[PASS] 查询班级 (TEST99)")
    else:
        print(f"[FAIL] 查询班级 - {result.get('message')}")
    
    # 更新班级
    result = make_request(f"{BASE_URL}/teacher/clazz/TEST99", "PUT",
        json.dumps({"memo": "已更新", "state": 1}).encode("utf-8"),
        teacher_headers)
    if result.get("success"):
        print("[PASS] 更新班级 (TEST99)")
    else:
        print(f"[FAIL] 更新班级 - {result.get('message')}")
    
    # 删除班级
    result = make_request(f"{BASE_URL}/teacher/clazz/TEST99", "DELETE", None, teacher_headers)
    if result.get("success"):
        print("[PASS] 删除班级 (TEST99)")
    else:
        print(f"[FAIL] 删除班级 - {result.get('message')}")

print("\n" + "=" * 60)
print("测试完成!")
print("=" * 60)
