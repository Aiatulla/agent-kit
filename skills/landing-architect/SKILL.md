---
name: landing-architect
description: >
  Design complete, conversion-optimized landing pages and marketing pages for any project.
  Use this skill whenever a user wants to build a landing page, marketing site, SaaS homepage,
  product page, or any page meant to convert visitors — even if they just say "I want a website
  for my app", "help me design my startup's page", "what should my homepage look like", "create
  a landing page for X", or "design a page that gets users to sign up". Also trigger when a user
  describes their project idea and wants to know how to present it online, or asks "what sections
  should my site have". This skill produces the full page architecture: section order, copy
  direction, visual guidance, CTA strategy, and design decisions — exactly what top SaaS companies
  like Stripe, Linear, Vercel, and Notion use to convert visitors into users. Always use this
  skill before writing any landing page HTML/CSS/React code.
---

# Landing Architect

Produce a complete, conversion-optimized landing page design specification for any project.
This is not a code generator — it produces the **blueprint** that code is built from.

The output answers: what sections, in what order, with what content, designed how, to
achieve what goal — for this specific project.

---

## Phase 0 — Extract Project DNA

Before designing anything, understand the project deeply. Extract from the conversation,
or ask in ONE message if missing:

### Required Information
1. **What it is** — product/service name and one-sentence description
2. **Who it's for** — the specific user (not "everyone")
3. **The core value** — what problem does it solve? what transformation does it create?
4. **The primary action** — what should a visitor DO? (sign up / book / buy / download)
5. **Trust level** — is this a known brand or unknown startup?
6. **Product type** — SaaS / mobile app / service / physical product / marketplace / tool

### Infer If Not Given
- **Tone**: B2B (professional, data-driven) vs B2C (emotional, benefit-driven)
- **Price sensitivity**: free/freemium vs paid → affects how much trust-building is needed
- **Complexity**: simple tool vs complex platform → affects how much explanation is needed

### Positioning Statement
Before writing copy, define the positioning to avoid commodity framing:
```
BAD (commodity):  "We build [product type]"
GOOD (specialist): "We help [specific audience] achieve [specific result] by [mechanism]"
```
This becomes the lens for every headline. Generic positioning = generic copy = low conversions.
Specific positioning = trust + authority + higher conversion.

### The Transformation Statement
Before writing anything, write this internally:
```
[USER TYPE] can [ACHIEVE RESULT] without [PAIN/BARRIER] using [PRODUCT NAME]
```
This drives every headline, benefit, and CTA on the page.

---

## Phase 0.5 — User Awareness Level

This is one of the most important and most skipped steps.
Visitors land on a page at different stages of awareness. The page must speak to WHERE THEY ARE,
not where you wish they were. Mismatched awareness = instant bounce.

### The 5 Awareness Levels

| Level | State | What They Think | What The Page Must Do |
|-------|-------|-----------------|----------------------|
| 1 — Unaware | Don't know they have a problem | "Everything is fine" | Open with the PROBLEM — make them feel the pain first |
| 2 — Problem Aware | Know the pain, don't know solutions exist | "This is frustrating but I don't know what to do" | Empathize with pain, introduce that a solution exists |
| 3 — Solution Aware | Know solutions exist, researching options | "I know tools like this exist, which is best?" | Show differentiation, features, benefits |
| 4 — Product Aware | Know your product, comparing you to competitors | "I've heard of this, is it better than X?" | Social proof, testimonials, pricing, specific advantages |
| 5 — Most Aware | Ready to buy, just needs the right offer | "I want this — what's the deal?" | Just the offer, the CTA, the price, remove friction |

### How to Detect Awareness Level
Ask: where does this traffic come from?
- **Cold social media ad → Level 1-2**: Start with problem, don't assume they know your product
- **Google search for your brand name → Level 4-5**: Start with the offer, skip problem education
- **Google search for "best [category] tool" → Level 3**: Start with differentiation and social proof
- **Referral from existing customer → Level 3-4**: Trust is partially inherited, lead with product

### Awareness Level → Hero Copy Approach

**Level 1-2 (Pain-led hero)**
Lead with the problem they feel, then introduce the solution:
> "Still managing 10,000 student records in spreadsheets? There's a better way."

**Level 3 (Solution-led hero)**
Lead with what makes your solution different:
> "The only university management platform with automated grading built in."

**Level 4-5 (Offer-led hero)**
Lead directly with the offer and remove friction:
> "Start your free trial today. No credit card, setup in 10 minutes."

Always note the awareness level in the Phase 6 output so the user understands WHO the page is written for.

---

## Phase 1 — Page Architecture

Design the section order based on project type. Choose the right architecture:

### Architecture A: SaaS / Web App
Best for: subscription tools, platforms, dashboards
```
1. NAVBAR
2. HERO
3. SOCIAL PROOF BAR
4. PROBLEM → SOLUTION BRIDGE
5. FEATURES (with benefits)
6. HOW IT WORKS
7. TESTIMONIALS
8. PRICING
9. FAQ
10. FINAL CTA
11. FOOTER
```

### Architecture B: Mobile App
Best for: consumer apps, productivity tools, lifestyle apps
```
1. NAVBAR (minimal)
2. HERO (app store badges prominent)
3. FEATURE SHOWCASE (scrolling phone mockups)
4. SOCIAL PROOF (ratings + download count)
5. BENEFIT SECTIONS (alternating left/right)
6. TESTIMONIALS
7. FINAL CTA (download focused)
8. FOOTER
```

### Architecture C: Service / Agency
Best for: freelancers, agencies, consultants, B2B services
```
1. NAVBAR
2. HERO
3. CLIENT LOGOS
4. SERVICES
5. PROCESS / HOW IT WORKS
6. CASE STUDIES / RESULTS
7. TEAM
8. TESTIMONIALS
9. PRICING OR "GET A QUOTE"
10. FAQ
11. FINAL CTA
12. FOOTER
```

### Architecture D: Product / E-commerce
Best for: physical products, digital downloads, one-time purchases
```
1. NAVBAR
2. HERO (product-forward)
3. SOCIAL PROOF (reviews bar)
4. PRODUCT BENEFITS
5. HOW IT WORKS / SPECS
6. GALLERY / DEMO
7. REVIEWS
8. FAQ
9. FINAL CTA
10. FOOTER
```

### Architecture E: Developer Tool / API
Best for: APIs, CLIs, open source, developer-facing products
```
1. NAVBAR (with GitHub stars)
2. HERO (code example visible)
3. QUICK START (3-line install)
4. FEATURES (technical + benefit)
5. INTEGRATIONS
6. SOCIAL PROOF (used by X companies / stars)
7. PRICING
8. FAQ
9. FINAL CTA
10. FOOTER
```

After selecting architecture, state which one and why.

---

## Phase 2 — Section-by-Section Design

Design every section in full detail. For each section produce:
- **Purpose** (why this section exists)
- **Content specification** (exactly what goes in it)
- **Copy direction** (headline formula + example for this project)
- **Visual direction** (what the user sees, not just reads)
- **Design rules** (spacing, hierarchy, colors, layout)
- **CTA** (if applicable)

Read `references/section-playbooks.md` for the full playbook of each section type.
Read `references/copy-formulas.md` for headline, subheadline, CTA, and benefit copy formulas.
Read `references/visual-direction.md` for visual design rules per section type.

---

## Phase 3 — Copy Architecture

For each section, produce actual copy — not placeholders, not generic text.
Write copy specific to THIS project based on the transformation statement from Phase 0.

### The Clarity Principle (Clarity > Cleverness — Always)
High-converting copy is never clever. It is always clear.

The test: would a 12-year-old understand it in 3 seconds?

Failing the clarity test:
- "Redefining digital transformation" → meaningless
- "Synergizing academic ecosystems" → jargon
- "The future of institutional intelligence" → pretentious

Passing the clarity test:
- "Manage grades, attendance, and exams from one dashboard"
- "Your entire university in one place"
- "Grade 200 assignments in 20 minutes"

Rule: every headline rewrite must move toward MORE specific and MORE clear.
If it sounds impressive but requires thought → rewrite it.

### Congruency Check (Message Must Match End-to-End)
The page message must be consistent across the entire user journey:
```
Ad/referral headline → Landing page headline → CTA button → Thank you page → First email
```
If an ad says "Get 5 qualified sales calls per week" and the landing page says
"AI-powered outreach automation platform" → user is confused → user leaves.

Before writing hero copy, ask: what message sent this person here?
That message must be the first thing they see, in the same language.

Congruency checklist:
- [ ] Hero headline matches the source (ad, email, social post) that sent traffic here
- [ ] CTA copy matches what the hero promised ("Start getting sales calls" not generic "Get Started")
- [ ] Section flow follows logical progression — no jarring topic jumps
- [ ] Brand voice consistent throughout (don't be casual in hero, formal in FAQ)

### The Headline Hierarchy
Every page has 3 levels of headline:

**Level 1 — Hero Headline** (the ONE most important message)
- 6-12 words
- Outcome-focused, not feature-focused
- Formula: see `references/copy-formulas.md` → Section: Hero Headlines

**Level 2 — Section Headlines** (guide the reader through the page)
- Each one answers: why does this section matter to the reader?
- Not "Our Features" — but "Everything you need to [goal]"

**Level 3 — Card/Item Headlines** (specific value points)
- Specific, concrete, no jargon
- Name the benefit, not the feature

### The CTA Stack
Every landing page needs 3 CTAs minimum:

**CTA 1 — Hero CTA** (cold visitor, high stakes)
- Primary button: action-specific ("Start Managing Students Free")
- Secondary button: lower commitment ("See How It Works" / "Watch Demo")

**CTA 2 — Mid-page CTA** (warming visitor, after features)
- Placed after features or testimonials
- Different framing than hero: "Join 10,000+ teams" / "Ready to get started?"

**CTA 3 — Final CTA** (convinced visitor, bottom of page)
- The last chance — make it emotionally resonant
- Repeat the transformation: "Stop managing grades in spreadsheets."

---

## Phase 4 — Visual Design Direction

### Color Strategy
Recommend a color approach based on product type:

**Dark canvas** (recommended for: dev tools, AI products, premium SaaS)
- Near-black background (#0a0a0a to #111)
- White primary text
- One brand accent color for CTAs and highlights
- Reference: Linear, Vercel, Resend

**Light professional** (recommended for: B2B SaaS, enterprise, healthcare)
- White/light gray background
- Dark text
- Brand color for CTAs only
- Reference: Notion, Stripe (light), Intercom

**Bold/colorful** (recommended for: consumer apps, creative tools, marketplaces)
- Colored hero section, white content sections
- Strong gradient for hero
- Reference: Framer, Lottiefiles, Figma

### Typography Direction
Specify font pairing based on brand tone:

**Precise / Technical** → Cabinet Grotesk (display) + DM Sans (body)
**Premium / Refined** → Clash Display (display) + Satoshi (body)
**Energetic / Modern** → Bricolage Grotesque (display) + Outfit (body)
**Minimal / Clean** → Plus Jakarta Sans (display + body, different weights)
**Developer / Code** → Geist (display) + Geist Mono (code blocks)

### Spacing System
Always recommend the 8px grid:
- Component padding: 24px (sm), 40px (md), 64px (lg)
- Section vertical padding: 80-96px between major sections
- Card internal padding: 24-32px
- Max content width: 1200px (SaaS), 1440px (visual/marketing heavy)

### Hero Visual Direction
Specify the exact visual type for the hero:

| Product Type | Recommended Hero Visual |
|---|---|
| Dashboard/SaaS | Full product screenshot, slightly angled (3D perspective) |
| Mobile App | Phone mockup showing key screen, possibly 2-3 phones overlapping |
| API/Dev tool | Syntax-highlighted code block OR terminal screenshot |
| Service | Before/after, result imagery, or team photo |
| AI product | Animated chat or result generation demo |
| Marketplace | Grid of content/products with live data |

---

## Phase 5 — Conversion Optimization Layer

After the base design, apply these conversion principles:

### The Trust Stack
Order trust signals by strength (strongest first):
1. **Logos** of recognizable companies/clients (strongest — social proof from authority)
2. **Numbers** with specificity ("2,847 students managed" beats "thousands")
3. **Testimonials** with photo + real name + role + company
4. **Ratings** (if on app stores or review platforms)
5. **Press mentions** (if any)
6. **Certifications** (security, compliance, awards)

Place trust signals:
- First instance: immediately below or within hero
- Second instance: after features section
- Third instance: before final CTA

### Objection Killing Map
Identify the top 3-5 objections for this specific product and map them to page sections:

| Objection | Where It's Killed | How |
|---|---|---|
| "Is this secure?" | FAQ + footer badges | Security certifications, data policy link |
| "Can I cancel?" | Pricing section | "Cancel anytime" next to price |
| "Will it work for me?" | Testimonials | Show users similar to visitor |
| "Is it hard to set up?" | How It Works | 3-step simplicity |
| "Is it worth the price?" | Features + testimonials | ROI framing |

### Scroll Momentum Rules
- Never place two text-heavy sections back to back
- Alternate: visual-heavy → text-heavy → visual-heavy
- Every section should make the visitor want to see the next
- End each section with a thread-puller: a line that previews the next section

### Above the Fold — The 5-Second Test
**Stat: fewer than 10% of visitors scroll far down the page.**
This means the hero is not just important — it IS the page for most visitors.
The hero must convert OR earn the scroll. Everything else is for the 10% who scroll.

The hero must pass this: show it for 5 seconds to a stranger and they should know:
1. What the product is
2. Who it's for
3. What to do next

If any of these fail → rewrite the hero copy before touching anything else.

### The Pre-Sell Principle
Great landing pages don't just sell — they educate and pre-sell.
When done right, users arrive at the CTA already thinking: "This is probably right for me."
They are not being convinced — they are confirming what the page already made them believe.

How to pre-sell on the page:
- **Problem section**: make them nod "yes, that's exactly my problem"
- **Features + benefits**: show the solution in their language, not yours
- **Testimonials**: show someone like them getting the result they want
- **FAQ**: answer the exact objections they're forming in their head
- **Final CTA**: frame it as a natural next step, not a sales moment

Result: the CTA feels like relief, not pressure.

### Performance Rules (Speed = Trust = Money)
Page speed is a conversion factor, not just a technical concern.
Every 1-second delay in load time reduces conversions by ~7% (Google data).
Slow pages feel untrustworthy — users assume the product is slow too.

Always specify in the output:
- **Images**: use WebP format, lazy-load below-the-fold images
- **Hero image/video**: compress aggressively — hero loads first, must be fast
- **Fonts**: use `font-display: swap`, load only the weights actually used
- **Scripts**: defer all non-critical JS (analytics, chat widgets) until after load
- **Animations**: CSS-only preferred over JS for simple effects (faster, no JS parse cost)
- **Target**: Lighthouse score 90+ on mobile. If it loads slow on 4G, it will lose users.

### Distraction Elimination Rules
Every element must serve the ONE conversion goal. Remove everything else.
- Minimal navigation: no exit links before conversion
- One primary CTA per section (secondary OK, tertiary = distraction)
- No social media links above the fold
- No autoplay video with sound. No popup on arrival.

---

## Phase 6 — Full Output Format

Produce the complete specification as a structured document:

```
# [PROJECT NAME] — Landing Page Blueprint

## Transformation Statement
[USER TYPE] can [ACHIEVE RESULT] without [PAIN] using [PRODUCT NAME]

## Positioning Statement
[Specialist framing — not commodity]

## Awareness Level
[Level 1-5 + traffic source assumption + hero approach chosen]

## Congruency Map
[What sent visitors here → hero headline → CTA → follow-up message]

## Architecture Selected
[Architecture type + reason]

## Color Strategy
[Recommended palette with hex values]

## Typography
[Font pairing + rationale]

---

## SECTION 1: NAVBAR
Purpose: ...
Content: ...
Design: ...

## SECTION 2: HERO
Purpose: ...
Headline: [actual copy for this project]
Subheadline: [actual copy]
Primary CTA: [actual copy]
Secondary CTA: [actual copy]
Visual: [specific description]
Trust signal: [specific copy]
Design rules: ...

## SECTION 3: [NAME]
[continues for every section...]

---

## CTA Stack Summary
CTA 1 (Hero): ...
CTA 2 (Mid): ...
CTA 3 (Final): ...

## Objection Map
[table for this project]

## Trust Signal Placement
[where + what for this project]

## Mobile Adaptation Notes
[specific changes for mobile for this project]

## Performance Checklist
[image formats, font loading, script deferral — specific to this project's stack]

## What To Study Before Building
[2-3 specific sites similar to this project + what to look at]
```

---

## Efficiency Rules

- **Never produce generic output.** Every headline, every CTA, every benefit must be
  written for THIS specific project.
- **Name the user.** Not "users" — "university administrators", "indie developers",
  "small restaurant owners". Specificity makes copy land.
- **Benefits over features.** Always translate: "Real-time sync" → "Your team always
  sees the latest version, no refresh needed."
- **Read section-playbooks.md before designing sections** — it has the exact rules for
  hero, social proof, features, testimonials, pricing, FAQ, and final CTA sections.
- **If the project is unclear**, ask ONE clarifying question before proceeding.
  Never ask more than one question at a time.

---

## Reference Files

Read when needed — do not preload all:

- `references/section-playbooks.md` — Full design rules for every section type
- `references/copy-formulas.md` — Headline, CTA, benefit, and testimonial copy formulas
- `references/visual-direction.md` — Visual design rules, mockup types, animation guidance
- `references/conversion-psychology.md` — The psychology behind why each design decision works
