# Antigravity Global Skills

Reusable AI agent skills for the Antigravity IDE.
Symlinked to `~/.antigravity/skills/` by `install.sh`.

## Available skills

| Skill             | Purpose                       |
| ----------------- | ----------------------------- |
| `backend-dev`     | Python, FastAPI, CLI tools    |
| `frontend-dev`    | Next.js, TypeScript, Tailwind |
| `reviewer`        | Code review checklist         |
| `tester-backend`  | pytest patterns               |
| `tester-frontend` | Vitest, React Testing Library |

## Two-level system

These are **global skills** — generic best practices.

For project-specific context, create `.antigravity/skills/`
in your project root with thin override SKILL.md files.

See gitpulse for an example:
`gitpulse/.antigravity/skills/backend-dev/SKILL.md`
