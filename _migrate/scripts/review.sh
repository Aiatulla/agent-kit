#!/usr/bin/env bash
# =============================================================================
# review.sh — Run AGENT_REVIEWER on any file or git diff
# Usage: ./scripts/review.sh src/components/ProductCard.tsx
# Usage: ./scripts/review.sh --diff          (reviews staged git changes)
# Usage: ./scripts/review.sh --last          (reviews last commit)
# =============================================================================

set -euo pipefail

TARGET=""
MODE="file"
AI_TOOL="${AI_TOOL:-gemini}"
GEMINI_MODEL="${GEMINI_MODEL:-gemini-2.5-pro}"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --diff)  MODE="diff";  shift ;;
    --last)  MODE="last";  shift ;;
    --claude) AI_TOOL="claude"; shift ;;
    *) TARGET="$1"; shift ;;
  esac
done

case "$MODE" in
  diff) CODE=$(git diff --staged) ;;
  last) CODE=$(git diff HEAD~1 HEAD) ;;
  file)
    [[ -z "$TARGET" ]] && { echo "❌ Provide a file path or --diff / --last"; exit 1; }
    [[ -f "$TARGET" ]] || { echo "❌ File not found: $TARGET"; exit 1; }
    CODE=$(cat "$TARGET")
    ;;
esac

CONTEXT=$(cat <<PROMPT
$(cat agents/AGENT_REVIEWER.md)

---

$(cat rules/RULES_FRONTEND.md)

---

$(cat rules/RULES_BACKEND.md)

---

$(cat rules/RULES_GENERAL.md)

---

## DESIGN TOKENS (for frontend review)
$(cat DESIGN.md 2>/dev/null || echo "_DESIGN.md not present_")

---

## CODE TO REVIEW
\`\`\`
$CODE
\`\`\`

Review this code against all the rules above.
Output in the exact REVIEW RESULT format defined in AGENT_REVIEWER.md.
PROMPT
)

echo "🔍  Running review on: ${TARGET:-git diff}..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [[ "$AI_TOOL" == "claude" ]]; then
  echo "$CONTEXT" | claude
else
  echo "$CONTEXT" | gemini --model "$GEMINI_MODEL"
fi
