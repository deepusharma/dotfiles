# ✏️ Editor — Antigravity

[← Quick Reference](../QUICK-REF.md)

## ⌨️ Core Shortcuts

<table><tr><td width="33%">

### Navigation

| Shortcut       | What it does     |
| -------------- | ---------------- |
| `Ctrl+P`       | Quick open file  |
| `Ctrl+Shift+P` | Command palette  |
| `Ctrl+Shift+E` | File explorer    |
| `Ctrl+Shift+F` | Search all files |
| `Ctrl+Shift+G` | Source control   |
| `Ctrl+Shift+X` | Extensions       |
| `Ctrl+B`       | Toggle sidebar   |
| `Ctrl+J`       | Toggle panel     |
| `Ctrl+\``      | Toggle terminal  |
| `Ctrl+Tab`     | Switch files     |

</td><td width="33%">

### Editing

| Shortcut                  | What it does       |
| ------------------------- | ------------------ |
| `Ctrl+/`                  | Toggle comment     |
| `Alt+↑↓`                  | Move line          |
| `Shift+Alt+↑↓`            | Copy line          |
| `Ctrl+Shift+K`            | Delete line        |
| `Ctrl+D`                  | Select next match  |
| `Ctrl+Shift+L`            | Select all matches |
| `Ctrl+L`                  | Select line        |
| `Tab` / `Shift+Tab`       | Indent / outdent   |
| `Ctrl+Z` / `Ctrl+Shift+Z` | Undo / redo        |
| `Ctrl+Shift+[/]`          | Fold / unfold      |

</td><td width="33%">

### Code intelligence

| Shortcut        | What it does     |
| --------------- | ---------------- |
| `F12`           | Go to definition |
| `Alt+F12`       | Peek definition  |
| `Shift+F12`     | Find references  |
| `F2`            | Rename symbol    |
| `Ctrl+Space`    | Autocomplete     |
| `Ctrl+.`        | Quick fix        |
| `Shift+Alt+F`   | Format file      |
| `Ctrl+K Ctrl+F` | Format selection |
| `F8`            | Next error       |
| `Shift+F8`      | Previous error   |

</td></tr><tr><td>

### Search + replace

| Shortcut          | What it does      |
| ----------------- | ----------------- |
| `Ctrl+F`          | Find in file      |
| `Ctrl+H`          | Replace in file   |
| `Ctrl+Shift+F`    | Find all files    |
| `Ctrl+Shift+H`    | Replace all files |
| `F3` / `Shift+F3` | Next / prev match |

</td><td>

### Split + layout

| Shortcut        | What it does |
| --------------- | ------------ |
| `Ctrl+\`        | Split right  |
| `Ctrl+K Ctrl+\` | Split down   |
| `Ctrl+1/2/3`    | Focus group  |
| `Ctrl+W`        | Close editor |

</td><td>

### Terminal

| Shortcut        | What it does    |
| --------------- | --------------- |
| `Ctrl+\``       | Open terminal   |
| `Ctrl+Shift+\`` | New terminal    |
| `Ctrl+Shift+5`  | Split terminal  |
| `Alt+←→`        | Switch terminal |

</td></tr></table>

---

## 🔌 Plugin Shortcuts

<table><tr><td width="50%">

### 🔍 GitLens

| Action           | What it does     |
| ---------------- | ---------------- |
| Hover over line  | Show last commit |
| `Ctrl+Shift+G G` | Open graph       |
| `Ctrl+Shift+G H` | File history     |
| `Ctrl+Shift+G B` | Toggle blame     |

### 📊 Git Graph

| Action             | What it does           |
| ------------------ | ---------------------- |
| Click commit       | Show details           |
| Right-click commit | Checkout / cherry-pick |
| Click branch       | Filter view            |

### 🌐 REST Client

Create `.http` file:

```http
### Get users
GET https://api.example.com/users
Authorization: Bearer {{token}}

### Create user
POST https://api.example.com/users
Content-Type: application/json

{"name": "name"}
```

| Shortcut             | What it does    |
| -------------------- | --------------- |
| Click `Send Request` | Run request     |
| `Ctrl+Alt+R`         | Run at cursor   |
| `Ctrl+Alt+H`         | Request history |

</td><td width="50%">

### 🐍 Python

| Shortcut                                      | What it does      |
| --------------------------------------------- | ----------------- |
| `Ctrl+Shift+P` → `Python: Select Interpreter` | Choose venv       |
| `Ctrl+Shift+P` → `Python: Run File`           | Run file          |
| `F5`                                          | Start debug       |
| `F9`                                          | Toggle breakpoint |
| `F10`                                         | Step over         |
| `F11`                                         | Step into         |
| `Shift+F11`                                   | Step out          |

### 🗄️ SQLTools

| Shortcut                               | What it does |
| -------------------------------------- | ------------ |
| `Ctrl+E Ctrl+E`                        | Run query    |
| `Ctrl+E Ctrl+F`                        | Format query |
| Command palette: `SQLTools: Connect`   | Connect DB   |
| Command palette: `SQLTools: New Query` | New query    |

### ✏️ Markdown All in One

| Shortcut                            | What it does     |
| ----------------------------------- | ---------------- |
| `Ctrl+Shift+V`                      | Toggle preview   |
| `Ctrl+B`                            | Bold             |
| `Ctrl+I`                            | Italic           |
| `Ctrl+Shift+]`                      | Increase heading |
| `Ctrl+Shift+[`                      | Decrease heading |
| Command: `Create Table of Contents` | Insert TOC       |

### 🎨 Excalidraw

| Key      | What it does |
| -------- | ------------ |
| `V`      | Select       |
| `R`      | Rectangle    |
| `E`      | Ellipse      |
| `A`      | Arrow        |
| `T`      | Text         |
| `Ctrl+G` | Group        |
| `Ctrl+A` | Select all   |

### ✅ Todo Tree

Tags tracked: `TODO` `FIXME` `HACK` `BUG` `XXX`

Command palette: `Todo Tree: Show Tree`

</td></tr></table>
