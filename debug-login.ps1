# Debug Login Test
Write-Host "=== Debug Login Test ===" -ForegroundColor Cyan

# Admin Login Debug
Write-Host "`n[DEBUG] Admin Login Raw Response:" -ForegroundColor Yellow
$body = @{account="admin";password="admin123";role="ADMIN"} | ConvertTo-Json
$raw = Invoke-WebRequest -Uri "http://localhost:8080/api/auth/login" -Method Post -ContentType "application/json" -Body $body
Write-Host "Status: $($raw.StatusCode)" -ForegroundColor White
Write-Host "Content: $($raw.Content)" -ForegroundColor White

# Teacher Login Debug
Write-Host "`n[DEBUG] Teacher Login Raw Response:" -ForegroundColor Yellow
$body = @{account="teacher1";password="123456";role="TEACHER"} | ConvertTo-Json
$raw = Invoke-WebRequest -Uri "http://localhost:8080/api/auth/login" -Method Post -ContentType "application/json" -Body $body
Write-Host "Status: $($raw.StatusCode)" -ForegroundColor White
Write-Host "Content: $($raw.Content)" -ForegroundColor White

# Student Login Debug
Write-Host "`n[DEBUG] Student Login Raw Response:" -ForegroundColor Yellow
$body = @{account="23201335";password="123456";role="STUDENT"} | ConvertTo-Json
$raw = Invoke-WebRequest -Uri "http://localhost:8080/api/auth/login" -Method Post -ContentType "application/json" -Body $body
Write-Host "Status: $($raw.StatusCode)" -ForegroundColor White
Write-Host "Content: $($raw.Content)" -ForegroundColor White

# Check admin credentials in DB
Write-Host "`n[DEBUG] Testing admin with teacher account:" -ForegroundColor Yellow
$body = @{account="admin";password="admin123";role="TEACHER"} | ConvertTo-Json
$raw = Invoke-WebRequest -Uri "http://localhost:8080/api/auth/login" -Method Post -ContentType "application/json" -Body $body
Write-Host "Status: $($raw.StatusCode)" -ForegroundColor White
Write-Host "Content: $($raw.Content)" -ForegroundColor White
