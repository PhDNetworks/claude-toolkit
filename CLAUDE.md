# Claude Toolkit

## What
Personal productivity toolkit for Claude Code by Danny Doherty / PhD Networks.
Commands for daily planning, session documentation, git workflows, and autonomous deep work.

## Project Structure
- `commands/` - Slash commands (symlinked to ~/.claude/commands/)
- `scripts/` - Shell scripts (symlinked to ~/bin/)
- `mcp-configs/` - MCP server setup guides
- `docs/` - Extended documentation

## Commands
| Command | Purpose |
|---------|---------|
| `/today` | Daily planning from Asana + Google Calendar |
| `/plan-tomorrow` | Automated tomorrow planning with calendar events + Notion workspaces |
| `/doc-to-notion` | Document sessions to Notion |
| `/ship` | Git commit with conventional format |
| `/deepwork` | Autonomous deep work mode |
| `/auto` | Autonomous task orchestrator (ultrathink + sub-agents) |

## Automation
- **Daily 20:00** - `/plan-tomorrow` runs via launchd (com.phdnetworks.plan-tomorrow)

## Quick Start
```bash
./install.sh        # Install symlinks and aliases
./update.sh         # Pull latest and reinstall
./uninstall.sh      # Remove symlinks
```

## Code Standards
- Shell: Bash, POSIX-compatible where possible
- Markdown: CommonMark standard
- Commits: Conventional format (feat/fix/docs/refactor/chore)

## User Context
- Owner: Danny Doherty, PhD Networks & Systems Ltd (Leeds, UK)
- Stack: WordPress/Elementor, Google Ads, Local SEO
- Clients: JP Electrical, JLR Smith Roofing, Ossett Dental, Wortley Windows, Rodley Carpets
- MCP Servers: Notion (OAuth), Google Calendar (OAuth), Asana (Token), Playwright

## Key Learnings
- Notion MCP: Use OAuth method from https://developers.notion.com/docs/mcp (not API key env var)
- Google Calendar MCP: Requires OAuth credential JSON file setup
- Always test MCP with simple query (`claude -p "list calendars"`) before debugging config

## Adding New Commands
1. Create `commands/new-command.md` with `$ARGUMENTS` placeholder at end
2. Run `./install.sh` to update symlinks
3. Use with `/new-command` in Claude Code
