$ErrorActionPreference = "Stop"

$RepoDir = if ($env:REPO_DIR) { $env:REPO_DIR } else { (Resolve-Path (Join-Path $PSScriptRoot "..")).Path }
$UserHome = $env:USERPROFILE
$LocalAppData = $env:LOCALAPPDATA
$DocumentsDir = [Environment]::GetFolderPath("MyDocuments")

Write-Host "[dotfiles] Windows native bootstrap" -ForegroundColor Cyan
Write-Host "Repo: $RepoDir" -ForegroundColor DarkGray

$winget = Get-Command winget -ErrorAction SilentlyContinue
if (-not $winget) {
  Write-Host "winget is required for the native bootstrap path." -ForegroundColor Yellow
  exit 1
}

$packages = @(
  "wez.wezterm",
  "Microsoft.WindowsTerminal",
  "Neovim.Neovim",
  "Git.Git",
  "BurntSushi.ripgrep.MSVC",
  "sharkdp.fd",
  "junegunn.fzf",
  "ajeetdsouza.zoxide",
  "sxyazi.yazi",
  "Tailscale.Tailscale"
)

foreach ($pkg in $packages) {
  winget install --id $pkg --exact --accept-package-agreements --accept-source-agreements --silent
}

$NvimTarget = Join-Path $LocalAppData "nvim"
$YaziTarget = Join-Path $LocalAppData "yazi"
$PsTargetDir = Join-Path $DocumentsDir "PowerShell"
$PsTarget = Join-Path $PsTargetDir "Microsoft.PowerShell_profile.ps1"
$WeztermTarget = Join-Path $UserHome ".wezterm.lua"

New-Item -ItemType Directory -Force $LocalAppData | Out-Null
New-Item -ItemType Directory -Force $PsTargetDir | Out-Null

if (Test-Path $NvimTarget) { Remove-Item $NvimTarget -Recurse -Force }
if (Test-Path $YaziTarget) { Remove-Item $YaziTarget -Recurse -Force }

Copy-Item -Path (Join-Path $RepoDir "nvim\.config\nvim") -Destination $NvimTarget -Recurse -Force
Copy-Item -Path (Join-Path $RepoDir "yazi\.config\yazi") -Destination $YaziTarget -Recurse -Force
Copy-Item -Path (Join-Path $RepoDir "powershell\Documents\PowerShell\Microsoft.PowerShell_profile.ps1") -Destination $PsTarget -Force
Copy-Item -Path (Join-Path $RepoDir "wezterm\.wezterm.lua") -Destination $WeztermTarget -Force

Write-Host ""
Write-Host "Installed native Windows config:" -ForegroundColor Cyan
Write-Host "  Neovim config -> $NvimTarget"
Write-Host "  Yazi config   -> $YaziTarget"
Write-Host "  PowerShell     -> $PsTarget"
Write-Host "  WezTerm        -> $WeztermTarget"
Write-Host ""
Write-Host "Skipped on purpose in Windows Native:" -ForegroundColor Yellow
Write-Host "  tmux"
Write-Host "  zsh"
Write-Host ""
Write-Host "Open a new terminal and start working with:"
Write-Host "  nvim"
Write-Host "  y"
Write-Host "  yy"
