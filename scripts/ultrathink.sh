#!/bin/bash

# Ultrathink launcher for Claude Code
# Runs Claude with --dangerously-skip-permissions and extended thinking

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

echo -e "${PURPLE}"
echo "  _   _ _ _             _____ _     _       _    "
echo " | | | | | |           |_   _| |   (_)     | |   "
echo " | | | | | |_ _ __ __ _  | | | |__  _ _ __ | | __"
echo " | | | | | __| '__/ _\` | | | | '_ \| | '_ \| |/ /"
echo " | |_| | | |_| | | (_| | | | | | | | | | | |   < "
echo "  \___/|_|\__|_|  \__,_| \_/ |_| |_|_|_| |_|_|\_\\"
echo -e "${NC}"
echo ""
echo -e "${YELLOW}DANGEROUS MODE ACTIVE${NC}"
echo -e "${RED}No permission prompts - Claude will execute autonomously${NC}"
echo ""

# Check if there's a task provided
if [ -z "$1" ]; then
    echo -e "${GREEN}Starting interactive ultrathink session...${NC}"
    echo ""
    claude --dangerously-skip-permissions
else
    echo -e "${GREEN}Task: $@${NC}"
    echo ""
    claude --dangerously-skip-permissions -p "$@"
fi
