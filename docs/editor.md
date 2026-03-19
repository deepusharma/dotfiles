# Editor — Antigravity

[← Back to Quick Reference](../QUICK-REF.md)

---

## Core shortcuts

### Navigation

| Shortcut | What it does |
|---|---|
| `Ctrl+P` | Quick open file |
| `Ctrl+Shift+P` | Command palette |
| `Ctrl+Shift+E` | File explorer |
| `Ctrl+Shift+F` | Search across files |
| `Ctrl+Shift+G` | Source control |
| `Ctrl+Shift+X` | Extensions |
| `Ctrl+Shift+D` | Debug panel |
| `Ctrl+B` | Toggle sidebar |
| `Ctrl+J` | Toggle bottom panel |
| `Ctrl+\`` | Toggle terminal |
| `Ctrl+1/2/3` | Focus editor group |
| `Ctrl+Tab` | Switch open files |

### Editing

| Shortcut | What it does |
|---|---|
| `Ctrl+/` | Toggle line comment |
| `Ctrl+Shift+/` | Toggle block comment |
| `Alt+↑↓` | Move line up / down |
| `Shift+Alt+↑↓` | Copy line up / down |
| `Ctrl+Shift+K` | Delete line |
| `Ctrl+D` | Select next occurrence |
| `Ctrl+Shift+L` | Select all occurrences |
| `Ctrl+L` | Select entire line |
| `Ctrl+Shift+[` | Fold code block |
| `Ctrl+Shift+]` | Unfold code block |
| `Tab` | Indent |
| `Shift+Tab` | Outdent |
| `Ctrl+Z` | Undo |
| `Ctrl+Shift+Z` | Redo |

### Code intelligence

| Shortcut | What it does |
|---|---|
| `F12` | Go to definition |
| `Alt+F12` | Peek definition |
| `Shift+F12` | Find all references |
| `F2` | Rename symbol |
| `Ctrl+Space` | Trigger autocomplete |
| `Ctrl+Shift+Space` | Trigger parameter hints |
| `Ctrl+.` | Quick fix / code actions |
| `Shift+Alt+F` | Format document |
| `Ctrl+K Ctrl+F` | Format selection |

### Split editor

| Shortcut | What it does |
|---|---|
| `Ctrl+\` | Split editor right |
| `Ctrl+K Ctrl+\` | Split editor down |
| `Ctrl+K ←→` | Move editor to group |

### Search + replace

| Shortcut | What it does |
|---|---|
| `Ctrl+F` | Find in file |
| `Ctrl+H` | Find and replace in file |
| `Ctrl+Shift+F` | Find across all files |
| `Ctrl+Shift+H` | Replace across all files |
| `F3` | Find next |
| `Shift+F3` | Find previous |

### Terminal

| Shortcut | What it does |
|---|---|
| `Ctrl+\`` | Open / close terminal |
| `Ctrl+Shift+\`` | New terminal |
| `Ctrl+Shift+5` | Split terminal |
| `Alt+←→` | Switch terminal |

---

## GitLens

| Shortcut / Command | What it does |
|---|---|
| Hover over a line | Show last commit for that line |
| `Ctrl+Shift+G G` | Open GitLens graph |
| `Ctrl+Shift+G H` | File history |
| `Ctrl+Shift+G B` | Toggle blame |
| Command palette: `GitLens:` | All GitLens commands |

---

## Git Graph

| Action | What it does |
|---|---|
| Click commit | Show commit details |
| Right-click commit | Checkout, cherry-pick, revert options |
| Click branch | Filter to branch |
| `Ctrl+Shift+G` then click Git Graph icon | Open graph |

---

## Error Lens

Inline errors and warnings show automatically. No shortcuts needed — errors appear on the same line as the problem.

| Setting | What it does |
|---|---|
| `errorLens.enabled` | Toggle on/off |
| `errorLens.delay` | Delay before showing (ms) |

---

## REST Client

Create a `.http` file and write requests directly:

```http
### Get users
GET https://api.example.com/users
Authorization: Bearer {{token}}

### Create user
POST https://api.example.com/users
Content-Type: application/json

{
  "name": "Deepak",
  "email": "deepak@example.com"
}
```

| Shortcut | What it does |
|---|---|
| Click `Send Request` above any request | Execute the request |
| `Ctrl+Alt+R` | Send request (cursor on request) |
| `Ctrl+Alt+H` | Show request history |

---

## Todo Tree

| Command palette | What it does |
|---|---|
| `Todo Tree: Show Tree` | Open todo panel |
| `Todo Tree: Refresh` | Refresh tree |

Tags it tracks by default: `TODO`, `FIXME`, `HACK`, `BUG`, `XXX`

---

## Prettier

| Shortcut | What it does |
|---|---|
| `Shift+Alt+F` | Format current file |
| `Ctrl+K Ctrl+F` | Format selection |

Auto-formats on save if `editor.formatOnSave` is enabled.

---

## Python (Microsoft)

| Shortcut | What it does |
|---|---|
| `Ctrl+Shift+P` → `Python: Select Interpreter` | Choose Python / venv |
| `Ctrl+Shift+P` → `Python: Run Python File` | Run current file |
| `F5` | Start debugging |
| `F9` | Toggle breakpoint |
| `F10` | Step over |
| `F11` | Step into |
| `Shift+F11` | Step out |

---

## SQLTools

| Shortcut | What it does |
|---|---|
| `Ctrl+E Ctrl+E` | Run selected query |
| `Ctrl+E Ctrl+F` | Format query |
| `Ctrl+Shift+P` → `SQLTools: Connect` | Connect to database |
| `Ctrl+Shift+P` → `SQLTools: New Query` | Open new query file |

---

## Markdown All in One

| Shortcut | What it does |
|---|---|
| `Ctrl+Shift+V` | Toggle preview |
| `Ctrl+B` | Bold selected text |
| `Ctrl+I` | Italic selected text |
| `Ctrl+Shift+]` | Increase heading level |
| `Ctrl+Shift+[` | Decrease heading level |
| `Ctrl+Shift+P` → `Create Table of Contents` | Insert TOC |
| `Ctrl+Shift+P` → `Update Table of Contents` | Update TOC |

---

## Excalidraw

| Shortcut | What it does |
|---|---|
| `V` | Selection tool |
| `R` | Rectangle |
| `E` | Ellipse |
| `A` | Arrow |
| `T` | Text |
| `L` | Line |
| `Ctrl+Z` | Undo |
| `Ctrl+A` | Select all |
| `Ctrl+G` | Group selection |
| `Ctrl+Shift+G` | Ungroup |
| `Delete` | Delete selected |
| `Ctrl+C` / `Ctrl+V` | Copy / paste |
