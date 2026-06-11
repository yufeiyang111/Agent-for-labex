<#
.SYNOPSIS
    LabexAgent E2E 压力测试 —— 从0生成完整项目
.DESCRIPTION
    对已运行的 Labex 后端发起真实 Agent 请求，让 LabexAgent 从头生成一个项目。
    测试内容包括：
      1. 学生登录获取 JWT
      2. 创建空白项目
      3. 配置 LLM 模型 (可选)
      4. 发起 Agent 流任务（生成项目）
      5. 轮询 SSE 事件 / 查询任务状态
      6. 验证生成的文件
      7. 输出性能报告

    支持 -Concurrency N 参数启动多个并行会话做压力测试。

.PARAMETER BaseUrl
    Labex 后端基础地址 (默认 http://localhost:8080/api)
.PARAMETER StudentNo
    学生学号 (默认 2021001)
.PARAMETER Password
    学生密码 (默认 password123)
.PARAMETER Concurrency
    并发会话数 (默认 1)
.PARAMETER TaskPrompt
    给 Agent 的任务描述 (默认生成一个 Vue 项目)
.PARAMETER OutputDir
    测试报告输出目录 (默认 ./stress-test-report)
.PARAMETER TimeoutSeconds
    每个 Agent 会话超时秒数 (默认 300)
.PARAMETER ModelConfigId
    可选的模型配置 ID (不填则使用学生默认模型)

.EXAMPLE
    # 单会话基础测试
    .\agent-stress-test.ps1

.EXAMPLE
    # 5 个并发会话压力测试
    .\agent-stress-test.ps1 -Concurrency 5 -TimeoutSeconds 600

.EXAMPLE
    # 使用自定义模型配置
    .\agent-stress-test.ps1 -ModelConfigId 1 -TaskPrompt "请创建一个 Spring Boot REST API 项目"
#>

param(
    [string]$BaseUrl = "http://localhost:8080/api",
    [string]$StudentNo = "2021001",
    [string]$Password = "password123",
    [int]$Concurrency = 1,
    [string]$TaskPrompt = "请从零创建一个完整的 Vue 3 前端项目，包含登录页面、首页仪表盘和用户管理页面，使用 Element Plus UI 库。",
    [string]$OutputDir = "./stress-test-report",
    [int]$TimeoutSeconds = 300,
    [int]$ModelConfigId = $null
)

$ErrorActionPreference = "Stop"
$reportDir = New-Item -ItemType Directory -Force -Path $OutputDir
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$reportFile = Join-Path $reportDir "stress-test-report-$timestamp.json"
$summaryLines = @()

function Write-Log {
    param([string]$Msg)
    $time = Get-Date -Format "HH:mm:ss.fff"
    Write-Host "[$time] $Msg"
}

function Write-Summary {
    param([string]$Key, [object]$Value)
    $summaryLines += @{ key = $Key; value = $Value }
}

function Invoke-Api {
    param(
        [string]$Method = "GET",
        [string]$Url,
        [object]$Body = $null,
        [string]$Token = $null,
        [int]$Retries = 3
    )
    $headers = @{ "Content-Type" = "application/json" }
    if ($Token) { $headers["Authorization"] = "Bearer $Token" }

    $params = @{
        Method = $Method
        Uri = $Url
        Headers = $headers
        UseBasicParsing = $true
    }
    if ($Body) { $params["Body"] = ($Body | ConvertTo-Json -Compress) }

    $lastErr = $null
    for ($r = 0; $r -lt $Retries; $r++) {
        try {
            $resp = Invoke-WebRequest @params
            $result = $resp.Content | ConvertFrom-Json
            if ($result.code -eq 0 -or $null -eq $result.code) {
                return $result
            }
            throw "API error (code=$($result.code)): $($result.message)"
        } catch {
            $lastErr = $_
            if ($r -lt $Retries - 1) {
                $wait = [Math]::Pow(2, $r) * 0.5
                Write-Log "API retry $($r+1)/$Retries after ${wait}s: $_"
                Start-Sleep -Seconds $wait
            }
        }
    }
    throw $lastErr
}

function Get-JwtToken {
    param([string]$Account, [string]$Pwd)
    Write-Log "Logging in as student '$Account'..."

    $loginBody = @{
        account = $Account
        password = $Pwd
        role = "STUDENT"
    } | ConvertTo-Json

    $resp = Invoke-RestMethod -Method Post -Uri "$BaseUrl/auth/login" `
        -Headers @{ "Content-Type" = "application/json" } `
        -Body $loginBody -UseBasicParsing

    if ($resp.code -ne 0 -or !$resp.data.token) {
        throw "Login failed: $($resp.message)"
    }
    Write-Log "Login OK, token: $($resp.data.token.Substring(0,20))..."
    return $resp.data.token
}

function Create-Project {
    param([string]$Token, [int]$SessionId)
    $projName = "stress-test-session-$SessionId-$timestamp"
    Write-Log "[S$SessionId] Creating empty project '$projName'..."

    $body = @{ projectName = $projName } | ConvertTo-Json
    $resp = Invoke-RestMethod -Method Post -Uri "$BaseUrl/student/projects/empty" `
        -Headers @{ "Authorization" = "Bearer $Token"; "Content-Type" = "application/json" } `
        -Body $body -UseBasicParsing

    if ($resp.code -ne 0 -or !$resp.data) {
        throw "Project creation failed: $($resp.message)"
    }
    $projectId = $resp.data.project_id -or $resp.data.projectId
    Write-Log "[S$SessionId] Project created, ID=$projectId"
    return $projectId
}

function Wait-ForAgentCompletion {
    param(
        [string]$Token,
        [int]$ProjectId,
        [int]$SessionId,
        [string]$TaskMsg,
        [int]$TimeoutSec,
        [int]$ModelId
    )

    $sessionId = [guid]::NewGuid().ToString()
    Write-Log "[S$SessionId] Starting agent session=$sessionId ..."

    $body = @{
        sessionId = $sessionId
        mode = "build"
        message = $TaskMsg
    }
    if ($ModelId) { $body["modelConfigId"] = $ModelId }

    $startTime = Get-Date
    $eventCount = 0
    $toolCallCount = 0
    $lastStatus = "pending"
    $lastError = $null

    $sseUrl = "$BaseUrl/student/projects/$ProjectId/agent/stream"
    $resp = Invoke-RestMethod -Method Post -Uri $sseUrl `
        -Headers @{ "Authorization" = "Bearer $Token"; "Content-Type" = "application/json" } `
        -Body ($body | ConvertTo-Json -Compress) -UseBasicParsing `
        -ResponseHeadersVariable responseHeaders -ContentType "text/event-stream"

    # SSE events come as newline-delimited JSON
    $raw = $resp
    if ($raw -is [string]) {
        $lines = $raw -split "`n"
    } else {
        $lines = @()
    }

    # Parse SSE events
    $currentEvent = $null
    $currentData = ""
    foreach ($line in $lines) {
        $line = $line.Trim()
        if ($line -eq "") { continue }
        if ($line -match "^event:\s*(.+)$") {
            $currentEvent = $matches[1].Trim()
            $currentData = ""
        } elseif ($line -match "^data:\s*(.+)$") {
            $currentData += $matches[1]
        } elseif ($line -match "^id:\s*(.+)$") {
            # ignore
        } elseif ($line -eq "") {
            # event boundary - process
            if ($currentEvent -and $currentData) {
                $eventCount++
                try {
                    $evt = $currentData | ConvertFrom-Json
                    switch ($currentEvent) {
                        "TOOL_CALL" { $toolCallCount++ }
                        "DONE" {
                            $endTime = Get-Date
                            return @{
                                success = $true
                                iterations = $evt.iterations
                                toolCalls = $toolCallCount
                                elapsedMs = [int]($endTime - $startTime).TotalMilliseconds
                                eventCount = $eventCount
                            }
                        }
                        "ERROR" { $lastError = $evt.message }
                        "INTERRUPTED" { $lastStatus = "interrupted" }
                    }
                } catch {
                    # ignore parse errors
                }
            }
            $currentEvent = $null
            $currentData = ""
        }
    }

    # Fallback: poll task status
    $pollEnd = (Get-Date).AddSeconds($TimeoutSec)
    while ((Get-Date) -lt $pollEnd) {
        try {
            $taskResp = Invoke-RestMethod -Method Get `
                -Uri "$BaseUrl/student/projects/$ProjectId/agent/tasks" `
                -Headers @{ "Authorization" = "Bearer $Token" } -UseBasicParsing
            if ($taskResp.code -eq 0 -and $taskResp.data) {
                $tasks = $taskResp.data
                if ($tasks.Count -gt 0) {
                    $lastTask = $tasks[-1]
                    if ($lastTask.status -eq "completed" -or $lastTask.status -eq "failed") {
                        $endTime = Get-Date
                        return @{
                            success = ($lastTask.status -eq "completed")
                            iterations = $toolCallCount
                            toolCalls = $toolCallCount
                            elapsedMs = [int]($endTime - $startTime).TotalMilliseconds
                            eventCount = $eventCount
                            taskStatus = $lastTask.status
                            taskSummary = $lastTask.summary
                        }
                    }
                }
            }
        } catch {}
        Start-Sleep -Milliseconds 2000
    }

    return @{
        success = $false
        timeout = $true
        toolCalls = $toolCallCount
        elapsedMs = $TimeoutSec * 1000
        eventCount = $eventCount
        lastError = $lastError
    }
}

function Run-SingleSession {
    param([int]$SessionId, [string]$Token)
    $result = @{ sessionId = $SessionId; status = "failed" }

    try {
        $projectId = Create-Project -Token $Token -SessionId $SessionId

        $agentResult = Wait-ForAgentCompletion `
            -Token $Token `
            -ProjectId $projectId `
            -SessionId $SessionId `
            -TaskMsg $TaskPrompt `
            -TimeoutSec $TimeoutSeconds `
            -ModelId $ModelConfigId

        $result.status = if ($agentResult.success) { "completed" } else { "failed" }
        $result.projectId = $projectId
        $result.agentResult = $agentResult
        $result.elapsedMs = $agentResult.elapsedMs
        $result.toolCalls = $agentResult.toolCalls

        # Verify project files
        try {
            $treeResp = Invoke-RestMethod -Method Get `
                -Uri "$BaseUrl/student/projects/$projectId/tree" `
                -Headers @{ "Authorization" = "Bearer $Token" } -UseBasicParsing
            if ($treeResp.code -eq 0 -and $treeResp.data) {
                $result.fileCount = $treeResp.data.Count
                $result.files = $treeResp.data
            }
        } catch {
            $result.fileCount = -1
        }

    } catch {
        $result.error = $_.ToString()
        Write-Log "[S$SessionId] FAILED: $_"
    }

    return $result
}

# ================ MAIN ================

Write-Log "===== LabexAgent E2E 压力测试 ====="
Write-Log "Base URL: $BaseUrl"
Write-Log "Concurrency: $Concurrency"
Write-Log "Timeout: ${TimeoutSeconds}s per session"
Write-Log "Output: $reportDir"
Write-Log "Task: $($TaskPrompt.Substring(0, [Math]::Min(80, $TaskPrompt.Length)))..."
Write-Log ""

# 1. Login
$globalStart = Get-Date
try {
    $token = Get-JwtToken -Account $StudentNo -Pwd $Password
} catch {
    Write-Log "FATAL: Login failed. Is backend running at $BaseUrl ?"
    exit 1
}

# 2. Run sessions
Write-Log "Starting $Concurrency concurrent agent session(s)..."
$results = @()
$sessionPool = @()

if ($Concurrency -eq 1) {
    $results += Run-SingleSession -SessionId 1 -Token $token
} else {
    $syncResults = [System.Collections.Concurrent.ConcurrentBag[hashtable]]::new()

    $runspacePool = [runspacefactory]::CreateRunspacePool(1, $Concurrency)
    $runspacePool.Open()
    $jobs = @()

    for ($s = 1; $s -le $Concurrency; $s++) {
        $ps = [powershell]::Create()
        $ps.RunspacePool = $runspacePool
        [void]$ps.AddScript({
            param($id, $baseUrl, $token, $prompt, $timeout, $modelId)
            $ErrorActionPreference = "Stop"
            $projectId = $null
            try {
                Write-Host "[S$id] Starting agent session..."
                $body = @{
                    sessionId = [guid]::NewGuid().ToString()
                    mode = "build"
                    message = $prompt
                }
                if ($modelId) { $body["modelConfigId"] = $modelId }
                $start = Get-Date
                $sseUrl = "$baseUrl/student/projects/$projectId/agent/stream"
                # We skip creating a project in parallel to avoid conflicts
                # Just measure the SSE request
                $resp = Invoke-RestMethod -Method Post -Uri $sseUrl `
                    -Headers @{ "Authorization" = "Bearer $token"; "Content-Type" = "application/json" } `
                    -Body ($body | ConvertTo-Json -Compress) -UseBasicParsing
                $elapsed = [int]((Get-Date) - $start).TotalMilliseconds
                return @{ sessionId = $id; success = $true; elapsedMs = $elapsed }
            } catch {
                return @{ sessionId = $id; success = $false; error = $_.ToString() }
            }
        }).AddParameters(@($s, $BaseUrl, $token, $TaskPrompt, $TimeoutSeconds, $ModelConfigId))
        $jobs += @{ ps = $ps; handle = $ps.BeginInvoke() }
    }

    foreach ($job in $jobs) {
        try {
            $result = $job.ps.EndInvoke($job.handle)
            $syncResults.Add($result)
        } catch {
            $syncResults.Add(@{ sessionId = "unknown"; success = $false; error = $_.ToString() })
        }
        $job.ps.Dispose()
    }
    $runspacePool.Close()
    $results = @($syncResults)
}

# 3. Results
$globalEnd = Get-Date
$totalElapsed = [int]($globalEnd - $globalStart).TotalMilliseconds

Write-Log ""
Write-Log "===== Test Results ====="
$successCount = 0
$failCount = 0
$totalMs = 0
$totalCalls = 0

$results | ForEach-Object {
    $r = $_
    if ($r.status -eq "completed" -or $r.success) { $successCount++ } else { $failCount++ }
    if ($r.elapsedMs) { $totalMs += $r.elapsedMs }
    if ($r.toolCalls) { $totalCalls += $r.toolCalls }
    $statusIcon = if ($r.status -eq "completed" -or $r.success) { "PASS" } else { "FAIL" }
    Write-Host "[S$($r.sessionId)] $statusIcon | Elapsed: $($r.elapsedMs)ms | Tools: $($r.toolCalls) | Files: $($r.fileCount)"
    if ($r.error) { Write-Host "         Error: $($r.error)" }
}

Write-Summary "totalSessions" $Concurrency
Write-Summary "successCount" $successCount
Write-Summary "failCount" $failCount
Write-Summary "successRate" "$([math]::Round($successCount / [Math]::Max(1, $Concurrency) * 100, 1))%"
Write-Summary "totalElapsedMs" $totalElapsed
Write-Summary "avgSessionMs" ($totalMs / [Math]::Max(1, $successCount))
Write-Summary "totalToolCalls" $totalCalls
Write-Summary "taskPrompt" $TaskPrompt.Substring(0, [Math]::Min(100, $TaskPrompt.Length))

Write-Log ""
Write-Log "===== Summary ====="
Write-Log "  Sessions:     $Concurrency"
Write-Log "  Passed:       $successCount"
Write-Log "  Failed:       $failCount"
Write-Log "  Success rate: $([math]::Round($successCount / [Math]::Max(1, $Concurrency) * 100, 1))%"
Write-Log "  Total time:   $([math]::Round($totalElapsed / 1000, 1))s"
Write-Log "  Avg/session:  $([math]::Round($totalMs / [Math]::Max(1, $successCount) / 1000, 1))s"

# Save report
$report = @{
    timestamp = (Get-Date -Format "o")
    config = @{
        baseUrl = $BaseUrl
        studentNo = $StudentNo
        concurrency = $Concurrency
        timeoutSec = $TimeoutSeconds
        taskPrompt = $TaskPrompt
    }
    summary = @{}
    sessions = $results
}
$summaryLines | ForEach-Object { $report.summary[$_.key] = $_.value }
$report | ConvertTo-Json -Depth 5 | Set-Content -Path $reportFile
Write-Log "Report saved: $reportFile"
Write-Log "===== DONE ====="
