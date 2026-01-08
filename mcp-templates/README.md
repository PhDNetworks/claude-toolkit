# MCP Config Templates

Cross-platform MCP server configuration templates for Claude Code. Copy and customize for your machine.

## Included MCP Servers

| Server | Purpose | Auth Type |
|--------|---------|-----------|
| **Asana** | Task management | Personal Access Token |
| **Google Calendar** | Calendar integration | OAuth 2.0 |
| **Notion** | Knowledge base / docs | OAuth 2.0 (browser) |
| **Make.com** | Automation workflows | URL-based (org ID) |
| **Playwright** | Browser automation | None (local) |

## Quick Setup

### 1. Prerequisites

```bash
# Node.js 18+ required
node --version

# npm comes with Node
npm --version
```

### 2. Choose Your Platform Template

| Platform | Template File |
|----------|--------------|
| macOS | `mac-mcp-config.json` |
| WSL / Linux | `wsl-mcp-config.json` |
| Windows | `windows-mcp-config.json` |

### 3. Copy Template to Claude Config

**macOS / Linux:**
```bash
# View your current config (if exists)
cat ~/.claude.json

# Merge the mcpServers section from the template
# Or use claude mcp add commands (see below)
```

**Recommended: Use CLI to Add Servers**

```bash
# Asana
claude mcp add asana -s user \
  -e ASANA_ACCESS_TOKEN="YOUR_TOKEN" \
  -- npx -y @roychri/mcp-server-asana

# Google Calendar
claude mcp add google-calendar -s user \
  -e GOOGLE_OAUTH_CREDENTIALS="~/path/to/client_secret.json" \
  -- npx -y @cocal/google-calendar-mcp

# Notion (OAuth - opens browser)
claude mcp add notion -s user \
  -- npx -y mcp-remote https://mcp.notion.com/mcp

# Make.com
claude mcp add make -s user \
  -- npx -y mcp-remote https://YOUR_REGION.make.com/mcp/u/YOUR_ORG_ID/sse

# Playwright
claude mcp add playwright -s user \
  -- npx @playwright/mcp@latest
```

### 4. Replace Placeholders

Edit your config and replace:

| Placeholder | Where to Get It |
|-------------|-----------------|
| `YOUR_ASANA_PAT` | [Asana Developer Console](https://app.asana.com/0/developer-console) |
| `YOUR_REGION` | Your Make.com dashboard URL (e.g., `eu2`, `us1`) |
| `YOUR_ORG_ID` | Your Make.com organization ID from dashboard URL |
| Google OAuth JSON | See [google-calendar.md](../mcp-configs/google-calendar.md) |

### 5. Verify Installation

```bash
# List configured MCP servers
claude mcp list

# Test each server
claude -p "list my asana workspaces"
claude -p "list my calendars"
claude -p "search notion for test"
```

## Detailed Setup Guides

- [Google Calendar OAuth Setup](../mcp-configs/google-calendar.md)
- [Notion OAuth Setup](../mcp-configs/notion-oauth.md)
- [Asana Setup](../mcp-configs/README.md)

## Troubleshooting

### Server Not Starting

```bash
# Check if npx can find the package
npx -y @roychri/mcp-server-asana --version

# Clear npm cache if needed
npm cache clean --force
```

### OAuth Issues

**Google Calendar:**
- Ensure OAuth credentials JSON file exists at specified path
- Run `claude -p "list calendars"` to trigger OAuth flow
- Check `~/.config/google-calendar-mcp/tokens.json` for saved tokens

**Notion:**
- Browser should open for OAuth on first use
- Ensure you authorize the correct workspace

### Windows-Specific

- Use `cmd /c npx` format as shown in `windows-mcp-config.json`
- Paths use backslashes: `%USERPROFILE%\Documents\...`
- May need to run terminal as Administrator for first setup

### Permission Errors

```bash
# Ensure npm global packages are accessible
npm config get prefix
export PATH="$PATH:$(npm config get prefix)/bin"
```

## File Reference

| File | Purpose |
|------|---------|
| `mac-mcp-config.json` | macOS configuration template |
| `wsl-mcp-config.json` | WSL/Linux configuration template |
| `windows-mcp-config.json` | Windows configuration template |
| `secrets.example.env` | Environment variables reference |

## Platform Notes

### macOS
- Paths use `~/` for home directory
- OAuth credential files typically in `~/Documents/credentials/`

### WSL / Linux
- Paths use `~/` or `~/.config/`
- Same npx commands as macOS

### Windows
- Uses `cmd /c npx` wrapper
- Paths use `%USERPROFILE%` environment variable
- Backslashes in paths must be escaped in JSON: `\\`

---

Part of [claude-toolkit](../) by PhD Networks
