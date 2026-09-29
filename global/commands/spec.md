Help me write a spec for: $ARGUMENTS

Do NOT write code or plans. Interview me one question at a time until the goal,
non-goals, acceptance criteria, and constraints are unambiguous. Challenge vague
answers ("fast", "secure", "handles errors") until they are testable.
Point out edge cases and failure modes I haven't mentioned.

Then write docs/specs/<next-number>-<slug>.md:
## Goal            (1-3 sentences, the problem, not the solution)
## Non-goals       (what we are explicitly NOT doing)
## Acceptance criteria  (observable behavior: "given X, when Y, then Z")
## Constraints     (stack, performance, security, compatibility)
## Open questions
## Customer summary   (plain language, no technical terms, send this to the customer)
  - What will change for users, as 3-5 concrete scenarios:
    "Anna pays for an order. Even if the payment confirmation arrives twice,
     she is charged once and gets one confirmation email."
  - What will NOT be included in this version (from Non-goals)
  - Questions we need the customer to answer
