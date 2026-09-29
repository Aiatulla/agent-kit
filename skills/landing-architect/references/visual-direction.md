# Visual Direction
# Design rules, mockup types, layout patterns, animation guidance
# Landing Architect reference — read during Phase 4 (Visual Design Direction)

---

## HERO VISUAL PLAYBOOK

The hero visual is the single most important design decision on the landing page.
It must show the product in its best moment — not its default empty state.

### For SaaS / Dashboard Products

**The Angled Screenshot**
- Take a real screenshot of the dashboard with real data
- Apply a slight 3D perspective tilt (rotateX: 5-10deg, rotateY: 5-10deg)
- Add a realistic drop shadow beneath
- Frame it in a browser chrome (top bar with 3 dots + URL bar) for authenticity
- Background: dark gradient or subtle mesh gradient behind screenshot
- Effect: feels like looking at a product in use, not a flat image

**The Layered Screenshots**
- 2-3 screenshots overlapping, showing different features
- Main screenshot: centered, largest
- Secondary: offset top-right or bottom-left, smaller, slight shadow
- Creates depth and shows multiple capabilities simultaneously

**The Floating UI Elements**
- Dashboard screenshot as base
- Small floating cards overlaid on top: metric callouts, notification cards, user avatars
- These appear to be "popping off" the dashboard
- Adds motion potential (cards animate in on page load)

### For Mobile Apps

**Single Phone Centered**
- High-quality phone frame (iPhone 15 Pro or Pixel 8)
- App screenshot filling the screen
- Clean background — gradient, solid color, or subtle pattern
- Slight shadow under the phone

**Two Phones, Offset**
- Two phones showing different screens
- One slightly behind/to the side of the other
- Shows app depth and multiple features

**Phone + Feature Callouts**
- Phone in center
- Floating text callouts with arrows pointing to key features on screen
- "Tap to grade" → arrow to grading interface
- "Auto-syncs" → arrow to sync indicator

### For Developer Tools / APIs

**Code Block as Hero Visual**
- Syntax-highlighted code showing a simple, elegant integration
- Dark background code block, colored syntax
- Show the "before" (complex/long) and "after" (3 lines with your API)
- Use a real, working example — not pseudocode

**Terminal Screenshot**
- Real terminal showing install + first run
- Shows simplicity: `npm install x` → immediate output
- Dark terminal, colored prompts

### For Services / Agencies

**The Result Visual**
- Show the outcome, not the process
- Before/after comparison if applicable
- Client logos arranged cleanly

**Team Photo**
- Real team, professional but approachable
- Not stock photos
- Consistent editing style

---

## COLOR SYSTEM GUIDELINES

### Dark Canvas (Premium / Technical)

```css
:root {
  --canvas: #0a0a0a;          /* page background */
  --surface-card: #141414;    /* card backgrounds */
  --surface-elevated: #1e1e1e; /* modals, dropups */
  --border: #2a2a2a;          /* subtle borders */
  --text-primary: #ffffff;
  --text-body: #a8a8a8;
  --text-muted: #6b6b6b;

  /* Accent — pick ONE based on brand */
  --accent-blue: #3b82f6;     /* reliable, trustworthy */
  --accent-purple: #8b5cf6;   /* creative, premium */
  --accent-green: #22c55e;    /* growth, success */
  --accent-orange: #f97316;   /* energy, action */
  --accent-cyan: #06b6d4;     /* tech, modern */
}
```

Best for: Dev tools, AI products, fintech, premium SaaS
Reference: Linear, Vercel, Resend, Railway

### Light Professional

```css
:root {
  --canvas: #ffffff;
  --surface-card: #f8f9fa;
  --surface-elevated: #f0f2f5;
  --border: #e5e7eb;
  --text-primary: #111827;
  --text-body: #374151;
  --text-muted: #9ca3af;

  /* Accent */
  --accent: #2563eb;          /* or brand color */
}
```

Best for: B2B SaaS, healthcare, education, enterprise
Reference: Notion, Intercom, HubSpot

### Gradient Hero + White Body

```css
/* Hero section only */
.hero {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  /* or */
  background: linear-gradient(135deg, #0f0c29, #302b63, #24243e);
}

/* Rest of page: white */
body { background: #ffffff; }
```

Best for: Creative tools, consumer apps, marketplaces
Reference: Framer, Figma, Dribbble

---

## TYPOGRAPHY SYSTEM

### Pairing Guide (by brand tone)

**Precise / Engineering**
- Display: `Cabinet Grotesk` (700-800) — geometric, confident
- Body: `DM Sans` (300-400) — clean, readable
- Code: `JetBrains Mono`

**Premium / Elevated**
- Display: `Clash Display` (600-700) — distinctive, high-end
- Body: `Satoshi` (300-400) — modern, elegant

**Modern / Energetic**
- Display: `Bricolage Grotesque` (700-800) — dynamic, fresh
- Body: `Outfit` (300-400) — friendly, clear

**Minimal / Focused**
- Display + Body: `Plus Jakarta Sans` — use 700 display, 300-400 body
- Same family, different weights creates clean elegance

**Developer / Technical**
- Display: `Geist` (600-700) — Vercel's font, technical confidence
- Body: `Geist` (400)
- Code: `Geist Mono`

**All fonts available on Google Fonts except Cabinet Grotesk and Clash Display
(those are on Fontshare — free for commercial use)**

### Size Scale (Desktop)

| Role | Size | Weight | Line Height | Letter Spacing |
|------|------|--------|-------------|----------------|
| Hero H1 | 64-80px | 700-800 | 1.0-1.05 | -2px to -3px |
| Section H2 | 40-48px | 700 | 1.1 | -1px |
| Sub-section H3 | 28-32px | 600-700 | 1.2 | -0.5px |
| Card title H4 | 20-24px | 600 | 1.3 | 0 |
| Body | 16-18px | 300-400 | 1.6-1.7 | 0 |
| Caption/Label | 12-14px | 500-600 | 1.4 | 0.5-1.5px |
| Button | 14-15px | 600 | 1.0 | 0.3-0.5px |

### Mobile Scale

| Role | Desktop | Mobile |
|------|---------|--------|
| Hero H1 | 64-80px | 36-44px |
| Section H2 | 40-48px | 28-32px |
| Body | 16-18px | 16px (never below) |

---

## LAYOUT PATTERNS

### The Section Rhythm
Alternate between these section types to maintain scroll momentum:
```
Hero (visual-heavy)
↓
Social proof bar (minimal, transition)
↓
Features (card grid — visual + text balanced)
↓
How it works (visual process — screenshots)
↓
Testimonials (human faces — emotional)
↓
Pricing (structured, clear)
↓
Final CTA (full-bleed, emotional)
```

Never: two text-heavy sections in a row.
Never: two visual-heavy sections without a text break.

### Section Anatomy (consistent across all sections)

```
SECTION WRAPPER (80-96px vertical padding)
  SECTION HEADER (center-aligned, max-width 640px)
    Eyebrow label (small, uppercase, brand color)
    Section headline (large, bold)
    Section description (optional, muted, 1-2 lines)
  SECTION CONTENT (max-width 1200px)
    [cards / screenshots / list / whatever the section shows]
  SECTION CTA (optional, center-aligned)
    CTA button
    Trust micro-copy
```

### Card Grid Rules
- 3-up grid: 360-380px min card width, 24px gap
- 2-up grid: for screenshot + text alternating layouts
- Cards equal height: use flexbox column with content at top, CTA at bottom
- Card padding: 24-32px
- Card hover: translateY(-4px) + box-shadow intensifies, 0.25s ease

### Max-Width Strategy
- Content max-width: 1200px (most SaaS)
- Full-bleed: hero backgrounds, section backgrounds
- Narrow content: article text, single-column sections (640-720px)
- The content is constrained, the background is full-bleed

---

## ANIMATION GUIDANCE

### Page Load Cascade (hero animation)
On page load, elements animate in with a stagger:

```css
/* Sequence: eyebrow → headline → subheadline → CTA → visual */
.hero-eyebrow { animation: fadeUp 0.5s ease-out 0.1s both; }
.hero-headline { animation: fadeUp 0.6s ease-out 0.2s both; }
.hero-sub { animation: fadeUp 0.6s ease-out 0.35s both; }
.hero-cta { animation: fadeUp 0.5s ease-out 0.5s both; }
.hero-visual { animation: fadeUp 0.8s ease-out 0.65s both; }

@keyframes fadeUp {
  from { opacity: 0; transform: translateY(24px); }
  to { opacity: 1; transform: translateY(0); }
}
```

Use `cubic-bezier(0.16, 1, 0.3, 1)` for a snappy expo ease-out feel.
This easing feels fast, confident, and premium.

### Scroll Reveal (for sections below hero)
```javascript
// Using AOS (simplest implementation)
// data-aos="fade-up" on each section
// AOS.init({ duration: 600, once: true, offset: 80 })

// Or native IntersectionObserver
const observer = new IntersectionObserver(
  (entries) => entries.forEach(e => {
    if (e.isIntersecting) e.target.classList.add('visible');
  }),
  { threshold: 0.1 }
);
```

Apply to: section headings, feature cards, testimonial cards, stat numbers.
Do NOT apply to: navigation, hero (already animated), footer.

### Card Hover
```css
.card {
  transition: transform 0.25s ease-out, box-shadow 0.25s ease-out;
}
.card:hover {
  transform: translateY(-4px);
  box-shadow: 0 20px 40px rgba(0,0,0,0.15);
}
```

### Button Interactions
```css
.btn-primary {
  transition: all 0.2s ease;
}
.btn-primary:hover {
  filter: brightness(1.1);
  transform: translateY(-1px);
}
.btn-primary:active {
  transform: scale(0.97) translateY(0);
}
```

### Number Counter Animation (for stats)
When stat numbers scroll into view, count up from 0 to the target value.
Duration: 1.5-2s, ease-out curve.
Only do this for numbers that are impressive when you see them counting up.

### What NOT to Animate
- Page background parallax (usually distracting, slows the page)
- Every single element (animation fatigue)
- Anything that delays the user from reading content
- Cursor trail effects (childish, distracting)
- Heavy 3D transforms that require GPU (performance issues on mobile)

---

## GRADIENT PATTERNS

### Hero Background Gradients
```css
/* Subtle dark → slightly lighter (common for dark canvas) */
background: radial-gradient(ellipse at top, #1a1a2e 0%, #0a0a0a 60%);

/* Brand color ambient glow */
background: radial-gradient(ellipse at 50% 0%, rgba(99,102,241,0.15) 0%, transparent 60%),
            #0a0a0a;

/* Classic diagonal gradient (bold hero sections) */
background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);

/* Mesh gradient (modern, popular 2024-2025) */
background:
  radial-gradient(at 40% 20%, #3b82f6 0px, transparent 50%),
  radial-gradient(at 80% 0%, #8b5cf6 0px, transparent 50%),
  radial-gradient(at 0% 50%, #06b6d4 0px, transparent 50%),
  #0a0a0a;
```

### Card Accent Borders
```css
/* Top border accent on featured/highlighted cards */
.card-featured {
  border-top: 2px solid var(--accent);
}

/* Gradient border (premium feel) */
.card-gradient-border {
  border: 1px solid transparent;
  background: linear-gradient(var(--canvas), var(--canvas)) padding-box,
              linear-gradient(135deg, var(--accent), transparent) border-box;
}
```

---

## MOBILE-SPECIFIC DESIGN RULES

### Navigation
- Logo left, hamburger right
- Hamburger opens a full-screen overlay
- Overlay: dark background, nav items large (48px tall), centered
- Close button top-right
- CTA button at bottom of mobile menu

### Hero on Mobile
- Stack: text first, visual second (never visual above text on mobile)
- CTA button: full width (100%)
- Hero visual: width 100%, no 3D perspective tilt (too complex on small screen)
- Reduce font sizes (see typography scale above)

### Cards on Mobile
- 1-up stack (no columns below 768px)
- Full width with 16px horizontal padding
- Equal visual weight, no "featured" sizing

### CTAs on Mobile
- All primary CTAs: full width
- Min height: 52-56px (generous touch targets)
- Floating bottom CTA bar: optional for high-intent pages
  (fixed bottom bar: "Get Started Free" — appears after hero scrolls away)

### Images on Mobile
- App screenshots: full width, aspect ratio preserved
- Dashboard screenshots: consider showing a cropped/zoomed version (key part only)
  Full desktop dashboard often becomes too small to read on mobile
