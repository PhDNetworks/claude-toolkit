# Claude Toolkit

Personal productivity toolkit for Claude Code. Commands for daily planning, session documentation, git workflows, and autonomous deep work.

By **Danny Doherty** / [PhD Networks & Systems Ltd](https://phdnetworks.co.uk)

## Quick Start

```bash
# Clone
git clone https://github.com/PhDNetworks/claude-toolkit.git ~/Projects/claude-toolkit
cd ~/Projects/claude-toolkit

# Install
./install.sh

# Reload shell
source ~/.zshrc

# Use
claude
/today
```

## Features

| Command | Description |
|---------|-------------|
| `/today` | Generate daily plan from Asana tasks + Google Calendar |
| `/doc-to-notion` | Document Claude Code session to Notion |
| `/ship` | Smart git commit with conventional format |
| `/ultrathink` | Activate autonomous deep work mode |

### Shell Commands

| Command | Description |
|---------|-------------|
| `ultrathink` | Launch Claude in autonomous mode |
| `ultrathink "task"` | Run single task autonomously |
| `claude-toolkit` | Navigate to toolkit directory |

## Installation

### Prerequisites

- macOS or Linux
- [Claude Code CLI](https://claude.ai/code)
- Git

### Install

```bash
./install.sh
```

This creates symlinks (not copies) so updates flow through automatically:
- `~/.claude/commands/` → `commands/`
- `~/bin/ultrathink.sh` → `scripts/ultrathink.sh`

### Update

```bash
./update.sh
# or
cd ~/Projects/claude-toolkit && git pull && ./install.sh
```

### Uninstall

```bash
./uninstall.sh
```

## MCP Server Configuration

For full functionality, configure these MCP servers:

| Server | Required For | Setup Guide |
|--------|--------------|-------------|
| Notion | `/doc-to-notion` | [mcp-configs/notion-oauth.md](mcp-configs/notion-oauth.md) |
| Google Calendar | `/today` | [mcp-configs/google-calendar.md](mcp-configs/google-calendar.md) |
| Asana | `/today` | [mcp-configs/README.md](mcp-configs/README.md) |

### Quick Asana Setup

```bash
claude mcp add asana -s user -e ASANA_ACCESS_TOKEN="your-token" -- npx -y @roychri/mcp-server-asana
```

## Project Structure

```
claude-toolkit/
├── CLAUDE.md              # Project context for Claude
├── README.md              # This file
├── install.sh             # One-command installation
├── update.sh              # Pull latest & reinstall
├── uninstall.sh           # Clean removal
├── commands/              # Slash commands
│   ├── today.md
│   ├── doc-to-notion.md
│   ├── ship.md
│   └── ultrathink.md
├── scripts/               # Shell scripts
│   └── ultrathink.sh
├── mcp-configs/           # MCP server setup guides
├── templates/             # Reusable templates
└── docs/                  # Extended documentation
    ├── setup.md
    ├── troubleshooting.md
    ├── mcp-setup.md
    └── changelog.md
```

## Customization

### Adding New Commands

1. Create `commands/new-command.md`
2. End file with `$ARGUMENTS` placeholder
3. Run `./install.sh`
4. Use with `/new-command` in Claude Code

### Command Template

```markdown
# Command Name

Clear description of what this command does.

## Steps
1. Step one
2. Step two

## Output Format
Description of expected output

$ARGUMENTS
```

## Troubleshooting

See [docs/troubleshooting.md](docs/troubleshooting.md) for common issues.

### Quick Fixes

```bash
# Commands not appearing
./install.sh && source ~/.zshrc

# MCP errors
claude mcp list
claude -p "test notion search"

# Permission issues
chmod +x *.sh scripts/*.sh
```

## Contributing

1. Fork the repository
2. Create feature branch: `git checkout -b feat/new-command`
3. Commit changes: `git commit -m "feat: add new command"`
4. Push: `git push origin feat/new-command`
5. Open Pull Request

## License

MIT License - see [LICENSE](LICENSE)

## Acknowledgments

- [Claude Code Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)
- [HumanLayer: Writing a Good CLAUDE.md](https://www.humanlayer.dev/blog/writing-a-good-claude-md)
- [awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code)

---

Built with Claude Code
