# Document Work to Notion

Document the current Claude Code session to Danny's Notion workspace for future reference and project tracking.

## Machine Detection

First, detect the source machine to tag the documentation appropriately:

```bash
# Get hostname and determine machine type
HOSTNAME=$(hostname)
case "$HOSTNAME" in
  *MacBook*|*macbook*|*MBP*|PhD-Mac*|*phdnetworks*)
    MACHINE_EMOJI="🍎"
    MACHINE_NAME="MacBook Pro"
    ;;
  *PhD-Laptop*|*DESKTOP*|*laptop*|*WSL*)
    MACHINE_EMOJI="🪟"
    MACHINE_NAME="Windows Workhorse (WSL)"
    ;;
  *)
    MACHINE_EMOJI="💻"
    MACHINE_NAME="$HOSTNAME"
    ;;
esac
```

Run this detection and use the results throughout the documentation.

## What to Extract

Analyse the current session and extract:

### 1. Work Completed
- Code written/modified
- Files created/updated
- Problems solved
- Commands executed

### 2. Decisions Made
- Technical choices and rationale
- Architecture decisions
- Client-related decisions

### 3. Learnings
- New techniques discovered
- Gotchas encountered
- Reusable patterns identified

### 4. Next Steps
- Outstanding work
- Follow-up tasks (create as Asana tasks if actionable)
- Dependencies or blockers

## Documentation Structure

Create a Notion page with this structure:

**Title format:** `📅 Session: [DATE] — [BRIEF_DESCRIPTION] [MACHINE_EMOJI]`

**Properties/Metadata:**
- Tags: `automation`, `session-log`, relevant tech tags
- Source Machine: [MACHINE_NAME]
- Hostname: [HOSTNAME]

**Content:**

```markdown
## Summary
[2-3 sentence overview of what was accomplished]
Source: [MACHINE_EMOJI] [MACHINE_NAME]

## Work Log
| Time | Action | Outcome |
|------|--------|---------|
| ... | ... | ... |

## Code Changes
- `filename.ext` - [what changed and why]

## Technical Notes
[Important technical details for future reference]

## Client Impact
[How this affects the client/project - useful for updates]

## Action Items
- [ ] Task 1
- [ ] Task 2

## Related
- Links to relevant docs/resources used
- Related Notion pages

---
Documented via /doc-to-notion 🤖
Source: [MACHINE_EMOJI] [MACHINE_NAME] ([HOSTNAME])
```

## Auto-Tagging

Tag entries with:
- **Client**: JP Electrical, JLR Smith Roofing, Ossett Dental, Wortley Windows, Rodley Carpets, DOAB
- **Project type**: `google-ads`, `wordpress`, `seo`, `hosting`, `automation`, `membership`
- **Status**: `in-progress`, `completed`, `blocked`
- **Priority**: `high`, `medium`, `low`
- **Source**: `macbook`, `windows-wsl`

## Notion Location

Save to: **PhD Networks Command Centre > Knowledge Base > Session Logs**
(Or appropriate client/project subfolder if session is project-specific)

## Instructions

1. Run the machine detection bash command first
2. Review the current terminal session, git history, and any files modified
3. Extract the key information and create a comprehensive but concise session document
4. Include the machine source prominently so it's clear where the work was done
5. Add the footer with source machine details

$ARGUMENTS
