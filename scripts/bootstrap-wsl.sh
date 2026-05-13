#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${REPO_DIR:-$HOME/dotfiles-public}"

echo "[dotfiles] WSL bootstrap"

sudo apt update
sudo apt install -y git zsh tmux neovim yazi stow ripgrep fd-find fzf curl unzip

if ! command -v fd >/dev/null 2>&1 && command -v fdfind >/dev/null 2>&1; then
  mkdir -p "$HOME/.local/bin"
  ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"
fi

if [ ! -d "$REPO_DIR" ]; then
  echo "Repo not found at $REPO_DIR"
  echo "Clone it first, or set REPO_DIR=/path/to/repo"
  exit 1
fi

cd "$REPO_DIR"
stow git nvim tmux yazi zsh

if command -v chsh >/dev/null 2>&1; then
  chsh -s "$(command -v zsh)" || true
fi

echo
echo "WSL bootstrap finished."
echo "Open a new shell, then run: tmux"
