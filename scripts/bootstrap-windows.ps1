$ErrorActionPreference = "Stop"

Write-Host "[dotfiles] Windows host bootstrap" -ForegroundColor Cyan

$winget = Get-Command winget -ErrorAction SilentlyContinue
if (-not $winget) {
  Write-Host "winget is required for the default bootstrap path." -ForegroundColor Yellow
  Write-Host "Install App Installer from Microsoft Store, then rerun."
  exit 1
}

Write-Host "Installing host-side tools..." -ForegroundColor Cyan
winget install --id wez.wezterm --exact --accept-package-agreements --accept-source-agreements
winget install --id Microsoft.WindowsTerminal --exact --accept-package-agreements --accept-source-agreements
winget install --id Tailscale.Tailscale --exact --accept-package-agreements --accept-source-agreements

Write-Host ""
Write-Host "WSL2 is the recommended target environment for shell/editor tooling." -ForegroundColor Cyan
Write-Host "If WSL is not installed yet, run these manually in an elevated shell:" -ForegroundColor Yellow
Write-Host "  wsl --install"
Write-Host "  wsl --install -d Ubuntu"
Write-Host ""
Write-Host "Then clone this repo inside WSL and run scripts/bootstrap-wsl.sh"
