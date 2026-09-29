# Task Template

# Copy this file, fill it in, run: ./scripts/task.sh -f my-task.md

# Or: AGENT=frontend ./scripts/task.sh -f my-task.md

## Goal

<!-- One sentence: what should exist when this task is done? -->

## Agent

<!-- orchestrator | frontend | backend | database | reviewer | planner -->

orchestrator

## Context / Background

<!-- What does the agent need to know that isn't in DOCS.md? -->

## Details

<!-- Exact requirements. Be as specific as possible. -->
<!-- For UI tasks: describe dimensions, spacing, which components to use -->
<!-- For API tasks: describe endpoints, request/response shapes, auth required -->

## Visual Reference

<!-- Attach screenshot or describe layout precisely if this is a UI task -->

## Reuse (check scan-context.sh first)

<!-- List existing components / models / services this task must use, not recreate -->

## Acceptance Criteria

<!-- The agent self-checks these before outputting anything -->

- [ ] (fill in)
- [ ] (fill in)
- [ ] (fill in)

## Do NOT

<!-- Explicit things the agent must not do -->

- Do not create new components if existing ones cover this
- Do not hardcode colors — use DESIGN.md tokens
- Do not add new dependencies without asking first
