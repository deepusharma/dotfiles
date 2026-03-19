# =============================================================================
# .zshrc — Zsh configuration
# Part of: github.com/YOURUSERNAME/dotfiles
# =============================================================================

# ── Oh My Zsh ─────────────────────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""  # disabled — Starship handles the prompt

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  z
)

source $ZSH/oh-my-zsh.sh

# ── Homebrew (Linux/WSL2) ─────────────────────────────────────────────────────
if [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# ── Starship prompt ───────────────────────────────────────────────────────────
eval "$(starship init zsh)"

# ── zoxide (smart cd) ─────────────────────────────────────────────────────────
eval "$(zoxide init zsh)"

# ── fzf ───────────────────────────────────────────────────────────────────────
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --inline-info'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# ── File listing (eza replaces ls) ────────────────────────────────────────────
alias ls='eza --icons'
alias ll='eza --long --icons --git'
alias lt='eza --tree --level=2 --icons'
alias lta='eza --tree --level=3 --icons'
alias la='eza --long --all --icons --git'

# ── File viewing (bat replaces cat) ───────────────────────────────────────────
alias cat='bat'
export BAT_THEME="Dracula"

# ── Navigation ────────────────────────────────────────────────────────────────
alias cd='z'       # zoxide handles this
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ── Git ───────────────────────────────────────────────────────────────────────
alias lg='lazygit'
alias gs='git status'
alias gp='git push'
alias gpl='git pull'
alias gco='git checkout'
alias gcb='git checkout -b'
alias glog='git log --oneline --graph --decorate'

# ── Python ────────────────────────────────────────────────────────────────────
alias python='python3'
alias pip='uv pip'
alias venv='uv venv'
alias activate='source .venv/bin/activate'

# ── Cloud CLIs ────────────────────────────────────────────────────────────────
# Uncomment whichever you use:
# source /usr/local/share/google-cloud-sdk/path.zsh.inc
# source /usr/local/share/google-cloud-sdk/completion.zsh.inc

# ── Utilities ─────────────────────────────────────────────────────────────────
alias reload='source ~/.zshrc'
alias path='echo $PATH | tr ":" "\n"'
alias ports='lsof -i -P -n | grep LISTEN'

# delta — better git diffs (set as default git pager)
export GIT_PAGER='delta'

# direnv — auto-load .envrc files per project
eval "$(direnv hook zsh)"

# Better history
export HISTSIZE=50000
export HISTFILESIZE=50000
export HISTCONTROL=ignoredups:erasedups
setopt SHARE_HISTORY
setopt HIST_FIND_NO_DUPS

# ── Zellij auto-start ─────────────────────────────────────────────────────────
# Opens Zellij automatically when you open a new terminal.
# Comment this out if you prefer to launch Zellij manually.
if [[ -z "$ZELLIJ" ]]; then
  zellij
fi
