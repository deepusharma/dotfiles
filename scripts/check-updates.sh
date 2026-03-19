#!/usr/bin/env bash
# scripts/check-updates.sh
# Checks for outdated packages and reports drift between Brewfile and installed tools.
# Run manually or add to crontab for weekly reminders.
#
# Add to crontab:
#   crontab -e
#   0 9 * * 1 ~/dotfiles/scripts/check-updates.sh >> ~/dotfiles-update.log 2>&1

set -e

YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo ""
echo -e "${BLUE}dotfiles maintenance check — $(date '+%Y-%m-%d')${NC}"
echo "─────────────────────────────────────────────"

# Check for outdated Homebrew packages
echo ""
echo -e "${BLUE}Outdated packages:${NC}"
OUTDATED=$(brew outdated 2>/dev/null)
if [[ -z "$OUTDATED" ]]; then
  echo -e "${GREEN}All packages up to date.${NC}"
else
  echo "$OUTDATED"
  echo ""
  echo "Run 'brew update && brew upgrade' to update."
fi

# Check Brewfile drift — packages installed but not in Brewfile
echo ""
echo -e "${BLUE}Brewfile status:${NC}"
DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
if brew bundle check --file="$DOTFILES/Brewfile" &>/dev/null; then
  echo -e "${GREEN}Brewfile is in sync with installed packages.${NC}"
else
  echo -e "${YELLOW}Brewfile is out of sync. Run:${NC}"
  echo "  brew bundle dump --force --file=$DOTFILES/Brewfile"
  echo "  cd $DOTFILES && git diff Brewfile"
fi

# Check for uncommitted config changes
echo ""
echo -e "${BLUE}Uncommitted config changes:${NC}"
cd "$DOTFILES"
CHANGES=$(git status --porcelain 2>/dev/null)
if [[ -z "$CHANGES" ]]; then
  echo -e "${GREEN}dotfiles repo is clean.${NC}"
else
  echo -e "${YELLOW}Uncommitted changes:${NC}"
  echo "$CHANGES"
  echo ""
  echo "Run 'cd ~/dotfiles && git diff' to review."
fi

echo ""
echo "─────────────────────────────────────────────"
echo "Done."
echo ""
