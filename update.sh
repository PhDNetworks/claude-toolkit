#!/bin/bash

# Claude Toolkit Updater
# Pulls latest changes and re-runs install

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}"
echo "╔═══════════════════════════════════════════╗"
echo "║       Claude Toolkit Updater              ║"
echo "╚═══════════════════════════════════════════╝"
echo -e "${NC}"

cd "$SCRIPT_DIR"

# Check for changes before pull
echo -e "${YELLOW}Checking for updates...${NC}"

git fetch origin

LOCAL=$(git rev-parse HEAD)
REMOTE=$(git rev-parse @{u} 2>/dev/null || echo "$LOCAL")

if [ "$LOCAL" = "$REMOTE" ]; then
    echo -e "${GREEN}Already up to date!${NC}"
    echo ""
    exit 0
fi

# Pull latest
echo -e "${YELLOW}Pulling latest changes...${NC}"
git pull origin main

echo ""

# Show what changed
echo -e "${YELLOW}Recent changes:${NC}"
git log --oneline -5

echo ""

# Re-run install
echo -e "${YELLOW}Re-running install...${NC}"
./install.sh

echo ""
echo -e "${GREEN}Update complete!${NC}"
