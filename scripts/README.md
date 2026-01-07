# Shell Scripts

Utility scripts for Claude Code workflows.

## Available Scripts

| Script | Description |
|--------|-------------|
| `ultrathink.sh` | Launch Claude in autonomous mode with extended thinking |

## Installation

Scripts are symlinked to `~/bin/` via the main `install.sh` script.

## Usage

### ultrathink.sh

```bash
# Interactive session
ultrathink

# With a specific task
ultrathink "Build the landing page for JP Electrical"
```

This launches Claude Code with `--dangerously-skip-permissions` flag, enabling:
- No permission prompts
- Autonomous execution
- Extended thinking
- Full tool access

## Creating New Scripts

1. Add your script to this directory
2. Make it executable: `chmod +x script-name.sh`
3. Add symlink logic to `../install.sh`
4. Document usage in this README
