# Ship It - Git Commit & Push

Fast-track git workflow. Analyse changes, generate meaningful commit message, commit, and push.

## Workflow

### Step 1: Analyse Current State

```bash
git branch --show-current
git status
git diff --stat
git diff --cached --stat
```

### Step 2: Stage Changes

If unstaged changes exist:
- Stage all if cohesive change
- Prompt if clearly separate concerns should be separate commits

```bash
git add -A
```

### Step 3: Generate Commit Message

Follow conventional commits format:

```
<type>(<scope>): <short summary>

<body - what and why>
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only
- `style`: Formatting, no code change
- `refactor`: Code restructure, no feature change
- `perf`: Performance improvement
- `test`: Adding/updating tests
- `chore`: Maintenance, deps, config

**Scope examples:**
- Clients: `jp-electrical`, `jlr-roofing`, `ossett-dental`, `wortley-windows`, `doab`
- Features: `google-ads`, `landing-page`, `seo`, `automation`, `membership`
- Technical: `api`, `db`, `auth`, `ui`, `config`

### Step 4: Commit

```bash
git commit -m "<generated message>"
```

### Step 5: Push

```bash
git push origin $(git branch --show-current)
```

### Step 6: Confirm

Output:
- Committed: `<hash short>`
- Pushed to: `<branch>` on `<remote>`
- Message: `<commit message>`
- Stats: `<files changed, insertions, deletions>`

## Options

- `--amend` - Amend the last commit
- `--wip` - Quick WIP commit: `chore: wip`
- `--no-push` - Commit only, don't push
- `--force` - Force push (with lease for safety)

## Safety Checks

Before pushing:
1. Warn if on `main`/`master` branch
2. Check for merge conflicts
3. Check for large files accidentally staged (>5MB)
4. Check for sensitive files (.env, credentials)

$ARGUMENTS
