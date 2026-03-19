# Terminal

[← Back to Quick Reference](../QUICK-REF.md)

---

## Ghostty

| Shortcut | What it does |
|---|---|
| `Cmd+N` (Mac) / `Ctrl+Shift+N` (Win) | New window |
| `Cmd+T` (Mac) | New tab |
| `Cmd++` / `Cmd+-` | Increase / decrease font size |
| `Cmd+0` | Reset font size |
| `Cmd+K` | Clear screen |

---

## Zellij

### Panes

| Shortcut | What it does |
|---|---|
| `Ctrl+p` | Enter pane mode |
| `Ctrl+p` then `n` | New pane |
| `Ctrl+p` then `x` | Close pane |
| `Ctrl+p` then `f` | Fullscreen toggle |
| `Ctrl+p` then `↑↓←→` | Move focus |
| `Ctrl+p` then `r` | Resize mode |
| `Alt+↑↓←→` | Move between panes (shortcut) |

### Tabs

| Shortcut | What it does |
|---|---|
| `Ctrl+t` | Enter tab mode |
| `Ctrl+t` then `n` | New tab |
| `Ctrl+t` then `r` | Rename tab |
| `Ctrl+t` then `x` | Close tab |
| `Ctrl+t` then `←→` | Navigate tabs |

### Session + scroll

| Shortcut | What it does |
|---|---|
| `Ctrl+o` | Session mode |
| `Ctrl+s` | Enter scroll mode |
| `Ctrl+s` then `e` | Edit scrollback in editor |
| `Ctrl+g` | Unlock / lock mouse |
| `Ctrl+q` | Quit Zellij |

---

## fzf — fuzzy finder

| Shortcut / Command | What it does |
|---|---|
| `Ctrl+R` | Fuzzy search command history |
| `Ctrl+T` | Fuzzy search files |
| `Alt+C` | Fuzzy cd into subdirectory |
| `ls \| fzf` | Fuzzy filter any list |
| `git branch \| fzf` | Pick a branch interactively |
| `rg "term" \| fzf` | Fuzzy search grep results |

---

## eza — file listing

| Command | What it does |
|---|---|
| `ls` | List with icons (aliased) |
| `ll` | Long listing with git status |
| `lt` | Tree view 2 levels |
| `lta` | Tree view 3 levels |
| `la` | Long listing including hidden |
| `ll --sort=modified` | Sort by modified time |
| `ll --sort=size` | Sort by size |

---

## bat — file viewer

| Command | What it does |
|---|---|
| `cat <file>` | View with syntax highlighting (aliased) |
| `bat -n <file>` | Show line numbers only |
| `bat --diff <file>` | Show git diff inline |
| `bat -l json <file>` | Force JSON highlighting |
| `bat -p <file>` | Plain output, no decorations |

---

## zoxide — smart cd

| Command | What it does |
|---|---|
| `z dirname` | Jump to best matching directory |
| `z proj` | Jump to most visited "proj" directory |
| `z -` | Go back to previous directory |
| `zi` | Interactive fuzzy directory picker |
| `zoxide query --list` | Show all tracked directories |

---

## ripgrep — fast search

| Command | What it does |
|---|---|
| `rg "term"` | Search current directory |
| `rg "term" --type py` | Search only Python files |
| `rg -i "term"` | Case-insensitive search |
| `rg "term" -l` | List matching files only |
| `rg "term" -n` | Show line numbers |
| `rg "term" --hidden` | Include hidden files |

---

## fd — file finder

| Command | What it does |
|---|---|
| `fd .py` | Find Python files |
| `fd config` | Find files named "config" |
| `fd -e toml` | Find by extension |
| `fd -H .env` | Find hidden files |
| `fd . --type d` | Find directories only |

---

## delta — git diff viewer

Runs automatically with `git diff`, `git log -p`, `git show`. No commands needed.

| Command | What it does |
|---|---|
| `git diff` | Diff with syntax highlighting |
| `git log -p` | Log with highlighted diffs |
| `git show HEAD` | Show last commit with diff |

---

## Starship prompt — what it shows

| Indicator | Meaning |
|---|---|
| `dirname` | Current directory |
| `main` | Git branch |
| `+1` | 1 staged change |
| `~2` | 2 unstaged changes |
| `?1` | 1 untracked file |
| `⇡1` | 1 commit ahead of remote |
| `⇣1` | 1 commit behind remote |
| `py 3.12` | Active Python version |
| `v20` | Active Node version |
| `12s` | Last command took 12 seconds |

---

## tldr — simplified man pages

| Command | What it does |
|---|---|
| `tldr <tool>` | Show common examples for a tool |
| `tldr git` | Common git commands |
| `tldr docker` | Common docker commands |
| `tldr --update` | Update local cache |
