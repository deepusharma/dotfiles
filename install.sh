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

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
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
  ln -sf "$src" "$dest"
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
if ! nvm ls --no-colors | grep -q "lts"; then
  log "Installing Node.js LTS..."
  nvm install --lts
  ok "Node.js LTS installed"
else
  ok "Node.js LTS already installed"
fi

# ── Symlink configs ───────────────────────────────────────────────────────────
log "Symlinking config files..."

symlink "$DOTFILES/configs/zsh/.zshrc"                    "$HOME/.zshrc"
symlink "$DOTFILES/configs/starship/starship.toml"        "$HOME/.config/starship.toml"
symlink "$DOTFILES/configs/zellij/config.kdl"             "$HOME/.config/zellij/config.kdl"
symlink "$DOTFILES/configs/zellij/layouts/dev.kdl"        "$HOME/.config/zellij/layouts/dev.kdl"

if [[ "$OS" == "mac" ]]; then
  symlink "$DOTFILES/configs/ghostty/config"          "$HOME/.config/ghostty/config"
fi

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
