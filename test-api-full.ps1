# Labex API Test Script
$ErrorActionPreference = "Continue"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Labex - API Test" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$global:adminToken = $null
$global:teacherToken = $null
$global:studentToken = $null

# Test 1: Admin Login
Write-Host "[TEST] Admin Login" -ForegroundColor Yellow
$body = @{account="admin";password="admin123";role="ADMIN"} | ConvertTo-Json
try {
    $response = Invoke-RestMethod -Uri "http://localhost:8080/api/auth/login" -Method Post -ContentType "application/json" -Body $body
    if ($response.success) {
        Write-Host "  PASS - Token: $($response.data.token.Substring(0,30))..." -ForegroundColor Green
        $global:adminToken = $response.data.token
    } else {
        Write-Host "  FAIL - $($response.message)" -ForegroundColor Red
    }
} catch { Write-Host "  FAIL - $_" -ForegroundColor Red }

# Test 2: Teacher Login
Write-Host "[TEST] Teacher Login" -ForegroundColor Yellow
$body = @{account="teacher1";password="123456";role="TEACHER"} | ConvertTo-Json
try {
    $response = Invoke-RestMethod -Uri "http://localhost:8080/api/auth/login" -Method Post -ContentType "application/json" -Body $body
    if ($response.success) {
        Write-Host "  PASS - Token obtained" -ForegroundColor Green
        $global:teacherToken = $response.data.token
    } else {
        Write-Host "  FAIL - $($response.message)" -ForegroundColor Red
    }
} catch { Write-Host "  FAIL - $_" -ForegroundColor Red }

# Test 3: Student Login
Write-Host "[TEST] Student Login" -ForegroundColor Yellow
$body = @{account="23201335";password="123456";role="STUDENT"} | ConvertTo-Json
try {
    $response = Invoke-RestMethod -Uri "http://localhost:8080/api/auth/login" -Method Post -ContentType "application/json" -Body $body
    if ($response.success) {
        Write-Host "  PASS - Token obtained" -ForegroundColor Green
        $global:studentToken = $response.data.token
    } else {
        Write-Host "  FAIL - $($response.message)" -ForegroundColor Red
    }
} catch { Write-Host "  FAIL - $_" -ForegroundColor Red }

# Admin Headers
$adminHeaders = @{"Authorization"="Bearer $adminToken"}
$teacherHeaders = @{"Authorization"="Bearer $teacherToken"}
$studentHeaders = @{"Authorization"="Bearer $studentToken"}

Write-Host ""
Write-Host "=== Admin Module ===" -ForegroundColor Cyan

# Admin Teacher List
Write-Host "[TEST] Admin Teacher List" -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "http://localhost:8080/api/admin/teacher/list" -Method Get -Headers $adminHeaders
    if ($response.success) { Write-Host "  PASS - Total: $($response.data.total)" -ForegroundColor Green }
    else { Write-Host "  FAIL - $($response.message)" -ForegroundColor Red }
} catch { Write-Host "  FAIL - $_" -ForegroundColor Red }

# Admin Student List
Write-Host "[TEST] Admin Student List" -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "http://localhost:8080/api/admin/student/list" -Method Get -Headers $adminHeaders
    if ($response.success) { Write-Host "  PASS - Total: $($response.data.total)" -ForegroundColor Green }
    else { Write-Host "  FAIL - $($response.message)" -ForegroundColor Red }
} catch { Write-Host "  FAIL - $_" -ForegroundColor Red }

# Admin Clazz List
Write-Host "[TEST] Admin Clazz List" -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "http://localhost:8080/api/admin/clazz/list" -Method Get -Headers $adminHeaders
    if ($response.success) { Write-Host "  PASS - Total: $($response.data.total)" -ForegroundColor Green }
    else { Write-Host "  FAIL - $($response.message)" -ForegroundColor Red }
} catch { Write-Host "  FAIL - $_" -ForegroundColor Red }

# Admin Stats
Write-Host "[TEST] Admin Stats" -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "http://localhost:8080/api/admin/stats" -Method Get -Headers $adminHeaders
    if ($response.success) { Write-Host "  PASS" -ForegroundColor Green }
    else { Write-Host "  FAIL - $($response.message)" -ForegroundColor Red }
} catch { Write-Host "  FAIL - $_" -ForegroundColor Red }

Write-Host ""
Write-Host "=== Teacher Module ===" -ForegroundColor Cyan

# Teacher Clazz List
Write-Host "[TEST] Teacher Clazz List" -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "http://localhost:8080/api/teacher/clazz/list" -Method Get -Headers $teacherHeaders
    if ($response.success) { Write-Host "  PASS - Total: $($response.data.total)" -ForegroundColor Green }
    else { Write-Host "  FAIL - $($response.message)" -ForegroundColor Red }
} catch { Write-Host "  FAIL - $_" -ForegroundColor Red }

# Teacher Student List
Write-Host "[TEST] Teacher Student List" -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "http://localhost:8080/api/teacher/student/list" -Method Get -Headers $teacherHeaders
    if ($response.success) { Write-Host "  PASS - Total: $($response.data.total)" -ForegroundColor Green }
    else { Write-Host "  FAIL - $($response.message)" -ForegroundColor Red }
} catch { Write-Host "  FAIL - $_" -ForegroundColor Red }

# Teacher Experiment List
Write-Host "[TEST] Teacher Experiment List" -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "http://localhost:8080/api/teacher/experiment/list" -Method Get -Headers $teacherHeaders
    if ($response.success) { Write-Host "  PASS - Total: $($response.data.total)" -ForegroundColor Green }
    else { Write-Host "  FAIL - $($response.message)" -ForegroundColor Red }
} catch { Write-Host "  FAIL - $_" -ForegroundColor Red }

# Teacher Lecture List
Write-Host "[TEST] Teacher Lecture List" -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "http://localhost:8080/api/teacher/lecture/list" -Method Get -Headers $teacherHeaders
    if ($response.success) { Write-Host "  PASS - Total: $($response.data.total)" -ForegroundColor Green }
    else { Write-Host "  FAIL - $($response.message)" -ForegroundColor Red }
} catch { Write-Host "  FAIL - $_" -ForegroundColor Red }

Write-Host ""
Write-Host "=== Student Module ===" -ForegroundColor Cyan

# Student Experiments
Write-Host "[TEST] Student Experiments" -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "http://localhost:8080/api/student/experiments" -Method Get -Headers $studentHeaders
    if ($response.success) { Write-Host "  PASS - Total: $($response.data.Count)" -ForegroundColor Green }
    else { Write-Host "  FAIL - $($response.message)" -ForegroundColor Red }
} catch { Write-Host "  FAIL - $_" -ForegroundColor Red }

# Student Lectures
Write-Host "[TEST] Student Lectures" -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "http://localhost:8080/api/student/lectures" -Method Get -Headers $studentHeaders
    if ($response.success) { Write-Host "  PASS - Total: $($response.data.Count)" -ForegroundColor Green }
    else { Write-Host "  FAIL - $($response.message)" -ForegroundColor Red }
} catch { Write-Host "  FAIL - $_" -ForegroundColor Red }

# Student Scores
Write-Host "[TEST] Student Scores" -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "http://localhost:8080/api/student/scores" -Method Get -Headers $studentHeaders
    if ($response.success) { Write-Host "  PASS" -ForegroundColor Green }
    else { Write-Host "  FAIL - $($response.message)" -ForegroundColor Red }
} catch { Write-Host "  FAIL - $_" -ForegroundColor Red }

Write-Host ""
Write-Host "=== File Preview ===" -ForegroundColor Cyan

# Preview Lecture 1
Write-Host "[TEST] Preview Lecture 1" -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "http://localhost:8080/api/preview/lecture/1" -Method Get
    if ($response) { Write-Host "  PASS - Response received" -ForegroundColor Green }
} catch { Write-Host "  FAIL - $_" -ForegroundColor Red }

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Tests Complete" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
