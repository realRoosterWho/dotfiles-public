# dotfiles-public

Public-facing dotfiles for a terminal-first workflow built around:

- `LazyVim`
- `tmux`
- `zsh`
- `yazi`
- `WezTerm` on Windows
- `WSL2 Ubuntu` as the preferred Windows shell environment

This repo is designed to be readable by both humans and Codex. The goal is simple:

- clone it on a new machine
- let Codex read this repo
- finish the machine-specific setup with minimal extra instruction

## Philosophy

The portable stack lives in the shell/editor layer, not in the host terminal app.

- On macOS: use `iTerm2` or another terminal
- On Windows: use `WezTerm` or `Windows Terminal`
- On Windows for real work: use `WSL2` for `zsh`, `tmux`, `nvim`, and `yazi`

That keeps the working environment as close as possible across macOS, Linux, and Windows.

## Repository Layout

This repo uses a `stow`-friendly layout:

```text
dotfiles-public/
  git/.gitconfig
  nvim/.config/nvim
  powershell/Documents/PowerShell/Microsoft.PowerShell_profile.ps1
  tmux/.tmux.conf
  wezterm/.wezterm.lua
  yazi/.config/yazi
  zsh/.zshrc
  scripts/bootstrap-mac.sh
  scripts/bootstrap-windows.ps1
  scripts/bootstrap-windows-native.ps1
  scripts/bootstrap-wsl.sh
```

## What Is Safe To Publish

This repo is meant to hold:

- editor and shell behavior
- tmux workflow
- file manager theming and bindings
- bootstrap scripts
- public-safe git settings

It must not hold:

- SSH private keys
- `known_hosts`
- tokens or API keys
- private host aliases
- company or school secrets
- machine-specific local overrides

## Local Override Strategy

Keep local-only config outside git:

- `~/.zshrc.local`
- `~/.gitconfig.local`
- `~/.ssh/config`

The public configs in this repo are written to tolerate those files being absent.

## Quick Start

### macOS / Linux

Install `stow`, clone this repo, then:

```sh
stow -t ~ git nvim tmux yazi zsh
```

If you use WezTerm on that machine too:

```sh
stow -t ~ wezterm
```

### Windows

Recommended path:

1. install `WSL2`
2. install an Ubuntu distribution
3. install `WezTerm`
4. run `scripts/bootstrap-windows.ps1`
5. open WSL and run `scripts/bootstrap-wsl.sh`
6. inside WSL, `stow git nvim tmux yazi zsh`

### Windows Native

If you want to stay in native Windows instead of WSL:

1. clone this repo on Windows
2. run `scripts/bootstrap-windows-native.ps1`
3. use `WezTerm` or `Windows Terminal`
4. work with `PowerShell + Neovim + Yazi`

This route intentionally does not try to force:

- `zsh`
- `tmux`

Those are better handled in WSL. The native route is optimized for:

- fast setup
- good SSH workflow
- good enough editor and file manager ergonomics
- minimal Unix-emulation friction

## Notes For Codex

If Codex is helping bootstrap a new machine, prefer this flow:

1. read this `README.md`
2. detect host OS
3. on Windows, choose between:
   - `WSL2` for the full Unix-like workflow
   - `Windows Native` for faster setup with `PowerShell + Neovim + Yazi`
4. install package prerequisites
5. on macOS/Linux/WSL, use `stow -t ~`
6. on Windows Native, use `scripts/bootstrap-windows-native.ps1`
7. keep secrets and host-specific details in local override files

## Current Style Decisions

- `LazyVim` stays close to upstream starter, with small focused overrides
- `blink.cmp` keeps manual-friendly completion behavior in writing-oriented buffers
- `tmux` keeps mouse support, vi copy mode, and fast pane navigation
- `yazi` is configured as a keyboard-first file browser with Git helpers
- `zsh` keeps a small public baseline and expects private overrides elsewhere
- `PowerShell` gets a native profile for the Windows-only route

## Migration Status

Already migrated into this repo:

- `nvim`: actual public-safe starter-based config
- `yazi`: actual config, theme, and plugin setup
- `tmux`: public-safe version based on the current local workflow
- `powershell`: native Windows shell profile for the non-WSL route
- `zsh`: public-safe version preserving editor/yazi/tmux ergonomics
- `wezterm`: portable Windows-first terminal baseline

## Publishing

This repo is intended to be public after one last manual review:

- skim for private paths
- skim for internal hostnames
- skim for secrets

Then push it to GitHub and use it as the source of truth for future machines.
