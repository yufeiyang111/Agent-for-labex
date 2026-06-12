# 压力测试方案

## 一、概述

本文档描述Labex项目的压力测试方案，使用Apache Bench (ab)进行API压力测试。

## 二、测试环境

- Backend API: http://localhost:8080/api
- Frontend: http://localhost:3000
- 测试工具: Apache Bench (ab)

## 三、测试用例

### ST-01: 登录接口压力测试
```bash
# 登录请求内容 (login_payload.json)
{
  "account": "2021001",
  "password": "password123",
  "role": "STUDENT"
}

# 测试命令
ab -n 1000 -c 100 -p login_payload.json -T application/json http://localhost:8080/api/auth/login
```

### ST-02: 学生实验列表压力测试
```bash
# 需要先获取token
TOKEN="your_jwt_token"
ab -n 500 -c 50 -H "Authorization: Bearer $TOKEN" http://localhost:8080/api/student/experiments
```

### ST-03: 考试列表压力测试
```bash
TOKEN="your_jwt_token"
ab -n 500 -c 50 -H "Authorization: Bearer $TOKEN" http://localhost:8080/api/student/exam/list
```

### ST-04: 提交考试答案压力测试
```bash
# 请求体 (submit_payload.json)
[
  {"questionId": 1, "myAnswer": "A"},
  {"questionId": 2, "myAnswer": "B"}
]

TOKEN="your_jwt_token"
ab -n 300 -c 30 -p submit_payload.json -T application/json -H "Authorization: Bearer $TOKEN" http://localhost:8080/api/student/exam/1/submit
```

### ST-05: 教师题目列表压力测试
```bash
TOKEN="your_jwt_token"
ab -n 500 -c 50 -H "Authorization: Bearer $TOKEN" http://localhost:8080/api/teacher/question/list
```

### ST-06: RAG问答压力测试
```bash
# 请求体 (rag_payload.json)
{
  "query": "什么是Java的多态？",
  "sessionId": "test-session"
}

TOKEN="your_jwt_token"
ab -n 200 -c 20 -p rag_payload.json -T application/json -H "Authorization: Bearer $TOKEN" http://localhost:8080/api/rag/query
```

## 四、测试执行脚本

### stress_test.sh
```bash
#!/bin/bash

# Labex压力测试脚本

API_BASE="http://localhost:8080/api"
RESULTS_DIR="./results"

# 确保结果目录存在
mkdir -p $RESULTS_DIR

# 获取Token函数
get_token() {
  local account=$1
  local password=$2
  local role=$3

  response=$(curl -s -X POST "$API_BASE/auth/login" \
    -H "Content-Type: application/json" \
    -d "{\"account\":\"$account\",\"password\":\"$password\",\"role\":\"$role\"}")

  echo $response | grep -o '"token":"[^"]*"' | cut -d'"' -f4
}

echo "=== Labex 压力测试开始 ==="
echo "测试时间: $(date)"
echo ""

# 测试 ST-01: 登录接口
echo "ST-01: 登录接口压力测试"
echo '{"account":"2021001","password":"password123","role":"STUDENT"}' > /tmp/login_payload.json
ab -n 1000 -c 100 -p /tmp/login_payload.json -T application/json "$API_BASE/auth/login" > "$RESULTS_DIR/st01_login.txt" 2>&1
echo "完成，结果保存至 $RESULTS_DIR/st01_login.txt"
echo ""

# 获取学生Token
STUDENT_TOKEN=$(get_token "2021001" "password123" "STUDENT")
echo "获取学生Token: ${STUDENT_TOKEN:0:20}..."

# 测试 ST-02: 学生实验列表
echo "ST-02: 学生实验列表压力测试"
ab -n 500 -c 50 -H "Authorization: Bearer $STUDENT_TOKEN" "$API_BASE/student/experiments" > "$RESULTS_DIR/st02_experiments.txt" 2>&1
echo "完成，结果保存至 $RESULTS_DIR/st02_experiments.txt"
echo ""

# 测试 ST-03: 考试列表
echo "ST-03: 考试列表压力测试"
ab -n 500 -c 50 -H "Authorization: Bearer $STUDENT_TOKEN" "$API_BASE/student/exam/list" > "$RESULTS_DIR/st03_exam_list.txt" 2>&1
echo "完成，结果保存至 $RESULTS_DIR/st03_exam_list.txt"
echo ""

# 测试 ST-05: 教师题目列表
TEACHER_TOKEN=$(get_token "teacher1" "teacher123" "TEACHER")
echo "获取教师Token: ${TEACHER_TOKEN:0:20}..."

echo "ST-05: 教师题目列表压力测试"
ab -n 500 -c 50 -H "Authorization: Bearer $TEACHER_TOKEN" "$API_BASE/teacher/question/list" > "$RESULTS_DIR/st05_questions.txt" 2>&1
echo "完成，结果保存至 $RESULTS_DIR/st05_questions.txt"
echo ""

echo "=== Labex 压力测试完成 ==="
echo "所有结果保存在 $RESULTS_DIR 目录"
```

## 五、预期结果

| 测试编号 | 端点 | 并发数 | 请求数 | 预期QPS | 预期响应时间 |
|---------|------|--------|--------|---------|-------------|
| ST-01 | POST /api/auth/login | 100 | 1000 | > 500 | < 100ms |
| ST-02 | GET /api/student/experiments | 50 | 500 | > 300 | < 200ms |
| ST-03 | GET /api/student/exam/list | 50 | 500 | > 300 | < 200ms |
| ST-04 | POST /api/student/exam/{id}/submit | 30 | 300 | > 100 | < 500ms |
| ST-05 | GET /api/teacher/question/list | 50 | 500 | > 300 | < 200ms |
| ST-06 | POST /api/rag/query | 20 | 200 | > 50 | < 2000ms |

## 六、结果分析

### 关键指标
- **QPS (Queries Per Second)**: 每秒请求数
- **响应时间**: 50%, 90%, 99%分位
- **错误率**: 失败请求数/总请求数
- **吞吐量**: 成功处理的请求总数

### 性能问题定位
1. **高响应时间**: 检查数据库查询、连接池配置
2. **高错误率**: 检查日志、内存、磁盘空间
3. **低QPS**: 检查CPU、内存、网络带宽