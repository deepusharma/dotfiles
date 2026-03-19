# Git + GitHub CLI

[← Back to Quick Reference](../QUICK-REF.md)

---

## Git — setup

| Command | What it does |
|---|---|
| `git config --global user.name "Name"` | Set your name |
| `git config --global user.email "email"` | Set your email |
| `git config --global --list` | Show all config |
| `git init` | Initialise a new repo |
| `git clone <url>` | Clone a repo |

---

## Git — daily workflow

| Command | What it does |
|---|---|
| `git status` | Show working tree status |
| `git add .` | Stage all changes |
| `git add <file>` | Stage a specific file |
| `git commit -m "msg"` | Commit with message |
| `git commit --amend` | Amend last commit |
| `git push` | Push to remote |
| `git push -u origin main` | Push and set upstream |
| `git pull` | Pull from remote |
| `git fetch` | Fetch without merging |
| `git stash` | Stash uncommitted changes |
| `git stash pop` | Apply last stash |
| `git stash list` | List all stashes |

---

## Git — branches

| Command | What it does |
|---|---|
| `git branch` | List local branches |
| `git branch -a` | List all branches including remote |
| `git checkout -b branch` | Create and switch to new branch |
| `git checkout main` | Switch to main |
| `git merge branch` | Merge branch into current |
| `git rebase main` | Rebase current branch onto main |
| `git branch -d branch` | Delete a branch |
| `git push origin --delete branch` | Delete remote branch |

---

## Git — history + diff

| Command | What it does |
|---|---|
| `git log --oneline` | Compact commit history |
| `git log --oneline --graph` | History with branch graph |
| `git diff` | Show unstaged changes |
| `git diff --staged` | Show staged changes |
| `git show HEAD` | Show last commit |
| `git blame <file>` | Show who changed each line |

---

## Git — undo

| Command | What it does |
|---|---|
| `git restore <file>` | Discard unstaged changes |
| `git restore --staged <file>` | Unstage a file |
| `git reset HEAD~1` | Undo last commit, keep changes |
| `git reset --hard HEAD~1` | Undo last commit, discard changes |
| `git revert <commit>` | Create a new commit that undoes a commit |

---

## Git — worktrees

| Command | What it does |
|---|---|
| `git worktree list` | List all worktrees |
| `git worktree add ../feature feature` | Create worktree for branch |
| `git worktree remove ../feature` | Remove a worktree |

---

## Git — config shortcuts (.zshrc aliases)

| Alias | Command |
|---|---|
| `gs` | `git status` |
| `gp` | `git push` |
| `gpl` | `git pull` |
| `gco` | `git checkout` |
| `gcb` | `git checkout -b` |
| `glog` | `git log --oneline --graph --decorate` |
| `lg` | `lazygit` |

---

## GitHub CLI (gh)

| Command | What it does |
|---|---|
| `gh auth login` | Authenticate with GitHub |
| `gh repo create` | Create a new repo |
| `gh repo clone user/repo` | Clone a repo |
| `gh repo view` | View current repo info |
| `gh browse` | Open repo in browser |

### Pull requests

| Command | What it does |
|---|---|
| `gh pr create` | Create a pull request |
| `gh pr list` | List open PRs |
| `gh pr view` | View current branch PR |
| `gh pr checkout 42` | Check out PR #42 |
| `gh pr merge` | Merge current PR |
| `gh pr diff` | Show PR diff |

### Issues

| Command | What it does |
|---|---|
| `gh issue create` | Create an issue |
| `gh issue list` | List open issues |
| `gh issue view 42` | View issue #42 |
| `gh issue close 42` | Close issue #42 |

### Actions + releases

| Command | What it does |
|---|---|
| `gh run list` | List recent workflow runs |
| `gh run watch` | Watch a running workflow |
| `gh release create v1.0` | Create a release |
| `gh release list` | List releases |

---

## lazygit — key bindings

| Key | What it does |
|---|---|
| `space` | Stage / unstage file |
| `a` | Stage all files |
| `c` | Commit |
| `A` | Amend last commit |
| `P` | Push |
| `p` | Pull |
| `f` | Fetch |
| `b` | Branch menu |
| `n` | New branch |
| `d` | View diff |
| `z` | Stash |
| `Z` | Pop stash |
| `e` | Open file in editor |
| `[` / `]` | Navigate panels |
| `?` | All keybindings |
| `q` | Quit |
