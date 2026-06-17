@echo off
setlocal
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0setup-lsp.ps1" %*
exit /b %ERRORLEVEL%
