$fixes = @{
    'D:\workfordasan\backend\src\main\java\com\labex\labexagent\service\AgentConversationService.java' = @(
        @{ old = '(Object)conversation'; new = 'conversation' },
        @{ old = '(Object)conversationId'; new = 'conversationId' },
        @{ old = '(Object)studentId'; new = 'studentId' },
        @{ old = '(Object)projectId'; new = 'projectId' },
        @{ old = '(Object)1'; new = '1' },
        @{ old = '(Object)0'; new = '0' },
        @{ old = '(Object)LocalDateTime.now()'; new = 'LocalDateTime.now()' }
    )
}
foreach ($file in $fixes.Keys) {
    $c = Get-Content $file -Raw -Encoding UTF8
    foreach ($r in $fixes[$file]) {
        $c = $c.Replace($r.old, $r.new)
    }
    [System.IO.File]::WriteAllText($file, $c, [System.Text.UTF8Encoding]::new($false))
    Write-Host "Fixed: $(Split-Path $file -Leaf)"
}
