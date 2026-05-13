# Public zsh profile.
# Keep secrets, host-specific aliases, and work-only paths in ~/.zshrc.local

export EDITOR=nvim
export VISUAL=nvim
export PATH="$HOME/.local/bin:$HOME/.diversion/bin:$PATH"

setopt AUTO_CD
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
setopt INTERACTIVE_COMMENTS

autoload -Uz compinit
compinit

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

alias v="nvim"
alias y='EDITOR=nvim VISUAL=nvim yazi'
alias ta='tmux attach || tmux new -s main'
alias tl='tmux ls'

yy() {
  local tmp
  tmp="$(mktemp -t yazi-cwd.XXXXXX)" || return
  EDITOR=nvim VISUAL=nvim yazi "$@" --cwd-file="$tmp"

  local cwd
  cwd="$(cat -- "$tmp" 2>/dev/null)"
  rm -f -- "$tmp"

  if [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
}

# iTerm2 shell integration when available on macOS.
if [[ "$TERM_PROGRAM" == "iTerm.app" ]] && [[ -r /Applications/iTerm.app/Contents/Resources/iterm2_shell_integration.zsh ]]; then
  source /Applications/iTerm.app/Contents/Resources/iterm2_shell_integration.zsh
fi

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
