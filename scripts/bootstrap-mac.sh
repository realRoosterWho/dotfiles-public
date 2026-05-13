#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${REPO_DIR:-$HOME/dotfiles-public}"

echo "[dotfiles] macOS bootstrap"

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is required: https://brew.sh"
  exit 1
fi

brew install git neovim tmux yazi zoxide stow ripgrep fd fzf || true

if [ ! -d "$REPO_DIR" ]; then
  echo "Repo not found at $REPO_DIR"
  echo "Clone it first, or set REPO_DIR=/path/to/repo"
  exit 1
fi

cd "$REPO_DIR"
stow git nvim tmux yazi zsh || true

echo
echo "Linked packages with stow."
echo "Optional next step: stow wezterm"
