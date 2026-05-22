@echo off
title Labex 一键启动
setlocal enabledelayedexpansion

echo ============================================
echo   Labex 实验教学管理系统 - 一键启动
echo ============================================
echo.

REM ---- 配置路径 ----
set PROJECT_DIR=D:\workfordasan
set REDIS_DIR=D:\ai\redis\Redis-8.0.2-Windows-x64-cygwin-with-Service\Redis-8.0.2-Windows-x64-cygwin-with-Service
set NEO4J_DIR=D:\35475\Neo4j\neo4j-chs-community-2025.02.0-windows
set EMBEDDING_DIR=%PROJECT_DIR%\embedding_service
set BACKEND_DIR=%PROJECT_DIR%\backend
set FRONTEND_DIR=%PROJECT_DIR%\frontend

REM ---- 检查环境 ----
where python >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [错误] 未找到 Python，请确保 Python 已加入 PATH
    pause
    exit /b 1
)

where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [错误] 未找到 Node.js，请确保 Node.js 已加入 PATH
    pause
    exit /b 1
)

where mvn >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [错误] 未找到 Maven，请确保 Maven 已加入 PATH
    pause
    exit /b 1
)

echo 即将启动以下服务：
echo   [1] Redis               %REDIS_DIR%
echo   [2] Neo4j               %NEO4J_DIR%
echo   [3] Embedding Service   %EMBEDDING_DIR%
echo   [4] Backend (Spring)    %BACKEND_DIR%
echo   [5] Frontend (Vite)     %FRONTEND_DIR%
echo.
echo 每个服务会打开独立的窗口，关闭窗口 = 停止该服务
echo.

REM ---- 启动 Redis ----
echo [1/5] 启动 Redis...
start "Labex-Redis" "%REDIS_DIR%\redis-server.exe"
if %ERRORLEVEL% NEQ 0 (
    echo [警告] Redis 启动失败，请检查路径
) else (
    echo        Redis 已启动 [OK]
)
timeout /t 2 /nobreak >nul

REM ---- 启动 Neo4j ----
echo [2/5] 启动 Neo4j...
start "Labex-Neo4j" /d "%NEO4J_DIR%" cmd /k "title Labex-Neo4j && bin\neo4j.bat console"
if %ERRORLEVEL% NEQ 0 (
    echo [警告] Neo4j 启动失败，请检查路径
) else (
    echo        Neo4j 已启动 [OK]
)

REM ---- 启动 Embedding Service ----
echo [3/5] 启动 Embedding Service...
start "Labex-Embedding" /d "%EMBEDDING_DIR%" cmd /k "title Labex-Embedding && python app.py"
if %ERRORLEVEL% NEQ 0 (
    echo [警告] Embedding Service 启动失败
) else (
    echo        Embedding Service 已启动 [OK]
)

REM ---- 等依赖服务就绪后再启动后端 ----
echo.
echo 等待依赖服务启动 (8 秒)...
timeout /t 8 /nobreak >nul

REM ---- 启动后端 ----
echo [4/5] 启动 Backend (Maven)...
start "Labex-Backend" /d "%BACKEND_DIR%" cmd /k "title Labex-Backend && mvn spring-boot:run"
if %ERRORLEVEL% NEQ 0 (
    echo [警告] Backend 启动失败
) else (
    echo        Backend 正在编译启动 [OK]
)

REM ---- 启动前端 ----
echo [5/5] 启动 Frontend (Vite)...
start "Labex-Frontend" /d "%FRONTEND_DIR%" cmd /k "title Labex-Frontend && npm run dev"
if %ERRORLEVEL% NEQ 0 (
    echo [警告] Frontend 启动失败
) else (
    echo        Frontend 正在编译启动 [OK]
)

echo.
echo ============================================
echo   所有服务已启动！
echo.
echo   前端地址：    http://localhost:3000
echo   后端地址：    http://localhost:8080/api
echo   Neo4j 地址：  http://localhost:7474
echo.
echo   关闭窗口即停止对应服务
echo   一键停止所有：close-all.bat
echo ============================================
echo.
pause
