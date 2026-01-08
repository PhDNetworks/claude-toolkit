# Claude Code Commands

Custom slash commands for Claude Code productivity.

## Available Commands

| Command | File | Description |
|---------|------|-------------|
| `/today` | today.md | Daily planning from Asana + Google Calendar |
| `/plan-tomorrow` | plan-tomorrow.md | Auto-schedule tomorrow with calendar events + Notion |
| `/doc-to-notion` | doc-to-notion.md | Document sessions to Notion (auto-detects source machine) |
| `/ship` | ship.md | Git commit with conventional format |
| `/deepwork` | deepwork.md | Autonomous deep work mode |
| `/auto` | auto.md | Autonomous task orchestrator with ultrathink |

## Features

### Machine Detection (`/doc-to-notion`)

Automatically detects whether you're on MacBook Pro or Windows Workhorse (WSL) and tags Notion documentation accordingly:
- 🍎 MacBook Pro
- 🪟 Windows Workhorse (WSL)
- 💻 Unknown hostname

## Installation

These commands are installed via the main `install.sh` script which creates symlinks from `~/.claude/commands/` to this directory.

## Usage

In any Claude Code session:
```
/today
/plan-tomorrow
/doc-to-notion
/ship --no-push
/deepwork "build the new feature"
/auto "complete the API integration"
```

## Creating New Commands

1. Create a new `.md` file in this directory
2. Include clear instructions for Claude
3. End with `$ARGUMENTS` to accept parameters
4. Run `../install.sh` to create the symlink

## Command Structure

Each command file should include:
- Clear purpose statement
- Step-by-step workflow
- Expected output format
- Any options/flags
- `$ARGUMENTS` placeholder at the end

## Requirements

Commands may require MCP servers to be configured:
- **today.md**: Asana MCP, Google Calendar MCP
- **plan-tomorrow.md**: Asana MCP, Google Calendar MCP, Notion MCP
- **doc-to-notion.md**: Notion MCP
- **ship.md**: Git (no MCP needed)
- **deepwork.md**: No dependencies
- **auto.md**: No dependencies (uses ultrathink mode)
