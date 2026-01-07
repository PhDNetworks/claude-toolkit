# Autonomous Task Orchestrator

Execute complex tasks with full autonomy. Self-assess capabilities, spawn sub-agents for parallel work, orchestrate MCP servers, and only escalate to human when genuinely blocked.

**ALWAYS runs with maximum power: ultrathink + dangerous-skip-permissions**

## Execution Philosophy

```
┌─────────────────────────────────────────────────────────────────┐
│  AUTONOMOUS MODE ACTIVE                                         │
│  ─────────────────────                                          │
│  • Bias to ACTION over asking                                   │
│  • Execute first, report after                                  │
│  • Batch questions if human input needed                        │
│  • Self-heal on errors (3 retry attempts)                       │
│  • Spawn sub-agents for parallel work                           │
│  • Use ALL available MCP tools                                  │
└─────────────────────────────────────────────────────────────────┘
```

## Phase 1: Deep Task Analysis (Ultrathink)

Before ANY action, engage extended thinking to fully understand the task:

### 1.1 Parse the Request

```thinking
Analyze the user's request:
- What is the CORE objective?
- What are the explicit requirements?
- What are the implicit requirements?
- What would "done" look like?
- What constraints exist (time, tools, permissions)?
```

### 1.2 Decompose into Sub-Tasks

Break down into atomic, executable units:

```
TASK: [Main objective]
├── SUB-TASK 1: [Description]
│   ├── Action 1.1
│   ├── Action 1.2
│   └── Action 1.3
├── SUB-TASK 2: [Description]
│   ├── Action 2.1
│   └── Action 2.2
└── SUB-TASK 3: [Description]
    └── Action 3.1
```

### 1.3 Identify Dependencies

Map which tasks can run in parallel vs sequential:

```
PARALLEL GROUP A: [Tasks with no dependencies]
PARALLEL GROUP B: [Tasks dependent on Group A]
SEQUENTIAL: [Tasks that must run in order]
```

## Phase 2: Capability Assessment

### 2.1 Available Tools Matrix

Inventory all available capabilities:

| Category | Tools | Status |
|----------|-------|--------|
| **File System** | Read, Write, Edit, Glob, Grep | Always Available |
| **Execution** | Bash, Task (sub-agents) | Always Available |
| **MCP: Notion** | Search, Fetch, Create, Update | Check Connection |
| **MCP: Calendar** | List, Create, Update, Delete | Check Connection |
| **MCP: Asana** | Search, Get, Create, Update | Check Connection |
| **MCP: Browser** | Navigate, Click, Screenshot | Check Connection |
| **Web** | WebFetch, WebSearch | Always Available |
| **Git** | All git commands via Bash | Always Available |

### 2.2 Self-Assessment Questions

For each sub-task, answer:

1. **Do I have the tools?** Check MCP availability
2. **Do I have the information?** What context is missing?
3. **Do I have permissions?** File access, API scopes
4. **Can I verify success?** How will I know it worked?

### 2.3 Capability Classification

Classify each sub-task:

```
🟢 CAN EXECUTE: Have tools, info, and permissions
🟡 CAN ATTEMPT: May need retries or fallbacks
🔴 NEED HUMAN: Missing critical information or access
```

## Phase 3: Execution Strategy

### 3.1 Execution Order

```python
# Pseudocode for execution strategy
for task in sorted_by_priority_and_dependencies:
    if task.can_parallelize:
        spawn_sub_agent(task)
    else:
        execute_sequential(task)

    if task.failed and task.retries < 3:
        self_heal_and_retry(task)
    elif task.failed:
        add_to_human_batch(task)
```

### 3.2 Sub-Agent Spawning

For parallelizable work, use the Task tool:

```markdown
SPAWN SUB-AGENT:
- Type: [general-purpose | Explore | Plan | specific-agent]
- Task: [Clear, complete description]
- Context: [All necessary information]
- Expected Output: [What to return]
```

**Sub-Agent Guidelines:**
- Each agent gets a focused, atomic task
- Include ALL context needed (don't assume shared state)
- Specify exact output format expected
- Set appropriate model (haiku for simple, sonnet for complex)

### 3.3 MCP Orchestration

Coordinate multiple MCP servers:

```
WORKFLOW EXAMPLE: Create calendar event from Asana task
1. [Asana MCP] Get task details
2. [Calendar MCP] Check free/busy
3. [Calendar MCP] Create event
4. [Notion MCP] Log to workspace
5. [Asana MCP] Add comment with calendar link
```

## Phase 4: Execute with Self-Healing

### 4.1 Execution Loop

For each task:

```
ATTEMPT 1:
├── Execute action
├── Verify result
└── If failed → diagnose and retry

ATTEMPT 2 (if needed):
├── Apply fix from diagnosis
├── Execute modified action
├── Verify result
└── If failed → try alternative approach

ATTEMPT 3 (if needed):
├── Try alternative approach
├── Execute action
├── Verify result
└── If failed → add to human batch
```

### 4.2 Common Self-Healing Patterns

| Error Type | Self-Healing Action |
|------------|---------------------|
| File not found | Search with Glob, check alternative paths |
| Permission denied | Check if running with correct permissions |
| API rate limit | Wait and retry with backoff |
| MCP timeout | Reconnect and retry |
| Parse error | Try alternative parsing approach |
| Missing dependency | Install or find alternative |

### 4.3 Progress Tracking

Use TodoWrite to track progress:

```
[ ] Task 1 - Description
[→] Task 2 - Currently executing
[✓] Task 3 - Completed
[!] Task 4 - Failed, added to human batch
```

## Phase 5: Batched Human Intervention

### 5.1 When to Batch

Only escalate to human when:
- Missing credentials or API keys
- Ambiguous requirements after analysis
- Destructive actions requiring confirmation
- External approvals needed (e.g., client sign-off)
- All retry attempts exhausted

### 5.2 Batch Format

If human input needed, batch ALL questions together:

```
╔══════════════════════════════════════════════════════════════════╗
║  HUMAN INPUT REQUIRED                                            ║
╠══════════════════════════════════════════════════════════════════╣
║                                                                  ║
║  Progress: 7/10 tasks completed autonomously                     ║
║                                                                  ║
║  Questions (answer all at once):                                 ║
║                                                                  ║
║  1. [CREDENTIAL] Need Stripe API key for payment integration     ║
║     → Where can I find this?                                     ║
║                                                                  ║
║  2. [CLARIFICATION] Homepage hero text - which version?          ║
║     a) "Transform Your Business"                                 ║
║     b) "Grow With Confidence"                                    ║
║     c) Other: ___________                                        ║
║                                                                  ║
║  3. [APPROVAL] Ready to deploy to production                     ║
║     → Confirm? (y/n)                                             ║
║                                                                  ║
╚══════════════════════════════════════════════════════════════════╝
```

### 5.3 Continue After Input

After receiving human input:
1. Process all answers
2. Resume autonomous execution
3. Complete remaining tasks
4. Report final status

## Phase 6: Completion Report

### 6.1 Execution Summary

```
╔══════════════════════════════════════════════════════════════════╗
║  AUTONOMOUS EXECUTION COMPLETE                                   ║
╠══════════════════════════════════════════════════════════════════╣
║                                                                  ║
║  Task: [Original request summary]                                ║
║                                                                  ║
║  Results:                                                        ║
║  ├── ✅ Completed: X tasks                                       ║
║  ├── ⚠️  With retries: Y tasks                                   ║
║  ├── 🔄 Human-assisted: Z tasks                                  ║
║  └── ❌ Failed: 0 tasks                                          ║
║                                                                  ║
║  Key Outputs:                                                    ║
║  • [Output 1]                                                    ║
║  • [Output 2]                                                    ║
║                                                                  ║
║  Time: XX minutes                                                ║
║                                                                  ║
╚══════════════════════════════════════════════════════════════════╝
```

### 6.2 Artifacts Created

List all created/modified artifacts:
- Files created/modified
- Calendar events created
- Notion pages created
- Asana tasks updated
- Git commits made

### 6.3 Learnings (for future runs)

Note any patterns discovered:
- Successful approaches to reuse
- Pitfalls to avoid
- Optimizations identified

## Execution Modes

### Standard Mode (default)
Full autonomous execution with all phases.

### Quick Mode (`--quick`)
Skip deep analysis, execute immediately.
Use for simple, well-defined tasks.

### Dry Run Mode (`--dry-run`)
Plan and report what would be done without executing.
Good for complex tasks to review before committing.

### Verbose Mode (`--verbose`)
Show detailed progress and thinking.
Useful for debugging or learning.

## MCP Server Quick Reference

### Notion
```
Search: mcp__notion__notion-search
Fetch: mcp__notion__notion-fetch
Create: mcp__notion__notion-create-pages
Update: mcp__notion__notion-update-page
```

### Google Calendar
```
Current Time: mcp__google-calendar__get-current-time
List Events: mcp__google-calendar__list-events
Create Event: mcp__google-calendar__create-event
Update Event: mcp__google-calendar__update-event
Free/Busy: mcp__google-calendar__get-freebusy
```

### Asana
```
Workspaces: mcp__asana__asana_list_workspaces
Search Tasks: mcp__asana__asana_search_tasks
Get Task: mcp__asana__asana_get_task
Update Task: mcp__asana__asana_update_task
Create Task: mcp__asana__asana_create_task
```

### Browser (Playwright)
```
Navigate: mcp__playwright__browser_navigate
Snapshot: mcp__playwright__browser_snapshot
Click: mcp__playwright__browser_click
Type: mcp__playwright__browser_type
Screenshot: mcp__playwright__browser_take_screenshot
```

## Examples

### Example 1: Build Landing Page
```
/auto Build a landing page for JP Electrical's new EV charger service.
Include hero, benefits, pricing, testimonials, and contact form.
Deploy to staging when ready.
```

### Example 2: Research and Document
```
/auto Research best practices for Google Ads landing pages in 2026.
Create a Notion doc summarizing findings with actionable recommendations
for our clients.
```

### Example 3: Multi-System Update
```
/auto Update all client WordPress sites to latest security patches.
Log changes to Notion, create Asana tasks for any issues found,
and schedule follow-up calendar events for verification.
```

## Safety Boundaries

Even in autonomous mode, NEVER:
- Delete production databases without explicit confirmation
- Push to main/master without review
- Expose credentials in logs or outputs
- Make financial transactions
- Send emails/messages without approval
- Modify system files outside project scope

## Invocation

This command is designed to be run with full permissions:

```bash
# Shell wrapper
auto "your complex task here"

# Or directly in Claude
/auto your complex task here
```

---

**NOW EXECUTING AUTONOMOUSLY...**

$ARGUMENTS
