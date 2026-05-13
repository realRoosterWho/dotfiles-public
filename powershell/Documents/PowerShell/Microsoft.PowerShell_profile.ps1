$ErrorActionPreference = "Continue"

function Test-Command($Name) {
  return [bool](Get-Command $Name -ErrorAction SilentlyContinue)
}

$env:EDITOR = "nvim"
$env:VISUAL = "nvim"

if (Test-Command "fzf") {
  Set-PSReadLineKeyHandler -Key Tab -Function Complete
}

if (Test-Command "zoxide") {
  Invoke-Expression (& { (zoxide init powershell | Out-String) })
}

function y {
  yazi $args
}

function yy {
  $tmp = New-TemporaryFile
  try {
    yazi @args --cwd-file "$($tmp.FullName)"
    if (Test-Path $tmp.FullName) {
      $cwd = Get-Content $tmp.FullName -ErrorAction SilentlyContinue
      if ($cwd -and (Test-Path $cwd)) {
        Set-Location $cwd
      }
    }
  }
  finally {
    Remove-Item $tmp.FullName -ErrorAction SilentlyContinue
  }
}

function ll {
  Get-ChildItem -Force
}

function grep {
  rg @args
}

function v {
  nvim @args
}

Set-Alias vim nvim

Write-Host "PowerShell profile loaded: nvim + yazi + zoxide" -ForegroundColor DarkGray
