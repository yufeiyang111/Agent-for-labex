$root = 'D:\workfordasan\backend\src\main\java'
$count = 0
Get-ChildItem -Path $root -Recurse -Filter *.java | ForEach-Object {
    $c = Get-Content $_.FullName -Raw -Encoding UTF8
    $changed = $false
    # Remove CFR decompiler casts that break type inference
    # Pattern: (Wrapper)((LambdaQueryWrapper)((LambdaQueryWrapper)new LambdaQueryWrapper()...
    if ($c -match '\(Wrapper\)\s*\(\s*\(Lambda(Query|Update)Wrapper\)') {
        $c = $c -replace '\(Wrapper\)\s*',''
        $c = $c -replace '\(LambdaQueryWrapper\)\s*',''
        $c = $c -replace '\(LambdaUpdateWrapper\)\s*',''
        $c = $c -replace '\(Object\)\s*',''
        $changed = $true
    }
    # Remove (Object) casts in method arguments  
    if ($c -match '\(Object\)') {
        $c = $c -replace '\(Object\)',''
        $changed = $true
    }
    if ($changed) {
        [System.IO.File]::WriteAllText($_.FullName, $c, [System.Text.UTF8Encoding]::new($false))
        $count++
        Write-Host ('Cleaned: '+$_.Name)
    }
}
Write-Host ('Total cleaned: '+$count)
