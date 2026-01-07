# Google Calendar MCP Setup

Setup guide for Google Calendar MCP server with Claude Code.

## Package

Using `@cocal/google-calendar-mcp`

## Setup Steps

### 1. Create Google Cloud Project

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create new project or select existing
3. Enable Google Calendar API

### 2. Create OAuth Credentials

1. Go to APIs & Services > Credentials
2. Create OAuth 2.0 Client ID
3. Application type: Desktop app
4. Download JSON file

### 3. Add MCP Server

```bash
claude mcp add google-calendar -s user -- npx -y @cocal/google-calendar-mcp
```

### 4. Configure Credentials

Place the downloaded JSON file in the location specified by the MCP server (usually `~/.config/` or similar).

### 5. Authorize

First run will open browser for OAuth authorization. Grant access to your calendar.

### 6. Verify

```bash
claude -p "List my calendars"
```

## Troubleshooting

### No Calendars Found

- Check OAuth credentials are valid
- Verify Calendar API is enabled in Google Cloud
- Re-authorize if token expired

### Permission Errors

- Ensure calendar access scope is granted
- Check Google account settings for app access

## Available Commands

Once configured, you can:
- List calendars
- List events for date range
- Create events
- Search events
- Get free/busy information

## Related

- [Google Calendar API Docs](https://developers.google.com/calendar)
- See also: `notion-oauth.md` for Notion setup
