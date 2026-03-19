# Node.js

[← Back to Quick Reference](../QUICK-REF.md)

---

## nvm — Node version manager

| Command | What it does |
|---|---|
| `nvm install --lts` | Install latest LTS Node |
| `nvm install 20` | Install Node 20 |
| `nvm use --lts` | Switch to LTS |
| `nvm use 20` | Switch to Node 20 |
| `nvm ls` | List installed versions |
| `nvm ls-remote` | List available versions |
| `nvm current` | Show active version |
| `nvm alias default 20` | Set default version |
| `nvm uninstall 18` | Uninstall a version |

### Per-project Node version

Create `.nvmrc` in project root:
```bash
echo "20" > .nvmrc
nvm use    # reads .nvmrc automatically
```

---

## npm — package manager

### Project setup

| Command | What it does |
|---|---|
| `npm init -y` | Create package.json with defaults |
| `npm install` | Install all dependencies |
| `npm install <pkg>` | Install a package |
| `npm install -D <pkg>` | Install as dev dependency |
| `npm uninstall <pkg>` | Remove a package |
| `npm update` | Update all packages |
| `npm outdated` | Show outdated packages |
| `npm list` | List installed packages |

### Running scripts

| Command | What it does |
|---|---|
| `npm run dev` | Run dev server |
| `npm run build` | Build for production |
| `npm run start` | Start production server |
| `npm run test` | Run tests |
| `npm run lint` | Run linter |
| `npm run format` | Run formatter |

### npx

| Command | What it does |
|---|---|
| `npx create-react-app myapp` | Create React app |
| `npx create-next-app myapp` | Create Next.js app |
| `npx <pkg>` | Run a package without installing |

---

## Common package.json scripts

```json
{
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "eslint .",
    "format": "prettier --write ."
  }
}
```

---

## Vercel — deployment

| Command | What it does |
|---|---|
| `npm i -g vercel` | Install Vercel CLI |
| `vercel login` | Authenticate |
| `vercel` | Deploy to preview |
| `vercel --prod` | Deploy to production |
| `vercel dev` | Run local dev server |
| `vercel env add` | Add environment variable |
| `vercel env ls` | List environment variables |
| `vercel ls` | List deployments |
| `vercel logs` | View deployment logs |
| `vercel domains ls` | List domains |

---

## Common React + Next.js packages

| Package | What it does |
|---|---|
| `next` | React framework |
| `react` `react-dom` | React core |
| `typescript` | TypeScript support |
| `tailwindcss` | Utility CSS framework |
| `eslint` | Linting |
| `prettier` | Code formatting |
| `axios` | HTTP client |
| `zustand` | State management |
| `react-query` | Server state management |
