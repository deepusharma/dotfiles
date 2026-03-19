# 📦 Node.js

[← Quick Reference](../QUICK-REF.md)

## 🔄 nvm + npm

<table><tr><td width="50%">

### nvm — version manager

| Command | What it does |
|---|---|
| `nvm install --lts` | Install LTS |
| `nvm install 20` | Install v20 |
| `nvm use --lts` | Switch to LTS |
| `nvm use 20` | Switch to v20 |
| `nvm ls` | List installed |
| `nvm ls-remote` | List available |
| `nvm current` | Active version |
| `nvm alias default 20` | Set default |
| `nvm uninstall 18` | Remove version |

**Per-project version:**
```bash
echo "20" > .nvmrc
nvm use    # reads .nvmrc
```

</td><td width="50%">

### npm — package manager

| Command | What it does |
|---|---|
| `npm init -y` | Create package.json |
| `npm install` | Install all deps |
| `npm install pkg` | Add package |
| `npm install -D pkg` | Add dev dep |
| `npm uninstall pkg` | Remove |
| `npm update` | Update all |
| `npm outdated` | Show outdated |
| `npm list` | List installed |
| `npm run dev` | Dev server |
| `npm run build` | Build |
| `npm run test` | Run tests |
| `npm run lint` | Lint |

</td></tr></table>

---

## 🚀 Vercel + npx

<table><tr><td width="50%">

### Vercel — deployment

| Command | What it does |
|---|---|
| `npm i -g vercel` | Install CLI |
| `vercel login` | Authenticate |
| `vercel` | Deploy preview |
| `vercel --prod` | Deploy production |
| `vercel dev` | Local dev server |
| `vercel env add` | Add env var |
| `vercel env ls` | List env vars |
| `vercel ls` | List deployments |
| `vercel logs` | View logs |

</td><td width="50%">

### npx + scaffolding

| Command | What it does |
|---|---|
| `npx create-next-app myapp` | New Next.js app |
| `npx create-react-app myapp` | New React app |
| `npx create-vite myapp` | New Vite app |
| `npx pkg` | Run without install |

### Common packages

| Package | What it does |
|---|---|
| `next` | React framework |
| `tailwindcss` | Utility CSS |
| `typescript` | TypeScript |
| `eslint` | Linting |
| `prettier` | Formatting |
| `axios` | HTTP client |
| `zustand` | State management |

</td></tr></table>
