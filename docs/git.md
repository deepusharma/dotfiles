# 🔀 Git + GitHub CLI

[← Quick Reference](../QUICK-REF.md)

<table><tr><td width="50%">

### ⚙️ Setup

| Command | What it does |
|---|---|
| `git config --global user.name "Name"` | Set name |
| `git config --global user.email "email"` | Set email |
| `git config --global --list` | Show config |
| `git init` | Init repo |
| `git clone <url>` | Clone repo |

### 📅 Daily workflow

| Command | What it does |
|---|---|
| `gs` | Status (alias) |
| `git add .` | Stage all |
| `git add <file>` | Stage file |
| `git commit -m "msg"` | Commit |
| `git commit --amend` | Amend last commit |
| `gp` | Push (alias) |
| `git push -u origin main` | Push + set upstream |
| `gpl` | Pull (alias) |
| `git fetch` | Fetch only |
| `git stash` | Stash changes |
| `git stash pop` | Apply stash |
| `git stash list` | List stashes |

### 🌿 Branches

| Command | What it does |
|---|---|
| `git branch` | List local branches |
| `git branch -a` | List all branches |
| `gcb branch` | Create + switch (alias) |
| `gco main` | Switch to main (alias) |
| `git merge branch` | Merge branch |
| `git rebase main` | Rebase onto main |
| `git branch -d branch` | Delete branch |
| `git push origin --delete branch` | Delete remote |

</td><td width="50%">

### 🔍 History + diff

| Command | What it does |
|---|---|
| `glog` | Pretty log (alias) |
| `git log --oneline` | Compact history |
| `git diff` | Unstaged changes |
| `git diff --staged` | Staged changes |
| `git show HEAD` | Last commit |
| `git blame <file>` | Line-by-line author |

### ↩️ Undo

| Command | What it does |
|---|---|
| `git restore <file>` | Discard changes |
| `git restore --staged <file>` | Unstage file |
| `git reset HEAD~1` | Undo commit, keep changes |
| `git reset --hard HEAD~1` | Undo commit, discard |
| `git revert <commit>` | Safe undo via new commit |

### 🌲 Worktrees

| Command | What it does |
|---|---|
| `git worktree list` | List worktrees |
| `git worktree add ../feat feat` | Add worktree |
| `git worktree remove ../feat` | Remove worktree |

### 🔗 Aliases (.zshrc)

| Alias | Expands to |
|---|---|
| `gs` | `git status` |
| `gp` | `git push` |
| `gpl` | `git pull` |
| `gco` | `git checkout` |
| `gcb` | `git checkout -b` |
| `glog` | `git log --oneline --graph --decorate` |
| `lg` | `lazygit` |

</td></tr></table>

---

## 🐙 GitHub CLI (gh)

<table><tr><td width="33%">

### 🏠 Repo

| Command | What it does |
|---|---|
| `gh auth login` | Authenticate |
| `gh repo create` | Create repo |
| `gh repo clone user/repo` | Clone |
| `gh repo view` | View info |
| `gh browse` | Open in browser |

</td><td width="33%">

### 🔄 Pull Requests

| Command | What it does |
|---|---|
| `gh pr create` | Create PR |
| `gh pr list` | List PRs |
| `gh pr view` | View current PR |
| `gh pr checkout 42` | Check out PR |
| `gh pr merge` | Merge PR |
| `gh pr diff` | Show diff |

</td><td width="33%">

### ⚡ Actions + Issues

| Command | What it does |
|---|---|
| `gh run list` | Recent runs |
| `gh run watch` | Watch run |
| `gh issue create` | Create issue |
| `gh issue list` | List issues |
| `gh issue close 42` | Close issue |
| `gh release create v1.0` | Create release |

</td></tr></table>

---

## 🦥 lazygit

<table><tr><td width="50%">

### Navigation + staging

| Key | What it does |
|---|---|
| `space` | Stage / unstage |
| `a` | Stage all |
| `[` / `]` | Switch panels |
| `↑↓` | Navigate list |
| `e` | Open in editor |
| `?` | All keybindings |
| `q` | Quit |

</td><td width="50%">

### Commits + branches

| Key | What it does |
|---|---|
| `c` | Commit |
| `A` | Amend last commit |
| `P` | Push |
| `p` | Pull |
| `f` | Fetch |
| `n` | New branch |
| `b` | Branch menu |
| `d` | View diff |
| `z` | Stash |
| `Z` | Pop stash |

</td></tr></table>
