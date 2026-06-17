# LabexAgent Real LSP Setup

LabexAgent uses real language servers for diagnostics and symbol operations. It does not use static parser fallback for `diagnostics`, `lsp_symbols`, or `lsp`.

## One-Click Setup On Windows

Run from the repository root:

```powershell
scripts\setup-lsp.cmd
```

Or run the PowerShell script directly:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts\setup-lsp.ps1
```

The script installs and configures:

- TypeScript / JavaScript: `typescript-language-server --stdio`
- Vue: `vue-language-server --stdio`
- Python: `pyright-langserver --stdio`
- Java: Eclipse JDT LS, installed under `.tools\lsp\jdtls`

It also writes user environment variables used by Spring Boot:

- `LABEX_LSP_TS_CMD`
- `LABEX_LSP_VUE_CMD`
- `LABEX_LSP_PY_CMD`
- `LABEX_LSP_JAVA_CMD`

Restart the backend after running the script.

## Prerequisites

- Node.js 18+ and npm
- JDK 21+ for Eclipse JDT LS runtime
- Windows `tar.exe` available on PATH
- Internet access for npm packages and Eclipse JDT LS download

## Verify

Use PowerShell:

```powershell
Get-Command typescript-language-server
Get-Command vue-language-server
Get-Command pyright-langserver
[Environment]::GetEnvironmentVariable("LABEX_LSP_TS_CMD", "User")
[Environment]::GetEnvironmentVariable("LABEX_LSP_VUE_CMD", "User")
[Environment]::GetEnvironmentVariable("LABEX_LSP_PY_CMD", "User")
[Environment]::GetEnvironmentVariable("LABEX_LSP_JAVA_CMD", "User")
```

In PowerShell, `where` is not the same as `where.exe`. If you want the Windows executable lookup, use:

```powershell
where.exe typescript-language-server
where.exe vue-language-server
where.exe pyright-langserver
```

## Backend Configuration

`backend/src/main/resources/application.yml` reads these environment variables:

```yaml
labex-agent:
  lsp:
    commands:
      java: ${LABEX_LSP_JAVA_CMD:jdtls}
      typescript: ${LABEX_LSP_TS_CMD:typescript-language-server --stdio}
      vue: ${LABEX_LSP_VUE_CMD:vue-language-server --stdio}
      python: ${LABEX_LSP_PY_CMD:pyright-langserver --stdio}
```

If a language server is unavailable, LabexAgent fails the LSP tool call and post-edit hook explicitly. That is expected behavior: install or fix the real server instead of relying on fallback parsing.

For Java projects, LabexAgent automatically starts JDT LS with a per-project workspace under `.labexagent\jdtls-workspace`.

## Useful Options

```powershell
# Reinstall JDT LS even if it exists
scripts\setup-lsp.cmd -Force

# Configure npm language servers only
scripts\setup-lsp.cmd -SkipJava

# Configure Java language server only
scripts\setup-lsp.cmd -SkipNpm
```
