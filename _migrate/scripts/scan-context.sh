#!/usr/bin/env bash
# =============================================================================
# scan-context.sh
# Scans the project and outputs a structured inventory of:
#   - Frontend components (with props if available)
#   - Backend models, schemas, services, routers
# This output is injected into every AI agent prompt automatically.
# =============================================================================

set -euo pipefail

FRONTEND_DIR="${FRONTEND_DIR:-frontend/src}"
BACKEND_DIR="${BACKEND_DIR:-backend/app}"

echo "# PROJECT CONTEXT INVENTORY"
echo "# Generated: $(date '+%Y-%m-%d %H:%M')"
echo "# Inject this into your agent prompt before every task."
echo ""

# ── Frontend Components ───────────────────────────────────────────────────────
echo "## Frontend Components"
echo ""
echo "### shadcn/ui (DO NOT recreate — import only)"
if [ -d "$FRONTEND_DIR/components/ui" ]; then
  find "$FRONTEND_DIR/components/ui" -name "*.tsx" | sort | while read -r f; do
    name=$(basename "$f" .tsx)
    echo "- $name → @/components/ui/$name"
  done
else
  echo "_No shadcn components found. Run: npx shadcn-ui@latest init_"
fi

echo ""
echo "### Custom Components (reuse before creating new)"
if [ -d "$FRONTEND_DIR/components" ]; then
  find "$FRONTEND_DIR/components" -name "*.tsx" \
    ! -path "*/ui/*" \
    ! -name "*.test.tsx" \
    ! -name "*.stories.tsx" | sort | while read -r f; do
    rel="${f#$FRONTEND_DIR/}"
    name=$(grep -E "^export (default function|const) [A-Z]" "$f" 2>/dev/null \
      | head -1 | sed -E 's/export (default function|const) ([A-Za-z]+).*/\2/' || \
      basename "$f" .tsx)
    props=$(grep -E "^(interface|type) [A-Za-z]*Props" "$f" 2>/dev/null \
      | head -1 | sed -E 's/(interface|type) ([A-Za-z]+Props).*/\2/' || echo "")
    if [ -n "$props" ]; then
      echo "- $name → @/$rel (props: $props)"
    else
      echo "- $name → @/$rel"
    fi
  done
else
  echo "_No custom components yet._"
fi

echo ""

# ── Backend Inventory ─────────────────────────────────────────────────────────
echo "## Backend Models (SQLAlchemy)"
if [ -d "$BACKEND_DIR/models" ]; then
  find "$BACKEND_DIR/models" -name "*.py" ! -name "__init__.py" ! -name "base.py" \
  | sort | while read -r f; do
    rel="${f#$BACKEND_DIR/}"
    classes=$(grep -E "^class [A-Z]" "$f" 2>/dev/null | sed 's/class //' | sed 's/(.*//' | tr '\n' ', ' | sed 's/, $//')
    echo "- $classes → app/$rel"
  done
else
  echo "_No models yet._"
fi

echo ""
echo "## Backend Schemas (Pydantic)"
if [ -d "$BACKEND_DIR/schemas" ]; then
  find "$BACKEND_DIR/schemas" -name "*.py" ! -name "__init__.py" | sort | while read -r f; do
    rel="${f#$BACKEND_DIR/}"
    classes=$(grep -E "^class [A-Z]" "$f" 2>/dev/null | sed 's/class //' | sed 's/(.*//' | tr '\n' ', ' | sed 's/, $//')
    echo "- $classes → app/$rel"
  done
else
  echo "_No schemas yet._"
fi

echo ""
echo "## Backend Services"
if [ -d "$BACKEND_DIR/services" ]; then
  find "$BACKEND_DIR/services" -name "*.py" ! -name "__init__.py" | sort | while read -r f; do
    rel="${f#$BACKEND_DIR/}"
    methods=$(grep -E "^\s+async def " "$f" 2>/dev/null | sed 's/.*async def //' | sed 's/(.*//' | head -6 | tr '\n' ', ' | sed 's/, $//')
    svc=$(basename "$f" .py)
    echo "- $svc → app/$rel (methods: $methods)"
  done
else
  echo "_No services yet._"
fi

echo ""
echo "## Backend Routers (API Endpoints)"
if [ -d "$BACKEND_DIR/routers" ]; then
  find "$BACKEND_DIR/routers" -name "*.py" ! -name "__init__.py" | sort | while read -r f; do
    rel="${f#$BACKEND_DIR/}"
    routes=$(grep -E "@router\.(get|post|put|patch|delete)" "$f" 2>/dev/null \
      | sed 's/.*@router\.//' | sed 's/(.*//' \
      | paste -sd ',' - | head -c 80)
    router=$(basename "$f" .py)
    echo "- $router → app/$rel (verbs: $routes)"
  done
else
  echo "_No routers yet._"
fi

echo ""
echo "# END OF INVENTORY"
