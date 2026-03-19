# Terminal Tools Cheatsheet

A quick reference for every tool in this setup — what it does, when to use it, and the commands you'll actually reach for daily.

---

## Navigation

### zoxide — smart `cd`

Learns the directories you visit. The more you visit a directory, the higher it ranks.

| Command      | What it does                                        |
| ------------ | --------------------------------------------------- |
| `z dotfiles` | Jump to the directory with "dotfiles" in the path   |
| `z proj`     | Jump to your most-visited directory matching "proj" |
| `z -`        | Go back to previous directory                       |
| `zi`         | Interactive fuzzy picker of your most visited dirs  |

**When to use:** Instead of `cd` for everything. After a few days it knows where you work.

---

### fzf — fuzzy finder

An interactive filter for any list. Works on files, history, branches, processes — anything.

| Command             | What it does                            |
| ------------------- | --------------------------------------- |
| `Ctrl+R`            | Fuzzy search command history            |
| `Ctrl+T`            | Fuzzy search files in current directory |
| `Alt+C`             | Fuzzy cd into a subdirectory            |
| `ls \| fzf`         | Fuzzy filter any command output         |
| `git branch \| fzf` | Pick a branch interactively             |

**When to use:** Anytime you're searching for something — a file, a past command, a branch name.

---

### eza — better `ls`

Replaces `ls` with colour, icons, git status, and tree views.

| Command              | What it does                                    |
| -------------------- | ----------------------------------------------- |
| `ls`                 | List files with icons (aliased to eza)          |
| `ll`                 | Long listing with permissions, size, git status |
| `lt`                 | Tree view 2 levels deep                         |
| `lta`                | Tree view 3 levels deep                         |
| `la`                 | Long listing including hidden files             |
| `ll --sort=modified` | Sort by last modified                           |

**When to use:** All the time — it replaces `ls` completely.

---

### fd — better `find`

Faster and friendlier alternative to `find`.

| Command         | What it does                               |
| --------------- | ------------------------------------------ |
| `fd .py`        | Find all Python files in current directory |
| `fd config`     | Find files/dirs named "config"             |
| `fd -e toml`    | Find files with `.toml` extension          |
| `fd -H .env`    | Find hidden files named `.env`             |
| `fd . --type d` | Find only directories                      |

**When to use:** When you need to find a file but can't remember where it is.

---

## File Viewing

### bat — better `cat`

Syntax-highlighted file viewer with line numbers and git integration.

| Command              | What it does                                        |
| -------------------- | --------------------------------------------------- |
| `cat file.py`        | View file with syntax highlighting (aliased to bat) |
| `bat -n file.py`     | View with line numbers only                         |
| `bat --diff file.py` | Show git diff inline                                |
| `bat -l json file`   | Force JSON syntax highlighting                      |

**When to use:** Whenever you want to read a file in the terminal. Replaces `cat` completely.

---

## Search

### ripgrep — fast grep

Searches file contents recursively. Much faster than grep, respects `.gitignore`.

| Command                    | What it does                               |
| -------------------------- | ------------------------------------------ |
| `rg "search term"`         | Search current directory recursively       |
| `rg "def train" --type py` | Search only Python files                   |
| `rg -i "error"`            | Case-insensitive search                    |
| `rg "TODO" -l`             | List files containing TODO (not the lines) |
| `rg "import" --stats`      | Show match statistics                      |

**When to use:** When you need to find where something is used across a codebase.

---

## Git

### lazygit — visual git TUI

A full git interface in the terminal. Open with `lg`.

| Key       | What it does            |
| --------- | ----------------------- |
| `space`   | Stage / unstage a file  |
| `a`       | Stage all files         |
| `c`       | Commit                  |
| `A`       | Amend last commit       |
| `P`       | Push                    |
| `p`       | Pull                    |
| `f`       | Fetch                   |
| `b`       | Open branch menu        |
| `n`       | Create new branch       |
| `[` / `]` | Navigate between panels |
| `?`       | Show all keybindings    |
| `q`       | Quit                    |
| `e`       | Open file in editor     |
| `d`       | View diff               |
| `z`       | Stash changes           |

**Panels (top row):**

- `1` Status
- `2` Files
- `3` Branches
- `4` Commits
- `5` Stash

**When to use:** For all day-to-day git operations — staging, committing, pushing, branching. Much faster than typing git commands manually.

---

### gh — GitHub CLI

Interact with GitHub from the terminal without opening a browser.

| Command                   | What it does                     |
| ------------------------- | -------------------------------- |
| `gh repo create`          | Create a new GitHub repo         |
| `gh repo clone user/repo` | Clone a repo                     |
| `gh pr create`            | Open a pull request              |
| `gh pr list`              | List open PRs                    |
| `gh pr checkout 42`       | Check out PR #42 locally         |
| `gh issue create`         | Create a new issue               |
| `gh issue list`           | List open issues                 |
| `gh browse`               | Open current repo in browser     |
| `gh run list`             | List recent GitHub Actions runs  |
| `gh run watch`            | Watch a running Actions workflow |

**When to use:** Creating repos, opening PRs, checking CI status — without leaving the terminal.

---

### delta — better git diffs

Automatically used when you run `git diff`, `git log -p`, or view diffs in lazygit.

| Command         | What it does                                             |
| --------------- | -------------------------------------------------------- |
| `git diff`      | Diff with syntax highlighting (delta runs automatically) |
| `git log -p`    | Log with highlighted diffs                               |
| `git show HEAD` | Show last commit with highlighted diff                   |

No extra commands needed — delta is set as the default git pager in `.zshrc`.

---

## Shell

### Zellij — terminal multiplexer

Panes, tabs, and persistent sessions. Keybindings are shown at the bottom of the screen.

| Shortcut             | What it does                           |
| -------------------- | -------------------------------------- |
| `Ctrl+p`             | Enter pane mode                        |
| `Ctrl+p` then `n`    | New pane                               |
| `Ctrl+p` then `x`    | Close pane                             |
| `Ctrl+p` then `↑↓←→` | Move between panes                     |
| `Ctrl+p` then `f`    | Toggle fullscreen on current pane      |
| `Ctrl+t`             | Enter tab mode                         |
| `Ctrl+t` then `n`    | New tab                                |
| `Ctrl+t` then `r`    | Rename tab                             |
| `Alt+↑↓←→`           | Move between panes (shortcut)          |
| `Ctrl+s`             | Enter scroll mode (keyboard selection) |
| `Ctrl+q`             | Quit Zellij                            |

**When to use:** Always — it's your terminal workspace. Main shell on the left, lazygit top right, server/logs bottom right.

---

### Starship — prompt

Shows context automatically. Nothing to run — it just works.

| What you see | What it means                             |
| ------------ | ----------------------------------------- |
| `dotfiles`   | Current directory name                    |
| `main`       | Git branch                                |
| `+1`         | 1 staged change                           |
| `~2`         | 2 unstaged changes                        |
| `?1`         | 1 untracked file                          |
| `⇡1`         | 1 commit ahead of remote                  |
| `⇣1`         | 1 commit behind remote                    |
| `py 3.12`    | Python version (when in a Python project) |
| `v20`        | Node version (when in a Node project)     |
| `12s`        | Last command took 12 seconds              |

---

## Python

### uv — Python environment manager

Replaces `pip`, `venv`, and `pyenv` in one tool.

| Command                              | What it does                          |
| ------------------------------------ | ------------------------------------- |
| `uv python install 3.12`             | Install Python 3.12                   |
| `uv python list`                     | List available Python versions        |
| `uv venv`                            | Create a `.venv` in current directory |
| `source .venv/bin/activate`          | Activate the venv                     |
| `uv pip install requests`            | Install a package                     |
| `uv pip install -r requirements.txt` | Install from requirements file        |
| `uv pip freeze`                      | List installed packages               |
| `uv run script.py`                   | Run script without activating venv    |
| `uv pip compile requirements.in`     | Pin dependencies                      |

**When to use:** For every Python project. Create a venv per project, never install packages globally.

---

### ipython — enhanced Python REPL

A much better interactive Python shell than the default `python` command.

| Command          | What it does                      |
| ---------------- | --------------------------------- |
| `ipython`        | Start the REPL                    |
| `%run script.py` | Run a Python file                 |
| `%timeit func()` | Time a function                   |
| `%paste`         | Paste and run code from clipboard |
| `?object`        | Show documentation for any object |
| `??object`       | Show source code for any object   |
| `%history`       | Show command history              |
| `Ctrl+D`         | Exit                              |

**When to use:** Quick Python experiments, testing agentic app logic, exploring a new library.

---

## Node.js

### nvm — Node version manager

| Command                | What it does             |
| ---------------------- | ------------------------ |
| `nvm install --lts`    | Install latest LTS Node  |
| `nvm install 20`       | Install Node 20          |
| `nvm use 20`           | Switch to Node 20        |
| `nvm use --lts`        | Switch to LTS            |
| `nvm ls`               | List installed versions  |
| `nvm current`          | Show active version      |
| `nvm alias default 20` | Set default Node version |

**When to use:** When a project needs a specific Node version, or when switching between projects with different requirements.

---

## Cloud + APIs

### jq — JSON processor

Parse, filter, and transform JSON from the command line.

| Command                                        | What it does            |
| ---------------------------------------------- | ----------------------- |
| `echo '{"name":"test"}' \| jq .`               | Pretty-print JSON       |
| `cat data.json \| jq '.name'`                  | Extract a field         |
| `cat data.json \| jq '.users[]'`               | Iterate an array        |
| `cat data.json \| jq '.users[] \| {id, name}'` | Extract specific fields |
| `cat data.json \| jq 'length'`                 | Count items             |
| `cat data.json \| jq 'select(.age > 30)'`      | Filter by condition     |
| `cat data.json \| jq -r '.name'`               | Raw output (no quotes)  |

**When to use:** Whenever an API returns JSON — pipe the response through jq to extract what you need.

---

### httpie — human-friendly HTTP client

| Command                                                       | What it does           |
| ------------------------------------------------------------- | ---------------------- |
| `http GET api.example.com/users`                              | GET request            |
| `http POST api.example.com/users name=deepak`                 | POST with JSON body    |
| `http GET api.example.com/users Authorization:"Bearer token"` | With auth header       |
| `http --follow GET url`                                       | Follow redirects       |
| `http -v GET url`                                             | Verbose — show headers |
| `http GET url \| jq '.results'`                               | Pipe to jq             |

**When to use:** Testing APIs, debugging endpoints, quick HTTP requests without writing code.

---

### direnv — per-project environment variables

| Command                                        | What it does                            |
| ---------------------------------------------- | --------------------------------------- |
| `echo 'export AWS_PROFILE=myproject' > .envrc` | Create env file                         |
| `direnv allow`                                 | Approve the `.envrc` for this directory |
| `direnv deny`                                  | Revoke approval                         |
| `direnv reload`                                | Reload after editing `.envrc`           |

**Typical `.envrc` for a project:**

```bash
export AWS_PROFILE=myproject
export ENVIRONMENT=development
export API_URL=http://localhost:8000
source .venv/bin/activate
```

**When to use:** Any project that needs specific environment variables — cloud credentials, API keys, environment flags. Set once, loads automatically when you `cd` in.

---

## Utilities

### tldr — simplified man pages

| Command         | What it does            |
| --------------- | ----------------------- |
| `tldr git`      | Common git commands     |
| `tldr docker`   | Common docker commands  |
| `tldr tar`      | How to actually use tar |
| `tldr ffmpeg`   | Common ffmpeg recipes   |
| `tldr --update` | Update the local cache  |

**When to use:** Before googling how to use a CLI tool. `tldr` gives you the 5 most common examples immediately.

---

## Workflows

### Starting a new Python project

```bash
mkdir myproject && cd myproject
uv venv
source .venv/bin/activate
uv pip install crewai langgraph
echo 'source .venv/bin/activate' > .envrc
direnv allow
git init
gh repo create myproject --public
git add . && git commit -m "init"
git push -u origin main
```

### Exploring an API response

```bash
http GET api.example.com/data | jq '.'              # pretty print
http GET api.example.com/data | jq '.results[0]'    # first result
http GET api.example.com/data | jq '.results | length'  # count
```

### Finding where something is used in a codebase

```bash
rg "function_name" --type py     # find in Python files
rg "import crewai" -l            # list files that import crewai
rg "TODO" | fzf                  # fuzzy search TODOs
```

### Checking what changed in git

```bash
lg                               # open lazygit
git diff | bat                   # diff with syntax highlighting
git log --oneline | fzf          # fuzzy search commit history
```

---

_Part of the [dotfiles](https://github.com/YOURUSERNAME/dotfiles) setup._
