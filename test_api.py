#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import sys
import io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
"""
Labex API Test Script
"""
import json
import urllib.request
import urllib.error

BASE_URL = "http://localhost:8080/api"

def make_request(url, method="GET", data=None, headers=None):
    """Make HTTP request"""
    if headers is None:
        headers = {}
    headers["Content-Type"] = "application/json"
    
    req = urllib.request.Request(url, data=data, headers=headers, method=method)
    
    try:
        with urllib.request.urlopen(req, timeout=10) as response:
            return json.loads(response.read().decode("utf-8"))
    except urllib.error.HTTPError as e:
        return {"error": f"HTTP {e.code}: {e.reason}", "body": e.read().decode("utf-8")}
    except Exception as e:
        return {"error": str(e)}

def test_login():
    """Test login for all roles"""
    print("\n" + "="*50)
    print("1. 认证模块测试")
    print("="*50)
    
    results = {}
    
    # Admin Login
    print("\n[1.1] 管理员登录")
    data = json.dumps({"account": "admin", "password": "admin123", "role": "ADMIN"}).encode("utf-8")
    result = make_request(f"{BASE_URL}/auth/login", "POST", data)
    if result.get("success"):
        print(f"  ✓ PASS - Token obtained")
        results["admin_token"] = result["data"]["token"]
    else:
        print(f"  ✗ FAIL - {result.get('message', result.get('error'))}")
        results["admin_token"] = None
    
    # Teacher Login
    print("\n[1.2] 教师登录")
    data = json.dumps({"account": "teacher1", "password": "123456", "role": "TEACHER"}).encode("utf-8")
    result = make_request(f"{BASE_URL}/auth/login", "POST", data)
    if result.get("success"):
        print(f"  ✓ PASS - Token obtained")
        results["teacher_token"] = result["data"]["token"]
    else:
        print(f"  ✗ FAIL - {result.get('message', result.get('error'))}")
        results["teacher_token"] = None
    
    # Student Login
    print("\n[1.3] 学生登录")
    data = json.dumps({"account": "23201335", "password": "123456", "role": "STUDENT"}).encode("utf-8")
    result = make_request(f"{BASE_URL}/auth/login", "POST", data)
    if result.get("success"):
        print(f"  ✓ PASS - Token obtained")
        results["student_token"] = result["data"]["token"]
    else:
        print(f"  ✗ FAIL - {result.get('message', result.get('error'))}")
        results["student_token"] = None
    
    return results

def test_admin_module(token):
    """Test admin module APIs"""
    print("\n" + "="*50)
    print("2. 管理员模块测试")
    print("="*50)
    
    headers = {"Authorization": f"Bearer {token}"}
    
    tests = [
        ("[2.1] 教师列表", f"{BASE_URL}/admin/teacher/list"),
        ("[2.2] 学生列表", f"{BASE_URL}/admin/student/list"),
        ("[2.3] 班级列表", f"{BASE_URL}/admin/clazz/list"),
        ("[2.4] 系统统计", f"{BASE_URL}/admin/stats"),
    ]
    
    for name, url in tests:
        result = make_request(url, "GET", headers=headers)
        if result.get("success"):
            print(f"  ✓ {name} - PASS")
        else:
            print(f"  ✗ {name} - FAIL: {result.get('message', result.get('error'))}")

def test_teacher_module(token):
    """Test teacher module APIs"""
    print("\n" + "="*50)
    print("3. 教师模块测试")
    print("="*50)
    
    headers = {"Authorization": f"Bearer {token}"}
    
    tests = [
        ("[3.1] 班级列表", f"{BASE_URL}/teacher/clazz/list"),
        ("[3.2] 学生列表", f"{BASE_URL}/teacher/student/list"),
        ("[3.3] 实验列表", f"{BASE_URL}/teacher/experiment/list"),
        ("[3.4] 讲义列表", f"{BASE_URL}/teacher/lecture/list"),
        ("[3.5] 成绩列表", f"{BASE_URL}/teacher/score/experiment/1/students"),
        ("[3.6] 题目列表", f"{BASE_URL}/teacher/experiment-item/list"),
        ("[3.7] 作业列表", f"{BASE_URL}/teacher/homework/list"),
    ]
    
    for name, url in tests:
        result = make_request(url, "GET", headers=headers)
        if result.get("success"):
            total = result.get("data", {}).get("total", len(result.get("data", [])))
            print(f"  ✓ {name} - PASS (total: {total})")
        else:
            print(f"  ✗ {name} - FAIL: {result.get('message', result.get('error'))}")

def test_student_module(token):
    """Test student module APIs"""
    print("\n" + "="*50)
    print("4. 学生模块测试")
    print("="*50)
    
    headers = {"Authorization": f"Bearer {token}"}
    
    tests = [
        ("[4.1] 实验列表", f"{BASE_URL}/student/experiments"),
        ("[4.2] 讲义列表", f"{BASE_URL}/student/lectures"),
        ("[4.3] 成绩查询", f"{BASE_URL}/student/scores"),
        ("[4.4] 作业列表", f"{BASE_URL}/student/homework/list"),
        ("[4.5] 考试列表", f"{BASE_URL}/student/exam/list"),
    ]
    
    for name, url in tests:
        result = make_request(url, "GET", headers=headers)
        if result.get("success"):
            count = len(result.get("data", []))
            print(f"  ✓ {name} - PASS (count: {count})")
        else:
            print(f"  ✗ {name} - FAIL: {result.get('message', result.get('error'))}")

def test_file_preview():
    """Test file preview"""
    print("\n" + "="*50)
    print("5. 文件预览测试")
    print("="*50)
    
    # Preview Lecture 1
    print("\n[5.1] 讲义文件预览")
    result = make_request(f"{BASE_URL}/preview/lecture/1")
    if result and "error" not in result:
        print(f"  ✓ PASS - Response received (type: {type(result)})")
    else:
        print(f"  ✗ FAIL - {result}")

def test_crud_operations(token):
    """Test CRUD operations"""
    print("\n" + "="*50)
    print("6. CRUD操作测试")
    print("="*50)
    
    headers = {"Authorization": f"Bearer {token}"}
    
    # Test creating a class
    print("\n[6.1] 创建班级 (POST)")
    data = json.dumps({
        "clazzNo": "TEST001",
        "memo": "API测试班级",
        "state": 1
    }).encode("utf-8")
    result = make_request(f"{BASE_URL}/teacher/clazz", "POST", data, headers)
    if result.get("success"):
        print(f"  ✓ PASS - Class created")
    else:
        print(f"  ✗ FAIL - {result.get('message', result.get('error'))}")
    
    # Test reading the class
    print("\n[6.2] 查询班级 (GET)")
    result = make_request(f"{BASE_URL}/teacher/clazz/TEST001", "GET", headers=headers)
    if result.get("success"):
        print(f"  ✓ PASS - Class retrieved")
    else:
        print(f"  ✗ FAIL - {result.get('message', result.get('error'))}")
    
    # Test updating the class
    print("\n[6.3] 更新班级 (PUT)")
    data = json.dumps({
        "memo": "API测试班级-已更新",
        "state": 1
    }).encode("utf-8")
    result = make_request(f"{BASE_URL}/teacher/clazz/TEST001", "PUT", data, headers)
    if result.get("success"):
        print(f"  ✓ PASS - Class updated")
    else:
        print(f"  ✗ FAIL - {result.get('message', result.get('error'))}")
    
    # Test deleting the class
    print("\n[6.4] 删除班级 (DELETE)")
    result = make_request(f"{BASE_URL}/teacher/clazz/TEST001", "DELETE", headers=headers)
    if result.get("success"):
        print(f"  ✓ PASS - Class deleted")
    else:
        print(f"  ✗ FAIL - {result.get('message', result.get('error'))}")

def main():
    print("\n" + "#"*50)
    print("# Labex 实验教学管理系统 - API全面测试")
    print("#"*50)
    
    # Test authentication
    tokens = test_login()
    
    # Test admin module
    if tokens.get("admin_token"):
        test_admin_module(tokens["admin_token"])
    
    # Test teacher module
    if tokens.get("teacher_token"):
        test_teacher_module(tokens["teacher_token"])
    
    # Test student module
    if tokens.get("student_token"):
        test_student_module(tokens["student_token"])
    
    # Test file preview
    test_file_preview()
    
    # Test CRUD operations
    if tokens.get("teacher_token"):
        test_crud_operations(tokens["teacher_token"])
    
    print("\n" + "#"*50)
    print("# 测试完成!")
    print("#"*50 + "\n")

if __name__ == "__main__":
    main()
