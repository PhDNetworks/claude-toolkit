# Claude Code Commands

Custom slash commands for Claude Code productivity.

## Available Commands

| Command | File | Description |
|---------|------|-------------|
| `/today` | today.md | Daily planning from Asana + Google Calendar |
| `/doc-to-notion` | doc-to-notion.md | Document sessions to Notion |
| `/ship` | ship.md | Git commit with conventional format |
| `/ultrathink` | ultrathink.md | Autonomous deep work mode |

## Installation

These commands are installed via the main `install.sh` script which creates symlinks from `~/.claude/commands/` to this directory.

## Usage

In any Claude Code session:
```
/today
/doc-to-notion
/ship --no-push
/ultrathink "build the new feature"
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
- **doc-to-notion.md**: Notion MCP
- **ship.md**: Git (no MCP needed)
- **ultrathink.md**: No dependencies
