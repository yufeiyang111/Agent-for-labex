# Test API script
$headers = @{"Content-Type" = "application/json"}

# Test 1: Admin Login
Write-Host "=== Test 1: Admin Login ===" -ForegroundColor Cyan
$body = @{
    account = "admin"
    password = "admin123"
} | ConvertTo-Json
try {
    $response = Invoke-RestMethod -Uri 'http://localhost:8080/api/auth/login' -Method Post -ContentType 'application/json' -Body $body
    Write-Host "Response:" $response -ForegroundColor Green
    $global:adminToken = $response.data.token
    Write-Host "Token obtained: $($global:adminToken.Substring(0, [Math]::Min(50, $global:adminToken.Length)))..." -ForegroundColor Yellow
} catch {
    Write-Host "Error: $_" -ForegroundColor Red
}

# Test 2: Teacher Login
Write-Host "`n=== Test 2: Teacher Login ===" -ForegroundColor Cyan
$body = @{
    account = "teacher1"
    password = "123456"
} | ConvertTo-Json
try {
    $response = Invoke-RestMethod -Uri 'http://localhost:8080/api/auth/login' -Method Post -ContentType 'application/json' -Body $body
    Write-Host "Response:" $response -ForegroundColor Green
    $global:teacherToken = $response.data.token
} catch {
    Write-Host "Error: $_" -ForegroundColor Red
}

# Test 3: Student Login
Write-Host "`n=== Test 3: Student Login ===" -ForegroundColor Cyan
$body = @{
    account = "23201335"
    password = "123456"
} | ConvertTo-Json
try {
    $response = Invoke-RestMethod -Uri 'http://localhost:8080/api/auth/login' -Method Post -ContentType 'application/json' -Body $body
    Write-Host "Response:" $response -ForegroundColor Green
    $global:studentToken = $response.data.token
} catch {
    Write-Host "Error: $_" -ForegroundColor Red
}

# Test 4: Get User Info (Admin)
Write-Host "`n=== Test 4: Get User Info (Admin) ===" -ForegroundColor Cyan
if ($global:adminToken) {
    try {
        $headers["Authorization"] = "Bearer $($global:adminToken)"
        $response = Invoke-RestMethod -Uri 'http://localhost:8080/api/auth/userinfo' -Method Get -Headers $headers
        Write-Host "Response:" $response -ForegroundColor Green
    } catch {
        Write-Host "Error: $_" -ForegroundColor Red
    }
}

Write-Host "`n=== Tests Completed ===" -ForegroundColor Cyan
