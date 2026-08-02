#!/usr/bin/env bash
# install.sh
# Sets up the full terminal environment on macOS or Windows (WSL2).
# Safe to re-run — symlinks are overwritten, existing files are backed up.
#
# Usage:
#   git clone git@github.com:YOURUSERNAME/dotfiles.git ~/dotfiles
#   cd ~/dotfiles && ./install.sh

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

log()     { echo -e "${BLUE}-->${NC} $1"; }
ok()      { echo -e "${GREEN}ok${NC}  $1"; }
warn()    { echo -e "${YELLOW}!${NC}   $1"; }

usage() {
  cat <<'EOF'
install.sh — bootstrap a new macOS or Windows (WSL2) machine

Usage:
  ./install.sh          Show this help (default — does NOT install anything)
  ./install.sh run      Run the full bootstrap (idempotent, safe to re-run)

What `run` does:
  - Installs Homebrew if missing, then all Brewfile packages
  - Installs Oh My Zsh + plugins, nvm + Node.js LTS, fzf integration
  - Symlinks all configs into place (shell, git, prompt, VS Code, skills)
  - Creates ~/.secrets from configs/zsh/.secrets.example if missing
  - Backs up any real file it would overwrite

See also: ./scripts/dotfiles.sh — help | install | sync | audit
EOF
}

case "${1:-}" in
  run) ;;  # continue into the bootstrap below
  ""|-h|--help) usage; exit 0 ;;
  *) echo "Unknown argument: $1"; echo; usage; exit 1 ;;
esac

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKUP="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

# Detect OS
OS="unknown"
[[ "$OSTYPE" == "darwin"* ]]    && OS="mac"
[[ "$OSTYPE" == "linux-gnu"* ]] && OS="linux"
log "OS: $OS"

# Symlink helper — backs up existing files, creates link
symlink() {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [[ -e "$dest" && ! -L "$dest" ]]; then
    mkdir -p "$BACKUP"
    warn "Backing up $dest"
    mv "$dest" "$BACKUP/"
  fi
  # Remove an existing link first — `ln -sf` onto a symlinked directory would
  # create the new link *inside* the target instead of replacing the link
  [[ -L "$dest" ]] && rm "$dest"
  ln -s "$src" "$dest"
  ok "Linked $(basename "$src")"
}

# ── Homebrew ──────────────────────────────────────────────────────────────────
log "Checking Homebrew..."
if ! command -v brew &>/dev/null; then
  log "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [[ "$OS" == "linux" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
else
  ok "Homebrew found"
fi

# ── Zsh (Linux/WSL2 only) ─────────────────────────────────────────────────────
if [[ "$OS" == "linux" ]]; then
  log "Checking Zsh..."
  if ! command -v zsh &>/dev/null; then
    sudo apt-get update -qq && sudo apt-get install -y -qq zsh
  fi
  if [[ "$SHELL" != "$(which zsh)" ]]; then
    chsh -s "$(which zsh)"
    warn "Default shell changed to Zsh — takes effect on next login"
  else
    ok "Zsh is default shell"
  fi
fi

# ── Packages via Brewfile ─────────────────────────────────────────────────────
log "Installing packages from Brewfile..."
if [[ "$OS" == "linux" ]]; then
  # Skip casks on Linux — not supported
  grep -v '^cask' "$DOTFILES/Brewfile" | brew bundle --file=/dev/stdin
else
  brew bundle --file="$DOTFILES/Brewfile"
fi
ok "Packages installed"

# ── fzf shell integration ─────────────────────────────────────────────────────
log "Setting up fzf shell integration..."
"$(brew --prefix)/opt/fzf/install" --all --no-update-rc --no-bash --no-fish 2>/dev/null || true
ok "fzf ready"

# ── Oh My Zsh ─────────────────────────────────────────────────────────────────
log "Checking Oh My Zsh..."
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  RUNZSH=no CHSH=no sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  ok "Oh My Zsh already installed"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
  git clone --quiet https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
  ok "zsh-syntax-highlighting installed"
fi

if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
  git clone --quiet https://github.com/zsh-users/zsh-autosuggestions.git \
    "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
  ok "zsh-autosuggestions installed"
fi

# ── nvm (Node Version Manager) ────────────────────────────────────────────────
log "Checking nvm..."
if [[ ! -d "$HOME/.nvm" ]]; then
  log "Installing nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
  ok "nvm installed"
else
  ok "nvm already installed"
fi

# Load nvm and install LTS Node if not already installed
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# `nvm ls` always prints lts/* alias lines even with nothing installed, so
# grepping it never triggers an install. `nvm version` resolves the alias
# against installed versions only ("N/A" when absent).
NODE_LTS="$(nvm version lts/\* 2>/dev/null || true)"
if [[ -z "$NODE_LTS" || "$NODE_LTS" == "N/A" ]]; then
  log "Installing Node.js LTS..."
  nvm install --lts
  ok "Node.js LTS installed"
else
  ok "Node.js LTS already installed ($NODE_LTS)"
fi

# ── Symlink configs ───────────────────────────────────────────────────────────
log "Symlinking config files..."

symlink "$DOTFILES/configs/zsh/.zshrc"                    "$HOME/.zshrc"
symlink "$DOTFILES/configs/starship/starship.toml"        "$HOME/.config/starship.toml"
symlink "$DOTFILES/configs/zellij/config.kdl"             "$HOME/.config/zellij/config.kdl"
symlink "$DOTFILES/configs/zellij/layouts/dev.kdl"        "$HOME/.config/zellij/layouts/dev.kdl"
# ── Git config ────────────────────────────────────────────────────────────────
symlink "$DOTFILES/configs/git/.gitconfig"                "$HOME/.gitconfig"
if [[ ! -f "$HOME/.gitconfig.local" ]]; then
  warn "~/.gitconfig.local not found — copy configs/git/.gitconfig.local.example and fill in your details"
fi

# ── Secrets template ──────────────────────────────────────────────────────────
# Copied (not symlinked) so real keys never live inside the repo working tree.
if [[ ! -f "$HOME/.secrets" ]]; then
  cp "$DOTFILES/configs/zsh/.secrets.example" "$HOME/.secrets"
  chmod 600 "$HOME/.secrets"
  warn "Created ~/.secrets from template — add your API keys there"
fi



if [[ "$OS" == "mac" ]]; then
  symlink "$DOTFILES/configs/ghostty/config"          "$HOME/.config/ghostty/config"
fi

# ── VS Code-family editors ──────────────────────────────────────────────────
# Each editor's settings.json is generated by scripts/sync-editor-settings.sh
# from configs/editors/common.json + configs/<editor>/overrides.json — run
# that script (or `./scripts/dotfiles.sh sync-editors`) after editing either.
# Windsurf and Devin are the same product (Cognition acquired Windsurf) and
# intentionally share one generated file (configs/windsurf/settings.json).
#
# App-folder names below are the macOS ones, confirmed on this machine.
# The Windows/WSL side (AppData\Roaming\<App>\User\settings.json) follows
# the same convention as VS Code's own long-standing Windows path, but
# hasn't been verified against an actual Windows install of each app —
# if a folder name differs there, fix the path below and re-run.
log "Symlinking VS Code-family editor settings..."
if [[ "$OS" == "mac" ]]; then
  symlink "$DOTFILES/configs/vscode/settings.json" \
    "$HOME/Library/Application Support/Code/User/settings.json"
  symlink "$DOTFILES/configs/antigravity/settings.json" \
    "$HOME/Library/Application Support/Antigravity IDE/User/settings.json"
  symlink "$DOTFILES/configs/cursor/settings.json" \
    "$HOME/Library/Application Support/Cursor/User/settings.json"
  symlink "$DOTFILES/configs/kiro/settings.json" \
    "$HOME/Library/Application Support/Kiro/User/settings.json"
  symlink "$DOTFILES/configs/windsurf/settings.json" \
    "$HOME/Library/Application Support/Windsurf/User/settings.json"
  symlink "$DOTFILES/configs/windsurf/settings.json" \
    "$HOME/Library/Application Support/Devin/User/settings.json"
elif [[ "$OS" == "linux" ]]; then
  WIN_USER=$(cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r')
  WIN_APPDATA="/mnt/c/Users/$WIN_USER/AppData/Roaming"
  symlink "$DOTFILES/configs/vscode/settings.json" \
    "$WIN_APPDATA/Code/User/settings.json"
  symlink "$DOTFILES/configs/antigravity/settings.json" \
    "$WIN_APPDATA/Antigravity IDE/User/settings.json"
  symlink "$DOTFILES/configs/cursor/settings.json" \
    "$WIN_APPDATA/Cursor/User/settings.json"
  symlink "$DOTFILES/configs/kiro/settings.json" \
    "$WIN_APPDATA/Kiro/User/settings.json"
  symlink "$DOTFILES/configs/windsurf/settings.json" \
    "$WIN_APPDATA/Windsurf/User/settings.json"
  symlink "$DOTFILES/configs/windsurf/settings.json" \
    "$WIN_APPDATA/Devin/User/settings.json"
fi

# ── Antigravity skills ────────────────────────────────────────────────────────
log "Symlinking Antigravity skills..."
mkdir -p "$HOME/.antigravity"
symlink "$DOTFILES/configs/antigravity/skills" "$HOME/.antigravity/skills"

# ── Kiro CLI ──────────────────────────────────────────────────────────────────
# Same ~/.kiro path on Mac and WSL2 (a CLI tool, not a native Windows app —
# no AppData path involved). Currently empty on both sides; wired now so any
# future custom agent/steering config is shared, not lost per-machine.
log "Symlinking Kiro CLI config..."
mkdir -p "$HOME/.kiro"
symlink "$DOTFILES/configs/kiro-cli/agents" "$HOME/.kiro/agents"
symlink "$DOTFILES/configs/kiro-cli/steering" "$HOME/.kiro/steering"

# ── Done ──────────────────────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}Setup complete.${NC}"
echo ""
echo "  Next steps:"
echo "  1. Restart your terminal (or run: exec zsh)"
echo "  2. Run 'gh auth login' to connect GitHub CLI"
echo "  3. Open a git repo and run 'lg' to try lazygit"
if [[ "$OS" == "linux" ]]; then
  echo ""
  echo "  Windows manual steps still required:"
  echo "  - Install Alacritty .msi from github.com/alacritty/alacritty/releases"
  echo "  - Copy configs/alacritty/alacritty.toml to %APPDATA%\alacritty\alacritty.toml"
  echo "  - Install JetBrainsMono Nerd Font (see README)"
fi
echo ""
[[ -d "$BACKUP" ]] && warn "Backed up existing configs to: $BACKUP"
