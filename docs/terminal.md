# 🖥️ Terminal

[← Quick Reference](../QUICK-REF.md)

## 👻 Ghostty

<table><tr><td width="50%">

| Shortcut (Mac) | What it does |
|---|---|
| `Cmd+N` | New window |
| `Cmd+T` | New tab |
| `Cmd++` / `Cmd+-` | Font size |
| `Cmd+0` | Reset font size |
| `Cmd+K` | Clear screen |

</td><td width="50%">

| Shortcut (Windows) | What it does |
|---|---|
| `Ctrl+Shift+N` | New window |
| `Ctrl+Shift+T` | New tab |
| `Ctrl+Shift+=` / `-` | Font size |
| `Ctrl+Shift+0` | Reset font size |
| `Ctrl+L` | Clear screen |

</td></tr></table>

---

## 🪟 Zellij

<table><tr><td width="33%">

### Panes

| Key | What it does |
|---|---|
| `Ctrl+p` | Pane mode |
| `n` | New pane |
| `x` | Close pane |
| `f` | Fullscreen |
| `↑↓←→` | Move focus |
| `Alt+↑↓←→` | Move (shortcut) |

</td><td width="33%">

### Tabs

| Key | What it does |
|---|---|
| `Ctrl+t` | Tab mode |
| `n` | New tab |
| `r` | Rename tab |
| `x` | Close tab |
| `←→` | Navigate tabs |

</td><td width="33%">

### Session + misc

| Key | What it does |
|---|---|
| `Ctrl+o` | Session mode |
| `Ctrl+s` | Scroll mode |
| `Ctrl+g` | Unlock mouse |
| `Ctrl+q` | Quit |

</td></tr></table>

---

## 🔍 fzf + Search

<table><tr><td width="50%">

### fzf — fuzzy finder

| Key / Command | What it does |
|---|---|
| `Ctrl+R` | Fuzzy history |
| `Ctrl+T` | Fuzzy files |
| `Alt+C` | Fuzzy cd |
| `ls \| fzf` | Filter any list |
| `git branch \| fzf` | Pick branch |

</td><td width="50%">

### ripgrep — fast search

| Command | What it does |
|---|---|
| `rg "term"` | Search directory |
| `rg "term" --type py` | Python files only |
| `rg -i "term"` | Case insensitive |
| `rg "term" -l` | Files only |
| `rg "term" \| fzf` | Interactive search |

</td></tr></table>

---

## 📁 Files

<table><tr><td width="33%">

### eza — listing

| Command | What it does |
|---|---|
| `ls` | List with icons |
| `ll` | Long + git status |
| `lt` | Tree 2 levels |
| `lta` | Tree 3 levels |
| `la` | Include hidden |
| `ll --sort=modified` | By date |
| `ll --sort=size` | By size |

</td><td width="33%">

### bat — viewer

| Command | What it does |
|---|---|
| `cat <file>` | Syntax view |
| `bat -n <file>` | Line numbers |
| `bat --diff <file>` | Git diff |
| `bat -l json <file>` | Force JSON |
| `bat -p <file>` | Plain output |

</td><td width="33%">

### fd — finder

| Command | What it does |
|---|---|
| `fd .py` | Find by ext |
| `fd config` | Find by name |
| `fd -e toml` | By extension |
| `fd -H .env` | Hidden files |
| `fd . --type d` | Dirs only |

</td></tr></table>

---

## 🧭 Navigation + Info

<table><tr><td width="50%">

### zoxide — smart cd

| Command | What it does |
|---|---|
| `z dirname` | Jump to dir |
| `z proj` | Most visited match |
| `z -` | Previous dir |
| `zi` | Interactive picker |

### delta — git diffs

Runs automatically with `git diff`, `git log -p`, `git show`. No config needed.

</td><td width="50%">

### Starship prompt indicators

| Shows | Means |
|---|---|
| `dirname` | Current directory |
| `main` | Git branch |
| `+1` | Staged changes |
| `~2` | Unstaged changes |
| `?1` | Untracked files |
| `⇡1` | Ahead of remote |
| `⇣1` | Behind remote |
| `py 3.12` | Python version |
| `v20` | Node version |
| `12s` | Slow command |

</td></tr></table>

---

## 📖 tldr

| Command | What it does |
|---|---|
| `tldr <tool>` | Quick examples |
| `tldr git` | Git examples |
| `tldr docker` | Docker examples |
| `tldr --update` | Update cache |
