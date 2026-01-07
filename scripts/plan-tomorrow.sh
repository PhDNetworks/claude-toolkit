#!/bin/bash
#
# plan-tomorrow.sh
# Wrapper script for /plan-tomorrow slash command
# Runs Claude Code in autonomous mode to plan tomorrow's schedule
#
# Usage:
#   plan-tomorrow              # Interactive planning
#   plan-tomorrow "context"    # With additional context
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
LOG_FILE="$LOG_DIR/plan-tomorrow-$TIMESTAMP.log"

# Ensure log directory exists
mkdir -p "$LOG_DIR"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging function
log() {
    local level="$1"
    local message="$2"
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] [$level] $message" >> "$LOG_FILE"

    case "$level" in
        INFO)  echo -e "${BLUE}[INFO]${NC} $message" ;;
        OK)    echo -e "${GREEN}[OK]${NC} $message" ;;
        WARN)  echo -e "${YELLOW}[WARN]${NC} $message" ;;
        ERROR) echo -e "${RED}[ERROR]${NC} $message" ;;
    esac
}

# Header
echo ""
echo "=================================================="
echo "  📅 PLAN TOMORROW - Autonomous Planning Mode"
echo "=================================================="
echo ""

log "INFO" "Starting plan-tomorrow execution"
log "INFO" "Log file: $LOG_FILE"

# Check if claude is available
if ! command -v claude &> /dev/null; then
    log "ERROR" "Claude CLI not found. Please install Claude Code."
    exit 1
fi

# Build the prompt
PROMPT="/plan-tomorrow"

# Add any additional context from arguments
if [ $# -gt 0 ]; then
    CONTEXT="$*"
    PROMPT="$PROMPT

Additional context: $CONTEXT"
    log "INFO" "Additional context provided: $CONTEXT"
fi

log "INFO" "Executing Claude with autonomous permissions..."
echo ""

# Run Claude in autonomous mode
# Capture both stdout and stderr, display in real-time, and log
{
    claude --dangerously-skip-permissions -p "$PROMPT" 2>&1 | tee -a "$LOG_FILE"
    EXIT_CODE=${PIPESTATUS[0]}
} || EXIT_CODE=$?

echo ""

if [ $EXIT_CODE -eq 0 ]; then
    log "OK" "Plan tomorrow completed successfully"
    echo ""
    echo "=================================================="
    echo "  ✅ Planning Complete"
    echo "  📄 Log: $LOG_FILE"
    echo "=================================================="
else
    log "ERROR" "Plan tomorrow failed with exit code: $EXIT_CODE"
    echo ""
    echo "=================================================="
    echo "  ❌ Planning Failed (exit code: $EXIT_CODE)"
    echo "  📄 Check log: $LOG_FILE"
    echo "=================================================="
    exit $EXIT_CODE
fi

# Cleanup old logs (keep last 30 days)
find "$LOG_DIR" -name "plan-tomorrow-*.log" -mtime +30 -delete 2>/dev/null || true

log "INFO" "Execution complete"
