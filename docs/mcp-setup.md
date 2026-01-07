# MCP Server Setup

Comprehensive guide to setting up all MCP servers for this toolkit.

## Overview

The toolkit uses these MCP servers:

| Server | Purpose | Commands Using It |
|--------|---------|-------------------|
| Notion | Workspace docs | `/doc-to-notion` |
| Google Calendar | Calendar events | `/today` |
| Asana | Task management | `/today` |
| Playwright | Browser automation | Various |

## Notion Setup (OAuth)

**Recommended method** - OAuth is more reliable than API key.

1. Remove any old config:
   ```bash
   claude mcp remove notion -s user
   ```

2. Visit: https://developers.notion.com/docs/mcp

3. Follow the OAuth flow and authorize your workspace

4. Test:
   ```bash
   claude -p "Search Notion for PhD Networks"
   ```

See `../mcp-configs/notion-oauth.md` for detailed guide.

## Google Calendar Setup

1. Create Google Cloud project and enable Calendar API

2. Create OAuth credentials (Desktop app)

3. Add MCP:
   ```bash
   claude mcp add google-calendar -s user -- npx -y @cocal/google-calendar-mcp
   ```

4. Authorize when prompted

5. Test:
   ```bash
   claude -p "What's on my calendar today?"
   ```

See `../mcp-configs/google-calendar.md` for detailed guide.

## Asana Setup

1. Get Personal Access Token from:
   https://app.asana.com/0/developer-console

2. Add MCP:
   ```bash
   claude mcp add asana -s user -e ASANA_ACCESS_TOKEN="your-token" -- npx -y @roychri/mcp-server-asana
   ```

3. Test:
   ```bash
   claude -p "List my Asana workspaces"
   ```

## Playwright Setup

Usually auto-configured. If needed:

```bash
claude mcp add playwright -s user -- npx -y @anthropic/mcp-playwright
```

## Verification Script

Run this to check all MCP servers:

```bash
echo "=== MCP Status ==="
claude mcp list

echo ""
echo "=== Testing Notion ==="
claude -p "Search Notion for test" 2>&1 | head -5

echo ""
echo "=== Testing Calendar ==="
claude -p "List my calendars" 2>&1 | head -5

echo ""
echo "=== Testing Asana ==="
claude -p "List Asana workspaces" 2>&1 | head -5
```

## Common Issues

See `troubleshooting.md` for detailed solutions.
