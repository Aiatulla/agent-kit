---
name: page-auditor
description: >
  Audit any landing page, marketing page, or individual UI component against professional
  conversion best practices — and give specific, actionable improvement suggestions.
  Trigger when the user says: "review my landing page", "audit this component", "what's
  wrong with my hero section", "how can I improve this page", "is my pricing section good",
  "check my login form", "give feedback on my testimonials", "score my landing page",
  "what would you change about this", "CRO audit", or pastes HTML/screenshot/description
  of a page or component and wants improvement advice. Works on: full pages, individual
  sections (hero, pricing, FAQ, navbar), or single components (button, form, card,
  testimonial, CTA). Input can be: HTML code, a screenshot description, a written
  description, or a URL. Output is always: a scored audit report with specific
  fixes — not generic advice. AI-universal: works with Claude, GPT, Gemini.
---

# Page Auditor

Professional conversion rate optimization (CRO) audit for any landing page or component.
Analyzes what's there, scores it against what million-dollar pages do, and gives
specific fixes — not generic "improve your CTA" advice.

**The difference between this and generic feedback:**
Generic: "Your headline could be better."
This skill: "Your headline 'Welcome to EduManager' fails the clarity test — it says
nothing about the outcome. Rewrite to: 'Manage 10,000 students without spreadsheets.'
Expected impact: +15-30% time-on-page from cold traffic."

---

## Phase 0 — Understand What's Being Audited

Before auditing, establish:

1. **What is being audited?**
   - Full landing page
   - Specific section (hero / pricing / testimonials / FAQ / navbar / footer / CTA)
   - Single component (button / form / card / testimonial / modal)

2. **What is the page/component trying to do?**
   - Primary conversion goal (sign up / book / buy / download)
   - If not stated → infer from context, then confirm

3. **Who is the target audience?**
   - If not stated → infer from product/content, then note assumption

4. **What input format was provided?**
   - HTML code → analyze structure, copy, and design tokens
   - Screenshot description → analyze visually described elements
   - Written description → analyze based on described content
   - URL → analyze what can be inferred (ask user to paste HTML if deeper audit needed)

**If critical context is missing, ask ONE question before proceeding.**
Never ask more than one question — infer everything else and state assumptions clearly.

---

## Phase 1 — Triage: What Exists vs. What Should Exist

Before scoring, map what's present against what professional pages include.

### Full Page Triage Checklist
Check which of these exist:
```
□ Navbar (with CTA)
□ Hero headline (outcome-focused)
□ Hero subheadline
□ Primary CTA (above the fold)
□ Hero visual (product/result shown)
□ Trust signal in hero
□ Social proof bar (logos/numbers)
□ Problem section
□ Features + benefits
□ How it works (3 steps)
□ Testimonials (with photos + specifics)
□ Stats/numbers section
□ Pricing section
□ FAQ section
□ Final CTA section
□ Footer (with legal links)
```

For each missing item: note it as a **Gap** with priority level:
- 🔴 Critical gap (directly hurts conversions)
- 🟡 Important gap (missed opportunity)
- ⚪ Optional (nice to have for this product type)

### Component Triage
If auditing a single component, go directly to Phase 2 and the relevant
component scorecard in `references/component-scorecards.md`.

---

## Phase 2 — Score Each Element

Score every element present using the scorecards.
Read `references/component-scorecards.md` for the full scoring rubric per component.

Each element gets:
- **Score**: 1-10
- **What's working**: specific things done well
- **What's failing**: specific problems with evidence
- **Fix**: exact rewrite or change, not vague advice

### Scoring Scale
| Score | Meaning |
|-------|---------|
| 9-10 | Professional level — matches top SaaS pages |
| 7-8 | Good — minor improvements needed |
| 5-6 | Average — significant improvements needed |
| 3-4 | Weak — fundamental problems present |
| 1-2 | Failing — hurting conversions actively |

---

## Phase 3 — Conversion Impact Analysis

For each issue found, estimate conversion impact:

**High impact** — fixing this likely increases conversions 10-30%+
- Unclear hero headline
- No social proof above the fold
- Weak/missing CTA
- No trust signals
- Poor mobile layout

**Medium impact** — fixing this likely increases conversions 5-15%
- Generic testimonials (no specifics)
- Feature-only descriptions (no benefits)
- Missing FAQ
- Weak secondary CTA

**Low impact** — nice to have, marginal conversion lift
- Footer improvements
- Minor copy tweaks
- Color refinements
- Animation polish

Always prioritize high-impact fixes first. A user should never leave the audit
unsure what to fix first.

---

## Phase 4 — Psychology Audit Layer

Beyond surface-level design, check these psychological principles:
Read `references/psychology-checks.md` for the full checklist.

Quick checks to always run:

**Clarity Check**
- Can a stranger explain what this does in 3 seconds from the headline alone?
- Is there any jargon, buzzwords, or vague language?

**Trust Check**
- Is there any social proof above the fold?
- Are testimonials specific (names, roles, results) or generic?
- Does the page feel polished and professional?

**Friction Check**
- How many form fields are there? (more than 3 for cold traffic = too many)
- How many clicks to the primary action?
- Is there anything that takes users AWAY from converting?

**Awareness Level Check**
- Who is this page written for — cold traffic or warm traffic?
- Does the hero lead with problem (cold) or offer (warm)?
- Is the awareness level matched correctly?

**Congruency Check**
- Is the messaging consistent throughout the page?
- Does every section feel like the same brand voice?

---

## Phase 5 — Final Output Format

Produce the audit as a structured report. Always in this format:

---

```
# [PAGE/COMPONENT NAME] — Conversion Audit Report
# Audited by: Page Auditor
# Goal: [conversion goal]
# Audience: [target user]
# Input type: [HTML / description / screenshot]

---

## 🔢 OVERALL SCORE: [X/10]
[1-sentence summary of the page's conversion readiness]

---

## 🚨 CRITICAL FIXES (Do These First)
[Ordered by conversion impact — highest first]

### Fix 1: [Short title]
**Problem:** [Specific description of what's wrong and why it hurts]
**Current:** "[exact current copy or element description]"
**Rewrite to:** "[exact suggested replacement]"
**Why it matters:** [psychological principle + estimated impact]

### Fix 2: [Short title]
[same structure...]

---

## ✅ WHAT'S WORKING
[Specific things done well — be genuine, not just polite]

---

## 📋 SECTION-BY-SECTION SCORES

| Section | Score | Status |
|---------|-------|--------|
| Navbar | X/10 | [one-line note] |
| Hero headline | X/10 | [one-line note] |
| Hero visual | X/10 | [one-line note] |
| Social proof | X/10 | [one-line note] |
| [continues...] | | |

---

## 🔍 DETAILED SECTION ANALYSIS

### NAVBAR [X/10]
**What's there:** [description]
**Issues:** [specific problems]
**Fixes:** [specific changes]

### HERO [X/10]
**Headline:** [quote current] → [suggest rewrite]
**Subheadline:** [analysis]
**CTA:** [analysis + rewrite]
**Visual:** [analysis]
**Trust signal:** [present/missing + suggestion]

[continues for every section present...]

---

## 🧠 PSYCHOLOGY AUDIT

**Clarity:** [Pass/Fail + note]
**Trust stack:** [Pass/Fail + note]
**Friction level:** [Low/Medium/High + note]
**Awareness match:** [Level + correct/incorrect + note]
**Congruency:** [Pass/Fail + note]

---

## 📱 MOBILE AUDIT
[mobile-specific issues if detectable]

---

## ⚡ PERFORMANCE FLAGS
[any performance concerns visible from code/description]

---

## 🗺️ PRIORITY ACTION PLAN
[numbered list, highest impact first]
1. [Fix X] — estimated impact: HIGH
2. [Fix Y] — estimated impact: HIGH
3. [Fix Z] — estimated impact: MEDIUM
[...]

---

## 💡 WHAT THIS PAGE SHOULD FEEL LIKE
[2-3 sentences describing the ideal version of this page —
 the emotional experience a visitor should have]

## 📚 REFERENCE PAGES TO STUDY
[2-3 specific pages similar to this one that do it well + what to look at specifically]
```

---

## Efficiency Rules

- **Be specific always.** Never write "improve your headline." Write the new headline.
- **Quote the actual content.** Reference exact text/elements from what was provided.
- **Prioritize ruthlessly.** Top 3 fixes matter more than a list of 20 minor tweaks.
- **Explain the why.** Every suggestion must reference a psychological principle or
  conversion data — not just personal preference.
- **If input is a single component** → skip full-page structure, go straight to
  component scorecard + specific fix suggestions.
- **Acknowledge what works.** Never only criticize — genuine positives build trust
  in the audit and help users understand what to keep.
- **State assumptions clearly.** If you inferred the audience or goal, say so.

---

## Reference Files

Read when needed:

- `references/component-scorecards.md` — Scoring rubrics for every component type
  (navbar, hero, social proof, features, testimonials, pricing, FAQ, CTA, footer,
   forms, buttons, cards, modals, login pages)
- `references/psychology-checks.md` — Full psychology audit checklist + what to look for
- `references/rewrite-patterns.md` — Common bad patterns + exact rewrite formulas
  for headlines, CTAs, benefits, testimonials, and form labels
