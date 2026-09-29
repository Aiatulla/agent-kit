#!/usr/bin/env bash
# =============================================================================
# task.sh — Run a task with full context auto-injected
# Usage: ./scripts/task.sh "Create a ProductCard component"
# Usage: AGENT=frontend ./scripts/task.sh "Create a ProductCard component"
# Usage: ./scripts/task.sh -f task.md
# =============================================================================

set -euo pipefail

AGENT="${AGENT:-orchestrator}"
TASK=""
TASK_FILE=""
GEMINI_MODEL="${GEMINI_MODEL:-gemini-2.5-pro}"
AI_TOOL="${AI_TOOL:-gemini}"  # gemini | claude

while [[ $# -gt 0 ]]; do
  case "$1" in
    -f|--file) TASK_FILE="$2"; shift 2 ;;
    -a|--agent) AGENT="$2"; shift 2 ;;
    -m|--model) GEMINI_MODEL="$2"; shift 2 ;;
    --claude) AI_TOOL="claude"; shift ;;
    *) TASK="$1"; shift ;;
  esac
done

if [[ -n "$TASK_FILE" ]]; then
  [[ -f "$TASK_FILE" ]] || { echo "❌ Task file not found: $TASK_FILE"; exit 1; }
  TASK=$(cat "$TASK_FILE")
fi

[[ -z "$TASK" ]] && { echo "❌ No task. Usage: ./scripts/task.sh \"your task\""; exit 1; }

# Determine which agent and rules files to load
case "$AGENT" in
  frontend)  AGENT_FILE="agents/AGENT_FRONTEND.md"; RULES_FILE="rules/RULES_FRONTEND.md" ;;
  backend)   AGENT_FILE="agents/AGENT_BACKEND.md";  RULES_FILE="rules/RULES_BACKEND.md"  ;;
  database)  AGENT_FILE="agents/AGENT_DATABASE.md"; RULES_FILE="rules/RULES_BACKEND.md"  ;;
  reviewer)  AGENT_FILE="agents/AGENT_REVIEWER.md"; RULES_FILE="rules/RULES_GENERAL.md"  ;;
  planner)   AGENT_FILE="agents/AGENT_PLANNER.md";  RULES_FILE="rules/RULES_GENERAL.md"  ;;
  *)         AGENT_FILE="agents/ORCHESTRATOR.md";   RULES_FILE="rules/RULES_GENERAL.md"  ;;
esac

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🤖  Agent:  $AGENT"
echo "📋  Rules:  $RULES_FILE"
echo "🛠   Tool:   $AI_TOOL"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Build context
CONTEXT=$(cat <<PROMPT
$(cat CLAUDE.md 2>/dev/null || cat GEMINI.md 2>/dev/null)

---

$(cat "$AGENT_FILE")

---

$(cat "$RULES_FILE")

---

$(cat rules/RULES_GENERAL.md)

---

## DESIGN TOKENS
$(cat DESIGN.md 2>/dev/null || echo "_DESIGN.md not found. Frontend agent must stop and request it._")

---

## PROJECT OVERVIEW
$(cat DOCS.md 2>/dev/null || echo "_DOCS.md not found. Planner/Orchestrator must stop and request it._")

---

## CURRENT PROJECT INVENTORY
$(bash scripts/scan-context.sh 2>/dev/null || echo "_scan-context.sh failed. Check script permissions._")

---

## YOUR TASK

$TASK

PROMPT
)

# Run with selected tool
if [[ "$AI_TOOL" == "claude" ]]; then
  echo "$CONTEXT" | claude
else
  echo "$CONTEXT" | gemini --model "$GEMINI_MODEL"
fi
