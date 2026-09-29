# Animation Libraries Reference
# DNA Scanner — used in Phase 2F (Animation Catalog)

## How to Use
When scanning JS files in Tier 3, look for these library signatures.
When detected: note the library, describe the animation pattern in plain English,
and include the CDN link in Implementation Guide Document 2.
Do NOT read the library source — only the usage patterns around it.

---

## GSAP (GreenSock Animation Platform)

**Detection signatures:**
- `gsap.to(`, `gsap.from(`, `gsap.fromTo(`, `gsap.timeline(`
- `ScrollTrigger.create(`, `gsap.registerPlugin(ScrollTrigger`
- Import: `from "gsap"` or `from "gsap/ScrollTrigger"`
- CDN: `cdnjs.cloudflare.com/ajax/libs/gsap`

**Common patterns to document:**
- `gsap.from(".hero-title", { opacity:0, y:30, duration:0.8, ease:"power2.out" })`
  → Note: "Hero title fades up 30px over 0.8s with power ease on page load"
- `ScrollTrigger` → "Elements animate on scroll using GSAP ScrollTrigger"
- `gsap.timeline().from(...).from(...)` → "Sequenced animation cascade"

**CDN for Implementation Guide:**
```html
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.5/gsap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.5/ScrollTrigger.min.js"></script>
```

**npm:** `npm install gsap`

---

## Framer Motion

**Detection signatures:**
- `from "framer-motion"` import
- `<motion.div`, `<motion.span`, `<AnimatePresence`
- `animate={{ opacity:1 }}`, `initial={{ opacity:0 }}`, `whileHover={{ scale:1.05 }}`
- `useAnimation()`, `useScroll()`, `useTransform()`

**Common patterns to document:**
- `whileHover={{ scale:1.05 }}` → "Cards scale up 5% on hover (spring physics)"
- `initial/animate` props → "Component mounts with fade-in animation"
- `AnimatePresence` → "Route/modal transitions with exit animations"
- `useScroll + useTransform` → "Parallax scroll effects"

**CDN:** Not available via CDN — React library only.
**npm:** `npm install framer-motion`

**Note in output:** "Framer Motion animations use spring physics by default — feel is
bouncier/more natural than CSS ease. Replicate with `spring` type in Framer Motion config."

---

## AOS (Animate On Scroll)

**Detection signatures:**
- `AOS.init(` in JS
- `data-aos="fade-up"`, `data-aos="fade-in"`, `data-aos-delay="200"` attributes in HTML
- `aos.js` or `aos.min.js` in scripts
- `aos.css` in stylesheets

**Common patterns to document:**
- `data-aos="fade-up"` → "Elements fade up as they enter viewport"
- `data-aos-delay="200"` → "Staggered 200ms delays between elements"
- `AOS.init({ duration: 600, once: true })` → "Animations run once, 600ms duration"

**CDN for Implementation Guide:**
```html
<link rel="stylesheet" href="https://unpkg.com/aos@2.3.1/dist/aos.css" />
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>AOS.init({ duration: 600, once: true });</script>
```

**npm:** `npm install aos`

---

## Anime.js

**Detection signatures:**
- `anime({` function calls
- `anime.timeline(`
- `from "animejs"` import
- `targets:`, `easing: "easeOutExpo"` in animation objects

**Common patterns to document:**
- `anime({ targets: ".el", opacity: [0,1], translateY: [30,0] })`
  → "Elements animate from invisible/30px-low to visible/in-place"
- `anime.timeline()` → "Multi-step sequenced animation"
- `loop: true` → "Continuous looping animation (likely decorative)"

**CDN:**
```html
<script src="https://cdnjs.cloudflare.com/ajax/libs/animejs/3.2.1/anime.min.js"></script>
```

**npm:** `npm install animejs`

---

## Lottie (JSON-based vector animations)

**Detection signatures:**
- `lottie.loadAnimation(`, `lottiePlayer.load(`
- `<lottie-player` custom element in HTML
- `.json` files referenced as animation sources
- `from "lottie-web"` import
- `bodymovin` (older name for Lottie)

**Common patterns to document:**
- `lottie.loadAnimation({ path: "/animations/hero.json" })`
  → "Hero section has a Lottie JSON animation (likely an illustration or icon animation)"
- Note the `.json` file path — user will need to replace with their own Lottie file

**CDN:**
```html
<script src="https://cdnjs.cloudflare.com/ajax/libs/bodymovin/5.12.2/lottie.min.js"></script>
<!-- Or web component: -->
<script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
```

**npm:** `npm install lottie-web`

**Asset note:** Lottie `.json` files are design assets — add them to the assets_to_replace
list with note: "Lottie animation JSON — create your own at lottiefiles.com"

---

## Three.js (3D / WebGL)

**Detection signatures:**
- `from "three"` import
- `new THREE.Scene()`, `new THREE.WebGLRenderer()`
- `<canvas>` element (may be Three.js canvas)
- `three.min.js` in scripts

**Common patterns to document:**
- 3D background animation → "Site uses Three.js for 3D WebGL background — particle system
  or 3D model. Complex to replicate — consider CSS gradient alternative."
- Particle system → "Animated particle field behind hero"

**CDN:**
```html
<script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
```

**Note in output:** "Three.js animations are complex — document the visual effect in plain
English and suggest a CSS/canvas alternative for the user if 3D is not their priority."

---

## ScrollReveal

**Detection signatures:**
- `ScrollReveal().reveal(`, `sr.reveal(`
- `from "scrollreveal"` import
- `scrollreveal.min.js` in scripts

**Pattern:** Similar to AOS — elements animate on viewport entry.

**CDN:**
```html
<script src="https://unpkg.com/scrollreveal"></script>
```

---

## Swiper.js (Carousels / Sliders)

**Detection signatures:**
- `new Swiper(`, `Swiper.` usage
- `swiper.min.js`, `swiper-bundle.min.js` in scripts
- `swiper.min.css` in stylesheets
- Class names: `.swiper`, `.swiper-slide`, `.swiper-pagination`

**What to document:**
- Carousel type: horizontal scroll / fade / coverflow
- Autoplay: `autoplay: { delay: 3000 }` → "Auto-advances every 3s"
- Loop: true/false
- Navigation: arrows / dots / both

**CDN:**
```html
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
```

---

## Pure CSS Animations (No Library)

When no library is detected but animations exist:

**CSS Keyframes — document as:**
```yaml
- name: "[inferred name from class or element]"
  type: "CSS keyframe"
  trigger: "[page load / hover / focus / class toggle]"
  keyframe: "[description of from→to states]"
  duration: "[value from animation property]"
  easing: "[value from animation-timing-function]"
  library: null
```

**CSS Transitions — document as:**
```yaml
- name: "[element] [state] transition"
  type: "CSS transition"
  trigger: "[hover / focus / active]"
  properties: "[list of properties that transition]"
  duration: "[transition-duration value]"
  easing: "[transition-timing-function value]"
  library: null
```

**Common easing plain-English translations:**
- `ease` → "standard ease, slight acceleration then deceleration"
- `ease-out` → "starts fast, decelerates — feels responsive"
- `ease-in-out` → "smooth start and end — polished feel"
- `cubic-bezier(0.16, 1, 0.3, 1)` → "expo ease-out — snappy start, gentle land"
- `cubic-bezier(0.4, 0, 0.2, 1)` → "Material Design standard — smooth and precise"
- `spring(...)` → "physics-based spring — natural bounce"

---

## IntersectionObserver (Custom Scroll Animation)

**Detection signatures:**
- `new IntersectionObserver(` in JS
- `observer.observe(`, `entry.isIntersecting`

**What to document:**
- Which elements are observed (look at `querySelectorAll` calls near the observer)
- What happens on intersection (class toggle? inline style change? counter animation?)
- Threshold value (`0.1` = triggers when 10% visible, `1.0` = fully visible)

**Plain-English pattern note:**
"Custom scroll-triggered animations using browser IntersectionObserver — no library needed,
just vanilla JS. Replicate by adding/removing a CSS class on viewport entry."

---

## requestAnimationFrame (Canvas / Custom Loops)

**Detection signatures:**
- `requestAnimationFrame(`, `rAF(` in JS
- Usually accompanies `<canvas>` elements
- Custom particle systems or procedural animations

**What to document:**
- Visual effect in plain English
- Canvas dimensions
- Note: "Custom canvas animation — complex to replicate exactly. Consider a Lottie or
  CSS alternative for equivalent visual effect."
