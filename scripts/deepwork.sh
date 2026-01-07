#!/bin/bash

# Deepwork launcher for Claude Code
# Runs Claude with --dangerously-skip-permissions for autonomous execution
# Note: Claude's native extended thinking (ultrathink) activates automatically for complex tasks

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}"
echo "  ____                                      _    "
echo " |  _ \  ___  ___ _ ____      _____  _ __| | __"
echo " | | | |/ _ \/ _ \ '_ \ \ /\ / / _ \| '__| |/ /"
echo " | |_| |  __/  __/ |_) \ V  V / (_) | |  |   < "
echo " |____/ \___|\___| .__/ \_/\_/ \___/|_|  |_|\_\\"
echo "                 |_|                            "
echo -e "${NC}"
echo ""
echo -e "${YELLOW}AUTONOMOUS MODE ACTIVE${NC}"
echo -e "${RED}No permission prompts - Claude will execute autonomously${NC}"
echo -e "${GREEN}Extended thinking activates automatically for complex tasks${NC}"
echo ""

# Check if there's a task provided
if [ -z "$1" ]; then
    echo -e "${GREEN}Starting interactive deepwork session...${NC}"
    echo ""
    claude --dangerously-skip-permissions
else
    echo -e "${GREEN}Task: $@${NC}"
    echo ""
    claude --dangerously-skip-permissions -p "$@"
fi
