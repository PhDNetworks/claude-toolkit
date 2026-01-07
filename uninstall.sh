#!/bin/bash

# Claude Toolkit Uninstaller
# Removes symlinks and optionally removes aliases

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}"
echo "╔═══════════════════════════════════════════╗"
echo "║       Claude Toolkit Uninstaller          ║"
echo "╚═══════════════════════════════════════════╝"
echo -e "${NC}"

# Remove command symlinks
echo -e "${YELLOW}Removing commands...${NC}"

COMMANDS=("today.md" "doc-to-notion.md" "ship.md" "ultrathink.md")

for cmd in "${COMMANDS[@]}"; do
    if [ -L "$HOME/.claude/commands/$cmd" ]; then
        rm "$HOME/.claude/commands/$cmd"
        echo -e "  ${GREEN}✓${NC} Removed $cmd"
    else
        echo -e "  ${YELLOW}-${NC} $cmd not found"
    fi
done

echo ""

# Remove script symlink
echo -e "${YELLOW}Removing scripts...${NC}"

if [ -L "$HOME/bin/ultrathink.sh" ]; then
    rm "$HOME/bin/ultrathink.sh"
    echo -e "  ${GREEN}✓${NC} Removed ultrathink.sh"
else
    echo -e "  ${YELLOW}-${NC} ultrathink.sh not found"
fi

echo ""

# Ask about aliases
echo -e "${YELLOW}Shell aliases${NC}"
echo "The following aliases may exist in ~/.zshrc:"
echo "  - ultrathink"
echo "  - claude-toolkit"
echo ""
read -p "Remove aliases from ~/.zshrc? (y/N) " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Create backup
    cp ~/.zshrc ~/.zshrc.backup

    # Remove lines (macOS compatible)
    grep -v 'alias ultrathink=' ~/.zshrc > ~/.zshrc.tmp && mv ~/.zshrc.tmp ~/.zshrc
    grep -v 'alias claude-toolkit=' ~/.zshrc > ~/.zshrc.tmp && mv ~/.zshrc.tmp ~/.zshrc
    grep -v '# Claude Toolkit' ~/.zshrc > ~/.zshrc.tmp && mv ~/.zshrc.tmp ~/.zshrc

    echo -e "  ${GREEN}✓${NC} Removed aliases (backup at ~/.zshrc.backup)"
else
    echo -e "  ${YELLOW}-${NC} Aliases kept"
fi

echo ""

# Ask about repo deletion
echo -e "${YELLOW}Repository${NC}"
read -p "Delete the claude-toolkit repository? (y/N) " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    echo -e "  ${RED}This will delete: $SCRIPT_DIR${NC}"
    read -p "Are you sure? (y/N) " -n 1 -r
    echo ""

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf "$SCRIPT_DIR"
        echo -e "  ${GREEN}✓${NC} Repository deleted"
    else
        echo -e "  ${YELLOW}-${NC} Repository kept"
    fi
else
    echo -e "  ${YELLOW}-${NC} Repository kept"
fi

echo ""
echo -e "${GREEN}════════════════════════════════════════════${NC}"
echo -e "${GREEN}Uninstall complete!${NC}"
echo -e "${GREEN}════════════════════════════════════════════${NC}"
echo ""
echo -e "Run ${YELLOW}source ~/.zshrc${NC} to reload your shell"
echo ""
