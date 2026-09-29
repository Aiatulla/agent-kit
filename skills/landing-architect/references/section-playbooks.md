# Section Playbooks
# Full design rules for every landing page section type
# Landing Architect reference — read per section during Phase 2

---

## NAVBAR

### Purpose
Give visitors orientation and a safety net. NOT a navigation menu — a conversion tool.

### What Goes In It
- Logo (left) — links to homepage
- Navigation (center or right) — max 4-5 items
- CTA button (far right) — same CTA as hero, smaller
- Optional: "Sign in" link before the CTA button

### Navigation Items — What To Include
Include only items that help a cold visitor decide to convert:
- Features / Product (what it does)
- Pricing (removes uncertainty)
- Blog / Resources (optional, builds authority)
- About (optional, builds trust for unknown brands)

Do NOT include: everything from the sitemap. Nav is for conversion, not exploration.

### Sticky Behavior
Navbar should be sticky (fixed on scroll) with:
- Slight background blur (backdrop-filter: blur(12px)) for dark navbars
- On scroll: gains a subtle bottom border or shadow to separate from content

### CTA Button Copy
Match the hero CTA exactly: "Get Started" on hero = "Get Started" on nav.
Use a filled button, contrasting color. Not just a text link.

### Mobile
- Logo left, hamburger right
- No nav items visible
- Full-screen overlay on hamburger open
- Dark background overlay, nav items stacked with 48px tap targets

---

## HERO SECTION

### Purpose
Convert or earn the scroll. This is the entire product in 5 seconds.
Every other section exists to support people who didn't convert here.

### Formula
```
EYEBROW LABEL (optional)    → "Trusted by 20+ universities"
BIG HEADLINE                → The transformation in 6-12 words
SUBHEADLINE                 → How + who + what makes it different (2-3 lines)
PRIMARY CTA                 → The single most important action
SECONDARY CTA               → Lower-commitment alternative
HERO VISUAL                 → The product in its best moment
TRUST MICRO-SIGNAL          → Rating, user count, or logo strip below CTA
```

### Eyebrow Label (if used)
Small text above the headline. Creates context and urgency.
Examples:
- "Now in public beta"
- "#1 rated university tool"
- "Trusted by 500+ schools"
Style: uppercase, 12-13px, brand color or muted, letter-spacing 1-2px

### Headline Rules
- 6-12 words (mobile: aim for 6-8)
- Outcome/result language, not feature language
- Avoid: "Introducing", "The future of", "Revolutionary", "Best-in-class"
- Use: strong verbs ("Build", "Manage", "Ship", "Replace")
- Font: largest on the page (56-80px desktop, 36-48px mobile)
- Weight: heaviest (700-800)
- Letter spacing: -1px to -3px (feels modern and premium)

### Subheadline Rules
- 2-3 lines max
- Explains HOW the headline happens
- Names the target user explicitly
- Mentions 1-2 key differentiators
- Font: 18-22px, weight 300-400, line height 1.6
- Color: slightly muted (not pure white/black — use 80% opacity)

### Layout Options
**Centered**: Headline + sub centered, CTA centered, hero image below
→ Use for: simple products, apps, tools
→ Looks like: Linear, Vercel

**Left + Right split**: Text left, visual right
→ Use for: dashboards, complex products, B2B
→ Looks like: Intercom, HubSpot

**Full-bleed background**: Text overlaid on full-width image/video
→ Use for: visual products, services, lifestyle
→ Looks like: Airbnb, Shopify

### Hero Visual Rules
- Show the BEST moment of the product, not the default state
- Use real data (not "Lorem ipsum", not "John Doe", not empty states)
- Slight tilt or 3D perspective on dashboard screenshots feels more dynamic
- Drop shadow beneath the screenshot for depth
- On dark backgrounds: light screenshot pops naturally
- On light backgrounds: add a subtle card/frame around screenshot

### Trust Micro-Signal (below CTA)
Small, unobtrusive line immediately below the CTA buttons:
- "⭐⭐⭐⭐⭐ Rated 4.9/5 by 200+ teams"
- "No credit card required · Free 14-day trial"
- "Join 10,000+ developers who already use this"
- Logos of 4-5 recognizable clients in small gray scale

---

## SOCIAL PROOF BAR

### Purpose
The first trust moment. Happens immediately after hero.
Users just saw the promise — now they need to know others believe it too.

### What Goes In It
Option A — Logo strip:
```
"Trusted by teams at:"
[LOGO] [LOGO] [LOGO] [LOGO] [LOGO] [LOGO]
```

Option B — Stats bar:
```
[NUMBER] [LABEL] | [NUMBER] [LABEL] | [NUMBER] [LABEL]
"10,000 students" | "500 universities" | "99.9% uptime"
```

Option C — Combination:
Stats above, logos below (or vice versa).

### Design Rules
- Full width, center-aligned
- Logos in grayscale (reduces visual noise, doesn't compete with brand)
- Logos at 50-70% opacity — present but not dominant
- Section has minimal vertical padding (40-48px top and bottom)
- Background: same as hero, or one step lighter/darker to create a subtle break
- No card, no border — this should feel like a quiet confidence moment

### Number Specificity Rule
Vague: "Thousands of users"
Specific: "12,847 students managed"
Specific numbers are 3x more credible than round numbers.
If you don't have real numbers yet, use milestones: "First 500 customers" is honest.

---

## PROBLEM → SOLUTION BRIDGE

### Purpose
Make visitors feel understood. Before showing features, show you know their pain.
This section is often skipped by beginners — big mistake.

### Structure
```
The Problem (relatable pain)
↓
The Old Way (how they currently solve it — and why it fails)
↓
The New Way (your product's approach — not features, just the shift)
```

### Copy Direction
Open with empathy, not accusation:
Bad: "Your current tools are broken."
Good: "Most universities still manage grades in spreadsheets."

Name the specific pain:
- Not: "Managing students is hard"
- But: "Tracking attendance across 40 classes in Excel is a nightmare"

Pivot to the solution with a single transition:
- "There's a better way."
- "We built something different."
- "[Product] changes this entirely."

### Visual Options
- Split section: problem visual (messy spreadsheet) ↔ solution visual (clean dashboard)
- Timeline: before/after comparison
- Dark section with a single powerful quote about the problem

---

## FEATURES SECTION

### Purpose
Show what the product does. But always through the lens of benefits.
Features without benefits are a catalog. Benefits with features are a pitch.

### The Feature → Benefit Rule
Every feature must be translated:
```
Feature: "Automated grading"
Benefit: "Grade 200 assignments in minutes, not hours"

Feature: "Role-based access"
Benefit: "Teachers see their classes; admins see everything. No confusion."

Feature: "Export to CSV"
Benefit: "Your data works anywhere — Excel, Google Sheets, your BI tool"
```

### Layout Options

**Grid of cards** (3-up or 2-up):
Best for: 6-9 features
Each card: icon + feature name + 1-2 sentence benefit
Card size: consistent, equal weight

**Alternating sections** (left/right):
Best for: 3-4 major features with screenshots
Each section: screenshot one side, headline + benefit + subpoints other side
Alternates direction to create visual rhythm

**Feature list with icons**:
Best for: showing a lot of features quickly (pricing comparison style)
Each item: small icon + bold feature name + short description

### Icon Rules
- Use a consistent icon set (Lucide, Heroicons, Phosphor — pick one)
- Icons same size: 24px or 32px in a 48px container
- Icon container: brand color at 10-15% opacity, rounded
- Never mix icon styles (outline + filled = inconsistent)

### Section Heading Formula
Not: "Features"
But: "Everything you need to [achieve the transformation]"
Example: "Everything you need to run your university's academic operations"

---

## HOW IT WORKS

### Purpose
Remove confusion about process. Users who understand the path to value convert better.
Most important for: complex products, multi-step services, onboarding-heavy tools.

### Structure
```
SECTION LABEL: "How it works" or "Get started in minutes"
HEADLINE: "From signup to running in 3 steps"
STEPS: numbered, sequential, visual
```

### 3-Step Rule
Always exactly 3 steps. Never 2 (too simple to trust), never 4+ (too complex to digest).

Step structure:
- Number (large, brand color)
- Step name (short, action verb)
- Description (1-2 sentences, what happens AND what the user gains)
- Visual (screenshot, illustration, or icon)

Example:
```
1. Create your university account
   Set up your institution in minutes. Add your departments, teachers, and grading scales.

2. Import your students
   Upload a CSV or connect your existing student database. Everything syncs automatically.

3. Start managing
   Grades, attendance, exams, and reports — all in one place from day one.
```

### Visual Options
- Horizontal 3-step flow (desktop) with connecting arrows/lines
- Stacked timeline (mobile-first)
- Screenshots beside each step (most effective)
- Animated sequence (if budget allows — shows the actual flow)

---

## TESTIMONIALS

### Purpose
Let others sell for you. Humans trust humans more than marketing.
One good testimonial outperforms five paragraphs of features copy.

### The Perfect Testimonial Structure
```
PHOTO (real, professional, consistent crop)
NAME (full name — no "J.S." abbreviations)
ROLE + COMPANY ("Head of Academic Affairs, MIT")
QUOTE (result-focused, specific, in their voice)
```

### What Makes a Testimonial Believable
Specific beats generic:
- Bad: "This is a great product, I love it!"
- Good: "We reduced grade entry time from 3 hours to 20 minutes per week."

Details beat claims:
- Include numbers, timeframes, specific features when possible
- "Since switching, we've eliminated 90% of our grade-related support tickets"

Person must be real and identifiable:
- No stock photos
- Full name + verifiable role
- Company name if possible

### Layout Options

**3-up grid** (most common):
Three testimonials side by side, equal weight

**Featured testimonial** (most powerful):
One large testimonial above, two smaller ones below
Featured one has a pull quote, larger, centered

**Scrolling carousel**:
Works when you have 6+ testimonials
Auto-scrolls with pause on hover

**Integrated testimonials**:
Single testimonials placed within relevant sections
(e.g., a testimonial about grading speed next to the grading feature card)

### Testimonial Section Heading
Not: "What our customers say"
But: "Used by [user type] who [achieved result]"
Example: "Used by academic teams who've taken back their weekends"

---

## PRICING SECTION

### Purpose
Remove the final financial uncertainty. Make the decision obvious.

### The 3-Tier Rule
Always 3 tiers. Named by who they're for, not by arbitrary labels.

Tier naming examples:
- "Solo / Team / University"
- "Starter / Growth / Enterprise"
- "Free / Pro / Scale"
- "Individual / Department / Institution"

### Highlighted Plan
The recommended plan (middle or most popular):
- Different visual treatment: elevated card, brand color border, or dark background
- Badge: "Most Popular" or "Best Value"
- Slightly larger or visually prominent
- CTA in strongest contrast color

### Feature List Rules
- Max 6 features per tier
- Use checkmarks for included, gray dash or no mark for excluded
- "Everything in [lower tier], plus:" pattern for upgrades
- Never use feature names users won't understand — translate to benefits

### Pricing Page Copy
Headline: "Simple pricing that grows with you"
Subheadline: "Start free. No credit card required. Upgrade when you're ready."

Below pricing cards — trust signals:
- "Cancel anytime"
- "14-day free trial"
- "No hidden fees"
- "Dedicated support on Pro+"

### Annual vs Monthly Toggle
Show annual pricing by default (higher plan value perception).
Badge: "Save 40%" next to annual toggle.
Show monthly equivalent: "$19/mo billed $228/yr" — don't hide the math.

---

## FAQ SECTION

### Purpose
Kill objections before they kill conversions.
Every question in FAQ is a real reason someone didn't buy.

### FAQ Construction Rule
Write questions from the visitor's perspective, not the company's:
- Not: "What is [Product]?"
- But: "Do I need technical knowledge to set this up?"

### Universal FAQ Questions (adapt to project)
1. Is there a free trial / free plan?
2. Can I cancel my subscription anytime?
3. How secure is my data?
4. Does it work on mobile?
5. How long does setup take?
6. Can I migrate from my current tool?
7. Do you offer discounts for nonprofits/students/education?
8. What support do you offer?

### Design
- Accordion style (expand/collapse) — reduces visual overwhelm
- Max 8-10 questions
- Open the first one by default to show the interaction
- Section heading: "Questions? We've got answers." or "Everything you need to know"

---

## FINAL CTA SECTION

### Purpose
Catch the convinced visitor at the bottom of the page.
Users who scrolled all the way are highly interested — give them a frictionless path.

### Structure
```
BACKGROUND: different from rest of page (dark, brand color, gradient)
HEADLINE: emotional, transformation-focused
SUBTEXT: reinforce the risk-removal ("Free to start, no credit card")
PRIMARY CTA: same as hero CTA
OPTIONAL: secondary trust signal
```

### Headline Approaches
Approach A — Empathy + Solution:
"Stop managing grades in spreadsheets. Start running your university properly."

Approach B — Outcome visualization:
"Imagine having your entire academic operation in one place."

Approach C — Direct invitation:
"Join 2,000+ universities who already made the switch."

Approach D — Time-based urgency (use sparingly, only if real):
"Set up in under 10 minutes. Your first class is waiting."

### Design Rules
- Full-width section, strong visual contrast with the section above
- No cards, no columns — simple centered text + one button
- Add a subtle gradient or texture to give it visual weight
- The button should be the largest, most prominent CTA on the page

---

## FOOTER

### Purpose
Navigation safety net + legal trust layer.
Users who reach the footer and don't convert still need a path forward.

### Structure
```
LOGO + tagline (left)
COLUMNS: Product / Resources / Company / Legal
BOTTOM ROW: Copyright · Privacy Policy · Terms · Social icons
```

### Column Content
Product column: Features, Pricing, Changelog, Roadmap
Resources column: Documentation, Blog, Support, Status
Company column: About, Careers, Press, Contact
Legal column: Privacy Policy, Terms of Service, Cookie Policy

### Design Rules
- Background: same as hero (canvas color) — creates frame/bookend
- Text color: muted (60-70% opacity) — this is not primary content
- Links: no underlines normally, underline on hover
- Social icons: small, grayscale unless it's a consumer product
- Copyright + legal links: smallest text on the page, bottom row

### What the Footer Communicates
A well-designed footer signals:
- This is a real, established company
- We have policies and transparency
- You can find anything here if the nav didn't have it

A broken/empty footer signals: unfinished, untrustworthy.
