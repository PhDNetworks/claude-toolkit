# Changelog

All notable changes to this project.

## [1.0.0] - 2026-01-07

### Added
- Initial release
- Four slash commands:
  - `/today` - Daily planning from Asana + Calendar
  - `/doc-to-notion` - Session documentation
  - `/ship` - Git commit workflow
  - `/ultrathink` - Autonomous deep work mode
- Shell scripts:
  - `ultrathink.sh` - Launcher for autonomous mode
- Installation scripts:
  - `install.sh` - One-command setup
  - `update.sh` - Pull and reinstall
  - `uninstall.sh` - Clean removal
- MCP configuration guides:
  - Notion OAuth setup
  - Google Calendar setup
  - Asana token setup
- Documentation:
  - Full setup guide
  - Troubleshooting guide
  - MCP setup guide
- Optimized CLAUDE.md following best practices

### Technical
- Symlink-based installation (updates flow through)
- Zsh alias integration
- MIT licensed

---

## Version Format

This project uses [Semantic Versioning](https://semver.org/):
- MAJOR: Breaking changes
- MINOR: New features, backward compatible
- PATCH: Bug fixes, backward compatible
