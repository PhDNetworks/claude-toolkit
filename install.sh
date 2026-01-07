#!/bin/bash

# Claude Toolkit Installer
# Creates symlinks and configures aliases for Claude Code productivity tools

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}"
echo "╔═══════════════════════════════════════════╗"
echo "║       Claude Toolkit Installer            ║"
echo "║       PhD Networks & Systems Ltd          ║"
echo "╚═══════════════════════════════════════════╝"
echo -e "${NC}"

# Check dependencies
echo -e "${YELLOW}Checking dependencies...${NC}"

if ! command -v git &> /dev/null; then
    echo -e "${RED}Error: git is not installed${NC}"
    exit 1
fi
echo -e "  ${GREEN}✓${NC} git"

if ! command -v claude &> /dev/null; then
    echo -e "${RED}Error: claude CLI is not installed${NC}"
    echo "  Install from: https://claude.ai/code"
    exit 1
fi
echo -e "  ${GREEN}✓${NC} claude"

echo ""

# Create directories if needed
echo -e "${YELLOW}Creating directories...${NC}"

mkdir -p ~/.claude/commands
echo -e "  ${GREEN}✓${NC} ~/.claude/commands/"

mkdir -p ~/bin
echo -e "  ${GREEN}✓${NC} ~/bin/"

echo ""

# Create symlinks for commands
echo -e "${YELLOW}Installing commands...${NC}"

COMMANDS=("today.md" "doc-to-notion.md" "ship.md" "ultrathink.md")

for cmd in "${COMMANDS[@]}"; do
    if [ -L "$HOME/.claude/commands/$cmd" ]; then
        rm "$HOME/.claude/commands/$cmd"
    fi
    ln -s "$SCRIPT_DIR/commands/$cmd" "$HOME/.claude/commands/$cmd"
    echo -e "  ${GREEN}✓${NC} $cmd"
done

echo ""

# Create symlink for ultrathink.sh
echo -e "${YELLOW}Installing scripts...${NC}"

chmod +x "$SCRIPT_DIR/scripts/ultrathink.sh"

if [ -L "$HOME/bin/ultrathink.sh" ]; then
    rm "$HOME/bin/ultrathink.sh"
fi
ln -s "$SCRIPT_DIR/scripts/ultrathink.sh" "$HOME/bin/ultrathink.sh"
echo -e "  ${GREEN}✓${NC} ultrathink.sh"

echo ""

# Add to .zshrc if not present
echo -e "${YELLOW}Configuring shell...${NC}"

ZSHRC="$HOME/.zshrc"

# PATH addition
if ! grep -q 'export PATH="\$HOME/bin:\$PATH"' "$ZSHRC" 2>/dev/null; then
    echo '' >> "$ZSHRC"
    echo '# Claude Toolkit' >> "$ZSHRC"
    echo 'export PATH="$HOME/bin:$PATH"' >> "$ZSHRC"
    echo -e "  ${GREEN}✓${NC} Added ~/bin to PATH"
else
    echo -e "  ${GREEN}✓${NC} PATH already configured"
fi

# Ultrathink alias
if ! grep -q 'alias ultrathink=' "$ZSHRC" 2>/dev/null; then
    echo 'alias ultrathink="~/bin/ultrathink.sh"' >> "$ZSHRC"
    echo -e "  ${GREEN}✓${NC} Added ultrathink alias"
else
    echo -e "  ${GREEN}✓${NC} ultrathink alias exists"
fi

# claude-toolkit alias
if ! grep -q 'alias claude-toolkit=' "$ZSHRC" 2>/dev/null; then
    echo 'alias claude-toolkit="cd ~/Projects/claude-toolkit"' >> "$ZSHRC"
    echo -e "  ${GREEN}✓${NC} Added claude-toolkit alias"
else
    echo -e "  ${GREEN}✓${NC} claude-toolkit alias exists"
fi

echo ""
echo -e "${GREEN}════════════════════════════════════════════${NC}"
echo -e "${GREEN}Installation complete!${NC}"
echo -e "${GREEN}════════════════════════════════════════════${NC}"
echo ""
echo -e "Run ${YELLOW}source ~/.zshrc${NC} to reload your shell"
echo ""
echo -e "${BLUE}Available commands:${NC}"
echo "  /today          - Daily planning from Asana + Calendar"
echo "  /doc-to-notion  - Document sessions to Notion"
echo "  /ship           - Git commit with conventional format"
echo "  /ultrathink     - Autonomous deep work mode"
echo ""
echo -e "${BLUE}Shell commands:${NC}"
echo "  ultrathink      - Launch autonomous mode"
echo "  claude-toolkit  - Go to toolkit directory"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "  1. source ~/.zshrc"
echo "  2. Configure MCP servers (see mcp-configs/)"
echo "  3. Start Claude Code and try /today"
echo ""
