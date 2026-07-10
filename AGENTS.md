# AGENTS.md — AI Agent Instructions

This file provides context and rules for AI coding agents (Claude Code,
Antigravity, Gemini, Copilot, etc.) working in this repository.
`CLAUDE.md` is a small pointer file that imports this one via `@AGENTS.md` —
edit AGENTS.md, never CLAUDE.md.

---

## What this repo is

A personal dotfiles repo — version-controlled shell configs, tool configs,
and an install script that bootstraps a new macOS or Windows (WSL2) machine
from zero to fully configured in one command.

**Primary owner:** Deepak Sharma (`deepu.sharma@gmail.com`)\
**GitHub handle:** `deepusharma`\
**Platforms:** macOS (primary), Windows WSL2 (secondary)\
**Current focus:** agentic AI development, Python, TypeScript/JavaScript/React

---

## Common commands

```bash
# Lint all Markdown files (run before committing)
markdownlint '**/*.md'

# Verify Brewfile is in sync with installed packages
brew bundle check --file=Brewfile

# Full maintenance check (outdated packages, Brewfile drift, uncommitted changes)
./scripts/check-updates.sh

# Drift audit: symlinks, packages, VS Code extensions, secrets, repo state
./scripts/dotfiles.sh audit
```

There is no build step, test suite, or compilation. Changes to `configs/` take
effect immediately on next shell reload (`exec zsh`) or tool restart.

---

## Repo structure

```text
dotfiles/
├── AGENTS.md               # AI agent instructions (this file — single source)
├── CLAUDE.md               # pointer file: imports AGENTS.md via @AGENTS.md
├── README.md               # overview + machine setup guide (right-level only)
├── CHEATSHEET.md           # THE command reference for all CLI tools
├── QUICK-REF.md            # one-glance card, links into docs/*.md
├── Brewfile                # all Homebrew packages
├── install.sh              # forwarder → scripts/install.sh (kept for clone-and-run UX)
├── .markdownlint.json      # markdown linting rules
├── .gitignore
├── configs/
│   ├── cli-tools.txt       # AI/dev CLI manifest checked by dotfiles.sh audit
│   ├── alacritty/          # Alacritty terminal config (Windows/WSL2)
│   ├── antigravity/
│   │   └── skills/         # global AI agent skills (symlinked to ~/.antigravity/skills)
│   ├── ghostty/            # Ghostty terminal config (macOS) — file is `config`, no extension
│   ├── git/
│   │   ├── .gitconfig      # global git config (symlinked to ~/.gitconfig)
│   │   └── .gitconfig.local.example
│   ├── starship/
│   │   └── starship.toml   # prompt config (symlinked to ~/.config/starship.toml)
│   ├── vscode/
│   │   ├── settings.json   # user settings shared by VS Code AND Antigravity (live symlink!)
│   │   └── extensions.txt  # extension manifest checked by dotfiles.sh audit
│   ├── zellij/             # Zellij multiplexer config + layouts
│   └── zsh/
│       ├── .zshrc          # Zsh shell config (symlinked to ~/.zshrc)
│       └── .secrets.example  # template — install.sh copies it to ~/.secrets
├── docs/
│   ├── editor.md           # per-topic references (linked from QUICK-REF)
│   ├── git.md
│   ├── markdown.md
│   ├── node.md
│   ├── python.md
│   ├── terminal.md
│   └── dev-setup/          # extensions audit, Python/Node setup, plugin configs
├── scripts/
│   ├── agents-welcome.sh   # AI-agents banner shown on new interactive shells
│   ├── check-updates.sh    # weekly update checker (standalone / cron — NOT run by install.sh)
│   ├── dotfiles.sh         # manager: help | install | sync | audit
│   └── install.sh          # the real bootstrap script (root install.sh forwards here)
└── images/                 # diagrams used in README.md
```

---

## Documentation roles (keep these distinct)

| File | Role | What does NOT belong there |
| --- | --- | --- |
| `README.md` | Overview, install steps, machine sync workflow | Per-tool command lists |
| `CHEATSHEET.md` | Single full command reference for every CLI tool | Setup instructions |
| `QUICK-REF.md` | One-glance card; links to `docs/*.md` for depth | Long explanations |
| `docs/*.md` | Per-topic deep dives (git, python, node, …) | Duplicating CHEATSHEET verbatim |

When documenting a tool, put commands in CHEATSHEET.md and only link from
elsewhere. Do not re-document the same tool in multiple files.

---

## How the symlink system works

`install.sh` creates symlinks from where tools expect configs to where this
repo stores them. For example:

- `~/.gitconfig` → `<repo>/configs/git/.gitconfig`
- `~/.config/starship.toml` → `<repo>/configs/starship/starship.toml`
- `~/.zshrc` → `<repo>/configs/zsh/.zshrc`
- `~/Library/Application Support/Code/User/settings.json` → `<repo>/configs/vscode/settings.json`

The repo does not have to live at `~/dotfiles` — `.zshrc` resolves the repo
location from the `~/.zshrc` symlink at runtime.

**Consequences for agents:**

- Editing a file in `configs/` edits the live config. No build or deploy step.
- The reverse is also true: **running tools write into this repo.** VS Code,
  Antigravity, and extensions (notably the Pleiades Java pack) write directly
  into `configs/vscode/settings.json` while they run. Unstaged changes the
  user didn't make are expected — do not treat them as corruption, and re-read
  the file before rewriting it wholesale.
- `~/.secrets` is a **copy** of `configs/zsh/.secrets.example`, never a
  symlink — real keys must never live inside the repo working tree.

---

## Tech stack

| Layer | Tool |
| --- | --- |
| Terminal | Ghostty (macOS) / Alacritty (Windows) |
| Shell | Zsh + Oh My Zsh |
| Multiplexer | Zellij (auto-starts only in Ghostty, never in IDE terminals) |
| Prompt | Starship |
| File listing | eza |
| Dir jump | zoxide (`z` / `cdz` — plain `cd` is intentionally NOT aliased) |
| Fuzzy find | fzf |
| File pager | bat |
| Search | ripgrep |
| Git UI | lazygit + gh CLI |
| Git diff | delta |
| Python | uv + ipython |
| Node | nvm |
| Secrets | Bitwarden + rbw (unofficial CLI); runtime keys in `~/.secrets` |
| Cloud CLIs | aws / gcloud / az (installed per-machine as needed) |
| JSON / HTTP | jq + httpie |

### Editors and AI tooling (multi-IDE by design)

VS Code and Antigravity are the **primary** editors and share
`configs/vscode/settings.json`. Cursor, Zed, Kiro, and Windsurf/Devin are
installed but used infrequently. CLI agents in rotation include Claude Code,
Codex, opencode, GitHub Copilot CLI, and others. This plurality is
intentional — do not "consolidate" to one editor or flag it as a conflict.

**Java is NOT part of the stack.** The extensive Java/JDK/Maven blocks in
`configs/vscode/settings.json` are machine-generated by the Pleiades JDK
extension — leave them alone, don't document Java as a stack tool, and don't
remove the blocks (the extension will just rewrite them).

---

## Key conventions

- **Commit messages** follow Conventional Commits:
  `feat:`, `fix:`, `chore:`, `docs:`, `refactor:`
- **Config changes** go in `configs/<tool>/` — never edit home-dir dotfiles
- **New tools:** add to `Brewfile`, add config to `configs/`, add symlink to
  `install.sh`, document in CHEATSHEET.md
- **Markdown** is linted — run `markdownlint '**/*.md'` before committing
- **No secrets** — no API keys, tokens, or passwords in this repo. Runtime
  keys go in `~/.secrets` (template: `configs/zsh/.secrets.example`);
  long-term storage is Bitwarden (`rbw` on the CLI)
- **`cd` stays `cd`** — zoxide is reached via `z`/`cdz`, never alias `cd='z'`
- **Zellij auto-start** is guarded by `$GHOSTTY_RESOURCES_DIR` so it only
  launches in Ghostty — never remove that guard or IDE-embedded terminals
  (VS Code, Antigravity, …) will nest into Zellij layouts

---

## What agents should and shouldn't do

### ✅ Do

- Edit files in `configs/` when updating tool configurations
- Respect the documentation roles table above when updating docs
- Update `Brewfile` when adding or removing tools
- Follow existing formatting and comment style within each file
- Use Conventional Commits format for commit messages

### ❌ Don't

- Add secrets, credentials, or personal tokens to any file
- Modify `install.sh` unless explicitly asked — regressions are hard to test
- Create new top-level directories without discussing first
- Remove or "fix" machine-generated blocks in `configs/vscode/settings.json`
  (Java runtimes, terminal profiles, ZDOTDIR entries)
- Break cross-platform compatibility — configs should work on both macOS and
  WSL2 unless clearly platform-specific (e.g., `ghostty/`, `alacritty/`)

---

## Platform notes

| File | macOS | Windows WSL2 |
| --- | --- | --- |
| `configs/ghostty/` | ✅ used | ❌ not used |
| `configs/alacritty/` | ❌ not used | ✅ manual copy |
| `configs/zsh/.zshrc` | ✅ | ✅ |
| `configs/starship/starship.toml` | ✅ | ✅ |
| `configs/vscode/settings.json` | ✅ | ✅ |
| `configs/git/.gitconfig` | ✅ | ✅ |
| `configs/antigravity/skills/` | ✅ | ✅ |
| `Brewfile` | ✅ Homebrew | ✅ Linuxbrew (casks skipped) |
