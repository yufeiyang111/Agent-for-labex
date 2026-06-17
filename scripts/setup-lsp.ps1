param(
  [string]$InstallRoot = "",
  [switch]$SkipNpm,
  [switch]$SkipJava,
  [switch]$Force,
  [switch]$NoUserEnv
)

$ErrorActionPreference = "Stop"

function Info($Message) {
  Write-Host "[Labex LSP] $Message" -ForegroundColor Cyan
}

function Warn($Message) {
  Write-Host "[Labex LSP] $Message" -ForegroundColor Yellow
}

function Fail($Message) {
  Write-Host "[Labex LSP] $Message" -ForegroundColor Red
  exit 1
}

function Require-Command($Name, $InstallHint) {
  $cmd = Get-Command $Name -ErrorAction SilentlyContinue
  if (-not $cmd) {
    Fail "$Name not found. $InstallHint"
  }
  return $cmd.Source
}

function Set-UserEnv($Name, $Value) {
  [Environment]::SetEnvironmentVariable($Name, $Value, "User")
  Set-Item -Path "Env:$Name" -Value $Value
  Info "Set user env $Name=$Value"
}

function Add-UserPath($PathToAdd) {
  if (-not (Test-Path $PathToAdd)) {
    return
  }
  $current = [Environment]::GetEnvironmentVariable("Path", "User")
  $parts = @()
  if ($current) {
    $parts = $current -split ';' | Where-Object { $_ -and $_.Trim() }
  }
  if ($parts -notcontains $PathToAdd) {
    $next = (@($parts) + $PathToAdd) -join ';'
    [Environment]::SetEnvironmentVariable("Path", $next, "User")
    Info "Added to user PATH: $PathToAdd"
  }
  if (($env:Path -split ';') -notcontains $PathToAdd) {
    $env:Path = "$env:Path;$PathToAdd"
  }
}

function Get-EffectiveEnv($Name) {
  $value = [Environment]::GetEnvironmentVariable($Name, "Process")
  if (-not $value) {
    $value = [Environment]::GetEnvironmentVariable($Name, "User")
  }
  return $value
}

function Download-Jdtls($TargetDir) {
  $jdtlsBat = Get-ChildItem -Path $TargetDir -Recurse -Filter "jdtls.bat" -ErrorAction SilentlyContinue | Select-Object -First 1
  if ($jdtlsBat -and -not $Force) {
    Info "JDT LS already installed: $($jdtlsBat.FullName)"
    return $jdtlsBat.FullName
  }

  Require-Command "java" "Install JDK 21+ and rerun this script. Current JDT LS releases require Java 21 to run." | Out-Null
  Require-Command "tar" "Windows 10/11 includes tar.exe. Install it or extract JDT LS manually." | Out-Null

  if (Test-Path $TargetDir) {
    Remove-Item -LiteralPath $TargetDir -Recurse -Force
  }
  New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null

  Info "Fetching latest Eclipse JDT LS snapshot metadata..."
  $headers = @{ "User-Agent" = "LabexAgent-LSP-Setup" }
  $downloadUrl = "https://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz"
  $assetName = "jdt-language-server-latest.tar.gz"
  try {
    $latest = Invoke-RestMethod -Headers $headers -Uri "https://download.eclipse.org/jdtls/snapshots/latest.txt"
    $match = [regex]::Match([string]$latest, "jdt-language-server-[^\s]+?\.tar\.gz")
    if ($match.Success) {
      $assetName = $match.Value
      $downloadUrl = "https://download.eclipse.org/jdtls/snapshots/$assetName"
    }
  } catch {
    Warn "latest.txt unavailable, using jdt-language-server-latest.tar.gz"
  }

  $archive = Join-Path $TargetDir $assetName
  Info "Downloading $assetName..."
  Invoke-WebRequest -Headers $headers -Uri $downloadUrl -OutFile $archive

  Info "Extracting JDT LS..."
  tar -xzf $archive -C $TargetDir
  Remove-Item -LiteralPath $archive -Force

  $jdtlsBat = Get-ChildItem -Path $TargetDir -Recurse -Filter "jdtls.bat" -ErrorAction SilentlyContinue | Select-Object -First 1
  if (-not $jdtlsBat) {
    Fail "JDT LS extracted, but jdtls.bat was not found."
  }
  return $jdtlsBat.FullName
}

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
if (-not $InstallRoot) {
  $InstallRoot = Join-Path $repoRoot ".tools\lsp"
}
$InstallRoot = (New-Item -ItemType Directory -Path $InstallRoot -Force).FullName

Info "Repository: $repoRoot"
Info "Install root: $InstallRoot"

$npmPrefix = ""
if (-not $SkipNpm) {
  Require-Command "node" "Install Node.js 18+ and rerun this script." | Out-Null
  Require-Command "npm" "Install npm and rerun this script." | Out-Null

  Info "Installing TypeScript, Vue and Python language servers via npm..."
  npm install -g typescript typescript-language-server @vue/language-server pyright
  if ($LASTEXITCODE -ne 0) {
    Fail "npm language server installation failed."
  }

  $npmPrefix = (npm config get prefix).Trim()
  Add-UserPath $npmPrefix

  $tsCmd = Join-Path $npmPrefix "typescript-language-server.cmd"
  $vueCmd = Join-Path $npmPrefix "vue-language-server.cmd"
  $pyCmd = Join-Path $npmPrefix "pyright-langserver.cmd"
  foreach ($path in @($tsCmd, $vueCmd, $pyCmd)) {
    if (-not (Test-Path $path)) {
      Fail "Expected language server command not found: $path"
    }
  }

  if (-not $NoUserEnv) {
    Set-UserEnv "LABEX_LSP_TS_CMD" "`"$tsCmd`" --stdio"
    Set-UserEnv "LABEX_LSP_VUE_CMD" "`"$vueCmd`" --stdio"
    Set-UserEnv "LABEX_LSP_PY_CMD" "`"$pyCmd`" --stdio"
  }
}

if (-not $SkipJava) {
  $jdtlsDir = Join-Path $InstallRoot "jdtls"
  $jdtlsBat = Download-Jdtls $jdtlsDir
  if (-not $NoUserEnv) {
    Set-UserEnv "LABEX_LSP_JAVA_CMD" "`"$jdtlsBat`""
  }
}

Info "Verification:"
foreach ($name in @("typescript-language-server", "vue-language-server", "pyright-langserver")) {
  $cmd = Get-Command $name -ErrorAction SilentlyContinue
  if ($cmd) {
    Write-Host "  $name => $($cmd.Source)"
  } else {
    Write-Host "  $name => not found in current PATH" -ForegroundColor Yellow
  }
}
Write-Host "  LABEX_LSP_TS_CMD=$(Get-EffectiveEnv "LABEX_LSP_TS_CMD")"
Write-Host "  LABEX_LSP_VUE_CMD=$(Get-EffectiveEnv "LABEX_LSP_VUE_CMD")"
Write-Host "  LABEX_LSP_PY_CMD=$(Get-EffectiveEnv "LABEX_LSP_PY_CMD")"
Write-Host "  LABEX_LSP_JAVA_CMD=$(Get-EffectiveEnv "LABEX_LSP_JAVA_CMD")"

Info "Done. Restart backend after running this script so Spring can read the updated environment variables."
