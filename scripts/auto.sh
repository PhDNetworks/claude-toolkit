#!/bin/bash
#
# auto.sh
# Autonomous Task Orchestrator for Claude Code
# Runs with maximum power: ultrathink + dangerous-skip-permissions
#
# Usage:
#   auto "complex task description"
#   auto --dry-run "task"    # Plan only, don't execute
#   auto --quick "task"      # Skip deep analysis
#   auto --verbose "task"    # Show detailed progress
#
# Author: Danny Doherty / PhD Networks
# Created: 2026-01-07
#

set -euo pipefail

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TOOLKIT_DIR="$(dirname "$SCRIPT_DIR")"
LOG_DIR="$TOOLKIT_DIR/logs"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="$LOG_DIR/auto-$TIMESTAMP.log"

# Ensure log directory exists
mkdir -p "$LOG_DIR"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
BOLD='\033[1m'
NC='\033[0m'

# Parse flags
DRY_RUN=false
QUICK=false
VERBOSE=false
TASK=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        --quick)
            QUICK=true
            shift
            ;;
        --verbose)
            VERBOSE=true
            shift
            ;;
        --help|-h)
            echo "Usage: auto [OPTIONS] \"task description\""
            echo ""
            echo "Options:"
            echo "  --dry-run    Plan only, don't execute"
            echo "  --quick      Skip deep analysis"
            echo "  --verbose    Show detailed progress"
            echo "  --help       Show this help"
            exit 0
            ;;
        *)
            TASK="$1"
            shift
            ;;
    esac
done

# Logging function
log() {
    local level="$1"
    local message="$2"
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] [$level] $message" >> "$LOG_FILE"

    if [ "$VERBOSE" = true ] || [ "$level" = "ERROR" ] || [ "$level" = "OK" ]; then
        case "$level" in
            INFO)  echo -e "${BLUE}[INFO]${NC} $message" ;;
            OK)    echo -e "${GREEN}[OK]${NC} $message" ;;
            WARN)  echo -e "${YELLOW}[WARN]${NC} $message" ;;
            ERROR) echo -e "${RED}[ERROR]${NC} $message" ;;
            DEBUG) echo -e "${CYAN}[DEBUG]${NC} $message" ;;
        esac
    fi
}

# ASCII Art Header
show_header() {
    echo ""
    echo -e "${MAGENTA}${BOLD}"
    cat << 'EOF'
    ╔═══════════════════════════════════════════════════════════════════╗
    ║                                                                   ║
    ║     █████╗ ██╗   ██╗████████╗ ██████╗                            ║
    ║    ██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗                           ║
    ║    ███████║██║   ██║   ██║   ██║   ██║                           ║
    ║    ██╔══██║██║   ██║   ██║   ██║   ██║                           ║
    ║    ██║  ██║╚██████╔╝   ██║   ╚██████╔╝                           ║
    ║    ╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝                            ║
    ║                                                                   ║
    ║    AUTONOMOUS TASK ORCHESTRATOR                                   ║
    ║    ═══════════════════════════                                    ║
    ║    • Full Autonomy Mode                                           ║
    ║    • Ultrathink Enabled                                           ║
    ║    • Sub-Agent Spawning                                           ║
    ║    • MCP Orchestration                                            ║
    ║                                                                   ║
    ╚═══════════════════════════════════════════════════════════════════╝
EOF
    echo -e "${NC}"
    echo ""
}

# Show execution mode
show_mode() {
    echo -e "${CYAN}┌─────────────────────────────────────────────────────────────────┐${NC}"
    echo -e "${CYAN}│${NC}  ${BOLD}Execution Mode:${NC}"

    if [ "$DRY_RUN" = true ]; then
        echo -e "${CYAN}│${NC}    ${YELLOW}▸ DRY RUN${NC} - Planning only, no execution"
    elif [ "$QUICK" = true ]; then
        echo -e "${CYAN}│${NC}    ${GREEN}▸ QUICK${NC} - Immediate execution, minimal analysis"
    else
        echo -e "${CYAN}│${NC}    ${GREEN}▸ FULL AUTONOMOUS${NC} - Deep analysis + execution"
    fi

    if [ "$VERBOSE" = true ]; then
        echo -e "${CYAN}│${NC}    ${BLUE}▸ VERBOSE${NC} - Detailed output enabled"
    fi

    echo -e "${CYAN}│${NC}"
    echo -e "${CYAN}│${NC}  ${BOLD}Task:${NC}"
    echo -e "${CYAN}│${NC}    $TASK"
    echo -e "${CYAN}│${NC}"
    echo -e "${CYAN}│${NC}  ${BOLD}Log:${NC} $LOG_FILE"
    echo -e "${CYAN}└─────────────────────────────────────────────────────────────────┘${NC}"
    echo ""
}

# Main execution
main() {
    show_header

    # Validate task provided
    if [ -z "$TASK" ]; then
        echo -e "${RED}Error: No task provided${NC}"
        echo ""
        echo "Usage: auto \"your complex task here\""
        echo ""
        echo "Examples:"
        echo "  auto \"Build a landing page for JP Electrical\""
        echo "  auto --dry-run \"Refactor the authentication module\""
        echo "  auto --quick \"Fix the typo in README.md\""
        echo ""
        exit 1
    fi

    show_mode

    log "INFO" "Starting autonomous execution"
    log "INFO" "Task: $TASK"
    log "INFO" "Mode: dry_run=$DRY_RUN quick=$QUICK verbose=$VERBOSE"

    # Check if claude is available
    if ! command -v claude &> /dev/null; then
        log "ERROR" "Claude CLI not found. Please install Claude Code."
        exit 1
    fi

    # Build the prompt with mode flags
    PROMPT="/auto"

    if [ "$DRY_RUN" = true ]; then
        PROMPT="$PROMPT --dry-run"
    fi

    if [ "$QUICK" = true ]; then
        PROMPT="$PROMPT --quick"
    fi

    if [ "$VERBOSE" = true ]; then
        PROMPT="$PROMPT --verbose"
    fi

    PROMPT="$PROMPT

$TASK"

    log "INFO" "Executing with dangerous-skip-permissions..."
    echo -e "${GREEN}▶ Engaging autonomous mode...${NC}"
    echo ""

    # Run Claude with full autonomy
    {
        claude --dangerously-skip-permissions -p "$PROMPT" 2>&1 | tee -a "$LOG_FILE"
        EXIT_CODE=${PIPESTATUS[0]}
    } || EXIT_CODE=$?

    echo ""

    if [ $EXIT_CODE -eq 0 ]; then
        log "OK" "Autonomous execution completed successfully"
        echo ""
        echo -e "${GREEN}╔══════════════════════════════════════════════════════════════════╗${NC}"
        echo -e "${GREEN}║${NC}  ${BOLD}✅ AUTONOMOUS EXECUTION COMPLETE${NC}                                ${GREEN}║${NC}"
        echo -e "${GREEN}║${NC}                                                                  ${GREEN}║${NC}"
        echo -e "${GREEN}║${NC}  Log: $LOG_FILE"
        echo -e "${GREEN}╚══════════════════════════════════════════════════════════════════╝${NC}"
    else
        log "ERROR" "Autonomous execution failed with exit code: $EXIT_CODE"
        echo ""
        echo -e "${RED}╔══════════════════════════════════════════════════════════════════╗${NC}"
        echo -e "${RED}║${NC}  ${BOLD}❌ EXECUTION FAILED${NC} (exit code: $EXIT_CODE)                        ${RED}║${NC}"
        echo -e "${RED}║${NC}                                                                  ${RED}║${NC}"
        echo -e "${RED}║${NC}  Check log: $LOG_FILE"
        echo -e "${RED}╚══════════════════════════════════════════════════════════════════╝${NC}"
        exit $EXIT_CODE
    fi

    # Cleanup old logs (keep last 30 days)
    find "$LOG_DIR" -name "auto-*.log" -mtime +30 -delete 2>/dev/null || true

    log "INFO" "Execution complete"
}

# Run main
main
