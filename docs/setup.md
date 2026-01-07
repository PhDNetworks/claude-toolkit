# Full Setup Guide

Complete guide to setting up the Claude Toolkit.

## Prerequisites

- macOS or Linux
- [Claude Code CLI](https://claude.ai/code) installed
- Git installed
- Zsh shell (default on macOS)

## Installation

### 1. Clone the Repository

```bash
cd ~/Projects
git clone https://github.com/PhDNetworks/claude-toolkit.git
cd claude-toolkit
```

### 2. Run Install Script

```bash
./install.sh
```

This will:
- Create symlinks for all commands
- Add ultrathink.sh to ~/bin/
- Add aliases to ~/.zshrc
- Verify installation

### 3. Reload Shell

```bash
source ~/.zshrc
```

### 4. Configure MCP Servers

For full functionality, configure:
- Notion MCP (see `mcp-configs/notion-oauth.md`)
- Google Calendar MCP (see `mcp-configs/google-calendar.md`)
- Asana MCP (see `mcp-configs/README.md`)

## Verification

```bash
# Check commands are available
ls -la ~/.claude/commands/

# Check ultrathink alias
which ultrathink

# Test a command
claude
/today
```

## Updating

```bash
cd ~/Projects/claude-toolkit
./update.sh
```

## Uninstalling

```bash
cd ~/Projects/claude-toolkit
./uninstall.sh
```

## Directory Structure

After installation:

```
~/Projects/claude-toolkit/     # This repo
~/.claude/commands/            # Symlinks to commands/
~/bin/ultrathink.sh            # Symlink to scripts/ultrathink.sh
```

## Troubleshooting

See `troubleshooting.md` for common issues.
