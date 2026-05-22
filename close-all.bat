@echo off
title Labex Ò»¼üÍ£Ö¹
echo ============================================
echo   ÕýÔÚÍ£Ö¹ËùÓÐ Labex ·þÎñ...
echo ============================================
echo.

echo [1/5] Í£Ö¹ Redis...
taskkill /f /fi "WINDOWTITLE eq Labex-Redis" >nul 2>nul
echo        Redis ÒÑÍ£Ö¹ [OK]

echo [2/5] Í£Ö¹ Neo4j...
taskkill /f /fi "WINDOWTITLE eq Labex-Neo4j" >nul 2>nul
echo        Neo4j ÒÑÍ£Ö¹ [OK]

echo [3/5] Í£Ö¹ Embedding Service...
taskkill /f /fi "WINDOWTITLE eq Labex-Embedding" >nul 2>nul
echo        Embedding Service ÒÑÍ£Ö¹ [OK]

echo [4/5] Í£Ö¹ Backend...
taskkill /f /fi "WINDOWTITLE eq Labex-Backend" >nul 2>nul
echo        Backend ÒÑÍ£Ö¹ [OK]

echo [5/5] Í£Ö¹ Frontend...
taskkill /f /fi "WINDOWTITLE eq Labex-Frontend" >nul 2>nul
echo        Frontend ÒÑÍ£Ö¹ [OK]

echo.
echo ============================================
echo   ËùÓÐ·þÎñÒÑÍ£Ö¹£¡
echo ============================================
echo.
timeout /t 2 /nobreak >nul