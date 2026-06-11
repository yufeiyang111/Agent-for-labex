#!/bin/bash

# Labex 压力测试脚本
# 使用 Apache Bench 进行API压力测试

API_BASE="http://localhost:8080/api"
RESULTS_DIR="$(dirname "$0")/results"

# 确保结果目录存在
mkdir -p "$RESULTS_DIR"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Labex 压力测试开始 ===${NC}"
echo "测试时间: $(date)"
echo ""

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

# 检查ab是否安装
if ! command -v ab &> /dev/null; then
    echo -e "${RED}错误: Apache Bench (ab) 未安装${NC}"
    echo "请安装 Apache Bench: "
    echo "  macOS: brew install httpd"
    echo "  Ubuntu/Debian: apt-get install apache2-utils"
    echo "  Windows: 下载 Apache for Windows"
    exit 1
fi

# 测试 ST-01: 登录接口
echo -e "${YELLOW}ST-01: 登录接口压力测试${NC}"
echo '{"account":"2021001","password":"password123","role":"STUDENT"}' > /tmp/login_payload.json
ab -n 1000 -c 100 -p /tmp/login_payload.json -T application/json "$API_BASE/auth/login" > "$RESULTS_DIR/st01_login.txt" 2>&1
echo "完成，结果保存至 $RESULTS_DIR/st01_login.txt"
echo ""

# 获取学生Token
STUDENT_TOKEN=$(get_token "2021001" "password123" "STUDENT")
if [ -z "$STUDENT_TOKEN" ]; then
    echo -e "${RED}警告: 无法获取学生Token，跳过需要认证的测试${NC}"
    STUDENT_TOKEN="dummy_token"
fi
echo "获取学生Token: ${STUDENT_TOKEN:0:20}..."

# 测试 ST-02: 学生实验列表
echo -e "${YELLOW}ST-02: 学生实验列表压力测试${NC}"
ab -n 500 -c 50 -H "Authorization: Bearer $STUDENT_TOKEN" "$API_BASE/student/experiments" > "$RESULTS_DIR/st02_experiments.txt" 2>&1
echo "完成，结果保存至 $RESULTS_DIR/st02_experiments.txt"
echo ""

# 测试 ST-03: 考试列表
echo -e "${YELLOW}ST-03: 考试列表压力测试${NC}"
ab -n 500 -c 50 -H "Authorization: Bearer $STUDENT_TOKEN" "$API_BASE/student/exam/list" > "$RESULTS_DIR/st03_exam_list.txt" 2>&1
echo "完成，结果保存至 $RESULTS_DIR/st03_exam_list.txt"
echo ""

# 测试 ST-04: 作业列表
echo -e "${YELLOW}ST-04: 作业列表压力测试${NC}"
ab -n 500 -c 50 -H "Authorization: Bearer $STUDENT_TOKEN" "$API_BASE/student/homework/list" > "$RESULTS_DIR/st04_homework.txt" 2>&1
echo "完成，结果保存至 $RESULTS_DIR/st04_homework.txt"
echo ""

# 获取教师Token
TEACHER_TOKEN=$(get_token "teacher1" "teacher123" "TEACHER")
if [ -z "$TEACHER_TOKEN" ]; then
    echo -e "${RED}警告: 无法获取教师Token${NC}"
    TEACHER_TOKEN="dummy_token"
fi
echo "获取教师Token: ${TEACHER_TOKEN:0:20}..."

# 测试 ST-05: 教师题目列表
echo -e "${YELLOW}ST-05: 教师题目列表压力测试${NC}"
ab -n 500 -c 50 -H "Authorization: Bearer $TEACHER_TOKEN" "$API_BASE/teacher/question/list" > "$RESULTS_DIR/st05_questions.txt" 2>&1
echo "完成，结果保存至 $RESULTS_DIR/st05_questions.txt"
echo ""

# 测试 ST-06: 班级列表
echo -e "${YELLOW}ST-06: 班级列表压力测试${NC}"
ab -n 500 -c 50 -H "Authorization: Bearer $TEACHER_TOKEN" "$API_BASE/teacher/clazz/list" > "$RESULTS_DIR/st06_classes.txt" 2>&1
echo "完成，结果保存至 $RESULTS_DIR/st06_classes.txt"
echo ""

echo -e "${GREEN}=== Labex 压力测试完成 ===${NC}"
echo "所有结果保存在 $RESULTS_DIR 目录"
echo ""

# 显示摘要结果
echo "=== 测试结果摘要 ==="
echo ""

for result_file in "$RESULTS_DIR"/*.txt; do
    if [ -f "$result_file" ]; then
        filename=$(basename "$result_file")
        echo "--- $filename ---"
        grep -E "Requests per second|Time per request|Failed requests" "$result_file" 2>/dev/null | head -5
        echo ""
    fi
done