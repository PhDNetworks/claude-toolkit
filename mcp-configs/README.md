# MCP Configuration Guides

Setup guides for Model Context Protocol (MCP) servers used with Claude Code.

## Current MCP Servers

| Server | Auth Method | Guide |
|--------|-------------|-------|
| Notion | OAuth | [notion-oauth.md](notion-oauth.md) |
| Google Calendar | OAuth | [google-calendar.md](google-calendar.md) |
| Asana | Token | See below |
| Playwright | None | Auto-configured |

## Asana Quick Setup

```bash
claude mcp add asana -s user -e ASANA_ACCESS_TOKEN="your-token-here" -- npx -y @roychri/mcp-server-asana
```

Get your token from: https://app.asana.com/0/developer-console

## Checking MCP Status

```bash
# List all configured MCP servers
claude mcp list

# Test a specific server
claude -p "Search Notion for test"
claude -p "List my calendars"
claude -p "List Asana workspaces"
```

## Common Issues

### Server Not Found

- Restart Claude Code after adding MCP
- Check `claude mcp list` output

### Authentication Errors

- Re-run OAuth flow
- Check token hasn't expired
- Verify permissions granted

### Timeout Errors

- Check network connectivity
- Try removing and re-adding server

## Adding New MCP Servers

1. Find the MCP package (npm, Python, etc.)
2. Add with `claude mcp add`
3. Configure authentication
4. Test with simple query
5. Document in this folder
