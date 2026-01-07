# Notion MCP Setup (OAuth Method)

The recommended way to set up Notion MCP for Claude Code.

## Why OAuth?

The old method using `NOTION_API_KEY` environment variable is unreliable. The OAuth method is officially supported by Notion.

## Setup Steps

### 1. Remove Old Config (if exists)

```bash
claude mcp remove notion -s user
```

### 2. Visit Official Docs

Go to: https://developers.notion.com/docs/mcp

### 3. Follow OAuth Flow

1. Click the setup link in Notion's docs
2. Authorize with your Notion workspace
3. Select which pages/databases to share
4. Complete the OAuth flow

### 4. Verify Installation

```bash
claude -p "Search Notion for PhD Networks"
```

If working, you'll see search results from your workspace.

## Troubleshooting

### 401 Unauthorized Errors

- Remove and re-add the MCP server
- Ensure you authorized the correct workspace
- Check that pages are shared with the integration

### No Results

- Verify pages are shared with the Notion integration
- Check workspace permissions in Notion settings

### MCP Not Found

- Restart Claude Code after setup
- Check `claude mcp list` for installed servers

## Related

- [Notion MCP Official Docs](https://developers.notion.com/docs/mcp)
- See also: `google-calendar.md` for Calendar setup
