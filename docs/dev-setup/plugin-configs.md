# Plugin Configurations

Settings to add to Antigravity `settings.json`.
Open with: `Ctrl+Shift+P` → "Open User Settings JSON"

---

## Todo Tree

```json
"todo-tree.general.tags": [
    "TODO",
    "FIXME",
    "HACK",
    "BUG",
    "NOTE",
    "OPTIMIZE",
    "REVIEW"
],
"todo-tree.highlights.customHighlight": {
    "TODO": {
        "icon": "check",
        "foreground": "#000",
        "background": "#FFD700",
        "iconColour": "#FFD700"
    },
    "FIXME": {
        "icon": "alert",
        "foreground": "#fff",
        "background": "#e45454",
        "iconColour": "#e45454"
    },
    "NOTE": {
        "icon": "info",
        "foreground": "#fff",
        "background": "#4CAF50",
        "iconColour": "#4CAF50"
    },
    "REVIEW": {
        "icon": "eye",
        "foreground": "#fff",
        "background": "#7B68EE",
        "iconColour": "#7B68EE"
    },
    "OPTIMIZE": {
        "icon": "zap",
        "foreground": "#fff",
        "background": "#FF8C00",
        "iconColour": "#FF8C00"
    }
},
"todo-tree.tree.showCountsInTree": true,
"todo-tree.tree.groupedByTag": true
```

**Usage in code:**
```python
# TODO: implement this
# FIXME: known bug here
# NOTE: important context
# REVIEW: needs code review
# OPTIMIZE: performance improvement needed
# HACK: temporary workaround
# BUG: known issue, fix in next release
```

---

## markdownlint

Disable MD033 (inline HTML) since we use HTML tables for side-by-side layout.

Create `.markdownlint.json` in repo root:
```json
{
    "MD033": false
}
```

---

## Ruff

```json
"[python]": {
    "editor.defaultFormatter": "charliermarsh.ruff",
    "editor.formatOnSave": true
},
"ruff.lint.select": ["T20"]
```

---

## Python

```json
"python.defaultInterpreterPath": "${workspaceFolder}/.venv/bin/python"
```

This auto-selects the project venv when you open a folder.

---

## Git

```json
"git.autofetch": true,
"git.confirmSync": false
```

---

## Editor general

```json
"editor.formatOnSave": true,
"editor.rulers": [88],
"editor.tabSize": 4,
"files.trimTrailingWhitespace": true,
"files.insertFinalNewline": true
```

Line ruler at 88 matches Ruff/Black default line length.

---

## Git global config (run once per machine)

```bash
git config --global core.fileMode false     # ignore file permission changes (WSL2)
git config --global user.name "Your Name"
git config --global user.email "you@email.com"
git config --global --add safe.directory '*'  # WSL2 Windows drive repos
```
