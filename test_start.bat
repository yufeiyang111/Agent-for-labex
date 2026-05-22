@echo off
title Labex 诊断 - start 命令测试
echo ============================================
echo   start 命令测试脚本
echo ============================================
echo.
echo 如果能看到这段中文，说明 GBK 编码正常
echo.
echo 将尝试打开一个新窗口...
echo.
start "Test-Window" cmd /k "title Test-Window && echo 这个窗口是从 start 命令打开的 && echo 如果看到这行字，说明 start 命令工作正常 && echo. && echo 请手动关闭这个窗口"
echo.
echo 新窗口已启动，请在任务栏查看 Test-Window
echo.
pause
